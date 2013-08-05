DGPARAPI ;RGI/VSL - Edit Parmaters API;07/18/13  15:47
 ;;5.3;Registration;**260005**;
 ;
GETDIV(RETURN,DIV) ; Get Medical Center Division
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("NAME") [String] Medical Center Divisions name
 ;      RETURN("INSTIT") [String] Institution file pointer (from the Institution file #4 in internal^external)
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N %,TMP,FLDS,NAMES,NAME
 S FLDS=".01;.07",NAMES="NAME;INSTIT;"
 K RETURN S RETURN=0
 S %=$$CHKDIV(.RETURN,.DIV) Q:'RETURN 0
 D GETDIV^DGPARDAL(.TMP,+DIV,FLDS)
 D BUILD^DGPMAPI8(.RETURN,.TMP,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
LSTDIV(RETURN,SEARCH,START,NUMBER) ; Get Medical Center Divisions
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [String] number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID") [Numeric] Medical Center Divisions IEN (pointer to the Medical Center Divisions file #40.8)
 ;      RETURN(#,"NAME") [String] Medical Center Divisions name
 ;      RETURN(#,"INSTIT") [String] Institution file pointer (from the Institution file #4 in internal^external)
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,TYPES
 K RETURN S FLDS=".01;.07;"
 S NAMES="NAME;INSTIT;",SEARCH=$$UP^XLFSTR($G(SEARCH))
 D LSTDIV^DGPARDAL(.TYPES,.SEARCH,.START,.NUMBER,FLDS)
 D BLDLST^DGPMAPI7(.RETURN,.TYPES,FLDS,NAMES)
 Q 1
 ;
CHKDIV(RETURN,DIV) ; Check Medical Center Division
 K RETURN S RETURN=0
 I '+$G(DIV) D ERRX^DGPMAPIE(.RETURN,"INVPARM","DIV") Q 0
 I '$$DIVEXST^DGPARDAL(+DIV) D ERRX^DGPMAPIE(.RETURN,"DIVNFND") Q 0
 S RETURN=1
 Q 1
 ;
GETMPAR(RETURN) ; Get Main Parameters
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("DEFCOSCR") [Boolean] Multidivision med center?
 ;      RETURN("APILEVEL") [String] Medical center name (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N FLDS,NAMES,PAR
 K RETURN S RETURN=0
 S FLDS="11;12;"
 S NAMES="GLMDIV;GLMEDC;"
 D GETMPAR^DGPARDAL(.PAR,1,FLDS)
 D BUILD^DGPMAPI8(.RETURN,.PAR,FLDS,NAMES)
 S RETURN=1
 Q 1
 ;
UPDMPAR(RETURN,PARAM) ; Update MAS Parameters
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Optional,Array] Array passed by reference that holds the new data.
 ;      PARAM("GLMDIV") [Optional,Boolean] Multidivision med center?
 ;      PARAM("GLMEDC") [Optional,Numeric] Medical center name (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N %,PAR,OLD K RETURN S RETURN=1
 Q:'$D(PARAM) 1 Q:$O(PARAM(""))="" 1
 S RETURN=0
 S %=$$GETMPAR^DGPARAPI(.OLD)
 S %=$$CHKMUPD(.RETURN,.PARAM,.OLD,.PAR) Q:'RETURN 0
 D UPDMPAR^DGPARDAL(.RETURN,1,.PAR)
 S RETURN=1
 Q 1
 ;
CHKMUPD(RETURN,PARAM,OLD,NEW) ; Check Main parameters
 N %,DAYS,LVLS,E1,TXT
 S RETURN=1
 I $G(PARAM("GLMDIV"))'="",$P($G(PARAM("GLMDIV")),U)'=$P(OLD("GLMDIV"),U) D  Q:'RETURN 0
 . I $P($G(PARAM("GLMDIV")),U)'=0&($P($G(PARAM("GLMDIV")),U)'=1) D  Q
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","PARAM(""GLMDIV"")")
 . S NEW(11)=+PARAM("GLMDIV")
 I $G(PARAM("GLMEDC"))'="",$G(OLD("GLMEDC"))'=$G(PARAM("GLMEDC")) D  Q:'RETURN 0
 . S %=$$CHKDIV(.RETURN,$G(PARAM("GLMEDC"))) Q:'RETURN
 . S NEW(11)=+PARAM("GLMEDC")
 Q 1
