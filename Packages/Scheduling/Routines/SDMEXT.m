SDMEXT ;RGI/CBR - EXTERNAL API; 9/17/13
 ;;5.3;scheduling;**260003**;08/13/93
CNSSTAT(IFN) ; Get consult status
 Q $P($G(^GMR(123,IFN,0)),U,12)
 ;
CNSEXST(IFN) ; Consult exists
 Q $D(^GMR(123,+$G(IFN)))
 ;
GETMOVDT(IFN) ; Get patient movement
 Q +$G(^DGPM(IFN,0))
 ;
HASMOV(DFN) ; Has movement?
 Q $D(^DGPM("C",DFN))
 ;
LSTSADM(RETURN,DFN,SD,CAN) ; Get scheduled admissions
 N LST,FLDS K RETURN
 D LSTSADM^SDMDALE(.LST,5,.SD,.CAN)
 S FLDS(13)="CANCEL DT",FLDS(2)="DATE"
 D BLDLST^SDMAPI(.RETURN,.LST,.FLDS)
 Q 1
 ;
LSTMGRP(RETURN,SEARCH,START,NUMBER) ; Get Mail Groups
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] Mail Group IEN (pointer to the Mail Group file #3.8)
 ;      RETURN(#,"NAME") [String] Mail Group name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,TYPES
 K RETURN S FLDS=".01;"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTMGRP^SDMDALE(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 S FLDS(.01)="NAME"
 D BLDLST^SDMAPI(.RETURN,.TYPES,.FLDS)
 Q 1
 ;
LSTEFRM(RETURN,SEARCH,START,NUMBER) ; Get Encounter Forms
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] Encounter Form IEN (pointer to the Encounter Form file #357)
 ;      RETURN(#,"NAME") [String] Encounter Form name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,TYPES
 K RETURN S FLDS=".01;"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTEFRM^SDMDALE(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 S FLDS(.01)="NAME"
 D BLDLST^SDMAPI(.RETURN,.TYPES,.FLDS)
 Q 1
 ;
LSTPKGI(RETURN,SEARCH,START,NUMBER) ; Get Package Interfaces
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] Package Interface IEN (pointer to the Package Interface file #357.6)
 ;      RETURN(#,"NAME") [String] Package Interface name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,TYPES
 K RETURN S FLDS=".01;"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTPKGI^SDMDALE(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 S FLDS(.01)="NAME"
 D BLDLST^SDMAPI(.RETURN,.TYPES,.FLDS)
 Q 1
 ;
LSTPCON(RETURN,SEARCH,START,NUMBER) ; Get Print Conditions
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] Print Condition IEN (pointer to the Print Condition file #357.92)
 ;      RETURN(#,"NAME") [String] Print Condition name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,TYPES
 K RETURN S FLDS=".01;"
 S SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTPCON^SDMDALE(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 S FLDS(.01)="NAME"
 D BLDLST^SDMAPI(.RETURN,.TYPES,.FLDS)
 Q 1
 ;
