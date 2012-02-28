GMPLAPIE ; / Problem List Error provider;02/27/2012
 ;;TBD;Problem List;;02/27/2012
ERR(ERT,ERRNO,TEXT)
 Q:$G(ERRNO)=""
 N I
 S TEXT=$G(TEXT)
 D BUILD
 S:$G(ERT)="" ERT="^TMP(""GMPLERR"",$J)"
 S I=+$G(@ERT)+1
 S @ERT=I
 S @ERT@(I)=ERRNO_"^"_$G(GMPLERR(ERRNO))_TEXT
 Q
 ;
BUILD
 Q:$D(GMPLERR)
 N I,LINE,ERR
 F I=1:1 S LINE=$T(ERRTABLE+I) Q:LINE=""  D
 . S ERR=$P(LINE,";;",2)
 . S GMPLERR($P(ERR,"^",1))=$P(ERR,"^",2)
 Q
 ;
ERRTABLE
 ;;INVALIDPARAM^Invalid parameter value - 
 ;;FILELOCKED^"Record in use. Try again in a few moments.
 ;;PRBNOTFOUND^Problem not found
 ;;PRBDELETED^Problem already deleted
 ;;PROVNOTFOUND^Provider not found
 ;;FACNOTFOUND^Facility not found
 ;;PRBVERIFIED^Problem Already Verified
 ;;LISTEXIST^List already exists
 ;;LISTNOTFOUND^Problem selection list not found
 ;;INACTIVEICD9^This Selection List contains problems with inactive ICD9 codes associated with them.
 ;;LISTUSED^List could not be deleted, 
 ;;LOCNOTFOUND^Clinic not found
 ;;CATEGEXIST^Category already exists
 