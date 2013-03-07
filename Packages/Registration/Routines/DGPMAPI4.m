DGPMAPI4 ;RGI/VSL - CHECK IN PATIENT API; 3/4/2013
 ;;5.3;Registration;**260005**;
LDGIN(RETURN,PARAM) ; Check-in patient
 N %,PM6,DFN,PTF,RPTF,PM1,PM6,NOD60,IFN1,IFN6,TYPE
 K RETURN S RETURN=0
 S %=$$CHKLDG(.RETURN,.PARAM,.TYPE)
 I %=0 Q 0
 D INITEVT^DGPMDAL1
 S DFN=+PARAM("PATIENT")
 S %=$$LOCKMVT^DGPMDAL1(DFN)
 I %=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 S %=$$ADDLDGIN(.RETURN,.PARAM,.TYPE)
 D RESET^DGPMDDLD
 D SETCIEVT^DGPMDAL1(+RETURN,"A")
 D MVTEVT^DGPMAPI7(DFN,4,+IFN1)
 S RETURN=IFN1
 D ULOCKMVT^DGPMDAL1(DFN)
 Q 1
 ;
ADDLDGIN(RETURN,PARAM,TYPE) ; Add check-in lodger
 S DFN=+PARAM("PATIENT")
 S PM1(.01)=+PARAM("DATE") ; admission date
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM1)
 S IFN1=+RETURN
 K PM1
 ;D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 S PM1(.02)=4  ; transaction
 S PM1(.03)=DFN  ; patient
 ;D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 S PM1(.04)=+PARAM("TYPE")  ; type of movement
 I TYPE(.03,"I")=5 D
 . S PM1(.06)=+PARAM("WARD")  ; ward
 . S PM1(.07)=+$G(PARAM("ROOMBED"))  ; roombed
 I TYPE(.03,"I")=6 D
 . S PM1(.05)=+$G(PARAM("FCTY"))  ; Transfer facility
 S PM1(30.01)=+PARAM("LDGRSN")  ; lodger reason
 S PM1(30.02)=PARAM("LDGCOMM")  ; lodger comments
 S PM1(100)=DUZ,PM1(101)=$$NOW^XLFDT()
 S PM1(102)=DUZ,PM1(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 K PM1
 S PM1(.14)=IFN1  ; admission checkin movement
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 Q IFN1
 ;
CANDEL(RETURN,AFN) ; 
 S RETURN=1
 Q 1
 ;
DELLDGIN(RETURN,AFN) ; Delete lodger check-in
 N %,ADM,IN,MVTS
 K RETURN S RETURN=0
 S %=$$CANDEL^DGPMAPI1(.RETURN,+AFN) Q:'RETURN 0
 D GETMVT^DGPMDAL1(.ADM,+AFN,".03;.15;.16;.17;.18;.21")
 S %=$$LOCKMVT^DGPMDAL1(ADM(.03,"I"))
 I %=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 D INITEVT^DGPMDAL1
 D SETDLEVT^DGPMDAL1(+AFN)
 D LSTCA^DGPMDAL1(.MVTS,+AFN)
 S IN=0
 F  S IN=$O(MVTS(IN)) Q:IN=""  D
 . D:IN'=+AFN DELMVT^DGPMDAL1(IN)
 D DELMVT^DGPMDAL1(+AFN)
 S DFN=ADM(.03,"I") D RESET^DGPMDDLD
 D MVTEVT^DGPMAPI7(ADM(.03,"I"),1,+AFN)
 D ULOCKMVT^DGPMDAL1(ADM(.03,"I"))
 S RETURN=1
 Q 1
 ;
CHKDT(RETURN,PARAM) ; Check check-in date
 ; check-in date
 K RETURN S RETURN=1
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(PARAM("PATIENT"))) Q:'RETURN 0
 I $G(PARAM("DATE"))=""!(+$G(PARAM("DATE"))<1800000) D  Q 0
 . S TXT(1)="PARAM('DATE')",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 I $$TIMEUSD^DGPMDAL2(+PARAM("PATIENT"),+PARAM("DATE")) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 I "^1^2^6^7^"[("^"_$G(LMVT("TYPE"))_"^") S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"LDGPINP")
 I +$G(LMVT("MFN"))>0,LMVT("DATE")>+PARAM("DATE") D  Q 0
  . S TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG("4070000.00"_LMVT("TYPE"))),RETURN=0
  . S TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 Q 1
 ;
CHKLDG(RETURN,PARAM,TYPE) ; Check check-in parameters
 N %,TXT,LMVT
 K RETURN S RETURN=1 ; patient
 S %=$$CHKDT(.RETURN,.PARAM) Q:'RETURN 0
 ; type of movement
 S:'$G(ASH) %=$$CHKCITYP^DGPMAPI4(.RETURN,$G(PARAM("TYPE")),+PARAM("PATIENT"),+PARAM("DATE")) Q:'RETURN 0
 D GETMVTT^DGPMDAL2(.TYPE,+PARAM("TYPE"))
 ;D GETMASMT^DGPMDAL2(.MAS,TYPE)
 ; short diagnosis
 I $G(PARAM("LDGCOMM"))'="",$L($G(PARAM("LDGCOMM")))<3!($L($G(PARAM("SHDIAG")))>30) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV") Q 0
 ; ward
 S:TYPE(.03,"I")=5 %=$$CHKWARD^DGPMAPI8(.RETURN,$G(PARAM("WARD")),+PARAM("DATE")) Q:'RETURN 0
 ; roombed
 I TYPE(.03,"I")=5,$G(PARAM("ROOMBED"))'="" D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI8(.RETURN,PARAM("ROOMBED"),+PARAM("WARD"),+PARAM("PATIENT"),+PARAM("DATE"))
 I TYPE(.03,"I")=6 S %=$$CHKFCTY^DGPMAPI8(.RETURN,$G(PARAM("FCTY"))) Q:'RETURN 0
 ; reason for lodging
 S %=$$CHKCIRSN^DGPMAPI8(.RETURN,$G(PARAM("LDGRSN"))) Q:'RETURN 0
 Q 1
 ;
CHKUDT(RETURN,AFN,DGDT) ; Check update date
 N %,TXT,DATE
 K RETURN S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 I $G(DGDT)'="",$G(OLD("DATE"))'=+$G(DGDT) D  Q:'RETURN 0
 . S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD("PATIENT"),+DGDT)
 . I +$G(LMVT("MFN"))'=+AFN D  Q
 . . S TXT(1)=$S(LMVT("TYPE")=2:$$EZBLD^DIALOG(4070000.138),LMVT("TYPE")=3:$$EZBLD^DIALOG(4070000.137),1:"")
 . . S RETURN=0,TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 . S RETURN=+DGDT
 Q 1
 ;
CHKUPD(RETURN,PARAM,AFN,OLD,NEW) ; Check update
 N %,TXT,DATE,WARD,RPHY
 K RETURN,OLD,NEW S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S %=$$CHKUDT(.RETURN,+AFN,$G(PARAM("DATE"))) Q:'RETURN 0
 I RETURN>1 S NEW("DATE")=+RETURN
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD("DATE"))
 ; type of movement
 I $G(PARAM("TYPE"))'="",$G(OLD("TYPE"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKCITYP^DGPMAPI4(.RETURN,$G(PARAM("TYPE")),+OLD("PATIENT"),+DATE) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 ; ward
 I $G(PARAM("WARD"))'="",+$G(OLD("WARD"))'=+$G(PARAM("WARD")) D  Q:'RETURN 0
 . S %=$$CHKWARD^DGPMAPI8(.RETURN,$G(PARAM("WARD")),DATE) Q:'%
 . S NEW("WARD")=+PARAM("WARD")
 S WARD=$S($D(NEW("WARD")):+NEW("WARD"),1:+OLD("WARD"))
 ; roombed
 I $G(PARAM("ROOMBED"))'="",+$G(OLD("ROOMBED"))'=$G(PARAM("ROOMBED")) D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI8(.RETURN,PARAM("ROOMBED"),WARD,+OLD("PATIENT"),DATE) Q:'%
 . S NEW("ROOMBED")=+PARAM("ROOMBED")
 S RETURN=($D(NEW)>0)
 ; reason for lodging
 I $G(PARAM("LDGRSN"))'="",+$G(OLD("LDGRSN"))'=+$G(PARAM("LDGRSN")) D  Q:'RETURN 0
 . S %=$$CHKCIRSN^DGPMAPI8(.RETURN,$G(PARAM("LDGRSN"))) Q:'%
 . S NEW("LDGRSN")=+PARAM("LDGRSN")
 S WARD=$S($D(NEW("LDGRSN")):+NEW("LDGRSN"),1:+OLD("LDGRSN"))
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDLDGIN(RETURN,PARAM,AFN) ; Update check-in lodger
 N %,MVT,OLD,DFN,RPHY,NEW K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.AFN,.OLD,.NEW)
 Q:'% 0
 S DFN=$P(OLD("PATIENT"),U)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S %=$$LOCKMVT^DGPMDAL1(DFN)
 I %=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 D INITEVT^DGPMDAL1
 D SETCIEVT^DGPMDAL1(AFN,"P")
 S:$D(NEW("DATE")) MVT(.01)=+NEW("DATE")
 S:$D(NEW("TYPE")) MVT(.04)=+NEW("TYPE")
 S:$D(NEW("WARD")) MVT(.06)=+NEW("WARD"),MVT(.07)=""
 S:$D(NEW("ROOMBED")) MVT(.07)=+NEW("ROOMBED")
 S:$D(NEW("LDGRSN")) MVT(.1)=NEW("LDGRSN")
 S:$D(NEW("LDGCOMM")) MVT(.1)=NEW("LDGCOMM")
 D UPDMVT^DGPMDAL1(.RETURN,.MVT,AFN)
 D RESET^DGPMDDLD
 D SETCIEVT^DGPMDAL1(AFN,"A")
 D MVTEVT^DGPMAPI7(DFN,4,AFN)
 D ULOCKMVT^DGPMDAL1(DFN)
 S RETURN=1
 Q 1
 ;
CHKCITYP(RETURN,TYPE,DFN,DATE) ; Check check-in type
 N %,TMP,TXT,ADTYP,ERR K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI8(.RETURN,TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTCITYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN)
 I $G(TMP(.04,"I"))'=1 S ERR="MVTTINAC"
 I +$G(ADTYP(0))=0 S TXT(1)=TMP(.01,"E") D ERRX^DGPMAPIE(.RETURN,$S($D(ERR):ERR,1:"ADMINVAT"),.TXT) Q 0
 S RETURN=1
 Q 1
 ;
