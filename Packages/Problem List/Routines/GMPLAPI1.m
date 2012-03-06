GMPLAPI1 ;; Build Problem Selection Lists ; 02/21/12 10:23
 ;;;Problem List;;02/21/12
NEWLST(GMPLLST,GMPLLOC,ERT) ; Add new Problem Selection List
 ; Input
 ;  GMPLLST  Problem Selection List name
 ;  GMPLLOC  Location IEN
 ; Output:  IEN of Problem Selection List  
 N LOCERR S LOCERR=0
 I '$G(GMPLLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLLST") Q 0
 I $L($G(GMPLLOC))>0 D
 . I +$G(GMPLLOC)'>0 D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLLOC")
 . S:+$G(GMPLLOC)'>0 LOCERR=1
 Q:LOCERR=1 0
 N EXLST,NEWLST,LOCQ
 S EXLST=$$FIND("125",GMPLLST),LOCQ=0
 I EXLST>0 D ERR^GMPLAPIE(.ERT,"LISTEXIST") Q EXLST
 I $G(GMPLLOC) D
 . I '$$FIND(44,GMPLLOC) D ERR^GMPLAPIE(.ERT,"LOCNOTFOUND") S LOCQ=1
 Q:LOCQ=1 0
 S NEWLST=$$CREATE(GMPLLST,"^GMPL(125,","125")
 I +NEWLST'>0 D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLLST") Q 0
 I $G(GMPLLOC) D ADDLOC(NEWLST,GMPLLOC,.ERT)
 Q NEWLST
 ;
ASSGNUSR(GMPLSLST,GMPLUSER,ERT) ; Assign Problem Selection List to users
 ; Input
 ;  GMPLLST   List IEN
 ;  GMPLUSER  List of users (^UserIEN^...)
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q 0
 N EXISTS,DIE,DR,DA,GMPLI,U,UE
 S DIE="^VA(200,",U="^",UE=0,EXISTS=$$FIND("125",GMPLSLST)
 I EXISTS'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 I '$$VALLIST^GMPLBLD2(+GMPLSLST) D ERR^GMPLAPIE(.ERT,"INACTIVEICD9") Q
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . I '$G(DA) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLUSER") S UE=1 Q
 . I '$$FIND("200",DA) D ERR^GMPLAPIE(.ERT,"PROVNOTFOUND") S UE=1
 Q:UE>0
 S DR="125.1////"_+GMPLSLST
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . D ^DIE
 Q
 ;
REMUSR(GMPLSLST,GMPLUSER,ERT) ; Remove Problem Selection List from users
 ; Input
 ;  GMPLLST   List IEN
 ;  GMPLUSER  List of users (^UserIEN^...)
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q 0
 N EXISTS,DIE,DR,DA,GMPLI,U,UE
 S DIE="^VA(200,",U="^",UE=0,EXISTS=$$FIND("125",GMPLSLST)
 I EXISTS'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 I '$$VALLIST^GMPLBLD2(+GMPLSLST) D ERR^GMPLAPIE(.ERT,"INACTIVEICD9") Q
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . I '$G(DA) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLUSER") S UE=1 Q
 . I '$$FIND("200",DA) D ERR^GMPLAPIE(.ERT,"PROVNOTFOUND") S UE=1
 Q:UE>0
 S DR="125.1///@"
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . D ^DIE
 Q
 ;
DELSLST(GMPLSLST,SCREEN,ERT) ; Delete Problem Selection List
 ; Input
 ;  GMPLSLST  Problem Selection List IEN
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q
 N U,USER,VIEW,GMPCOUNT,DIK,DA
 S GMPCOUNT=0,U="^",EXISTS=$$FIND("125",GMPLSLST)
 I EXISTS'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 F USER=0:0 S USER=$O(^VA(200,USER)) Q:USER'>0  D
 . S VIEW=$P($G(^VA(200,USER,125)),U,2) Q:'VIEW  Q:VIEW'=+GMPLSLST
 . S GMPCOUNT=GMPCOUNT+1
 I $$LSTUSED(GMPLSLST,"",.ERT) D ERR^GMPLAPIE(.ERT,"LISTUSED",GMPCOUNT_" user(s) are currently assigned this list!") Q
 Q:'$$LOCKLST(GMPLSLST,.ERT)
 S DIK="^GMPL(125.1,",DA=0
 F  S DA=$O(^GMPL(125.1,"B",+GMPLSLST,DA)) Q:DA'>0  D ^DIK
 S DA=+GMPLSLST,DIK="^GMPL(125," D ^DIK X:SCREEN]"" SCREEN
 D UNLKLST(GMPLSLST)
 Q
 ;
LSTUSED(GMPLSLST,SCREEN,ERT) ; Return number of users assigned to this list
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q
 I $$FIND("125",GMPLSLST)'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 N USER,VIEW,GMPCOUNT
 S GMPCOUNT=0
 F USER=0:0 S USER=$O(^VA(200,USER)) Q:USER'>0  D
 . S VIEW=$P($G(^VA(200,USER,125)),U,2) Q:'VIEW  Q:VIEW'=+GMPLSLST
 . S GMPCOUNT=GMPCOUNT+1 X:SCREEN]"" SCREEN
 Q GMPCOUNT
 ;
NEWCAT(GMPLGRP,ERT) ; Add new Category
 ; Input
 ;  GMPLCAT  Category name
 I '$G(GMPLCAT) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLGRP") Q 0
 N EXCAT,NEWCAT
 S EXCAT=$$FIND("125.11",GMPLGRP)
 I EXCAT>0 D ERR^GMPLAPIE(.ERT,"CATEGEXIST") Q EXCAT
 S NEWCAT=$$CREATE(GMPLGRP,"^GMPL(125.11,","125.11")
 I +NEWCAT'>0 D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLGRP") Q 0
 Q NEWCAT
 ;
CATUSED(GMPLGRP,ERT) ; Verify if category is used by a list
 ; Returns 0 if this category is not used by any list, 1 otherwise
 Q $D(^GMPL(125.1,"G",+GMPLGRP))
 ;
DELCAT(GMPLGRP,SCREEN,ERT) ; Delete catagory
 I '$G(GMPLGRP) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLGRP") Q 0
 I $$FIND("125.11",GMPLGRP)'>0 D ERR^GMPLAPIE(.ERT,"CATNOTFOUND") Q 0
 I $$CATUSED(GMPLGRP,.ERT) D ERR^GMPLAPIE(.ERT,"CATUSED") Q 0
 N IFN,DA,DIK
 F IFN=0:0 S IFN=$O(^GMPL(125.12,"B",+GMPLGRP,IFN)) Q:IFN'>0  D
 . Q:IFN'>0  S DA=IFN,DIK="^GMPL(125.12," D ^DIK
 . X:SCREEN]"" SCREEN
 S DA=+GMPLGRP,DIK="^GMPL(125.11," D ^DIK X:SCREEN]"" SCREEN
 Q
 ;
FIND(FILENO,EL) ; Lookup
 ; Input
 ;  EL      IEN or name of the record
 ;  FILENO  File number
 ; Output:
 ;  0   - if no exact matches are found
 ;  IEN - if a single match is found
 N PRE S PRE=""
 I +EL>0 S EL=+EL,PRE="`"
 Q $$FIND1^DIC(FILENO,"","MX",PRE_EL,"","","ERR")
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
ADDLOC(GMPLLST,GMPLLOC,ERT) ; Add location to list
 I '$G(GMPLLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLLST") Q 0
 I '$G(GMPLLOC) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLLOC") Q 0
 N DIE,DA,DR
 Q:'$$LOCKLST(GMPLLST,.ERT) 0
 S DIE="^GMPL(125,",DA=+GMPLLST,DR=".03////"_+GMPLLOC D ^DIE
 D UNLKLST(GMPLLST)
 Q 1
 ;
LOCK(TARGET,ERT) ; Lock the TARGET
 L +@TARGET:1
 I '$T D ERR^GMPLAPIE(.ERT,"FILELOCKED") Q 0
 Q 1
 ;
UNLOCK(TARGET) ; Unlock the TARGET
 L -@TARGET
 Q
 ;
LOCKLST(GMPIFN,ERT) ; Lock speciefied list
 ; Returns 0 if list is already locked by another process, 1 otherwise
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q 0
 I $$FIND("125",GMPLSLST)'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q 0
 Q $$LOCK("^GMPL(125,"_+GMPIFN_",0)",.ERT)
 ;
UNLKLST(GMPIFN) ; Unlock specified list
 ;
 I $$FIND("125",GMPLSLST)'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 D UNLOCK("^GMPL(125,"_+GMPIFN_",0)")
 Q
 ;
LOCKCAT(GMPIFN,ERT) ; Lock speciefied category
 ; Returns 0 if category is already locked by another process, 1 otherwise
 I '$G(GMPIFN) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPIFN") Q 0
 I $$FIND("125.11",GMPIFN)'>0 D ERR^GMPLAPIE(.ERT,"CATNOTFOUND") Q 0
 Q $$LOCK("^GMPL(125.11,"_+GMPIFN_",0)",.ERT)
 ;
UNLKCAT(GMPIFN) ; Unlock specified category
 ;
 I '$G(GMPIFN) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPIFN") Q
 D UNLOCK("^GMPL(125.11,"_+GMPIFN_",0)")
 Q
 ;
GETLIST(GMPIFN,TARGET,CODLEN,ERT) ; Return Problem Selection list details
 ; Input
 ;  GMPIFN: Problem Selection list IEN
 ;  TARGET: Root of the target local or global.
 ;  CODLEN: MaxLength of the problem name
 ; Result:
 ;  TARGET("LST","NAME") - Selection List name
 ;  TARGET("LST","MODIFIED") - Date last modified
 ;  TARGET(0) - Number of categories
 ;  TARGET(List_Content_IEN)= seq ^ group ^ subhdr ^ probs
 ;  TARGET("GRP",Category_IEN)=List_Content_IEN
 ;  TARGET("SEQ",# Sequence)=List_Content_IEN
 ;  TARGET("GRP",Category_IEN,# Sequence)=Problem name^Problem code^Inactive flag 
 ;   (1 for inactive code, 0 for active)
 I '$G(GMPIFN) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPIFN") Q
 N IFN,SEQ,GRP,ITEM,CNT,LISTIFN,LIST
 S LISTIFN=$$FIND("125",GMPIFN)
 I LISTIFN'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q 
 S CNT=0,LIST=^GMPL(125,LISTIFN,0)
 S @TARGET@("LST","NAME")=$P(LIST,"^",1)
 S @TARGET@("LST","MODIFIED")=$S(+$P(LIST,U,2):$$FMTE^XLFDT($P(LIST,U,2)),1:"<new list>")
 F IFN=0:0 S IFN=$O(^GMPL(125.1,"B",LISTIFN,IFN)) Q:IFN'>0  D
 . S ITEM=$G(^GMPL(125.1,IFN,0)),SEQ=$P(ITEM,U,2),GRP=$P(ITEM,U,3)
 . S @TARGET@(IFN)=$P(ITEM,U,2,5),CNT=CNT+1 ; seq ^ group ^ subhdr ^ probs
 . S (@TARGET@("GRP",GRP),@TARGET@("SEQ",SEQ))=IFN
 . D GETCATD(GRP,TARGET,CODLEN,.ERR)
 S @TARGET@(0)=CNT
 Q
 ;
GETCAT(GMPIFN,TARGET,ERT) ; Return category details
 ; Input
 ;  GMPIFN: Problem Selection list IEN
 ;  TARGET: Root of the target local or global.
 ; Result:
 ;  TARGET(Problem_IEN)=Sequence^Poiter_to_Problem(757.01)^Display_text^ICD_Code
 ;  TARGET(Problem_IEN,"CODE")=ICD_Code^Inactive_flag
 ;  TARGET("SEQ",Sequence #)=Problem_IEN
 ;  TARGET("PROB",Poiter_to_Problem(757.01))=Problem_IEN
 I '$G(GMPIFN) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPIFN") Q
 I $$FIND("125.11",GMPIFN)'>0 D ERR^GMPLAPIE(.ERT,"CATNOTFOUND") Q 
 N SEQ,IFN,ITEM,PROB,CNT,CODE S CNT=0
 F IFN=0:0 S IFN=$O(^GMPL(125.12,"B",+GMPIFN,IFN)) Q:IFN'>0  D
 . S ITEM=$G(^GMPL(125.12,IFN,0)),SEQ=$P(ITEM,U,2),PROB=$P(ITEM,U,3)
 . S @TARGET@(IFN)=$P(ITEM,U,2,5),CNT=CNT+1 ; seq ^ prob ^ text ^ code
 . S (@TARGET@("PROB",PROB),@TARGET@("SEQ",SEQ))=IFN,CODE=$P(ITEM,U,5) ; Xrefs
 . I $L(CODE) D
 .. I $$STATCHK^ICDAPIU(CODE,DT) S FLAG=0  ; OK - code is active
 .. E  S FLAG=1
 .. S @TARGET@(IFN,"CODE")=CODE_"^"_FLAG
 S @TARGET@(0)=CNT
 Q
 ;
GETCATD(GMPIFN,TARGET,CODLEN,ERT) ; Return Category details
 ; Input
 ;  GMPIFN: Category IEN
 ;  TARGET: Root of the target local or global.
 ;  CODLEN: MaxLength of the problem name
 ; Result:
 ;  TARGET("GRP",Category_IEN,# Sequence)=Problem name^Problem code^Inactive flag
 I '$G(GMPIFN) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPIFN") Q
 I $$FIND("125.11",GMPIFN)'>0 D ERR^GMPLAPIE(.ERT,"CATNOTFOUND") Q 
 N PSEQ,IFN,ITEM,LINE,GROUP,FLAG
 S LINE=0,GROUP=+GMPIFN
 F PSEQ=0:0 S PSEQ=$O(^GMPL(125.12,"C",+GROUP,PSEQ)) Q:PSEQ'>0  D
 . S IFN=$O(^GMPL(125.12,"C",+GROUP,PSEQ,0))
 . S ITEM=$G(^GMPL(125.12,IFN,0)),LINE=LINE+1
 . S DIAG=$P(ITEM,U,4)
 . I $G(CODLEN) S DIAG=$E(DIAG,1,CODLEN)
 . S @TARGET@("GRP",GROUP,LINE)=DIAG
 . I $L($P(ITEM,U,5)) D
 .. I $$STATCHK^ICDAPIU($P(ITEM,U,5),DT) S FLAG=0  ; code is active
 .. E  S FLAG=1
 .. S @TARGET@("GRP",GROUP,LINE)=@TARGET@("GRP",GROUP,LINE)_"^"_$P(ITEM,U,5)_"^"_FLAG
 Q
 ;
SAVLST(GMPLSLST,SOURCE,DT,ERT) ; Save changes to existing list
 I '$G(GMPLSLST) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLSLST") Q
 I $$FIND("125",GMPLSLST)'>0 D ERR^GMPLAPIE(.ERT,"LISTNOTFOUND") Q
 N IFN,SEQ,GRP,ITEM,CNT,LISTIFN,LIST
 N DIK,DIE,DR,ITEM,TMPLST,DA
 S DIE="^GMPL(125,",DA=+GMPLSLST,DR=".02////"_DT D ^DIE ; set modified date
 S DA=0
 F  S DA=$O(@SOURCE@(DA)) Q:+DA'>0  D
 .S DIK="^GMPL(125.1,"
 .I +DA'=DA D  Q  ; new link
 .. Q:"@"[$G(@SOURCE@(DA))  ; nothing to save
 .. S TMPLST=@SOURCE@(DA) D NEW(DIK,+GMPLSLST,TMPLST)
 .I "@"[$G(@SOURCE@(DA)) D ^DIK Q
 .S ITEM=$P($G(^GMPL(125.1,DA,0)),U,2,5)
 .I ITEM'=@SOURCE@(DA) D
 .. S DR="",DIE=DIK
 .. F I=1,2,3,4 D
 ... S:$P(@SOURCE@(DA),U,I)'=$P(ITEM,U,I) DR=DR_";"_I_"////"_$S($P(@SOURCE@(DA),U,I)="":"@",1:$P(@SOURCE@(DA),U,I))
 .. S:$E(DR)=";" DR=$E(DR,2,999) D ^DIE
 Q
 ;
SAVGRP(GMPLCAT,SOURCE,DT,ERT) ; Save changes to existing group
 I '$G(GMPLCAT) D ERR^GMPLAPIE(.ERT,"INVALIDPARAM","GMPLCAT") Q
 I $$FIND("125.11",GMPLCAT)'>0 D ERR^GMPLAPIE(.ERT,"CATNOTFOUND") Q 
 N DIK,DIE,DR,ITEM,TMPITEM
 S DIE="^GMPL(125.11,",DA=+GMPLCAT,DR="1////"_DT D ^DIE ; set modified date
 F  S DA=$O(@SOURCE@(DA)) Q:+DA'>0  D
 .S DIK="^GMPL(125.12,"
 .I +DA'=DA D  Q
 .. Q:"@"[$G(@SOURCE@(DA))  ; nothing to save
 .. S TMPITEM=@SOURCE@(DA) D NEW(DIK,+GMPLGRP,TMPITEM)
 .I "@"[$G(@SOURCE@(DA)) D ^DIK Q
 .S ITEM=$P($G(^GMPL(125.12,DA,0)),U,2,5)
 .I ITEM'=@SOURCE@(DA) D
 .. S DR="",DIE=DIK
 .. F I=1:1:4 D
 ... S:$P(@SOURCE@(DA),U,I)'=$P(ITEM,U,I) DR=DR_";"_I_"////"_$S($P(@SOURCE@(DA),U,I)="":"@",1:$P(@SOURCE@(DA),U,I))
 .. S:$E(DR)=";" DR=$E(DR,2,999) D ^DIE
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
