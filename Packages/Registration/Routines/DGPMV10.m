DGPMV10 ;ALB/MRL/MIR - PATIENT MOVEMENT, CONT.; 7/11/13
 ;;5.3;Registration;**84,498,509,683,719,260005**;Aug 13, 1993
CS ;Current Status
 ;first print primary care team/practitioner/attending
 N %,LMVT
 D PCMM^SCRPU4(DFN,DT)
 S X=$S('DGPMT:1,DGPMT<4:2,DGPMT>5:2,1:3) ;DGPMT=0 if from pt inq (DGRPD)
 S %=$$GETLASTM^DGPMAPI8(.LMVT,DFN)
 I $D(LMVT)'>1 W !!,"Status      : PATIENT HAS NO INPATIENT OR LODGER ACTIVITY IN THE COMPUTER",*7 D CS2 Q
 S A=$S("^3^5^"[("^"_+LMVT("TYPE")_"^"):0,1:+LMVT("TYPE")) W !!,"Status      : ",$S('A:"IN",1:""),"ACTIVE ",$S("^4^5^"[("^"_+LMVT("TYPE")_"^"):"LODGER",1:"INPATIENT")
 G CS1:'A W "-" S X=+LMVT("MASTYPE") I X=1 W "on PASS" G CS1
 I "^2^3^25^26^"[("^"_X_"^") W "on ",$S("^2^26^"[X:"A",1:"U"),"A" G CS1
 I "^13^43^44^45^"[("^"_X_"^") W "ASIH" G CS1
 I X=6 W "OTHER FAC" G CS1
 W "on WARD"
CS1 I +LMVT("TYPE")=3,+LMVT("DISIFN") W ?39,"Discharge Type : ",$S($L(LMVT("DISTYPE")):LMVT("DISTYPE"),1:"UNKNOWN")
 I "^3^4^5^"'[("^"_+LMVT("TYPE")_"^"),($P(LMVT("SERILL"),U)="S") W "  (Seriously ill)"
 W ! I +LMVT("FDEXC") W "Patient chose not to be included in the Facility Directory for this admission"
 W !,$S("^4^5^"'[("^"_+LMVT("TYPE")_"^"):"Admitted    ",1:"Checked-in  "),": "_$P(LMVT("ADMDT"),"^",2)
 N LMVTTY,LMVTDT,LMVTADM
 S LMVTTY=LMVT("TYPE")
 S LMVTDT=LMVT("DATE")
 W ?39,$S("^4^5^"[("^"_+LMVTTY_"^"):"Checked-out",+LMVTTY=3:"Discharged ",1:"Transferred"),"    : ",$S("^1^4^"'[("^"_+LMVTTY_"^"):$P(LMVTDT,"^",2),$P(LMVTDT,"^",2)'=$P(LMVT("ADMDT"),"^",2):$P(LMVTDT,"^",2),1:"")
 W !,"Ward        : ",$E($P(LMVT("WARD"),"^",2),1,24)
 W ?39,"Room-Bed       : ",$E($P(LMVT("ROOMBED"),"^",2),1,21)
 I "^4^5^"'[("^"_+LMVTTY_"^") W !,"Provider    : ",$E($P(LMVT("PRYMPHY"),"^",2),1,26) D
 . W ?39,"Specialty      : ",$E($P(LMVT("FTSPEC"),"^",2),1,21)
 W !,"Attending   : ",$E($P(LMVT("ATNDPHY"),"^",2),1,26)
 D CS2
 S DGPMIFN=LMVT("ADMIFN") I +LMVT("TYPE")'=4&(+LMVT("TYPE")'=5) D ^DGPMLOS W !!,"Admission LOS: ",+$P(X,"^",5),"  Absence days: ",+$P(X,"^",2),"  Pass Days: ",+$P(X,"^",3),"  ASIH days: ",+$P(X,"^",4)
 K A,C,I,J,X
 Q
 ;
CS2 ;-- additional fields for admission screen
 Q:DGPMT'=1
 N %,PAT S %=$$GETPAT^DGPMAPI8(.PAT,DFN)
 W !!,"Religion    : ",$E($P(PAT("RELPREF"),U,2),1,24)
 W ?39,"Marital Status : ",$P(PAT("MSTAT"),U,2)
 W !,"Eligibility : ",$P(PAT("ELIG"),U,2)
 W:PAT("ESTAT")]"" " (",$P(PAT("ESTAT"),U,2),")"
 W:PAT("ESTAT")']"" " (NOT VERIFIED)"
 K DGHOLD
 Q
 ;
LODGER ;set-up necessary variables if getting last lodger episode
 ;only need 1,2,13,17 - date/time,TT,check-in IFN,check-out IFN
 S I=$O(^DGPM("ATID4",DFN,0)),I=$O(^(+I,0))
 S X=$S($D(^DGPM(+I,0)):^(0),1:"") I 'X D NULL Q
 I $D(^DGPM(+$P(X,"^",17),0)) S (DGPMDCD,DGPMVI(1))=+^(0),DGPMVI(2)=5,DGPMVI(13)=I,DGPMVI(17)=$P(X,"^",17) Q
 S (DGPMDCD,DGPMVI(17))="",DGPMVI(1)=+X,DGPMVI(2)=4,DGPMVI(13)=I
 Q
NULL S DGPMDCD="" F I=1,2,13,17 S DGPMVI(I)=""
 Q
 ;
INP ;set-up inpt vbls needed (mimic VAIP array)
 ;
 ;Called from scheduling, too
 ;
 N %
 I '$D(NOW) D NOW^%DTC S (VAX("DAT"),NOW)=%,NOWI=9999999.999999-%
 E  S NOWI=NOW,(VAX("DAT"),NOW)=9999999.999999-NOWI
 I '$D(VAIP("E")) D LAST^VADPT3
 F I=1:1:8,13,17 S DGPMVI(I)=""
 F I=13,19 S DGPMVI(I,1)=""
 S DGPMVI(1)=$S($D(VAIP("E")):VAIP("E"),1:E) ;use ifn of last mvt from VADPT call or one passed from DGPMV
 S DGX=$G(^DGPM(+DGPMVI(1),0)),DGPMVI(2)=$P(DGX,"^",2),DGPMVI(4)=$P(DGX,"^",18) S Y=+DGX X ^DD("DD") S DGPMVI(3)=$P(DGX,"^",1)_"^"_Y
 S DGPMVI(5)=$P(DGX,"^",6)_"^"_$S($D(^DIC(42,+$P(DGX,"^",6),0)):$P(^(0),"^",1),1:""),DGPMVI(6)=$P(DGX,"^",7)_"^"_$S($D(^DG(405.4,+$P(DGX,"^",7),0)):$P(^(0),"^",1),1:""),DGPMVI(13)=$P(DGX,"^",14)
 I "^3^5^"[("^"_DGPMVI(2)_"^") D GETWD ;get from ward if d/c or check-out
 S DGX=$G(^DGPM(+DGPMVI(13),0)) I DGX]"" S Y=+DGX X ^DD("DD") S DGPMVI(13,1)=$P(DGX,"^",1)_"^"_Y,DGPMVI(17)=$P(DGX,"^",17) I $D(DGPMSVC) S DGPMSV=$P($G(^DIC(42,+$P(DGX,"^",6),0)),"^",3)
 S DGPMDCD=$S($D(^DGPM(+DGPMVI(17),0)):$P(^(0),"^",1),1:"")
 S (DGTS,DGPP,DGAP)="" ;t.s., primary care physician, attending
 F I=NOWI:0 S I=$O(^DGPM("ATS",DFN,+DGPMVI(13),I)) Q:'I  F J=0:0 S J=$O(^DGPM("ATS",DFN,+DGPMVI(13),I,J)) Q:'J  F IFN=0:0 S IFN=$O(^DGPM("ATS",DFN,+DGPMVI(13),I,J,IFN)) Q:'IFN  D TS1 G TSQ:DGTS&DGPP&DGAP
TSQ S DGPMVI(7)=DGPP,DGPMVI(8)=DGTS,DGPMVI(18)=DGAP
 S DGX=$G(^DGPM(+DGPMVI(13),0)) I $P(DGX,"^",2)=1 D
 .S DGX=$G(^DGPM(+DGPMVI(13),"DIR"))
 .S DGX=$P(DGX,"^",1)
 .I DGX="" S DGX=$S('DGPMDCD:1,(DGPMDCD<3030414.999999):"",1:1) Q:DGX=""
 .S DGPMVI(19,1)=DGX_"^"_$$EXTERNAL^DILFD(405,41,,DGX)
 D Q^VADPT3 K DGAP,DGPP,DGTS,DGX,IFN
 Q
 ;
TS1 ; set DGTS, DGPP, and DGAP
 Q:'$D(^DGPM(IFN,0))  S DGX=^(0)
 I 'DGPP,$D(^VA(200,+$P(DGX,"^",8),0)) S Y=$P(DGX,"^",8)_"^"_$P(^(0),"^") S DGPP=Y
 I 'DGAP,$D(^VA(200,+$P(DGX,"^",19),0)) S Y=$P(DGX,"^",19)_"^"_$P(^(0),"^") S DGAP=Y
 I 'DGTS,$D(^DIC(45.7,+$P(DGX,"^",9),0)) S DGTS=$P(DGX,"^",9)_"^"_$P(^(0),"^")
 Q
GETWD ;get the from ward if last mvt is discharge or check-out
 I DGPMVI(2)=5 S J=DGPMVI(13) D SETWD Q
 F I=0:0 S I=$O(^DGPM("APMV",DFN,DGPMVI(13),I)) Q:'I!+DGPMVI(5)  F J=0:0 S J=$O(^DGPM("APMV",DFN,DGPMVI(13),I,J)) Q:'J  D SETWD Q:+DGPMVI(5)
 Q
 ;
SETWD ;set ward and room-bed variables for discharge/check-out mvts
 S X=$G(^DGPM(J,0))
 I $D(^DIC(42,+$P(X,"^",6),0)) S DGPMVI(5)=$P(X,"^",6)_"^"_$P(^(0),"^",1)
 I $D(^DG(405.4,+$P(X,"^",7),0)) S DGPMVI(6)=$P(X,"^",7)_"^"_$P(^(0),"^",1)
 Q
