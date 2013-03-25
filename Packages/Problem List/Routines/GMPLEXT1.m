GMPLEXT1 ; RGI -- DATA ACCESS LAYER - DIRECT GLOBALS ACCESS ; 3/25/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
GETUSRS(RETURN,SEARCH,START,NUMBER) ;
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 D LIST^DIC("200","","@;.01;1;.151;8","",NUMBER,.START,SEARCH,"","","","RETURN")
 I $L(SEARCH)>0,$P(RETURN("DILIST",0),U,1)'>0 D
 . D LIST^DIC("200","","@;.01;1;.151;8","",NUMBER,.START,$$UP^XLFSTR(SEARCH),"","","","RETURN")
 Q
 ;
GETASSUS(RETURN,GMPLST) ; Array of users assigned to specified list
 ; RETURN - Passed by reference, array of users
 ;  RETURN(0) = Number of users
 ;  RETURN(I,"ID") = user IFN
 ;  RETURN(I,"NAME") = user name
 ; GMPLST - problem list IFN
 N IND,RET,DL,LIST,LIN,CNT,ID
 S IND="",DL="DILIST"
 D LIST^DIC("200","","@;.01","",,,,,,,"RET")
 S RETURN(DL,0)="0^*^0^"
 S CNT=$P(RET(DL,0),"^",1),LIN=0
 F IND=1:1:CNT D
 . S ID=RET(DL,2,IND),LIST=""
 . S:$D(^VA(200,ID,125))>0 LIST=$P(^VA(200,ID,125),"^",2) Q:'$G(LIST)
 . I LIST=+GMPLST D
 . . S LIN=LIN+1
 . . S RETURN(DL,2,LIN)=ID
 . . S RETURN(DL,"ID",LIN,".01")=RET(DL,"ID",IND,".01")
 S RETURN(DL,0)=LIN_"^*^0^"
 Q
 ;
GETCLIN(RETURN,SEARCH,START,NUMBER) ;
 N RET,TYPE S DL="DILIST"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 D LIST^DIC("44","",,,NUMBER,.START,SEARCH,,"","","RET")
 S RETURN(DL,0)="0^"_$S(NUMBER="":"*",1:NUMBER)_"^0^"
 S CNT=$P(RET(DL,0),"^",1),LIN=0
 F IND=1:1:CNT D
 . S ID=RET(DL,2,IND)
 . S TYPE=$P(^SC(ID,0),U,3)
 . I TYPE="C" D
 . . S LIN=LIN+1
 . . S RETURN(DL,2,LIN)=ID
 . . S RETURN(DL,1,LIN)=$P(^SC(ID,0),U,1)
 S RETURN(DL,0)=LIN_"^"_$S(NUMBER="":"*",1:NUMBER)_"^0^"
 Q
 ;
LSTUSED(GMPLLST) ;
 N USER,VIEW,GMPCOUNT
 S GMPCOUNT=0
 F USER=0:0 S USER=$O(^VA(200,USER)) Q:USER'>0  D
 . S VIEW=$P($G(^VA(200,USER,125)),U,2) Q:'VIEW  Q:VIEW'=+GMPLLST
 . S GMPCOUNT=GMPCOUNT+1
 Q GMPCOUNT
 ;
GETULST(USER) ; Get user assigned problem selection list
 ; RETURN - Passed by reference, List IFN^List name
 ; USER - User IFN
 N LST
 S LST=$P($G(^VA(200,USER,125)),U,2)
 S $P(LST,U,2)=$P($G(^GMPL(125,+LST,0)),U)
 Q LST
 ;
ASSUSR(RETURN,GMPLLST,GMPLUSER) ; Assign Problem Selection List to user
 N DIE,DR,DA
 S DIE="^VA(200,"
 S DR="125.1////"_+$G(GMPLLST),RETURN=0
 S DA=GMPLUSER
 D ^DIE
 Q 1
 ;
REMUSR(RETURN,GMPLLST,GMPLUSER) ; Remove Problem Selection List from user
 N DIE,DR,DA
 S DIE="^VA(200,"
 S DR="125.1///@"
 S DA=GMPLUSER
 D ^DIE
 Q 1
 ;
LEXICON(LEX) ;
 Q:'+$G(LEX) ""
 Q $P($G(^LEX(757.01,+LEX,0)),U)
 ;
