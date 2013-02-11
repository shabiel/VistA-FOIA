SROATMNO ;BIR/MAM - TRANSMIT NO ASSESSMENT ;09/12/2011
 ;;3.0;Surgery;**27,38,47,62,68,79,83,81,88,93,95,97,129,125,142,153,160,166,174,175,176**;24 Jun 93;Build 8
 ;** NOTICE: This routine is part of an implementation of a nationally
 ;**         controlled procedure. Local modifications to this routine
 ;**         are prohibited.
 ;
 ; Reference to ^DIC(45.3 supported by DBIA #218
 ;
 N SR1L,SR10SP,SRINTUB,SR95PO,SRLO,SRPID,TDATE K ^TMP("SRA",$J) S SRATOT=0,SRASITE=+$P($$SITE^SROVAR,"^",3),(SRAMNUM,SRACNT)=1
 S Z=$E(DT,1,3)-2,SRLO=Z_"1215"
 S TDATE=0 F  S TDATE=$O(^SRF("AQ",TDATE)) Q:TDATE=""  I DT'<TDATE S SRTN=0 F  S SRTN=$O(^SRF("AQ",TDATE,SRTN)) Q:'SRTN  D SET
 S SRATOTM=SRAMNUM,SR1L=1 D ^SROATM4
 Q
SET I $P($G(^SRF(SRTN,.4)),"^",2)="T"!(TDATE<SRLO) K ^SRF("AQ",TDATE,SRTN) Q
 I $P($G(^SRF(SRTN,"NON")),"^")="Y" K ^SRF("AQ",TDATE,SRTN) S $P(^SRF(SRTN,.4),"^",2)="" Q
 I $P($G(^SRF(SRTN,"RA")),"^",6)="Y",$P($G(^SRF(SRTN,"RA")),"^",2)="N" K ^SRF("AQ",TDATE,SRTN) Q
 I $P($G(^SRF(SRTN,0)),"^",9)="" K ^SRF("AQ",TDATE,SRTN) Q
 S SR10SP="          " K DA,DIE,DR S DA=SRTN,DIE=130,DR="905///R" D ^DIE K DR,DA,DIE
 S SRA(0)=^SRF(SRTN,0),DATE=$E($P(SRA(0),"^",9),1,7),SPEC=$P(SRA(0),"^",4) S:SPEC SPEC=$P(^DIC(45.3,$P(^SRO(137.45,SPEC,0),"^",2),0),"^")
 S EMERG=$P(SRA(0),"^",10),EMERG=$S(EMERG="EM":"Y",1:"N")
 K SRTECH,SRZ S SRT=0 F  S SRT=$O(^SRF(SRTN,6,SRT)) Q:'SRT  D ^SROPRIN Q:$D(SRZ)
 I $D(SRTECH) S SRINTUB=$P($G(^SRF(SRTN,6,SRT,8)),"^",2)
 I '$D(SRTECH) S (SRTECH,SRINTUB)=""
 S CPT=$P($G(^SRO(136,SRTN,0)),"^",2),SRPMOD="" I CPT S CPT=$P($$CPT^ICPTCOD(CPT),"^",2) D
 .S SRM=0,SRCNT=1 F  S SRM=$O(^SRO(136,SRTN,1,SRM)) Q:'SRM  D  Q:SRCNT>5
 ..S X=$P(^SRO(136,SRTN,1,SRM,0),"^") I X S Y=$P($$MOD^ICPTMOD(X,"I"),"^",2),SRPMOD=SRPMOD_Y,SRCNT=SRCNT+1
 S DFN=$P(SRA(0),"^") N I D DEM^VADPT S SRDOB=$E($P(VADM(3),"^"),1,7),SRDEATH=$P(VADM(6),U),SRSEX=$P(VADM(5),"^")
 S SRPID=VA("PID"),SRPID=$TR(SRPID,"-","") ; remove hyphens from PID
 S X=$$SITE^SROUTL0(SRTN),SRDIV=$S(X:$P(^SRO(133,X,0),"^"),1:""),SRDIV=$S(SRDIV:$$GET1^DIQ(4,SRDIV,99),1:SRASITE)
 D RS^SROATM2
 S SRMAJMIN=$E($P($G(^SRF(SRTN,0)),U,3),1)
 S SRDTHUR=$E($P($G(^SRF(SRTN,.4)),U,7),1)
 S SRSTATUS=$S($P($G(^SRF(SRTN,208)),"^",14):"I",1:$E($P($G(^SRF(SRTN,0)),U,12),1))
 I SRSTATUS'="I"&(SRSTATUS'="O") S VAIP("D")=$P(SRA(0),"^",9) D IN5^VADPT S SRSTATUS=$S(VAIP(13):"I",1:"O") K VAIP
 S SRAGE="" I $P(VADM(3),"^") S SRAGE=$E(DATE,1,3)-$E($P(VADM(3),"^"),1,3)-($E(DATE,4,7)<$E($P(VADM(3),"^"),4,7))
 S SRASA="",Y=$P($G(^SRF(SRTN,1.1)),"^",3) S:Y X=$P($G(^SRO(132.8,Y,0)),"^"),SRASA=$E(X,1,2)
 ; Admission wi 14 days following outpatient surgery due to an Occurrence
 S (SRADMIT,SRADMT)=0 I SRSTATUS="O" D ADM^SROQ0A S SRADMIT=$S(SRADMT=0:"0",1:"1")
 S EXC=$P($G(^SRF(SRTN,"RA")),"^",7),SRWOUND=$P($G(^SRF(SRTN,"1.0")),"^",8)
 D OCC
 S SRNODE="  X" S:$P($G(^SRF(SRTN,"RA")),U,6)="N" SRNODE="  *" S:$P($G(^SRF(SRTN,"RA")),U,2)="C" SRNODE="  C"
 S SRTEMP="/"_$J(SRASITE,3)_$J(SRTN,7)_SRNODE_$J(DATE,7)_$J(SRTECH,3)_$J(EMERG,1)_$J(SPEC,3)_$J(CPT,5)_$J(EXC,1)_$J(SRPID,20)_$J(SRDIV,6)_$J(SRSEX,1)
 S SRTEMP=SRTEMP_$J(SRMAJMIN,1)_$J($E(SRDEATH,1,7),7)_$J(SRDTHUR,1)_$J(SRSTATUS,1)_$J(SRAGE,3)_$J(SRASA,2)_$J(SRADMIT,1)_SRTMP
 K CPT,SRMOD F SRZ=1:1:10 S (CPT(SRZ),SRMOD(SRZ))=""
 S (OPS,CNT)=0 F  S OPS=$O(^SRO(136,SRTN,3,OPS)) Q:'OPS!(CNT=10)  S CNT=CNT+1,X=$P($G(^SRO(136,SRTN,3,OPS,0)),"^") I X S CPT(CNT)=$P($$CPT^ICPTCOD(X),"^",2) D MOD
 S SRCC=$P($G(^SRF(SRTN,"CON")),"^"),SRBLANK="          "
 I SRCC,$P($G(^SRF(SRCC,30)),"^")!($P($G(^SRF(SRCC,31)),"^",8)) S SRCC=""
 S SRTEMP=SRTEMP_$J(CPT(1),5)_$J(CPT(2),5)_$J(CPT(3),5)_$J(CPT(4),5)_$J(CPT(5),5)_$J(CPT(6),5)_$J(CPT(7),5)_$J(CPT(8),5)_$J(CPT(9),5)_$J(CPT(10),5)_$J(SRWOUND,2)_$J(SROCTYPE,1)_SRBLANK_$J(SRCC,10)_$J(SRDEATH,12)
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRTEMP,SRACNT=SRACNT+1
 S SRICD=$P($G(^SRO(136,SRTN,0)),"^",3) S:SRICD SRICD=$P(^ICD9(SRICD,0),"^")
 N SRCVA D CVA S SRA(.2)=$G(^SRF(SRTN,.2))
 S SRTEMP="/"_$J(SRASITE,3)_$J(SRTN,7)_"  B"_$J($E($P(SRA(.2),"^"),1,12),12)_$J($E($P(SRA(.2),"^",4),1,12),12)_$E(SRPMOD_SR10SP,1,10)
 F I=1:1:10 S SRTEMP=SRTEMP_$E(SRMOD(I)_SR10SP,1,10)
 S SRTEMP=SRTEMP_$J(SRINTUB,1)_SR95PO_$J(SRATT,2)_$J(SRDOB,7)_$J(SRICD,6)_$J(SROC(38),2)_$J(SROC(39),2)
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRTEMP_$J($P(SRA(.2),"^",10),12)_$J($P(SRA(.2),"^",12),12)_$J($P(SRA(.2),"^",2),12)_$J($P(SRA(.2),"^",3),12)_$J(SRCVA,1),SRACNT=SRACNT+1
 S SRA(.9)=$G(^SRF(SRTN,.9)),SRA("VER")=$G(^SRF(SRTN,"VER")),SRA(52)=$G(^SRF(SRTN,52))
 S SRTEMP="/"_$J(SRASITE,3)_$J(SRTN,7)_"  D"_$J($P(SRA(.9),"^"),12)_$J($P(SRA(.9),"^",2),12)_$J($P(SRA(.9),"^",3),12)_$J($P(SRA(.9),"^",4),12)_$J($P(SRA(.9),"^",5),12)_$J($P(SRA(.9),"^",6),12)
 S SRTEMP=SRTEMP_$J($P($G(^SRF(SRTN,30)),"^"),12)_$J($P($G(^SRF(SRTN,31)),"^",8),4)_$J($P($G(^SRF(SRTN,30)),"^",4),50)
 F I=7:1:18 S SRTEMP=SRTEMP_$J($P(SRA("VER"),"^",I),2)
 S SROR="",Y=$P(^SRF(SRTN,0),"^",2),C=$P(^DD(130,.02,0),"^",2) I Y'="" D Y^DIQ S SROR=Y
 S SRTEMP=SRTEMP_$J($E(SROR,1,30),30) F I=1:1:6 S SRTEMP=SRTEMP_$J($P(SRA(52),"^",I),2)
 S ^TMP("SRA",$J,SRAMNUM,SRACNT,0)=SRTEMP,SRACNT=SRACNT+1
 I SRACNT>100 S SRACNT=1,SRAMNUM=SRAMNUM+1
 S SRATOT=SRATOT+1
 S X=$E($P(^SRF(SRTN,0),"^",9),1,5)_"00",^TMP("SRWL",$J,X)=""
 K DATE,ANES,EMERG,EXC,SPEC,SRADMIT,SRADMT,SRATT,SRBLANK,SRCC,SRDIV,SRDOB,SRDTHUR,SRICD,SRIO,SRMAJMIN,SROCTYPE,SROR,SRSEX,SRTEMP,SRTMP,SRWOUND,SRZ,SR14,CPT
 Q
OCC ; total of each occurrence by category
 N SRIOFLAG,SRPOFLAG
 F SRK=1:1:39 S SROC(SRK)=""
 S (SRPO,SRIOFLAG)=0 F  S SRPO=$O(^SRF(SRTN,10,SRPO)) Q:'SRPO  S SRSUB=$P(^SRF(SRTN,10,SRPO,0),U,2) I SRSUB'="" D
 .S SROC(SRSUB)=SROC(SRSUB)+1,SRIOFLAG=1
 S (SRPO,SRPOFLAG)=0 F  S SRPO=$O(^SRF(SRTN,16,SRPO)) Q:'SRPO  S SRSUB=$P(^SRF(SRTN,16,SRPO,0),U,2) I SRSUB'="" D
 .S SROC(SRSUB)=SROC(SRSUB)+1,SRPOFLAG=1
 S (SROCTYPE,SRTMP)="" F SRK=1:1:10 S SRTMP=SRTMP_$J(SROC(SRK),2)
 S SRTMP=SRTMP_$J(SROC(37),2) F SRK=12:1:32 S SRTMP=SRTMP_$J(SROC(SRK),2)
 S SR95PO=$J(SROC(33),2)_$J(SROC(34),2)_$J(SROC(35),2)_$J(SROC(36),2)
 I SRIOFLAG=1,(SRPOFLAG=0) S SROCTYPE="I"
 I SRIOFLAG=0,(SRPOFLAG=1) S SROCTYPE="P"
 I SRIOFLAG=1,(SRPOFLAG=1) S SROCTYPE="B"
 I SRIOFLAG=0,(SRPOFLAG=0) S SROCTYPE=""
 Q
MOD N SRM S SRM=0,SRCNT=1 F  S SRM=$O(^SRO(136,SRTN,3,OPS,1,SRM)) Q:'SRM  D  Q:SRCNT>5
 .S X=$P(^SRO(136,SRTN,3,OPS,1,SRM,0),"^"),Y=$P($$MOD^ICPTMOD(X,"I"),"^",2)
 .I Y'="" S SRMOD(CNT)=SRMOD(CNT)_Y,SRCNT=SRCNT+1
 Q
CVA S X=$P($G(^SRF(SRTN,205)),"^",21),SRCVA=$S(X="Y":"Y",1:1) I SRCVA=1 Q
 N SROCC S SROCC=0 F  S SROCC=$O(^SRF(SRTN,16,SROCC)) Q:'SROCC  I $P(^SRF(SRTN,16,SROCC,0),"^",2)=12 S X=$P(^SRF(SRTN,16,SROCC,0),"^",8) S:X'="" SRCVA=X Q
 Q
