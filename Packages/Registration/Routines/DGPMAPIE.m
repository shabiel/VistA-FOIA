DGPMAPIE ;RGI/VSL - Registration Error provider; 6/19/13
 ;;5.3;Registration;**260005**;
ERRX(RETURN,ERRNO,TEXT) ; adds error to RETURN
 N ERRTXT,IND,ST,STR,TXT,I
 Q:'$D(RETURN)
 Q:'$D(ERRNO)
 N I S I=0
 I $D(RETURN(I)) F I=0:1 Q:$O(RETURN(I))=""
 S RETURN(I)=ERRNO_U_$$EZBLD^DIALOG($P($T(@ERRNO),";;",2),.TEXT)
 Q
 ;
ERRTABLE ; Error table
INVPARM ;;4070000.078;;Invalid parameter
WRDINACT ;;4070000.079;;Ward is inactive.
BEDINACT ;;4070000.08;;Bed is inactive.
BEDOCC ;;4070000.081;;Bed is occupied.
FILELOCK ;;4070000.082;;Record in use. Try again in a few moments.
CANDASIH ;;4070000.086;;Cannot delete before ASIH transfers are removed
CANMDDF ;;4070000.087;;Must delete discharge first
CANDWPTF ;;4070000.088;;Cannot delete while PTF Census record # is closed.
DELTITP ;;4070000.095;;Cannot delete transfer - would create an invalid transfer pair
DELTMDTA ;;4070000.096;;Must delete through corresponding hospital admission
DELTCDWD ;;4070000.097;;Cannot delete while discharge exists
DELTCDPC ;;4070000.098;;Cannot delete when corresponding admission PTF closed out
DELTMMRF ;;4070000.099;;|1| movement must be removed first
TRANBADM ;;4070000.114;;Not before admission movement
DSCNMVTD ;;4070000.116;;There is no movement type define for
PATNFND ;;4070000.119;;Patient not found.
AREGNFND ;;4070000.12;;Admitting regulation not found.
AREGINAC ;;4070000.121;;Admitting regulation is inactive.
MVTTNFND ;;4070000.122;;Movement type not found.
MVTTINAC ;;4070000.123;;Movement type is inactive.
ADMINVAT ;;4070000.124;;Invalid admission type.
SHDGINV ;;4070000.125;;Invalid diagnosis, must be 3-30 characters long.
WRDNFND ;;4070000.126;;Ward not found.
WRDINVGL ;;4070000.127;;Ward's 'G&L Order' field is not valid.
BEDNFND ;;4070000.128;;Bed not found.
WRDCNASB ;;4070000.129;;Ward cannot assign this bed.
FTSNFND ;;4070000.13;;Facility treating specialty not found.
FTSINAC ;;4070000.131;;Facility treating specialty is inactive.
PROVNFND ;;4070000.132;;Provider not found.
PROVINAC ;;4070000.133;;Is not an active provider.
ASRCNFND ;;4070000.134;;Source of admission not found.
ADMPAHAD ;;4070000.135;;Patient already has an active admission.
ADMMBBNM ;;4070000.136;;There is a |1| movement on file for this patient on |2|.
TRAINVAT ;;4070000.139;;Invalid transfer type.
ADMNFND ;;4070000.14;;Admission not found.
TRANFND ;;4070000.141;;Transfer not found.
TRANADIS ;;4070000.142;;Not after discharge movement
ASHWINVS ;;4070000.143;;Invalid ward service for this type of movement
TFCNFND ;;4070000.144;;Transfer facility not found.
TFCINAC ;;4070000.145;;Transfer facility is inactive.
TIMEUSD ;;4070000.146;;There is already a movement at that date/time entered for this patient
DISINVAT ;;4070000.147;;Invalid discharge type.
MVTNFND ;;4070000.148;;Movement not found.
DCHCDWAH ;;4070000.149;;You can not delete a WHILE ASIH type discharge
DCHDTCNH ;;4070000.15;;Delete through corresponding NHCU/DOM movements
DCHCDOLA ;;4070000.151;;Can only delete discharge for last admission
DCHDODLM ;;4070000.152;;You can only remove a discharge when it is the last movement for the patient.
DCHMDHDF ;;4070000.153;;You must delete the hospital discharge first.
DCHNBLM ;;4070000.154;;Not before last movement
DCHPADON ;;4070000.155;;Patient already discharged on...
DCHNFND ;;4070000.156;;Discharge not found
PSRVNFND ;;4070000.163;;Period of service not found
ADMPLODG ;;4070000.165;;Patient is a lodger...you can not add an admission!
ADMNBLD ;;4070000.167;;New ...must enter after last ...
LDGPINP ;;4070000.173;;Patient is an inpatient...you can not add a lodger movement!
RSNNFND ;;4070000.174;;Reason for lodging not found.
RPMNFND ;;4070000.034;;Related physical movement not found
CANDRPM ;;4070000.035;;You are not allowed to delete a specialty transfer that is assoicated with the initial admission movement.
LDGPALD ;;4070000.175;;Patient is already a lodger
TRACEAT ;;4070000.176;;Cannot edit ASIH transfers
PATENFND ;;4070000.177;;Patient eligibility not found
