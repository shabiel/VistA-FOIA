GMPLUTL3 ; SLC/JST/JVS -- PL Utilities (CIRN)           ; 03/29/12
 ;;2.0;Problem List;**14,15,19,25,26,260002**;Aug 25, 1994
 ;
 ; External References
 ;   None
 ;             
 ; This routine is primarily called by CIRN for use 
 ; in HL7 (RGHOPL), and Historical Load (RGHOPLB), 
 ; record creation.
 ;             
 ; NOTE: This routine DOES NOT NEW the variables 
 ;       that are set below.
 ;             
CALL0(GMPLZ) ; Call 0 - Get Node 0
 N VALID,DELETED
 S %=$$VALID^GMPLAPI4(.VALID,GMPLZ)
 I 'VALID D CLEAR Q
 S %=$$DELETED^GMPLAPI2(.DELETED,GMPLZ)
 I DELETED D CLEAR Q
 D NODE0
 Q
 ;
CALL1(GMPLZ) ; Call 1 - Get Node 1
 N VALID,DELETED
 S %=$$VALID^GMPLAPI4(.VALID,GMPLZ)
 I 'VALID D CLEAR Q
 S %=$$DELETED^GMPLAPI2(.DELETED,GMPLZ)
 I DELETED D CLEAR Q
 D NODE1
 Q
 ;
CALL2(GMPLZ) ; Call 2 - Get both Node 0 and Node 1
 N VALID,DELETED
 S %=$$VALID^GMPLAPI4(.VALID,GMPLZ)
 I 'VALID D CLEAR Q
 S %=$$DELETED^GMPLAPI2(.DELETED,GMPLZ)
 I DELETED S GMPLCOND="H" D CLEAR Q
 D NODE0,NODE1
 Q
 ;               
NODE0 ; Set Node 0 data variables
 N GMPL
 S %=$$DETAIL^GMPLAPI2(.GMPL,GMPLZ)
 ;   Diagnosis
 S GMPLICD=$P(GMPL(.01),U)
 ;   Patient Name
 S GMPLPNAM=$P(GMPL(.02),U)
 ;   Date Last Modifed
 S GMPLDLM=$P(GMPL(.03),U)
 ;   Provider Narrative
 S GMPLTXT=$P(GMPL(.05),U)
 ;   Status
 S GMPLSTAT=$P(GMPLZ(.12),U)
 ;   Date of Onset
 S GMPLODAT=$P(GMPL(.13),U)
 ;   Date Entered
 S:'GMPLODAT GMPLODAT=$P(GMPLZ(.08),U)
 Q
 ;
NODE1 ; Set Node 1 data variables
 N GMPL
 S %=$$DETAIL^GMPLAPI2(.GMPL,GMPLZ)
 ;   Problem
 S GMPLLEX=$P(GMPL(1.01),U)
 ;   Condition
 S GMPLCOND=$P(GMPL(1.02),U)
 ;   Recording Provider
 S GMPLPRV=$P(GMPL(1.04),U)
 ;   Responsible Provider
 S:'GMPLPRV GMPLPRV=$P(GMPL(1.05),U)
 ;   Date Resolved
 S GMPLXDAT=$P(GMPL(1.07),U)
 ;   Priority
 S GMPLPRIO=$P(GMPL(1.14),U)
 Q
 ;          
CLEAR ; Set Variables Equal to Null
 S (GMPLZ0,GMPLICD,GMPLPNAM,GMPLDLM,GMPLTXT,GMPLSTAT,GMPLODAT)=""
 S (GMPLZ1,GMPLLEX,GMPLPRV,GMPLXDAT,GMPLPRIO,GMPLCOND)=""
 Q
MOD(DFN) ; Return the Date the Patients Problem List was Last Modified
 N MODIFIED
 S %=$$MODIFIED^GMPLAPI4(.MODIFIED,DFN)
 Q MODIFIED
