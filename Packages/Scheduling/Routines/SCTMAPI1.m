SCTMAPI1 ;RGI/VSL - TEAM API; 9/17/13
 ;;5.3;scheduling;**260003**;08/13/93
LSTATMS(RETURN,SEARCH,START,NUMBER) ; Get active teams
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields except 'IEN' are returned in internal^external format.
 ;    RETURN [Numeric] # of entries found
 ;    RETURN(#,"ID") [Numeric] Team IEN
 ;    RETURN(#,"NAME") [String] Team name
 ;   SEARCH [Optional,String] Partial match restriction. Default: All entries
 ;    SEARCH(0) [Optional,Boolean] If 1 returns only primary care positions.
 ;   START [Optional,Numeric] The team position name from which to begin the list. Default: ""
 ;   NUMBER [Optional,Numeric] Number of entries to return. Default: All entries
 ;Output:
 ;  1=Success,0=Failure
 N %,LST,TMP,CNT,IND
 K RETURN
 S:$L($G(SEARCH))=0 SEARCH=""
 D LSTTMS^SCTMDAL1(.LST,.SEARCH,.START,$G(NUMBER))
 D BLDLST^SDMAPI(.TMP,.LST)
 S CNT=0
 F IND=0:0 S IND=$O(TMP(IND)) Q:IND=""  D
 . N HIS
 . D GETTMH^SCTMDAL1(.HIS,TMP(IND,"ID"),1)
 . Q:'$D(HIS)
 . Q:'HIS(.03)
 . Q:HIS(.02)>DT
 . S CNT=CNT+1
 . M RETURN(CNT)=TMP(IND)
 S RETURN=1,RETURN(0)=CNT
 Q 1
 ;
LSTAPOS(RETURN,SEARCH,START,NUMBER) ; Get active practitioners
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields except 'IEN' are returned in internal^external format.
 ;    RETURN [Numeric] # of entries found
 ;    RETURN(#,"ID") [Numeric] Team position IEN
 ;    RETURN(#,"CLINIC") [Numeric] Associated clinic IEN
 ;    RETURN(#,"NAME") [String] Team position name
 ;    RETURN(#,"TEAM") [String] Team name
 ;    RETURN(#,"USER") [String] Practitioner IEN
 ;   SEARCH [Optional,String] Partial match restriction. Default: All entries
 ;    SEARCH(0) [Optional,Numeric] Team IEN
 ;    SEARCH(1) [Optional,Boolean] If 1 returns only primary care positions.
 ;   START [Optional,Numeric] The team position name from which to begin the list. Default: ""
 ;   NUMBER [Optional,Numeric] Number of entries to return. Default: All entries
 ;Output:
 ;  1=Success,0=Failure
 N LST,TMP,CNT,IND,FLDS,%
 K RETURN
 S:$L($G(SEARCH))=0 SEARCH=""
 D LSTPOS^SCTMDAL1(.LST,.SEARCH,.START,$G(NUMBER),"@;.01;.02;.09I")
 S FLDS(.02)="TEAM",FLDS(.09)="CLINIC"
 D BLDLST^SDMAPI(.TMP,.LST,.FLDS)
 S CNT=0
 F IND=0:0 S IND=$O(TMP(IND)) Q:IND=""  D
 . N PO,POH,POAH
 . D GETTMPO^SCTMDAL1(.PO,TMP(IND,"ID"),1)
 . Q:$S($G(SEARCH(0))="":0,PO(.02)'=$G(SEARCH(0)):1,1:0)
 . Q:($D(SEARCH(1)))&(PO(.04)'=$G(SEARCH(1)))
 . D GETTMPOH^SCTMDAL1(.POH,+TMP(IND,"ID"),1)
 . Q:'$D(POH)
 . Q:'POH(.04)
 . Q:POH(.02)>DT
 . S CNT=CNT+1
 . D GETPOASH^SCTMDAL1(.POAH,TMP(IND,"ID"),,1)
 . I $D(POAH) S RETURN(CNT,"USER")=POAH(.03)
 . M RETURN(CNT)=TMP(IND)
 S RETURN=1,RETURN(0)=CNT
 Q 1
 ;
GETEAM(RETURN,SCTM) ; Get team
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields returned in internal^external format.
 ;    RETURN("AUTO-ASSIGN FROM ASSC CLINICS?") [Boolean] Autoassign patients from associated clinics
 ;    RETURN("CAN ACT AS A PC TEAM?") [Boolean] Can act as primary care team for a patient
 ;    RETURN("CLOSE TO FURTHER ASSIGNMENT?") [Boolean] Indicates if team can be assigned additional patients
 ;    RETURN("CURRENT # OF PATIENTS") [Numeric] # of patients currently assigned to this team
 ;    RETURN("CURRENT ACTIVATION DATE") [DateTime] Activation date
 ;    RETURN("CURRENT EFFECTIVE DATE") [DateTime] The most recent date that the status has changed
 ;    RETURN("CURRENT INACTIVATION DATE") [DateTime] Inactivation date as of today
 ;    RETURN("CURRENT STATUS") [String] Status (Active, Inactive)
 ;    RETURN("DEFAULT TEAM PRINTER") [Numeric] Printer IEN (pointer to DEVICE file)
 ;    RETURN("DESCRIPTION") [String] Team description
 ;    RETURN("DISCHARGE FROM ASSOC. CLINICS?") [Boolean] Auto discharge from team when discharge from associated clinic?
 ;    RETURN("INSTITUTION") [Numeric] Site IEN (pointer to INSTITUTION file)
 ;    RETURN("MAX % OF PRIMARY CARE PATIENTS") [Numeric] Maximum percentage of patients that this team should be assigned
 ;    RETURN("MAX NUMBER OF PATIENTS") [Numeric] Maximum allowable number of patients for this team
 ;    RETURN("NAME") [String] Team name
 ;    RETURN("RESTRICT CONSULTS?") [Boolean] Prevents making consult appointments to clinics in which the patient is not enrolled
 ;    RETURN("SERVICE/DEPARTMENT") [Numeric] Service/Section IEN (pointer to SERVICE/SECTION file)
 ;    RETURN("TEAM PHONE NUMBER") [String] Phone
 ;    RETURN("TEAM PURPOSE") [Numeric] Primary role of team (pointer to TEAM PURPOSE file)
 ;   SCTM [Required,Numeric] Team IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN S RETURN=0
 I '+$G(SCTM) D ERRX^SDAPIE(.RETURN,"INVPARAM","SCTM") Q 0
 I '$$TEAMEXST^SCTMDAL1(+SCTM) D ERRX^SDAPIE(.RETURN,"TEAMNFND") Q 0
 D GETEAM^SCTMDAL1(.RETURN,+SCTM,1,1,1)
 S RETURN=1
 Q 1
 ;
GETEAMPO(RETURN,SCTMPO) ; Get team position
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields returned in internal^external format.
 ;    RETURN("ASSOCIATED CLINIC") [Numeric] Associated clinic IEN (pointer to HOSPITAL LOCATION file)
 ;    RETURN("BEEPER NUMBER") [String] Pager/beeper number
 ;    RETURN("CAN ACT AS PRECEPTOR?") [Boolean] Set to 1 if this position may be used as a preceptor position
 ;    RETURN("CONSULT MESSAGE") [String] For which patients team receives messages related to patient activity in clinics in which he is not enrolled
 ;    RETURN("CURRENT # OF PATIENTS") [Numeric] # of all patients associated with the team
 ;    RETURN("CURRENT # OF PC PATIENTS") [Numeic] # of primary care patients
 ;    RETURN("CURRENT ACTIVATION DATE") [DateTime] Activation date as of today
 ;    RETURN("CURRENT EFFECTIVE DATE") [DateTime] Effective date as of today
 ;    RETURN("CURRENT INACTIVATION DATE") [DateTime] Inactivation date as of today
 ;    RETURN("CURRENT STATUS") [String] Status (Active, Inactive)
 ;    RETURN("DEATH MESSAGE") [String] For which patients team receives messages related to patient's death
 ;    RETURN("FUTURE # OF PATIENTS")- [Numeric] # of current and future assignments
 ;    RETURN("FUTURE # OF PC PATIENTS") [Numeric] # of current and future patient care assignments
 ;    RETURN("INPATIENT MESSAGE") [String] For which patients team receives messages related to inpatient activity
 ;    RETURN("MAX NUMBER OF PATIENTS") [Numeric] Maximum nuber of patients that can be assigned to this position
 ;    RETURN("POSITION")="OIF OEF CLINICAL CASE MANAGER^OIF OEF CLINICAL CASE MANAGER"
 ;    RETURN("POSITION DESCRIPTION") [String] Description
 ;    RETURN("POSSIBLE PRIMARY PRACTITIONER?") [Boolean] If 1 this position may be used as preceptor for the team
 ;    RETURN("PRECEPTOR CONSULT MESSAGE") [Boolean] 1 sends a message to preceptor on consult activity
 ;    RETURN("PRECEPTOR DEATH MESSAGE") [Boolean] 1 sends a message to preceptor on a death entry
 ;    RETURN("PRECEPTOR INPATIENT MESSAGE") [Boolean] 1 sends a message to preceptor on inpatient activity
 ;    RETURN("PRECEPTOR TEAM MESSAGE") [Boolean] 1 sends a message to preceptor on team activity
 ;    RETURN("STANDARD ROLE NAME") [Numeric] Standard role IEN (pointer to ROLE POSITION file)
 ;    RETURN("TEAM") [Numeric] Team IEN (pointer to TEAM file)
 ;    RETURN("TEAM MESSAGE") [String] For which patients team receives messages related to team activity
 ;    RETURN("USER CLASS") [Numeric] Pointer to USR CLASS file
 ;   SCTMPO [Required,Numeric] Team position IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN S RETURN=0
 I '+$G(SCTMPO) D ERRX^SDAPIE(.RETURN,"INVPARAM","SCTMPO") Q 0
 I '$$TMPOEXST^SCTMDAL1(+SCTMPO) D ERRX^SDAPIE(.RETURN,"TMPONFND") Q 0
 D GETEAMPO^SCTMDAL1(.RETURN,+SCTMPO,1,1,1)
 S RETURN=1
 Q 1
 ;
