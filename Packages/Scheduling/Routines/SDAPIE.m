SDAPIE ;RGI/CBR - Scheduling Error provider; 3/7/13
 ;;5.3;scheduling;**260003**;08/13/93;
ERRX(RETURN,ERRNO,TEXT,LVL) ; adds error to RETURN
 N ERRTXT,IND,ST,STR,TXT,I
 Q:'$D(RETURN)
 Q:'$D(ERRNO)
 S:$G(LVL)="" LVL=1
 N I S I=0
 I $D(RETURN(I)) F I=0:1 Q:$O(RETURN(I))=""
 ;I $G(TEXT)'="" S TEXT(1)=TEXT
 S RETURN(I)=ERRNO_U_$$EZBLD^DIALOG($P($T(@ERRNO),";;",2),.TEXT)_U_LVL
 Q
 ;
ERRTXT(RETURN) ;
 Q $P($G(RETURN(0)),U,2)
 ; 
ERRTABLE ; Error table
INVPARAM ;;480000.035;;Invalid parameter value - ^$TXT1^.
CLNINV ;;480000.036;;Invalid Clinic.
CLNNFND ;;480000.037;;Clinic not found.
CLNNDFN ;;480000.038;;Clinic not define or has no zero node.
CLNSCIN ;;480000.039;;Invalid Clinic Stop Code ^$TXT1^.
CLNSCRD ;;480000.04;;Clinic's Stop Code ^$TXT1^ cannot be used. Restriction date is ^$TXT2^ ^$TXT3^.
CLNSCPS ;;480000.041;;Clinic's Stop Code ^$TXT1^ cannot be ^$TXT2^.
CLNSCNR ;;480000.042;;Clinic's Stop Code ^$TXT1^ has no restriction type ^$TXT2^.
CLNURGT ;;480000.043;;Access to ^$TXT1^ is prohibited!^$TXT2^Only users with a special code may access this clinic.
CLNNOSL ;;480000.044;;No 'SL' node defined - cannot proceed with this clinic.
PATDIED ;;480000.1;;PATIENT HAS DIED.
PATNFND ;;480000.046;;Patient not found.
PATSENS ;;480000.047;;Do you want to continue processing this patient record
NOAVSLO ;;480000.048;;No available slots found on the same day in all the selected clinics for this date range
APTCRGT ;;480000.049;;Appt. in ^$TXT1^ NOT CANCELLED^$TXT2^Access to this clinic is restricted to only privileged users!
APTCCHO ;;480000.05;;>>> Appointment has a check out date and cannot be cancelled.
APTCAND ;;480000.051;;Appointment already cancelled
APTCNPE ;;480000.052;;You cannot cancel this appointment.
APTCIPE ;;480000.053;;You cannot check in this appointment.
APTCITS ;;480000.054;;It is too soon to check in this appointment.
APTPPAB ;;480000.055;;That date is prior to the patient's date of birth.
APTPCLA ;;480000.056;;That date is prior to the clinic's availability date.
APTCLUV ;;480000.057;;There is no availability for this date/time.
APTEXCD ;;480000.058;;EXCEEDS MAXIMUM DAYS FOR FUTURE APPOINTMENT!!
APTSHOL ;;480000.059;;^$TXT1^??
APTPAHA ;;480000.06;;PATIENT ALREADY HAS APPOINTMENT ^$TXT1^ THEN.
APTPAHU ;;480000.061;;o  Patient already has an appt on ^$TXT1^
APTPHSD ;;480000.062;;PATIENT ALREADY HAS APPOINTMENT ON THE SAME DAY ^$TXT1^
APTPPCP ;;480000.063;;THIS TIME WAS PREVIOUSLY CANCELLED BY THE PATIENT
APTOVBK ;;480000.064;;OVERBOOK!
APTOVOS ;;480000.065;;THAT TIME IS NOT WITHIN SCHEDULED PERIOD!
APTOAPD ;;480000.066;;ONLY ^$TXT1^ OVERBOOK^$TXT2^ PER DAY!!
APTCBCP ;;480000.067;;CAN'T BOOK WITHIN A CANCELLED TIME PERIOD
APTNOST ;;480000.068;;NO OPEN SLOTS THEN
APTEXOB ;;480000.069;;WILL EXCEED MAXIMUM ALLOWABLE OVERBOOKS,
APTLOCK ;;480000.07;;Another user is editing this record.  Trying again.
APTCINV ;;480000.071;;*** Note: Clinic is scheduled to be inactivated on ^$TXT1^$TXT2^
APTNSCE ;;480000.073;;You cannot execute no-show processing for this appointment.
APTNSTS ;;480000.074;;It is too soon to no-show this appointment.
APTNSAL ;;480000.075;;ALREADY RECORDED AS NO-SHOW... WANT TO ERASE
APTNSAR ;;480000.076;;THIS APPOINTMENT ALREADY A NO-SHOW AND REBOOKED... ARE YOU SURE YOU WANT TO ERASE
APTNSIA ;;480000.077;;Inpatient Appointments cannot reflect No-Show status!
PATDARD ;;480000.078;;PATIENT ALREADY DISCHARGED FROM '^$TXT1^' CLINIC
PATDNEN ;;480000.079;;>>> Patient not enrolled in '^$TXT1^' clinic.
PATDHFA ;;480000.08;;PATIENT HAS FUTURE APPOINTMENTS, MUST BE CANCELLED PRIOR TO DISCHARGE !!
APTDCOD ;;480000.081;;>>> The appointment must have a check out date/time to delete.
APTDCOO ;;480000.082;;>>> Editing and deleting old encounters not allowed.
APTCOCE ;;480000.083;;>>> You can not check out this appointment.
APTCOTS ;;480000.084;;>>> It is too soon to check out this appointment.
APTCOCN ;;480000.085;;>>> You cannot check out this appointment.
APTCOAC ;;480000.086;;Appointment already checked out
APTCONW ;;480000.087;;Appointment new encounter
APTCOSU ;;480000.088;;You must have the 'SD SUPERVISOR' key to delete an appointment check out.
APTWHEN ;;480000.089;;WHEN??
APTPAHCO ;;480000.06;;PATIENT ALREADY HAS APPOINTMENT ^$TXT1^ THEN.
RSNNFND ;;480000.095;;Cancellation reason not found.
TYPNFND ;;480000.096;;Appointment type not found.
TYPINVD ;;480000.097;;Patient must have the eligibility code EMPLOYEE, COLLATERAL or SHARING AGREEMENT to choose those types of appointments.
TYPINVSC ;;480000.098;;The 'SC Percent','Service Connected' and 'Primary Eligibility Codes' are OUT OF SYNC, Please CORRECT the problem.
STYPNFND ;;480000.099;;Appointment subtype not found or inactive.
APTNFND ;;480000.101;;Appointment not found.
