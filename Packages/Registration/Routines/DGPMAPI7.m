DGPMAPI7 ;RGI/VSL - PATIENT MOVEMENT API; 5/27/13
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
LSTPROV(RETURN,SEARCH,START,NUMBER,DGDT) ; Get active providers
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] provider IEN
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
 S %=$$VALDT^DGPMAPI8(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S NAMES="NAME;INITIAL;TITLE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTPROV^DGPMDAL2(.PROV,.SEARCH,.START,.NUMBER,FLDS,.DGDT)
 D BLDLST(.RETURN,.PROV,FLDS,NAMES)
 Q 1
 ;
LSTADREG(RETURN,SEARCH,START,NUMBER) ; Get admitting regulations
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] admitting regulation IEN
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
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTFTS(RETURN,SEARCH,START,NUMBER,DGDT) ; Get active facility treating specialties
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] facility treating specialty IEN
 ;      RETURN(#,"NAME") [String] facility treating specialty name
 ;      RETURN(#,"SPEC") [String] specialty
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DGDT [Optional,DateTime] Get active facility treating specialties on specified date. Default is current date.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,ADREG,%
 K RETURN S FLDS=".01;1;"
 S %=$$VALDT^DGPMAPI8(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 S:'$G(DGDT) DGDT=$$NOW^XLFDT()
 S NAMES="NAME;SPEC;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTFTS^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS,DGDT)
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTADSRC(RETURN,SEARCH,START,NUMBER) ; Get sources of admission
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] source of admission IEN
 ;      RETURN(#,"CODE") [String] source of admission code
 ;      RETURN(#,"NAME") [String] source of admission name
 ;      RETURN(#,"PLACE") [String] source of admission place
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADREG
 S FLDS=".01;2;11"
 S NAMES="CODE;NAME;PLACE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTADSRC^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTCOTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get check-out types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] check-out type IEN
 ;      RETURN(#,"NAME") [String] check-out type name
 ;      RETURN(#,"TYPE") [String] transaction type
 ;      RETURN(#,"STATUS") [String] check-out type status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   DGDT [Optional,DateTime] Get check-out types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Check-out IEN (pointer to file 405). Get allowed check-out types for an existing check-out.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,5,.MFN) Q:'% 0
 Q 1
 ;
LSTCITYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get check-in types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] check-in type IEN
 ;      RETURN(#,"NAME") [String] check-in type name
 ;      RETURN(#,"TYPE") [String] transaction type
 ;      RETURN(#,"STATUS") [String] check-in type status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   DGDT [Optional,DateTime] Get check-in types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Check-in IEN (pointer to file 405). Get allowed check-in types for an existing check-in.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,4,.MFN) Q:'% 0
 Q 1
 ;
LSTADTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get admission types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] admission type IEN
 ;      RETURN(#,"NAME") [String] admission type name
 ;      RETURN(#,"TYPE") [String] transaction type
 ;      RETURN(#,"STATUS") [String] admission type status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   DGDT [Optional,DateTime] Get admission types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Admission IEN (pointer to file 405). Get allowed admission types for an existing admission.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,1,.MFN) Q:'% 0
 Q 1
 ;
LSTTRTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get transfer types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] transfer type IEN
 ;      RETURN(#,"NAME") [String] transfer type name
 ;      RETURN(#,"TYPE") [String] transaction type
 ;      RETURN(#,"STATUS") [String] transfer type status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   DGDT [Optional,DateTime] Get transfer types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Transfer IEN (pointer to file 405). Get allowed transfer types for an existing transfer.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,2,.MFN) Q:'% 0
 Q 1
 ;
LSTDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get discharge types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] discharge type IEN
 ;      RETURN(#,"NAME") [String] discharge type name
 ;      RETURN(#,"TYPE") [String] transaction type
 ;      RETURN(#,"STATUS") [String] discharge type status
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   DGDT [Optional,DateTime] Get discharge types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Discharge IEN (pointer to file 405). Get allowed discharge types for an existing discharge.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,3,.MFN) Q:'% 0
 Q 1
 ;
BLDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,TYP,MFN) ; Build movement types
 N TXT,WHEN,%,OLD K RETURN S RETURN=0
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
LSTFCTY(RETURN,SEARCH,START,NUMBER) ; Get transfer facilities
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] transfer facility IEN
 ;      RETURN(#,"NAME") [String] transfer facility name
 ;      RETURN(#,"TYPE") [String] transfer facility type
 ;      RETURN(#,"STATE") [String] discharge type state
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,TYPES
 K RETURN S FLDS=".01;.02;13;"
 S NAMES="NAME;STATE;TYPE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTFCTY^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTLRSN(RETURN,SEARCH,START,NUMBER) ; Get reasons for lodging
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] reason for lodging IEN
 ;      RETURN(#,"NAME") [String] reason for lodging name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,TYPES
 K RETURN S FLDS=".01;"
 S NAMES="NAME;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTLRSN^DGPMDAL2(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTWARD(RETURN,SEARCH,START,NUMBER) ; Get wards
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] ward IEN
 ;      RETURN(#,"NAME") [String] ward name
 ;      RETURN(#,"SPEC") [String] specialty_IEN^specialty_name
 ;      RETURN(#,"SERV") [String] service_code^service_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,WRD
 K RETURN S FLDS=".01;.017IE;.03IE;"
 S NAMES="NAME;SPEC;SERV"
 D LSTWARD^DGPMDAL2(.WRD,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST(.RETURN,.WRD,FLDS,NAMES)
 Q 1
 ;
LSTWBED(RETURN,SEARCH,START,NUMBER,WARD,DFN) ; Get available beds
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] bed IEN
 ;      RETURN(#,"NAME") [String] bed name
 ;      RETURN(#,"DESC") [String] bed description
 ;      RETURN(#,"OOS") [Boolean] out of service flag (0 - active, 1 - inactive)
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   WARD [Required,Numeric] Ward IEN (pointer to file 42). Get available beds on which.
 ;   DFN [Optional,Numeric] Patient IEN (pointer to file 2)
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,BED,OCB,TMP,TBED,CNT,J,I,OCUP,TMP,TXT,%
 K RETURN S RETURN=0 S FLDS=".01;.02;.2;"
 I '$G(WARD) S TXT(1)="WARD" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
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
LSTTPATS(RETURN,SEARCH,START,NUMBER) ; Get transferable patients by name
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] patient IEN
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
LSTPADMS(RETURN,DFN) ; Get patient admissions.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI7 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to file 42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to file 405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to file 4)
 ;      RETURN(#,"DISCH") [Numeric] discharge IEN (pointer to file 405)
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADM,%
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.17I;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;DISCH;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,1,FLDS)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPTRAN(RETURN,DFN,AFN) ; Get patient transfers related to an admission.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI7 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to file 42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to file 405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to file 4)
 ;      RETURN(#,"RABSDT") [String] absence_return_date^absence_return_date
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   AFN [Required,Numeric] Admission IEN (pointer to file 405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 I '$G(AFN) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","AFN") Q 0
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.13IE;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;RABSDT;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,2,FLDS,+AFN)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPFTS(RETURN,DFN,AFN) ; Get patient treating specialty transfers related to an admission.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI7 for the general movement format.
 ;      RETURN(#,"ATNDPHY") [String] attending_physician_IEN^attender_physician_name (pointer to file 200)
 ;      RETURN(#,"PRYMPHY") [String] primary_physician_IEN^primary_physician_name (pointer to file 200)
 ;      RETURN(#,"FTSPEC") [String] facility_treating_specialty_IEN^facility_treating_specialty_name (pointer to file 45.7)
 ;      RETURN(#,"DIAG",#) [Array] Array of detailed diagnosis description.
 ;         RETURN(#,"DIAG",n) [String] diagnosis description
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   AFN [Required,Numeric] Admission IEN (pointer to file 405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD,I
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 I '$G(AFN) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","AFN") Q 0
 S %=$$GETADM^DGPMAPI8(.OLD,+AFN)
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.08IE;.09IE;.18IE;.19IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;PRYMPHY;FTSPEC;MASTYPE;ATNDPHY"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,6,FLDS,+AFN)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 F I=0:0 S I=$O(RETURN(I)) Q:'I  D
 . S %=$$GETMVT^DGPMAPI8(.OLD,+RETURN(I,"ID"))
 . M RETURN(I,"DIAG")=OLD("DIAG")
 Q 1
 ;
LSTPLDGI(RETURN,DFN) ; Get patient lodger check-in.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI7 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to file 42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to file 405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to file 4)
 ;      RETURN(#,"LDGRSN") [String] reason_for_check-in_IEN^reason_for_check-in_name (pointer to file 406.41)
 ;      RETURN(#,"LDGCOMM") [String] additional comment
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADM,%
 S %=$$CHKPAT^DGPMAPI8(.RETURN,$G(DFN)) Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.17I;.18IE;30.01;30.02;"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;DISCH;MASTYPE;LDGRSN;LDGCOMM"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,4,FLDS)
 D BLDLST(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
BLDLST(RETURN,LST,FLDS,NAMES,DESC) ; Build list
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [Numeric] number of movements found
 ;      RETURN(#,"ID") [Numeric] movement IEN (pointer to file 405)
 ;      RETURN(#,"DATE") [String] internal_movement_date^external_movement_date
 ;      RETURN(#,"TTYPE") [Numeric] transaction type IEN (pointer to file 405.3)
 ;      RETURN(#,"PATIENT") [String] patient_IEN^patient_name (pointer to file 2)
 ;      RETURN(#,"TYPE") [String] movement_type_IEN^movement_type_name (pointer to file 405.1)
 ;      RETURN(#,"MASTYPE") [String] MAS_movement_type_IEN^MAS_movement_type_name (pointer to file 405.2)
 ;Output:
 ;  1=Success,0=Failure
 N IND,FLD,NAME,D1,D2,ID,REV,CNT
 S D1="DILIST",D2="ID",CNT=0
 S RETURN(0)=+$G(LST("DILIST",0))
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
LSTLDIS(RETURN) ;List check-out dispositions
 ;Input:
 ;  .RETURN [Required,Array]   Array passed by reference that will receive the data. 
 ;                             Set to Error description if the call fails
 ;        RETURN(0) [Numeric] Number of entries found
 ;        RETURN(#) [String] check-out_disposition_code^check-out_disposition_name
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=1
 D LSTSCOD^SDMDAL(405,30.03,.RETURN)
 Q 1
 ;
