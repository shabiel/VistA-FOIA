RMPR29LE ;HIN/RVD-ENTER/CLOSE LAB STOCK ISSUE 2529-3 [ 11/05/98
 ;;3.0;PROSTHETICS;**33,37**;Feb 09,1996
CREATE ;CREATE Lab Stock Issue 2529-3
 K RMPREDIT,RMPRTMP,RMPR25,RMNEW D DIV4^RMPRSIT G:$D(X) EXIT
 D GETPAT^RMPRUTIL I '$D(RMPRDFN) G EXIT
 S RMDFN=RMPRDFN
VIEW ;CREATE Lab Stock Issue 2529-3 VIA LAB MENU
 N RMPRDA,RMPRWO,RMPRJOB S RMPRF=15,(RSTOCK,RNEW,RFLG)=1 D ^RMPRPAT
 S DIC="^RMPR(664.1,",DIC(0)="ZL",X=DT
 S DLAYGO=664.1 D FILE^DICN K DLAYGO,DIC G:+Y'>0 EXIT
 S RMPRDA=+Y,$P(^RMPR(664.1,RMPRDA,0),U,2)=RMDFN,$P(^(0),U,3)=RMPR("STA"),$P(^(0),U,17)="S"
 S IDEF=$$STA^RMPR31U(RMPR("STA"))
 S DA=RMPRDA,DIK="^RMPR(664.1," D IX1^DIK
 K DR,DA,DIC,Y,DIE D KVAR^VADPT
 S RMPRDFN=$P(^RMPR(664.1,RMPRDA,0),U,2),VAIP("D")="L"
 D IN5^VADPT S VAINDT=$P($G(VAIP(3)),U) D INP^VADPT
EDT ;EDIT/DELETE 2529-3
 I $G(RMPRDA)>0,$G(RMPRDA)'="" G TYPE
 K DR,DIC D DIV4^RMPRSIT G:$D(X) EXIT S REDIT=1
 S DIC="^RMPR(664.1,",DIC(0)="AEQM",DR=".01"
 ;screen on complete, delete status
 S DIC("S")="I $P(^(0),U,17)=""S"""
 S DIC("W")="D EN3^RMPRD1"
 K DIC("A") D ^DIC K DIC G:+Y'>0 EXIT S RMPRDA=+Y I $G(RMPRDA)'>0 Q
 L +^RMPR(664.1,RMPRDA,0):1
 I '$T W $C(7),!!,?5,"Someone is already editing this entry" G EXIT
 S RMPRDFN=$P(^RMPR(664.1,RMPRDA,0),U,2)
 D LIS^RMPR29LU K DIR
 S DIR(0)="Y",DIR("A")="Would you like to Edit this Entry",DIR("B")="NO"
 D ^DIR G:$D(DTOUT)!($D(DIRUT)) EXIT G:Y=0!(Y<0) EXIT
 ;D ST^RMPR29LS
 ;
TYPE ;
 K DIR S PDA=RMPRDA
 D ST^RMPR29LS I '$G(RMPRDFN) W !,"*** UNABLE to access patient information, please contact your IRM..",! G EXIT
 D GD^RMPR29LS
 I $G(RNEW),$D(RMFLG) D RDL^RMPR29LU G:$D(RMFLG) EXIT
 ;G:$D(REDIT) ITEM
 S DIR(0)="SBO^V:VA;C:COMMERCIAL",DIR("A")="Select VA or COMMERCIAL SOURCE" S DIR("B")="C"
 S DIR("?")="Enter V for VA or C for Commercial"
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) D RDL^RMPR29LU G EXIT
 S (RMSOR,RMSO)=Y K DIR
 S DIR(0)="664.16,8"
TRAN S:$D(RMTYPS) DIR("B")=$S(RMTYPS="I":"INITIAL",RMTYPS="X":"REPAIR",RMTYPS="R":"REPLACE",RMTYPS="S":"SPARE",1:"")
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) D RDL^RMPR29LU G EXIT
 I Y="" W !,"Please enter Type of Transaction!!" G TRAN
 S RMTYP=Y K DIR
 S RMTYPS=$S(Y="I":"INITIAL",Y="X":"REPAIR",Y="R":"REPLACE",Y="S":"SPARE",1:"")
PCAT K DIR S DIR(0)="664.16,9" S:$D(RMCATS) DIR("B")=$S(RMCATS=1:"SC/OP",RMCATS=2:"SC/IP",RMCATS=3:"NSC/IP",RMCATS=4:"NSC/OP",1:"")
 D ^DIR
 I $D(DUOUT)!$D(DTOUT) D RDL^RMPR29LU G EXIT
 I Y="" W !,"Please enter Patient Category!!" G PCAT
 S RMCAT=Y,RMCATS=$S(Y=1:"SC/OP",Y=2:"SC/IP",Y=3:"NSC/IP",Y=4:"NSC/OP",1:"") K DIR G:RMCAT<4 ITEM
SCAT S DIR(0)="664.16,10" S:$D(RMSPES) DIR("B")=$S(RMSPES=1:"SPECIAL LEGISLATION",RMSPES=2:"A&A",RMSPES=3:"PHC",RMSPES=4:"ELIGIBILITY REFORM",1:"")
 I RMCAT=4 D ^DIR I $D(DUOUT)!$D(DTOUT) D RDL^RMPR29LU G EXIT
 I RMCAT=4 S RMSPE=Y,RMSPES=$S(Y=1:"SPECIAL LEGISLATION",Y=2:"A&A",Y=3:"PHC",Y=4:"ELIGIBILITY REFORM",1:"")
 K DIR
ITEM ;EDIT 2529-3 ITEM
 K DIR,RMEDIT,RMITFLG,DUOUT,DTOUT,DIC,RMPRGIP,RDEL S DA=RMPRDA,DIC="^RMPR(664.1,"_RMPRDA_",2,"
 S DIC("P")="664.16PA",DA(1)=RMPRDA,DIC(0)="AEQMZL"
 D ^DIC K DIC G:+Y'>0 LAB
 S RMITEMS=$P($G(^RMPR(661,$P(Y,U,2),0)),U,1)
 S (RMIDA,DA)=+Y,DIE="^RMPR(664.1,"_RMPRDA_",2,",DR=".01" D ^DIE I $D(Y)!'$D(^RMPR(664.1,RMPRDA,2,RMIDA,0)) D  G ITEM
 .K ^RMPR(664.1,RMPRDA,2,RMIDA) K DIE,DR,RMIDA S RICHECK=$O(^RMPR(664.1,RMPRDA,2,0))
 .K:'$G(RICHECK) REDIT
 I $D(^RMPR(664.1,RMPRDA,2,RMIDA,0)),$P(^RMPR(664.1,RMPRDA,2,RMIDA,0),U,1)="" K ^RMPR(664.1,RMPRDA,2,RMIDA) G ITEM
 S RM0=$G(^RMPR(664.1,RMPRDA,2,DA,0)) S:$P(RM0,U,2)'="" REDIT=1
 I $G(REDIT) D
 .S RMHS=$P($G(^RMPR(664.1,RMPRDA,2,DA,2)),U,1)
 .S RM3=$G(^RMPR(664.1,RMPRDA,2,DA,3)),RMLOC=$P(RM3,U,4),RMIT=$P(RM3,U,3)
 .S RMQTYS=$P(RM0,U,2),RMCOS=$P(RM0,U,4),RMGIP=$P(RM0,U,13)
 .S RMTYPS=$P(RM0,U,7),RMCATS=$P(RM0,U,8),RMSPES=$P(RM0,U,9)
HCPCS ;HCPCS code
 K DIC
 S DIC(0)="AQEM",DIC="^RMPR(661.1,",DIC("A")="PSAS HCPCS: " S:$G(RMHS) DIC("B")=RMHS
 S DIC("S")="I $P(^RMPR(661.1,+Y,0),U,10)"
 D ^DIC
 I $D(DUOUT)!$D(DTOUT) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 I Y=-1 W !,"HCPCS CODE IS MANDATORY!" D HELP G HCPCS
 I $P(^RMPR(661.1,+Y,0),U,10)<1 D HELP G HCPCS
 I +Y>0 G:$P(^RMPR(661.1,+Y,0),U,5)'=1 HCPCS S $P(R1(0),U,22)=$P(^RMPR(661.1,+Y,0),U,4)
 S (RMI,RMHCPC,DA(1),RMHCPCS)=+Y
 D ITEMLOC^RMPR5NU1 K DIC
 I $G(RMITFLG) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 K:'$G(RMHCDA)!'$G(RMITDA) RMLOC I $G(RMLOC) S RMGIP=0 G VEN
 G GI
HMESS1 W !,$C(7),"HCPCS has no pre-determined time....",!,"Please SEND mail message to G.PROS-CODE@FORUM.DOMAIN.EXT!!!" X CK Q
 Q
 ;
GI I $P(^RMPR(669.9,RMPRSITE,0),U,3),'$D(^PRCP(445,"AD",DUZ)) W $C(7),!,"You are not an authorized user of any Inventory Point, please see your ADPAC." H 2 D RDL^RMPR29LU G EXIT
 S RMPRGIP=$P(^RMPR(669.9,RMPRSITE,0),U,3),RMFORM=15 I RMPRGIP S PRCPPRIV=1 D INV^RMPR29LS G:$D(RMEXIT)&($G(REDIT)) LAB Q:$D(RMEXIT)
 G:$D(RDEL) ITEM
 ;
VEN K DIC("S")
 ;S X=" ",DIC=440,DIC(0)="ZM" D ^DIC S:+Y>0 DIC("B")=$P(^PRC(440,+Y,0),U,1)
VEN0 I $G(RMLOC),$D(RMVEN) S DIC("B")=RMVEN
 S DIC(0)="AEQM",DIC=440,DIC("A")="VENDOR: " S:$G(REDIT)&($D(RMVENS)) DIC("B")=RMVENS D ^DIC
 I $D(DUOUT)!$D(DTOUT) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G VEN
 S (RMVEN,RMVENS)=+Y K DIC,Y,X
COS ;UNIT COST
 I (RMSO["C")&($G(RMPRGIP)) S RMCOS=$P($G(^PRCP(445,PRCP("I"),1,PRCP("ITEM"),0)),U,15)
 I $G(RMLOC) S RMCOS=$P($G(^RMPR(661.3,RMLOC,1,RMHCDA,1,RMITDA,0)),U,10)
 S DIR(0)="667.3,3",DIR("A")="UNIT COST"
 S:$D(RMCOS)&($G(RMCOS)) DIR("B")=RMCOS
 D ^DIR K DIR
 I $D(DUOUT)!$D(DTOUT) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 I (RMSO["C")&(X<.001) W !,"You must enter a UNIT COST....",! G COS
 S RMCO=Y K DIR
QTY S DIR(0)="664.16,2",RMQTYS=$P(RM0,U,2) S:$D(RMQTYS) DIR("B")=RMQTYS D ^DIR
 I $D(DUOUT)!$D(DTOUT) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 I X<1 W !,"You must enter a quantity....",! G QTY
 S (RMQTY,RMQTYS)=Y K DIR
 ;
 K DIR S DIR(0)="664.16,12",RMSERS=$P(RM0,U,12) S:$D(RMSERS) DIR("B")=RMSERS D ^DIR
 I $D(DUOUT)!$D(DTOUT) G:$G(REDIT) LAB D RDL^RMPR29LU G EXIT
 S (RMSER,RMSERS)=Y K DIR
 S DIE(0)="AEQM",DR=4
 S DR(1,664.129)="4;"
 S DR(2,664.1294)=".01"
 S ^RMPR(664.1,RMPRDA,8,0)="^664.129DA"
 S ^RMPR(664.1,RMPRDA,8,1,1,0)="^664.1294^"
 S DA(1)=RMPRDA,DIE="^RMPR(664.1,"_RMPRDA_",8,"
 S DA=1 D ^DIE K DIE,DR,DA
 S DA(1)=RMPRDA,DA=RMIDA,DIE="^RMPR(664.1,"_RMPRDA_",2,"
 S DR="2///^S X=$G(RMQTY);4///^S X=$G(RMCO);12///^S X=$G(RMSER);8///^S X=$G(RMTYP);9///^S X=$G(RMCAT);10///^S X=$G(RMSPE);16///^S X=$G(RMIT);14///^S X=$G(RMSO)"
 D ^DIE I $D(DTOUT)!$D(DUOUT) G:$G(REDIT) LAB G EXIT
 S RM0=$G(^RMPR(664.1,RMPRDA,2,DA,0)),RMQTY=$P(RM0,U,2),RMCO=$P(RM0,U,4)
 I RMQTY S RMTOCO=RMQTY*RMCO,DR="11///^S X=$G(RMTOCO);13///^S X=$G(RMHCPC)" D ^DIE
 S:$G(RMGIP) $P(^RMPR(664.1,RMPRDA,2,DA,0),U,13)=RMGIP
 S $P(^RMPR(664.1,RMPRDA,2,DA,3),U,4)=$G(RMLOC)
 S $P(^RMPR(664.1,RMPRDA,2,DA,3),U,2)=$G(RMVEN)
 G ITEM
LAB ;ASK TO POST REQUEST
 I $G(REDIT),$D(RMIDA) D SET^RMPR29LS
 S DIR(0)="Y",DIR("A")="Would you like to review this request"
 S DIR("B")="YES" D ^DIR I $D(DTOUT)!($D(DUOUT)) D CHK^RMPR29LU D:$G(RMEXIT) RDL^RMPR29LU G EXIT
 I Y=1 S IOP="HOME" D PRT^RMPR29R
 D CHK^RMPR29LU K RMNEW G:$G(RMEDIT) TYPE D:$G(RMEXIT) RDL^RMPR29LU G:$G(RMEXIT) EXIT
 K DIR S DIR(0)="Y",DIR("A")="Would you like to post this request"
 S DIR("B")="YES" D ^DIR G:$D(DTOUT)!($D(DUOUT)) EXIT
 I +Y=0 W !!,?5,$C(7),"Request not posted!!" D RDL^RMPR29LU G EXIT
 S RMPRWO=$P(^RMPR(664.1,RMPRDA,0),U,13) G:RMPRWO'="" PRINT S SCR=$P(^(0),U,11)
 D CR^RMPR29U(SCR) I '$D(RMPRWO) W !!,?5,$C(7),"Request not posted!!" D RDL^RMPR29LU G EXIT
PRINT D SG^RMPR29LS
 S DIK="^RMPR(664.1,",DA=RMPRDA D IX1^DIK K DIK,DA
 W !! S DIR(0)="Y",DIR("A")="Would you like to print this 2529-3  request"
 S DIR("B")="YES" D ^DIR G:$D(DTOUT)!($D(DUOUT)) EXIT I Y=1 D PRT^RMPR29R
 ;close a Lab Issue from Stock.
 D STA^RMPR29LC
 ;suspense record inquiry
 D LINK^RMPRS
 G CREATE
HELP ;
 W !,"** You can only select HCPCS that have a LAB pre-determined time.",!,"** If the HCPCS you are selecting are not in the list, please send an E-mail"
 W !,"** message to G.PROS-CODE@FORUM.DOMAIN.EXT to be added in the list..."
 Q
 ;
EXIT ;common exit
 L:+$G(RMPRDA) -^RMPR(664.1,+RMPRDA,0)
 ;I '$D(RMPR25)&('$D(RMPREDIT)) W !! S DIR(0)="Y",DIR("A")="Would you like to Process another 2529-3 Request",DIR("B")="NO" D ^DIR G:+Y=1 CREATE
 N RMPR,RMPRSITE D KILL^XUSCLEAN
 Q
