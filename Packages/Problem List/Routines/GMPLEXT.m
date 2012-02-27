GMPLEXT ; / External functions mockup (to be deleted when the interfaces are fixed);02/27/2012
 ;;TBD;Problem List;;02/27/2012
PROVNAME(GMPROV) ; Returns provider name
 Q $P($G(^VA(200,+GMPROV,0)),U)
 ;
CLINNAME(GMCLIN) ; Returns Clinic name
 Q $P($G(^SC(+GMCLIN,0)),U)
 ;
PATNAME(GMPDFN) ; Returns patient name
 Q $P($G(^DPT(+GMPDFN,0)),U)
 ;
ICD9NAME(GMPICD)
 Q $P($G(^ICD9(+GMPICD,0)),U)
 ;
