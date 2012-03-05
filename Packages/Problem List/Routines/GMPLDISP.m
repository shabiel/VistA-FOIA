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
 D DETAILX^GMPLAPI2(GMPIFN,.GMPL,$G(GMPLMGR),GMPVAMC,GMPROV)
 S SP="",LCNT=1
 F I=1:1:GMPL("EXPOSURE") D
 . S SP=SP_GMPL("EXPOSURE",I)
 . S:I'=GMPL("EXPOSURE") SP=SP_U
 ;S GMPL0=$G(^AUPNPROB(GMPIFN,0)),GMPL1=$G(^(1)),LCNT=1,SP=""
 ;F I=11,12,13,15,16,17,18 S:+$P(GMPL1,U,I) SP=SP_$S(I=11:"AGENT ORANGE",I=12:"RADIATION",I=13:"ENV CONTAMINANTS",I=15:"HEAD/NECK CANCER",I=16:"MIL SEXUAL TRAUMA",I=17:"COMBAT VET",1:"SHAD")_U
 ;F  Q:$E(SP,$L(SP))'="^"  S SP=$E(SP,1,($L(SP)-1))
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
 F I=1:1:GMPL("HISTORY") S AIFN=$P(GMPL("HISTORY",I),U) D DT^GMPLHIST
PRQ ;   Header Node
 S VALMCNT=LCNT,GMPDT(0)=VALMCNT,VALMSG=$$MSG^GMPLX,VALMBG=1,VALMBCK="R"
 Q
 ;                     
HDR ; Header Code (uses GMPDFN, GMPIFN)
 N LASTMOD,PAT S PAT=$P(GMPDFN,U,2)_"  ("_$P(GMPDFN,U,3)_")"
 S LASTMOD=$S($G(GMPIFN):$P(^AUPNPROB(GMPIFN,0),U,3),1:$E($$HTFM^XLFDT($H),1,12))
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
