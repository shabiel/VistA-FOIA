DGPMAPI7 ;RGI/VSL - PATIENT MOVEMENT API; 8/28/13
 ;;5.3;Registration;**260005**;
LSTADSRC(RETURN,SEARCH,START,NUMBER) ; Get sources of admission
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] source of admission IEN (pointer to the Source of Admission file #45.1)
 ;      RETURN(#,"CODE") [String] source of admission code
 ;      RETURN(#,"NAME") [String] source of admission name
 ;      RETURN(#,"PLACE") [String] source of admission place (internal format^external format)
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADREG
 S FLDS=".01;2;11IE"
 S NAMES="CODE;NAME;PLACE;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTADSRC^DGPMDAL2(.ADREG,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST^DGPMAPI9(.RETURN,.ADREG,FLDS,NAMES)
 Q 1
 ;
LSTCOTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get check-out types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] check-out type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"NAME") [String] check-out type name
 ;      RETURN(#,"TYPE") [String] transaction_type_IEN^transaction_type_name
 ;      RETURN(#,"STATUS") [String] check-out_type_status_code^dispaly_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get check-out types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Check-out IEN (pointer to the Patient Movement file #405). Get allowed check-out types for an existing check-out.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP^DGPMAPI9(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,5,.MFN) Q:'% 0
 Q 1
 ;
LSTCITYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get check-in types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] check-in type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"NAME") [String] check-in type name
 ;      RETURN(#,"TYPE") [String] transaction_type_IEN^transaction_type_name
 ;      RETURN(#,"STATUS") [String] check-in_type_status_code^dispaly_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get check-in types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Check-in IEN (pointer to the Patient Movement file #405). Get allowed check-in types for an existing check-in.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP^DGPMAPI9(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,4,.MFN) Q:'% 0
 Q 1
 ;
LSTADTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get admission types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] admission type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"NAME") [String] admission type name
 ;      RETURN(#,"TYPE") [String] transaction_type_IEN^transaction_type_name
 ;      RETURN(#,"STATUS") [String] admission_type_status_code^dispaly_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get admission types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Admission IEN (pointer to the Patient Movement file #405). Get allowed admission types for an existing admission.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP^DGPMAPI9(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,1,.MFN) Q:'% 0
 Q 1
 ;
LSTTRTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get transfer types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] transfer type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"NAME") [String] transfer type name
 ;      RETURN(#,"TYPE") [String] transaction_type_IEN^transaction_type_name
 ;      RETURN(#,"STATUS") [String] transfer_type_status_code^dispaly_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get transfer types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Transfer IEN (pointer to the Patient Movement file #405). Get allowed transfer types for an existing transfer.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP^DGPMAPI9(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,2,.MFN) Q:'% 0
 Q 1
 ;
LSTDTYP(RETURN,SEARCH,START,NUMBER,DFN,DGDT,MFN) ; Get discharge types
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] discharge type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN(#,"NAME") [String] discharge type name
 ;      RETURN(#,"TYPE") [String] transaction_type_IEN^transaction_type_name
 ;      RETURN(#,"STATUS") [String] discharge_type_status_code^dispaly_name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get discharge types on specified date. Default is current date.
 ;   MFN [Optional,Numeric] Discharge IEN (pointer to the Patient Movement file #405). Get allowed discharge types for an existing discharge.
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$BLDTYP^DGPMAPI9(.RETURN,.SEARCH,.START,.NUMBER,.DFN,.DGDT,3,.MFN) Q:'% 0
 Q 1
 ;
LSTFCTY(RETURN,SEARCH,START,NUMBER) ; Get transfer facilities
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] transfer facility IEN (pointer to the Institution file #4)
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
 D BLDLST^DGPMAPI9(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTLRSN(RETURN,SEARCH,START,NUMBER) ; Get reasons for lodging
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] reason for lodging IEN (pointer to the Lodging Reason file #406.41)
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
 D BLDLST^DGPMAPI9(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
LSTWARD(RETURN,SEARCH,START,NUMBER) ; Get wards
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [String] ward IEN (pointer to the Ward Location file #42)
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
 D BLDLST^DGPMAPI9(.RETURN,.WRD,FLDS,NAMES)
 Q 1
 ;
LSTWBED(RETURN,SEARCH,START,NUMBER,WARD,DFN) ; Get available beds
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] bed IEN (pointer to the Room-bed file #405.4)
 ;      RETURN(#,"NAME") [String] bed name
 ;      RETURN(#,"DESC") [String] bed description
 ;      RETURN(#,"OOS") [Boolean] out of service flag (0 - active, 1 - inactive)
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;   WARD [Required,Numeric] Ward IEN (pointer to the Ward Location file #42). Get available beds on which.
 ;   DFN [Optional,Numeric] Patient IEN (pointer to the Patient file #2)
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,BED,OCB,TMP,TBED,CNT,J,I,OCUP,TMP,TXT,%
 K RETURN S RETURN=0 S FLDS=".01;.02;.2;"
 I '$G(WARD) S TXT(1)="WARD" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETWARD^DGPMDAL2(.TMP,+WARD,".01;400;200*")
 I TMP=0 D ERRX^DGPMAPIE(.RETURN,"WRDNFND") Q 0
 I $G(DFN)'="" S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S NAMES="NAME;DESC;OOS"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTWBED^DGPMDAL2(.BED,.SEARCH,.START,.NUMBER,FLDS,+$G(WARD),.DFN)
 D BLDLST^DGPMAPI9(.RETURN,.BED,FLDS,NAMES)
 Q 1
 ;
LSTTPATS(RETURN,SEARCH,START,NUMBER) ; Get transferable patients by name
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
 D LSTPATS^DGPMDAL2(.LST,$$UP^XLFSTR(SEARCH),.START,NUMBER,1)
 D BLDPAT^DGPMAPI9(.RETURN,.LST)
 S RETURN=1
 Q 1
 ;
LSTPADMS(RETURN,DFN) ; Get patient admissions.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI9 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to the Room-bed file #405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN(#,"DISCH") [Numeric] discharge IEN (pointer to the Patient Movement file #405)
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADM,%
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.17I;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;DISCH;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,1,FLDS)
 D BLDLST^DGPMAPI9(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPTRAN(RETURN,DFN,AFN) ; Get patient transfers related to an admission.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI9 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to the Room-bed file #405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN(#,"RABSDT") [String] absence_return_date^absence_return_date
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   AFN [Required,Numeric] Admission IEN (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 I '$G(AFN) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","AFN") Q 0
 S %=$$GETADM^DGPMAPI8(.OLD,+$G(AFN))
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.13IE;.18IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;RABSDT;MASTYPE"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,2,FLDS,+AFN)
 D BLDLST^DGPMAPI9(.RETURN,.ADM,FLDS,NAMES,1)
 Q 1
 ;
LSTPFTS(RETURN,DFN,AFN) ; Get patient treating specialty transfers related to an admission.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI9 for the general movement format.
 ;      RETURN(#,"ATNDPHY") [String] attending_physician_IEN^attender_physician_name (pointer to the New Person file #200)
 ;      RETURN(#,"PRYMPHY") [String] primary_physician_IEN^primary_physician_name (pointer to the New Person file #200)
 ;      RETURN(#,"FTSPEC") [String] facility_treating_specialty_IEN^facility_treating_specialty_name (pointer to the Facility Treating Specialty file #45.7)
 ;      RETURN(#,"DIAG",#) [Array] Array of detailed diagnosis description.
 ;         RETURN(#,"DIAG",n) [String] diagnosis description
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   AFN [Required,Numeric] Admission IEN (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N %,FLDS,NAMES,ADM,LMVT,OLD,I
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN)) Q:'RETURN 0
 I '$G(AFN) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","AFN") Q 0
 S %=$$GETADM^DGPMAPI8(.OLD,+AFN)
 I OLD=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.08IE;.09IE;.18IE;.19IE"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;PRYMPHY;FTSPEC;MASTYPE;ATNDPHY"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,6,FLDS,+AFN)
 D BLDLST^DGPMAPI9(.RETURN,.ADM,FLDS,NAMES,1)
 F I=0:0 S I=$O(RETURN(I)) Q:'I  D
 . S %=$$GETMVT^DGPMAPI8(.OLD,+RETURN(I,"ID"))
 . M RETURN(I,"DIAG")=OLD("DIAG")
 Q 1
 ;
LSTPLDGI(RETURN,DFN) ; Get patient lodger check-in.
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      see BLDLST^DGPMAPI9 for the general movement format.
 ;      RETURN(#,"WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN(#,"ROOMBED") [String] bed_IEN^bed_name ((pointer to the Room-bed file #405.4)
 ;      RETURN(#,"FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN(#,"LDGRSN") [String] reason_for_check-in_IEN^reason_for_check-in_name (pointer to the Lodging Reason file #406.41)
 ;      RETURN(#,"LDGCOMM") [String] additional comment
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,ADM,%
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN)) Q:'RETURN 0
 S FLDS=".01IE;.02I;.03IE;.04IE;.05IE;.06IE;.07IE;.17I;.18IE;30.01IE;30.02;"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;DISCH;MASTYPE;LDGRSN;LDGCOMM"
 D LSTPMVT^DGPMDAL2(.ADM,+DFN,4,FLDS)
 D BLDLST^DGPMAPI9(.RETURN,.ADM,FLDS,NAMES,1)
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
