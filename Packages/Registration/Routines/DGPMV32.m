DGPMV32 ;ALB/MIR - CONTINUE TRANSFER A PATIENT OPTION ;3/28/2013
 ;;5.3;Registration;**418,260005**;Aug 13, 1993
 S:$D(PAR("TYPE")) %=$$GETMVTT^DGPMAPI8(.MVTT,PAR("TYPE")),%=$$GETMASMT^DGPMAPI8(.MAS,MVTT("MAS"))
 S DGPMTYP=+$G(MVTT("MAS")) I $S('DGPMTYP:1,'$G(MAS("ABS")):1,1:0) I '$G(PAR("TYPE"))!'$G(PAR("WARD")) W !,"Incomplete Transfer...Deleted" S DGQUIT=1 G Q
 I $S(+$G(PAR("WARD"))_U_+$G(PAR("ROOMBED"))=+$G(OLD("WARD"))_U_+$G(OLD("ROOMBED")):0,'DGPMABL:0,1:1) S DGPMND=DGPMA D AB ;if change in room-bed or ward and next movement is to absence, update subsequent absences
CONT S DGPMTYP="^"_DGPMTYP_"^" I "^13^44^"[DGPMTYP D ECA^DGPMV321 ;Edit Corresponding admission when TO ASIH or RESUME ASIH
 I DGPMTYP="^43^" ;D ASIHOF
 I "^14^45^"[DGPMTYP D UHD^DGPMV321 ;if FROM ASIH or CHANGE ASIH LOCATION (O.F.)
 I 'MVTT("ASKSPEC") G Q
 S Y=0 D SPEC^DGPMV36
Q K ORQUIT
 Q
AB ;update absences upon ward/room-bed change during admit or transfer patient options
 S DGI=$P(DGPMND,"^"),DIE="^DGPM(",DIC(0)="M" W !,"Updating subsequent Absences"
 F DGI=DGI:0 S DGI=$O(^DGPM("APTT2",DFN,DGI)) Q:'DGI  F DGJ=0:0 S DGJ=$O(^DGPM("APTT2",DFN,DGI,DGJ)) Q:'DGJ  I $D(^DGPM(DGJ,0)) S DGJJ=^(0) Q:$P(DGJJ,"^",14)'=DGPMCA  D ABB
 K DA,DGI,DGJ,DGJJ,DGPMND,DIC,DIE,J
 Q
ABB ;absence checks
 I $S($P(DGJJ,"^",18)=23:0,'$D(^DG(405.2,+$P(DGJJ,"^",18),"E")):1,^("E"):0,1:1) Q  ;quit if from pass or not absence mvt
 S J=$S("^1^23^43^45^"[("^"_$P(DGJJ,"^",18)_"^"):1,1:0),DA=+DGJ,DR=".06////"_$P(DGPMND,"^",6)_$S(J:";.07////"_$P(DGPMND,"^",7),1:"") K DQ,DG
 S ^UTILITY("DGPM",$J,$P(DGJJ,"^",2),DA,"P")=DGJJ D ^DIE S ^UTILITY("DGPM",$J,$P(DGJJ,"^",2),DA,"A")=^DGPM(DA,0)
 Q
DICS S DGX=+$G(PMVT("TYPE")) I $S('$D(^DG(405.1,+DGX,0)):0,'$D(^DG(405.1,+Y,"F",+DGX)):1,1:0) S DGER=1 Q
 S DGX=+$G(NMVT("TYPE")) I $S('$D(^DG(405.1,+DGX,0)):0,'$D(^DG(405.1,+DGX,"F",+Y)):1,1:0) S DGER=1 Q
 S DGX=$P(^DG(405.1,+Y,0),"^",3) I +$G(PMVT("TTYPE"))=1,$S('$D(^DG(405.2,+DGX,"E")):0,$P(^("E"),"^",2):0,1:1) S DGER=1 Q
 I +$G(PMVT("ASIH")),(DGX=14),(+PMVT("MASTYPE")'=45) S DGER=1 Q
 I $D(OLD),"^1^2^3^"[("^"_(+$G(OLD("MASTYPE")))_"^"),(DGX=4) S DGER=1 Q
 ;I "^13^43^44^45"[("^"_DGX_"^"),("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^")) S DGER=1 Q
 I "^13^43^44^45^"[("^"_DGX_"^"),("^NH^D^"'[("^"_$S($D(^DIC(42,+ADM("WARD"),0)):$P(^(0),"^",3),1:"")_"^"))&($P(^(0),"^",17)'=1) S DGER=1 Q  ;p-418
 ;I DGX=14,("^NH^D^"'[("^"_$S($D(^DIC(42,+$P(DGPMAN,"^",6),0)):$P(^(0),"^",3),1:"")_"^")) S DGER=1 Q
 I DGX=14,("^NH^D^"'[("^"_$S($D(^DIC(42,+$G(ADM("WARD")),0)):$P(^(0),"^",3),1:"")_"^"))&($P(^(0),"^",17)'=1) S DGER=1 Q  ;p-418
 I $G(OLD("ASIH")),(DGX'=+$G(OLD("DISIFN"))) S DGER=1 Q
 I DGX=44,(+$G(NMVT("MASTYPE"))=14) S DGER=1 Q
 S DGER=0 Q
ASIHOF ;if TO ASIH (OTHER FACILITY) update pseudo discharge
 I DGPMN S DGPMTN=DGPMA,DGPMNI=DGPMCA D FINDLAST,ASIHOF^DGPMV321 Q
 S X1=+DGPMA,X2=30 D C^%DTC S DA=$P(DGPMAN,"^",17)
 I $D(^DGPM(+DA,0)) S ^UTILITY("DGPM",$J,3,DA,"P")=$S($D(^UTILITY("DGPM",$J,3,DA,"P")):^("P"),1:^DGPM(DA,0)),DIE="^DGPM(",DR=".01///"_X K DQ,DG D ^DIE S ^UTILITY("DGPM",$J,3,DA,"A")=^DGPM(DA,0) ;update pseudo discharge
 Q
SET ;set variables if coming from hospital admission (for FINDLAST)
 S DGPMAB=0,DGPMTN=$S($D(^DGPM(+$G(ADM("ASIHTRA")),0)):^(0),1:""),DGPMNI=$S($D(^DGPM(+$P(DGPMTN,"^",14),0)):+$P(DGPMTN,"^",14),1:"") Q:'DGPMNI
FINDLAST ;find the last transfer which originated ASIH care (either a TO ASIH or TO ASIH (OTHER FACILITY) transfer)
 ;
 ;input:  DGPMNI - IFN of NHCU/DOM admission
 ;        DGPMTN - 0 node of transfer which created hospital admission
 ;output: DGPMAB - the date/time on which ASIH care began.  will be the
 ;                 same date/time for TO ASIH and TO ASIH (O.F.),
 ;                 earlier for RESUME ASIH IN PARENT FACILITY and 
 ;                 CHANGE ASIH LOCATION (OTHER FACILITY) transfers.
 ;
 S DGPMAB=0 I "^13^43^"[("^"_$P(DGPMTN,"^",18)_"^") S DGPMAB=+DGPMTN Q
 I "^44^45^"[("^"_$P(DGPMTN,"^",18)_"^") F I=9999999.999999-+DGPMTN:0 S I=$O(^DGPM("APMV",DFN,DGPMNI,I)) Q:'I  S X=$O(^(I,0)) I $D(^DGPM(+X,0)),("^13^43^"[("^"_$P(^(0),"^",18)_"^")) S DGPMAB=$P(^(0),"^",1) Q
 K DGPMNI,DGPMTN Q
