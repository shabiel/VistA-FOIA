DGSAUTL ;ALB/MTC - SHARING AGREEMENTS UTILITY FUNCTIONS ;07/03/13  12:03
 ;;5.3;Registration;**114,194,216,260005*****;Aug 13, 1993
 ;
 Q
 ;
EN(ORG) ;-- Entry point to Add/Edit Sharing Agreement Sub-Categories
 ;
 ;   ORG - This parameter specifies the orginating process
 ;         "SD" - Appointment Type, "DG" - Admitting Regulation
 ;
 ;-- get the appropriate Admitting Reg or Appoitment Type
 N DGAPT,DGCAT
 ;
 S DGAPT=$$GET(ORG)
 ;-- if no selection quit
 I DGAPT'>0 G ENQ
 ;-- get category
 S DGCAT=$$CAT(ORG)
 I DGCAT'>0 G ENQ
 ;-- put it all together
 D GOGO(ORG,DGAPT,DGCAT)
ENQ ;
 Q
 ;
GOGO(ORG,ATR,CAT) ;-- This function does something
 ;
 I ORG=""!(ATR'>0)!(CAT'>0) G GOGOQ
 ;
 N DGX,DA
 S DGX=$S(ORG="SD":"AT",1:"AR"),DIC("V")=$S(ORG="SD":"I +Y(0)=409.1",1:"I +Y(0)=43.4")
 S DA=$O(^DG(35.1,DGX,+ATR,+CAT,0))
 I DA D
 . N DGEDMODE S DIE="^DG(35.1,",DR="[DGSHARESUB]" D ^DIE
 E  D
 .S X=+ATR_";"_$S(ORG="SD":"SD(409.1,",1:"DIC(43.4,")
 . S (DIC,DIK)="^DG(35.1,",DIC(0)="L",DLAYGO=35.1
 . S DIC("DR")=".02////"_+CAT_";.03"
 .K DD,DO D FILE^DICN
 ;
GOGOQ K DIE,DIC
 Q
 ;
GET(ORG) ;-- This function will get the appropriate App Type or Admit Reg
 N DGX
 S:ORG="SD" DGX=$$GETAT
 S:ORG="DG" DGX=$$GETAR
 Q DGX
 ;
GETAT() ;-- get appointment type
 K DIC,Y
 S DIC="^SD(409.1,"
 S DIC("S")="I +$P(^(0),U,3)=0"
 S DIC(0)="AEZNQ"
 D ^DIC
 K DIC
 Q $G(Y)
 ;
GETAR() ;-- get admitting regulation
 N DIC,Y
 S DIC="^DIC(43.4,"
 S DIC("S")="I +$P(^(0),U,4)=0"
 S DIC(0)="AEZNQ"
 D ^DIC
 K DIC
 Q $G(Y)
 ;
CAT(DGORG) ;
 N DIC,Y
 ;-- get category from 35.2
 S DIC="^DG(35.2,"
 S DIC(0)="SLAEZQ"
 D ^DIC
 K DIC
 Q $G(Y)
 ;
HLP ;-- help for Sub-Category file
 ;
 I '$D(DGAPT)!('$D(DGORG)) G HLPQ
 ;
 N DGX,DGI,DGJ
 S DGJ=1
 S DGX=$S(DGORG="SD":"AT",1:"AR")
 S DGI=0 F  S DGI=$O(^DG(35.1,DGX,+DGAPT,DGI)) Q:'DGI  S DGK=$O(^(DGI,0)) D
 . I DGORG="SD" D
 .. I DGJ W !,"APPOINTMENT TYPE :",$P(DGAPT,U,2),!,?5,"CATEGORY :" S DGJ=0
 . I DGORG="DG" D
 .. I DGJ W !,"VA ADMITTING REGULATION :",$P(DGAPT,U,2),!,?5,"CATEGORY :" S DGJ=0
 . W !,?10,$P(^DG(35.2,$P(^DG(35.1,DGK,0),U,2),0),U),?35,$S($P(^DG(35.1,DGK,0),U,3)=1:"ACTIVE",1:"INACTIVE")
HLPQ ;
 Q
 ;
ADCAT(ADCAT,DEFAULT) ;-- This function will prompt the user for the category
 ; associated with the admitting regulation selected.
 ;
 N RESULT,SCAT
 S %=$$LSTACAT^DGSAAPI(.SCAT,ADCAT,1)
 S RESULT=$$SUB(ADCAT,1,$G(DEFAULT),.SCAT)
 Q RESULT
 ;
SUB(ATAR,SOURCE,DEFAULT,SCAT) ;-- This function will check and prompt for sharing
 ; agreement sub-categories associated with either an Admitting Reg
 ; or a Appointment Type.
 ;
 ;   INPUT:  ATAR - IEN if Admitting Reg or Appointment Type
 ;           SOURCE - (1:ADT,2:SCHEDULING)
 ;           DEFALUT - IEN from file 35.2
 ;  OUTPUT:  IEN of file 35.2^Name
 ;
 ;
 N RESULT,ALLEL,EMP,X,DGDEF,Y
 ;
 ;-- get eligility codes
 S DGDEF=""
 ;
 S RESULT=""
 I '$G(SCAT(0)) G SUBQ
 S X=0,X=$O(SCAT(X))
 I '$O(SCAT(X)) S RESULT=SCAT(X,"SUBCAT") G SUBQ
 ;-- if no default set default to first entry
 I DGDEF="" S DGDEF=SCAT(X,"SUBCAT")
 ;
DISP ;-- display choices
 ;
 S ALLEL=""
 ;-- get the name of the Admitting Reg or Appointment Type
 S DGNAME=$P(ATAR,U,2)
 ;
 W !,"THE ["_DGNAME_$S(SOURCE=1:"] ADMITTING REGULATION",1:"] APPOINTMENT TYPE")
 W !,"HAS THE FOLLOWING SUB-CATEGORIES DEFINED."
 S X=0 F  S X=$O(SCAT(X)) Q:'X  D
 . W !?5,$P(SCAT(X,"SUBCAT"),U,2)
 . I +$G(DEFAULT)=+SCAT(X,"SUBCAT") S DGDEF=SCAT(X,"SUBCAT")
 . S ALLEL=ALLEL_U_$P(SCAT(X,"SUBCAT"),U,2)
 ;
 ;-- prompt for sub-categories
 ;
1 W !,"ENTER THE SUB-CAT FOR THE ["_DGNAME_$S(SOURCE=1:"] ADMITTING REG",1:"] APPT TYPE")_": "_$P(DGDEF,U,2)_"// "
 R X:DTIME
 ;-- if timeout
 G SUBQ:'$T
 ;-- if ^
 G SUBQ:X[U
 ;-- if default (primary) quit
 I X="" S RESULT=DGDEF G SUBQ
 ;-- find eligibility
 S X=$$UPPER^VALM1(X)
 G DISP:X["?",1:ALLEL'[(U_X)
 N CNT,RES S CNT=0
 S EMP=X ;_$P($P(ALLEL,U_X,2),U) ;W $P($P(ALLEL,U_X,2),U)
 S X=0 F  S X=$O(SCAT(X)) Q:X'>0  D
 . I $E($P(SCAT(X,"SUBCAT"),U,2),1,$L(EMP))=EMP S CNT=CNT+1,(RES(CNT),RESULT)=X_U_$P(SCAT(X,"SUBCAT"),U,2)
 W:CNT=1 $P($P(ALLEL,U_EMP,2),U) I CNT>1 D  G 1:(('RESULT)&(X'[U))
 .N I F I=1:1:CNT W !?5,I_"  "_$P(RES(I),U,2)
 .W !,"CHOOSE 1 - "_CNT_": "
 .S RESULT="" R X:DTIME I $D(RES(+X)) S RESULT=RES(+X) W " "_$P(RES(+X),U,2)
SUBQ ;
 K SCAT
 Q +RESULT
 ;
