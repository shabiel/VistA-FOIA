DGPMAPI8 ;RGI/VSL - PATIENT MOVEMENT API; 8/26/13
 ;;5.3;Registration;**260005**;
GETLASTM(RETURN,DFN,DGDT,ADT) ; Get last patient movement
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("MFN") [Numeric] last movement IEN (pointer to the Patient Movement file #405)
 ;      RETURN("MTYPE") [String] movement_type_IEN^movement_type_name (pointer to the Facility Movement Type file #405.1)
 ;      RETURN("TYPE") [Numeric] transaction type IEN (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("DATE") [DateTime] last movement date
 ;      RETURN("MASTYPE") [Numeric] MAS movement type IEN (pointer to the MAS Movement Type file #405.2)
 ;      RETURN("WARD") [Numeric] ward IEN (pointer to the Ward Location file #42)
 ;      RETURN("ROOMBED") [Numeric] bed IEN (pointer to the Room-bed file #405.4)
 ;      RETURN("PRYMPHY") [Numeric] primary physician IEN (pointer to the New Person file #200)
 ;      RETURN("FTSPEC") [Numeric] facility treating specialty IEN (pointer to the Facility Treating Specialty file #45.7)
 ;      RETURN("ADMIFN") [Numeric] related admission IEN (pointer to the Patient Movement file #405)
 ;      RETURN("ADMDT") [DateTime] related admission date (pointer to the Patient Movement file #405)
 ;      RETURN("DISIFN") [Numeric] related discharge IEN (pointer to the Patient Movement file #405)
 ;      RETURN("DISDT") [DateTime] related discharge date (pointer to the Patient Movement file #405)
 ;      RETURN("DISTYPE") [String] discharge type IEN (pointer to the Facility Movement Type file #405.1)
 ;      RETURN("ATNDPHY") [Numeric] attending physician IEN (pointer to the New Person file #200)
 ;      RETURN("FDEXC") [Boolean] facility directory exclusion
 ;      RETURN("SERILL") [String] patient_condition_code^patient_condition_name
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;   DGDT [Optional,DateTime] Get last movement on specified date. Default is current date.
 ;Output:
 ;  1=Success,0=Failure
 N %,DGDT1,LMVT,MVT,FLDS,ADM,RPM,PAT
 K RETURN S RETURN=0
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 S %=$$VALDT^DGPMAPI9(.RETURN,.DGDT,"DGDT") Q:'RETURN 0
 I '$D(DGDT) D NOW^%DTC S DGDT=%
 S DGDT1=9999999.999999-DGDT
 D GETLASTM^DGPMDAL1(.LMVT,+DFN,DGDT1,.ADT)
 Q:LMVT(1)'>0 1
 D GETPAT^DGPMDAL2(.PAT,+DFN,"401.3")
 S RETURN("SERILL")=PAT(401.3,"I")_U_PAT(401.3,"E")
 D GETMVT^DGPMDAL1(.MVT,+LMVT(1),".04")
 S RETURN("MTYPE")=MVT(.04,"I")_U_MVT(.04,"E")
 S RETURN("MFN")=LMVT(1)
 S RETURN("TYPE")=LMVT(2)
 S RETURN("DATE")=LMVT(3)
 S RETURN("MASTYPE")=LMVT(4)
 S RETURN("WARD")=LMVT(5)
 S RETURN("ROOMBED")=LMVT(6)
 S RETURN("PRYMPHY")=LMVT(7)
 S RETURN("FTSPEC")=LMVT(8)
 S RETURN("ADMIFN")=LMVT(13)
 S RETURN("ADMDT")=LMVT(13,1)
 S RETURN("DISIFN")=LMVT(17)
 D GETMVT^DGPMDAL1(.MVT,+LMVT(17),".01;.04")
 I LMVT(17)'=LMVT(1) D
 . S RETURN("DISDT")=$G(MVT(.01,"I"))
 S:LMVT(17)=LMVT(1) RETURN("DISDT")=LMVT(3)
 S RETURN("DISTYPE")=$G(MVT(.04,"E"))
 S RETURN("ATNDPHY")=LMVT(18)
 S RETURN("FDEXC")=LMVT(19,1)
 S RETURN=1
 Q 1
 ;
GETPAT(RETURN,DFN) ; Get patient
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] patient name
 ;      RETURN("SEX") [String] patient sex code (M:MALE, F:FEMALE)
 ;      RETURN("DOB") [DateTime] date of birth
 ;      RETURN("MSTAT") [Numeric] marital status IEN (pointer to the Marital Status file #11)
 ;      RETURN("RELPREF") [Numeric] religious preference IEN (pointer to the Religion file #13)
 ;      RETURN("MEANST") [Numeric] current means test status IEN (pointer to file 408.32)
 ;      RETURN("DTHDT") [DateTime] date of death
 ;      RETURN("ELIG") [Numeric] primary eligibility code IEN (pointer to the Eligibility Code file #8)
 ;      RETURN("ESTAT") [String] eligibility status code (P:PENDING VERIFICATION, R:PENDING RE-VERIFICATION, V:VERIFIED)
 ;      RETURN("POFSRV") [Numeric] period of service IEN (pointer to the Period of Service file #21)
 ;      RETURN("SRILL") [String] condition code (S:SERIOUSLY ILL)
 ;      RETURN("WARD") [String] ward location name
 ;   DFN [Required,Numeric] Patient IEN (pointer to the Patient file #2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,PAT,%
 S FLDS=".01;.02;.03;.05;.08;.14;.351;.361;.3611;.323;401.3;.1"
 S NAMES="NAME;SEX;DOB;MSTAT;RELPREF;MEANST;DTHDT;ELIG;ESTAT;POFSRV;SRILL;WARD"
 S %=$$CHKPAT^DGPMAPI9(.RETURN,$G(DFN),"DFN") Q:'RETURN 0
 D GETPAT^DGPMDAL2(.PAT,+DFN,FLDS)
 D BUILD(.RETURN,.PAT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETADM(RETURN,AFN) ; Get admission
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("DATE") [String] admission_date_internal^admission_date_external
 ;      RETURN("TTYPE") [String] transaction_type_IEN^transaction_type_name (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("PATIENT") [String] patient_IEN^patient_name (pointer to the Patient file #2)
 ;      RETURN("TYPE") [String] admission_type_IEN^admission_type_name (pointer to the Facility Movement Type file #405.1)
 ;      RETURN("FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN("WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN("ROOMBED") [String] bed_IEN^bed_name (pointer to the Room-bed file #405.4)
 ;      RETURN("SHDIAG") [String] diagnosis
 ;      RETURN("ADMSCC") [String] admitted_for_sc_condition_code^admitted_for_sc_condition_name
 ;      RETURN("ADMREG") [String] admitting_regulation_IEN^admitting_regulation_name (pointer to the VA Admitting Regulation file #43.4)
 ;      RETURN("DISCH") [String] related_discharge_IEN^discharge_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("MASTYPE") [String] MAS_movement_type_IEN^MAS_movement_type_name (pointer to the MAS Movement Type file #405.2)
 ;      RETURN("ASIHTRA") [String] related_ASIH_transfer_IEN^transfer_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("LDGRSN") [String] reason_for_lodging_IEN^reason_for_lodging_name (pointer to the Lodging Reason file #406.41)
 ;      RETURN("LDGCOMM") [String] lodging comments
 ;      RETURN("LDGDISP") [String] lodging_disposition_code^lodging_disposition_name
 ;      RETURN("FDEXC") [String] facility_directory_exclusion_code^facility_directory_exclusion_name
 ;      RETURN("PRYMPHY") [String] primary_physician_IEN^primary_physician_name (pointer to the New Person file #200)
 ;      RETURN("FTSPEC") [String] facility_treating_specialty_IEN^facility_treating_specialty_name (pointer to the Facility Treating Specialty file #45.7)
 ;      RETURN("ATNDPHY") [String] attending_physician_IEN^attending_physician_name (pointer to the New Person file #200)
 ;      RETURN("SERILL") [String] patient_condition_code^patient_condition_name
 ;      RETURN("ADMSRC") [String] source_of_admission_IEN^source_of_admission_name (pointer to the Source of Admission file #45.1)
 ;      RETURN("ELIGIB") [String] admitting_eligibility_IEN^admitting_eligibility_name (pointer to the Eligibility Code file #8)
 ;      RETURN("ADMCAT") [String] admitting_category_IEN^admitting_category_name (pointer to the Sharing Agreement Sub-category file #35.2)
 ;      RETURN("DIAG",#) [Array] Array of detailed diagnosis description.
 ;         RETURN("DIAG",n) [String] diagnosis description
 ;   AFN [Required,Numeric] Admission IEN (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,RPHY,RPHYMVT,DIAG,PTF,PAT,TXT
 S FLDS=".01;.02;.03;.04;.05;.06;.07;.1;.11;.12;.17;.18;.21;30.01;30.02;30.03;41;.16;54"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;SHDIAG;ADMSCC;ADMREG;DISCH;MASTYPE;ASIHTRA;LDGRSN;LDGCOMM;LDGDISP;FDEXC;PTF;ADMCAT"
 I '$G(AFN) S RETURN=0,TXT(1)="AFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVT^DGPMDAL1(.MVT,+$G(AFN),FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"ADMNFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 I MVT(.02,"I")=4 S RETURN=1 Q 1
 D GETPTF^DGPMDAL1(.PTF,+RETURN("PTF"),"20;20.1")
 S RETURN("ADMSRC")=PTF(20,"I")_U_PTF(20,"E")
 S RETURN("ELIGIB")=PTF(20.1,"I")_U_PTF(20.1,"E")
 D GETPAT^DGPMDAL2(.PAT,+RETURN("PATIENT"),"401.3")
 S RETURN("SERILL")=PAT(401.3,"I")_U_PAT(401.3,"E")
 S FLDS=".08;.09;.19"
 S NAMES="PRYMPHY;FTSPEC;ATNDPHY"
 S RPHY=$$GETRPHY^DGPMDAL1(AFN)
 D GETMVT^DGPMDAL1(.RPHYMVT,RPHY,FLDS)
 D GETDIAG^DGPMDAL2(.DIAG,RPHY)
 M RETURN("DIAG")=DIAG(99)
 D BUILD(.RETURN,.RPHYMVT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETTRA(RETURN,TFN) ; Get transfer
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("DATE") [String] transfer_date_internal^transfer_date_external
 ;      RETURN("TTYPE") [String] transaction_type_IEN^transaction_type_name (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("PATIENT") [String] patient_IEN^patient_name (pointer to the Patient file #2)
 ;      RETURN("TYPE") [String] transfer_type_IEN^transfer_type_name (pointer to the Facility Movement Type file #405.1)
 ;      RETURN("FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN("WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN("ROOMBED") [String] bed_IEN^bed_name (pointer to the Room-bed file #405.4)
 ;      RETURN("RABSDT") [String] absence_return_date_internal^absence_return_date_date_external
 ;      RETURN("ADMIFN") [String] related_admission_IEN^admission_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("MASTYPE") [String] MAS_movement_type_IEN^MAS_movement_type_name (pointer to the MAS Movement Type file #405.2)
 ;   TFN [Required,Numeric] Transfer IEN (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,RPHY,RPHYMVT,DIAG,PAT,TXT
 S FLDS=".01;.02;.03;.04;.05;.06;.07;.13;.14;.18;"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;RABSDT;ADMIFN;MASTYPE;"
 I '$G(TFN) S RETURN=0,TXT(1)="TFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVT^DGPMDAL1(.MVT,+$G(TFN),FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"TRANFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 D GETPAT^DGPMDAL2(.PAT,+RETURN("PATIENT"),"401.3")
 S RETURN("SERILL")=PAT(401.3,"I")_U_PAT(401.3,"E")
 S FLDS=".08;.09;.19"
 S NAMES="PRYMPHY;FTSPEC;ATNDPHY"
 S RPHY=$$GETRPHY^DGPMDAL1(+TFN)
 I $G(RPHY)>0 D
 . D GETMVT^DGPMDAL1(.RPHYMVT,RPHY,FLDS)
 . D GETDIAG^DGPMDAL2(.DIAG,RPHY)
 . M RETURN("DIAG")=DIAG(99)
 . D BUILD(.RETURN,.RPHYMVT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETMVT(RETURN,MFN) ; Get movement
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("DATE") [String] movement_date_internal^movement_date_external
 ;      RETURN("TTYPE") [String] transaction_type_IEN^transaction_type_name (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("PATIENT") [String] patient_IEN^patient_name (pointer to the Patient file #2)
 ;      RETURN("TYPE") [String] movement_type_IEN^movement_type_name (pointer to the Facility Movement Type file #405.1)
 ;      RETURN("FCTY") [String] transfer_facility_IEN^transfer_facility_name (pointer to the Institution file #4)
 ;      RETURN("WARD") [String] ward_IEN^ward_name (pointer to the Ward Location file #42)
 ;      RETURN("ROOMBED") [String] bed_IEN^bed_name (pointer to the Room-bed file #405.4)
 ;      RETURN("PRYMPHY") [String] primary_physician_IEN^primary_physician_name (pointer to the New Person file #200)
 ;      RETURN("FTSPEC") [String] facility_treating_specialty_IEN^facility_treating_specialty_name (pointer to the Facility Treating Specialty file #45.7)
 ;      RETURN("SHDIAG") [String] diagnosis
 ;      RETURN("ADMIFN") [String] related_admission_IEN^admission_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("DISCH") [String] related_discharge_IEN^discharge_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("MASTYPE") [String] MAS_movement_type_IEN^MAS_movement_type_name (pointer to the MAS Movement Type file #405.2)
 ;      RETURN("ATNDPHY") [String] attending_physician_IEN^attending_physician_name (pointer to the New Person file #200)
 ;      RETURN("RPM") [String] related_physical_movement_IEN^related_physical_movement_date_external (pointer to the Patient Movement file #405)
 ;      RETURN("LDGRSN") [String] reason_for_lodging_IEN^reason_for_lodging_name (pointer to the Lodging Reason file #406.41)
 ;      RETURN("LDGCOMM") [String] lodging comments
 ;      RETURN("LDGDISP") [String] lodging_disposition_code^lodging_disposition_name
 ;   MFN [Required,Numeric] Movement IEN (pointer to the Patient Movement file #405)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,RPHY,RPHYMVT,DIAG,TXT
 S FLDS=".01;.02;.03;.04;.05;.06;.07;.08;.09;.1;.14;.17;.18;.19;.24;30.01;30.02;30.03;"
 S NAMES="DATE;TTYPE;PATIENT;TYPE;FCTY;WARD;ROOMBED;PRYMPHY;FTSPEC;"
 S NAMES=NAMES_"SHDIAG;ADMIFN;DISCH;MASTYPE;ATNDPHY;RPM;LDGRSN;LDGCOMM;LDGDISP;"
 I '$G(MFN) S RETURN=0,TXT(1)="MFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVT^DGPMDAL1(.MVT,+MFN,FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTNFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 D GETDIAG^DGPMDAL2(.DIAG,MFN)
 M:$D(DIAG(99)) RETURN("DIAG")=DIAG(99)
 S RETURN=1
 Q 1
 ;
GETMVTT(RETURN,IFN) ; Get movement type
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] movement type name
 ;      RETURN("TTYPE") [Numeric] transaction type IEN (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("MAS") [Numeric] MAS movement type IEN (pointer to the MAS Movement Type file #405.2)
 ;      RETURN("STAT") [Boolean] movement type status
 ;      RETURN("ASKSPEC") [Boolean] ask specialty at movement
 ;   IFN [Required,Numeric] Movement type IEN (pointer to the Facility Movement Type file #405.1)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,RPHY,RPHYMVT,TXT
 S FLDS=".01;.02;.03;.04;.05;.07;"
 S NAMES="NAME;TTYPE;MAS;STAT;ASKSPEC;PNAME"
 I '$G(IFN) S RETURN=0,TXT(1)="IFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMVTT^DGPMDAL2(.MVT,+$G(IFN),FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTTNFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETPSRV(RETURN,IFN) ; Get period of service
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] period of service name
 ;      RETURN("ABV") [String] period of service abbreviation
 ;      RETURN("CODE") [String] period of service code
 ;      RETURN("BEGDT") [DateTime] period of service begining date
 ;      RETURN("ENDDT") [DateTime] period of service ending date
 ;   IFN [Required,Numeric] period of service IEN (pointer to the Period of Service file #21)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,RPHY,RPHYMVT,TXT
 S FLDS=".01;.02;.03;.04;.05;"
 S NAMES="NAME;ABV;CODE;BEGDT;ENDDT"
 I '$G(IFN) S RETURN=0,TXT(1)="IFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETPSRV^DGPMDAL2(.MVT,+$G(IFN),FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"PSRVNFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETMASMT(RETURN,IFN) ; Get MAS movement type
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] MAS movement type name
 ;      RETURN("TTYPE") [Numeric] transaction type IEN (pointer to the MAS Movement Transaction Type file #405.3)
 ;      RETURN("ASKSPEC") [Boolean] ask specialty at movement?
 ;      RETURN("ASKFTY") [Boolean] ask facility at movement?
 ;      RETURN("ABS") [Boolean] is this movement an absence?
 ;      RETURN("CFADM") [Boolean] can movement follow admission?
 ;      RETURN("ASIH") [Boolean] ASIH movement?
 ;   IFN [Required,Numeric] MAS movement type IEN (pointer to the MAS Movement Type file #405.2)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,MVT,TXT
 S FLDS=".01;.02;.05;.06;50.01;50.02;50.03;"
 S NAMES="NAME;TTYPE;ASKSPEC;ASKFTY;ABS;CFADM;ASIH"
 I '$G(IFN) S RETURN=0,TXT(1)="IFN" D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 D GETMASMT^DGPMDAL2(.MVT,+$G(IFN),FLDS)
 I MVT=0 S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"MVTTNFND") Q 0
 D BUILD(.RETURN,.MVT,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
GETAREG(RETURN,IFN) ; Get admitting regulation
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("IEN") [Numeric] admitting regulation IEN
 ;      RETURN("NAME") [String] admitting regulation name
 ;      RETURN("STATUS") [String] admitting regulation status (internal^external format)
 ;   IFN [Required,Numeric] admitting regulation IEN (pointer to the VA Admitting Regulation file #43.4)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N FLDS,NAMES,AREG
 S FLDS=".001;.01;4;"
 S NAMES="IEN;NAME;STATUS"
 I '$$CHKAREG^DGPMAPI9(.RETURN,.IFN,"IFN",1) Q 0
 D GETAREG^DGPMDAL2(.AREG,+$G(IFN),FLDS)
 D BUILD(.RETURN,.AREG,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
BUILD(RETURN,REC,FLDS,NAMES) ; 
 N IND,NAME
 F IND=0:0 S IND=$O(REC(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND)
 . S RETURN(NAME)=REC(IND,"I")_$S(REC(IND,"I")=REC(IND,"E"):"",1:U_REC(IND,"E"))
 Q
GETWARD(RETURN,IFN) ; Get ward
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] ward name
 ;      RETURN("BED") [String] bedsection of this ward
 ;      RETURN("SERVICE") [String] ward service code (M:MEDICINE, S:SURGERY, P:PSYCHIATRY, NH:NHCU, 
 ;                                 NE:NEUROLOGY, I:INTERMEDIATE MED, R:REHAB MEDICINE, SCI:SPINAL CORD INJURY,
 ;                                 D:DOMICILIARY, B:BLIND REHAB, NC:NON-COUNT)
 ;      RETURN("SRILL") [Boolean] seriously ill (1:INCLUDE ON SERIOUSLY ILL LIST)
 ;      RETURN("SPCTY") [Numeric] specialty IEN (pointer to the Specialty file #42.4)
 ;   IFN [Required,Numeric] Ward IEN (pointer to the Ward Location file #42)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN N IND,NAME,FLDS,NAMES,WARD
 S FLDS=".01;.02;.03;.09;.017;"
 S NAMES="NAME;BED;SERVICE;SRILL;SPCTY"
 I '$G(IFN) S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","IFN") Q 0
 D GETWARD^DGPMDAL2(.WARD,+$G(IFN),FLDS)
 I WARD=0 M RETURN=WARD S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"WRDNFND") Q 0
 D BUILD(.RETURN,.WARD,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
