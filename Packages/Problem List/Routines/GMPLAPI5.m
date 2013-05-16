GMPLAPI5 ; Build Problem Selection Lists ; 5/15/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
ADDLOC(RETURN,GMPLLST,GMPLLOC) ; Add location to list
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if operation succeeds
 ;                             Set to Error description if the call fails
 ;   GMPLLST [Required,Numeric] Problem selection list IEN (pointer to file 125)
 ;   GMPLLOC [Required,Numeric] Clinic location IEN (pointer to file 44)
 ;Output:
 ;  1=Success,0=Failure
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 I '$$SCIEN^GMPLCHK(.RETURN,.GMPLLOC,"GMPLLOC") Q 0
 Q:'$$LOCKLST^GMPLAPI1(.RETURN,GMPLLST) 0
 D ADDLOC^GMPLDAL1(.RETURN,GMPLLST,GMPLLOC)
 D UNLKLST^GMPLAPI1(GMPLLST)
 Q 1
 ;
GETCATD(RETURN,GMPLGRP,CODLEN) ; Return Category details
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("GRP",category_IEN,#)=problem_name^ICD9_code^inactive_flag^lexicon_term_IEN(757.01)
 ;   GMPLGRP [Required,Numeric] Problem category IEN
 ;   CODLEN [Optional,Numeric] A number that specifies the maximum length of the returned problem text
 ;Output:
 ;  1=Success,0=Failure
 N %
 S RETURN=0
 I '$$CTGIEN^GMPLCHK(.RETURN,.GMPLGRP) Q 0
 I '$$NUM^GMPLCHK(.RETURN,.CODLEN,"CODLEN",1,0,1) Q 0
 N PSEQ,ITEM,GROUP,FLAG
 S PSEQ=0,GROUP=+GMPLGRP
 S %=$$GETCATD^GMPLDAL1(.RETURN,GMPLGRP,$G(CODLEN))
 F  S PSEQ=$O(RETURN("GRP",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . S ITEM=$G(RETURN("GRP",+GROUP,PSEQ))
 . S FLAG=""
 . I $L($P(ITEM,U,2)) D
 .. I $$STATCHK^ICDAPIU($P(ITEM,U,2),DT) S FLAG=0  ; code is active
 .. E  S FLAG=1
 . S RETURN("GRP",GROUP,PSEQ)=$P(ITEM,U,1,2)_"^"_FLAG_"^"_$P(ITEM,U,3)
 S RETURN=1
 Q 1
 ;
GETLSTS(RETURN,SEARCH,START,NUMBER) ; Get lists
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0)=number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID")=problem selection list IEN
 ;      RETURN(#,"NAME")=problem selection list name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N RET,DL,IN
 S RETURN=0
 I '$$NUM^GMPLCHK(.RETURN,.NUMBER,"NUMBER",1,0,1) Q 0
 S START=$G(START)
 S SEARCH=$G(SEARCH)
 S NUMBER=$G(NUMBER)
 D GETLSTS^GMPLDAL1(.RET,SEARCH,.START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . I $D(RET(DL,1,IN))>0 D
 . . S RETURN(IN,"ID")=RET(DL,2,IN)
 . . S RETURN(IN,"NAME")=RET(DL,1,IN)
 . E  D
 . . S RETURN(IN,"ID")=RET(DL,2,IN)
 . . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 . . S:$D(RET(DL,"ID",IN,".03")) RETURN(IN,"CLINIC")=RET(DL,"ID",IN,".03")
 . . S:$D(RETURN(IN,"CLINIC")) RETURN(IN,"NAME")=RETURN(IN,"CLINIC")_$C(9)_RETURN(IN,"NAME")
 S RETURN=1
 Q 1
 ;
GETCATS(RETURN,SEARCH,START,NUMBER) ; Get categories
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0)=number_of_entries_found^maximum_requested^any_more?
 ;      RETURN(#,"ID")=problem category IEN
 ;      RETURN(#,"NAME")=problem category name
 ;   SEARCH [Optional,String] Partial match restriction.
 ;  .START [Optional,String] Index from which to begin the list. Similar to .FROM parameter to LIST^DIC.
 ;   NUMBER [Optional,Numeric] Number of entries to return.
 ;Output:
 ;  1=Success,0=Failure
 N RET,DL,IN
 S RETURN=0
 I '$$NUM^GMPLCHK(.RETURN,.NUMBER,"NUMBER",1,0,1) Q 0
 S SEARCH=$G(SEARCH)
 S NUMBER=$G(NUMBER)
 D GETCATS^GMPLDAL1(.RET,SEARCH,.START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . Q:$D(RET(DL,1,IN))'>0
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,1,IN)
 S RETURN=1
 Q 1
 ;
GETUSRS(RETURN,SEARCH,START,NUMBER) ; Array of users
 ; RETURN - Passed by reference, array of users
 ;  RETURN(0) = Number of users
 ;  RETURN(I,"ID") = user IFN
 ;  RETURN(I,"NAME") = user name
 ;  RETURN(I,"INITIAL") = user initial name
 ;  RETURN(I,"EMAIL") = email
 ;  RETURN(I,"WRITE") = type of user
 ; SEARCH - string to search
 ; START - start of search
 ; NUMBER - max number of records
 N RET
 S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 D GETUSRS^GMPLEXT1(.RET,SEARCH,.START,NUMBER)
 D BUILDUSR(.RETURN,.RET)
 Q 1
 ;
BUILDUSR(RETURN,RET) ;
 N DL,IN
 S DL="DILIST"
 Q:'$D(RET(DL,0))
 S RETURN(0)=RET(DL,0)
 F IN=1:1:$P(RETURN(0),U,1) D
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 . S:$D(RET(DL,"ID",IN,"1")) RETURN(IN,"INITIAL")=RET(DL,"ID",IN,"1")
 . S:$D(RET(DL,"ID",IN,".151")) RETURN(IN,"EMAIL")=RET(DL,"ID",IN,".151")
 . S:$D(RET(DL,"ID","WRITE",IN,"8")) RETURN(IN,"WRITE")=RET(DL,"ID","WRITE",IN,"8")
 Q
 ;
GETASUSR(RETURN,GMPLLST)  ; Array of users assigned to specified list
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(0)=number of currently assigned users
 ;      RETURN(#,"ID")=user IEN (pointer to file 200)
 ;      RETURN(#,"NAME")=user name
 ;   GMPLLST [Required,Numeric] The problem selection list IEN.
 ;Output:
 ;  1=Success,0=Failure
 N RET
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 D GETASSUS^GMPLEXT1(.RET,GMPLLST)
 D BUILDUSR(.RETURN,.RET)
 I $D(RETURN(0)) S RETURN(0)=+RETURN(0)
 S RETURN=1
 Q 1
 ;
GETCLIN(RETURN,SEARCH,START,NUMBER) ; Array of clinical locations
 ; RETURN - Passed by reference, array of locations
 ;  RETURN(0) = Number of locations
 ;  RETURN(I,"ID") = location IFN
 ;  RETURN(I,"NAME") = location name
 ; SEARCH - string to search
 ; START - start of search
 ; NUMBER - max number of records
 S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 N RET,DL,IN
 S RETURN=0
 D GETCLIN^GMPLEXT1(.RET,SEARCH,.START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . Q:$D(RET(DL,1,IN))'>0
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,1,IN)
 S RETURN=1
 Q 1
 ;
