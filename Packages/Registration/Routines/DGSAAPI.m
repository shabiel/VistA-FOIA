DGSAAPI ;RGI/CBR - SHARING AGREEMENTS UTILITY FUNCTIONS ;5/17/13
 ;;5.3;Registration;**114,194,216,260003*****;Aug 13, 1993
LSTSBCTG(RETURN,SEARCH,START,NUMBER) ;List sharing agreement sub-categories (file 35.2)
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN(0) – [String] # of entries found
 ;    RETURN(#) – [String] IEN^name
 ;   SEARCH [Optional,String] Partial match restriction. Default: All entries
 ;   START [Optional,String] The appointment type name from which to begin the list. Default: ""
 ;   NUMBER [Optional,Numeric] Number of entries to return. Default: All entries
 ;Output:
 ;  1=Success,0=Failure
 D LSTSBCTG^DGSADAL(.RETURN,$$UP^XLFSTR($G(SEARCH)),.START,$G(NUMBER))
 S RETURN=1
 Q RETURN
 ;
