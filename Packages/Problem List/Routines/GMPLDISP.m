GMPLDISP ; SLC/MKB -- Problem List detailed display ; 04/15/2002
 ;;2.0;Problem List;**21,26,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA  3106  ^DIC(49
 ;   DBIA 10082  ^ICD9( file 80
 ;   DBIA 10040  ^SC(  file 44
 ;   DBIA 10060  ^VA(200
 ;   DBIA 10116  $$SETSTR^VALM1
 ;   DBIA 10117  CLEAN^VALM10
 ;   DBIA 10117  CNTRL^VALM10
 ;   DBIA 10103  $$FMTE^XLFDT
 ;   DBIA 10103  $$HTFM^XLFDT
 ;   DBIA 10104  $$REPEAT^XLFSTR
 ;                      
EN ; Init Variables (need GMPLSEL,GMPLNO) and List Array
 G:'$D(GMPLSEL) ERROR G:'$G(GMPLNO) ERROR
 S GMPI=+$G(GMPI)+1 I GMPI>GMPLNO D  Q
 . W !!,"There are no more problems that have been selected to view!",! S VALMBCK="" H 2
 S GMPLNUM=$P(GMPLSEL,",",GMPI) G:GMPLNUM'>0 ERROR
 S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) G:GMPIFN'>0 ERROR
 W !!,"Retrieving current data for problem #"_GMPLNUM_" ...",!
 ;                        
PROB ; Display problem GMPIFN
 N LINE,STR,I,TEXT,NOTE,GMPL,X,Y,IDT,FAC,AIFN,SP,LCNT,NIFN
 G:'$G(GMPIFN) ERROR D CLEAN^VALM10
 D DETAILX^GMPLAPI2(.GMPL,GMPIFN,$G(GMPLMGR),$G(GMPROV))
 S SP="",LCNT=1
 F I=1:1:GMPL("EXPOSURE") D
 . S SP=SP_GMPL("EXPOSURE",I)
 . S:I'=GMPL("EXPOSURE") SP=SP_U
 D WRAP^GMPLX($$PROBTEXT^GMPLX(GMPIFN),65,.TEXT)
 S GMPDT(LCNT,0)="  Problem: "_TEXT(1)
 I TEXT>1 F I=2:1:TEXT S LCNT=LCNT+1,GMPDT(LCNT,0)=TEXT(I)
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR1 ;   Onset
 ;   SC Condition
 ;   Status
 ;   Exposure
 ;   Provider
 ;   Service/Clinic
 S LINE="    Onset: "_$S(GMPL("ONSET")'="":GMPL("ONSET"),1:"date unknown"),STR=""
 S:GMPVA STR="SC Condition: "_GMPL("SC")
 S LINE=$$SETSTR^VALM1(STR,LINE,49,30),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S LINE="   Status: "_GMPL("STATUS")
 I GMPL("PRIORITY")'="" S LINE=LINE_"/"_GMPL("PRIORITY")
 I GMPL("STATUS")="INACTIVE",GMPL("RESOLVED") S LINE=LINE_", Resolved "_GMPL("RESOLVED")
 S STR="",LCNT=LCNT+1
 S:GMPVA STR="    Exposure: "_$S('$L(SP):"none",1:$P(SP,U))
 S LINE=$$SETSTR^VALM1(STR,LINE,49,30),GMPDT(LCNT,0)=LINE
 S LINE=" Provider: "_GMPL("PROVIDER"),LCNT=LCNT+1,STR=""
 I GMPVA,$L(SP,U)>1 S STR=$P(SP,U,2)
 S LINE=$$SETSTR^VALM1(STR,LINE,63,16),GMPDT(LCNT,0)=LINE
 I $E(GMPLVIEW("VIEW"))="S" S LINE="  Service: "_GMPL("SERVICE")
 E  S LINE="   Clinic: "_GMPL("CLINIC")
 S LCNT=LCNT+1,STR="" I GMPVA,$L(SP,U)>2 S STR=$P(SP,U,3)
 S LINE=$$SETSTR^VALM1(STR,LINE,63,16),GMPDT(LCNT,0)=LINE
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR2 ;   Recorded
 ;   Entered
 ;   Provider Narrative
 ;   ICD code
 S LINE=" Recorded: "_$S($P(GMPL("RECORDED"),U):$P(GMPL("RECORDED"),U),1:"date unknown")
 S:$P(GMPL("RECORDED"),U,2) LINE=LINE_", by "_$P(GMPL("RECORDED"),U,2)
 S LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S LINE="  Entered: "_$P(GMPL("ENTERED"),U)
 S LINE=LINE_", by "_$P(GMPL("ENTERED"),U,2),LCNT=LCNT+1
 S:GMPARAM("VER")&(GMPL("CONDITION")="TRANSCRIBED") LINE=LINE_"  <unconfirmed>"
 S GMPDT(LCNT,0)=LINE
 S LINE=" ICD Code: "_GMPL("DIAGNOSIS"),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
PR3 ;   Comments
 S LCNT=LCNT+1,GMPDT(LCNT,0)="Comments:"
 D CNTRL^VALM10(LCNT,1,8,IOUON,IOUOFF)
 ;     By Facility
 I GMPL("COMMENT")=0 S LCNT=LCNT+1,GMPDT(LCNT,0)="   <None>" G PR4
 F I=1:1:GMPL("COMMENT") D
 . S NOTE=$P(GMPL("COMMENT",I),U,3) Q:NOTE=""
 . S LINE=$J($P(NOTE,U),10)_": "_$P(NOTE,U,3)
 . S LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 . I $P(NOTE,U,2) S LINE="            "_$P(NOTE,U,2),LCNT=LCNT+1,GMPDT(LCNT,0)=LINE
 S:'($G(NOTE)) LCNT=LCNT+1,GMPDT(LCNT,0)="   <None>"
PR4 ;   Audit Trail
 S LCNT=LCNT+1,GMPDT(LCNT,0)="       "
 S LCNT=LCNT+1,GMPDT(LCNT,0)="History:"
 D CNTRL^VALM10(LCNT,1,7,IOUON,IOUOFF)
 I GMPL("HISTORY")=0 S LCNT=LCNT+1,GMPDT(LCNT,0)="   <No changes>" G PRQ
 F I=1:1:GMPL("HISTORY") D 
 . S AIFN=$P(GMPL("HISTORY",I),U) 
 . D AUDET^GMPLHIST(.RETURN,AIFN)
 . D DT(.GMPDT,.LCNT,.RETURN)
PRQ ;   Header Node
 S VALMCNT=LCNT,GMPDT(0)=VALMCNT,VALMSG=$$MSG^GMPLX,VALMBG=1,VALMBCK="R"
 Q
 ;                     
DT(GMPDT,LCNT,RETURN) ;
 N FLD,OLD,NEW,DATE,PROV
 S FLD=RETURN("FLD")
 S OLD=RETURN("OLD")
 S NEW=RETURN("NEW")
 S DATE=RETURN("DATE")
 S PROV=RETURN("PROV")
 S LCNT=LCNT+1
 I +FLD=1101 D  Q
 . S REASON=" removed by "
 . S:OLD="C" REASON=" changed by "
 . S GMPDT(LCNT,0)=$J(DATE,10)_": NOTE "_RETURN("OLDDATE")_REASON_PROV_":"
 . S LCNT=LCNT+1,GMPDT(LCNT,0)="            "_RETURN("OLDNOTE")
 I +FLD=1.02 D  Q
 . S CHNGE=$S(NEW="H":"removed",OLD="T":"verified",1:"placed back on list")
 . S GMPDT(LCNT,0)=$J(DATE,10)_": PROBLEM "_CHNGE_" by "_PROV
 S GMPDT(LCNT,0)=$J(DATE,10)_": "_$P(FLD,U,2)_" changed by "_PROV,LCNT=LCNT+1
 I +FLD=.12 S GMPDT(LCNT,0)=$J("from ",17)_$S(OLD="A":"ACTIVE",OLD="I":"INACTIVE",1:"UNKNOWN")_" to "_$S(NEW="A":"ACTIVE",NEW="I":"INACTIVE",1:"UNKNOWN") Q
 I (+FLD=.13)!(+FLD=1.07) S GMPDT(LCNT,0)=$J("from ",17)_OLD_" to "_NEW Q
 I +FLD=1.14 S GMPDT(LCNT,0)=$J("from ",17)_$S(OLD="A":"ACUTE",OLD="C":"CHRONIC",1:"UNSPECIFIED")_" to "_$S(NEW="A":"ACUTE",NEW="C":"CHRONIC",1:"UNSPECIFIED") Q
 I +FLD>1.09 S GMPDT(LCNT,0)=$J("from ",17)_$S(+OLD:"YES",OLD=0:"NO",1:"UNKNOWN")_" to "_$S(+NEW:"YES",NEW=0:"NO",1:"UNKNOWN") Q
 I "^.01^.05^1.01^1.04^1.05^1.06^1.08^"[(U_+FLD_U) D
 . S GMPDT(LCNT,0)=$J("from ",17)_$S($L($G(OLD))>0:OLD,1:"UNSPECIFIED")
 . S LCNT=LCNT+1,GMPDT(LCNT,0)=$J("to ",17)_$S($L($G(NEW))>0:NEW,1:"UNSPECIFIED")
 Q
 ;
HDR ; Header Code (uses GMPDFN, GMPIFN)
 N LASTMOD,PAT S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 D:$G(GMPIFN) LASTMOD^GMPLAPI4(.LASTMOD,GMPIFN)
 S:'$G(GMPIFN) LASTMOD=$E($$HTFM^XLFDT($H),1,12)
 S LASTMOD="Last Updated: "_$$FMTE^XLFDT(LASTMOD)
 S VALMHDR(1)=PAT_$$REPEAT^XLFSTR(" ",(79-$L(PAT)-$L(LASTMOD)))_LASTMOD
 Q
 ;
HELP ; Help Code
 N X W !!?4,"You may view detailed information here on this problem;"
 W !?4,"more data may be available by entering 'Next Screen'."
 W !?4,"If you have selected multiple problems to view, you may"
 W !?4,"enter 'Continue to Next Selected Problem'; to return to"
 W !?4,"the patient's problem list, enter 'Quit to Problem List'."
 W !!,"Press <return> to continue ... " R X:DTIME
 S VALMSG=$$MSG^GMPLX,VALMBCK=$S(VALMCC:"",1:"R")
 Q
 ;
DEFLT() ; Default Action, using GMPI and GMPLNO
 I GMPI<GMPLNO Q "Continue to Next Selected Problem"
 Q "Quit to Problem List"
 ;
ERROR ; Error Message - drop into EXIT
 W !!,"ERROR -- Cannot continue ... Returning to Problem List.",!
 S VALMBCK="Q" H 1
EXIT ; Exit Code
 K GMPDT Q
