DGPMAPI5 ;RGI/VSL - CHECK-OUT PATIENT API; 8/26/13
 ;;5.3;Registration;**260005**;
CHKDT(RETURN,PARAM,TYPE,MAS,ADM) ; Check lodger check-out date
 N %,TXT,TT,DIS,LMVT
 K RETURN S RETURN=0 ; patient
 I $G(PARAM("ADMIFN"))="" S TXT(1)="PARAM(""ADMIFN"")" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVT^DGPMDAL1(.ADM,+$G(PARAM("ADMIFN")),".01;.02;.03;.17")
 I ADM=0 S TXT(1)=$$EZBLD^DIALOG(4070000.014),RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND",.TXT) Q 0
 S %=$$CHKDT^DGPMAPI9(.RETURN,$G(PARAM("DATE"))) Q:'RETURN 0
 S RETURN=0
 I ADM(.17,"I")>0 D  Q 0
 . D GETMVT^DGPMDAL1(.DIS,+ADM(.17,"I"))
 . S TXT(1)=DIS(.01,"E")
 . D ERRX^DGPMAPIE(.RETURN,"DCHPADON",.TXT)
 I $$TIMEUSD^DGPMDAL2(+ADM(.03,"I"),+PARAM("DATE")) D ERRX^DGPMAPIE(.RETURN,"TIMEUSD") Q 0
 K TXT S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.014))
 I +PARAM("DATE")<ADM(.01,"I") D ERRX^DGPMAPIE(.RETURN,"TRANBADM",.TXT) Q 0
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+ADM(.03,"I"))
 I +PARAM("DATE")<LMVT("DATE") D ERRX^DGPMAPIE(.RETURN,"DCHNBLM",.TXT) Q 0
 S RETURN=1
 Q 1
CHKADD(RETURN,PARAM,TYPE,MAS,ADM) ; Check discharge patient
 N %,TXT,TT,ADM,DISP,FOUND,DIS,I
 K RETURN S RETURN=0 ; patient
 S %=$$CHKDT(.RETURN,.PARAM,.TYPE,.MAS,.ADM) Q:'RETURN 0
 ; type of movement
 S PARAM("PATIENT")=+ADM(.03,"I")
 S:$G(PARAM("TYPE")) %=$$CHKCOTYP(.RETURN,$G(PARAM("TYPE")),+ADM(.03,"I"),+PARAM("DATE")) Q:'RETURN 0
 S RETURN=0,TXT(1)="PARAM(""LDGDISP"")"
 I $G(PARAM("LDGDISP"))="" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 S DISP=$$LOW^XLFSTR($P(PARAM("LDGDISP"),U))
 S %=$$LSTLDIS^DGPMAPI7(.DIS),FOUND=0
 F I=0:0 S I=$O(DIS(I)) Q:'I!FOUND  I $P(DIS(I),U)=DISP S FOUND=1
 I 'FOUND D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 S RETURN=1
 Q 1
CHKCOTYP(RETURN,TYPE,DFN,DATE) ; Check lodger check-out type
 N %,TMP,TXT,ADTYP K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI9(.RETURN,.TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTCOTYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN,+DATE)
 S TXT(1)=TMP(.01,"E"),TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.015))
 I $G(TMP(.04,"I"))'=1 D ERRX^DGPMAPIE(.RETURN,"MVTTINAC",.TXT) Q 0
 I +$G(ADTYP(0))=0 D ERRX^DGPMAPIE(.RETURN,"ADMINVAT",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
LDGOUT(RETURN,PARAM) ; Lodger check-out
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new check-out IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("ADMIFN") [Required,Numeric] Check-in associated IEN (pointer to the Patient Movement file #405)
 ;      PARAM("DATE") [Required,DateTime] Check-out date
 ;      PARAM("TYPE") [Required,Numeric] Check-out type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("LDGDISP") [Required,String] One of the following options: "a", "d".
 ;                                         -"a" means that the patient was admitted, "d" dismissed.
 ;Output:
 ;  1=Success,0=Failure
 N %,DFN,TYPE
 K RETURN S RETURN=0
 S %=$$CHKADD(.RETURN,.PARAM,.TYPE) Q:'RETURN 0
 S DFN=+PARAM("PATIENT")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$ADD(.RETURN,.PARAM,.TYPE,1)
 S %=$$UPDPAT^DGPMAPI9(,.PARAM,DFN,+RETURN,1)
 D EVT(DFN,+RETURN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
ADD(RETURN,PARAM,TYPE,QUIET) ; Lodger check-out
 N %,DFN,IFN,TXT,DGQUIET
 S:$G(QUIET) DGQUIET=1
 S DFN=+PARAM("PATIENT")
 D INITEVT^DGPMDAL1
 D SETCIEVT^DGPMDAL1(+PARAM("ADMIFN"),"P")
 S IFN=$$ADDCO(.RETURN,.PARAM,DFN,.TYPE)
 D SETCOEVT^DGPMDAL1(IFN,"A")
 D SETCIEVT^DGPMDAL1(+PARAM("ADMIFN"),"A")
 Q 1
 ;
EVT(DFN,IFN,MODE) ; Lodger check-out event
 D MVTEVT^DGPMAPI9(DFN,5,IFN,.MODE)
 Q
ADDCO(RETURN,PARAM,DFN,TYPE) ;
 N MVT,ADMIFN,DGDT,PM,IFN
 D GETMVT^DGPMDAL1(.MVT,+PARAM("ADMIFN"),".01;.03;.06;.16")
 S ADMIFN=+PARAM("ADMIFN")
 S DGDT=+PARAM("DATE")
 S PM(.01)=DGDT ; discharge date
 S PM(.02)=5  ; transaction
 S PM(.03)=DFN  ; patient
 S PM(.14)=ADMIFN
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM)
 S IFN=+RETURN
 S PM(.04)=$S(+$G(PARAM("TYPE")):+$G(PARAM("TYPE")),1:45)  ; type of movement
 S PM(30.03)=$$LOW^XLFSTR($P($G(PARAM("LDGDISP")),U))  ; disposition
 S PM(100)=DUZ,PM(101)=$$NOW^XLFDT()
 S PM(102)=DUZ,PM(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM,IFN)
 Q IFN
 ;
CHKUDT(RETURN,COFN,DGDT,OLD,NEW) ; Check lodger date update
 N %,DATE,NMVT,ADM,LMVT,PARAM,TXT K RETURN S RETURN=1
 ; check-out date
 D GETMVT^DGPMDAL1(.OLD,+$G(COFN))
 D GETMVT^DGPMDAL1(.ADM,+$G(OLD(.14,"I")),".01;.02;.03;")
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND") Q 0
 I $G(DGDT),+$G(OLD(.01,"I"))'=+$G(DGDT) D  Q:'RETURN 0
 . S %=$$CHKDT^DGPMAPI9(.RETURN,+DGDT) Q:'RETURN
 . S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD(.03,"I"))
 . K TXT S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.014))
 . I +DGDT<ADM(.01,"I") S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TRANBADM",.TXT) Q
 . ;not before last movement
 . S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.01_LMVT("TYPE")))
 . I $D(LMVT),LMVT("MFN")'=+COFN,+LMVT("DATE")<DGDT D  Q
 . . S TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U))
 . . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT) Q
 . I $$TIMEUSD^DGPMDAL2(+OLD(.03,"I"),+DGDT) D  Q
 . . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 . S NEW("DATE")=+DGDT
 S RETURN=1
 Q 1
 ;
CHKUPD(RETURN,PARAM,COFN,OLD,NEW) ; Check lodger update
 N %,DATE,DISP,DIS,FOUND,I,TXT,TYPE K RETURN S RETURN=1
 ; transfer date
 S %=$$CHKUDT(.RETURN,COFN,$G(PARAM("DATE")),.OLD,.NEW) Q:'RETURN 0
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD(.01,"I"))
 ; type of movement
 I $G(PARAM("TYPE"))'="",+$G(OLD(.04,"I"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKCOTYP(.RETURN,+$G(PARAM("TYPE")),+OLD(.03,"I"),+PARAM("DATE")) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 S TYPE=$S($D(NEW("TYPE")):+NEW("TYPE"),1:+OLD(.04,"I"))
 ; disposition
 S DISP=$$LOW^XLFSTR($P($G(PARAM("LDGDISP")),U))
 I $G(DISP)'="",$G(OLD(30.03,"I"))'=DISP  D  Q:'FOUND 0
 . S RETURN=0,TXT(1)="PARAM(""LDGDISP"")"
 . S %=$$LSTLDIS^DGPMAPI7(.DIS),FOUND=0
 . F I=0:0 S I=$O(DIS(I)) Q:'I!FOUND  I $P(DIS(I),U)=DISP S FOUND=1
 . I 'FOUND D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q
 . S NEW("LDGDISP")=DISP
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDLDGOU(RETURN,PARAM,COFN) ; Update lodger check-out
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("DATE") [Optional,DateTime] Check-out date
 ;      PARAM("TYPE") [Optional,Numeric] Check-out type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("LDGDISP") [Optional,String] One of the following options: "a", "d".
 ;                                         -"a" means that the patient was admitted, "d" dismissed.
 ;   COFN [Required,Numeric] Check-out IEN to update (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,OLD,NEW,DFN
 K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.COFN,.OLD,.NEW)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S DFN=OLD(.03,"I")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$UPD(.RETURN,.PARAM,COFN,.OLD,.NEW,1)
 S %=$$UPDPAT^DGPMAPI9(,.PARAM,DFN,+COFN,1)
 D EVT(DFN,+COFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
UPD(RETURN,PARAM,COFN,OLD,NEW,QUIET) ; Update lodger check-out
 N DIS,DGQUIET
 S:$G(QUIET) DGQUIET=1 K RETURN S RETURN=0
 D SETCOEVT^DGPMDAL1(+COFN,"P")
 S:$D(NEW("DATE")) DIS(.01)=+NEW("DATE")
 S:$D(NEW("TYPE")) DIS(.04)=+NEW("TYPE")
 S:$D(NEW("LDGDISP")) DIS(30.03)=NEW("LDGDISP")
 D UPDMVT^DGPMDAL1(,.DIS,+COFN)
 D SETCOEVT^DGPMDAL1(+COFN,"A")
 S RETURN=1
 Q 1
 ;
CANDEL(RETURN,COFN,OLD) ; Can delete lodger check-out
 N LMVT,FLDS,%,TXT
 K RETURN S RETURN=0,FLDS=".01;.02;.03;.04;.14;.15;.16;.17;.18;.21"
 D GETMVT^DGPMDAL1(.OLD,COFN,FLDS)
 S TXT(1)=$$EZBLD^DIALOG(4070000.015)
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND",.TXT) Q 0
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD(.03,"I"))
 I $G(LMVT("MFN"))'=+COFN D  Q 0
 . S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.015))
 . S TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.014))
 . D ERRX^DGPMAPIE(.RETURN,$S(LMVT("TYPE")<4:"DCHCDOLA",1:"DCHDODLM"),.TXT)
 S RETURN=1
 Q 1
 ;
DELLDGOU(RETURN,COFN) ; Delete lodger check-out
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   COFN [Required,Numeric] Check-out IEN to delete (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,ADM,DFN
 K RETURN S RETURN=0
 S %=$$CANDEL(.RETURN,+COFN,.ADM) Q:'RETURN 0
 S DFN=ADM(.03,"I")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$DEL(.RETURN,+COFN,.ADM,1)
 S %=$$UPDPAT^DGPMAPI9(,,DFN,ADM(.14,"I"),1)
 D EVT(DFN,+COFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
DEL(RETURN,COFN,OLD,QUIET) ; Delete lodger check-out
 N %,DA,DGQUIET
 S:$G(QUIET) DGQUIET=1
 K RETURN S RETURN=0,DA=+COFN
 D INITEVT^DGPMDAL1
 D SETCIEVT^DGPMDAL1(OLD(.14,"I"),"P")
 D SETCOEVT^DGPMDAL1(+COFN,"P")
 D DELMVT^DGPMDAL1(+COFN)
 D SETCIEVT^DGPMDAL1(OLD(.14,"I"),"A")
 D SETCOEVT^DGPMDAL1(+COFN,"A")
 S RETURN=1
 Q 1
 ;
