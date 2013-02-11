PRC5CON2 ;WISC/PLT-PRC5CON CONTINUE ; 09/12/95  11:24 AM
V ;;5.0;IFCAP;**27**;4/21/95
 ;QUIT  ; invalid entry
 ;
EN ;start convert CALM code sheet to FMS
 N PRCRI,PRCA,PRCB,PRCC,PRCD,PRCSITE,PRCPAT,PRCTD,PRCRD,PRCCNT
 N A,B,C
 S A=$$DATE^PRC0C($H,"H") I $P(A,"^",7)<2951014 D MMCALM("IFCAP V5 CALM CODE SHEET CONVERSION TOO EARLY^IFCAP V5 CALM CODE SHEETS CONVERSION USER","Please run this CALM code sheet conversion after 10/13/95.") QUIT
 D:'$D(ZTQUEUED) EN^DDIOL("IFCAP V5 calm code sheet conversion starts at "_$$NOW^PRC5A)
 ;^TMP("PRCCALM",$J,SITE-PAT#)=earliest transaction date^earliest transmision date
 K ^TMP("PRCCALM",$J)
 S PRCRI(420.92)=$O(^PRCU(420.92,"B","PRCCALM","")) D:PRCRI(420.92)
 . D DELETE^PRC0B1(.X,"420.92;^PRCU(420.92,;"_PRCRI(420.92))
 . QUIT
 ;get from batch/print entry
 S PRCA="95-100000" F  S PRCA=$O(^PRCF(421.2,"E",PRCA)) QUIT:'PRCA  D
 . S PRCRI(421.2)=0 F  S PRCRI(421.2)=$O(^PRCF(421.2,"E",PRCA,PRCRI(421.2))) QUIT:'PRCRI(421.2)  I PRCRI(421.2) S PRCC=$G(^PRCF(421.2,PRCRI(421.2),0)) I $P(PRCC,"-",2)="CLM",$P(PRCC,"^",3)="B" D
 .. S PRCC=$P(PRCC,"^")
 .. S PRCRI(423)=0 F  S PRCRI(423)=$O(^PRCF(423,"AD",PRCC,PRCRI(423))) QUIT:'PRCRI(423)  D F423
 . QUIT
 ;get code sheet from 423 if not batched/printed
 S PRCRI(423)=0 F  S PRCRI(423)=$O(^PRCF(423,"AC","N",PRCRI(423))) QUIT:'PRCRI(423)  D F423
 ;copy ^TMP entry to file 420.92
 S PRCRI(420.92)=$O(^PRCU(420.92,"B","PRCCALM","")) D:'PRCRI(420.92)
 . N A
 . S X="PRCCALM",X("DR")="1////IFCAP V4 PO 1996 CALM CODE SHEET;2///^S X=""N"""
 . D ADD^PRC0B1(.X,.Y,"420.92;^PRCU(420.92,")
 . I Y=-1 K Y I Y W:'$D(ZTQUEUED) !,"ERROR TRAP! CALL IRM/ISC SUPPORT."
 . S PRCRI(420.92)=+Y
 . QUIT
 S PRCA="" F  S PRCA=$O(^TMP("PRCCALM",$J,PRCA)) QUIT:'PRCA  S PRCB=$G(^(PRCA)) D
 . S PRCC=PRCA_"~"_$TR(PRCB,"^","~")
 . S A="420.92;^PRCU(420.92,;"_PRCRI(420.92)_";3~420.923;^PRCU(420.92,"_PRCRI(420.92)_",1,"
 . S X=0,X("DR")=".01///^S X=DA;1///^S X=PRCC"
 . D ADD^PRC0B1(.X,.Y,A) I Y=-1 S PRCERR=102
 . QUIT
 D EDIT^PRC0B(.X,"420.92;^PRCU(420.92,;"_PRCRI(420.92),"2.5///^S X=""N""","LS")
 S A="420.92;^PRCU(420.92,;"_PRCRI(420.92)_";4~420.924;^PRCU(420.92,"_PRCRI(420.92)_",2,"
 S X="|NOWRAP|"
 D ADD^PRC0B1(.X,.Y,A)
 I Y=-1 K Y I Y W:'$D(ZTQUEUED) !,"ERROR TRAP! CALL IRM/ISC SUPPORT."
 K ^TMP("PRCCALM",$J)
EN1 ;generate FMS documents
 S PRCCNT=0
 S PRCRI(420.92)=$O(^PRCU(420.92,"B","PRCCALM","")) I PRCRI(420.92) S PRCA=^PRCU(420.92,PRCRI(420.92),0) D:$P(PRCA,"^",4)]""&($P(PRCA,"^",6)="")
 . D ED^PRC5B1(PRCRI(420.92),1)
 . S PRCRI(420.923)=0
 . F  S PRCRI(420.923)=$O(^PRCU(420.92,PRCRI(420.92),1,PRCRI(420.923))) Q:'PRCRI(420.923)  D:$P(^(PRCRI(420.923),0),"^",2)="" FMSDOC(PRCRI(420.92),PRCRI(420.923))
 . D ED^PRC5B1(PRCRI(420.92),2)
 . QUIT
 D MMCALM("IFCAP V5 CALM CODE SHEETS CONVERSION DONE^IFCAP V5 CALM CODE SHEETS CONVERSION USER","IFCAP V5 CALM code sheets conversion done. Total FMS documents = "_PRCCNT)
 D:'$D(ZTQUEUED) EN^DDIOL("IFCAP V5 CALM code sheet conversion ends at "_$$NOW^PRC5A)
 QUIT
 ;
F423 ;get entry in file 423
 S PRCD=$G(^PRCF(423,PRCRI(423),0)),PRCRD=$G(^("TRANS"))
 QUIT:PRCD=""!(PRCRD="")
 S PRCSITE=$P(PRCD,"^",2),PRCPAT=$P(PRCD,"^",6),PRCTD=$$DATE^PRC0C($P(PRCD,"^",5),"E"),PRCTD=$P(PRCTD,"^",7),PRCRD=$P(PRCRD,"^",3)
 W:'$D(ZTQUEUED) !,PRCD,!,PRCRI(423),"    ",PRCTD,"    ",PRCSITE,"   ",PRCPAT
 QUIT:$P(PRCD,"^",10)'="CLM"  QUIT:PRCRD<2951001!'PRCRD
 S A=$G(^TMP("PRCCALM",$J,PRCSITE_"-"_PRCPAT))
 I A]"" S:$P(A,"^")>PRCTD $P(A,"^")=PRCTD S:$P(A,"^",2)>PRCRD $P(A,"^",2)=PRCRD
 I A="" S $P(A,"^")=PRCTD,$P(A,"^",2)=PRCRD
 S ^TMP("PRCCALM",$J,PRCSITE_"-"_PRCPAT)=A
 QUIT
 ;
FMSDOC(PRCA,PRCB) ;PRCA=ri of file 420.92, prcb=ri of file 420.923
 ; generate FMS doc
 N PRCRI,PRCC,PRCD,PRCE,A
 S PRCRI(420.92)=PRCA,PRCRI(420.923)=PRCB
 S A=^PRCU(420.92,PRCA,1,PRCB,1),PRCC=$P(A,"~",1),PRCD=$P(A,"~",3)
 S PRCRI(442)=$O(^PRC(442,"B",PRCC,"")) QUIT:'PRCRI(442)
 S PRCE=$G(^PRC(442,PRCRI(442),0))
 I $P(PRCE,"^",2)=21 QUIT:'$P(PRCE,"^",12)  S A=$G(^PRCS(410,$P(PRCE,"^",12),0)) QUIT:$P(A,"-",2)<96
 I $P(PRCE,"^",2)'=21,$P($G(^PRC(442,PRCRI(442),1)),"^",15)<2951001,$D(^(6)) D  QUIT
 . S A="420.92;^PRCU(420.92,;"_PRCRI(420.92)_";4~420.924;^PRCU(420.92,"_PRCRI(420.92)_",2,"
 . S X=PRCC_" - 1995 or earlier P.O. with Amendment, no FMS-doc generated."
 . D ADD^PRC0B1(.X,.Y,A)
 . I Y=-1 K Y I Y W:'$D(ZTQUEUED) !,"ERROR TRAP! CALL IRM/ISC SUPPORT."
 . QUIT
 S A=$P(PRCE,"^",15),A=$S(A>2950930:"E",1:"E")
 D
 . N PRCA,PRCB,PRCCON3
 . S PRCCON3=1 D EN^PRC5CON3(PRCRI(442),A,PRCD) S PRCCNT=PRCCNT+1
 . QUIT
 D ED1^PRC5B1(PRCA,PRCB) ;edit convert field in file 420.923
 QUIT
 ;
MMCALM(A,B) ;send CALM conversion done message
 N X,Y
 S X(1)=B
 S Y(.5)="",Y(PRCDUZ)="",Y("G.CSFISMGMT@FORUM.DOMAIN.EXT")=""
 D MM^PRC0B2(A,"X(",.Y)
 K PRCDUZ
 QUIT
