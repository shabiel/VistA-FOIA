DGPMAPI3 ;RGI/VSL - DISCHARGE PATIENT API; 5/24/13
 ;;5.3;Registration;**260005**;
CHKDT(RETURN,PARAM,TYPE,MAS,ADM) ; Check discharge date
 N %,TXT,TT,DIS,LMVT
 K RETURN S RETURN=0 ; patient
 D GETMVT^DGPMDAL1(.ADM,+$G(PARAM("ADMIFN")),".02;.03;")
 D GETMVTT^DGPMDAL2(.TT,+$G(PARAM("TYPE")))
 S TYPE=$G(TT(.03,"I"))
 D GETMASMT^DGPMDAL2(.MAS,TYPE)
 I '$G(PARAM("ADMIFN")) S TXT(1)="PARAM('ADMIFN')" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVT^DGPMDAL1(.ADM,+$G(PARAM("ADMIFN")))
 I ADM=0 S TXT(1)="PARAM('ADMIFN')" D ERRX^DGPMAPIE(.RETURN,"ADMNFND",.TXT) Q 0
 I ADM(.17,"I")>0 D  Q 0
 . D GETMVT^DGPMDAL1(.DIS,+ADM(.17,"I"))
 . S TXT(1)=DIS(.01,"E")
 . D ERRX^DGPMAPIE(.RETURN,"DCHPADON",.TXT)
 S %=$$CHKDT^DGPMAPI8(.RETURN,$G(PARAM("DATE"))) Q:'RETURN 0
 S RETURN=0
 I $$TIMEUSD^DGPMDAL2(+ADM(.03,"I"),+PARAM("DATE")) D ERRX^DGPMAPIE(.RETURN,"TIMEUSD") Q 0
 K TXT S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.011))
 I +PARAM("DATE")<ADM(.01,"I") D ERRX^DGPMAPIE(.RETURN,"TRANBADM",.TXT) Q 0
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+ADM(.03,"I"))
 I +PARAM("DATE")<LMVT("DATE") D ERRX^DGPMAPIE(.RETURN,"DCHNBLM",.TXT) Q 0
 S RETURN=1
 Q 1
CHKADD(RETURN,PARAM,TYPE,MAS,ADM) ; Check discharge patient
 N %,TXT,TT,ADM
 K RETURN S RETURN=0 ; patient
 S %=$$CHKDT(.RETURN,.PARAM,.TYPE,.MAS,.ADM) Q:'RETURN 0
 I $G(PARAM("FCTY"))'="",'$G(PARAM("FCTY")) S RETURN=0,TXT(1)="PARAM('FCTY')" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 ; type of movement
 S PARAM("PATIENT")=+ADM(.03,"I")
 S %=$$CHKDTYP(.RETURN,$G(PARAM("TYPE")),+ADM(.03,"I"),+PARAM("DATE")) Q:'RETURN 0
 D GETMVT^DGPMDAL1(.ADM,+$G(PARAM("ADMIFN")),".02;.03;")
 D GETMVTT^DGPMDAL2(.TT,+$G(PARAM("TYPE")))
 S TYPE=$G(TT(.03,"I"))
 I +TYPE=46,'$G(PARAM("FCTY")) S RETURN=0,TXT(1)="PARAM('FCTY')" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 I +TYPE=10 S %=$$CHKFCTY^DGPMAPI6(.RETURN,$G(PARAM("FCTY"))) Q:'RETURN 0
 I +TYPE=46 I $$GETAMT^DGPMDAL3(45)="" S TXT(1)=MAS(.01,"E") D ERRX^DGPMAPIE(.RETURN,"DSCNMVTD",.TXT) Q 0
 S RETURN=1
 Q 1
CHKDTYP(RETURN,TYPE,DFN,DATE) ; Check discharge type
 N %,TMP,TXT,ADTYP K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI8(.RETURN,.TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTDTYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN,+DATE)
 S TXT(1)=TMP(.01,"E"),TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.013))
 I $G(TMP(.04,"I"))'=1 D ERRX^DGPMAPIE(.RETURN,"MVTTINAC",.TXT) Q 0
 I +$G(ADTYP(0))=0 D ERRX^DGPMAPIE(.RETURN,"ADMINVAT",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
DISCH(RETURN,PARAM) ; Discharge patient
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new discharge IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("ADMIFN") [Required,Numeric] Admission associated IEN (pointer to file 405)
 ;      PARAM("DATE") [Required,DateTime] Discharge date
 ;      PARAM("TYPE") [Required,Numeric] Discharge type IEN (pointer to file 405.1)
 ;      The following parameter are used only with CONTINUED ASIH (OTHER FACILITY) movement type or
 ;        if movement type have the field "ask specialty at movement" set to 1:
 ;        PARAM("FCTY")	[Required,Numeric] Transfer facility (pointer to file 4)
 ;Output:
 ;  1=Success,0=Failure
 N %,MAS,TYPE,ADM,DFN,LMVT
 K RETURN S RETURN=0
 S %=$$CHKADD(.RETURN,.PARAM,.TYPE,.MAS,.ADM) Q:'RETURN 0
 S DFN=+PARAM("PATIENT")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$ADD(.RETURN,.PARAM,.TYPE,.MAS,.LMVT,1)
 S %=$$UPDPAT^DGPMAPI7(,.PARAM,DFN,,1)
 D EVT(DFN,+RETURN,1,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
ADD(RETURN,PARAM,TYPE,MAS,LMVT,QUIET) ; Discharge patient
 N %,DFN,IFN,MAS,TFCTY,TT,TXT,DGQUIET
 S:$G(QUIET) DGQUIET=1
 S:'$D(LMVT) %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"),+PARAM("DATE"))
 I '$D(TYPE) D GETMVTT^DGPMDAL2(.TT,+PARAM("TYPE")) S TYPE=TT(.03,"I")
 D:'$D(MAS) GETMASMT^DGPMDAL2(.MAS,TYPE)
 S DFN=+PARAM("PATIENT")
 D INITEVT^DGPMDAL1
 D SETAEVT^DGPMDAL1(+PARAM("ADMIFN"),,"A")
 I +TYPE=46 S TFCTY=+PARAM("FCTY") K PARAM("FCTY")
 I +TYPE=41 S %=$$DELASH(.PARAM,.MAS,TYPE)
 S IFN=$$ADDDIS(.RETURN,.PARAM,DFN,TYPE)
 I +TYPE=46!(+TYPE=41) S PARAM("FCTY")=$G(TFCTY),%=$$ASIH(.PARAM,.MAS,TYPE)
 D SETDEVT^DGPMDAL1(IFN,"A")
 Q 1
 ;
EVT(DFN,IFN,MODE,QUE) ;
 N DGPMDA
 S DGPMDA=IFN D DIS^DGPMVODS
 D MVTEVT^DGPMAPI7(DFN,3,IFN,.MODE,.QUE)
 Q
DELASH(PARAM,MAS,TYPE) ; Delete ASIH discharge
 N %,ASH,MVT,ADM,FLD,ADM1,PTF
 S FLD=".01;.03;.06;.14;.15;.16;.17;.21;"
 D GETMVT^DGPMDAL1(.ASH,+PARAM("ADMIFN"),FLD)
 D GETMVT^DGPMDAL1(.MVT,ASH(.21,"I"),FLD)
 D GETMVT^DGPMDAL1(.ADM,MVT(.14,"I"),FLD)
 I +TYPE=41 D
 . D DELMVT^DGPMDAL1(ADM(.17,"I"))
 S ADM1(.17)=""
 D UPDMVT^DGPMDAL1(,.ADM1,MVT(.14,"I"))
 S PTF(70)="@",PTF(71)="@",PTF(72)="@"
 D UPDPTF^DGPMDAL1(,.PTF,ADM(.16,"I"))
 Q %
 ;
ASIH(PARAM,MAS,TYPE) ; ASIH discharge
 N %,ASH,MVT,TRMAS,FLD,TRA
 S FLD=".01;.03;.06;.14;.15;.16;.17;.21;"
 D GETMVT^DGPMDAL1(.ASH,+PARAM("ADMIFN"),FLD)
 D GETMVT^DGPMDAL1(.MVT,ASH(.21,"I"),FLD)
 S PARAM("ADMIFN")=MVT(.14,"I")
 S TRMAS=$S(+TYPE=46:45,+TYPE=41:14,1:0)
 S PARAM("TYPE")=$$GETAMT^DGPMDAL3(TRMAS)
 S PARAM("ASHSEQ")=2
 S %=$$ADDTRA^DGPMAPI2(.TRA,.PARAM)
 Q %
 ;
ADDDIS(RETURN,PARAM,DFN,TYPE) ;
 N MVT,ADMIFN,DGDT,PM,IFNP,PAT,PTF,RPTF,IFN,MAS
 D GETMVT^DGPMDAL1(.MVT,+PARAM("ADMIFN"),".01;.03;.06;.16")
 S ADMIFN=+PARAM("ADMIFN")
 S DGDT=+PARAM("DATE")
 S PM(.01)=DGDT ; discharge date
 S PM(.02)=3  ; transaction
 S PM(.03)=DFN  ; patient
 S PM(.04)=+PARAM("TYPE")  ; type of movement
 S PM(.14)=ADMIFN
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM)
 S IFN=+RETURN
 S PM(.05)=$S($G(PARAM("FCTY")):+$G(PARAM("FCTY")),1:"")  ; transfer facility
 S:+$G(TYPE)=46!(+$G(TYPE)=41) PM(.22)=1  ; ASIH sequence
 S PM(100)=DUZ,PM(101)=$$NOW^XLFDT()
 S PM(102)=DUZ,PM(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM,IFN)
 S IFNP=MVT(.16,"I")
 S PTF(70)=DGDT
 D GETMVT^DGPMDAL1(.MVT,IFN,".01;.18")
 D GETMASMT^DGPMDAL2(.MAS,MVT(.18,"I"),".01;.08")
 S PTF(72)=MAS(.08,"I")
 D UPDPTF^DGPMDAL1(.RPTF,.PTF,IFNP)
 S PAT(401.3)="@"
 S PAT(401.4)="@"
 Q IFN
 ;
CHKUDT(RETURN,DMFN,DGDT,OLD,NEW) ; Check discharge date
 N %,NMVT
 ; transfer date
 S:'$D(OLD) %=$$GETMVT^DGPMAPI8(.OLD,+$G(DMFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"DCHNFND") Q 0
 I $G(DGDT)'="",+$G(OLD("DATE"))'=+$G(DGDT) D  Q:'RETURN 0
 . D GETAPRD^DGPMDAL1(.NMVT,+OLD("PATIENT"),+DGDT)
 . S %=$$CHKDT^DGPMAPI8(.RETURN,+DGDT) Q:'RETURN
 . ;not before last movement
 . I $D(NMVT),NMVT("ID")'=+DMFN S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"DCHNBLM") Q
 . I $$TIMEUSD^DGPMDAL2(+OLD("PATIENT"),+DGDT) D  Q
 . . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 . S NEW("DATE")=+DGDT
 Q 1
 ;
CHKUPD(RETURN,PARAM,DMFN,OLD,NEW) ; Check discharge parameters
 N %,TXT,DATE,NMVT K RETURN,OLD,NEW S RETURN=1
 S %=$$GETMVT^DGPMAPI8(.OLD,+$G(DMFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"DCHNFND") Q 0
 S %=$$CHKUDT(.RETURN,DMFN,$G(PARAM("DATE")),.OLD,.NEW) Q:'RETURN 0
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD("DATE"))
 ; type of movement
 I $G(PARAM("TYPE"))'="",+$G(OLD("TYPE"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKDTYP(.RETURN,+$G(PARAM("TYPE")),+OLD("PATIENT"),OLD("DATE")) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDDSCH(RETURN,PARAM,DMFN) ; Update discharge
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Optional,Array] Array passed by reference that holds the new data.
 ;      PARAM("DATE") [Optional,DateTime] Discharge date
 ;      PARAM("TYPE") [Optional,Numeric] Discharge type IEN (pointer to file 405.1)
 ;   DMFN [Required,Numeric] Discharge IEN to update (pointer to file 405)
 ;Output:
 ;  1=Success,0=Failure
 N %,OLD,NEW,DFN
 K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.DMFN,.OLD,.NEW)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S DFN=$P(OLD("PATIENT"),U)
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$UPD(.RETURN,.PARAM,DMFN,.OLD,.NEW,1)
 S %=$$UPDPAT^DGPMAPI7(,.PARAM,DFN,,1)
 D EVT(DFN,+DMFN,1,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
UPD(RETURN,PARAM,DMFN,OLD,NEW,QUIET) ; Update discharge
 N DIS,DGQUIET
 S:$G(QUIET) DGQUIET=1
 K RETURN S RETURN=0
 D SETDEVT^DGPMDAL1(+DMFN,"P")
 S:$D(NEW("DATE")) DIS(.01)=+NEW("DATE")
 S:$D(NEW("TYPE")) DIS(.04)=+NEW("TYPE")
 S:$D(NEW("FCTY")) DIS(.05)=+NEW("FCTY")
 D UPDMVT^DGPMDAL1(,.DIS,+DMFN)
 D SETDEVT^DGPMDAL1(+DMFN,"A")
 S RETURN=1
 Q 1
 ;
CANDEL(RETURN,DMFN,DCH) ; Can delete discharge?
 N LMVT,PMVT,ASHADM,FLDS,ADM,%
 K RETURN S RETURN=0,FLDS=".01;.02;.03;.04;.14;.15;.16;.17;.18;.21"
 D GETMVT^DGPMDAL1(.DCH,DMFN,FLDS)
 I DCH=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"DCHNFND") Q 0
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+DCH(.03,"I"))
 I DCH(.18,"I")=42!(DCH(.18,"I")=46) D ERRX^DGPMAPIE(.RETURN,"DCHCDWAH") Q 0
 I $G(LMVT("MFN"))'=+DMFN D ERRX^DGPMAPIE(.RETURN,$S(LMVT("TYPE")<4:"DCHCDOLA",1:"DCHDODLM")) Q 0
 D GETMVT^DGPMDAL1(.ADM,DCH(.14,"I"),FLDS)
 I ADM(.21,"I"),("^41^46^"[("^"_+DCH(.18,"I")_"^")) D ERRX^DGPMAPIE(.RETURN,"DCHDTCNH") Q 0
 I DCH(.18,"I")=47,("^13^44^"[("^"_ADM(.18,"I")_"^")) D  Q:'RETURN 0
 . D GETPMVT^DGPMDAL3(.PMVT,DCH(.03,"I"),DCH(.14,"I"),,DMFN,FLDS)
 . D GETMVT^DGPMDAL1(.ASHADM,$G(PMVT(.15,"I")),FLDS)
 . I $D(ASHADM),$G(ASHADM(.17,"I")) Q
 . S RETURN=1
 S RETURN=1
 Q 1
 ;
DELDSCH(RETURN,DMFN) ; Delete discharge
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   DMFN [Required,Numeric] Discharge IEN to delete (pointer to file 405)
 ;Output:
 ;  1=Success,0=Failure
 N %,DCH,DFN
 K RETURN S RETURN=0
 S %=$$CANDEL(.RETURN,+DMFN,.DCH) Q:'RETURN 0
 S DFN=DCH(.03,"I")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 D INITEVT^DGPMDAL1
 S %=$$DEL(.RETURN,+DMFN,.DCH,1)
 S %=$$UPDPAT^DGPMAPI7(,,DFN,,1)
 D EVT(DFN,+DMFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
DEL(RETURN,DMFN,DCH,QUIET) ; Delete discharge
 N %,DIS,DA,DGQUIET
 S:$G(QUIET) DGQUIET=1
 K RETURN S RETURN=0,DA=+DMFN
 D GETMVT^DGPMDAL1(.DIS,+DMFN,".03;.14;.16;.17;.21")
 D SETAEVT^DGPMDAL1(DIS(.14,"I"),,"P")
 D SETDEVT^DGPMDAL1(+DMFN,"P")
 D DELMVT^DGPMDAL1(+DMFN)
 D SETAEVT^DGPMDAL1(DIS(.14,"I"),,"A")
 D SETDEVT^DGPMDAL1(+DMFN,"A")
 S RETURN=1
 Q 1
 ;
