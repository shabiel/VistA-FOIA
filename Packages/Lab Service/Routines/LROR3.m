LROR3 ;SLC/DCM - CANCEL,PURGE,SETUP,CLEAN EXECUTES ;11/26/90  10:10 ;
 ;;5.2;LAB SERVICE;**100,121,165**;Sep 27, 1994
C ;;Cancel execute from OR
 I ORSTS="",$D(ORPK),$L($P(ORPK,"^",8)) S X=$P(ORPK,"^",2)_","""_$P(ORPK,"^",5)_""","_$P(ORPK,"^",3)_","_$P(ORPK,"^",4)_","_$P(ORPK,"^",8) K:$L(X) @("^XUTL(""OR"",$J,""LROT"","_X_")") S ORSTS="K" D ST^ORX W "  Deleted" Q
 I +ORSTS=11 S ORSTS="K" D ST^ORX W "  Deleted" Q
 I ORGY=0 D C3 Q:LREND
 I ORGY'=0 S LRODT=+ORPK,LRSN=$P(ORPK,"^",2),I=$P(ORPK,"^",3)
 I 'LRODT!('LRSN)!('I) S ORSTS=1 D:ORGY=9 ST^ORX Q
 I '$D(^LRO(69,LRODT,1,LRSN)),ORGY=10 Q
 I '$D(^LRO(69,LRODT,1,LRSN)),ORGY=9 S ORSTS=1 D ST^ORX Q
 I '$D(^LRO(69,LRODT,1,LRSN,2,I)),ORGY=10 Q
 I '$D(^LRO(69,LRODT,1,LRSN,2,I)),ORGY=9 S ORSTS=1 D ST^ORX Q
 I $D(^LRO(69,LRODT,1,LRSN,3)),$P(^(3),"^",2) W !,"Tests already verified for this portion of the order, cannot delete." G END
C1 S LRORD=+^LRO(69,LRODT,1,LRSN,.1),X=^(2,I,0),LRTSN=+X,LRAD=+$P(X,"^",3),LRAA=+$P(X,"^",4),LRAN=+$P(X,"^",5),(LRNOP,LRACC)="",LRONE=""
 I LRAD,LRAA,LRAN,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)),'$D(^XUSEC("LRLAB",DUZ)) W !!,$C(7),"Already accessioned.  Contact lab to cancel.",! G END
C2 ;
 ;I ORGY=0 D DC^ORX5 S LREND=1 G END
 I ORGY=0 S LREND=1 G END
 I ORGY=9 D C4
END K LRODT,LRSN,LRAD,LRAA,LRAN,LRNOP,LRACC,LRONE,LRC,LRDFN,LRDPF,LRSX,LRTSN,LRUSNM
 Q
C3 I 'ORPK D C2 Q
 S LRODT=+ORPK,LRSN=$P(ORPK,"^",2),I=$P(ORPK,"^",3) I 'LRODT!('LRSN)!('I) D C2 Q
 I '$D(^LRO(69,LRODT,1,LRSN,2,I)) K LRODT,LRSN D C2 Q
 S LREND=0 Q
 Q
C4 I LRAD,LRAA,LRAN,$D(^LRO(68,LRAA,1,LRAD,1,LRAN,0)) D OR^LRCENDE1 I LRNOP G END
 I 'LRNOP D C5
 S ORSTS=1 D ST^ORX
 Q
C5 ;
 S $P(^LRO(69,LRODT,1,LRSN,2,$P(ORPK,"^",3),0),"^",3,6)="^^^",$P(^(0),"^",9,11)="CA^W^"_DUZ
 ;K ^LRO(69,LRODT,1,LRSN,2,$P(ORPK,"^",3)),^LRO(69,LRODT,1,LRSN,2,"B",LRTSN,$P(ORPK,"^",3)) S LRTSN=$P(^LAB(60,LRTSN,0),"^") S:'$D(^LRO(69,LRODT,1,LRSN,6,0)) ^(0)="^69.04^^"
 ;S LRUSNM=$P(^VA(200,DUZ,0),"^"),X=1+$P(^LRO(69,LRODT,1,LRSN,6,0),"^",3),$P(^(0),"^",3,4)=X_"^"_X,^(X,0)="Ordered test "_LRTSN_" deleted by "_LRUSNM
 ;S DIE="^LRO(69,LRODT,1,",DA=LRSN,DR=16 D ^DIE
 S Y=$P(^LRO(69,LRODT,1,LRSN,0),"^",8) D DD^%DT W !,"  Ordered test "_$P(^LAB(60,LRTSN,0),"^")_" for "_Y_" cancelled."
 Q
P ;;Purge execute from OR
 S LREND=0,LRXODT=+ORPK,LRXSN=$P(ORPK,"^",2),LRXTN=$P(ORPK,"^",3)
 I LRXODT,LRXSN,LRXTN,ORSTS'=1 D PEND
 I 'LREND S ORSTS="K" D ST^ORX
 K LRXODT,LRXSN,LRXTN,LREND Q
SETUP ;;Setup execute from OR
 Q
CLEAN ;;Clean-up execute from OR
 D LREND^LROW4
 K LRASK,LRPREV,LROCK,LRPGM,LRTSNM,LRCK,LRDTX,LROSX,LREK,LROST,LRPRAM,LRA,LRAA,LRABV,LRAD,LRAX,LRC,LRH,LRSF,LRSS,LRSX,LRU,LRWHO,LRECUR,LRNOW,LRSTUB,LRZX,LRSZX
 K ^XUTL("OR",$J,"LROST"),^("LRZX"),^("LROT"),^("COM")
 Q
PEND I '$D(^LRO(69,LRXODT,1,LRXSN,0)) Q
 S X=+^LRO(69,LRXODT,1,LRXSN,0) I $D(^LR(X,0)),$P(^(0),"^",2)'=2 G P1
 I '$D(^LRO(69,LRXODT,1,LRXSN,1)) S LREND=1 Q
 I ORSTS=5 S LREND=1 Q
 I $D(^LRO(69,LRXODT,1,LRXSN,3)),'$L($P(^(3),"^",2)) S LREND=1 Q
P1 S:$D(^LRO(69,LRXODT,1,LRXSN,2,LRXTN,0)) $P(^(0),"^",7)="" Q
 Q
