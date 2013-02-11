PRCAMDA2 ;ALB/TAZ - PRCA MDA MANAGEMENT WORKLIST SCREEN ;26-APR-2011
 ;;4.5;Accounts Receivable;**275**;Mar 20, 1995;Build 72
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; Need Integration Agreement with IB to call into TPJI.  We are using IB variables to make sure that everything works.
TPJI ;Third Party joint Inquiry - IA-???
 N DFN,PRCAIEN,IBIFN,IBNOTPJI
 D SEL(.PRCADA,1)
 S PRCAIEN=+$G(PRCADA(+$O(PRCADA(0))))
 I 'PRCAIEN G TPJIQ
 S PRCAFN=$P($G(^PRCA(436.1,PRCAIEN,1)),U,1) I PRCAFN S DFN=$P(^PRCA(430,PRCAFN,0),U,7)
 I '$G(DFN)!'PRCAFN G TPJIQ
 S IBIFN=PRCAFN,IBNOTPJI=1
 D EN^VALM("IBJT CLAIM INFO")
 K:$D(IBFASTXT) IBFASTXT
TPJIQ S VALMBCK="R"
 Q
 ;
CMNT ; enter MDA comments - entry point from MDA Worklist screen
 ; we need to select an entry from the list and set PRCAFN
 N DA,DD,DIC,DIK,DLAYGO,X,Y,PRCADA,PRCAFN,MRAFLG
 S MRAFLG=1
 D SEL(.PRCADA,1) S:$O(PRCADA(0)) PRCAIEN=+PRCADA($O(PRCADA(0))) I '$G(PRCAIEN) G CMNTQ
 D EN^VALM("PRCA MDA COMMENTS")
 D BLD^PRCAMDA1
 ;
CMNTQ ;
 S VALMBCK="R"
 Q
 ;
SEL(PRCADA,ONE) ; Select entry(s) from list
 ; PRCADA = array returned if selections made
 ;    PRCADA(n)=ien of entry selected (file 436.1)
 ; ONE = if set to 1, only one selection can be made at a time
 N VALMY
 K PRCADA
 D FULL^VALM1
 D EN^VALM2("",$S('$G(ONE):"",1:"S"))
 S PRCADA=0 F  S PRCADA=$O(VALMY(PRCADA)) Q:'PRCADA  S PRCADA(PRCADA)=$P($G(^TMP("PRCAMDA",$J,+PRCADA)),U,2,6)
 Q
 ;
STATUS ; change MDA review status
 N DA,DIE,DR,PRCADA,PRCAFN,SEL
 D SEL(.PRCADA,1) S:$O(PRCADA(0)) PRCAIEN=+PRCADA($O(PRCADA(0))) G:'$G(PRCAIEN) STATUSX
 L +^PRCA(436.1,PRCAIEN):3 I '$T W !,*7,"Sorry, another user currently editing this entry." D PAUSE^VALM1 G STATUSX
 D STATUS1
STATUSX ;
 ;update list manager display
 L -^PRCA(436.1,PRCAIEN)
 D BLD^PRCAMDA1
 S VALMBCK="R"
 Q
 ;
STATUS1 ; Entry point from comments section
 N PRCASTAT,PRCATEXT
 ; make sure this entry is not locked already
 ; Prompt for status change
 W !
 S DIR(0)="436.1,1.02",DIR("B")="REVIEW IN PROCESS"
 D ^DIR K DIR
 I $D(DTOUT)!$D(DUOUT) G STATUS1X
 M PRCASTAT=Y
 I PRCASTAT=3 D
 . W !
 . S DIR(0)="Y",DIR("A")="Are you sure you want to remove this entry from the worklist",DIR("B")="NO"
 . D ^DIR K DIR
 . I $D(DTOUT)!$D(DUOUT)!'Y S PRCASTAT="" Q
 . ; Enter comment for removal from worklist
 . S PRCATEXT(1)="Review completed and entry removed from worklist."
 . S DA(1)=PRCAIEN
 . K DO S DIC="^PRCA(436.1,"_DA(1)_",2,",DIC(0)="L",X=$$NOW^XLFDT,DLAYGO=436.12
 . D FILE^DICN
 . S DA=+Y I DA'>0 Q
 . D WP^DIE(436.12,DA_","_DA(1)_",",2,,"PRCATEXT")
 . K DIC
 I PRCASTAT'="" S DIE=436.1,DA=PRCAIEN,DR="1.02///"_PRCASTAT(0) D ^DIE,CLEAN^DILF
STATUS1X ;
 Q
 ;
MCOM(PRCABN,PRCALN)  ; MDA (Medicare Deductible Alert) Comments
 ; INPUTS: IEN for 430
 ;       : LIST MAN LINE COUNTER (Pass by Reference)
 ; OUTPUT: VALMAR
 ; PRCA*4.5*275 BI
 ; INTEGRATION CONTROL REGISTRATION is contained in DBIA #5696.
 ;
 N PRCADATE,PRCAIMDA,PRCAZ,PRCACMLN,PRCACTL,PRCAMCOM
 S PRCACTL=1
 S PRCAMCOM(0)=0
 I '$G(PRCABN) Q
 S PRCAIMDA=""
 F  S PRCAIMDA=$O(^PRCA(436.1,"C",PRCABN,PRCAIMDA)) Q:PRCAIMDA=""  D
 . D MCOM2(PRCAIMDA,.PRCALN,PRCACTL)
 D:PRCACTL=1 MDACMTS
 Q
MCOM2(PRCAIMDA,PRCALN,PRCACTL)  ; MDA (Medicare Deductible Alert) Comments
 ; INPUTS: IEN for 436.1
 ;       : LIST MAN LINE COUNTER (Pass by Reference)
 ; OUTPUT: VALMAR
 ; PRCA*4.5*275 BI
 ;
 S PRCACTL=$G(PRCACTL,0)
 I PRCACTL=0 N PRCACMLN,PRCADATE,PRCAZ,PRCAMCOM S PRCAMCOM(0)=0
 I 'PRCAIMDA Q
 I $D(^PRCA(436.1,PRCAIMDA,2))'>1 Q
 ; Loop through all available MDA comments.
 S PRCADATE="" F  S PRCADATE=$O(^PRCA(436.1,PRCAIMDA,2,"B",PRCADATE),-1) Q:PRCADATE=""  D
 . S PRCAMCOM(0)=PRCAMCOM(0)+1
 . S PRCAZ=$O(^PRCA(436.1,PRCAIMDA,2,"B",PRCADATE,""))
 . S PRCAIMDA(0)=$G(^PRCA(436.1,PRCAIMDA,2,PRCAZ,0))
 . S PRCAIMDA(0,0)=$G(^PRCA(436.1,PRCAIMDA,2,PRCAZ,1,0))
 . S PRCAMCOM(PRCAMCOM(0))=$$GET1^DIQ(200,$P(PRCAIMDA(0),U,2),.01)_U
 . S PRCAMCOM(PRCAMCOM(0))=PRCAMCOM(PRCAMCOM(0))_$$FMTE^XLFDT(PRCADATE,"2Z")_U
 . S PRCAMCOM(PRCAMCOM(0))=PRCAMCOM(PRCAMCOM(0))_$$FMTE^XLFDT($P(PRCAIMDA(0),U,3),"2Z")
 . ; Loop through the comment lines.
 . S PRCAMCOM(PRCAMCOM(0),0)=$P(PRCAIMDA(0,0),U,4)
 . F PRCACMLN=1:1:PRCAMCOM(PRCAMCOM(0),0) D
 .. S PRCAMCOM(PRCAMCOM(0),PRCACMLN)=^PRCA(436.1,PRCAIMDA,2,PRCAZ,1,PRCACMLN,0)
 I PRCACTL=0 D MDACMTS
 Q
 ;
MDACMTS ; Check for MDA comments, Load for List Manager Screen IB*2.0*447 BI
 ; Input:  VALMAR
 ;         PRCALN
 ; Output: @VALMAR Array
 ;
 N PRCASTR,PRCACCNT,PRCAK
 N DIW,DIWF,DIWI,DIWL,DIWR,DIWT,DIWTC,DIWX,DN,%,I,X,Z
 I PRCAMCOM(0)=0 Q
 ;
 ; Set up the header for the MDA comments section.
 S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,"")
 S PRCASTR=""
 S PRCASTR=$$SETSTR^VALM1("MEDICARE DEDUCTIBLE ALERT WORKLIST COMMENTS",PRCASTR,25,54)
 S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,PRCASTR)
 S PRCASTR=""
 S PRCASTR=$$SETSTR^VALM1("-------------------------------------------",PRCASTR,25,54)
 S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,PRCASTR)
 ;
 ; Loop through all available MDA comments.
 F PRCACCNT=1:1:PRCAMCOM(0) D
 . S PRCASTR=""
 . S PRCASTR=$$SETSTR^VALM1($P(PRCAMCOM(PRCACCNT),U,2),PRCASTR,14,8)
 . S PRCASTR=$$SETSTR^VALM1($J("Entered by "_$P(PRCAMCOM(PRCACCNT),U,1),54),PRCASTR,25,54)
 . S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,PRCASTR)
 . K ^UTILITY($J)
 . F PRCACMLN=1:1:PRCAMCOM(PRCACCNT,0) D
 .. S X=PRCAMCOM(PRCACCNT,PRCACMLN) I X'="" S DIWL=1,DIWR=54,DIWF=""  D ^DIWP
 . I $D(^UTILITY($J,"W")) S PRCAK=0 F  S PRCAK=$O(^UTILITY($J,"W",1,PRCAK)) Q:'PRCAK  D
 .. S PRCASTR=""
 .. S PRCASTR=$$SETSTR^VALM1($G(^UTILITY($J,"W",1,PRCAK,0)),PRCASTR,25,54)
 .. S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,PRCASTR)
 . I $P(PRCAMCOM(PRCACCNT),U,3)'="" D
 .. S PRCASTR=""
 .. S PRCASTR=$$SETSTR^VALM1("Follow Up Date: "_$P(PRCAMCOM(PRCACCNT),U,3),PRCASTR,14,24)
 .. S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,PRCASTR)
 . S PRCALN=PRCALN+1 D SET^VALM10(PRCALN,"")
 . K ^UTILITY($J,"W")
 Q
