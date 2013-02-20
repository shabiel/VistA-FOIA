DGPMAPI1 ;RGI/VSL - ADMIT PATIENT API; 2/20/2013
 ;;5.3;Registration;**260005**;
ADMIT(RETURN,PARAM) ; Admit patient
 ;
 ;Input
 ;
 ;Required elements include:
 ;  PARAM("ADMREG")=admitting regulation
 ;  PARAM("ATNDPHY")=attending physician
 ;  PARAM("DATE")=date time (admission date)
 ;  PARAM("FDEXC")=facility directory exclusion
 ;  PARAM("FTSPEC")=facility treating specialty
 ;  PARAM("PATIENT")=patient
 ;  PARAM("SHDIAG")=short diagnosis
 ;  PARAM("TYPE")=type of movement
 ;  PARAM("WARD")=ward
 ;
 ;Optional elements include:
 ;  PARAM("ADMSCC")=admitted for sc condition
 ;  PARAM("ADMSRC")=source of admission
 ;  PARAM("DIAG",1)=diagnosis array
 ;  PARAM("ELIGIB")=admitting eligibility
 ;  PARAM("PRYMPHY")=primary physician
 ;  PARAM("ROOMBED")=roombed
 ;  PARAM("SCADM")=scheduled admission
 ;  PARAM("SERILL")=condition (SERIOUSLY ILL)
 N %,PM6,DFN,PTF,RPTF,PM1,PM6,NOD60,IFN1,IFN6
 K RETURN S RETURN=0
 S %=$$CHKADM(.RETURN,.PARAM)
 I %=0 Q 0
 D INITEVT^DGPMDAL1
 S DFN=+PARAM("PATIENT")
 S %=$$LOCKMVT^DGPMDAL1(DFN)
 I %=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 S %=$$ADDADM(.RETURN,.PARAM)
 I +$G(PARAM("SCADM"))>0 D 
 . N SCADM S SCADM(17)=IFN1
 . D UPDSCADM^DGPMDAL1(,.SCADM,+$G(PARAM("SCADM")))
 S PARAM("ADMIFN")=IFN1,PARAM("RELIFN")=IFN1
 S %=$$ADDFTS^DGPMAPI6(.RETURN,.PARAM)
 D UPDPAT(,.PARAM,DFN)
 D SETAEVT^DGPMDAL1(IFN1,+RETURN,"A")
 D MVTEVT(DFN,1,+IFN1)
 S RETURN=IFN1
 D ULOCKMVT^DGPMDAL1(DFN)
 Q 1
 ;
ADDADM(RETURN,PARAM) ; Add admission
 S DFN=+PARAM("PATIENT")
 S PM1(.01)=+PARAM("DATE") ; admission date
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM1)
 S IFN1=+RETURN
 ;Add PTF
 S PTF(.01)=DFN,PTF(2)=+PARAM("DATE")
 S PTF(11)=1,PTF(6)=0,PTF(77)=0
 S PTF(20.1)=$S($G(PARAM("ELIGIB")):PARAM("ELIGIB"),1:0) ; eligibility
 S PTF(20)=+$G(PARAM("ADMSRC"))
 D ADDPTF^DGPMDAL1(.RPTF,.PTF)
 D UPDPTF^DGPMDAL1(.RPTF,.PTF,+RPTF)
 K PM1
 S PM1(.06)=+PARAM("WARD")  ; ward
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 S PM1(.02)=1  ; transaction
 S PM1(.16)=+RPTF
 S PM1(.03)=DFN  ; patient
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 S PM1(.04)=+PARAM("TYPE")  ; type of movement
 S PM1(.06)=+PARAM("WARD")  ; ward
 S PM1(.07)=+$G(PARAM("ROOMBED"))  ; roombed
 S PM1(.1)=PARAM("SHDIAG")  ; short diagnosis
 S PM1(.11)=+$G(PARAM("ADMSCC"))  ; admitted for sc condition
 S PM1(.12)=+PARAM("ADMREG")  ; admitting regulation
 S PM1(.25)=$S(+$G(PARAM("SCADM"))>0:1,1:0)  ; scheduled admission
 S PM1(41)=+$G(PARAM("FDEXC"))  ; facility directory exclusion
 S PM1(42)=$$NOW^XLFDT()  ; facility directory time stamp
 S PM1(43)=DUZ  ; facility directory user
 S PM1(54)=0
 S PM1(100)=DUZ,PM1(101)=$$NOW^XLFDT()
 S PM1(102)=DUZ,PM1(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 K PM1
 S PM1(.14)=IFN1  ; admission checkin movement
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 Q IFN1
 ;
UPDPAT(RETURN,PARAM,DFN) ; Update patient
 N PAT
 S PAT(.103)=+$G(PARAM("FTSPEC"))
 S PAT(.104)=$S(+$G(PARAM("PRYMPHY"))>0:+$G(PARAM("PRYMPHY")),1:+$G(PARAM("ATNDPHY")))
 S PAT(.1041)=+$G(PARAM("ATNDPHY"))
 S PAT(401.3)=$G(PARAM("SERILL"))
 S PAT(401.4)=$P($$NOW^XLFDT(),".")
 D RESET^DGPMDDCN
 D UPDPAT^DGPMDAL1(,.PAT,DFN)
 Q 1
 ;
CANDEL(RETURN,AFN) ; 
 N %,APMV,I,TXT,OLD
 S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 D LSTAPMV^DGPMDAL1(.APMV,AFN,".15")
 F I=0:0 S I=$O(APMV(I)) Q:I=""!'RETURN  D
 . I APMV(I,.15,"I")]"" S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"CANDASIH") Q
 Q:'RETURN 0
 D GETMVT^DGPMDAL1(.MVT,AFN,".16;.17;.21")
 I MVT(.21,"I"),MVT(.17,"I") S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"CANMDDF") Q 0
 S %=$$ISPTFCEN^DGPMDAL1(MVT(.16,"I"))
 I % S RETURN=0,TXT(1)=% D ERRX^DGPMAPIE(.RETURN,"CANDWPTF",.TXT) Q 0
 Q 1
 ;
DELADM(RETURN,AFN) ; Delete admission
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
 I ADM(.18,"I")=40 D
 . S %=$$DELASH^DGPMAPI2(.RETURN,ADM(.21,"I"))
 D DELPTF^DGPMDAL1(ADM(.16,"I"))
 D DELMVT^DGPMDAL1(+AFN)
 D MVTEVT(ADM(.03,"I"),1,+AFN)
 D ULOCKMVT^DGPMDAL1(ADM(.03,"I"))
 S RETURN=1
 Q 1
 ;
CHKADM(RETURN,PARAM,ASH) ; Check admit parameters
 N %,TXT,LMVT
 K RETURN S RETURN=1 ; patient
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(PARAM("PATIENT"))) Q:'RETURN 0
 ; admission date
 I $G(PARAM("DATE"))=""!(+$G(PARAM("DATE"))<1800000) D  Q 0
 . S TXT(1)="PARAM('DATE')",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 I $$TIMEUSD^DGPMDAL2(+PARAM("PATIENT"),+PARAM("DATE")) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 I '$G(ASH),+$G(LMVT("ADMDT"))>0,LMVT("DISIFN")=""!(+LMVT("DISIFN")>0&(+PARAM("DATE")<+$G(LMVT("DATE")))) D  Q 0
 . S RETURN=0,TXT(1)=$$FMTE^XLFDT(+LMVT("ADMDT")) D ERRX^DGPMAPIE(.RETURN,"ADMPAHAD",.TXT)
 ; facility directory exclusion
 I $G(PARAM("FDEXC"))=""!(+$G(PARAM("FDEXC"))'=0&(+$G(PARAM("FDEXC"))'=1)) D  Q 0
 . S TXT(1)="PARAM('FDEXC')",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 ; admitting regulation
 S %=$$CHKAREG^DGPMAPI8(.RETURN,$G(PARAM("ADMREG"))) Q:'RETURN 0
 ; type of movement
 S:'$G(ASH) %=$$CHKATYP^DGPMAPI1(.RETURN,$G(PARAM("TYPE")),+PARAM("PATIENT"),+PARAM("DATE")) Q:'RETURN 0
 ; short diagnosis
 I $L($G(PARAM("SHDIAG")))<3!($L($G(PARAM("SHDIAG")))>30) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV") Q 0
 ; ward
 S %=$$CHKWARD^DGPMAPI8(.RETURN,$G(PARAM("WARD")),+PARAM("DATE")) Q:'RETURN 0
 ; roombed
 I $G(PARAM("ROOMBED"))'="" D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI8(.RETURN,PARAM("ROOMBED"),+PARAM("WARD"),+PARAM("PATIENT"),+PARAM("DATE"))
 ; related physical movement
 S %=$$CHKRPM^DGPMAPI6(.RETURN,.PARAM) Q:'% 0
 ; source of admission
 I $G(PARAM("ADMSRC"))'="" D  Q:'RETURN 0
 . S %=$$CHKASRC^DGPMAPI1(.RETURN,$G(PARAM("ADMSRC")))
 Q 1
 ;
CHKUPD(RETURN,PARAM,AFN,OLD,NEW) ; Check update
 N %,TXT,DATE,WARD
 K RETURN,OLD,NEW S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 I $G(PARAM("DATE"))'="",$G(OLD("DATE"))'=+$G(PARAM("DATE")) D  Q:'RETURN 0
 . S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD("PATIENT"),+PARAM("DATE"))
 . I +$G(LMVT("MFN"))'=+AFN D  Q
 . . S TXT(1)=$S(LMVT("TYPE")=2:$$EZBLD^DIALOG(4070000.138),LMVT("TYPE")=3:$$EZBLD^DIALOG(4070000.137),1:"")
 . . S RETURN=0,TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 . S NEW("DATE")=+PARAM("DATE")
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD("DATE"))
 I $G(PARAM("FDEXC"))'="",+$G(PARAM("FDEXC"))'=OLD("FDEXC") D  Q:'RETURN 0
 . I +$G(PARAM("FDEXC"))'=0&(+$G(PARAM("FDEXC"))'=1) D  Q
 . . S TXT(1)="PARAM('FDEXC')",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 . S NEW("FDEXC")=+PARAM("FDEXC")
 ; admitting regulation
 I $G(PARAM("ADMREG"))'="",$G(OLD("ADMREG"))'=+$G(PARAM("ADMREG")) D  Q:'RETURN 0
 . S %=$$CHKAREG^DGPMAPI8(.RETURN,$G(PARAM("ADMREG"))) Q:'RETURN
 . S NEW("ADMREG")=+PARAM("ADMREG")
 ; type of movement
 I $G(PARAM("TYPE"))'="",$G(OLD("TYPE"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKATYP^DGPMAPI1(.RETURN,$G(PARAM("TYPE")),+OLD("PATIENT"),+DATE) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 ; short diagnosis
 I $G(PARAM("SHDIAG"))'="",$G(OLD("SHDIAG"))'=$G(PARAM("SHDIAG")) D  Q:'RETURN 0
 . I $L($G(PARAM("SHDIAG")))<3!($L($G(PARAM("SHDIAG")))>30) D   Q
 . . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV")  Q
 . S NEW("SHDIAG")=PARAM("SHDIAG")
 ; ward
 I $G(PARAM("WARD"))'="",$G(OLD("WARD"))'=+$G(PARAM("WARD")) D  Q:'RETURN 0
 . S %=$$CHKWARD^DGPMAPI8(.RETURN,$G(PARAM("WARD")),DATE) Q:'%
 . S NEW("WARD")=+PARAM("WARD")
 S WARD=$S($D(NEW("WARD")):+NEW("WARD"),1:+OLD("WARD"))
 ; roombed
 I $G(PARAM("ROOMBED"))'="",$G(OLD("ROOMBED"))'=$G(PARAM("ROOMBED")) D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI8(.RETURN,PARAM("ROOMBED"),WARD,+OLD("PATIENT"),DATE) Q:'%
 . S NEW("ROOMBED")=+PARAM("ROOMBED")
 ; related physical movement
 S %=$$CHKUPD^DGPMAPI6(.RETURN,.PARAM,+AFN,.NEW) Q:'% 0
 ; PTF
 S %=$$CHKUPTF^DGPMAPI1(.RETURN,.PARAM,+OLD("PTF")) Q:'% 0
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDADM(RETURN,PARAM,AFN) ; Update admission
 N %,MVT,OLD,DFN,RPHY,NEW K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.AFN,.OLD,.NEW)
 Q:'% 0
 S DFN=$P(OLD("PATIENT"),U)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S %=$$LOCKMVT^DGPMDAL1(DFN)
 I %=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 S RPHY=$$GETRPHY^DGPMDAL1(AFN)
 D INITEVT^DGPMDAL1
 D SETAEVT^DGPMDAL1(AFN,RPHY,"P")
 S:$D(NEW("DATE")) MVT(.01)=+NEW("DATE")
 S:$D(NEW("FDEXC")) MVT(41)=+NEW("FDEXC")
 S:$D(NEW("ADMREG")) MVT(.12)=+NEW("ADMREG")
 S:$D(NEW("ADMSCC")) MVT(.11)=NEW("ADMSCC")
 S:$D(NEW("TYPE")) MVT(.04)=+NEW("TYPE")
 S:$D(NEW("SHDIAG")) MVT(.1)=NEW("SHDIAG")
 S:$D(NEW("WARD")) MVT(.06)=+NEW("WARD"),MVT(.07)=""
 S:$D(NEW("ROOMBED")) MVT(.07)=+NEW("ROOMBED")
 D UPDMVT^DGPMDAL1(.RETURN,.MVT,AFN)
 S %=$$UPDFTS^DGPMAPI6(.RETURN,.PARAM,RPHY)
 S %=$$UPDPTF(.RETURN,.PARAM,$P(OLD("PTF"),U))
 S %=$$UPDPAT(.RETURN,.PARAM,DFN)
 D SETAEVT^DGPMDAL1(AFN,RPHY,"A")
 D MVTEVT(DFN,1,AFN)
 D ULOCKMVT^DGPMDAL1(DFN)
 S RETURN=1
 Q 1
 ;
CHKUPTF(RETURN,PARAM,PFN,OLD,NEW) ;
 N %
 D GETPTF^DGPMDAL1(.OLD,PFN,"20;20.1;")
 I $G(PARAM("ADMSRC"))'="",+PARAM("ADMSRC")'=OLD(20,"I") D  Q:'RETURN 0
 . S %=$$CHKASRC^DGPMAPI1(.RETURN,$G(PARAM("ADMSRC")))
 . S NEW(20)=+PARAM("ADMSRC")
 S RETURN=1
 Q 1
 ;
UPDPTF(RETURN,ADM,PFN) ; Update ptf
 N %,PTF,OLD,NEW K RETURN
 S %=$$CHKUPTF(.RETURN,.PARAM,+PFN,.OLD,.NEW) Q:'% 0
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 ; source of admission
 S:$D(NEW("ADMSRC")) PTF(20)=NEW("ADMSRC")
 S PTF(20.1)=$S($G(PARAM("ELIGIB")):PARAM("ELIGIB"),1:0) ; eligibility
 D UPDPTF^DGPMDAL1(,.PTF,PFN)
 Q 1
 ;
CHKATYP(RETURN,TYPE,DFN,DATE) ; Check admission type
 N %,TMP,TXT,ADTYP,ERR K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI8(.RETURN,TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTADTYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN)
 I $G(TMP(.04,"I"))'=1 S ERR="MVTTINAC"
 I +$G(ADTYP(0))=0 S TXT(1)=TMP(.01,"E") D ERRX^DGPMAPIE(.RETURN,$S($D(ERR):ERR,1:"ADMINVAT"),.TXT) Q 0
 S RETURN=1
 Q 1
 ;
CHKASRC(RETURN,ADMSRC) ; Check admission source
 K RETURN S RETURN=0
 D GETADMS^DGPMDAL2(.TMP,+$G(ADMSRC))
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"ASRCNFND") Q 0
 S RETURN=1
 Q 1
 ;
MVTEVT(DFN,TYPE,MFN) ; Movement events
 N DGPMDA,DGPMA,DGPMP,DGPMT,DGQUIET,DGNEW,DGPM0
 D START^DGPWB(DFN)
 D EN^DGPMVBM
 S DGPM0=""
 S DGPMA=$$GETMVT0^DGPMDAL1(MFN)
 S DGPMDA=MFN,DGPMP="",DGPMT=TYPE,DGQUIET=1
 S:TYPE=1 DGNEW=1
 D ^DGPMEVT
 Q
 ;
