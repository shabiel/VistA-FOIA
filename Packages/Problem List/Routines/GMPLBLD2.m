GMPLBLD2 ; SLC/MKB,JFR -- Bld PL Selection Lists cont ; 3/14/03 11:20
 ;;2.0;Problem List;**3,28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991
 ;
NEWGRP ; Change problem groups
 N NEWGRP,RETURN D FULL^VALM1
 I $D(GMPLSAVE),$$CKSAVE D SAVE
NG1 S NEWGRP=$$GROUP("L") G:+NEWGRP'>0 NGQ G:+NEWGRP=+GMPLGRP NGQ
 I '$$LOCKCAT^GMPLAPI1(.RETURN,NEWGRP) D  G NG1
 . W $C(7),!!,"This category is currently being edited by another user!",!
 D UNLKCAT^GMPLAPI1(+GMPLGRP) S GMPLGRP=NEWGRP
 D GETLIST^GMPLBLDC,BUILD^GMPLBLDC("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR^GMPLBLDC
NGQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
GROUP(L) ;
 N PRMPT,LNAME,X,LSTS,Y,RETURN,LSTS,FILE,FIELDS
GR ;
 S Y=-1,PRMPT="Select CATEGORY NAME: "
 S FILE="PROBLEM SELECTION CATEGORY",FIELDS="NAME"
 W !,PRMPT R X:$S($D(DTIME):DTIME,1:300) I "^"[X!($G(X)="") S Y=-1 Q "^"
 I X="?" D GETCATS^GMPLAPI5(.LSTS) I $$LSTSH1(.LSTS,FILE,FIELDS) D PRINTALL(.LSTS) D:$L(L)>0 CH1
 I X?1"??".E D
 . I X="??" D GETCATS^GMPLAPI5(.LSTS) D PRINTALL(.LSTS) D:$L(L)>0 CH2
 E  D:X'="?"
 . D GETCATS^GMPLAPI5(.LSTS,X)
 . S Y=$$SELLST(.LSTS,X)
 G:Y<0 GR I Y=0,$L(L)'>0 W " ??",! G GR
 I Y=0 D
 . I $L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) W " ??" G GR
 . S ADD=$$ASKADD(X,"PROBLEM SELECTION CATEGORY") G:ADD=0 GR
 . D NEWCAT^GMPLAPI1(.RETURN,X) S Y=RETURN G:RETURN=0 GR
 S:Y<0 Y="^"
 Q Y
 ;
CH1 ;
 W !,$C(9)_"You may enter a new PROBLEM SELECTION CATEGORY, if you wish"
 W !,$C(9)_"NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH"
 W !,$C(9)_"PUNCTUATION",!
 Q
 ;
CH2 ;
 W !,$C(9)_"You may enter a new PROBLEM SELECTION CATEGORY, if you wish"
 W !,$C(9)_"This is the name given to this problem group to identify and describe it.",!
 Q
 ;
NEWLST ; Change selection lists
 N NEWLST,RETURN D FULL^VALM1
 I $D(GMPLSAVE),$$CKSAVE D SAVE
NL1 S NEWLST=$$LIST("L") G:+NEWLST'>0 NLQ G:+NEWLST=+GMPLSLST NLQ
 I '$$LOCKLST^GMPLAPI1(.RETURN,NEWLST) D  G NL1
 . W $C(7),!!,"This list is currently being edited by another user!",!
 D UNLKLST^GMPLAPI1(+GMPLSLST) S GMPLSLST=NEWLST
 D GETLIST^GMPLBLD,BUILD^GMPLBLD("^TMP(""GMPLIST"",$J)",GMPLMODE),HDR^GMPLBLD
NLQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
LIST(L) ;
 N PRMPT,LNAME,X,LSTS,Y,RETURN,LSTS,ADD,CLINIC,FILE,FIELDS
LS ;
 S Y=-1,PRMPT="Select LIST NAME: "
 S FILE="PROBLEM SELECTION LIST",FIELDS="NAME, or CLINIC"
 W !,PRMPT R X:$S($D(DTIME):DTIME,1:300) I "^"[X!($G(X)="") S Y=-1 Q "^"
 I X="?" D GETLSTS^GMPLAPI5(.LSTS) I $$LSTSH1(.LSTS,FILE,FIELDS) D PRINTALL(.LSTS,1) D:$L(L)>0 LH1
 I X?1"??".E D
 . I X="??" D GETLSTS^GMPLAPI5(.LSTS) D PRINTALL(.LSTS,1) D:$L(L)>0 LH2
 E  D:X'="?"
 . D GETLSTS^GMPLAPI5(.LSTS,X)
 . S Y=$$SELLST(.LSTS,X)
 G:Y<0 LS I Y=0,$L(L)'>0 W " ??",! G LS
 I Y=0 D
 . I $L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) W " ??",! G LS
 . S ADD=$$ASKADD(X,FILE) G:ADD=0 LS
 . S CLINIC=$$CLINIC^GMPLBLD3("   "_FILE_" ") S:CLINIC="^" CLINIC=""
 . D NEWLST^GMPLAPI1(.RETURN,X,CLINIC) S Y=RETURN G:RETURN=0 LS
 S:Y<0 Y="^"
 Q Y
 ;
LH1 ;
 W !,$C(9)_"You may enter a new PROBLEM SELECTION LIST, if you wish"
 W !,$C(9)_"NAME MUST BE 3-30 CHARACTERS, NOT NUMERIC OR STARTING WITH"
 W !,$C(9)_"PUNCTUATION",!
 Q
 ;
LH2 ;
 W !,$C(9)_"You may enter a new PROBLEM SELECTION LIST, if you wish"
 W !,$C(9)_"This is a free text name for the list; it should contain the name of"
 W !,$C(9)_"the clinic or user who will be the primary user(s) of this list, as this"
 W !,$C(9)_"name will be used as an ID and a title.",!
 Q
 ;
SELLST(LSTS,X) ;
 N CNT,Y,MAXP,CLINE,SEL,OUT,RE
 I $D(LSTS)=0 Q -1
 S CNT=$P(LSTS(0),U,1)
 Q:CNT=0 0
 I CNT=1 W $E(LSTS(1,"NAME"),$L(X)+1,$L(LSTS(1,"NAME"))) Q LSTS(1,"ID")_U_LSTS(1,"NAME")
 S MAXP=5,CLINE=1,SEL=0,OUT=0,RE=0
 F IND=1:1:CNT  D  Q:OUT
 . S CLINE=CLINE+1
 . W !,$C(9)_IND_$C(9)_LSTS(IND,"NAME")
 . I CLINE>MAXP D
 . . W !,"Press <RETURN> to see more, '^' to exit this list, OR"
 . I CLINE>MAXP!(IND=CNT) D
 . . S RE=1
 . . W !,"CHOOSE 1-"_IND_": " R SEL:$S($D(DTIME):DTIME,1:300) S:'$T OUT=1 Q
 . I RE D  Q
 . . S RE=0
 . . I SEL="^" S OUT=1 Q
 . . I $G(SEL)="" S CLINE=1 Q
 . . I $G(SEL)>IND S SEL=0,OUT=1 Q
 . . E  S OUT=1 Q
 Q:SEL>0 LSTS(SEL,"ID")_U_LSTS(SEL,"NAME") Q -1
 ;
PRINTALL(LSTS,CHOOSE) ;
 N IND,CNT,GMPQUIT,LINE
 S GMPQUIT=0,LINE=1
 I $D(LSTS)=0 Q
 S CNT=$P(LSTS(0),U,1) Q:CNT=0
 W:$G(CHOOSE) !,"   Choose from:"
 F IND=1:1:CNT D
 . S LINE=LINE+1
 . W !,"   "_LSTS(IND,"NAME")
 . I LINE>(IOSL-4) S LINE=1 S:'$$CONTINUE GMPQUIT=1 Q:$D(GMPQUIT)  Q
 W !
 Q
 ;
CONTINUE() ; -- end of page prompt
 N DIR,X,Y
 S DIR(0)="E",DIR("A")=$C(9)_"'^' TO STOP"
 D ^DIR
 Q +Y
 ;
LSTSH1(LSTS,FILE,FIELDS) ; All items ??
 N DIR,X,Y,CNT
 S CNT=$P(LSTS(0),U,1) Q:CNT=0 1
 W !," Answer with "_FILE_" "_FIELDS
 Q:CNT<(IOSL-4) 1
 S:CNT>(IOSL-4) DIR("A")=" Do you want the entire "_CNT_"-Entry "_FILE_" List"
 S DIR(0)="YO"
 D ^DIR Q Y
 ;
ASKADD(NEWEL,FILE) ; Ask
 N DIR,X,Y,CNT
 S CNT=$P(LSTS(0),U,1)
 S DIR("A")=" Are you adding '"_NEWEL_"' as a new "_FILE
 S DIR(0)="YO",DIR("B")="No"
 D ^DIR Q Y
 ;
LAST(ROOT) ; Returns last subscript
 N I,J S (I,J)=""
 F  S I=$O(@(ROOT_"I)")) Q:I=""  S J=I
 Q J
 ;
CKSAVE() ; Save [changes] ??
 N DIR,X,Y,TEXT S TEXT=$S($D(GMPLGRP):"category",1:"list")
 S DIR("A")="Save the changes to this "_TEXT_"? ",DIR("B")="YES"
 S DIR("?",1)="Enter YES to save the changes that have been made to this "_TEXT,DIR("?")="before exiting it; NO will leave this "_TEXT_" unchanged."
 S DIR(0)="YA" D ^DIR
 Q +Y
 ;
SAVE ; Save changes to group/list
 N GMPLQT,LABEL,DA
 S GMPLQT=0
 I $D(GMPLGRP) D  I GMPLQT Q
 . N ITM,CODE
 . S ITM=0
 . F  S ITM=$O(^TMP("GMPLIST",$J,ITM)) Q:'ITM!(GMPLQT)  D
 .. S CODE=$P(^TMP("GMPLIST",$J,ITM),U,4) Q:'$L(CODE)
 .. I '$$STATCHK^ICDAPIU(CODE,DT) S GMPLQT=1 Q
 . I 'GMPLQT Q  ;no inactive codes in the category
 . D FULL^VALM1
 . W !!,$C(7),"This Group contains problems with inactive ICD9 codes associated with them."
 . W !,"The codes must be edited and corrected before the group can be saved."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . S VALMBCK="R",GMPLQT=1
 . Q
 ;
 I '$D(GMPLGRP),$D(GMPLSLST) D  I GMPLQT Q
 . N GRP,RET
 . S GRP=0
 . F  S GRP=$O(^TMP("GMPLIST",$J,"GRP",GRP)) Q:'GRP!(GMPLQT)  D
 .. I $$VALGRP^GMPLAPI6(.RET,GRP) Q  ;no inactive codes in the GROUP
 .. S GMPLQT=1
 . I 'GMPLQT Q  ; all groups and problems OK
 . D FULL^VALM1
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be saved."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . S VALMBCK="R",GMPLQT=1
 . Q
 W !!,"Saving ..."
 N SOURCE,RETURN 
 M SOURCE=^TMP("GMPLIST",$J)
 S LABEL=$S($D(GMPLGRP):"SAVGRP^GMPLAPI1(.RETURN,GMPLGRP,.SOURCE)",1:"SAVLST^GMPLAPI1(.RETURN,GMPLSLST,.SOURCE)")
 D @LABEL
 K GMPLSAVE,SOURCE S:$D(GMPLGRP) GMPSAVED=1
 S VALMBCK="Q" W " done." H 1
 Q
 ;
DELETE ; Delete problem group
 N DIR,X,Y,DA,DIK,IFN,CNT,RETURN S VALMBCK=$S(VALMCC:"",1:"R")
 D CATUSED^GMPLAPI1(.RETURN,+GMPLGRP)
 I RETURN W $C(7),!!,">>>  This category belongs to at least one problem selection list!",!,"     CANNOT DELETE" H 2 Q
 S DIR(0)="YA",DIR("B")="NO",DIR("A")="Are you sure you want to delete the entire '"_$P(GMPLGRP,U,2)_"' category? "
 S DIR("?")="Enter YES to completely remove this category and all its items."
 D ^DIR Q:'Y
DEL1 ; Ok, go for it ...
 W !!,"Deleting category items ..."
 K RETURN
 D DELCAT^GMPLAPI1(.RETURN,+GMPLGRP)
 D UNLKCAT^GMPLAPI1(+GMPLGRP) S GMPLGRP=0 K GMPLSAVE W ". <done>"
 D NEWGRP S:+GMPLGRP'>0 VALMBCK="Q"
 Q
 ;
ASSIGN ; allow lookup of PROB SEL LIST and assign to users
 ;
 N DIC,X,Y,DUOUT,DTOUT,GMPLSLST,RET
 S Y=$$LIST("")
 Q:Y'>0
 I '$$VALLIST^GMPLAPI6(.RET,+Y) D  G ASSIGN
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be assigned to",!,"users.",!!
 ;
 S GMPLSLST=+Y
 D USERS^GMPLBLD3("1")
 Q
