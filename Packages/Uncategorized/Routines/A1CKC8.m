A1CKC8 ; ;06/29/12
 D DE G BEGIN
DE S DIE="^DPT(",DIC=DIE,DP=2,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DPT(DA,""))=""
 I $D(^(.3)) S %Z=^(.3) S %=$P(%Z,U,11) S:%]"" DE(6)=%
 I $D(^(.362)) S %Z=^(.362) S %=$P(%Z,U,12) S:%]"" DE(12)=% S %=$P(%Z,U,13) S:%]"" DE(15)=% S %=$P(%Z,U,14) S:%]"" DE(9)=%
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
BEGIN S DNM="A1CKC8",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,D=0 K DE(1) ;.3721
 S DIFLD=.3721,DGO="^A1CKC9",DC="6^2.04P^.372^",DV="2.04MP31'X",DW="0;1",DOW="RATED DISABILITIES (VA)",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="DIC(31,"
 G RE:D I $D(DSC(2.04))#2,$P(DSC(2.04),"I $D(^UTILITY(",1)="" X DSC(2.04) S D=$O(^(0)) S:D="" D=-1 G M1
 S D=$S($D(^DPT(DA,.372,0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M1 I D>0 S DC=DC_D I $D(^DPT(DA,.372,+D,0)) S DE(1)=$P(^(0),U,1)
 S X="`"_ISC
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
R1 D DE
 G A
 ;
2 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=2 D X2 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X2 S Y="@31"
 Q
3 S DQ=4 ;@39
4 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=4 D X4 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X4 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
5 S DQ=6 ;@100
6 S DW=".3;11",DV="SX",DU="",DLB="RECEIVING VA DISABILITY?",DIFLD=.3025
 S DE(DW)="C6^A1CKC8"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=CP
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C6 G C6S:$D(DE(6))[0 K DB
 S X=DE(6),DIC=DIE
 X ^DD(2,.3025,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,2.4)
 S X=DE(6),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,2,2.4)
 S X=DE(6),DIC=DIE
 D EVENT^IVMPLOG(DA)
C6S S X="" G:DG(DQ)=X C6F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.3025,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.3)):^(.3),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.3025,1,2,1.4)
 S X=DG(DQ),DIC=DIE
 D EVENT^IVMPLOG(DA)
C6F1 Q
X6 S DFN=DA D MV^DGLOCK I $D(X),X="Y" D EC^DGLOCK1
 Q
 ;
7 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=7 D X7 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X7 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
8 S DQ=9 ;@200
9 D:$D(DG)>9 F^DIE17,DE S DQ=9,DW=".362;14",DV="SX",DU="",DLB="RECEIVING A VA PENSION?",DIFLD=.36235
 S DE(DW)="C9^A1CKC8"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=PE
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C9 G C9S:$D(DE(9))[0 K DB
 S X=DE(9),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(9),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,3,2.4)
 S X=DE(9),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C9S S X="" G:DG(DQ)=X C9F1 K DB
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36235,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C9F1 Q
X9 S DFN=DA D MV^DGLOCK
 Q
 ;
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
11 S DQ=12 ;@300
12 D:$D(DG)>9 F^DIE17,DE S DQ=12,DW=".362;12",DV="SX",DU="",DLB="RECEIVING A&A BENEFITS?",DIFLD=.36205
 S DE(DW)="C12^A1CKC8"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=AA
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 X ^DD(2,.36205,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,2.4)
 S X=DE(12),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(12),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,3,2.4)
 S X=DE(12),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.36205,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,1),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36205,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C12F1 Q
X12 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
13 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=13 D X13 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X13 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
14 S DQ=15 ;@400
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW=".362;13",DV="SX",DU="",DLB="RECEIVING HOUSEBOUND BENEFITS?",DIFLD=.36215
 S DE(DW)="C15^A1CKC8"
 S DU="Y:YES;N:NO;U:UNKNOWN;"
 S X=HB
 S Y=X
 S X=Y,DB(DQ)=1 G:X="" N^DIE17:DV,A I $D(DE(DQ)),DV["I"!(DV["#") D E^DIE0 G A:'$D(X)
 G RD
C15 G C15S:$D(DE(15))[0 K DB
 S X=DE(15),DIC=DIE
 X ^DD(2,.36215,1,1,2.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,1,2.4)
 S X=DE(15),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DE(15),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,3,2.4)
 S X=DE(15),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C15S S X="" G:DG(DQ)=X C15F1 K DB
 S X=DG(DQ),DIC=DIE
 X ^DD(2,.36215,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 S DFN=DA D EN^DGMTCOR K DGMTCOR
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X='$$TOTCHK^DGLOCK2(DA) I X S X=DIV S Y(1)=$S($D(^DPT(D0,.362)):^(.362),1:"") S X=$P(Y(1),U,20),X=X S DIU=X K Y S X="" X ^DD(2,.36215,1,3,1.4)
 S X=DG(DQ),DIC=DIE
 D AUTOUPD^DGENA2(DA)
C15F1 Q
X15 S DFN=DA D MV^DGLOCK I $D(X) S DFN=DA D EV^DGLOCK
 Q
 ;
16 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=16 D X16 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X16 S Y=$P(STR,"^"),STR=$P(STR,"^",2,99)
 Q
17 S DQ=18 ;@999
18 G 0^DIE17
