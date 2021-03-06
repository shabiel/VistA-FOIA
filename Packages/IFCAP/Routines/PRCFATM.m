PRCFATM ;WISC/SJG-DISPLAY TYPES/COUNTS OF ACCTG TECH DOCUMENTS ;12/14/93  10:15
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ;
 QUIT
 D PROMPT Q:'Y  Q:$D(DIRUT)
 S PRCF("X")="AS" D ^PRCFSITE Q:'%
 W ! D WAIT^DICD W !
 D HILO^PRCFQ
 D HDR,ENPO,ENPOA,ENRR
 W ! D ENCON^PRCFQ W !
 QUIT
ENPO ;COUNT/DISPLAY PURCHASE ORDERS
 S TYPE="Purchase Order",FLAG=0
 F LOOP=10,15,20 S TAG="EN"_LOOP D @TAG
 W:'FLAG !?3,"There are no PURCHASE ORDERS ready for processing at this time.",!
 D EXMAIN
 QUIT
ENPOA ;COUNT/DISPLAY PURCHASE ORDER AMENDMENTS
 S TYPE="Purchase Order Amendment",FLAG=0
 F LOOP=26,41,31,36 S TAG="EN"_LOOP D @TAG
 W:'FLAG ?3,"There are no PURCHASE ORDER AMENDMENTS ready for processing at this time.",!
 D EXMAIN
 QUIT
ENRR ;COUNT/DISPLAY RECEIVING REPORTS
 S TYPE="Receiving Report",FLAG=0
 F LOOP=35,30,36,31 S TAG="EN"_LOOP D @TAG
 W:'FLAG ?3,"There are no RECEIVING REPORTS ready for processing at this time.",!
 D EXMAIN
 QUIT
EN10 ;COUNT 'PENDING FISCAL ACTION' STATUS
 S FSO=10 D WORK S:X FLAG=1 D EXPO
 Q
EN26 ;COUNT 'ORDERED AND OBLIGATED (AMENDED)' STATUS
 S FSO=26 D WORK S:X FLAG=1 D EXPO
 Q
EN30 ;COUNT 'PARTIAL ORDER RECEIVED' STATUS
 S FSO=30 D WORK S:X FLAG=1 D EXPO
 Q
EN31 ;COUNT 'PARTIAL ORDER RECEIVED (AMENDED)' STATUS
 S FSO=31 D WORK S:X FLAG=1 D EXPO
 Q
EN15 ;COUNT 'PARTIAL ORDER RECEIVED BUT NOT OBLIGATED' STATUS
 S FSO=15 D WORK S:X FLAG=1 D EXPO
 Q
EN35 ;COUNT 'COMPLETE ORDER RECEIVED' STATUS
 S FSO=35 D WORK S:X FLAG=1 D EXPO
 Q
EN36 ;COUNT 'COMPLETE ORDER RECEIVED (AMENDED)' STATUS
 S FSO=36 D WORK S:X FLAG=1 D EXPO
 Q
EN20 ;COUNT 'COMPLETE ORDER RECEIVED BUT NOT OBLIGATED' STATUS
 S FSO=20 D WORK S:X FLAG=1 D EXPO
 Q
EN41 ;COUNT 'TRANSACTION COMPLETE (AMENDED)' STATUS
 S FSO=41 D WORK S:X FLAG=1 D EXPO
 Q
HDR ;
 W IOINHI,!!?3,"The following documents are ready for processing:",!
 W !?3,"Number",?11,"Type",?38,"Status",!
 N LINE S LINE="",$P(LINE,"-",75)="" W ?3,LINE K LINE W IOINORM
 K IOINLO,IOINHI,IOINORM
 Q
WORK D STATUS,COUNT,DISP
 Q
STATUS ;GET DOCUMENT STATUS
 S DIC=442.3,D="AC",DIC(0)="N",X=FSO D IX^DIC K DIC Q:Y<0
 Q
COUNT ;COUNT ENTRIES IN X-REF
 S X=0,I="" F  S I=$O(^PRC(442,"AI",FSO,I)) Q:I=""  K TX S TX=$G(^PRC(442,I,0)) I $P(TX,"-")=PRC("SITE") S X=X+1
 Q
DISP ;DISPLAY COUNT OF ENTRIES
 Q:'X
 W !?3,$J(X,6),?11,TYPE,?38,$P(Y,"^",2)
 Q
EXPO ;EXIT POINT FOR PURCHASE ORDER, AMENDMENTS, RECEIVING REPORTS
 KILL I,FSO,X,Y
 QUIT
EXMAIN ;MAIN EXIT POINT
 KILL LOOP,TAG,TYPE,FLAG,TX
 QUIT
PROMPT ; Prompt user if report should be run
 S DIR(0)="Y",DIR("A")="Do you want to run the report at this time",DIR("B")="NO"
 S DIR("A",1)=" ",DIR("A",2)="The system can now generate a report that will list the type and number"
 S DIR("A",3)="of each document that is ready for processing at this time."
 S DIR("A",4)=" ",DIR("A",5)="But, it may take a while to complete.",DIR("A",6)=" "
 S DIR("?")="Enter 'NO' or 'N' or 'RETURN' if the report should not be run at this time."
 S DIR("?",1)="Enter 'YES' or 'Y' to run the report"
 D ^DIR K DIR
 Q
