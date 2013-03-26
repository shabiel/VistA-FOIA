GMPLDAL ; RGI/CBR DATA ACCESS LAYER - DIRECT GLOBALS ACCESS ; 3/26/2013
 ;;2.0;Problem List;**260002**;Aug 25, 1994
CREATE(GMPDFN,GMPVAMC,GMPFLD,ERT) ; Create new problem
 N GMPIFN,NUM,DATA,I,DA,DIK
 S ERT=$G(ERT)
 S GMPIFN=$$NEWPROB(+GMPFLD(.01),+GMPDFN,ERT) Q:GMPIFN'>0 0
 S NUM=$$NEXTNMBR(+GMPDFN,+GMPVAMC)
 S:'NUM NUM=""
 ;   Set Node 0
 S DATA=^AUPNPROB(GMPIFN,0)_U_DT_"^^"_$P(GMPFLD(.05),U)_U_+GMPVAMC_U_+NUM_U_DT_"^^^^"_$P(GMPFLD(.12),U)_U_$P(GMPFLD(.13),U)
 S ^AUPNPROB(GMPIFN,0)=DATA
 ;   Set Node 1
 S DATA=$P(GMPFLD(1.01),U)
 F I=1.02:.01:1.18 S DATA=DATA_U_$P($G(GMPFLD(+I)),U)
 S ^AUPNPROB(GMPIFN,1)=DATA
 ;   Set X-Refs
 S DIK="^AUPNPROB(",DA=GMPIFN D IX1^DIK
 Q GMPIFN
 ;
NEWPROB(ICD,DFN,ERT) ; Creates New Problem Entry in file #9000011
 N HDR,LAST,TOTAL,DA
 S ERT=$G(ERT)
 Q:'$$LOCK(0,,ERT) -1
 ;L +^AUPNPROB(0):1 I '$T D  Q -1
 ;. W !!,"Someone else is currently editing this file."
 ;. W !,"Please try again later.",!
 S HDR=$G(^AUPNPROB(0)) Q:HDR="" -1
 S LAST=$P(HDR,U,3)
 S TOTAL=$P(HDR,U,4)
 F DA=(LAST+1):1 Q:'$D(^AUPNPROB(DA,0))
 S ^AUPNPROB(DA,0)=ICD_U_DFN
 S ^AUPNPROB("B",ICD,DA)=""
 S ^AUPNPROB("AC",DFN,DA)=""
 S $P(^AUPNPROB(0),U,3,4)=DA_U_(TOTAL+1)
 D UNLOCK(0)
 Q DA
 ;
UPDATE(GMPIFN,GMPORIG,GMPFLD,GMPLUSER,GMPROV,ERT) ; Updates a problem
 N DA,DR,DIE,FLD,NOW,AUDITED
 S AUDITED=0
 S DR="1.02////"_$S('+$G(GMPLUSER):"T",1:$P(GMPFLD(1.02),U))
 D:(GMPORIG(1.02)="T")&(GMPFLD(1.02)="P") AUDIT(GMPIFN,"1.02","T","P","Verified")
 I $P($G(GMPORIG(.12)),U)="I",$P(GMPFLD(.12),U)="A" D REACTV(GMPIFN,GMPROV) S AUDITED=1
 I +$G(GMPORIG(1.01))'=(+GMPFLD(1.01)) D REFORM(GMPIFN,GMPROV,GMPORIG(1.01),GMPFLD(1.01)) S AUDITED=1
 F FLD=.01,.05,.12,.13,1.01,1.05,1.06,1.07,1.08,1.09,1.1,1.11,1.12,1.13,1.14,1.15,1.16,1.17,1.18 D
 . Q:'$D(GMPFLD(FLD))  Q:$P($G(GMPORIG(FLD)),U)=$P($G(GMPFLD(FLD)),U)
 . S DR=DR_";"_FLD_"////"_$S($P(GMPFLD(FLD),U)'="":$P(GMPFLD(FLD),U),1:"@")
 . D:'AUDITED AUDIT(GMPIFN,FLD,$P(GMPORIG(FLD),U),$P(GMPFLD(FLD),U),"",+$G(GMPROV))
 S DA=GMPIFN
 S DIE="^AUPNPROB("
 D ^DIE
 Q 1
 ;
DELETE(GMPIFN,GMPROV,ERT) ; Delete a problem
 Q:'$$LOCK(GMPIFN,0,ERT) 0
 N OLD
 S OLD=$P($G(^AUPNPROB(GMPIFN,1)),U,2)
 D CHGCOND(GMPIFN,OLD,"H",GMPROV)
 D UNLOCK(GMPIFN,0)
 Q 1
 ;
DETAIL(GMPIFN,GMPFLD,ERT) ; Return problem details
 ;                
 ; Input   GMPIFN  Pointer to Problem file #9000011
 ;                
 ; Output  GMPFLD Array, passed by reference
 ;
 Q:'$D(^AUPNPROB(GMPIFN,0)) 0
 N GMPL0,GMPL1
 S GMPL0=$G(^AUPNPROB(GMPIFN,0))
 S GMPL1=$G(^(1))
 S GMPFLD(.01)=+$P(GMPL0,U)
 S GMPFLD(.02)=+$P(GMPL0,U,2)
 S GMPFLD(.03)=$P(GMPL0,U,3)
 ;S GMPFLD(.05)=$$PROBTEXT^GMPLX(GMPIFN)
 S GMPFLD(.08)=$P(GMPL0,U,8) ;_U_$P($G(^VA(200,+$P(GMPL1,U,3),0)),U)
 S GMPFLD(.12)=$P(GMPL0,U,12) ;,GMPL("STATUS")=$S(X="A":"ACTIVE",1:"INACTIVE")
 ;S X=$S(X'="A":"",1:$P(GMPL1,U,14)),GMPL("PRIORITY")=$S(X="A":"ACUTE",X="C":"CHRONIC",1:"")
 S GMPFLD(.13)=$P(GMPL0,U,13)
 S GMPFLD(1.02)=$P(GMPL1,U,2)
 S GMPFLD(1.03)=$P(GMPL1,U,3)
 S GMPFLD(1.04)=$P(GMPL1,U,4)
 S GMPFLD(1.05)=$P(GMPL1,U,5)
 S GMPFLD(1.06)=$P(GMPL1,U,6)
 S GMPFLD(1.08)=$P(GMPL1,U,8)
 S GMPFLD(1.09)=$P(GMPL1,U,9)
 S GMPFLD(1.10)=$P(GMPL1,U,10)
 S GMPFLD(1.11)=$P(GMPL1,U,11) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="AGENT ORANGE",GMPL("EXPOSURE")=X
 S GMPFLD(1.12)=$P(GMPL1,U,12) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="RADIATION",GMPL("EXPOSURE")=X
 S GMPFLD(1.13)=$P(GMPL1,U,13) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="ENV CONTAMINANTS",GMPL("EXPOSURE")=X
 S GMPFLD(1.14)=$P(GMPL1,U,14)
 S GMPFLD(1.15)=$P(GMPL1,U,15) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="HEAD AND/OR NECK CANCER",GMPL("EXPOSURE")=X
 S GMPFLD(1.16)=$P(GMPL1,U,16) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="MILITARY SEXUAL TRAUMA",GMPL("EXPOSURE")=X
 S GMPFLD(1.17)=$P(GMPL1,U,17) ;S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="COMBAT VET",GMPL("EXPOSURE")=X
 S GMPFLD(1.18)=$P(GMPL1,U,18) ;&(GMPLP'>0) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="SHAD",GMPL("EXPOSURE")=X
 Q 1
 ;
VERIFIED(GMPIFN) ; True if problem already verified
 Q $P($G(^AUPNPROB(GMPIFN,1)),U,2)'="T"
 ;
MKPERM(GMPIFN) ; Make a problem PERMANENT
 D CHGCOND(GMPIFN,"T","P")
 Q
 ;
CHGCOND(GMPIFN,OLD,NEW,GMPROV) ; Change condition flag
 N AUDMSG
 S GMPROV=$G(GMPROV,DUZ)
 S $P(^AUPNPROB(GMPIFN,1),U,2)=NEW
 S AUDMSG=""
 S:(NEW="H") AUDMSG="Deleted"
 S:(OLD="T")&(NEW="P") AUDMSG="Verified"
 S:(OLD="H")&(NEW="P") AUDMSG="Replaced"
 D AUDIT(GMPIFN,1.02,OLD,NEW,AUDMSG,+GMPROV)
 D DTMOD(GMPIFN)
 Q
 ;
LOCK(GMPIFN,SUB,ERT,TIMEOUT) ;
 N LOCKED
 S TIMEOUT=$G(TIMEOUT,1)
 I '$D(SUB) L +^AUPNPROB(GMPIFN):TIMEOUT S LOCKED=$T
 I $D(SUB) L +^AUPNPROB(GMPIFN,SUB):TIMEOUT S LOCKED=$T
 I 'LOCKED,$G(ERT)'="" D ERR^GMPLAPIE(ERT,"FILELOCK")
 Q LOCKED
 ;
UNLOCK(GMPIFN,SUB) ;
 L:'$D(SUB) -^AUPNPROB(GMPIFN)
 L:$D(SUB) -^AUPNPROB(GMPIFN,SUB)
 Q
 ;
AUDIT(GMPIFN,FIELD,ORIGVAL,CRTVAL,NOTE,GMPROV,OLD) ;
 N DA,DD,DO,DIC,X,Y,DIK,DLAYGO,DATA
 S:$G(GMPROV)="" GMPROV=DUZ
 S X=$G(GMPIFN)
 S DIC="^GMPL(125.8,"
 S DIC(0)="L"
 S DLAYGO=125.8
 D FILE^DICN
 Q:+Y'>0
 S DA=+Y,DIK="^GMPL(125.8,"
 S DATA=X_U_$G(FIELD)_U_$$HTFM^XLFDT($H)_U_DUZ_U_$G(ORIGVAL)_U_$G(CRTVAL)_U_$G(NOTE)_U_GMPROV
 S ^GMPL(125.8,DA,0)=DATA
 D IX1^DIK
 S:$G(OLD)'="" ^GMPL(125.8,DA,1)=OLD
 Q
 ;
DTMOD(GMPIFN) ; Update Date Last Modified
 N DIE,DR,DA
 S DA=GMPIFN
 S DR=".03///TODAY"
 S DIE="^AUPNPROB("
 D ^DIE
 Q
 ;
NOTE(GMPIFN,FAC,NIFN) ;Return note text or "" if not found
 Q $P($G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0)),U,3)
 ;
UPDNOTE(GMPIFN,FAC,NIFN,TEXT,GMPROV) ;
 N NODE,OLDTEXT
 S NODE=$G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0))
 S OLDTEXT=$P(NODE,U,3)
 S $P(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0),U,3)=TEXT
 D AUDIT(GMPIFN,"1101","C","","Note Modified",GMPROV,NODE)
 Q
 ;
DELNOTE(GMPIFN,FAC,NIFN,GMPROV) ;
 N DA,DIK,NODE
 S NODE=$G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0))
 S DIK="^AUPNPROB("_GMPIFN_",11,"_FAC_",11,"
 S DA(2)=GMPIFN
 S DA(1)=FAC
 S DA=NIFN
 D ^DIK
 D AUDIT(GMPIFN,"1101","A","","Deleted Note",+$G(GMPROV),NODE)
 Q
 ;
GNOTES(GMPIFN,GMPLNOTE,ERT) ;
 N FAC,NIFN,CNT
 S CNT=0
 S GMPLNOTE=0
 F FAC=0:0 S FAC=$O(^AUPNPROB(GMPIFN,11,FAC)) Q:+FAC'>0  D
 . F NIFN=0:0 S NIFN=$O(^AUPNPROB(GMPIFN,11,FAC,11,NIFN)) Q:NIFN'>0  D
 . . S X=$G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0))
 . . S CNT=CNT+1
 . . S GMPL("COMMENT",CNT)=$$EXTDT^GMPLX($P(X,U,5))_U_$$PROVNAME^GMPLEXT(+$P(X,U,6))_U_$P(X,U,3)
 S GMPL("COMMENT")=CNT
 Q
 ;
GETPLIST(PLIST,TOTAL,GMPDFN,GMPSTAT,GMPREV,GMPROV,GMPVIEW,GMPIDX) ; Build PLIST(#)=IFN for view
 N SHOWDEL,ST,STEND,IFN,RECORD,LIST,JUSTDEL,CNT,DATE
 K PLIST
 S GMPSTAT=$G(GMPSTAT)
 S GMPREV=+$G(GMPREV)
 S GMPROV=+$G(GMPROV)
 S GMPVIEW=$G(GMPVIEW)
 S GMPIDX=+$G(GMPIDX)
 S:GMPSTAT="" GMPSTAT="AI"
 S SHOWDEL=GMPSTAT["R"
 S JUSTDEL=GMPSTAT="R"
 S:GMPSTAT="R" GMPSTAT="AIR"
 S ST=$S(GMPSTAT'["A":"A",1:"")
 S STEND=$S(GMPSTAT'["I":"I",1:"")
 S TOTAL=0
 F  S ST=$O(^AUPNPROB("ACTIVE",+GMPDFN,ST)) Q:(ST="")!(ST=STEND)  D
 . F IFN=0:0 S IFN=$O(^AUPNPROB("ACTIVE",+GMPDFN,ST,IFN)) Q:IFN'>0  D
 . . S RECORD=$G(^AUPNPROB(IFN,1)) Q:'$L(RECORD)
 . . Q:'SHOWDEL&($P(RECORD,U,2)="H")
 . . Q:JUSTDEL&($P(RECORD,U,2)'="H")
 . . S TOTAL=TOTAL+1
 . . I $L(GMPVIEW)>2,GMPVIEW'[("/"_$P(RECORD,U,$S($E(GMPVIEW)="S":6,1:8))_"/") Q
 . . I GMPROV,$P(RECORD,U,5)'=+GMPROV Q
 . . S DATE=$P(RECORD,U,9) S:'DATE DATE=$P($G(^AUPNPROB(IFN,0)),U,8)
 . . S:GMPREV DATE=9999999-DATE
 . . S LIST(ST,DATE,IFN)=""
 S ST="",CNT=0
 F  S ST=$O(LIST(ST)) Q:ST=""  D
 . S DATE="" F  S DATE=$O(LIST(ST,DATE)) Q:DATE=""  D
 . . S IFN="" F  S IFN=$O(LIST(ST,DATE,IFN)) Q:IFN=""  D
 . . . S CNT=CNT+1
 . . . S PLIST(CNT)=IFN
 . . . S:$G(GMPIDX) PLIST("B",IFN)=CNT
 S PLIST(0)=CNT
 Q
 ;
REFORM(GMPIFN,GMPROV,OLDPRB,NEWPRB) ; Audit Entry that has been Reformulated
 N NODE
 S NODE=$G(^AUPNPROB(GMPIFN,0))_U_$G(^AUPNPROB(GMPIFN,1))
 D AUDIT(GMPIFN,1.01,+OLDPRB,+NEWPRB,"Reformulated",+GMPROV,NODE)
 Q
 ;
REACTV(GMPIFN,GMPROV) ; Audit Entry that has been Reactivated
 N NODE
 S NODE=$G(^AUPNPROB(GMPIFN,0))_U_$G(^AUPNPROB(GMPIFN,1))
 D AUDIT(GMPIFN,.12,"I","A","Reactivated",GMPROV,NODE)
 Q
 ;
REPLACE(GMPIFN,OLD,NEW) ; Replace ICD diagnosis
 N DIE,DA,DR
 S DIE="^AUPNPROB("
 S DA=GMPIFN
 S DR=".01////"_+NEW
 D ^DIE
 D AUDIT(GMPIFN,".01",OLD,NEW)
 Q
 ;
NEXTNMBR(DFN,VAMC) ; Returns Next Available Problem Number
 N I,J,NUM S NUM=1,I="" I '$D(^AUPNPROB("AA",DFN,VAMC)) Q NUM
 F  S I=$O(^AUPNPROB("AA",DFN,VAMC,I)) Q:I=""  S J=$E(I,2,999),NUM=+J
 S NUM=NUM+1
 Q NUM
ONSET(GMPIFN) ; Returns the date of onset
 Q $P($G(^AUPNPROB(GMPIFN,0)),U,13)
ACTIVE(GMPIFN) ; Is problem active?
 Q $P($G(^AUPNPROB(GMPIFN,0)),U,12)="A"
DELETED(GMPIFN) ;Is problem deleted?
 Q $P($G(^AUPNPROB(GMPIFN,1)),U,2)="H"
EXISTS(GMPIFN) ;Is ifn defined?
 Q $D(^AUPNPROB(GMPIFN,0))
DIAG(GMPIFN) ;Return diagnosis
 Q $P(^AUPNPROB(GMPIFN,0),U)
INACTV(GMPIFN,RESOLVED) ;Inactivate problem
 N DIE,DA,DR
 S DIE="^AUPNPROB(",DR=".12///I;1.07////"_$P($G(RESOLVED),U)
 S DA=GMPIFN D ^DIE
 D AUDIT(GMPIFN,".12","A","I","Inactivated",+$G(GMPROV))
 D DTMOD(GMPIFN)
 Q
TERMEXST(TERM) ;
 Q $D(^AUPNPROB("C",TERM))
AUPNEXST() ;
 Q $D(^AUPNPROB)
 ;
