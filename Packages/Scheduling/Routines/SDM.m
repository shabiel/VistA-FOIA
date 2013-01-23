SDM ;SF/GFT,ALB/BOK - MAKE AN APPOINTMENT ; 1/23/2013
 ;;5.3;Scheduling;**15,32,38,41,44,79,94,167,168,218,223,250,254,296,380,478,441,260003**;AUG 13, 1993;Build 14
 ;                                           If defined...
 ; appt mgt vars:  SDFN := DFN of patient....will not be asked
 ;                SDCLN := ifn of clinic.....will not be asked    
 ;              SDAMERR := returned if error occurs
 ; 
 S:'$D(SDMM) SDMM=0
EN1 ;
 N ERR,PAT,CLN,PAR,DFN
 L  W !! D I^SDUTL
 N Y S Y=$G(SDCLN)
 S PAR("FLAG")="AQZME"
 S PAR("PRMPT")=$$EZBLD^DIALOG(480000.031)
 I '$D(SDCLN) S Y=$$SELCLN^SDMUI(.PAR)
 S:+Y>0!($D(SDCLN)) %=$$GETCLN^SDMAPI1(.CLN,+Y) G:+Y<0!'$D(CLN("LENGTH OF APP'T")) END
 N SDRES S:$D(SDCLN) Y=+SDCLN S SDRES=$$CLNCK^SDMAPI1(.ERR,+Y)
 I 'SDRES W !,?5,$P(ERR(0),U,2),!,?5,$$EZBLD^DIALOG(480000.002) G END:$D(SDCLN),SDM
 K SDAPTYP,SDIN,SDRE,SDXXX S:$D(SDCLN) Y=+SDCLN
 S TMPYCLNC=Y,STPCOD=$P(CLN("STOP CODE NUMBER"),U,1) ;SD/478
 I $D(CLN("INACTIVATE DATE")) S SDIN=CLN("INACTIVATE DATE"),SDRE=CLN("REACTIVATE DATE")
 K SDINA I $D(SDIN),SDIN S SDINA=SDIN K SDIN
 I $D(SD),$D(SC),+Y'=+SC K SD
 S X=CLN("HOUR CLINIC DISPLAY BEGINS"),STARTDAY=$S($L(X):X,1:8)
 S SL=CLN("LENGTH OF APP'T")
 S SC=Y,SB=STARTDAY-1/100
 S X=CLN("DISPLAY INCREMENTS PER HOUR"),HSI=$S(X=1:X,X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4)
 S STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2) K Y
 K ERR S %=$$CLNRGHT^SDMAPI1(.ERR,+SC) I ERR=0 W !,*7,$P(ERR(0),U,2) S:$D(SDCLN) SDAMERR="" G END:$D(SDCLN),SDM
 D CS^SDM1A S SDW="",WY="Y"
 K PAR("PRMPT")
 I '$D(ORACTION),'$D(SDFN) S Y=$$SELPAT^SDMUI(.PAR) S:+Y=0 X="" S DFN=+Y G:+Y<0 END:$D(SDCLN),^SDM0:X[U,SDM
 S:$D(SDFN) DFN=SDFN
 S %=$$GETPAT^SDMAPI3(.PAT,DFN,1)
 I $D(PAT("DATE OF DEATH")),PAT("DATE OF DEATH")]"" W !?10,*7,$$EZBLD^DIALOG(480000.1) S:$D(SDFN) SDAMERR="" G END:$D(SDFN),SDM
 D ^SDM4 I $S('$D(COLLAT):1,COLLAT=7:1,1:0) G:$D(SDCLN) END G SDM
 ;-- get sub-category for appointment type
 S SDXSCAT=$$SUB^DGSAUTL(SDAPTYP,2,"")
 K SDXXX D EN G END:$D(SDCLN),SDM
EN K SDMLT1 W:$P(VAEL(9),U,2)]"" !!,?15,"MEANS TEST STATUS: ",$P(VAEL(9),U,2),!
 ; *** sck, mt blocking removed
 ;S X="EASMTCHK" X ^%ZOSF("TEST") I $T,$$MT^EASMTCHK(DFN,+$G(SDAPTYP),"M") S SDAMERR="" Q
 I $G(PAT("REMARKS"))]"" W !?3,*7,$P(PAT("REMARKS"),U,2)
 N SADM,SADMDT S SADMDT(0)=DT
 S %=$$LSTSADM^SDMEXT(.SADM,DFN,.SADMDT,0)
 I +$G(SADM(0))>0 S Y=$P($G(SADM(1,"DATE")),U,1),TXT(1)=$$FMTE^XLFDT(Y) W !,$$EZBLD^DIALOG(480000.003,.TXT)
PEND S %=""
 N PEND,LXE
 S %=$$GETPEND^SDMAPI1(.PEND,DFN) W:'$O(PEND(0)) !,$$EZBLD^DIALOG(480000.001)
 I $O(PEND(0)) D  G END:%<0,HELP:'%
 .S %=1 W !,$$EZBLD^DIALOG(480000.004)
 .D YN^DICN
 .I %Y["^" S SDMLT1=1
 D:%=1
 .N DX,DY,SDXY,SDEND S SDXY="S DX=$X,DY=0"_$S($L($G(^%ZOSF("XY"))):" "_^("XY"),1:"") X SDXY
 .S CN=1
 . F XIN=DT:0 S XIN=$O(PEND(XIN)) Q:XIN'>0  D
 . . S LXE=PEND(XIN,"LAB")_U_PEND(XIN,"XRAY")_U_PEND(XIN,"EKG")
 . . X:(($Y+4)>IOSL) "D OUT^SDUTL X SDXY"
 . . F SDJ=1,2,3 D
 . . . I $P(LXE,U,SDJ)]"" S Y=$P(LXE,U,SDJ) W:$X>9 ! W ?10,"*" D DT^SDM0 W ?32,$S(SDJ=1:"LAB",SDJ=2:"XRAY",3:"EKG")
 . . W:$X>9 ! W CN,".",?4,$$FMTE^XLFDT(XIN) W ?23
 . . W "("_PEND(XIN,"LENGTH OF APP'T")_" MIN) "
 . . W $S($D(PEND(XIN,"CLINIC")):PEND(XIN,"CLINIC"),1:"DELETED CLINIC ")
 . . W PEND(XIN,"COLLATERAL VISIT"),"  ",PEND(XIN,"APPOINTMENT TYPE")
 . . W:$G(PEND(XIN,"CONSULT LINK"))>0 " Consult Appt."
 . . S CN=CN+1
 ;Prompt for ETHNICITY if no value on file
 I '$O(PAT("ETHNICITY INFORMATION","")) D
 .S DA=DFN,DR="6ETHNICITY",DIE="^DPT("
 .S DR(2,2.06)=".01ETHNICITY"
 .D ^DIE K DR
 ;Prompt for RACE if no value on file
 I '$O(PAT("RACE INFORMATION","")) D
 .S DA=DFN,DR="2RACE",DIE="^DPT("
 .S DR(2,2.02)=".01RACE"
 .D ^DIE K DR
 I $S('$D(PAT("STREET ADDRESS [LINE 1]")):1,PAT("STREET ADDRESS [LINE 1]")="":1,1:0) N FLG S FLG(1)=1 D EN^DGREGAED(DFN,.FLG)
 Q:$D(SDXXX)
E S Y=CLN("PRINCIPAL CLINIC")
 S SDW="" I $L(PAT("WARD LOCATION"))>0 S SDW=$P(PAT("WARD LOCATION"),U,2) W !,"NOTE - PATIENT IS NOW IN WARD "_SDW
 Q:$D(SDXXX)
EN2 F X=0:0 S X=$O(^DPT(DFN,"DE",X)) Q:'$D(^(+X,0))  I ^(0)-SC=0!'(^(0)-Y) F XX=0:0 S XX=$O(^DPT(DFN,"DE",X,1,XX)) Q:XX<1  S SDDIS=$P(^(XX,0),U,3) I 'SDDIS D:'$D(SDMULT) A^SDCNSLT G ^SDM0
 I '$D(^SC(+Y,0)) S Y=+SC
 S Y=$P(^SC(+Y,0),U)
 ; SCRESTA = Array of pt's teams causing restricted consults
 N SCRESTA
 S SCREST=$$RESTPT^SCAPMCU4(DFN,DT,"SCRESTA")
 IF SCREST D
 .N SCTM
 . S SCCLNM=Y
 . W !,?5,"Patient has restricted consults due to team assignment(s):"
 .S SCTM=0
 .F  S SCTM=$O(SCRESTA(SCTM)) Q:'SCTM  W !,?10,SCRESTA(SCTM)
 IF SCREST&'$G(SCOKCONS) D  Q
 .W !,?5,"This patient may only be given appointments and enrolled in clinics via"
 .W !,?15,"Make Consult Appointment Option, and"
 .W !,?15,"Edit Clinic Enrollment Data option"
 D:$G(SCREST) MAIL^SCMCCON(DFN,.SCCLNM,2,DT,"SCRESTA")
 K DR,SCREST,SCCLNM
 D:'$D(SDMULT) ^SDCNSLT ;SD/478
 G ^SDM0
 ;
END D KVAR^VADPT K SDAPTYP,SDSC,%,%DT,ASKC,COV,DA,DIC,DIE,DP,DR,HEY,HSI,HY,J,SB,SC,SDDIF,SDJ,SDLN,SD17,SDMAX,SDU,SDYC,SI,SL,SSC,STARTDAY,STR
 K WY,X,XX,Y,S,SD,SDAP16,SDEDT,SDTY,SM,SS,ST,ARG,CCX,CCXN,HX,I,PXR,SDINA,SDW,COLLAT,SDDIS I $D(SDMM) K:'SDMM SDMM
 K A,CC,CLNIEN,CN,CNIEN,CNPAT,CNSLTLNK,CNSULT,CNT,CONS,CPRSTAT,CW,DSH,DTENTR,DTIN,DTLMT,DTR,ND,P8,PROC,PT,PTIEN,PTNM,RTMP,NOSHOW,SCPTTM,SD1,SDAMSCN,SDATE,SDDOT,SDII,SDINC,SDINCM,SDLEN,SDNS,SDSI,SDST,SDSTR,SDSTRTDT
 K SDXSCAT,SENDER,SERVICE,SRV,STATUS,STPCOD,TMP,TMPYCLNC,TYPE
 I '$D(SDMLT) K SDMLT1
 Q
 ;
OERR S XQORQUIT=1 Q:'$D(ORVP)  S DFN=+ORVP G SDM
 ;
HELP ;
 N HLP
 D BLD^DIALOG(480000.005,,,"HLP","FS")
 D MSG^DIALOG("WH",,,,"HLP")
 G PEND
 ;
CNAM(SDCL) ;Return clinic name
 ;Input: SDCL=clinic ien
 N SDX
 S SDX=CLN("NAME")
 Q $S($L(SDX):SDX,1:"this clinic")
