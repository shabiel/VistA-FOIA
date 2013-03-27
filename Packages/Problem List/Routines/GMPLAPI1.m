GMPLAPI1 ;RGI/VSL -- Build Problem Selection Lists ; 3/27/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
NEWLST(RETURN,GMPLLST,GMPLLOC) ; Add new Problem Selection List
 ; Input
 ;  GMPLLST  Problem Selection List name
 ;  GMPLLOC  Location IEN
 ; Output:  IEN of Problem Selection List  
 N LOCERR,%
 S RETURN=0
 I '$$LSTNAME^GMPLCHK(.RETURN,.GMPLLST,"GMPLLST") Q 0
 I '$$SCIEN^GMPLCHK(.RETURN,.GMPLLOC,"GMPLLOC",1) Q 0
 I $$FINDLST^GMPLDAL1(GMPLLST)>0 D ERRX^GMPLAPIE(.RETURN,"LISTXST") Q 0
 S NEWLST=$$NEWLST^GMPLDAL1(GMPLLST)
 I +NEWLST'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 I $G(GMPLLOC)'="" S %=$$ADDLOC^GMPLAPI5(.RETURN,+NEWLST,+GMPLLOC)
 S RETURN=+NEWLST
 Q 1
 ;
DELLST(RETURN,GMPLLST) ; Delete Problem Selection List
 ; Input
 ;  GMPLLST  Problem Selection List IEN
 S RETURN=0
 I '$$LSTUSED(.RETURN,.GMPLLST) Q 0
 I RETURN>0 D  Q 0
 . D ERRX^GMPLAPIE(.RETURN,"LISTUSED",RETURN_" user(s) are currently assigned this list!")
 . S RETURN=0
 I '$$LOCKLST(.RETURN,GMPLLST) Q 0
 S RETURN=$$DELLST^GMPLDAL1(GMPLLST)
 D UNLKLST(GMPLLST)
 Q 1
 ;
LSTUSED(RETURN,GMPLLST) ; Return number of users assigned to this list
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 S RETURN=$$LSTUSED^GMPLEXT1(GMPLLST)
 Q 1
 ;
NEWCAT(RETURN,GMPLGRP,DUPLIC) ; Add new Category
 ; Input
 ;  GMPLGRP  Category name
 K RETURN S RETURN=0
 I '$$LSTNAME^GMPLCHK(.RETURN,.GMPLGRP,"GMPLGRP") Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.DUPLIC,"DUPLIC") Q 0
 N EXCAT,NEWCAT,RET S EXCAT=0,RET=0
 I '$G(DUPLIC) S EXCAT=$$FINDCATM^GMPLDAL1(GMPLGRP)
 I EXCAT>0 D ERRX^GMPLAPIE(.RETURN,"CTGEXIST") Q 0
 S NEWCAT=$$NEWCAT^GMPLDAL1(GMPLGRP,$G(DUPLIC))
 I +NEWCAT'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLGRP") Q 0
 S RETURN=NEWCAT
 Q 1
 ;
CATUSED(RETURN,GMPLGRP) ; Verify if category is used by a list
 ; Returns 0 if this category is not used by any list, 1 otherwise
 S RETURN=0
 I '$$CTGIEN^GMPLCHK(.RETURN,.GMPLGRP) Q 0
 S RETURN=$S($$CATUSED^GMPLDAL1(GMPLGRP):1,1:0)
 Q 1
 ;
DELCAT(RETURN,GMPLGRP) ; Delete category
 S RETURN=0
 I '$$CATUSED(.RETURN,GMPLGRP) Q 0
 I RETURN D  Q 0
 . D ERRX^GMPLAPIE(.RETURN,"CATUSED")
 . S RETURN=0
 S RETURN=$$DELCAT^GMPLDAL1(GMPLGRP)
 Q 1
 ;
LOCKLST(RETURN,GMPLLST) ; Lock speciefied list
 ; Returns 0 if list is already locked by another process, 1 otherwise
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 S RETURN=$$LOCKLST^GMPLDAL1(GMPLLST)
 Q RETURN
 ;
UNLKLST(GMPLLST) ; Unlock specified list
 ;
 I '+$G(GMPLLST) Q
 D UNLCKLST^GMPLDAL1(+GMPLLST)
 Q
 ;
LOCKCAT(RETURN,GMPLGRP) ; Lock speciefied category
 ; Returns 0 if category is already locked by another process, 1 otherwise
 S RETURN=0
 I '$$CTGIEN^GMPLCHK(.RETURN,.GMPLGRP) Q 0
 S RETURN=$$LOCKCAT^GMPLDAL1(GMPLGRP)
 Q RETURN
 ;
UNLKCAT(GMPLGRP) ; Unlock specified category
 ;
 I '+$G(GMPLGRP) Q
 D UNLCKCAT^GMPLDAL1(GMPLGRP)
 Q
 ;
GETLIST(RETURN,GMPLLST,CODLEN,MINIM) ; Return Problem Selection list details
 ; Input
 ;  GMPLLST: Problem Selection list IEN
 ;  RETURN: Root of the target local or global.
 ;  CODLEN: MaxLength of the problem name
 ; Result:
 ;  RETURN("LST","NAME") - Selection List name
 ;  RETURN("LST","MODIFIED") - Date last modified
 ;  RETURN("LST","CLINIC") - Assigned Clinic
 ;  RETURN(0) - Number of categories
 ;  RETURN(List_Content_IEN)= seq ^ group ^ subhdr ^ probs
 ;  RETURN("GRP",Category_IEN)=List_Content_IEN
 ;  RETURN("SEQ",# Sequence)=List_Content_IEN
 ;  RETURN("GRP",Category_IEN,# Sequence)=Problem name^Problem code^Inactive flag 
 ;   (1 for inactive code, 0 for active)
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 I '$$NUM^GMPLCHK(.RETURN,.CODLEN,"CODLEN",1,0,1) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.MINIM,"MINIM") Q 0
 N GRP,LISTIFN,LIST,%
 ;S LISTIFN=$$FINDLST^GMPLDAL1(GMPLLST)
 S %=$$GETLIST^GMPLDAL1(.RETURN,GMPLLST,$G(CODLEN),$G(MINIM))
 S $P(RETURN("LST","MODIFIED"),U,2)=$S(+RETURN("LST","MODIFIED"):$$FMTE^XLFDT(RETURN("LST","MODIFIED")),1:"<new list>")
 S $P(RETURN("LST","CLINIC"),U,2)=$$CLINNAME^GMPLEXT(RETURN("LST","CLINIC"))
 Q:$G(MINIM)>0 1
 S GRP=0
 F  S GRP=$O(RETURN("GRP",GRP)) Q:GRP'>0  D
 . S %=$$GETCATD^GMPLAPI5(.RETURN,+GRP,$G(CODLEN))
 S RETURN=1
 Q 1
 ;
GETCAT(RETURN,GMPLGRP) ; Return category details
 ; Input
 ;  GMPLGRP: Problem Selection list IEN
 ;  RETURN: Root of the target local or global.
 ; Result:
 ;  RETURN(Problem_IEN)=Sequence^Poiter_to_Problem(757.01)^Display_text^ICD_Code
 ;  RETURN(Problem_IEN,"CODE")=ICD_Code^Inactive_flag
 ;  RETURN("SEQ",Sequence #)=Problem_IEN
 ;  RETURN("PROB",Poiter_to_Problem(757.01))=Problem_IEN
 S RETURN=0
 I '$$CTGIEN^GMPLCHK(.RETURN,.GMPLGRP) Q 0
 N MODIF,SEQ,IFN,PROB,CNT,CODE,CAT,FLAG,%
 S %=$$GETCAT^GMPLDAL1(.RETURN,GMPLGRP)
 S SEQ=0
 S MODIF=RETURN("CAT","MODIFIED")
 S $P(RETURN("CAT","MODIFIED"),U,2)=$S(+MODIF:$$FMTE^XLFDT(MODIF),1:"<new category>")
 F  S SEQ=$O(RETURN("SEQ",SEQ)) Q:SEQ'>0  D
 . S IFN=$G(RETURN("SEQ",SEQ))
 . S CODE=$G(RETURN(IFN,"CODE"))
 . I $L(CODE) D
 .. I $$STATCHK^ICDAPIU(CODE,DT) S FLAG=0  ; OK - code is active
 .. E  S FLAG=1
 .. S RETURN(IFN,"CODE")=CODE_"^"_FLAG
 S RETURN=1
 Q 1
 ;
SAVLST(RETURN,GMPLLST,SOURCE) ; Save changes to existing list
 S RETURN=0
 I '$$LSTIEN^GMPLCHK(.RETURN,.GMPLLST) Q 0
 I $D(SOURCE)<10 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","SOURCE") Q 0
 N TMPLST,DA,DT,INV,%
 S DA=0,INV=1 ; check SOURCE param
 F  S DA=$O(SOURCE(DA)) Q:+DA'>0  D 
 . Q:INV=0
 . I DA'?.N.1"N" S INV=0 Q
 . I $L($G(SOURCE(DA)))'>0 S INV=0 Q
 . I +DA=DA D  Q  ; new link
 . . I $L($$GETLSTGR^GMPLDAL1(DA))'>0 S INV=0 Q
 . I "@"[$G(SOURCE(DA)) Q
 . S TMPLST=$P(SOURCE(DA),"^",2) I $L(TMPLST)'>0 S INV=0 Q
 . I $L($P(SOURCE(DA),"^",3))'>0 S INV=0 Q
 . S INV=$$FINDCAT^GMPLDAL1(TMPLST)
 I INV=0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","SOURCE") Q 0
 S DT=$P($$HTFM^XLFDT($H),".")
 S %=$$SAVLST^GMPLDAL1(.RETURN,GMPLLST,.SOURCE,DT)
 S RETURN=1
 Q 1
 ;
SAVGRP(RETURN,GMPLGRP,SOURCE) ; Save changes to existing group
 N IDX,SRCERR,SEQ,TERM,CODE
 K RETURN
 S RETURN=0
 I '$$CTGIEN^GMPLCHK(.RETURN,.GMPLGRP) Q 0
 I $D(SOURCE)<10 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","SOURCE") Q 0
 S IDX=0,SRCERR=0
 F  S IDX=$O(SOURCE(IDX)) Q:+IDX'>0!SRCERR  D
 . I IDX'?.N.1"N" D  Q
 . . S SRCERR=1
 . . D ERRX^GMPLAPIE(.RETURN,"INVPARAM","SOURCE")
 . I "@"[SOURCE(IDX) Q
 . I +IDX=IDX,'$$CTGITM^GMPLCHK(.RETURN,IDX) S SRCERR=1 Q
 . S SEQ=$P(SOURCE(IDX),U)
 . S TERM=$P(SOURCE(IDX),U,2)
 . S CODE=$P(SOURCE(IDX),U,4)
 . I '$$NUM^GMPLCHK(.RETURN,SEQ,"SEQ, SOURCE("_IDX_")",1,2) S SRCERR=1 Q
 . I '$$TERMIEN^GMPLCHK(.RETURN,TERM,"TERM, SOURCE("_IDX_")") S SRCERR=1 Q
 . I CODE'="",'$$ICDCODE^GMPLCHK(.RETURN,+$$CODEN^ICDCODE(CODE),"CODE, SOURCE("_IDX_")",1) S SRCERR=1 Q
 I SRCERR Q 0 
 S %=$$SAVGRP^GMPLDAL1(.RETURN,GMPLGRP,.SOURCE)
 S RETURN=1
 Q 1
 ;
