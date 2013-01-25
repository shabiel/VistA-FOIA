SDMUI ;RGI/VSL - UI UTILS; 01/24/2013
 ;;5.3;scheduling;**260003**;08/13/93;
SELPAT(PARAM) ; Select patient
 N Y,DIC
 S:$D(PARAM("PRMPT")) DIC("A")=PARAM("PRMPT")
 S DIC(0)="AEQM"_$G(PARAM("FLAG"))
 S DIC="^DPT(" D ^DIC
 Q Y
 ;
SELCLN(PARAM) ; Select clinic
 N Y,DIC
 S:$D(PARAM("PRMPT")) DIC("A")=PARAM("PRMPT")
 S DIC(0)="AEQM"_$G(PARAM("FLAG"))
 S DIC="^SC("
 S DIC("S")="I $P(^(0),U,3)=""C"",'$G(^(""OOS""))"
 D ^DIC
 Q Y
 ;
SELCRSN(PARAM,WHO) ; Select cancellation reason
 N Y,DIC
 S:$D(PARAM("PRMPT")) DIC("A")=PARAM("PRMPT")
 S DIC="^SD(409.2,",DIC(0)="AEQM"
 S DIC("S")="I '$P(^(0),U,4),(WHO_""B""[$P(^(0),U,2))"
 D ^DIC
 Q Y
 ;
SELPCTM(PARAM) ; Select PC team
 N Y,DIC
 S DIC="^SCTM(404.51,"
 S DIC(0)="AEMQZ"
 S DIC("S")=$G(PARAM("SCR"))
 D ^DIC
 Q Y
 ;
SELTEAM(PARAM) ; Select team
 N Y,DIC
 S DIC="^SCTM(404.51,"
 S DIC(0)="AEMQZ"
 S DIC("S")="IF $$ACTTM^SCMCTMU(Y,DT) I $$NEW^SCMCQK2()"
 D ^DIC
 Q Y
 ;
SELPOSCP(PARAM) ; Select position current practitioner
 N Y,DIC
 S DIC("W")="N SCP1 S SCP1=$G(^SCTM(404.52,Y,0)) W ""    ["",$P($G(^VA(200,+$P(SCP1,U,3),0)),U,1),""]"""
 S DIC("A")=PARAM("PRMPT")
 S DIC="^SCTM(404.52,"
 S DIC("S")="I $$PRACSCR^SCMCQK1(Y)"
 S DIC(0)="AEMQZ"
 D ^DIC
 Q Y
 ;
SELPOSN(PARAM) ; Select position name
 N Y,DIC
 S DIC="^SCTM(404.57,"
 S DIC("A")=PARAM("PRMPT")
 S DIC("S")=$G(PARAM("SCR"))
 S DIC(0)="AEMQZ"
 D ^DIC
 Q Y
