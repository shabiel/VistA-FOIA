PSJXR514 ; COMPILED XREF FOR FILE #55.06 ; 10/28/97
 ; 
 S DA=0
A1 ;
 I $D(DISET) K DIKLM S:$D(DA(1)) DIKLM=1 G:$D(DA(1)) 1 S DA(1)=DA,DA=0 G @DIKM1
0 ;
A S DA=$O(^PS(55,DA(1),5,DA)) I DA'>0 S DA=0 G END
1 ;
 S DIKZ(0)=$G(^PS(55,DA(1),5,DA,0))
 S X=$P(DIKZ(0),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(1))#2 KILL^PSGAL5:PSGAL(1)=X K PSGAL
 S X=$P(DIKZ(0),U,1)
 I X'="" S ^PS(55,DA(1),5,"B",$E(X,1,30),DA)=""
 S X=$P(DIKZ(0),U,1)
 I X'="" I '$D(DIU(0)) S ^PS(55,"AUE",DA(1),DA)=""
 S X=$P(DIKZ(0),U,18)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(55)) KILL^PSGAL5:PSGAL(55)=X K PSGAL
 S X=$P(DIKZ(0),U,15)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(2))#2 KILL^PSGAL5:PSGAL(2)=X K PSGAL
 S X=$P(DIKZ(0),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(3))#2 KILL^PSGAL5:PSGAL(3)=X K PSGAL
 S X=$P(DIKZ(0),U,2)
 I X'="" I $S('$D(^PS(55,DA(1),5.1)):1,1:$P(^(5.1),"^",2)'=X) S $P(^(5.1),"^",2)=X
 S X=$P(DIKZ(0),U,3)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(4))#2 KILL^PSGAL5:PSGAL(4)=X K PSGAL
 S X=$P(DIKZ(0),U,4)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(5))#2 KILL^PSGAL5:PSGAL(5)=X K PSGAL
 S X=$P(DIKZ(0),U,5)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(6))#2 KILL^PSGAL5:PSGAL(6)=X K PSGAL
 S X=$P(DIKZ(0),U,5)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I 'X S DIU=$S($D(^PS(55,DA(1),5,DA,0)):$P(^(0),"^",6),1:"") I DIU S $P(^(0),"^",6)="" I $O(^DD(55.06,6,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV="",DIH=55.06,DIG=6 D ^DICR
 S X=$P(DIKZ(0),U,6)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(7))#2 KILL^PSGAL5:PSGAL(7)=X K PSGAL
 S X=$P(DIKZ(0),U,7)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(8))#2 KILL^PSGAL5:PSGAL(8)=X K PSGAL
 S X=$P(DIKZ(0),U,7)
 I X'="" I $D(^PS(55,DA(1),5,DA,2)),$P(^(2),"^",4) S ^PS(55,DA(1),5,"AU",X,+$P(^(2),"^",4),DA)=""
 S DIKZ(6)=$G(^PS(55,DA(1),5,DA,6))
 S X=$P(DIKZ(6),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(9))#2 KILL^PSGAL5:PSGAL(9)=X K PSGAL
 S DIKZ(2)=$G(^PS(55,DA(1),5,DA,2))
 S X=$P(DIKZ(2),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(41))#2 KILL^PSGAL5:PSGAL(41)=X K PSGAL
 S X=$P(DIKZ(0),U,10)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(11))#2 KILL^PSGAL5:PSGAL(11)=X K PSGAL
 S X=$P(DIKZ(0),U,11)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(12))#2 KILL^PSGAL5:PSGAL(12)=X K PSGAL
 S X=$P(DIKZ(0),U,12)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(13))#2 KILL^PSGAL5:PSGAL(13)=X K PSGAL
 S DIKZ(5)=$G(^PS(55,DA(1),5,DA,5))
 S X=$P(DIKZ(5),U,6)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(14))#2 KILL^PSGAL5:PSGAL(14)=X K PSGAL
 S X=$P(DIKZ(5),U,6)
 I X'="" ; I X S PSGAMSF=0 D ^PSGAMSA
 S X=$P(DIKZ(5),U,6)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I X S DIU=$S($D(^PS(55,DA(1),5,DA,5)):$P(^(5),"^",9),1:0) S $P(^(5),"^",9)=DIU+X I $O(^DD(55.06,63,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV=DIU+X,DIH=55.06,DIG=63 D ^DICR
 S DIKZ(4)=$G(^PS(55,DA(1),5,DA,4))
 S X=$P(DIKZ(4),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(15))#2 KILL^PSGAL5:PSGAL(15)=X K PSGAL
 S X=$P(DIKZ(4),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(16))#2 KILL^PSGAL5:PSGAL(16)=X K PSGAL
 S X=$P(DIKZ(4),U,3)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(17))#2 KILL^PSGAL5:PSGAL(17)=X K PSGAL
 S X=$P(DIKZ(4),U,4)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(18))#2 KILL^PSGAL5:PSGAL(18)=X K PSGAL
 S X=$P(DIKZ(4),U,5)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(19))#2 KILL^PSGAL5:PSGAL(19)=X K PSGAL
 S X=$P(DIKZ(4),U,6)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(20))#2 KILL^PSGAL5:PSGAL(20)=X K PSGAL
 S X=$P(DIKZ(4),U,7)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(21))#2 KILL^PSGAL5:PSGAL(21)=X K PSGAL
 S X=$P(DIKZ(4),U,8)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(22))#2 KILL^PSGAL5:PSGAL(22)=X K PSGAL
 S X=$P(DIKZ(0),U,17)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(23))#2 KILL^PSGAL5:PSGAL(23)=X K PSGAL
 S X=$P(DIKZ(2),U,3)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(24))#2 KILL^PSGAL5:PSGAL(24)=X K PSGAL
 S X=$P(DIKZ(2),U,1)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(43))#2 KILL^PSGAL5:PSGAL(43)=X K PSGAL
 S X=$P(DIKZ(2),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I '$D(DIU(0)),$D(PSGS0Y) S DIU=$S($D(^PS(55,DA(1),5,DA,2)):$P(^(2),"^",5),1:"") I DIU'=PSGS0Y S $P(^(2),"^",5)=PSGS0Y I $O(^DD(55.06,41,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV=PSGS0Y,DIH=55.06,DIG=41 D ^DICR
 S X=$P(DIKZ(2),U,1)
 I X'="" D
 .N DIK,DIV,DIU,DIN
 .I $D(PSGS0XT) S DIU=$S($D(^PS(55,DA(1),5,DA,2)):$P(^(2),"^",6),1:"") I DIU'=PSGS0XT S $P(^(2),"^",6)=PSGS0XT I $O(^DD(55.06,42,1,0)) K DIV S (DIV(0),D0)=DA(1),(DIV(1),D1)=DA,DIV=PSGS0XT,DIH=55.06,DIG=42 D ^DICR
 S X=$P(DIKZ(0),U,14)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(26))#2 KILL^PSGAL5:PSGAL(26)=X K PSGAL
 S X=$P(DIKZ(0),U,16)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(27))#2 KILL^PSGAL5:PSGAL(27)=X K PSGAL
 S X=$P(DIKZ(0),U,9)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(28))#2 KILL^PSGAL5:PSGAL(28)=X K PSGAL
 S X=$P(DIKZ(0),U,9)
 ;I X'="" I $P($G(^PS(55,DA(1),5,DA,0)),"^",21) S ORIFN=$P(^(0),"^",21),XX=X,X="ORX" X ^%ZOSF("TEST") I  S X=XX D ENSC^PSGORU K ORIFN,XX
 I X'="" I $P($G(^PS(55,DA(1),5,DA,0)),"^",21) S ORIFN=$P(^(0),"^",21),XX=X,X="ORX" X ^%ZOSF("TEST") I  S X=XX K ORIFN,XX
 S X=$P(DIKZ(5),U,2)
 I X'="" I '$D(DIU(0)) D:$D(PSGAL(51))#2 KILL^PSGAL5:PSGAL(51)=X K PSGAL
 S X=$P(DIKZ(2),U,4)
 G ^PSJXR515
END G END^PSJXR515
