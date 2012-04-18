GMPLBLD3 ; SLC/MKB -- Bld PL Selection Lists cont ;3/12/03 13:40
 ;;2.0;Problem List;**28**;Aug 25, 1994
 ;
 ; This routine invokes IA #3991
 ;
ASSIGN ; Assign list to clinic, users: Expects GMPLSLST
 N DIE,DA,DR,RET D FULL^VALM1 G:+$G(GMPLSLST)'>0 ASQ
 I '$$VALLIST^GMPLAPI6(.RET,+GMPLSLST) D  G ASQ
 . W !!,$C(7),"This Selection List contains problems with inactive ICD9 codes associated with"
 . W !,"them. The codes must be edited and corrected before the list can be assigned",!,"to users or clinics."
 . W !!,"If you have edited the list during this session to correct inactive codes, "
 . W !,"save the list prior to attempting to assign it."
 . N DIR,DUOUT,DTOUT,DIRUT
 . S DIR(0)="E" D ^DIR
 . Q
 ;
 W !!,"You may assign this list to a clinic as its default selection list,"
 W !,"as well as to individual users as a preferred selection list.",!
 D ASGCLIN(+GMPLSLST)
 D USERS("1") ; assign
ASQ S VALMBCK="R",VALMSG=$$MSG^GMPLX
 Q
 ;
ASGCLIN(GMPLSLST) ;
 N CLIN,RETURN,LST,SUF
 S SUF=""
 D GETLIST^GMPLAPI1(.LST,GMPLSLST,0,1)
 S:$D(LST("LST","CLINIC")) SUF=$G(LST("LST","CLINIC"))
 S:$L(SUF)>0 SUF=SUF_"// "
 S CLIN=$$CLINIC(,SUF)
 I $G(CLIN)>0 D ADDLOC^GMPLAPI5(.RETURN,GMPLSLST,CLIN)
 Q
 ;
CLINIC(PREFIX,SUFIX) ;
CL ;
 N PRMPT,LNAME,X,LSTS,Y,RETURN,LSTS,PREF,SUF
 S PREF=$G(PREFIX),SUF=$G(SUFIX)
 S Y=-1,PRMPT=PREF_"CLINIC: "_SUF
 W !,PRMPT R X:$S($D(DTIME):DTIME,1:300) I "^"[X!($G(X)="") S Y=-1 Q "^"
 I X="?" D CH1 D GETCLIN^GMPLAPI5(.LSTS) D PRINTALL^GMPLBLD2(.LSTS,1)
 I X?1"??".E D
 . I X="??" D CH2 D GETCLIN^GMPLAPI5(.LSTS) D PRINTALL^GMPLBLD2(.LSTS,1)
 E  D:X'="?"
 . D GETCLIN^GMPLAPI5(.LSTS,X)
 . S Y=$$SELLST^GMPLBLD2(.LSTS,X)
 G:Y<0 CL
 Q Y
 ;
CH1 ;
 W !,$C(9)_"Enter the clinic to be associated with this list."
 W !,$C(9)_"Only hospital locations that are clinics are allowed."
 W !,"    Answer with HOSPITAL LOCATION NAME, or ABBREVIATION, or TEAM"
 Q
 ;
CH2 ;
 W !,$C(9)_"This is the clinic to be associated with this list.  This should be the"
 W !,$C(9)_"primary clinic in which this list will be used to populate patient"
 W !,$C(9)_"problem lists; when adding new problems for a patient from this clinic,"
 W !,$C(9)_"this list will automatically be presented to select problems from.",!!
 Q
 ;
USERS(ADD) ; -- select user(s) to de-/assign list
 N DIR,DIC,DIE,DR,DA,X,Y,GMPLUSER,GMPLI,RETURN,PRMT
 Q:+$G(GMPLSLST)'>0  S GMPLUSER=""
 S PRMT="Select USER: "
 F  D READUS(PRMT) Q:+Y'>0  S GMPLUSER=GMPLUSER_U_+Y,PRMT="ANOTHER ONE: "
 I '$L(GMPLUSER) W !!,"No users selected.",! Q
 S DIR(0)="YA",DIR("A")="Are you ready? ",DIR("B")="NO"
 S DIR("?",1)="Enter YES to "_$S(ADD:"assign",1:"remove")_" the "_$P(GMPLSLST,U,2)_" list "_$S(ADD:"to the",1:"from the")
 S DIR("?")=($L(GMPLUSER,U)-1)_" user(s) selected; enter NO to exit."
 D ^DIR Q:'Y
USR W !,$S(ADD:"Assigning ",1:"Removing ")_$P(GMPLSLST,U,2)_" list ..."
 S TARGET=$S(ADD:"ASSUSR^GMPLAPI6(.RETURN,GMPLSLST,DA)",1:"REMUSR^GMPLAPI6(.RETURN,GMPLSLST,DA)")
 F GMPLI=1:1:$L(GMPLUSER,U) S DA=$P(GMPLUSER,U,GMPLI) I DA D
 . D @TARGET
 . W !?4,$$PROVNAME^GMPLEXT(DA)
 W !!,"DONE."
 Q
 ;
READUS(PRMT) ; prompt for username, respond
READ ;
 N LSTS
 W !,PRMT R X:DTIME I '$T!("^"[X) S Y=-1 Q
 I X="?" W !!,"Enter the name of the user you wish this list to be "_$S(ADD:"assigned to;",1:"removed from;"),!,"enter '??' to see users currently assigned this list, or '???' to see",!,"all users on this system.",! G READ
 I X?1"??".E D  G READ
 . I X="??" D
 . . D GETASUSR^GMPLAPI5(.LSTS,+GMPLSLST)
 . . W !!,"Users currently assigned "_$P(GMPLSLST,U,2)_" list:",!!
 . E  D
 . . D GETUSRS^GMPLAPI5(.LSTS)
 . D PRINTALL^GMPLBLD2(.LSTS,1)
 D GETUSRS^GMPLAPI5(.LSTS,X)
 S Y=$$SELLST^GMPLBLD2(.LSTS,X) G:Y'>0 READ
 Q
 ;
DELETE ; Delete Selection List
 N DIR,DIK,DA,X,Y,VIEW,USER,GMPCOUNT,GMPQUIT,GMPLSLST,RETURN
 S GMPCOUNT=0,GMPLSLST=$$LIST^GMPLBLD2("") Q:GMPLSLST=0
 W !!,"Checking the New Person file for use of this list ..."
 D LSTUSED^GMPLAPI1(.RETURN,GMPLSLST)
 S GMPCOUNT=RETURN
 I GMPCOUNT W $C(7),!!,GMPCOUNT_" user(s) are currently assigned this list!",!,"CANNOT DELETE",! Q
 W !,"0 users found."
DEL1 S DIR(0)="Y",DIR("B")="NO"
 S DIR("A")="Are you sure you want to delete this list"
 S DIR("?",1)="Enter YES if you wish to completely remove this list; press <return>",DIR("?")="to leave this list unchanged and exit this option."
 W $C(7),! D ^DIR Q:'Y
 W !!,"Deleting "_$P(GMPLSLST,U,2)_" selection list ..."
 K RETURN
 D DELLST^GMPLAPI1(.RETURN,+GMPLSLST)
 W "." ; list
 W !,"DONE.",!
 Q
 ;
MENU ; -- init variables and list array for GMPL LIST MENU list template
 ;    Expects GMPLSLST=selection list
 N RETURN,GRP,IND,IND1
 S IND=0,IND1=0
 D GETLIST^GMPLAPI1(.RETURN,GMPLSLST,"")
 M ^TMP("GMPLMENU1",$J)=RETURN
 F  S IND=$O(^TMP("GMPLMENU1",$J,"GRP",IND)) Q:'IND  D
 . S GRP=^TMP("GMPLMENU1",$J,"GRP",IND)
 . S ^TMP("GMPLMENU",$J,IND,0)=$P(^TMP("GMPLMENU1",$J,GRP),U,3,4)
 . F  S IND1=$O(^TMP("GMPLMENU1",$J,"GRP",IND,IND1)) Q:'IND1  D
 . . S PRB=^TMP("GMPLMENU1",$J,"GRP",IND,IND1)
 . . S ^TMP("GMPLMENU",$J,IND,IND1)=$P(PRB,U,4)_U_$P(PRB,U,1,2)
 K ^TMP("GMPLMENU1",$J)
 I '$D(^TMP("GMPLMENU",$J)) W !!,"No items available.  Returning to Problem List ..." H 2 S VALMBCK="Q",VALMQUIT=1 Q
 D BUILD^GMPLMENU
 Q
