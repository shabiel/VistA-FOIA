FBNHET ;AISC/GRR - ENTER TRANSFER FOR NURSING HOME ;6/16/2009
 ;;3.5;FEE BASIS;**108**;JAN 30, 1995;Build 115
 ;;Per VHA Directive 2004-038, this routine should not be modified.
RD1 D Q,GETVET^FBAAUTL1 G:DFN']"" Q
 I '$D(^FBAACNH("AD",DFN)) W !!,*7,"Veteran does NOT have an active admission!" G RD1
RD0 S FBPROG="I $P(^(0),U,3)=7" D GETAUTH^FBAAUTL1 G RD1:FTP']"",RD1:$D(DUOUT),H^XUS:$D(DTOUT) I FBTYPE'=7 D WRONGT^FBAAUTL1 G RD0
 S IFN=$O(^FBAACNH("AD",DFN,0)),FBTRT="T",FBLTD=$O(^FBAACNH("AF",DFN,0)),FBIFN=$O(^FBAACNH("AF",DFN,FBLTD,0)),FBLTT=$P(^FBAACNH(FBIFN,0),"^",3),FBLTTYP=$S(FBLTT'="T":"",1:$P(^(0),"^",7))
 ;
RD2 D ^FBNHDEC
 W ! S DIR(0)="DA^::EXR",DIR("A")="Enter Transfer Date/Time: ",DIR("?")="Enter date of transfer (time is required)" D ^DIR K DIR G:$D(DIRUT)!('Y) RD1
 I $D(FBTRT),$D(FBLTD),(9999999.999999-Y)'<FBLTD D  G RD2:'$G(X)
 .  W !,*7,"The date/time must follow an existing movement.",! H 2
 .  K X
 S FBY=+Y
 S DIR(0)="S^1:TO AUTHORIZED ABSENCE;2:TO UN-AUTHORIZED ABSENCE;3:TO ASIH"
 S DIR(0)=$S('$G(FBLTTYP):DIR(0),FBLTTYP<4:"S^"_$P($T(TRANS+(3+FBLTTYP)),";;",2),1:DIR(0))
 S DIR("A")="Enter Transfer Type"
 I $G(FBLTTYP),FBLTTYP<4 S DIR("B")=$P($P(DIR(0),"^",2),":",2)
 D ^DIR K DIR
 G RD1:$D(DIRUT) S FBZ=+Y
 S (DIC,DIE)="^FBAACNH(",DIC(0)="L",DLAYGO=162.3,X=FBY
 K DD,DO D FILE^DICN K DLAYGO,DIC G RD1:$D(DIRUT),RD2:Y<0
 S DA=+Y
 S DR="8////^S X=FBVEN;Q;1////^S X=DFN;2////^S X=""T"";4////^S X=IFN;6////^S X=FBZ" D ^DIE K DIE I $D(Y)'=0 G DEL
 G RD1
DEL W !!,*7,"Deleting Transfer because of incomplete transaction!" S DIK="^FBAACNH(" D ^DIK K DIK G RD1
 ;
Q K FBLTT,FBLTTYP,FBINF,FBTRT,FBLTD,DFN,IFN,DIK,FBPROG,CNT,DAT,DIC,F,FBAUT,FBDX,FBEDT,FBI,FBMULT,FBRR,FBTDT,FBXX,FTP,I,PI,PTYPE,T,X,Z,ZZ,FBAAOUT,Y,FBAABDT,FB7078,FBAAEDT,FBAAOUT,FBASSOC,FBDX,FBI,FBPOV,FBY
 K FBPSA,FBPT,I,PI,PTYPE,T,TA,VAL,FBTT,FBLOC,FBAAAD,FBAT,FBIFN,FBPDT,FBTYPE,FBVEN,DA,DR,FBASIH,FBJ,FBK,FBZ
 D GETAUTHK^FBAAUTL1
 Q
 ;
TRANS ;transfer types
 ;;1:TO AUTHORIZED ABSENCE
 ;;2:TO UNAUTHORIZED ABSENCE
 ;;3:TO ASIH
 ;;4:FROM AUTHORIZED ABSENCE
 ;;5:FROM UNAUTHORIZED ABSENCE
 ;;6:FROM ASIH < 15 DAYS
