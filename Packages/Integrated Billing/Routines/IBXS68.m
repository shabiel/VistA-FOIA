IBXS68 ; ;02/21/12
 D DE G BEGIN
DE S DIE="^DGCR(399,",DIC=DIE,DP=399,DL=1,DIEL=0,DU="" K DG,DE,DB Q:$O(^DGCR(399,DA,""))=""
 I $D(^("U1")) S %Z=^("U1") S %=$P(%Z,U,2) S:%]"" DE(2)=% S %=$P(%Z,U,3) S:%]"" DE(4)=% S %=$P(%Z,U,10) S:%]"" DE(7)=%
 I $D(^("U2")) S %Z=^("U2") S %=$P(%Z,U,4) S:%]"" DE(12)=% S %=$P(%Z,U,5) S:%]"" DE(15)=% S %=$P(%Z,U,6) S:%]"" DE(18)=%
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
BEGIN S DNM="IBXS68",DQ=1
1 D:$D(DG)>9 F^DIE17,DE S DQ=1,D=0 K DE(1) ;42
 S DIFLD=42,DGO="^IBXS69",DC="16^399.042IPA^RC^",DV="399.042MR*P399.2'",DW="0;1",DOW="REVENUE CODE",DLB=$P($$EZBLD^DIALOG(8042,DOW),": ") S:D DC=DC_D
 S DU="DGCR(399.2,"
 G RE:D I $D(DSC(399.042))#2,$P(DSC(399.042),"I $D(^UTILITY(",1)="" X DSC(399.042) S D=$O(^(0)) S:D="" D=-1 G M1
 S D=$S($D(^DGCR(399,DA,"RC",0)):$P(^(0),U,3,4),$O(^(0))'="":$O(^(0)),1:-1)
M1 I D>0 S DC=DC_D I $D(^DGCR(399,DA,"RC",+D,0)) S DE(1)=$P(^(0),U,1)
 G RE
R1 D DE
 S D=$S($D(^DGCR(399,DA,"RC",0)):$P(^(0),U,3,4),1:1) G 1+1
 ;
2 S DW="U1;2",DV="NJ8,2",DU="",DLB="OFFSET AMOUNT",DIFLD=202
 S DE(DW)="C2^IBXS68"
 G RE
C2 G C2S:$D(DE(2))[0 K DB
 S X=DE(2),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2)="" I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X="" X ^DD(399,202,1,1,2.4)
C2S S X="" G:DG(DQ)=X C2F1 K DB
 S X=DG(DQ),DIC=DIE
 ;
C2F1 Q
X2 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999)!(X<0) X
 Q
 ;
3 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=3 D X3 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X3 S:'X Y="@657"
 Q
4 D:$D(DG)>9 F^DIE17,DE S DQ=4,DW="U1;3",DV="FX",DU="",DLB="OFFSET DESCRIPTION",DIFLD=203
 G RE
X4 K:$L(X)>24!($L(X)<3) X
 I $D(X),X'?.ANP K X
 Q
 ;
5 S DQ=6 ;@657
6 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=6 D X6 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X6 I $P(^DGCR(399,DA,"U1"),"^",11)']"" S Y="@66"
 Q
7 S DW="U1;10",DV="RNJ10,2",DU="",DLB="*FY 1 CHARGES",DIFLD=210
 G RE
X7 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>9999999)!(X<0) X
 Q
 ;
8 S DQ=9 ;@66
9 S DQ=10 ;@67
10 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=10 D X10 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X10 S:IBDR20'["67" Y="@68"
 Q
11 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=11 D X11 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X11 S:'$D(^DGCR(399,DA,"I1")) Y="@672"
 Q
12 S DW="U2;4",DV="NJ11,2",DU="",DLB="PRIMARY PRIOR PAYMENT",DIFLD=218
 S DE(DW)="C12^IBXS68"
 G RE
C12 G C12S:$D(DE(12))[0 K DB
 S X=DE(12),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,218,1,1,2.4)
 S X=DE(12),DIC=DIE
 ;
C12S S X="" G:DG(DQ)=X C12F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,218,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,218,1,2,1.4)
C12F1 Q
X12 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999999)!(X<0) X
 Q
 ;
13 S DQ=14 ;@672
14 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=14 D X14 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X14 S:'$D(^DGCR(399,DA,"I2")) Y="@673"
 Q
15 D:$D(DG)>9 F^DIE17,DE S DQ=15,DW="U2;5",DV="NJ11,2",DU="",DLB="SECONDARY PRIOR PAYMENT",DIFLD=219
 S DE(DW)="C15^IBXS68"
 G RE
C15 G C15S:$D(DE(15))[0 K DB
 S X=DE(15),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,219,1,1,2.4)
 S X=DE(15),DIC=DIE
 ;
C15S S X="" G:DG(DQ)=X C15F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,219,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,219,1,2,1.4)
C15F1 Q
X15 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999999)!(X<0) X
 Q
 ;
16 S DQ=17 ;@673
17 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=17 D X17 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X17 S:'$D(^DGCR(399,DA,"I3")) Y="@68"
 Q
18 D:$D(DG)>9 F^DIE17,DE S DQ=18,DW="U2;6",DV="NJ11,2",DU="",DLB="TERTIARY PRIOR PAYMENT",DIFLD=220
 S DE(DW)="C18^IBXS68"
 G RE
C18 G C18S:$D(DE(18))[0 K DB
 S X=DE(18),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU-X X ^DD(399,220,1,1,2.4)
 S X=DE(18),DIC=DIE
 ;
C18S S X="" G:DG(DQ)=X C18F1 K DB
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X=DIV S X=DIU+DIV X ^DD(399,220,1,1,1.4)
 S X=DG(DQ),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"U1")):^("U1"),1:"") S X=$P(Y(1),U,3),X=X S DIU=X K Y S X=DIV S X="PRIOR PAYMENT(S)" X ^DD(399,220,1,2,1.4)
C18F1 Q
X18 S:X["$" X=$P(X,"$",2) K:X'?.N.1".".2N!(X>99999999)!(X<0) X
 Q
 ;
19 S DQ=20 ;@68
20 D:$D(DG)>9 F^DIE17,DE S Y=U,DQ=20 D X20 D:$D(DIEFIRE)#2 FIREREC^DIE17 G A:$D(Y)[0,A:Y=U S X=Y,DIC(0)="F",DW=DQ G OUT^DIE17
X20 K DIE("NO^")
 Q
21 G 0^DIE17
