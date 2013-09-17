DGPMAPI1 ;RGI/VSL - ADMIT PATIENT API; 8/26/13
 ;;5.3;Registration;**260005**;
ADMIT(RETURN,PARAM) ; Admit patient
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new admission IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("PATIENT") [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;      PARAM("DATE") [Required,DateTime] Admission date
 ;      PARAM("TYPE") [Required,Numeric] Admission type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("ADMREG") [Required,Numeric] Admitting regulation IEN (pointer to the VA Admitting Regulation file #43.4)
 ;      PARAM("ATNDPHY") [Required,Numeric] Attending physician IEN (pointer to the New Person file #200)
 ;      PARAM("FDEXC") [Required,Boolean] Patient wants to be excluded or not from Facility Directory.
 ;                                        If it is set to 1 the patient will be excluded from Facility Directory.
 ;      PARAM("FTSPEC") [Required,Numeric] Facility treating specialty IEN (pointer to the Facility Treating Specialty file #45.7)
 ;      PARAM("SHDIAG") [Required,String] A brief description of the diagnosis (3-30 chars) 
 ;      PARAM("WARD") [Required,Numeric] Ward location IEN (pointer to the Ward Location file #42)
 ;      PARAM("ADMSCC") [Optional,Boolean] Set to 1 if patient is admitted for service connected condition. Default: 0
 ;      PARAM("ADMSRC") [Optional,Numeric] Source of admission IEN (pointer to the Source of Admission file #45.1)
 ;      PARAM("ELIGIB") [Optional,Numeric] Admitting eligibility IEN (pointer to the Eligibility Code file #8)
 ;      PARAM("PRYMPHY") [Optional,Numeric] Primary physician IEN (pointer to the New Person file #200)
 ;      PARAM("FCTY") [Optional,Numeric] Transfer facility IEN (pointer to the Institution file #4)
 ;      PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to the Room-bed file #405.4)
 ;      PARAM("ADMCAT") [Optional,Numeric] Admitting category IEN (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;      PARAM("SCADM") [Optional,Boolean] Set to 1 if this admission is a result of a previously scheduled admission, 0 otherwise. Default: 0.
 ;      PARAM("DIAG") [Optional,Array] Array of detailed diagnosis description.
 ;         PARAM("DIAG",n) [Optional,String] Detailed diagnosis description.
 ;Output:
 ;  1=Success,0=Failure
 N %,DFN,MTYPE
 K RETURN S RETURN=0
 S %=$$CHKADD(.RETURN,.PARAM,,.MTYPE) Q:'RETURN 0
 S DFN=+PARAM("PATIENT")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$ADD(.RETURN,.PARAM,1,.MTYPE)
 S %=$$UPDPAT^DGPMAPI9(,.PARAM,DFN,,1)
 D EVT(DFN,+RETURN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
ADD(RETURN,PARAM,QUIET,MTYPE) ; Admit
 N %,DFN,AFN,DGQUIET
 S:$G(QUIET) DGQUIET=1
 D INITEVT^DGPMDAL1
 S DFN=+PARAM("PATIENT")
 S AFN=$$ADDADM(.RETURN,.PARAM,.MTYPE)
 I +$G(PARAM("SCADM"))>0 D 
 . N SCADM S SCADM(17)=AFN
 . D UPDSCADM^DGPMDAL1(,.SCADM,+$G(PARAM("SCADM")))
 S PARAM("ADMIFN")=AFN,PARAM("RELIFN")=AFN
 S %=$$ADD^DGPMAPI6(.RETURN,.PARAM)
 D SETAEVT^DGPMDAL1(AFN,+RETURN,"A")
 S RETURN=AFN
 Q 1
EVT(DFN,MFN,MODE) ; Raise admission event
 N DGPMDA
 S DGPMDA=MFN
 D ^DGPMVBUL,CK^DGBLRV
 D ADM^DGPMVODS
 D MVTEVT^DGPMAPI9(+DFN,1,+MFN,.MODE)
 Q
ADDADM(RETURN,PARAM,MTYPE) ; Add admission
 N %,DFN,PTF,RPTF,PM1,IFN1,SCC
 S DFN=+PARAM("PATIENT")
 S PM1(.01)=+PARAM("DATE") ; admission date
 S PM1(.02)=1  ; transaction
 S PM1(.03)=DFN  ; patient
 S PM1(.04)=+PARAM("TYPE")  ; type of movement
 S PM1(100)=DUZ,PM1(101)=$$NOW^XLFDT()
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM1)
 S IFN1=+RETURN
 ;Add PTF
 S PTF(.01)=DFN,PTF(2)=+PARAM("DATE")
 S PTF(11)=1,PTF(6)=0 ;,PTF(77)=0
 S PTF(20.1)=$S($G(PARAM("ELIGIB")):PARAM("ELIGIB"),1:0) ; eligibility
 S:+$G(PARAM("ADMSRC"))>0 PTF(20)=+$G(PARAM("ADMSRC"))
 D ADDPTF^DGPMDAL1(.RPTF,.PTF)
 D UPDPTF^DGPMDAL1(.RPTF,.PTF,+RPTF)
 K PM1
 S:$G(MTYPE)=9 PM1(.05)=+PARAM("FCTY")  ; transfer facility
 S PM1(.06)=+PARAM("WARD")  ; ward
 S PM1(.16)=+RPTF
 S PM1(.06)=+PARAM("WARD")  ; ward
 S:+$G(PARAM("ROOMBED"))>0 PM1(.07)=+$G(PARAM("ROOMBED"))  ; roombed
 S PM1(.1)=PARAM("SHDIAG")  ; short diagnosis
 S SCC=$G(PARAM("ADMSCC")),PM1(.11)=$S(SCC:1,SCC=0:0,1:"")  ; admitted for sc condition
 S PM1(.12)=+PARAM("ADMREG")  ; admitting regulation
 S PM1(.25)=$S(+$G(PARAM("SCADM"))>0:1,1:0)  ; scheduled admission
 S PM1(41)=+$G(PARAM("FDEXC"))  ; facility directory exclusion
 S PM1(42)=$$NOW^XLFDT()  ; facility directory time stamp
 S PM1(43)=DUZ  ; facility directory user
 S PM1(54)=+$G(PARAM("ADMCAT"))
 S PM1(102)=DUZ,PM1(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM1,IFN1)
 Q IFN1
 ;
CANDEL(RETURN,AFN,ADM) ; 
 N %,APMV,I,TXT,MVT
 S RETURN=1
 D GETMVT^DGPMDAL1(.ADM,+AFN,".03;.15;.16;.17;.18;.21")
 I ADM=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
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
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   AFN [Required,Numeric] Admission IEN to delete (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,ADM,DFN
 K RETURN S RETURN=0
 S %=$$CANDEL^DGPMAPI1(.RETURN,+AFN,.ADM) Q:'RETURN 0
 S DFN=ADM(.03,"I")
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$DEL(.RETURN,+AFN,.ADM,1)
 S %=$$UPDPAT^DGPMAPI9(,,DFN,,1)
 D EVT(DFN,+AFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
DEL(RETURN,AFN,ADM,QUIET) ; Delete admission
 N MVTS,IN,%,DGQUIET
 S:$G(QUIET) DGQUIET=1
 D INITEVT^DGPMDAL1
 D SETDLEVT^DGPMDAL1(+AFN)
 D LSTCA^DGPMDAL1(.MVTS,+AFN)
 S IN=0
 I ADM(.18,"I")=40 D
 . S %=$$DELASH^DGPMAPI2(.RETURN,ADM(.21,"I"))
 F  S IN=$O(MVTS(IN)) Q:IN=""  D
 . D:IN'=+AFN DELMVT^DGPMDAL1(IN)
 D DELPTF^DGPMDAL1(ADM(.16,"I"))
 D DELMVT^DGPMDAL1(+AFN)
 Q 1
CHKDT(RETURN,PARAM,ASH) ; Check admission date
 N LMVT,%,TXT
 ; admission date
 K RETURN S RETURN=1
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(PARAM("PATIENT"))) Q:'RETURN 0
 S %=$$CHKDT^DGPMAPI9(.RETURN,$G(PARAM("DATE"))) Q:'RETURN 0
 I $G(ASH)<2,$$TIMEUSD^DGPMDAL2(+PARAM("PATIENT"),+PARAM("DATE")) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TIMEUSD")
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 I $G(LMVT("TYPE"))=4 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMPLODG")
 I '$G(ASH),+$G(LMVT("ADMDT"))>0,LMVT("DISIFN")="" D  Q 0
 . S RETURN=0,TXT(1)=$$FMTE^XLFDT(+LMVT("ADMDT")) D ERRX^DGPMAPIE(.RETURN,"ADMPAHAD",.TXT)
 I +$G(LMVT("MFN"))>0,LMVT("DATE")>+PARAM("DATE") D  Q 0
 . S RETURN=0,TXT(1)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.011))
 . S TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.01_LMVT("TYPE")))
 . D ERRX^DGPMAPIE(.RETURN,"ADMNBLD",.TXT)
 Q 1
 ;
CHKADD(RETURN,PARAM,ASH,MTYPE) ; Check admit parameters
 N %,TXT,TT
 K RETURN S RETURN=1 ; patient
 S %=$$CHKDT(.RETURN,.PARAM,.ASH) Q:'RETURN 0
 ; facility directory exclusion
 I $G(PARAM("FDEXC"))=""!(+$G(PARAM("FDEXC"))'=0&(+$G(PARAM("FDEXC"))'=1)) D  Q 0
 . S TXT(1)="PARAM(""FDEXC"")",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 ; admitting regulation
 S %=$$CHKAREG^DGPMAPI9(.RETURN,$G(PARAM("ADMREG")),"PARAM(""ADMREG"")") Q:'RETURN 0
 ; admitting category
 I $G(PARAM("ADMCAT"))'="" D  Q:'RETURN 0
 . S %=$$CHKACAT^DGSAAPI(.RETURN,+PARAM("ADMREG"),$G(PARAM("ADMCAT")),"PARAM(""ADMCAT"")")
 ; type of movement
 S:'$G(ASH) %=$$CHKATYP^DGPMAPI1(.RETURN,$G(PARAM("TYPE")),+PARAM("PATIENT"),+PARAM("DATE")) Q:'RETURN 0
 ; transfer facility if type=9
 D GETMVTT^DGPMDAL2(.TT,+PARAM("TYPE")) S MTYPE=TT(.03,"I")
 I MTYPE=9 S %=$$CHKFCTY^DGPMAPI6(.RETURN,$G(PARAM("FCTY"))) Q:'RETURN 0
 ; short diagnosis
 I $L($G(PARAM("SHDIAG")))<3!($L($G(PARAM("SHDIAG")))>30) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV") Q 0
 ; ward
 S %=$$CHKWARD^DGPMAPI9(.RETURN,$G(PARAM("WARD")),+PARAM("DATE")) Q:'RETURN 0
 ; roombed
 I $G(PARAM("ROOMBED"))'="" D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI9(.RETURN,PARAM("ROOMBED"),+PARAM("WARD"),+PARAM("PATIENT"),+PARAM("DATE"))
 ; related physical movement
 S %=$$CHKADD^DGPMAPI6(.RETURN,.PARAM) Q:'% 0
 ; source of admission
 I $G(PARAM("ADMSRC"))'=""&($G(PARAM("ADMSRC"))'="^") D  Q:'RETURN 0
 . S %=$$CHKASRC^DGPMAPI1(.RETURN,$G(PARAM("ADMSRC")))
 ; eligibility
 I $G(PARAM("ELIGIB"))'=""&($G(PARAM("ELIGIB"))'="^") D  Q:'RETURN 0
 . S %=$$CHKELIG^DGPMAPI9(.RETURN,+$G(PARAM("PATIENT")),$G(PARAM("ELIGIB")))
 Q 1
 ;
CHKUDT(RETURN,AFN,DGDT,OLD,NEW) ; Check update date
 N %,TXT,LMVT
 K RETURN S RETURN=1
 S:'$D(OLD) %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 I $G(DGDT)'="",+$G(OLD("DATE"))'=+$G(DGDT) D  Q:'RETURN 0
 . S %=$$CHKDT^DGPMAPI9(.RETURN,+DGDT) Q:'RETURN
 . S %=$$GETLASTM^DGPMAPI8(.LMVT,+OLD("PATIENT"),+DGDT)
 . I +$G(LMVT("MFN"))'=+AFN D  Q
 . . S TXT(1)=$S(LMVT("TYPE")=2:$$EZBLD^DIALOG(4070000.138),LMVT("TYPE")=3:$$EZBLD^DIALOG(4070000.137),1:"")
 . . S RETURN=0,TXT(2)=$$FMTE^XLFDT($P(LMVT("DATE"),U)) D ERRX^DGPMAPIE(.RETURN,"ADMMBBNM",.TXT)
 . S NEW("DATE")=+DGDT
 Q 1
 ;
CHKUPD(RETURN,PARAM,AFN,OLD,NEW,MTYPE) ; Check update
 N %,TXT,DATE,WARD,RPHY,TT,TYPE,AREG
 K RETURN,OLD,NEW S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S %=$$CHKUDT(.RETURN,+AFN,$G(PARAM("DATE")),.OLD,.NEW) Q:'RETURN 0
 S DATE=$S($D(NEW("DATE")):+NEW("DATE"),1:+OLD("DATE"))
 I $G(PARAM("FDEXC"))'="",+$G(PARAM("FDEXC"))'=+OLD("FDEXC") D  Q:'RETURN 0
 . I +$G(PARAM("FDEXC"))'=0&(+$G(PARAM("FDEXC"))'=1) D  Q
 . . S TXT(1)="PARAM(""FDEXC"")",RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT)
 . S NEW("FDEXC")=+PARAM("FDEXC")
 ; admitting regulation
 I $G(PARAM("ADMREG"))'="",+$G(OLD("ADMREG"))'=+$G(PARAM("ADMREG")) D  Q:'RETURN 0
 . S %=$$CHKAREG^DGPMAPI9(.RETURN,$G(PARAM("ADMREG")),"PARAM(""ADMREG"")") Q:'RETURN
 . S NEW("ADMREG")=+PARAM("ADMREG")
 S AREG=$S($D(NEW("ADMREG")):+NEW("ADMREG"),1:+OLD("ADMREG"))
 ; admitting category
 I $G(PARAM("ADMCAT"))'="",+$G(OLD("ADMCAT"))'=+$G(PARAM("ADMCAT")) D  Q:'RETURN 0
 . S %=$$CHKACAT^DGSAAPI(.RETURN,AREG,$G(PARAM("ADMCAT")),"PARAM(""ADMCAT"")") Q:'RETURN
 . S NEW("ADMCAT")=+PARAM("ADMCAT")
 ; type of movement
 I $G(PARAM("TYPE"))'="",+$G(OLD("TYPE"))'=+$G(PARAM("TYPE")) D  Q:'RETURN 0
 . S %=$$CHKATYP^DGPMAPI1(.RETURN,$G(PARAM("TYPE")),+OLD("PATIENT"),+DATE) Q:'%
 . S NEW("TYPE")=+PARAM("TYPE")
 ; transfer facility if type=9
 S TYPE=$S($D(NEW("TYPE")):+NEW("TYPE"),1:+OLD("TYPE"))
 D GETMVTT^DGPMDAL2(.TT,TYPE) S MTYPE=TT(.03,"I")
 I MTYPE=9,$G(OLD("FCTY"))=""!($G(PARAM("FCTY"))&(+$G(OLD("FCTY"))'=+$G(PARAM("FCTY")))) D  Q:'RETURN 0
 . S %=$$CHKFCTY^DGPMAPI6(.RETURN,$G(PARAM("FCTY"))) Q:'%
 . S NEW("FCTY")=+PARAM("FCTY")
 ; short diagnosis
 I $G(PARAM("SHDIAG"))'="",$P($G(OLD("SHDIAG")),U)'=$P($G(PARAM("SHDIAG")),U) D  Q:'RETURN 0
 . I $L($G(PARAM("SHDIAG")))<3!($L($G(PARAM("SHDIAG")))>30) D   Q
 . . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SHDGINV")  Q
 . S NEW("SHDIAG")=PARAM("SHDIAG")
 ; ward
 I $G(PARAM("WARD"))'="",+$G(OLD("WARD"))'=+$G(PARAM("WARD")) D  Q:'RETURN 0
 . S %=$$CHKWARD^DGPMAPI9(.RETURN,$G(PARAM("WARD")),DATE) Q:'%
 . S NEW("WARD")=+PARAM("WARD")
 S WARD=$S($D(NEW("WARD")):+NEW("WARD"),1:+OLD("WARD"))
 ; roombed
 I $G(PARAM("ROOMBED"))'="",$G(PARAM("ROOMBED"))'="^",+$G(OLD("ROOMBED"))'=+$G(PARAM("ROOMBED")) D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI9(.RETURN,PARAM("ROOMBED"),WARD,+OLD("PATIENT"),DATE) Q:'%
 . S NEW("ROOMBED")=+PARAM("ROOMBED")
 ; eligibility
 I $G(PARAM("ELIGIB"))'="",($G(PARAM("ELIGIB"))'="^"),+$G(OLD("ELIGIB"))'=+$G(PARAM("ELIGIB")) D  Q:'RETURN 0
 . S %=$$CHKELIG^DGPMAPI9(.RETURN,+$G(OLD("PATIENT")),$G(PARAM("ELIGIB")))
 . S NEW("ELIGIB")=+PARAM("ELIGIB")
 ;
 I $G(PARAM("ADMSCC"))]"",$G(PARAM("ADMSCC"))'="^",+$G(OLD("ADMSCC"))'=+$G(PARAM("ADMSCC")) D  Q:'RETURN 0
 . S TXT="PARAM(""ADMSCC"")"
 . I $S(+PARAM("ADMSCC")=1:0,$P(PARAM("ADMSCC"),U)=0:0,1:1) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT) Q
 . S NEW("ADMSCC")=+PARAM("ADMSCC")
 ; related physical movement
 S RPHY=$$GETRPHY^DGPMDAL1(AFN)
 N TPAR M TPAR=PARAM S TPAR("DATE")=DATE
 S %=$$CHKUPD^DGPMAPI6(.RETURN,.TPAR,+RPHY,,.NEW) Q:'% 0
 ; PTF
 S %=$$CHKUPTF^DGPMAPI9(.RETURN,.TPAR,+OLD("PTF")) Q:'% 0
 S RETURN=($D(NEW)>0)
 Q 1
 ;
UPDADM(RETURN,PARAM,AFN) ; Update admission
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Optional,Array] Array passed by reference that holds the new data.
 ;      PARAM("DATE") [Optional,DateTime] Admission date
 ;      PARAM("TYPE") [Optional,Numeric] Admission type IEN (pointer to the Facility Movement Type file #405.1)
 ;      PARAM("ADMREG") [Optional,Numeric] Admitting regulation IEN (pointer to the VA Admitting Regulation file #43.4)
 ;      PARAM("ATNDPHY") [Optional,Numeric] Attending physician IEN (pointer to the New Person file #200)
 ;      PARAM("FDEXC") [Optional,Boolean] Patient wants to be excluded or not from Facility Directory.
 ;                                        If it is set to 1 the patient will be excluded from Facility Directory.
 ;      PARAM("FTSPEC") [Optional,Numeric] Facility treating specialty IEN (pointer to the Facility Treating Specialty file #45.7)
 ;      PARAM("SHDIAG") [Optional,String] A brief description of the diagnosis (3-30 chars) 
 ;      PARAM("WARD") [Optional,Numeric] Ward location IEN (pointer to the Ward Location file #42)
 ;      PARAM("ADMSCC") [Optional,Boolean] Set to 1 if patient is admitted for service connected condition. Default: 0
 ;      PARAM("ADMSRC") [Optional,Numeric] Source of admission IEN (pointer to the Source of Admission file #45.1)
 ;      PARAM("ELIGIB") [Optional,Numeric] Admitting eligibility IEN (pointer to the Eligibility Code file #8)
 ;      PARAM("PRYMPHY") [Optional,Numeric] Primary physician IEN (pointer to the New Person file #200)
 ;      PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to the Room-bed file #405.4)
 ;      PARAM("ADMCAT") [Optional,Numeric] Admitting category IEN (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;      PARAM("SCADM") [Optional,Boolean] Set to 1 if this admission is a result of a previously scheduled admission, 0 otherwise. Default: 0.
 ;      PARAM("DIAG") [Optional,Array] Array of detailed diagnosis description.
 ;         PARAM("DIAG",n) [Optional,String] Detailed diagnosis description.
 ;   AFN [Required,Numeric] Admission IEN to update (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 N %,OLD,NEW,DFN,MTYPE
 K RETURN S RETURN=0
 S %=$$CHKUPD(.RETURN,.PARAM,.AFN,.OLD,.NEW,.MTYPE)
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 S DFN=$P(OLD("PATIENT"),U)
 S %=$$LOCKMVT^DGPMAPI9(.RETURN,DFN) Q:'RETURN 0
 S %=$$UPD(.RETURN,.PARAM,AFN,.OLD,.NEW,1,.MTYPE)
 S %=$$UPDPAT^DGPMAPI9(,.PARAM,DFN,,1)
 D EVT(DFN,+AFN,1)
 D ULOCKMVT^DGPMAPI9(DFN)
 Q 1
UPD(RETURN,PARAM,AFN,OLD,NEW,QUIET,MTYPE) ; Update admission
 N %,MVT,RPHY,DGQUIET
 S:$G(QUIET) DGQUIET=1 K RETURN S RETURN=0
 S RPHY=$$GETRPHY^DGPMDAL1(AFN)
 D INITEVT^DGPMDAL1
 D SETAEVT^DGPMDAL1(AFN,RPHY,"P")
 S:$D(NEW("DATE")) MVT(.01)=+NEW("DATE")
 S:$D(NEW("FDEXC")) MVT(41)=+NEW("FDEXC")
 S:$D(NEW("ADMREG")) MVT(.12)=+NEW("ADMREG")
 S:$D(NEW("ADMCAT")) MVT(54)=+NEW("ADMCAT")
 S:$D(NEW("ADMSCC")) MVT(.11)=+NEW("ADMSCC")
 S:$D(NEW("TYPE")) MVT(.04)=+NEW("TYPE")
 S:$D(NEW("FCTY")) MVT(.05)=+NEW("FCTY")
 S:$D(NEW("SHDIAG")) MVT(.1)=NEW("SHDIAG")
 S:$D(NEW("WARD")) MVT(.06)=+NEW("WARD"),MVT(.07)=""
 S:$D(NEW("ROOMBED")) MVT(.07)=+NEW("ROOMBED")
 D UPDMVT^DGPMDAL1(.RETURN,.MVT,AFN)
 S %=$$UPD^DGPMAPI6(.RETURN,.PARAM,RPHY,.OLD,.NEW)
 S %=$$UPDPTF^DGPMAPI9(.RETURN,.PARAM,$P(OLD("PTF"),U))
 D SETAEVT^DGPMDAL1(AFN,RPHY,"A")
 S RETURN=1
 Q 1
 ;
CHKATYP(RETURN,TYPE,DFN,DATE) ; Check admission type
 N %,TMP,TXT,ADTYP,ERR K RETURN S RETURN=0
 S %=$$CHKTYPE^DGPMAPI9(.RETURN,TYPE,+DFN,+DATE,.TMP) Q:'RETURN 0
 S RETURN=0
 S %=$$LSTADTYP^DGPMAPI7(.ADTYP,TMP(.01,"E"),,,+DFN)
 S TXT(1)=TMP(.01,"E"),TXT(2)=$$LOW^XLFSTR($$EZBLD^DIALOG(4070000.011))
 I $G(TMP(.04,"I"))'=1 D ERRX^DGPMAPIE(.RETURN,"MVTTINAC",.TXT) Q 0
 I +$G(ADTYP(0))=0 D ERRX^DGPMAPIE(.RETURN,"ADMINVAT",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
CHKASRC(RETURN,ADMSRC) ; Check admission source
 N TMP K RETURN S RETURN=0
 D GETADMS^DGPMDAL2(.TMP,+$G(ADMSRC))
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"ASRCNFND") Q 0
 S RETURN=1
 Q 1
 ;
