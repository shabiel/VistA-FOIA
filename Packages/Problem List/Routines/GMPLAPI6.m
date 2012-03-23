GMPLAPI6 ;; Problem Selection Lists ; 03/20/12 11:20
 ;;;Problem List;;03/20/12
GETULST(RETURN,USER) ; Get user assigned problem selection list
 ; RETURN - Passed by reference, List IFN^List name
 ; USER - User IFN
 S RETURN=0
 I '$G(USER) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","USER") Q 0
 I '$$FIND^GMPLAPI5("200",USER) D ERRX^GMPLAPIE(.RETURN,"PROVNFND") Q 0
 S RETURN=$$GETULSTD(USER)
 Q 1
 ;
GETULSTD(USER) ; Get user assigned problem selection list
 ; RETURN - Passed by reference, List IFN^List name
 ; USER - User IFN
 N LST
 S LST=$P($G(^VA(200,DUZ,125)),U,2)
 S $P(LST,U,2)=$P($G(^GMPL(125,+LST,0)),U)
 Q LST
 ;
GETCLST(RETURN,GMPCLIN) ; Get first list assigned to the clinic
 ; RETURN - Passed by reference, List IFN^List name
 ; GMPCLIN - Location IFN
 S RETURN=0
 I '$G(GMPCLIN) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPCLIN") Q 0
 I '$$FIND^GMPLAPI5("44",+GMPCLIN) D ERRX^GMPLAPIE(.RETURN,"LOCNFND") Q 0
 S RETURN=$$GETCLSTD(GMPCLIN)
 Q 1
 ;
GETCLSTD(GMPCLIN) ; Get first list assigned to the clinic
 ; RETURN - Passed by reference, List IFN^List name
 ; GMPCLIN - Location IFN
 N LST
 S:$D(^GMPL(125,"C",+GMPCLIN)) LST=$O(^GMPL(125,"C",+GMPCLIN,0))
 S $P(LST,U,2)=$P($G(^GMPL(125,+LST,0)),U)
 Q LST
 ;
VALGRP(RETURN,GMPLCAT) ; check all problems in the category for inactive codes
 ; RETURN  - Passed by reference
 ;    1    = category has no problems with inactive codes
 ;    0    = category has one or more problems with inactive codes
 ; GMPLCAT = ien from file 125.11
 S RETURN=0
 I '$G(GMPLCAT) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLCAT") Q 0
 I '$$FIND^GMPLAPI5("125.11",GMPLCAT) D ERRX^GMPLAPIE(.RETURN,"CTGNFND") Q 0
 S RETURN=$$VALGRPD(GMPLCAT)
 Q RETURN
 ;
VALLIST(RETURN,LIST) ;check all categories in list for probs w/ inactive codes
 ; RETURN - Passed by reference
 ;    1 = list has no problems with inactive codes
 ;    0 = list has one or more problems with inactive codes
 ; LIST = ien from file 125
 S RETURN=0
 I '$G(LIST) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","LIST") Q 0
 I '$$FIND^GMPLAPI5("125",LIST) D ERRX^GMPLAPIE(.RETURN,"LISTNFND") Q 0
 S RETURN=$$VALLISTD(LIST)
 Q RETURN
 ;
VALGRPD(GMPLCAT) ; check all problems in the category for inactive codes
 I '$G(GMPLCAT) Q 0
 N PROB,GMPLVALC
 S GMPLVALC=1,PROB=0
 F  S PROB=$O(^GMPL(125.12,"B",GMPLCAT,PROB)) Q:'PROB!('GMPLVALC)  D
 . N GMPLCOD
 . S GMPLCOD=$P(^GMPL(125.12,PROB,0),U,5)
 . Q:'$L(GMPLCOD)  ; no code there
 . I '$$STATCHK^ICDAPIU(GMPLCOD,DT) S GMPLVALC=0
 . Q
 Q GMPLVALC
 ;
VALLISTD(LIST) ;check all categories in list for probs w/ inactive codes
 N GMPLIEN,GMPLVAL
 I '$G(LIST) Q 0
 S GMPLIEN=0,GMPLVAL=1
 F  S GMPLIEN=$O(^GMPL(125.1,"B",LIST,GMPLIEN)) Q:'GMPLIEN!('GMPLVAL)  D
 . N GMPLCAT
 . S GMPLCAT=$P(^GMPL(125.1,GMPLIEN,0),U,3) I 'GMPLCAT Q
 . I '$$VALGRPD(GMPLCAT) S GMPLVAL=0
 . Q
 Q GMPLVAL
 ;
GETFINC(RETURN) ; check probs on lists for future inactivation dates
 ; returns:
 ;   ^TMP("GMPLSL",$J,"F",category,problem)
 ;   ^TMP("GMPLSL",$J,"F",category,"L",list)
 K @RETURN
 N PROB,CAT,LIST
 S PROB=0
 F  S PROB=$O(^GMPL(125.12,PROB)) Q:'PROB  I $L($P(^(PROB,0),U,5)) D
 . N PROB0,PROBTX,APIDATA,PROBCAT,ACTDT
 . S PROB0=^GMPL(125.12,PROB,0)
 . I '$$STATCHK^ICDAPIU($P(PROB0,U,5),DT) Q  ;already inactive
 . S APIDATA=$$HIST^ICDAPIU($P(PROB0,U,5),.APIDATA)
 . S ACTDT=+$O(APIDATA(DT))
 . Q:'ACTDT  ; no future activity
 . I $G(APIDATA(ACTDT)) Q  ; no future inactivation = OK
 . S PROBTX=$$GET1^DIQ(125.12,PROB,2)
 . S PROBCAT=$P(PROB0,U)
 . S @RETURN@(PROBCAT,PROB)=PROBTX_U_$P(PROB0,U,4)_U_$P(PROB0,U,5)_U_$$FMTE^XLFDT(ACTDT)
 . Q
 ;
 ; find lists that contain the categories
 S CAT=0
 F  S CAT=$O(@RETURN@(CAT)) Q:'CAT  D
 . I '$D(^GMPL(125.1,"G",CAT)) Q  ; category not part of any lists
 . N LIST S LIST=0
 . F  S LIST=$O(^GMPL(125.1,"G",CAT,LIST)) Q:'LIST  D
 .. S @RETURN@(CAT,"L",LIST)=$$GET1^DIQ(125.1,LIST,.01)
 .. Q
 . Q
 Q
 ;
ASSUSR(RETURN,GMPLLST,GMPLUSER) ; Assign Problem Selection List to users
 ; Input
 ;  GMPLLST   List IEN
 ;  GMPLUSER  List of users (^UserIEN^...)
 N DR
 S DR="125.1////"_+GMPLLST,RETURN=0
 S RETURN=$$USERLST(.RETURN,GMPLLST,GMPLUSER,DR)
 Q RETURN
 ;
REMUSR(RETURN,GMPLLST,GMPLUSER) ; Remove Problem Selection List from users
 ; Input
 ;  GMPLLST   List IEN
 ;  GMPLUSER  List of users (^UserIEN^...)
 S RETURN=0
 S RETURN=$$USERLST(.RETURN,GMPLLST,GMPLUSER,"125.1///@")
 Q RETURN
 ;
USERLST(RETURN,GMPLLST,GMPLUSER,ACTION) ; Add/Remove Problem Selection List from users
 I '$G(GMPLLST) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 N EXISTS,DIE,DR,DA,GMPLI,U,UE,RET
 S DIE="^VA(200,",U="^",UE=0,RET=0
 S EXISTS=$$FIND^GMPLAPI5("125",GMPLLST)
 I EXISTS'>0 D ERRX^GMPLAPIE(.RETURN,"LISTNFND") Q 0
 I '$$VALLIST^GMPLAPI6(RET,+GMPLLST) D ERRX^GMPLAPIE(.RETURN,"INACTICD") Q 0
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) D
 . I '$G(DA) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLUSER") S UE=1 Q
 . I '$$FIND^GMPLAPI5("200",DA) D ERRX^GMPLAPIE(.RETURN,"PROVNFND") S UE=1 Q
 Q:UE>0 0
 S DR=ACTION
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . D ^DIE
 Q 1
 ;
