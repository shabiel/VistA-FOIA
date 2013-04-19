DGPMAPI7 ;RGI/VSL - PATIENT MOVEMENT API; 4/18/13
 ;;5.3;Registration;**260005**;
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
 N I,ACT,OUT
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
 N I,ACT
 S I=0,ACT=1,D0=$S($D(DGDT):DGDT,1:DT),D0=$P(D0,".")
 F  S I=$O(WARD("OOS",I)) Q:'I!('ACT)  D
 . I 'WARD("OOS",I,.06,"I") Q
 . S D1=WARD("OOS",I,.01,"I")
 . S D2=WARD("OOS",I,.04,"I")
 . I $S(D1<D0:1,D1=D0:1,1:0)&$S(D2="":1,D0<D2:1,1:0) S ACT=0 Q
 Q ACT
 ;
LSTPROV(RETURN,SEARCH,START,NUMBER,DGDT) ; Return active providers
 N FLDS,NAMES,PROV
 K RETURN S FLDS=".01;1;8;"
 S %=$$VALDT^DGPMAPI8(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S NAMES="NAME;INITIAL;TITLE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTPROV^DGPMDAL2(.PROV,.SEARCH,.START,.NUMBER,FLDS,.DGDT)
 D BLDLST(.RETURN,.PROV,FLDS,NAMES)
 Q 1
 ;
LSTADREG(RETURN,SEARCH,START,NUMBER) ; Return admitting regulations
 N FLDS,NAMES,ADREG
 K RETURN S FLDS=".01;2;"
 S NAMES="NAME;CFR;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTADREG^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTFTS(RETURN,SEARCH,START,NUMBER,DGDT) ; Return facility treating specialties
 N FLDS,NAMES,ADREG
 K RETURN S FLDS=".01;1;"
 S %=$$VALDT^DGPMAPI8(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S:'$G(DGDT) DGDT=$$NOW^XLFDT()
 S NAMES="NAME;SPEC;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTFTS^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS,DGDT)
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTADSRC(RETURN,SEARCH,START,NUMBER) ; Return source of admission
 K RETURN N FLDS,NAMES,ADREG
 S FLDS=".01;2;11"
 S NAMES="CODE;NAME;PLACE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTADSRC^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTCOTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Return check-out types
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,5,.MFN) Q:'% 0
 Q 1
 ;
LSTCITYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Return check-in types
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,4,.MFN) Q:'% 0
 Q 1
 ;
LSTADTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Return admission types
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,1,.MFN) Q:'% 0
 Q 1
 ;
LSTTRTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Return transfer types
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,2,.MFN) Q:'% 0
 Q 1
 ;
LSTDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Return discharge types
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,3,.MFN) Q:'% 0
 Q 1
 ;
BLDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,TYP,MFN) ; Build movement types
 N TXT,WHEN K RETURN S RETURN=0
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S %=$$VALDT^DGPMAPI8(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 I $G(MFN)'="" D  Q:'RETURN 0
 . I '+$G(MFN) S RETURN=0,TXT(1)="MFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q
 . D GETMVT^DGPMDAL1(.OLD,+$G(MFN))
 . I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND")
 N FLDS,NAMES,TYPES,PAR
 K RETURN S FLDS=".01;.02;.04",WHEN=$S('$G(DGDT):$$NOW^XLFDT(),1:+DGDT)
 S NAMES="NAME;TYPE;STATUS",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTMVTT^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS,TYP,+DFN,.WHEN)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTFCTY(RETURN,SEARCH,START,NUMBER) ; Return transfer facilities
 N FLDS,NAMES,TYPES
 K RETURN S FLDS=".01;.02;13;"
 S NAMES="NAME;STATE;TYPE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTFCTY^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTLRSN(RETURN,SEARCH,START,NUMBER) ; Return reasons for lodging
 N FLDS,NAMES,TYPES
 K RETURN S FLDS=".01;"
 S NAMES="NAME;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTLRSN^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTWARD(RETURN,SEARCH,START,NUMBER) ; Return wards
 N FLDS,NAMES,WRD
 K RETURN S FLDS=".01;.017IE;.03IE;"
 S NAMES="NAME;SPEC;SERV"
 D LSTWARD^DGPMDAL2(.WRD,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.WRD,FLDS,NAMES)
 Q 1
 ;
LSTWBED(RETURN,SEARCH,START,NUMBER,WARD,DFN) ; Return beds
 N FLDS,NAMES,BED,OCB,TMP,TBED,CNT,J,I,OCUP,TMP,TXT
 K RETURN S RETURN=0 S FLDS=".01;.02;.2;"
 I $G(WARD)="" S TXT(1)="PARAM('WARD')" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETWARD^DGPMDAL2(.TMP,+WARD,".01;400;200*")
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"WRDNFND") Q 0
 I $G(DFN)'="" S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S NAMES="NAME;DESC;OOS"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTWBED^DGPMDAL2(.BED,.SEARCH,.START,.NUMBER,FLDS,+$G(WARD))
 D BLDLST(.TBED,.BED,FLDS,NAMES)
 D LSTOCBED^DGPMDAL2(.TMP)
 M OCB=TMP("DILIST","ID")
 S CNT=0
 F J=0:0 S J=$O(TBED(J)) Q:J=""  D
 . S OCUP=0
 . F I=0:0 S I=$O(OCB(I)) Q:I=""  D
 . . I TBED(J,"ID")=OCB(I,.07),OCB(I,.03)'=+$G(DFN) S OCUP=1
 . I 'OCUP S CNT=CNT+1 M RETURN(CNT)=TBED(J)
 S RETURN(0)=CNT
 S RETURN=1
 Q 1
 ;
LSTPATS(RETURN,SEARCH,START,NUMBER) ; Get patients by name
 N RET,DL,IN,DG
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 K RETURN S RETURN=0
 D LSTPATS^DGPMDAL2(.RET,$$UP^XLFSTR(SEARCH),.START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . D SENS^DGSEC4(.DG,RET(DL,2,IN),DUZ)
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 . S RETURN(IN,"BIRTH")=$S(DG(1)=2:"*SENSITIVE*",1:RET(DL,"ID",IN,".03"))
 . S RETURN(IN,"SSN")=$S(DG(1)=2:"*SENSITIVE*",1:RET(DL,"ID",IN,".09"))
 . S RETURN(IN,"TYPE")=RET(DL,"ID",IN,"391")
 . S RETURN(IN,"VETERAN")=RET(DL,"ID",IN,"1901")
 S RETURN=1
 Q 1
 ;
LSTTPATS(RETURN,SEARCH,START,NUMBER) ; Get transferable patients by name
 N LST
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH="" S:'$G(NUMBER) NUMBER=""
 K RETURN S RETURN=0
 D LSTPATS^DGPMDAL2(.LST,$$UP^XLFSTR(SEARCH),.START,NUMBER,1)
 D BLDPAT^DGPMAPI7(.RETURN,.LST)
 S RETURN=1
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
LSTPADMS(RETURN,DFN) ; Returns patient admissions.
 K RETURN N FLDS,NAMES,ADM
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.08IE;.09IE;.1;.17I;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;PRYMPHY;FTSPEC;SHDIAG;DISCH;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,1,FLDS)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPTRAN(RETURN,DFN,AFN) ; Returns patient transfers.
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.06IE;.07IE;.08IE;.09IE;.1;.17I;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;WARD;ROOMBED;PRYMPHY;FTSPEC;SHDIAG;DISCH;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,2,FLDS,+AFN)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPFTS(RETURN,DFN,AFN) ; Returns patient FTS.
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.06IE;.07IE;.08IE;.09IE;.1;.17I;.18IE;.19IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;WARD;ROOMBED;PRYMPHY;FTSPEC;SHDIAG;DISCH;MASTYPE;ATNDPHY"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,6,FLDS,+AFN)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 M RETURN($O(RETURN(0)),"DIAG")=OLD("DIAG")
 Q 1
 ;
LSTPLDGI(RETURN,DFN) ; Returns patient lodger check-in.
 K RETURN N FLDS,NAMES,ADM
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.08IE;.09IE;.1;.17I;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;PRYMPHY;FTSPEC;SHDIAG;DISCH;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,4,FLDS)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
BLDLST(RETURN,LST,FLDS,NAMES,DESC) ; Build list
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
MVTEVT(DFN,TYPE,MFN,QUIET) ; Movement events
 N DGPMDA,DGPMA,DGPMP,DGPMT,DGQUIET,DGNEW,DGPM0
 D START^DGPWB(+DFN)
 D EN^DGPMVBM
 S DGPM0="",DA=+MFN,DFN=+DFN
 S DGPMA=$$GETMVT0^DGPMDAL1(MFN)
 S DGPMDA=MFN,DGPMP="",DGPMT=TYPE S:$G(QUIET) DGQUIET=1 ;$S($G(QUIET):0,1:1)
 S:TYPE=1 DGNEW=1
 D ^DGPMEVT
 Q
 ;
UPDPAT(RETURN,PARAM,DFN,MFN) ; Update patient
 S DA=$G(MFN)
 D RESET^DGPMDDCN
 Q 1
 ;
LSTLDIS(RETURN) ;List check-out dispositions
 K RETURN
 S RETURN=1
 D LSTSCOD^SDMDAL(405,30.03,.RETURN)
 Q 1
 ;
