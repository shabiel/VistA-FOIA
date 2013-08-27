DGPMAPI9 ;RGI/VSL - PATIENT MOVEMENT API; 8/26/13
 ;;5.3;Registration;**260005**;
LOCKMVT(RETURN,DFN) ; Lock movement
 N % K RETURN S RETURN=0
 S %=$$CHKPAT^DGPMAPI9(.RETURN,.DFN) Q:'RETURN 0
 S RETURN=$$LOCKMVT^DGPMDAL1(+DFN) I RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 Q RETURN
 ;
ULOCKMVT(DFN) ; Unlock patient movements
 Q:'+$G(DFN)
 D ULOCKMVT^DGPMDAL1(+DFN)
 Q
LSTPROV(RETURN,SEARCH,START,NUMBER,DGDT) ; Get active providers
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] provider IEN (pointer to the New Person file #200)
 ;      RETURN(#,"NAME") [String] provider name
 ;      RETURN(#,"INITIAL") [String] provider initials
 ;      RETURN(#,"TITLE") [String] provider title
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DGDT [Optional,DateTime] Get active providers on specified date. Default is current date.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,PROV,%
 K RETURN S FLDS=".01;1;8;"
 S %=$$VALDT^DGPMAPI9(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S NAMES="NAME;INITIAL;TITLE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTPROV^DGPMDAL2(.PROV,.SEARCH,.START,.NUMBER,FLDS,.DGDT)
 D BLDLST^DGPMAPI9(.RETURN,.PROV,FLDS,NAMES)
 Q 1
 ;
LSTADREG(RETURN,SEARCH,START,NUMBER) ; Get admitting regulations
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] admitting regulation IEN (pointer to the VA Admitting Regulation file #43.4)
 ;      RETURN(#,"NAME") [String] admitting regulation name
 ;      RETURN(#,"CFR") [String] admitting regulation code
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,ADREG
 K RETURN S FLDS=".01;2;"
 S NAMES="NAME;CFR;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTADREG^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST^DGPMAPI9(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTFTS(RETURN,SEARCH,START,NUMBER,DGDT) ; Get active facility treating specialties
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] facility treating specialty IEN (pointer to the Facility Treating Specialty file #45.7)
 ;      RETURN(#,"NAME") [String] facility treating specialty name
 ;      RETURN(#,"SPEC") [String] specialty_IEN^specialty_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DGDT [Optional,DateTime] Get active facility treating specialties on specified date. Default is current date.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,ADREG,%
 K RETURN S FLDS=".01;1IE;"
 S %=$$VALDT^DGPMAPI9(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S:'$G(DGDT) DGDT=$$NOW^XLFDT()
 S NAMES="NAME;SPEC;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTFTS^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS,DGDT)
 D BLDLST^DGPMAPI9(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
ABS(RETURN,PARAM,LMVT) ; Absence transfer
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new transfer IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;    If movement type is: FROM UNAUTHORIZED ABSENCE, FROM AUTHORIZED ABSENCE or FROM AUTH. ABSENCE OF 96 HOURS OR LESS:
 ;      PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to the Room-bed file #405.4)
 ;      PARAM("FTSPEC") [Optional,Numeric] Facility treating specialty IEN (pointer to the Facility Treating Specialty file #45.7)
 ;      PARAM("ATNDPHY") [Optional,Numeric] Attending physician IEN (pointer to the New Person file #200)
 ;      PARAM("PRYMPHY") [Optional,Numeric] Primary physician IEN (pointer to the New Person file #200)
 ;      PARAM("DIAG") [Optional,Array] Array of detailed diagnosis description.
 ;         PARAM("DIAG",n) [Optional,String] Detailed diagnosis description.
 ;    If movement type is: AUTHORIZED ABSENCE, UNAUTHORIZED ABSENCE or AUTH ABSENCE 96 HOURS OR LESS:
 ;      PARAM("RABSDT") [Optional,DateTime] Absence return date
 ;Output:
 ;  1=Success,0=Failure
 N TFN
 S PARAM("WARD")=$G(LMVT("WARD"))
 S PARAM("ADMIFN")=$G(LMVT("ADMIFN"))
 S TFN=$$ADDTRA^DGPMAPI2(.RETURN,.PARAM)
 D SETTEVT^DGPMDAL1(TFN,,"A")
 S RETURN=+TFN
 Q 1
 ;
ASIHOF(RETURN,PARAM) ; ASIH (Other facility) transfer
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new transfer IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("FCTY") [Required,Numeric] Transfer facility (pointer to the Institution file #4)
 ;Output:
 ;  1=Success,0=Failure
 N %,TFN,LMVT
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 S PARAM("WARD")=+$G(LMVT("WARD"))
 S TFN=$$ADDTRA^DGPMAPI2(.RETURN,.PARAM)
 S %=$$ASHODIS(.RETURN,.PARAM)
 D SETTEVT^DGPMDAL1(TFN,,"A")
 S RETURN=TFN
 Q 1
 ;
ASHODIS(RETURN,PARAM) ;
 N %,DIS M DIS=PARAM
 S DIS("TYPE")=34 K DIS("FCTY")
 S DIS("DATE")=$$FMADD^XLFDT(+PARAM("DATE"),30)
 S %=$$ADDDIS^DGPMAPI3(.RETURN,.DIS,+PARAM("PATIENT"),34)
 D SETDEVT^DGPMDAL1(+RETURN,"A")
 Q 1
 ;
CHKUPTF(RETURN,PARAM,PFN,OLD,NEW) ;
 N %
 D GETPTF^DGPMDAL1(.OLD,PFN,"20;20.1;")
 I $G(PARAM("ADMSRC"))'="",+PARAM("ADMSRC")'=+OLD(20,"I") D  Q:'RETURN 0
 . S %=$$CHKASRC^DGPMAPI1(.RETURN,$G(PARAM("ADMSRC"))) Q:'RETURN
 . S NEW(20)=+PARAM("ADMSRC")
 S RETURN=1
 Q 1
 ;
UPDPTF(RETURN,PARAM,PFN) ; Update ptf
 N %,PTF,OLD,NEW K RETURN
 S %=$$CHKUPTF(.RETURN,.PARAM,+PFN,.OLD,.NEW) Q:'% 0
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 ; source of admission
 S:$D(NEW(20)) PTF(20)=NEW(20)
 S PTF(20.1)=$S($G(PARAM("ELIGIB")):PARAM("ELIGIB"),1:0) ; eligibility
 D UPDPTF^DGPMDAL1(,.PTF,PFN)
 Q 1
 ;
CHKELIG(RETURN,DFN,ELIG) ; Check patient eligibility
 N %,LST,FND,IND K RETURN
 S RETURN=0
 I '$G(ELIG) D ERRX^DGPMAPIE(.RETURN,"INVPARM","ELIG") Q 0
 S %=$$LSTPELIG^DGPMAPI9(.LST,+DFN)
 I +ELIG=+LST("PELIG") S RETURN=1
 F IND=0:0 S IND=$O(LST(IND)) Q:'IND  D
 . I +ELIG=+LST(IND) S RETURN=1
 I 'RETURN D ERRX^DGPMAPIE(.RETURN,"PATENFND")
 Q RETURN
 ;
LSTPELIG(RETURN,DFN) ; Get patient eligibility codes
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [Numeric] # of entries found
 ;      RETURN("PELIG") [String] primary_eligibility_IEN^primary_eligibility_name (pointer to the Eligibility Code file #8)
 ;      RETURN(#) [String] eligibility_IEN^eligibility_name (pointer to the Eligibility Code file #8)
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;Output:
 ;  1=Success,0=Failure
 N %,IND,VAEL,CNT K RETURN S CNT=0
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 D GETEL^DGUTL3(+DFN)
 S:VAEL(1)'="" RETURN("PELIG")=VAEL(1)
 F IND=0:0 S IND=$O(VAEL(1,IND)) Q:'IND  D
 . S CNT=CNT+1
 . S RETURN(CNT)=VAEL(1,IND)
 S RETURN(0)=CNT
 Q 1
 ;
GETPMVT(RETURN,AFN,DGDT,MFN) ; Get prior movement
 N MVT,FLDS,NAMES,PMVT,ID
 K RETURN S RETURN=0
 S FLDS=".01;.02;.03;.04;.06;.07;.1;.11;.12;.15;.17;.18;41;.16;54"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;WARD;ROOMBED;SHDIAG;ADMSCC;ADMREG;ASIH;DISCH;MASTYPE;FDEXC;PTF;ADMCAT"
 D GETMVT^DGPMDAL1(.MVT,+$G(AFN),FLDS) Q:MVT=0 0
 D GETPMVT^DGPMDAL3(.PMVT,MVT(.03,"I"),+AFN,.DGDT,.MFN,FLDS)
 I PMVT=0 M RETURN=PMVT Q 0
 S ID=PMVT("ID") K PMVT("ID")
 D BUILD^DGPMAPI8(.RETURN,.PMVT,FLDS,NAMES)
 S RETURN("ID")=ID
 S RETURN=1
 Q 1
GETNMVT(RETURN,AFN,DGDT,MFN) ; Get next movement
 N MVT,FLDS,NAMES,NMVT,ID
 K RETURN S RETURN=0
 S FLDS=".01;.02;.03;.04;.06;.07;.1;.11;.12;.17;.18;41;.16;54"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;WARD;ROOMBED;SHDIAG;ADMSCC;ADMREG;DISCH;MASTYPE;FDEXC;PTF;ADMCAT"
 D GETMVT^DGPMDAL1(.MVT,+$G(AFN),FLDS) Q MVT=0
 D GETNMVT^DGPMDAL3(.NMVT,MVT(.03,"I"),+AFN,.DGDT,.MFN,FLDS)
 I NMVT=0 M RETURN=NMVT Q 0
 S ID=NMVT("ID") K NMVT("ID")
 D BUILD^DGPMAPI8(.RETURN,.NMVT,FLDS,NAMES)
 S RETURN("ID")=ID
 S RETURN=1
 Q 1
 ;
CHKWARD(RETURN,WARD,DATE) ; Check ward
 N TMP,TXT K RETURN S RETURN=0
 I $G(WARD)="" S TXT(1)="PARAM(""WARD"")" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETWARD^DGPMDAL2(.TMP,+WARD,".01;400;200*")
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"WRDNFND") Q 0
 I TMP=1,TMP(400,"I")="" D ERRX^DGPMAPIE(.RETURN,"WRDINVGL",.TXT) Q 0
 I TMP=1,$D(TMP("OOS")),'$$ISWRDACT^DGPMAPI9(.TMP,+DATE) D ERRX^DGPMAPIE(.RETURN,"WRDINACT") Q 0
 S RETURN=1
 Q 1
 ;
CHKBED(RETURN,BED,WARD,DFN,DATE) ; Check bed
 N TMP,TXT K RETURN S RETURN=0
 D GETWARD^DGPMDAL2(.TMP,+$G(WARD),".01;")
 N ERR,WN S WN=$G(TMP(.01,"E")) K TMP
 D GETBED^DGPMDAL2(.TMP,+$G(BED),".01;.2;100*;200*")
 I TMP=0 S ERR=1 D ERRX^DGPMAPIE(.RETURN,"BEDNFND",.TXT) Q 0
 N I,WF S I="",WF=0
 F  S I=$O(TMP("W",I)) Q:I=""  S:TMP("W",I,.01,"I")=+$G(WARD) WF=1
 I 'WF S ERR=1,TXT(1)=WN,TXT(2)=TMP(.01,"E") D ERRX^DGPMAPIE(.RETURN,"WRDCNASB",.TXT) Q 0
 I $D(TMP("OOS")),'$$ISBEDACT^DGPMAPI9(.TMP,+$G(DATE)) S ERR=1 D ERRX^DGPMAPIE(.RETURN,"BEDINACT",.TXT) Q 0
 I $$ISBEDOCC^DGPMAPI9(+$G(BED),+$G(DFN)) S ERR=1 D ERRX^DGPMAPIE(.RETURN,"BEDOCC") Q 0
 S RETURN=1
 Q 1
 ;
CHKTYPE(RETURN,TYPE,DFN,DATE,MVT) ; Check type
 N TXT,ADTYP,ERR,TXT K RETURN S RETURN=0
 I '$G(TYPE) S TXT(1)="PARAM(""TYPE"")" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVTT^DGPMDAL2(.MVT,+TYPE)
 I MVT=0 D ERRX^DGPMAPIE(.RETURN,"MVTTNFND") Q 0
 S RETURN=1
 Q 1
 ;
CHKPAT(RETURN,DFN,PARN) ; Check patient
 N TMP,TXT K RETURN S RETURN=0
 S TXT(1)=$S($G(PARN)="":"PARAM(""PATIENT"")",1:PARN)
 I '$G(DFN) D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETPAT^DGPMDAL2(.TMP,+DFN)
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"PATNFND") Q 0
 S RETURN=1
 Q 1
 ;
CHKAREG(RETURN,ADMREG,NAME,ALL) ; Check admitting regulation
 N TMP,TXT K RETURN S RETURN=0
 I '$G(ADMREG) S TXT(1)=$G(NAME) D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETAREG^DGPMDAL2(.TMP,+ADMREG)
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"AREGNFND") Q 0
 I '$G(ALL),$G(TMP(4,"I"))=1 S TXT(1)=TMP(.01,"E") D ERRX^DGPMAPIE(.RETURN,"AREGINAC",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
CHKREG(RETURN,PARAM,DFN,MAS) ;
 N %
 ; ward
 S %=$$CHKWARD^DGPMAPI9(.RETURN,$G(PARAM("WARD")),+PARAM("DATE")) Q:'RETURN 0
 ; roombed
 I $G(PARAM("ROOMBED"))'="" D  Q:'RETURN 0
 . S %=$$CHKBED^DGPMAPI9(.RETURN,+PARAM("ROOMBED"),+PARAM("WARD"),DFN,+PARAM("DATE"))
 ; related physical movement
 I MAS(.05,"I"),$D(PARAM("FTSPEC"))!$D(PARAM("ATNDPHY")) D  Q:'% 0
 . S %=$$CHKADD^DGPMAPI6(.RETURN,.PARAM)
 Q 1
 ;
CHKDT(RETURN,DATE) ; Check movement date
 N TXT,%DT,X,Y
 K RETURN S RETURN=1,TXT(1)="PARAM(""DATE"")"
 I $G(DATE)=""!(+$G(DATE)<1800000) S RETURN=0
 S X=DATE,%DT="SXT",%DT(0)="-NOW" D ^%DT
 I $S('Y:1,Y'?7N1".".N:1,1:0) S RETURN=0
 I RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
VALDT(RETURN,DATE,PAR,REQ) ; Valid date
 N TXT,%DT,X,Y
 K RETURN S RETURN=1,TXT(1)=$G(PAR)
 I $G(DATE)="",'$G(REQ) Q 1
 I $G(DATE)=""!(+$G(DATE)<1800000) S RETURN=0
 S X=DATE,%DT="SXT" D ^%DT
 I $S('Y:1,Y'>0:1,1:0) S RETURN=0
 I RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 S RETURN=1
 Q 1
 ;
ISBEDOCC(BED,DFN) ; Is bed occupied?
 N BEDS,TMP,OCC,I
 S I=0,OCC=0
 D LSTOCBED^DGPMDAL2(.TMP)
 M BEDS=TMP("DILIST","ID")
 F  S I=$O(BEDS(I)) Q:'I!OCC  D
 . I BEDS(I,.07)=BED&(BEDS(I,.03)'=DFN) S OCC=1 Q
 Q OCC
 ;
ISFTSACT(FTS,DGDT) ; Is facility treating specialty active on date?
 I $D(FTS)=1 D GETFTS^DGPMDAL2(.FTS,FTS,".01;100*")
 N I,ACT,OUT,D0,D1
 S OUT=0,I=0,ACT=1,D0=$S($D(DGDT):DGDT,1:DT),D0=$P(D0,".")
 F  S I=$O(FTS("E",I)) Q:'I!(OUT)  D
 . S D1=FTS("E",I,.01,"I")
 . I D0<D1 S OUT=1 Q
 . S ACT=FTS("E",I,.02,"I")
 Q ACT
 ;
ISBEDACT(BED,DGDT) ; Is bed active on date?
 I $D(BED)=1 D GETBED^DGPMDAL2(.BED,BED,".01;.2;100*;200*")
 N I,ACT,D0,D1,D2
 S I=0,ACT=1,D0=$S($D(DGDT):DGDT,1:DT),D0=$P(D0,".")
 F  S I=$O(BED("OOS",I)) Q:'I!('ACT)  D
 . S D1=BED("OOS",I,.01,"I")
 . S D2=BED("OOS",I,.04,"I")
 . I $S(D1<D0:1,D1=D0:1,1:0)&$S(D2="":1,D0<D2:1,1:0) S ACT=0 Q
 Q ACT
 ;
ISWRDACT(WARD,DGDT) ; Is ward active on date?
 I $D(WARD)=1 D GETWARD^DGPMDAL2(.WARD,WARD,".01;400;200*")
 N I,ACT,D0,D1,D2
 S I=0,ACT=1,D0=$S($D(DGDT):DGDT,1:DT),D0=$P(D0,".")
 F  S I=$O(WARD("OOS",I)) Q:'I!('ACT)  D
 . I 'WARD("OOS",I,.06,"I") Q
 . S D1=WARD("OOS",I,.01,"I")
 . S D2=WARD("OOS",I,.04,"I")
 . I $S(D1<D0:1,D1=D0:1,1:0)&$S(D2="":1,D0<D2:1,1:0) S ACT=0 Q
 Q ACT
 ;
BLDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,TYP,MFN) ; Build movement types
 N TXT,WHEN,%,OLD K RETURN S RETURN=0
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S %=$$VALDT^DGPMAPI9(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 I $G(MFN)'="" D  Q:'RETURN 0
 . I '+$G(MFN) S RETURN=0,TXT(1)="MFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q
 . D GETMVT^DGPMDAL1(.OLD,+$G(MFN))
 . I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND")
 N FLDS,NAMES,TYPES,PAR
 K RETURN S FLDS=".01;.02IE;.04IE",WHEN=$S('$G(DGDT):$$NOW^XLFDT(),1:+DGDT)
 S NAMES="NAME;TYPE;STATUS",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTMVTT^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS,TYP,+DFN,.WHEN)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
BLDPAT(RETURN,LST) ;
 K RETURN N DL,IN,DG
 S RETURN(0)=LST("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . D SENS^DGSEC4(.DG,LST(DL,2,IN),DUZ)
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=LST(DL,2,IN)
 . S RETURN(IN,"NAME")=LST(DL,"ID",IN,".01")
 . S RETURN(IN,"BIRTH")=$S(DG(1)=2:"*SENSITIVE*",1:LST(DL,"ID",IN,".03"))
 . S RETURN(IN,"SSN")=$S(DG(1)=2:"*SENSITIVE*",1:LST(DL,"ID",IN,".09"))
 . S RETURN(IN,"TYPE")=LST(DL,"ID",IN,"391")
 . S RETURN(IN,"VETERAN")=LST(DL,"ID",IN,"1901")
 Q
 ;
BLDLST(RETURN,LST,FLDS,NAMES,DESC) ; Build list 
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [Numeric] number of movements found
 ;      RETURN(#,"ID") [Numeric] movement IEN (pointer to the Patient Movement file #405)
 ;      RETURN(#,"DATE") [String] internal_movement_date^external_movement_date
 ;      RETURN(#,"TTYPE") [Numeric] transaction type IEN (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN(#,"PATIENT") [String] patient_IEN^patient_name (pointer to the Patient file #2)
 ;      RETURN(#,"TYPE") [String] movement_type_IEN^movement_type_name (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"MASTYPE") [String] MAS_movement_type_IEN^MAS_movement_type_name (pointer to the MAS Movement Type file #405.2)
 ;Output:
 ;  1=Success,0=Failure
 N IND,FLD,NAME,D1,D2,ID,REV,CNT
 S D1="DILIST",D2="ID",CNT=0
 S RETURN(0)=$G(LST("DILIST",0))
 S IND=$S($G(DESC):9999999,1:0),REV=$S($G(DESC):-1,1:1)
 F  S IND=$O(LST(D1,2,IND),REV) Q:IND=""  D
 . S CNT=CNT+1
 . S ID=LST("DILIST",2,IND)
 . S RETURN(CNT,"ID")=ID
 . F FLD=0:0 S FLD=$O(LST(D1,D2,IND,FLD)) Q:FLD=""  D
 . . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,FLD)
 . . I $D(LST(D1,D2,IND,FLD,"I"))!$D(LST(D1,D2,IND,FLD,"E")) D
 . . . S RETURN(CNT,NAME)=$G(LST(D1,D2,IND,FLD,"I"))_U_$G(LST(D1,D2,IND,FLD,"E")) Q
 . . E  S RETURN(CNT,NAME)=$G(LST(D1,D2,IND,FLD))
 S RETURN=1
 Q
 ;
MVTEVT(DFN,TYPE,MFN,QUIET,QUE) ; Movement events
 N DGPMDA,DGPMA,DGPMP,DGPMT,DGQUIET,DGNEW,DGPM0,DA,ZTQUEUED
 S:$G(QUE) ZTQUEUED=1
 D START^DGPWB(+DFN)
 D EN^DGPMVBM
 S DGPM0="",DA=+MFN,DFN=+DFN
 S DGPMA=$$GETMVT0^DGPMDAL1(MFN)
 S DGPMDA=MFN,DGPMP="",DGPMT=TYPE S:$G(QUIET) DGQUIET=1 ;$S($G(QUIET):0,1:1)
 S:TYPE=1 DGNEW=1
 D ^DGPMEVT
 Q
 ;
UPDPAT(RETURN,PARAM,DFN,MFN,QUIET) ; Update patient
 N DA,DGQUIET S DA=$G(MFN)
 S:$G(QUIET) DGQUIET=1
 D RESET^DGPMDDCN
 Q 1
 ;
LSTCOPAT(RETURN,SEARCH,START,NUMBER) ; Get checked-in patients by name
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] patient IEN (pointer to the Patient file #2)
 ;      RETURN(#,"NAME") [String] patient name
 ;      RETURN(#,"BIRTH") [String] patient birth date
 ;      RETURN(#,"SSN") [String] patient SSN
 ;      RETURN(#,"TYPE") [String] patient type
 ;      RETURN(#,"VETERAN") [Boolean] patient veteran status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N LST
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH="" S:'$G(NUMBER) NUMBER=""
 K RETURN S RETURN=0
 D LSTPATS^DGPMDAL2(.LST,$$UP^XLFSTR(SEARCH),.START,NUMBER,4)
 D BLDPAT^DGPMAPI9(.RETURN,.LST)
 S RETURN=1
 Q 1
 ;
