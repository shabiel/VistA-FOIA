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
