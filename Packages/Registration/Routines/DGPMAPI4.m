DGPMAPI4 ;RGI/VSL - CHECK IN PATIENT API; 8/26/13
 ;;5.3;Registration;**260005**;
LDGIN(RETURN,PARAM) ; Check-in patient
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new check-in IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("PATIENT") [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;      PARAM("DATE") [Required,DateTime] Check-in date
 ;      PARAM("TYPE") [Required,Numeric] Check-in type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("LDGRSN") [Required,Numeric] Reason for check-in IEN (pointer to the Lodging Reason file #406.41)
 ;      PARAM("LDGCOMM") [Optional,String] Additional check-in comment (3-30 chars)
 ;      The following parameters are used only with CHECK-IN LODGER movement type:
 ;        PARAM("WARD") [Required,Numeric] Ward location IEN (pointer to the Ward Location file #42)
 ;        PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to the Room-bed file #405.4)
 ;      The following parameter are used only with CHECK-IN LODGER (OTHER FACILITY) movement type:
 ;        PARAM("FCTY")	[Required,Numeric] Transfer facility (pointer to the Institution file #4)
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
ADD(RETURN,PARAM,TYPE,QUIET) ; Add check-in lodger
 N DFN,PM1,IFN1,DGQUIET
 S:$G(QUIET) DGQUIET=1
 D INITEVT^DGPMDAL1
 D:'$D(TYPE) GETMVTT^DGPMDAL2(.TYPE,+PARAM("TYPE"))
 S DFN=+PARAM("PATIENT")
 S PM1(.01)=+PARAM("DATE") ; admission date
 S PM1(.02)=4  ; transaction
 S PM1(.03)=DFN  ; patient
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM1)
 S IFN1=+RETURN
 S PM1(.04)=+PARAM("TYPE")  ; type of movement
 I TYPE(.03,"I")=5 D
 . S PM1(.06)=+PARAM("WARD")  ; ward
 . S PM1(.07)=$S(+$G(PARAM("ROOMBED"))>0:+PARAM("ROOMBED"),1:"")  ; roombed
 I TYPE(.03,"I")=6 D
 . S PM1(.05)=+$G(PARAM("FCTY"))  ; Transfer facility
 S PM1(30.01)=+PARAM("LDGRSN")  ; lodger reason
 S PM1(30.02)=$G(PARAM("LDGCOMM"))  ; lodger comments
 S PM1(100)=DUZ,PM1(101)=$$NOW^XLFDT()
 S PM1(102)=DUZ,PM1(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 D SETCIEVT^DGPMDAL1(+RETURN,"A")
 Q IFN1
 ;
EVT(DFN,AFN,MODE) ; Check-in event
 N DA S DA=+AFN
 D RESET^DGPMDDLD
 D MVTEVT^DGPMAPI9(+DFN,4,+AFN,.MODE)
 Q
CANDEL(RETURN,AFN,ADM) ; 
 N % S RETURN=1
 S %=$$GETMVT^DGPMAPI8(.ADM,+AFN)
 I ADM=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND") Q 0
 Q 1
 ;
DELLDGIN(RETURN,AFN) ; Delete lodger check-in
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   AFN [Required,Numeric] Check-in IEN to delete (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,ADM,DFN
 K RETURN S RETURN=0
 S %=$$CANDEL(.RETURN,+AFN,.ADM) Q:'RETURN 0
 S DFN=ADM("PATIENT")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$DEL(.RETURN,+AFN,.ADM,1)
 S %=$$UPDPAT^DGPMAPI9(,,DFN,+AFN,1)
 D EVT(+DFN,+AFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
DEL(RETURN,AFN,ADM,QUIET) ; Delete lodger check-in
 N %,IN,MVTS,DGQUIET
 S:$G(QUIET) DGQUIET=1
 K RETURN S RETURN=0
 D INITEVT^DGPMDAL1
 D SETDLEVT^DGPMDAL1(+AFN)
 D LSTCA^DGPMDAL1(.MVTS,+AFN)
 S IN=0
 F  S IN=$O(MVTS(IN)) Q:IN=""  D
 . D:IN'=+AFN DELMVT^DGPMDAL1(IN)
 D DELMVT^DGPMDAL1(+AFN)
 S RETURN=1
 Q 1
 ;
CHKDT(RETURN,PARAM) ; Check check-in date
 N TXT,LMVT,%
 ; check-in date
 K RETURN S RETURN=1
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(PARAM("PATIENT"))) Q:'RETURN 0
 S %=$$CHKDT^DGPMAPI9(.RETURN,$G(PARAM("DATE"))) Q:'RETURN 0
 I $$TIMEUSD^DGPMDAL2(+PARAM("PATIENT"),+PARAM("DATE")) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 I "^1^2^6^7^"[("^"_$G(LMVT("TYPE"))_"^") S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"LDGPINP")
 I +$G(LMVT("TYPE"))=4 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"LDGPALD")
 I +$G(LMVT("MFN"))>0,+LMVT("DATE")>+PARAM("DATE") D  Q 0
  . S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG("4070000.00"_LMVT("TYPE"))),RETURN=0
  . S TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 Q 1
 ;
CHKADD(RETURN,PARAM,TYPE) ; Check check-in parameters
 N %,ASH
 K RETURN S RETURN=1 ; patient
 S %=$$CHKDT(.RETURN,.PARAM) Q:'RETURN 0
 ; type of movement
 S:'$G(ASH) %=$$CHKCITYP^DGPMAPI4(.RETURN,$G(PARAM("TYPE")),+PARAM("PATIENT"),+PARAM("DATE")) Q:'RETURN 0
 D GETMVTT^DGPMDAL2(.TYPE,+PARAM("TYPE"))
 ; short diagnosis
 I $G(PARAM("LDGCOMM"))'="",$L($G(PARAM("LDGCOMM")))<3!($L($G(PARAM("LDGCOMM")))>30) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV") Q 0
 ; ward
 S:TYPE(.03,"I")=5 %=$$CHKWARD^DGPMAPI9(.RETURN,$G(PARAM("WARD")),+PARAM("DATE")) Q:'RETURN 0
 ; roombed
 I TYPE(.03,"I")=5,$G(PARAM("ROOMBED"))'="",$G(PARAM("ROOMBED"))'="^" D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI9(.RETURN,PARAM("ROOMBED"),+PARAM("WARD"),+PARAM("PATIENT"),+PARAM("DATE"))
 I TYPE(.03,"I")=6 S %=$$CHKFCTY^DGPMAPI6(.RETURN,$G(PARAM("FCTY"))) Q:'RETURN 0
 ; reason for lodging
 S %=$$CHKCIRSN^DGPMAPI4(.RETURN,$G(PARAM("LDGRSN"))) Q:'RETURN 0
 Q 1
 ;
CHKUDT(RETURN,AFN,DGDT,OLD,NEW) ; Check update date
 N %,TXT,DATE,LMVT
 K RETURN S RETURN=1
 S:'$D(OLD) %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND") Q 0
 I $G(DGDT)'="",+$G(OLD("DATE"))'=+$G(DGDT) D  Q:'RETURN 0
 . S %=$$CHKDT^DGPMAPI9(.RETURN,+DGDT) Q:'RETURN
 . S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD("PATIENT"),,1)
 . I +$G(LMVT("MFN")),+LMVT("DATE")>+DGDT D  Q
 . . S TXT(1)=$S(LMVT("TYPE")=2:$$EZBLD^DIALOG(4070000.138),LMVT("TYPE")=3:$$EZBLD^DIALOG(4070000.137),1:"")
 . . S RETURN=0,TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 . S NEW("DATE")=+DGDT
 Q 1
 ;
CHKUPD(RETURN,PARAM,AFN,OLD,NEW) ; Check update
 N %,DATE,WARD,TYPE,TXT
 K RETURN,OLD,NEW S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S TXT(1)=$$EZBLD^DIALOG(4070000.014),RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND",.TXT) Q 0
 S %=$$CHKUDT(.RETURN,+AFN,$G(PARAM("DATE")),.OLD,.NEW) Q:'RETURN 0
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD("DATE"))
 ; type of movement
 I $G(PARAM("TYPE"))'="",+$G(OLD("TYPE"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKCITYP^DGPMAPI4(.RETURN,+$G(PARAM("TYPE")),+OLD("PATIENT"),+DATE) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 S TYPE=$S($D(NEW("TYPE")):+NEW("TYPE"),1:+OLD("TYPE"))
 D GETMVTT^DGPMDAL2(.TYPE,+TYPE)
 ; ward
 I TYPE(.03,"I")=5,'OLD("WARD")!($G(PARAM("WARD"))'=""&(+$G(OLD("WARD"))'=+$G(PARAM("WARD")))) D  Q:'RETURN 0
 . S %=$$CHKWARD^DGPMAPI9(.RETURN,+$G(PARAM("WARD")),DATE) Q:'%
 . S NEW("WARD")=+PARAM("WARD")
 S:TYPE(.03,"I")=5 WARD=$S($D(NEW("WARD")):+NEW("WARD"),1:+OLD("WARD"))
 ; roombed
 I TYPE(.03,"I")=5,$G(PARAM("ROOMBED"))'="",+$G(OLD("ROOMBED"))'=+$G(PARAM("ROOMBED")) D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI9(.RETURN,+PARAM("ROOMBED"),WARD,+OLD("PATIENT"),DATE) Q:'%
 . S NEW("ROOMBED")=+PARAM("ROOMBED")
 ; reason for lodging
 I TYPE(.03,"I")=6,$G(PARAM("FCTY"))'="",+$G(OLD("FCTY"))'=+$G(PARAM("FCTY")) D  Q:'RETURN 0
 . S %=$$CHKFCTY^DGPMAPI6(.RETURN,$G(PARAM("FCTY"))) Q:'%
 . S NEW("FCTY")=+PARAM("FCTY")
 ; reason for lodging
 I $G(PARAM("LDGRSN"))'="",+$G(OLD("LDGRSN"))'=+$G(PARAM("LDGRSN")) D  Q:'RETURN 0
 . S %=$$CHKCIRSN^DGPMAPI4(.RETURN,$G(PARAM("LDGRSN"))) Q:'%
 . S NEW("LDGRSN")=+PARAM("LDGRSN")
 I $G(PARAM("LDGCOMM"))'="",$P(PARAM("LDGCOMM"),U)'=$P(OLD("LDGCOMM"),U) D  Q:'RETURN 0
 . I $L($G(PARAM("LDGCOMM")))<3!($L($G(PARAM("LDGCOMM")))>30) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV") Q
 . S NEW("LDGCOMM")=PARAM("LDGCOMM")
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDLDGIN(RETURN,PARAM,AFN) ; Update check-in lodger
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("DATE") [Optional,DateTime] Check-in date
 ;      PARAM("TYPE") [Optional,Numeric] Check-in type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("LDGRSN") [Optional,Numeric] Reason for check-in IEN (pointer to the Lodging Reason file #406.41)
 ;      PARAM("LDGCOMM") [Optional,String] Additional check-in comment (3-30 chars)
 ;      The following parameters are used only with CHECK-IN LODGER movement type:
 ;        PARAM("WARD") [Optional,Numeric] Ward location IEN (pointer to the Ward Location file #42)
 ;        PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to the Room-bed file #405.4)
 ;      The following parameter are used only with CHECK-IN LODGER (OTHER FACILITY) movement type:
 ;        PARAM("FCTY")	[Optional,Numeric] Transfer facility (pointer to the Institution file #4)
 ;   AFN [Required,Numeric] Check-in IEN to update (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,OLD,NEW,DFN
 K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.AFN,.OLD,.NEW)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S DFN=$P(OLD("PATIENT"),U)
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$UPD(.RETURN,.PARAM,+AFN,.OLD,.NEW,1)
 S %=$$UPDPAT^DGPMAPI9(,.PARAM,DFN,+AFN,1)
 D EVT(DFN,+AFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
UPD(RETURN,PARAM,AFN,OLD,NEW,QUIET) ; Update check-in lodger
 N %,MVT,DGQUIET
 S:$G(QUIET) DGQUIET=1 K RETURN S RETURN=0
 D INITEVT^DGPMDAL1
 D SETCIEVT^DGPMDAL1(AFN,"P")
 S:$D(NEW("DATE")) MVT(.01)=+NEW("DATE")
 S:$D(NEW("TYPE")) MVT(.04)=+NEW("TYPE")
 S:$D(NEW("FCTY")) MVT(.05)=+NEW("FCTY")
 S:$D(NEW("WARD")) MVT(.06)=+NEW("WARD"),MVT(.07)=""
 S:$D(NEW("ROOMBED")) MVT(.07)=+NEW("ROOMBED")
 S:$D(NEW("LDGRSN")) MVT(30.01)=+NEW("LDGRSN")
 S:$D(NEW("LDGCOMM")) MVT(30.02)=NEW("LDGCOMM")
 D UPDMVT^DGPMDAL1(.RETURN,.MVT,AFN)
 D SETCIEVT^DGPMDAL1(AFN,"A")
 S RETURN=1
 Q 1
 ;
CHKCITYP(RETURN,TYPE,DFN,DATE) ; Check check-in type
 N %,TMP,TXT,ADTYP,ERR K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI9(.RETURN,TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTCITYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN,+DATE)
 S TXT(1)=TMP(.01,"E"),TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.014))
 I $G(TMP(.04,"I"))'=1 D ERRX^DGPMAPIE(.RETURN,"MVTTINAC",.TXT) Q 0
 I +$G(ADTYP(0))=0 D ERRX^DGPMAPIE(.RETURN,"ADMINVAT",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
CHKCIRSN(RETURN,RSN) ; Check reason for check-in
 N TMP,TXT K RETURN S RETURN=0
 I $G(RSN)="" S TXT(1)="PARAM(""LDGRSN"")" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETRSN^DGPMDAL2(.TMP,+RSN)
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"RSNNFND") Q 0
 S RETURN=1
 Q 1
 ;
