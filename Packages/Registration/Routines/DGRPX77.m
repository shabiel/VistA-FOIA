DGRPX77 ; ;08/29/12
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,9) S:%]"" DE(35)=% S %=$P(%Z,U,11) S:%]"" DE(25)=%
 I $D(^(.32)) S %Z=^(.32) S %=$P(%Z,U,3) S:%]"" DE(37)=%
 I $D(^(.36)) S %Z=^(.36) S %=$P(%Z,U,1) S:%]"" DE(33)=%
 I $D(^(.362)) S %Z=^(.362) S %=$P(%Z,U,6) S:%]"" DE(30)=% S %=$P(%Z,U,17) S:%]"" DE(28)=% S %=$P(%Z,U,20) S:%]"" DE(27)=%
 I $D(^(.385)) S %Z=^(.385) S %=$P(%Z,U,1) S:%]"" DE(9)=% S %=$P(%Z,U,2) S:%]"" DE(1)=%,DE(12)=%,DE(15)=%
 I $D(^("ODS")) S %Z=^("ODS") S %=$P(%Z,U,2) S:%]"" DE(39)=% S %=$P(%Z,U,3) S:%]"" DE(40)=%
 K %Z Q
 ;
W W !?DL+DL-2,DLB_": "
 Q
O D W W Y W:$X>45 !?9
 I $L(Y)>19,'DV,DV'["I",(DV["F"!(DV["K")) G RW^DIR2
 W:Y]"" "// " I 'DV,DV["I",$D(DE(DQ))#2 S X="" W "  (No Editing)" Q
TR R X:DTIME E  S (DTOUT,X)=U W $C(7)
 Q
A K DQ(DQ) S DQ=DQ+1
B G @DQ
RE G PR:$D(DE(DQ)) D W,TR
N I X="" G NKEY:$D(^DD("KEY","F",DP,DIFLD)),A:DV'["R",X:'DV,X:D'>0,A
RD G QS:X?."?" I X["^" D D G ^DIE17
 I X="@" D D G Z^DIE2
 I X=" ",DV["d",DV'["P",$D(^DISV(DUZ,"DIE",DLB)) S X=^(DLB) I DV'["D",DV'["S" W "  "_X
T G M^DIE17:DV,^DIE3:DV["V",P:DV'["S" X:$D(^DD(DP,DIFLD,12.1)) ^(12.1) I X?.ANP D SET I 'DDER X:$D(DIC("S")) DIC("S") I  W:'$D(DB(DQ)) "  "_% G V
 K DDER G X
P I DV["P" S DIC=U_DU,DIC(0)=$E("EN",$D(DB(DQ))+1)_"M"_$E("L",DV'["'") S:DIC(0)["L" DLAYGO=+$P(DV,"P",2) G:DV["*" AST^DIED D NOSCR^DIED S X=+Y,DIC=DIE G X:X<0
 G V:DV'["N" D D I $L($P(X,"."))>24 K X G Z
 I $P(DQ(DQ),U,5)'["$",X?.1"-".N.1".".N,$P(DQ(DQ),U,5,99)["+X'=X" S X=+X
V D @("X"_DQ) K YS
Z K DIC("S"),DLAYGO I $D(X),X'=U D:$G(DE(DW,"INDEX")) SAVEVALS G:'$$KEYCHK UNIQFERR^DIE17 S DG(DW)=X S:DV["d" ^DISV(DUZ,"DIE",DLB)=X G A
X W:'$D(ZTQUEUED) $C(7),"??" I $D(DB(DQ)) G Z^DIE17
 S X="?BAD"
QS S DZ=X D D,QQ^DIEQ G B
D S D=DIFLD,DQ(DQ)=DLB_U_DV_U_DU_U_DW_U_$P($T(@("X"_DQ))," ",2,99) Q
Y I '$D(DE(DQ)) D O G RD:"@"'[X,A:DV'["R"&(X="@"),X:X="@" S X=Y G N
PR S DG=DV,Y=DE(DQ),X=DU I $D(DQ(DQ,2)) X DQ(DQ,2) G RP
R I DG["P",@("$D(^"_X_"0))") S X=+$P(^(0),U,2) G RP:'$D(^(Y,0)) S Y=$P(^(0),U),X=$P(^DD(X,.01,0),U,3),DG=$P(^(0),U,2) G R
 I DG["V",+Y,$P(Y,";",2)["(",$D(@(U_$P(Y,";",2)_"0)")) S X=+$P(^(0),U,2) G RP:'$D(^(+Y,0)) S Y=$P(^(0),U) I $D(^DD(+X,.01,0)) S DG=$P(^(0),U,2),X=$P(^(0),U,3) G R
 X:DG["D" ^DD("DD") I DG["S" S %=$P($P(";"_X,";"_Y_":",2),";") S:%]"" Y=%
RP D O I X="" S X=DE(DQ) G A:'DV,A:DC<2,N^DIE17
I I DV'["I",DV'["#" G RD
 D E^DIE0 G RD:$D(X),PR
 Q
SET N DIR S DIR(0)="SV"_$E("o",$D(DB(DQ)))_U_DU,DIR("V")=1
 I $D(DB(DQ)),'$D(DIQUIET) N DIQUIET S DIQUIET=1
 D ^DIR I 'DDER S %=Y(0),X=Y
 Q
SAVEVALS S @DIEZTMP@("V",DP,DIIENS,DIFLD,"O")=$G(DE(DQ)) S:$D(^("F"))[0 ^("F")=$G(DE(DQ))
 I $D(DE(DW,"4/")) S @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")=""
 E  K @DIEZTMP@("V",DP,DIIENS,DIFLD,"4/")
 Q
NKEY W:'$D(ZTQUEUED) "??  Required key field" S X="?BAD" G QS
KEYCHK() Q:$G(DE(DW,"KEY"))="" 1 Q @DE(DW,"KEY")
BEGIN S DNM="DGRPX77",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,DW=".385;2",DV="*P27.18'X",DU="",DLB="PENSION AWARD REASON",DIFLD=.3852
 S DE(DW)="C1^DGRPX77"
 S DU="DG(27.18,"
 S X="@"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C1 G C1S:$D(DE(1))[0 K DB
 S X=DE(1),DIC=DIE
 D EVENT^IVMPLOG(DA)
C1S S X="" G:DG(DQ)=X C1F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C1F1 Q
X1 S:($G(X)]"")&(X'?1P.P) X=$$UPPER^DGUTL(X) S X=$$LOWER^DGUTL(X) S DIC("S")="I $P($G(^(0)),U)[""Original Award""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S Y="@7026"
 Q
3 S DQ=4 ;@7022
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S:($P($G(^DPT(DFN,.385)),U,10)'="Y") Y="@7023"
 Q
5 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=5 D X5 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X5 D EN^DDIOL("Pension Award Date and Pension Award Reason are editable only if VA Pension","","!!")
 Q
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 D EN^DDIOL("Indicator is Yes and Pension Award Reason is not 'Original Award'.  For any","","!")
 Q
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 D EN^DDIOL("other assistance, use the HEC Alert process.","","!")
 Q
8 S DQ=9 ;@7023
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW=".385;1",DV="DX",DU="",DLB="PENSION AWARD EFFECTIVE DATE",DIFLD=.3851
 S DE(DW)="C9^DGRPX77"
 G RE
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 D EVENT^IVMPLOG(DA)
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C9F1 Q
X9 S %DT="EPX" D ^%DT S X=Y K:Y<1 X I $D(X) D H^DGUTL I $G(X)>0 S DFN=DA D DTCHK^DGRP7CP
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 I X]"" S Y="@7024"
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 G A
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW=".385;2",DV="*P27.18'X",DU="",DLB="PENSION AWARD REASON",DIFLD=.3852
 S DE(DW)="C12^DGRPX77"
 S DU="DG(27.18,"
 S X="@"
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 D EVENT^IVMPLOG(DA)
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C12F1 Q
X12 S:($G(X)]"")&(X'?1P.P) X=$$UPPER^DGUTL(X) S X=$$LOWER^DGUTL(X) S DIC("S")="I $P($G(^(0)),U)[""Original Award""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y="@7026"
 Q
14 S DQ=15 ;@7024
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW=".385;2",DV="*P27.18'X",DU="",DLB="PENSION AWARD REASON",DIFLD=.3852
 S DE(DW)="C15^DGRPX77"
 S DU="DG(27.18,"
 G RE
C15 G C15S:$D(DE(15))[0 K DB
 S X=DE(15),DIC=DIE
 D EVENT^IVMPLOG(DA)
C15S S X="" G:DG(DQ)=X C15F1 K DB
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C15F1 Q
X15 S:($G(X)]"")&(X'?1P.P) X=$$UPPER^DGUTL(X) S X=$$LOWER^DGUTL(X) S DIC("S")="I $P($G(^(0)),U)[""Original Award""" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 I X="" S Y="@7026"
 Q
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 I X=$$GET1^DIQ(2,DFN,.3852,"I") S Y="@7026"
 Q
18 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=18 D X18 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X18 I $$GET1^DIQ(27.18,X,.01,"E")'["Original Award" D EN^DDIOL("Only 'Original Award' may be entered",,"!!") S Y="@7024"
 Q
19 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=19 D X19 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X19 S Y="@7026"
 Q
20 S DQ=21 ;@7025
21 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=21 D X21 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X21 D EN^DDIOL("Pension Award Date and Pension Award Reason are editable only if VA Pension","","!!")
 Q
22 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=22 D X22 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X22 D EN^DDIOL("Indicator is Yes and Pension Award Reason is not 'Original Award'.  For any","","!")
 Q
23 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=23 D X23 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X23 D EN^DDIOL("other assistance, use the HEC Alert process.","","!")
 Q
24 S DQ=25 ;@7026
25 D:$D(DG)>9 F^DIE17,DE S DQ=25,DW=".3;11",DV="SX",DU="",DLB="RECEIVING VA DISABILITY?",DIFLD=.3025
 S DE(DW)="C25^DGRPX77"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
C25 G C25S:$D(DE(25))[0 K DB
 S X=DE(25),DIC=DIE
 X ^DD(2,.3025,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,2.4)
 S X=DE(25),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,2,2.4)
 S X=DE(25),DIC=DIE
 D EVENT^IVMPLOG(DA)
C25S S X="" G:DG(DQ)=X C25F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.3025,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C25F1 Q
X25 S DFN=DA D MV^DGLOCK I $D(X),X="Y" D EC^DGLOCK1
 Q
 ;
26 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=26 D X26 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X26 S:(X'="Y")&($P($G(^DPT(DA,.362)),U,12,14)'["Y") Y=.36265
 Q
27 D:$D(DG)>9 F^DIE17,DE S DQ=27,DW=".362;20",DV="NJ8,2X",DU="",DLB="TOTAL ANNUAL VA CHECK AMOUNT",DIFLD=.36295
 S DE(DW)="C27^DGRPX77"
 G RE
C27 G C27S:$D(DE(27))[0 K DB
 S X=DE(27),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DE(27),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C27S S X="" G:DG(DQ)=X C27F1 K DB
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C27F1 Q
X27 D DOL^DGLOCK2 K:+X'=X&(X'?.N1"."2N)!(X>99999)!(X<0) X I $D(X) S DFN=DA D MV^DGLOCK I $D(X),('$$TOTCHK^DGLOCK2(DFN)) D TOTCKMSG^DGLOCK2 K X
 Q
 ;
28 D:$D(DG)>9 F^DIE17,DE S DQ=28,DW=".362;17",DV="SX",DU="",DLB="GI INSURANCE POLICY?",DIFLD=.36265
 S DE(DW)="C28^DGRPX77"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 G RE
C28 G C28S:$D(DE(28))[0 K DB
 S X=DE(28),DIC=DIE
 X ^DD(2,.36265,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(2,.36265,1,1,2.4)
C28S S X="" G:DG(DQ)=X C28F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.36265,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,6),X=X S DIU=X K Y S X="" X ^DD(2,.36265,1,1,1.4)
C28F1 Q
X28 S DFN=DA D MV^DGLOCK Q
 Q
 ;
29 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=29 D X29 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X29 S:X'="Y" Y="@703"
 Q
30 D:$D(DG)>9 F^DIE17,DE S DQ=30,DW=".362;6",DV="NJ8,2X",DU="",DLB="AMOUNT OF GI INSURANCE",DIFLD=.3626
 G RE
X30 D DOL^DGLOCK2 K:+X'=X&(X'?.N1"."2N)!(X>999999)!(X<1) X I $D(X) S DFN=DA D MV^DGLOCK I $D(X),$D(^DPT(DA,.362)),$P(^(.362),U,17)'="Y" W !?4,*7,"Applicant doesn't have GI Insurance." K X
 Q
 ;
31 S DQ=32 ;@703
32 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=32 D X32 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X32 S:DGDR'["703" Y="@704"
 Q
33 S DW=".36;1",DV="*P8'Xa",DU="",DLB="PRIMARY ELIGIBILITY CODE",DIFLD=.361
 S DE(DW)="C33^DGRPX77",DE(DW,"INDEX")=1
 S DU="DIC(8,"
 G RE
C33 G C33S:$D(DE(33))[0 K DB
 S X=DE(33),DIC=DIE
 ;
 S X=DE(33),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,2.2) I DIV(1)>0 S DIK(0)=DA,DIK="^DPT(DIV(0),""E"",",DA(1)=DIV(0),DA=DIV(1) D ^DIK S DA=DIK(0) K DIK
 S X=DE(33),DIC=DIE
 X "I $S('$D(^DIC(8,+X,0)):0,$P(^(0),""^"",1)[""DOM"":0,'$D(^DPT(DA,.36)):1,'$D(^DIC(8,+^(.36),0)):1,$P(^(0),""^"",1)'[""DOM"":1,1:0) S DGXRF=.361 D ^DGDDC Q"
 S X=DE(33),DIC=DIE
 K ^DPT("AEL",DA,+X)
 S X=DE(33),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 S X=DE(33),DIIX=2_U_DIFLD D AUDIT^DIET
C33S S X="" G:DG(DQ)=X C33F1 K DB
 S X=DG(DQ),DIC=DIE
 X "S DFN=DA D EN^DGMTR K DGREQF"
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 X ^DD(2,.361,1,2,89.4) S Y(102)=$S($D(^DPT(D0,"E",D1,0)):^(0),1:"") S X=$S('$D(^DIC(8,+$P(Y(102),U,1),0)):"",1:$P(^(0),U,1)) S D0=I(0,0) S D1=I(1,0) S DIU=X K Y S X=DIV S X=DIV,X=X X ^DD(2,.361,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 ;
 S X=DG(DQ),DIC=DIE
 S ^DPT("AEL",DA,+X)=""
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
 I $D(DE(33))'[0!(^DD(DP,DIFLD,"AUDIT")'="e") S X=DG(DQ),DIIX=3_U_DIFLD D AUDIT^DIET
C33F1 N X,X1,X2 S DIXR=815 D C33X1(U) K X2 M X2=X D C33X1("O") K X1 M X1=X
 D
 . D FC^DGFCPROT(.DA,2,.361,"KILL",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 K X M X=X2 D
 . D FC^DGFCPROT(.DA,2,.361,"SET",$H,$G(DUZ),.X,.X1,.X2,$G(XQY0)) Q
 G C33F2
C33X1(DION) K X
 S X(1)=$G(@DIEZTMP@("V",2,DIIENS,.361,DION),$P($G(^DPT(DA,.36)),U,1))
 S X=$G(X(1))
 Q
C33F2 Q
X33 S DFN=DA D EV^DGLOCK I $D(X) D ECD^DGLOCK1
 Q
 ;
34 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=34 D X34 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X34 D AAC1^DGLOCK2 S:DGAAC(1)']"" Y=361
 Q
35 D:$D(DG)>9 F^DIE17,DE S DQ=35,DW=".3;9",DV="*P35'X",DU="",DLB="AGENCY/ALLIED COUNTRY",DIFLD=.309
 S DU="DIC(35,"
 G RE
X35 S DFN=DA D AAC^DGLOCK2
 Q
 ;
36 S D=0 K DE(1) ;361
 S DIFLD=361,DGO="^DGRPX78",DC="3^2.0361IP^E^",DV="2.0361M*P8'X",DW="0;1",DOW="ELIGIBILITY",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="DIC(8,"
 G RE:D I $D(DSC(2.0361))#2,$P(DSC(2.0361),"I $D(^UTILITY(",1)="" X DSC(2.0361) S D=$O(^(0)) S:D="" D=-1 G M36
 S D=$S($D(^DPT(DA,"E",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M36 I D>0 S DC=DC_D I $D(^DPT(DA,"E",+D,0)) S DE(36)=$P(^(0),U,1)
 G RE
R36 D DE
 S D=$S($D(^DPT(DA,"E",0)):$P(^(0),U,3,4),1:1) G 36+1
 ;
37 S DW=".32;3",DV="*P21'Xa",DU="",DLB="PERIOD OF SERVICE",DIFLD=.323
 S DE(DW)="C37^DGRPX77"
 S DU="DIC(21,"
 G RE
C37 G C37S:$D(DE(37))[0 K DB
 S X=DE(37),DIC=DIE
 K ^DPT("APOS",$E(X,1,30),DA)
 S X=DE(37),DIC=DIE
 ;
 S X=DE(37),DIC=DIE
 I ($T(AVAFC^VAFCDD01)'="") S VAFCF=".323;" D AVAFC^VAFCDD01(DA)
 S X=DE(37),DIC=DIE
 D EVENT^IVMPLOG(DA)
 S X=DE(37),DIIX=2_U_DIFLD D AUDIT^DIET
C37S S X="" G:DG(DQ)=X C37F1 K DB
 D ^DGRPX79
C37F1 Q
X37 S DFN=DA D POS^DGLOCK1
 Q
 ;
38 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=38 D X38 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X38 D ^DGYZODS S:'DGODS Y="@704"
 Q
39 D:$D(DG)>9 F^DIE17,DE S DQ=39,DW="ODS;2",DV="S",DU="",DLB="RECALLED TO ACTIVE DUTY",DIFLD=11500.02
 S DE(DW)="C39^DGRPX77"
 S DU="0:NO;1:NATIONAL GUARD;2:RESERVES;"
 G RE
C39 G C39S:$D(DE(39))[0 K DB
 S X=DE(39),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
C39S S X="" G:DG(DQ)=X C39F1 K DB
 S X=DG(DQ),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
C39F1 Q
X39 Q
40 D:$D(DG)>9 F^DIE17,DE S DQ=40,DW="ODS;3",DV="*P25002.1'",DU="",DLB="RANK",DIFLD=11500.03
 S DE(DW)="C40^DGRPX77"
 S DU="DIC(25002.1,"
 G RE
C40 G C40S:$D(DE(40))[0 K DB
 S X=DE(40),DIC=DIE
 S A1B2TAG="PAT" D ^A1B2XFR
C40S S X="" G:DG(DQ)=X C40F1 K DB
 D ^DGRPX710
C40F1 Q
X40 S DIC("S")="I '$P(^(0),""^"",4),(""^e^c^""[(""^""_$P(^(0),""^"",2)_""^""))" D ^DIC K DIC S DIC=DIE,X=+Y K:Y<0 X
 Q
 ;
41 S DQ=42 ;@704
42 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=42 D X42 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X42 S:DGDR'["704" Y="@99"
 Q
43 D:$D(DG)>9 F^DIE17,DE S DQ=43,D=0 K DE(1) ;.3731
 S DIFLD=.3731,DGO="^DGRPX711",DC="2^2.05A^.373^",DV="2.05MFX",DW="0;1",DOW="SERVICE CONNECTED CONDITIONS",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 G RE:D I $D(DSC(2.05))#2,$P(DSC(2.05),"I $D(^UTILITY(",1)="" X DSC(2.05) S D=$O(^(0)) S:D="" D=-1 G M43
 S D=$S($D(^DPT(DA,.373,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M43 I D>0 S DC=DC_D I $D(^DPT(DA,.373,+D,0)) S DE(43)=$P(^(0),U,1)
 G RE
R43 D DE
 S D=$S($D(^DPT(DA,.373,0)):$P(^(0),U,3,4),1:1) G 43+1
 ;
44 S DQ=45 ;@99
45 G 0^DIE17
