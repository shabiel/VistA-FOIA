GMPLAPIE ; RGI -- Problem List Error provider; 03/20/12
 ;;2.0;Problem List;**260002**;Aug 25, 1994
ERR(ERT,ERRNO,TEXT) ; Adds error to array
 Q:$G(ERRNO)=""
 N I
 S TEXT=$G(TEXT)
 S:$G(ERT)="" ERT="^TMP(""GMPLERR"",$J)"
 S I=+$G(@ERT)+1
 S @ERT=I
 S @ERT@(I)=ERRNO_U_$P($T(@ERRNO),";;",2)_TEXT
 Q
 ;
ERRX(RETURN,ERRNO,TEXT) ; adds error to RETURN
 Q:'$D(RETURN)
 Q:'$D(ERRNO)
 S TEXT=$G(TEXT)
 N I
 F I=0:1 Q:$O(RETURN(I))=""
 S RETURN(I)=ERRNO_U_$P($T(@ERRNO),";;",2)_TEXT
 Q
 ;
ERRTXT(RETURN) ;
 Q $P($G(RETURN(0)),U,2)
 ; 
FIRSTERR(ERT) ; Returns first error text
 S:$G(ERT)="" ERT="^TMP(""GMPLERR"",$J)"
 Q $P($G(@ERT@(1)),U,2)
 ;
ERRTABLE ; Error table
INVPARAM ;;Invalid parameter value - 
FILELOCK ;;Record in use. Try again in a few moments.
PRBNFND ;;Problem not found
PRBDLTD ;;Problem already deleted
PROVNFND ;;Provider not found
FACNFND ;;Facility not found
PRBVRFD ;;Problem Already Verified
LISTXST ;;List already exists
LISTNFND ;;Problem selection list not found
INACTICD ;;This Selection List contains problems with inactive ICD9 codes associated with them.
LISTUSED ;;List could not be deleted, 
LOCNFND ;;Clinic not found
CTGEXIST ;;Category already exists
PRBINACT ;;Problem is already inactive!
ICDINACT ;;Inactive ICD9 code. Edit the problem before adding comments.
CTGNFND ;;Category not found
CATUSED ;;Category in use. Could not delete.
INVREC ;;Invalid record
