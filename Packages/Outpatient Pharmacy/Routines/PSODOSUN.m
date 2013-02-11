PSODOSUN ;BIR/RTR - Dose Check Utility routine ;11/18/08
 ;;7.0;OUTPATIENT PHARMACY;**251,379**;DEC 1997;Build 28
DOSE() ;Write Dose output for renew, finish, copy, etc.
 N PSODLINS,PSODLINR,PSODLERA,PSODLERB,PSODLERF,PSODLERZ,PSODLPL,PSODLP1,PSODLMSG,PSODLFLG,PSODLALZ,DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,X1,PSODLNN1,PSODLERR,PSODLERX,PSODLQT,PSOCPXG,PSOCPXRR,PSODLEXR,PSODELNX,PSODLECT
 S (PSODLERF,PSODLERZ,PSODLALZ,PSODLINS,PSODLINR,PSODLERR,PSODLQT,PSOCPXG)=0
 W @IOF I $P($G(^TMP($J,"PSOPDOSN","OUT",0)),"^")=-1 D  S PSODLFLG=0,PSODLERR=1 G END
 .D HD N X,DIWL,DIWR,DIWF,PSODELXR,PSODELXF D MESG
 .S X="Reason: "_$P(^TMP($J,"PSOPDOSN","OUT",0),"^",2),DIWL=1,DIWR=76 K ^UTILITY($J,"W") D ^DIWP
 .S PSODELXF=0 F PSODELXR=0:0 S PSODELXR=$O(^UTILITY($J,"W",DIWL,PSODELXR)) Q:'PSODELXR  D HD W:PSODELXF&('PSODLQT) ! D HD W:'PSODLQT "   "_$G(^UTILITY($J,"W",DIWL,PSODELXR,0)) S PSODELXF=1
 .K ^UTILITY($J,"W")
 ;PSOCPXB = Number of Dosing Seq
 S PSODLQT=0 K PSOCPXRR
 D DOSE^PSODOSU2
END ;
 I $G(PSORX("DFLG")) Q 0
 I 'PSODLALZ,'$G(PSODLFLG),'PSODLERR Q 0
 I 'PSODLFLG W !
 K PSODAILY,DIR,Y,PSODOSEX
 I $D(^XUSEC("PSORPH",DUZ)) D   I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODOSEX=1 S:$G(PSOREINS) PSOQUIT=1 Q 1
 .S DIR("B")="Y",DIR(0)="Y",DIR("A")="Do you want to Continue" D ^DIR K DIR
 ;K PSODAILY,DIR,Y S DIR("B")="Y",DIR(0)="Y",DIR("A")="Do you want to Continue" D ^DIR K DIR
 ;I Y'=1!($D(DTOUT))!($D(DUOUT)) Q 1
 I '$G(PSODLINS)&'$G(PSODLINR) Q 0
 I '$D(^XUSEC("PSORPH",DUZ)) Q 2_"^"_$$EVAL(PSODLINS,PSODLINR)
 W !!,"Do you want to Process medication",! K DIR,Y S DIR("B")="P",DIR(0)="SA^1:PROCESS MEDICATION;0:CANCEL MEDICATION"
 S DIR("A")=$$GETGN^PSODOSUN(PSODRUG("IEN"))_": "  K ^TMP($J,"PSODOSUN GN")
 ;S DIR("A")=$P($G(^PSDRUG(PSODRUG("IEN"),0)),"^")_": "
 S DIR("?",1)="Enter '1' or 'P' to Process Medication",DIR("?",2)="enter '0' or 'C' to Cancel Medication"
 D ^DIR K DIR
 I Y=0 Q 3_"^"_$S($G(PSODLINS)&($G(PSODLINR)):"MAX SINGLE DOSE & DAILY DOSE RANGE",$G(PSODLINS):"MAX SINGLE DOSE",$G(PSODLINR):"DAILY DOSE RANGE",1:"UNKNOWN")  ;need to know if user cancelled or not
 K PSODOSEX I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODOSEX=1 Q 1
 D SIG^XUSESIG I $G(X1)="" Q 1
END2 ;
 Q 2_"^"_$S($G(PSODLINS)&($G(PSODLINR)):"MAX SINGLE DOSE & DAILY DOSE RANGE",$G(PSODLINS):"MAX SINGLE DOSE",$G(PSODLINR):"DAILY DOSE RANGE",1:"UNKNOWN")
 ;
EVAL(PSODLINS,PSODLINR) ;
 Q $S($G(PSODLINS)&($G(PSODLINR)):"MAX SINGLE DOSE & DAILY DOSE RANGE",$G(PSODLINS):"MAX SINGLE DOSE",$G(PSODLINR):"DAILY DOSE RANGE",1:"UNKNOWN")
 ;
DOSEX(PSODLXNT) ;Write Dose exceptions for order entry/edit
 N PSODLINS,PSODLINR,PSODLERA,PSODLERB,PSODLERF,PSODLERZ,PSODLPL,PSODLP1,PSODLMSG,PSODLFLG,PSODLALZ,DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,X1,PSODLNN1,PSODLERR,PSODLERX,PSODLQT,PSODELNX
 W @IOF S (PSODLERF,PSODLERZ,PSODLALZ,PSODLINS,PSODLINR,PSODLERR,PSODLQT)=0
 I $P($G(^TMP($J,"PSOPDOSN","OUT",0)),"^")=-1 D  S PSODLFLG=0,PSODLERR=1 G ENDX
 .D HD N X,DIWL,DIWR,DIWF,PSODELXR,PSODELXF D MESG
 .S X="Reason: "_$P(^TMP($J,"PSOPDOSN","OUT",0),"^",2),DIWL=1,DIWR=76 K ^UTILITY($J,"W") D ^DIWP
 .S PSODELXF=0 F PSODELXR=0:0 S PSODELXR=$O(^UTILITY($J,"W",DIWL,PSODELXR)) Q:'PSODELXR  D HD W:PSODELXF&('PSODLQT) ! D HD W:'PSODLQT "   "_$G(^UTILITY($J,"W",DIWL,PSODELXR,0)) S PSODELXF=1
 .K ^UTILITY($J,"W")
 D DOSEX^PSODOSU2
ENDX ;
 I $G(PSORX("DFLG")) Q 0
 K PSOCPXRR
 I 'PSODLALZ,'$G(PSODLFLG),'PSODLERR Q 0
 I 'PSODLFLG W !
 I '$D(^XUSEC("PSORPH",DUZ)),$G(PSODLINS)!($G(PSODLINR))  Q 2_"^"_$$EVAL(PSODLINS,PSODLINR)
 Q:$G(PSOCPXV) 0
 I $G(PSODLBD4)&'$G(PSODLINS)&'$G(PSODLINR) S Y=1 G ENDX2
 K DIR,Y I $D(^XUSEC("PSORPH",DUZ)) S DIR("B")="Y",DIR(0)="Y",DIR("A")="Do you want to Continue" D ^DIR K DIR
ENDX2 ;
 K PSODOSEX I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODOSEX=1 S:$G(PSOREINS) PSOQUIT=1 Q 1
 W !
 Q 0
DOSEZ() ;Write Dose output summary for complex orders
 N PSOCPXF,PSOCPXC,PSOCPXRR,PSOCPXG,PSODLESM,PSODELNX,PSOCPXH
 N PSODLINS,PSODLINR,PSODLERA,PSODLERB,PSODLERF,PSODLERZ,PSODLPL,PSODLP1,PSODLMSG,PSODLFLG,PSODLALZ,DIR,DUOUT,DTOUT,DIROUT,DIRUT,X,Y,X1,PSODLNN1,PSODLERR,PSODLERX,PSODLQT,PSODLEXR,PSODLECT
 I '$G(PSOTOF) W @IOF
 S (PSODLERF,PSODLERZ,PSODLALZ,PSODLINS,PSODLINR,PSODLERR,PSOCPXF,PSOCPXC,PSODLQT,PSOCPXH)=0
 I PSOCPXB>3 S PSOCPXC=1
 I $P($G(^TMP($J,"PSOPDOSN","OUT",0)),"^")=-1 S PSODLQT=1 D  S PSODLFLG=0,PSODLERR=1 G ENDZ
 .D:PSOCPXC HD W:'PSODLQT&(PSOCPXC) !! N X,DIWL,DIWR,DIWF,PSODELXR,PSODELXF D MESG
 .S X="Reason: "_$P(^TMP($J,"PSOPDOSN","OUT",0),"^",2),DIWL=1,DIWR=76 K ^UTILITY($J,"W") D ^DIWP
 .S PSODELXF=0 F PSODELXR=0:0 S PSODELXR=$O(^UTILITY($J,"W",DIWL,PSODELXR)) Q:'PSODELXR  D:PSOCPXC HD W:PSODELXF&('PSODLQT)&(PSOCPXC) ! D:PSOCPXC HD W:'PSODLQT&(PSOCPXC) "   "_$G(^UTILITY($J,"W",DIWL,PSODELXR,0)) S PSODELXF=1
 .K ^UTILITY($J,"W")
 D DOSEZ^PSODOSU2
ENDZ ;
 K PSODAILY I 'PSODLALZ,'$G(PSODLFLG),'PSODLERR Q 0
 I 'PSODLFLG W !
 I '$G(PSODLINS)&('$G(PSODLINR)) Q 0
 K DIR,Y S DIR("B")="Y",DIR(0)="Y",DIR("A")="Do you want to Continue" D ^DIR K DIR
 I Y'=1!($D(DTOUT))!($D(DUOUT)) Q 1
 I '$D(^XUSEC("PSORPH",DUZ)),$G(PSODLINS)!($G(PSODLINR))  Q 2_"^"_$$EVAL(PSODLINS,PSODLINR)
 ;G ENDZ2:$G(PSORX("EDIT"))!$G(PSOCKCON)!$G(PSOEDDOS)!($G(PSOCOPY)&$G(PSODLBD4))
 G ENDZ2:$G(PSORX("EDIT"))!($G(PSORXED)&$G(PSOEDDOS))!($G(PSOCOPY)&$G(PSODLBD4))
 W !!,"Do you want to Process medication",! K DIR,Y S DIR("B")="P",DIR(0)="SA^1:PROCESS MEDICATION;0:CANCEL MEDICATION"
 S DIR("A")=$$GETGN^PSODOSUN(PSODRUG("IEN"))_": "  K ^TMP($J,"PSODOSUN GN")
 ;S DIR("A")=$P($G(^PSDRUG(PSODRUG("IEN"),0)),"^")_": "
 S DIR("?",1)="Enter '1' or 'P' to Process Medication",DIR("?",2)="enter '0' or 'C' to Cancel Medication"
 D ^DIR K DIR,PSODOSEX
 I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODOSEX=1 Q 1
 D SIG^XUSESIG I $G(X1)="" Q 1
ENDZ2 ;
 I $G(PSORX("DFLG")) Q 0
 Q 2_"^"_$S($G(PSODLINS)&($G(PSODLINR)):"MAX SINGLE DOSE & DAILY DOSE RANGE",$G(PSODLINS):"MAX SINGLE DOSE",$G(PSODLINR):"DAILY DOSE RANGE",1:"UNKNOWN")
HD ;
 I PSODLQT!(($Y+5)'>IOSL) Q
 N DIR,DTOUT,DUOUT,DIRUT,DIROUT,X,Y
 I $D(^XUSEC("PSORPH",DUZ))  D  I Y'=1!($D(DTOUT))!($D(DUOUT)) S PSODOSEX=1 S:$G(PSOREINS) PSOQUIT=1,PSORX("DFLG")=1 Q 1
 .K DIR,Y S DIR("B")="Y",DIR(0)="Y",DIR("A")="Do you want to Continue" D ^DIR K DIR
 ;W ! K DIR,Y S DIR(0)="E",DIR("A")="Press Return to continue,'^' to exit" D ^DIR K DIR I 'Y S PSODLQT=1 Q
 W @IOF W !
 Q
MESG ;Write out System error heading
 I 'PSODLQT D HD W "Dosing Checks could not be performed:",!
 Q
GETGN(PSODRIEN) ;get generic name
 K ^TMP($J,"PSODOSUN GN")
 D DATA^PSS50(PSODRIEN,,,,,"PSODOSUN GN")
 Q $S($D(^TMP($J,"PSODOSUN GN",PSODRIEN,.01)):^TMP($J,"PSODOSUN GN",PSODRIEN,.01),1:"")
 ;
