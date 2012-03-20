GMPLAPI5 ;; Build Problem Selection Lists ; 03/13/12 10:23
 ;;;Problem List;;02/21/12
USERLST(RETURN,GMPLLST,GMPLUSER,ACTION) ; Add/Remove Problem Selection List from users
 I '$G(GMPLLST) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 N EXISTS,DIE,DR,DA,GMPLI,U,UE
 S DIE="^VA(200,",U="^",UE=0,EXISTS=$$FIND("125",GMPLLST)
 I EXISTS'>0 D ERRX^GMPLAPIE(.RETURN,"LISTNFND") Q 0
 I '$$VALLIST^GMPLBLD2(+GMPLLST) D ERRX^GMPLAPIE(.RETURN,"INACTICD") Q 0
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) D
 . I '$G(DA) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLUSER") S UE=1 Q
 . I '$$FIND("200",DA) D ERRX^GMPLAPIE(.RETURN,"PROVNFND") S UE=1 Q
 Q:UE>0 0
 S DR=ACTION
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . D ^DIE
 Q 1
 ;
FIND(FILENO,EL) ; Lookup
 ; Input
 ;  EL      IEN or name of the record
 ;  FILENO  File number
 ; Output:
 ;  0   - if no exact matches are found
 ;  IEN - if a single match is found
 N PRE,TEXT S TEXT=EL,PRE=""
 I +EL>0 S TEXT=+EL,PRE="`"
 Q $$FIND1^DIC(FILENO,"","MX",PRE_TEXT,"","","ERR")
 ;
CREATE(GMPLNAME,GMPLFILE,GMPLFN) ; Create simple record
 ; Input
 ;  GMPLNAME  Name of the new record
 ;  GMPLFILE  File name
 ;  GMPLFN    File number
 ; Output
 ;  IEN  New record IEN
 ;  -1   On error
 N DIC,X,Y,DLAYGO
 S DIC=GMPLFILE,DIC(0)="OMZLX",DLAYGO=GMPLFN,X=GMPLNAME
 D ^DIC S:Y>0 Y=+Y_U_Y(0) Q Y
 ;
ADDLOC(RETURN,GMPLLST,GMPLLOC) ; Add location to list
 S RETURN=0
 I '$G(GMPLLST) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 I '$G(GMPLLOC) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLOC") Q 0
 N DIE,DA,DR
 Q:'$$LOCKLST^GMPLAPI1(.RETURN,GMPLLST) 0
 S DIE="^GMPL(125,",DA=+GMPLLST,DR=".03////"_+GMPLLOC D ^DIE
 D UNLKLST^GMPLAPI1(GMPLLST)
 S RETURN=1
 Q 1
 ;
LOCK(RETURN,TARGET) ; Lock the TARGET
 L +@TARGET:1
 I '$T D ERRX^GMPLAPIE(.RETURN,"FILELOCKED") Q 0
 Q 1
 ;
UNLOCK(TARGET) ; Unlock the TARGET
 L -@TARGET
 Q
 ;
NEW(DIK,LIST,ITEM) ; Create new entry in Contents file #125.1 or #125.12
 N I,HDR,LAST,TOTAL,DA
 S HDR=$G(@(DIK_"0)")),LAST=$P(HDR,U,3),TOTAL=$P(HDR,U,4)
 F I=(LAST+1):1 Q:'$D(@(DIK_"I,0)"))
 S DA=I,@(DIK_"DA,0)")=LIST_U_ITEM
 S $P(@(DIK_"0)"),U,3,4)=DA_U_(TOTAL+1)
 D IX1^DIK ; set Xrefs
 Q
 ;
GETCATD(RETURN,GMPLGRP,CODLEN) ; Return Category details
 ; Input
 ;  GMPLGRP: Category IEN
 ;  RETURN: Root of the target local or global.
 ;  CODLEN: MaxLength of the problem name
 ; Result:
 ;  RETURN("GRP",Category_IEN,# Sequence)=Problem name^Problem code^Inactive flag
 S @RETURN=0
 I '$G(GMPLGRP) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLGRP") Q 0
 I $$FIND("125.11",GMPLGRP)'>0 D ERRX^GMPLAPIE(.RETURN,"CTGNFND") Q 0
 N PSEQ,IFN,ITEM,LINE,GROUP,FLAG
 S LINE=0,GROUP=+GMPLGRP
 F PSEQ=0:0 S PSEQ=$O(^GMPL(125.12,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . S IFN=$O(^GMPL(125.12,"C",+GROUP,PSEQ,0))
 . S ITEM=$G(^GMPL(125.12,IFN,0)),LINE=LINE+1
 . S DIAG=$P(ITEM,U,4)
 . I $G(CODLEN) S DIAG=$E(DIAG,1,CODLEN)
 . S @RETURN@("GRP",GROUP,LINE)=DIAG
 . I $L($P(ITEM,U,5)) D
 .. I $$STATCHK^ICDAPIU($P(ITEM,U,5),DT) S FLAG=0  ; code is active
 .. E  S FLAG=1
 .. S @RETURN@("GRP",GROUP,LINE)=@RETURN@("GRP",GROUP,LINE)_"^"_$P(ITEM,U,5)_"^"_FLAG_"^"_$P(ITEM,U,3)
 S @RETURN=1
 Q 1
 ;
GETLSTS(RETURN,SEARCH,START,NUMBER) ; Array of problem selection lists
 ; RETURN - Passed by reference, array of problem selection lists
 ;  RETURN(0) = Number of lists
 ;  RETURN(I,"ID") = list IFN
 ;  RETURN(I,"NAME") = list name
 ; SEARCH - string to search
 ; START - start of search
 ; NUMBER - max number of records
 N RET,DL
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 S RETURN=0
 D GETLIST(.RET,SEARCH,START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . S RETURN(IN)=""
 . I $D(RET(DL,1,IN))>0 D
 . . S RETURN(IN,"ID")=RET(DL,2,IN)
 . . S RETURN(IN,"NAME")=RET(DL,1,IN)
 . E  D
 . . S RETURN(IN,"ID")=RET(DL,2,IN)
 . . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 . . S:$D(RET(DL,"ID",IN,".03")) RETURN(IN,"CLINIC")=RET(DL,"ID",IN,".03")
 S RETURN=1
 Q 1
 ;
GETLIST(RETURN,SEARCH,START,NUMBER) ;
 N FILE,FIELDS
 S FILE="125",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 D LIST^DIC(FILE,"",FIELDS,"",NUMBER,START,SEARCH,"B","","","RETURN")
 I $P(RETURN("DILIST",0),U,1)'>0 D
 . S FIELDS="@;.01;.03"
 . D LIST^DIC(FILE,"",FIELDS,"",NUMBER,START,SEARCH,"C","","","RETURN")
 Q
 ;
GETCATG(RETURN,SEARCH,START,NUMBER) ;
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 D LIST^DIC("125.11","","","",NUMBER,START,SEARCH,"","","","RETURN")
 Q
 ;
GETCATS(RETURN,SEARCH,START,NUMBER) ; Array of problem category
 ; RETURN - Passed by reference, array of problem category
 ;  RETURN(0) = Number of categories
 ;  RETURN(I,"ID") = category IFN
 ;  RETURN(I,"NAME") = category name
 ; SEARCH - string to search
 ; START - start of search
 ; NUMBER - max number of records
 N RET,DL
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 S RETURN=0
 D GETCATG(.RET,SEARCH,START,NUMBER)
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
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 D GETUSRSD(.RET,SEARCH,START,NUMBER)
 D BUILDUSR(.RETURN,.RET)
 Q 1
 ;
BUILDUSR(RETURN,RET) ;
 N DL
 S DL="DILIST"
 S RETURN(0)=RET(DL,0)
 F IN=1:1:$P(RETURN(0),U,1) D
 . Q:$D(RET(DL,1,IN))'>0
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,1,IN)
 . S:$D(RET(DL,"ID",IN,1)) RETURN(IN,"INITIAL")=RET(DL,"ID",IN,1)
 . S:$D(RET(DL,"ID",IN,28)) RETURN(IN,"EMAIL")=RET(DL,"ID",IN,28)
 . S:$D(RET(DL,"ID","WRITE",IN,1)) RETURN(IN,"WRITE")=RET(DL,"ID","WRITE",IN,1)
 Q
 ;
GETUSRSD(RETURN,SEARCH,START,NUMBER) ;
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 D LIST^DIC("200","",,"",NUMBER,START,SEARCH,"","","","RETURN")
 Q
 ;
GETASUSR(RETURN,GMPLST) ;
 N RET
 D GETASUSD(.RET,GMPLST)
 D BUILDUSR(.RETURN,.RET)
 Q 1
 ;
GETASUSD(RETURN,GMPLST) ; Array of users assigned to specified list
 ; RETURN - Passed by reference, array of users
 ;  RETURN(0) = Number of users
 ;  RETURN(I,"ID") = user IFN
 ;  RETURN(I,"NAME") = user name
 ; GMPLST - problem list IFN
 N IND,RET,DL,LIST,LIN,CNT S IND="",DL="DILIST"
 D LIST^DIC("200","","@;.01","",,,,,,,"RET")
 S RETURN(DL,0)="0^*^0^"
 S CNT=$P(RET(DL,0),"^",1),LIN=0
 F IND=1:1:CNT D
 . S ID=RET(DL,2,IND),LIST=""
 . S:$D(^VA(200,ID,125))>0 LIST=$P(^VA(200,ID,125),"^",2) Q:'$G(LIST)
 . I LIST=+GMPLST D
 . . S LIN=LIN+1
 . . S RETURN(DL,2,LIN)=ID
 . . S RETURN(DL,1,LIN)=RET(DL,"ID",IND,".01")
 S RETURN(DL,0)=LIN_"^*^0^"
 Q
 ;
GETCLIND(RETURN,SEARCH,START,NUMBER) ;
 N RET S DL="DILIST"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER="" ;,START="C",SEARCH="C"
 D LIST^DIC("44","",,,NUMBER,START,SEARCH,,"","","RET")
 S RETURN(DL,0)="0^*^0^"
 S CNT=$P(RET(DL,0),"^",1),LIN=0
 F IND=1:1:CNT D
 . S ID=RET(DL,2,IND)
 . S TYPE=$P(^SC(ID,0),U,3)
 . I TYPE="C" D
 . . S LIN=LIN+1
 . . S RETURN(DL,2,LIN)=ID
 . . S RETURN(DL,1,LIN)=$P(^SC(ID,0),U,1)
 S RETURN(DL,0)=LIN_"^*^0^"
 Q
 ;
GETCLIN(RETURN,SEARCH,START,NUMBER) ; Array of clinical locations
 ; RETURN - Passed by reference, array of locations
 ;  RETURN(0) = Number of locations
 ;  RETURN(I,"ID") = location IFN
 ;  RETURN(I,"NAME") = location name
 ; SEARCH - string to search
 ; START - start of search
 ; NUMBER - max number of records
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 N RET,DL
 S RETURN=0
 D GETCLIND(.RET,SEARCH,START,NUMBER)
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
