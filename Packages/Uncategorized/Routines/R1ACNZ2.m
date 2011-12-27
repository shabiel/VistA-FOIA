R1ACNZ2 ;VISN21/NLS/- Cont. Display WP data in CSP
 ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
 ;W # ;SFVAMC/DAD/3-31-2011/Add form feed (W #) to reset $X and $Y
 W "<label for=""text"">No Show - Please Call Us - [PC Type# 10]</label><br />"
 I $P($G(^DIZ(612418,DA,0)),U,6)]"" D
 .W "Please call us at"
 .W "<br>"
 .W $P($G(^DIZ(612418,DA,0)),U,6)
 .W "<br>"
 .W "to make a new"
 .W "<br>"
 .W "appointment."
 .W "<br>"
 W "<TEXTAREA align=""center"" name=""BB10"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""17"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=17,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 W "</TEXTAREA><br><br><br>"
 W "<label for=""text"">Cancelled Appointment + New Appointment - Alert - [PC Type# 11]</label><br />"
 I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
 .W "Can't make it?"
 .W "<br>"
 .W "Please call"
 .W "<br>"
 .W $P($G(^DIZ(612418,DA,0)),U,5)
 .W " to cancel."
 .W "<br>"
 W "<TEXTAREA align=""center"" name=""BB11"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""18"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=18,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 W "</TEXTAREA><br><br><br>"
 W "<label for=""text"">Group Orientaion Appointment - Alert - [PC Type# 12]</label><br />"
 I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
 .W "Can't make it?"
 .W "<br>"
 .W "Please call"
 .W "<br>"
 .W $P($G(^DIZ(612418,DA,0)),U,5)
 .W " to cancel."
 .W "<br>"
 W "<TEXTAREA align=""center"" name=""BB12"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""19"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=19,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 W "</TEXTAREA><br><br><br>"
 W "<label for=""text"">Cancel Clinic/No reschedule - Alert - [PC Type# 13]</label><br />"
 W "<TEXTAREA align=""center"" name=""BB13"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""20"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=20,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 W "</TEXTAREA><br><br><br>"
 W "<label for=""text"">Fee-Based Service at Non-VA site - [PC Type# 14]</label><br />"
 I $P($G(^DIZ(612418,DA,0)),U,5)]"" D
 .W "Can't make it?"
 .W "<br>"
 .W "Please call"
 .W "<br>"
 .W $P($G(^DIZ(612418,DA,0)),U,5)
 .W " to cancel."
 .W "<br>"
 W "<TEXTAREA align=""center"" name=""BB14"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""21"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=21,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 W "</TEXTAREA><br><br><br>"
 W "<label for=""text"">Birthday - [PC Type# 15]</label><br />"
 I $P($G(^DIZ(612418,DA,0)),U,6)]"" D
 .W "Please call us at "
 .W $P($G(^DIZ(612418,DA,0)),U,6)
 .W "<br>"
 .W "to make an appointment."
 .W "<br>"
 W "<TEXTAREA align=""center"" name=""BB15"" rows=""9"" cols=""65"" style=""color: #000000>"
 W "<background-color:#F0F8FF"" onMouseover=""('Dimension is 65 characters by 9 lines')"" tabindex=""22"">"
 N DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,R1ACFLD,R1ACIEN,R1ACCNT,NODE,DIWP,R1ACQ
 S (DIWF,DIWL,DIWR,ARHD1,ARHDMSGS,ARHDWP,X,NODE,DIWP,R1ACQ)=""
 S R1ACCNT=0,R1ACFLD=22,R1ACIEN=DA,R1ACIEN=R1ACIEN_","
 D WPOUTPUT^R1ACSUT2(612418,R1ACIEN,R1ACFLD,0,.R1ACCNT)
 ;K ^UTILITY($J,"W")
 ;D GETS^DIQ(612418,""_R1ACIEN_"",R1ACFLD,"","WP","")
 ;S ARHD1=0
 ;F  S ARHD1=$O(WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)) Q:ARHD1'>0  D
 ;.S NODE="",NODE=WP(612418,""_R1ACIEN_"",R1ACFLD,ARHD1)
 ;.D
 ;..S X="",X=NODE,DIWL=1,DIWR=65,DIWP="",R1ACCNT=R1ACCNT+1
 ;..D ^DIWP,^DIWW
 ;..Q
 ;.E  D
 ;..S R1ACQ=""
 ;..Q
 ;.Q
 ;K ^UTILITY($J,"W")
 ;K WP
 K DA
 W "</TEXTAREA>"
 W "<table>"
 W "<tbody>"
 Q
XTMPROOT(ARHDSUBS) ;From Don Donati's Utility: ^ARHDEOS1
 ; *** Get root in ^XTMP
 N ARHDDATE,ARHDPURG,ARHDRTN,ARHDXTMP
 S (ARHDDATE,ARHDPURG,ARHDRTN,ARHDXTMP)=""
 S ARHDRTN=$T(+0)
 S ARHDDATE=$$DT^XLFDT
 S ARHDPURG=$$FMADD^XLFDT(ARHDDATE,2,0,0,0)
 S ^XTMP(ARHDRTN,0)=ARHDPURG_U_ARHDDATE_U_""
 S ARHDSUBS=$S($G(ARHDSUBS)]"":ARHDSUBS,1:$$UNIQUE^R1UTCSPZ)
 S ARHDXTMP=$NA(^XTMP(ARHDRTN,ARHDSUBS))
 Q ARHDXTMP
 ;
GETPARAM(ARHDPARM,ARHDINST) ;From Don Donati's Utility:  ^ARHDEOS2
 ; *** Get a parameter value
 N ARHDQIET,ARHDVALU
 S (ARHDQIET,ARHDVALU)=""
 S ARHDQIET=1
 I $G(ARHDINST)]"" D
 . S ARHDVALU=$$GET^XPAR($$GETENTTY,ARHDPARM,ARHDINST)
 . Q
 E  D
 . S ARHDVALU=$$GET^XPAR($$GETENTTY,ARHDPARM)
 . Q
 Q ARHDVALU
 ;
GETENTTY() ;From Don Donati's Utility: ^ARHDEOS2
 ; *** Make the XPAR entity string
 N ARHDDUZ,ARHDENT
 S (ARHDDUZ,ARHDENT)=""
 D SETDUZ^R1UTCSPZ
 S ARHDDUZ=$S($G(DUZ)>0:DUZ,1:$$GETSES^R1UTCSPZ("DUZ"))
 S ARHDENT="USR.`"_(+ARHDDUZ)
 S ARHDENT=ARHDENT_"^SRV.`"_(+$$GET1^DIQ(200,+ARHDDUZ,29,"I"))
 S ARHDENT=ARHDENT_$S($G(DUZ(2))>0:"^DIV",1:"")
 S ARHDENT=ARHDENT_"^SYS"
 Q ARHDENT
