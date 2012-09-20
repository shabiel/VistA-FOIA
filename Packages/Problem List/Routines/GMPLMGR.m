GMPLMGR ; SLC/MKB/AJB -- Problem List VALM Utilities ; 09/13/12
 ;;2.0;Problem List;**21,28,260002**;Aug 25, 1994
 ; 28 Feb 00 - MA added view comments accross Divisions
INIT ; -- init variables, list array
 S:'$G(GMPDFN) GMPDFN=$$PAT^GMPLX1
 I +GMPDFN'>0 K GMPDFN S VALMQUIT=1 Q
 S GMPROV=$$REQPROV^GMPLX1
 I +GMPROV'>0 K GMPDFN,GMPROV S VALMQUIT=1 Q
IN1 S GMPVA=$S($G(DUZ("AG"))="V":1,1:0),GMPVAMC=+$G(DUZ(2))
 S (GMPSC,GMPAGTOR,GMPION,GMPGULF)=0 D:GMPVA VADPT^GMPLX1(+GMPDFN) ;reset
 S GMPLVIEW("ACT")="A",GMPLVIEW("PROV")=0
 S GMPLVIEW("VIEW")=$$USERVIEW^GMPLEXT(DUZ)
 K GMPARAM
 D GET^GMPLSITE(.GMPARAM)
 S %=$$GETPLIST^GMPLAPI4(.GMPLIST,GMPDFN,GMPLVIEW("ACT"),GMPARAM("REV"),GMPLVIEW("PROV"),GMPLVIEW("VIEW"),1)
 S GMPTOTAL=GMPLIST
 D BUILD(.GMPLIST)
 D:$E(GMPLVIEW("VIEW"))="S" CHGCAP^VALM("CLINIC","Service/Provider")
 S VALMSG=$$MSG^GMPLX
 Q
 ;
BUILD(PLIST) ; -- build list array
 N I
 D CLEAN^VALM10
 K ^TMP("GMPLIDX",$J)
 S (I,GMPCOUNT,VALMCNT)=0
 D:$D(XRTL) T0^%ZOSV ; Start RT Monitor
 F  S I=$O(PLIST(I)) Q:I'>0  D:$D(GMPLUSER) BLDPROB(+PLIST(I)) D:'$D(GMPLUSER) BLDPROB^GMPLMGR2(+PLIST(I))
 S ^TMP("GMPL",$J,0)=+$G(GMPCOUNT)_U_+$G(VALMCNT) ; # entries^# lines
 S:$D(XRT0) XRTN=$T(+0) D:$D(XRT0) T1^%ZOSV ; Stop RT Monitor
 I $G(GMPCOUNT)'>0 S ^TMP("GMPL",$J,1,0)="   ",^TMP("GMPL",$J,2,0)="    No data available meeting criteria."
 Q
BLDPROB(IFN) ; Add problem line
 N GMPL,DELETED,STATUS,PROBLEM,LINE,TEXT,NAME,TRANS,I,DATE
 S %=$$DETAILX^GMPLAPI2(.GMPL,IFN)
 S DELETED=($E(GMPL("CONDITION"))="H")
 S TRANS=($E(GMPL("CONDITION"))="T")
 S STATUS=$E(GMPL("STATUS"))
 S DATE=$J(GMPL("MODIFIED"),8)
 S PROBLEM=$S(DELETED:"< DELETED >",1:GMPL("NARRATIVE"))
 I STATUS="A",GMPL("ONSET"),'DELETED S PROBLEM=PROBLEM_", Onset "_GMPL("ONSET")
 I STATUS="I",GMPL("RESOLVED"),'DELETED S PROBLEM=PROBLEM_", Resolved "_GMPL("RESOLVED")
 D WRAP^GMPLX(PROBLEM,40,.TEXT) ; format text to 41 chr
 I $E(GMPLVIEW("VIEW"))="S" S NAME=GMPL("SERVICE")_"/"_$$FMTNAME^GMPLX1(GMPL("PROVIDER"))
 E  S NAME=GMPL("CLINIC")
 ; Build line of text
 S GMPCOUNT=+$G(GMPCOUNT)+1
 S LINE=$$SETFLD^VALM1(GMPCOUNT,"","NUMBER")
 S:STATUS="A" STATUS=$S($E(GMPL("PRIORITY"))="A":"*",1:"") ; reset for priority
 S LINE=$$SETFLD^VALM1(STATUS,LINE,"STATUS")
 S LINE=$$SETFLD^VALM1(TEXT(1),LINE,"PROBLEM")
 S LINE=$$SETFLD^VALM1(DATE,LINE,"DATE")
 S LINE=$$SETFLD^VALM1(NAME,LINE,"CLINIC")
 S VALMCNT=+$G(VALMCNT)+1
 S ^TMP("GMPL",$J,VALMCNT,0)=LINE,^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 S ^TMP("GMPLIDX",$J,GMPCOUNT)=VALMCNT_U_IFN
 I GMPARAM("VER"),TRANS D
 . S LINE=$E(LINE,1,4)_"$"_$E(LINE,6,79)
 . S ^TMP("GMPL",$J,VALMCNT,0)=LINE
 . D CNTRL^VALM10(VALMCNT,5,1,IOINHI,IOINORM)
 ; added for Code Set Versioning (CSV) - annotates inactive ICD code with #
 I '$$CODESTS^GMPLX(IFN,DT) D
 . S LINE=$E(LINE,1,4)_"#"_$E(LINE,6,79)
 . S ^TMP("GMPL",$J,VALMCNT,0)=LINE
 . D CNTRL^VALM10(VALMCNT,5,1,IOINHI,IOINORM)
 Q:DELETED
 ; Add text to array
 I TEXT>1 F I=2:1:TEXT D
 . S LINE="",LINE=$$SETFLD^VALM1(TEXT(I),LINE,"PROBLEM")
 . S VALMCNT=VALMCNT+1,^TMP("GMPL",$J,VALMCNT,0)=LINE
 . S ^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 F I=1:1:GMPL("COMMENT") D
 . S VALMCNT=VALMCNT+1
 . S ^TMP("GMPL",$J,"IDX",VALMCNT,GMPCOUNT)=""
 . S ^TMP("GMPL",$J,VALMCNT,0)="        "_$P(GMPL("COMMENT",I),U,3)
 Q
 ;
HDR ; -- header code
 N HDR,LNM,FNM,PAT,NUM
 S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S NUM=GMPCOUNT S:GMPTOTAL>GMPCOUNT NUM=NUM_" of "_GMPTOTAL
 S NUM=NUM_$S(GMPLVIEW("ACT")="A":" active",GMPLVIEW("ACT")="I":" inactive",1:"")_" problems"
 S VALMHDR(1)=PAT_$J(NUM,79-$L(PAT))
 S HDR=$S(GMPLVIEW("ACT")="I":"INACTIVE",GMPLVIEW("ACT")="A":"ACTIVE",1:"ALL")
 I $L(GMPLVIEW("VIEW"))>2 S HDR=HDR_$S($E(GMPLVIEW("VIEW"))="S":" SERVICE",1:" CLINIC") ; screened
 S HDR=HDR_" PROBLEMS"
 S:GMPLVIEW("PROV") LNM=$P($P(GMPLVIEW("PROV"),U,2),","),FNM=$P($P(GMPLVIEW("PROV"),U,2),",",2),HDR=HDR_" BY "_FNM_" "_LNM
 S VALMHDR(2)=$J(HDR,$L(HDR)\2+41)
 Q
 ;
HELP ; -- help code
 N X
 W !!?4,"To update the problem list first select from Add, Remove, Edit,"
 W !?4 W:GMPARAM("VER") "Verify, "
 W "Inactivate, or Comment, then enter the problem number(s)."
 W !?4,"If you need more information on a problem, select Detailed"
 W !?4,"Display; to change whether all or only selected problems for this"
 W !?4,"patient are listed, choose Select View.  Enter ?? to see more"
 W !?4,"actions for facilitating navigation of the list."
 W !?4,"Problem statuses: *-Acute I-Inactive #-Inactive ICD Code"
 W:GMPARAM("VER") " $-Unverified"
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
