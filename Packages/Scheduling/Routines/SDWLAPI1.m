SDWLAPI1 ;RGI/CBR - WAIT LIST API; 3/29/13
 ;;5.3;scheduling;**260003**;08/13/93
LOCK(RETURN,IEN) ; Lock specified wait list
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   IEN [Required,Numeric] Wait list IEN (pointer to file 409.3)
 ;Output:
 ;  1=Success,0=Failure
 S RETURN=0
 I '+$G(IEN) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","IEN")
 S RETURN=$$LOCK^SDWLDAL(IEN)
 Q:RETURN 1
 D ERRX^SDAPIE(.RETURN,"FILELOCK")
 Q 0
 ;
UNLOCK(IEN) ; Unlock specified wait list
 ;Input:
 ;   IEN [Required,Numeric] Wait list IEN (pointer to file 409.3)
 Q:'+$G(IEN) 0
 Q $$UNLOCK^SDWLDAL(IEN)
 ;
HASENTRY(RETURN,DFN) ;PATIENT HAS EWL ENTRIES?
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the patient has EWL entries on file.
 ;                             Set to Error description if the call fails
 ;   DFN [Required,Numeric] Patient IEN.
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=0
 I '$$PATIEN^SDCHK(.RETURN,.DFN) Q 0
 S RETURN=$$HASENTRY^SDWLDAL(DFN)
 Q 1
 ;
LIST(RETURN,DFN,STATUS,BEGIN,END) ;LIST PATIENT EWL ENTRIES
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields except 'IEN' are returned in internal^external format.
 ;    RETURN [Numeric] # of entries found
 ;    RETURN(#,"DISPTYPE") [String]Disposition type
 ;    RETURN(#,"IEN") [Numeric]EWL entry IEN
 ;    RETURN(#,"INSTITUTION") [Numeric]Institution
 ;    RETURN(#,"ORIGDT") [DateTime] Originating date
 ;    RETURN(#,"PRIORITY") [String] Priority (A:ASAP,F:FUTURE)
 ;    RETURN(#,"STATUS") [String] Status (O:OPEN,C:CLOSED)
 ;    RETURN(#,"WAITFOR") [Numeric] Pointer to Team/Position/Specialty/Clinic depending on Wait List Type
 ;    RETURN(#,"WLTYPE") [Numeric] Wait List Type: 1=PCMM Team assignment, 2=PCMM position assignment, 3=service/specialty, 4=specific clinic
 ;   DFN [Required,Numeric] Patient IEN
 ;   STATUS [Optional,String] EWL entry status (O=Open, C=Closed, ""=Both). Default: ""
 ;   BEGIN [Optional,DateTime] Start date (originating date)
 ;   END [Optional,DateTime] End date (originating date)
 ;Output:
 ;  1=Success,0=Failure
 N PATOK
 S RETURN=0
 I '$$PATIEN^SDCHK(.RETURN,.DFN) Q 0
 S STATUS=$E($G(STATUS))
 I STATUS'="",STATUS'="O",STATUS'="I" D ERRX^SDAPIE(.RETURN,"INVPARAM","STATUS") Q 0
 I '$$DTIME^SDCHK(.RETURN,.BEGIN,"BEGIN",1) Q 0
 I '$$DTIME^SDCHK(.RETURN,.END,"END",1) Q 0
 S BEGIN=$G(BEGIN)
 S END=$G(END)
 D LIST^SDWLDAL(.RETURN,DFN,STATUS,BEGIN,END)
 Q 1
 ;
DETAIL(RETURN,IEN) ;Wait List entry detailed information
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           All fields are returned in internal^external format.
 ;    RETURN(field_name)=internal^external (see Scheduling API manual for available fields)
 ;   IEN [Required,Numeric] EWL entry IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=0
 I '$$SDWLIEN^SDCHK(.RETURN,.IEN,"IEN") Q 0
 D DETAIL^SDWLDAL(.RETURN,IEN)
 Q 1
 ;
TRNDET(RETURN,SDWLIEN) ; Get transfer details for Electronic Wait List internal entry number
 ; Input:   SDWLIEN:   EWL IEN
 ; Output:  RETURN("ACTIVE"): 0: no active transfer, 1: active transfer
 ;          RETURN("INSTITUTION"): Institution name
 ;          RETURN("STATION"):  Station Number
 N HASENTRY
 S RETURN("ACTIVE")=0
 I '+$G(SDWLIEN) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","SDWLIEN")
 I '$$TRFRQACT^SDWLDAL(SDWLIEN) Q 1
 S RETURN("ACTIVE")=1
 Q $$TRFRQDET^SDWLDAL(.RETURN,SDWLIEN)
 Q 1
 ;
DISP(RETURN,SDWLIEN,SDWLDISP,SDWLAPPT) ;UPDATE DISPOSITION
 ;Input:
 ;  .RETURN [Required,Array] [Required,Boolean] Set to 1 if the update succeeded.
 ;                           Set to Error description if the call fails
 ;   SDWLDFN [Required,Numeric] Patient IEN
 ;   SDWLIEN [Required,Numeric] EWL entry IEN
 ;   SDWLDISP [Required,String] Disposition type
 ;  .SDWLAPPT [Optional,Array] Array containing appointment data (saved if disposition type is "SA")
 ;Output:
 ;  1=Success,0=Failure
 N DA,DIE,SDWLDUZ
 S RETURN=0
 I '$$SDWLIEN^SDCHK(.RETURN,.SDWLIEN,"SDWLIEN") Q 0
 I $G(SDWLDISP)=""!("^D^NC^SA^CC^NN^ER^TR^CL^"'[("^"_$G(SDWLDISP)_"^")) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","SDWLDISP")
 S RETURN=$$DISP^SDWLDAL(SDWLIEN,SDWLDISP,.SDWLAPPT)
 ;; OG ; SD*5.3*446 Inter-facility transfer.
 I SDWLDISP'="SA" D DIS^SDWLE6(SDWLIEN)
 Q RETURN
 ;
NEW(RETURN,SDWLD) ;CREATE NEW EWL ENTRY
 ;Input:
 ;  .RETURN [Required,Numeric] Will return the new IEN if the call succeeded, 0 otherwise
 ;                             Set to Error description if the call fails
 ;  .SDWLD [Required,Array] Array containing the data to be saved
 ;    SDWLD("CHDCLINP") [Numeric] Changed clinic parent pointer
 ;    SDWLD("CMNTS") [String] Comments
 ;    SDWLD("DSRDDT") [DateTime] Desired date of appointment
 ;    SDWLD("ENRDF") [String] EWL enrollee database file
 ;    SDWLD("ENRDU") [DateTime] EWL enrollee date used
 ;    SDWLD("ENRSTAT") [String] EWL enrollee status
 ;    SDWLD("INSTITUTION") [Numeric] Institution
 ;    SDWLD("PATIENT") [Numeric] Patient
 ;    SDWLD("PRIORITY") [String] Priority
 ;    SDWLD("PROVIDER") [Numeric] Provider
 ;    SDWLD("REQBY") [Numeric] Request by
 ;    SDWLD("SCPRCNT") [Numeric] Service connected percentage
 ;    SDWLD("SCPRIORITY") [Boolean] Service connected priority
 ;    SDWLD("TICKLER") [Boolean] Scheduling reminder flag
 ;    SDWLD("WAITFOR") [Numeric]Pointer to Team/Position/Specialty/Clinic depending on Wait List Type
 ;    SDWLD("WLTYPE") [Numeric]Wait List Type
 ;Output:
 ;  1=Success,0=Failure
 N PAT,TYP
 K RETURN
 S RETURN=0
 I '$D(SDWLD) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","SDWLD")
 I +$G(SDWLD("PATIENT"))'>0 D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","PATIENT")
 I '$$PATDET^SDWLEXT(.PAT,+SDWLD("PATIENT")) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"PATNFND")
 I +$G(SDWLD("INSTITUTION"))'>0 D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","INSTITUTION")
 S TYP=+$G(SDWLD("WLTYPE"))
 I TYP'>0,TYP'<5  D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","WLTYPE")
 I (TYP=3)!(TYP=4),'$D(SDWLD("PRIORITY")) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","PRIORITY")
 I (TYP=3)!(TYP=4),'$D(SDWLD("REQBY")) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","REQBY")
 I (TYP=3)!(TYP=4),'$D(SDWLD("DSRDDT")) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","DSRDDT")
 Q $$NEW^SDWLDAL(.RETURN,.SDWLD)
 ;
UPDATE(RETURN,SDWLIEN,SDWLD) ; Update EWL entry
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the the update succeeded.
 ;                             Set to Error description if the call fails
 ;   SDWLIEN [Required,Numeric] IEN of the EWL entry to be updated
 ;  .SDWLD [Required,Array] Array containing the data to be saved
 ;    SDWLD("CMNTS") [String] Comments
 ;    SDWLD("DSRDDT") [DateTime] Desired date of appointment
 ;    SDWLD("ENRSTAT") [String] EWL enrollee status
 ;    SDWLD("INSTITUTION") [Numeric] Institution
 ;    SDWLD("INTRATF") [Boolean] Intra-transfer flag
 ;    SDWLD("MULTITEAM") [Boolean] Multi team flag
 ;    SDWLD("PRIORITY") [String] Priority
 ;    SDWLD("PROVIDER") [Numeric] Provider
 ;    SDWLD("REJECTED") [Boolean] Rejection flag
 ;    SDWLD("REQBY") [Numeric] Request by
 ;    SDWLD("SCPRCNT") [Numeric] Service connected percentage
 ;    SDWLD("SCPRIORITY") [Boolean] Service connected priority
 ;    SDWLD("TICKLER") [Boolean] Scheduling reminder flag
 ;    SDWLD("WAITFOR") [Numeric] Pointer to Team/Position/Specialty/Clinic depending on Wait List Type
 ;    SDWLD("WLTYPE") [Numeric] Wait List Type
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=0
 I +$G(SDWLIEN)'>0 D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","SDWLIEN")
 I '+$D(SDWLD) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"INVPARAM","SDWLD")
 Q $$UPDATE^SDWLDAL(.RETURN,SDWLIEN,.SDWLD)
 ;
DELETE(RETURN,SDWLIEN) ;DELETE EWL ENTRY
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the delete succeeded.
 ;                             Set to Error description if the call fails
 ;   SDWLIEN [Required,Numeric] EWL entry IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=0
 I '$$SDWLIEN^SDCHK(.RETURN,.SDWLIEN,"SDWLIEN") Q 0
 Q $$DELETE^SDWLDAL(.RETURN,SDWLIEN)
 ;
