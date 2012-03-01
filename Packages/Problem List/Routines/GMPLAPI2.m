GMPLAPI2 ; / Problem List API - NEW,DELETE,VERIFY,VIEW DETAILED INFO,ADD NOTE ;02/27/12  12:00
 ;;TBD;Problem List;;02/27/2012
NEW(GMPDFN,GMPROV,GMPVAMC,GMPFLD,ERT) ; Save Collected Values in new Problem Entry
 ; Input
 ;  GMPDFN (R)   
 ;  GMPROV (R)  
 ;  GMPVAMC (R) 
 ;  GMPFLD (R)  
 ;  ERT         
 ; Output: IEN of PROBLEM file 
 I '$G(GMPDFN) D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPDFN") Q 0
 I '$G(GMPVAMC) D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPVAMC") Q 0 
 N DATA,DA,NUM,I,DIK,GMPIFN,TEMP,X,U,NOTES
 S U="^"
 I $P($G(GMPFLD(1.14)),U)="0" D
 . I '$D(GMPFLD(1.18)) S GMPFLD(1.18)=GMPFLD(1.14)
 . S GMPFLD(1.14)=""
 S:'$G(GMPFLD(.01)) GMPFLD(.01)=$$NOS^GMPLX
 S:$P(+GMPFLD(.01),U)=-1 GMPFLD(.01)=$$NOS^GMPLX ;chk for error from ICD
 S GMPFLD(.01)=+GMPFLD(.01) ;to remove text left by ?? lex (~)
 S:'$G(GMPFLD(1.01)) GMPFLD(1.01)="1^Unresolved"
 S:'$G(GMPFLD(.05)) X=$P($G(GMPFLD(.05)),U,2),GMPFLD(.05)=$$PROVNARR^GMPLX(X,+GMPFLD(1.01))
 S GMPIFN=$$CREATE^GMPLDAL(.GMPFLD,ERT)
 I $D(GMPFLD(10,"NEW"))>9 D 
 . M NOTES=GMPFLD(10,"NEW")
 . D NEWNOTE(GMPIFN,GMPROV,GMPVAMC,NOTES,ERT)
 Q GMPIFN
 ;
DELETE(GMPIFN,GMPROV,GMPVAMC,REASON,ERT) ; DELETE A PROBLEM
 ; GMPIFN   IEN of PROBLEM file
 ; GMPROV   pointer to NEW PERSON file
 ; GMPVAMC  pointer to LOCATION file
 ; REASON   comment
 ; ERT      Error array root
 N CHNGE
 I $G(GMPIFN)="" D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPIFN") Q 0 ; Invalid parameter value
 I '$$FIND1^DIC(9000011,,,"`"_GMPIFN) D ERR^GMPLAPIE(ERT,"PRBNOTFOUND") Q 0 ; Problem not found
 I $P($G(^AUPNPROB(GMPIFN,1)),U,2)="H" D ERR^GMPLAPIE(ERT,"PRBDELETED") Q 0 ; Already deleted
 ;I $G(GMPROV)="" D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPROV") Q 0 ; Invalid parameter value
 ;I '$$FIND1^DIC(200,,,"`"_GMPROV) D ERR^GMPLAPIE(ERT,"PROVNOTFOUND") Q 0 ; Unknown provider
 I $G(GMPVAMC)="" D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPVAMC") Q 0 ; Invalid parameter value
 I '$$FIND1^DIC(9999999.06,,,"`"_GMPVAMC) D ERR^GMPLAPIE(ERT,"FACNOTFOUND") Q 0 ; Unknown location
 I $G(REASON)'="" D NEWNOTE(GMPIFN,GMPROV,GMPVAMC,REASON,ERT)
 Q $$DELETE^GMPLDAL(GMPIFN,GMPROV,ERT)
 ;
NEWNOTE(GMPIFN,GMPROV,GMPVAMC,NOTES,ERT) ; Creates New Note Entries for Problem
 ; GMPIFN  Pointer to Problem
 ; GMPROV  Current Provider
 ; GMPVAMC Facility
 ; NOTES   Array of notes
 ; ERT     Errors array root
 N HDR,LAST,TOTAL,I,FAC,NIFN
 I '$D(NOTES) D ERR^GMPLIE(ERT,"INVALIDPARAM","NOTES") Q 0
 I $G(GMPIFN)="" D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPIFN") Q 0
 I '$$FIND1^DIC(9000011,,,"`"_GMPIFN) D ERR^GMPLAPIE(ERT,"PRBNOTFOUND") Q 0
 I $G(GMPVAMC)="" D ERR^GMPLAPIE(ERT,"INVALIDPARAM","GMPVAMC") Q 0
 I '$$FIND1^DIC(9999999.06,,,"`"_GMPVAMC) D ERR^GMPLAPIE(ERT,"FACNOTFOUND") Q 0
 I '$$LOCK^GMPLDAL(GMPIFN,11,ERT) Q 0
 S FAC=+$O(^AUPNPROB(GMPIFN,11,"B",GMPVAMC,0)) 
 I 'FAC D
 . S:'$D(^AUPNPROB(GMPIFN,11,0)) ^(0)="^9000011.11PA^^"
 . S HDR=^AUPNPROB(GMPIFN,11,0)
 . S LAST=$P(HDR,"^",3)
 . S TOTAL=$P(HDR,"^",4)
 . F I=(LAST+1):1 Q:'$D(^AUPNPROB(GMPIFN,11,I,0))
 . S ^AUPNPROB(GMPIFN,11,I,0)=GMPVAMC
 . S ^AUPNPROB(GMPIFN,11,"B",GMPVAMC,I)=""
 . S FAC=I
 . S $P(^AUPNPROB(GMPIFN,11,0),U,3,4)=FAC_"^"_(TOTAL+1)
 I FAC>0 D
 . S:'$D(^AUPNPROB(GMPIFN,11,FAC,11,0)) ^(0)="^9000011.1111IA^^"
 . S HDR=^AUPNPROB(GMPIFN,11,FAC,11,0)
 . S LAST=$P(HDR,U,3)
 . S TOTAL=$P(HDR,U,4)
 . F I=(LAST+1):1 Q:'$D(^AUPNPROB(GMPIFN,11,FAC,11,I,0))
 . S NIFN=I
 . F I=0:0 S I=$O(GMPFLD(10,"NEW",I)) Q:I'>0  D
 . . S ^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0)=NIFN_"^^"_GMPFLD(10,"NEW",I)_"^A^"_DT_U_+$G(GMPROV)
 . . S ^AUPNPROB(GMPIFN,11,FAC,11,"B",NIFN,NIFN)=""
 . . S TOTAL=TOTAL+1,LAST=NIFN,NIFN=NIFN+1
 . S $P(^AUPNPROB(GMPIFN,11,FAC,11,0),U,3,4)=LAST_U_TOTAL
 D UNLOCK^GMPLDAL(GMPIFN,11)
 Q 1
 ;
DETAIL(GMPIFN,GMPL) ; Returns Detailed Data for Problem
 ;                
 ; Input   GMPIFN  Pointer to Problem file #9000011
 ;                
 ; Output  GMPL Array, passed by reference
 ;         GMPL("DATA NAME") = External Format of Value
 ;
 ;         GMPL("DIAGNOSIS")  ICD Code
 ;         GMPL("PATIENT")    Patient Name
 ;         GMPL("MODIFIED")   Date Last Modified
 ;         GMPL("NARRATIVE")  Provider Narrative 
 ;         GMPL("ENTERED")    Date Entered ^ Entered by
 ;         GMPL("STATUS")     Status
 ;         GMPL("PRIORITY")   Priority Acute/Chronic
 ;         GMPL("ONSET")      Date of Onset
 ;         GMPL("PROVIDER")   Responsible Provider
 ;         GMPL("RECORDED")   Date Recorded ^ Recorded by
 ;         GMPL("CLINIC")     Hospital Location
 ;         GMPL("SC")         Service Connected SC/NSC/""
 ;
 ;         GMPL("EXPOSURE") = #
 ;         GMPL("EXPOSURE",X)="AGENT ORANGE"
 ;         GMPL("EXPOSURE",X)="RADIATION"
 ;         GMPL("EXPOSURE",X)="ENV CONTAMINANTS"
 ;         GMPL("EXPOSURE",X)="HEAD AND/OR NECK CANCER"
 ;         GMPL("EXPOSURE",X)="MILITARY SEXUAL TRAUMA"
 ;         GMPL("EXPOSURE",X)="COMBAT VET"
 ;         GMPL("EXPOSURE",X)="SHAD"
 ;
 ;         GMPL("COMMENT") = #
 ;         GMPL("COMMENT",CNT) = Date ^ Author ^ Text of Note
 ;              
 N GMPFLD,GMPLP,X,I,FAC,CNT,NIFN
 Q:'$$DETAIL^GMPLDAL(GMPIFN,.GMPFLD)
 S GMPLP=+($$PTR^GMPLUTL4)
 S GMPL("DIAGNOSIS")=$$ICD9NAME^GMPLEXT(GMPFLD(.01))
 S GMPL("PATIENT")=$$PATNAME^GMPLEXT(GMPFLD(.02))
 S GMPL("MODIFIED")=$$EXTDT^GMPLX(GMPFLD(.03))
 S GMPL("NARRATIVE")=$$PROBTEXT^GMPLX(GMPIFN)
 S GMPL("ENTERED")=$$EXTDT^GMPLX(GMPFLD(.08))_U_$$PROVNAME^GMPLEXT(GMPFLD(1.03))
 S GMPL("STATUS")=$S(GMPFLD(.12)="A":"ACTIVE",1:"INACTIVE")
 S X=$S(GMPFLD(.12)'="A":"",1:GMPFLD(1.14))
 S GMPL("PRIORITY")=$S(X="A":"ACUTE",X="C":"CHRONIC",1:"")
 S GMPL("ONSET")=$$EXTDT^GMPLX(GMPFLD(.13))
 S GMPL("PROVIDER")=$$PROVNAME^GMPLEXT(GMPFLD(1.05))
 S GMPL("RECORDED")=$$EXTDT^GMPLX(GMPFLD(1.09))_U_$$PROVNAME^GMPLEXT(GMPFLD(1.04))
 S GMPL("CLINIC")=$$CLINNAME^GMPLEXT(GMPFLD(1.08))
 S GMPL("SC")=$S(GMPFLD(1.10):"YES",GMPFLD(1.10)=0:"NO",1:"UNKNOWN")
 S GMPL("EXPOSURE")=0
 I GMPFLD(1.11) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="AGENT ORANGE",GMPL("EXPOSURE")=X
 I GMPFLD(1.12) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="RADIATION",GMPL("EXPOSURE")=X
 I GMPFLD(1.13) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="ENV CONTAMINANTS",GMPL("EXPOSURE")=X
 I GMPFLD(1.14) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="HEAD AND/OR NECK CANCER",GMPL("EXPOSURE")=X
 I GMPFLD(1.16) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="MILITARY SEXUAL TRAUMA",GMPL("EXPOSURE")=X
 I GMPFLD(1.17) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="COMBAT VET",GMPL("EXPOSURE")=X
 I GMPFLD(1.18)&(GMPLP'>0) S X=GMPL("EXPOSURE")+1,GMPL("EXPOSURE",X)="SHAD",GMPL("EXPOSURE")=X
 S (FAC,CNT)=0,GMPL("COMMENT")=0
 F FAC=0:0 S FAC=$O(^AUPNPROB(GMPIFN,11,FAC)) Q:+FAC'>0  D
 . F NIFN=0:0 S NIFN=$O(^AUPNPROB(GMPIFN,11,FAC,11,NIFN)) Q:NIFN'>0  D
 . . S X=$G(^AUPNPROB(GMPIFN,11,FAC,11,NIFN,0))
 . . S CNT=CNT+1,GMPL("COMMENT",CNT)=$$EXTDT^GMPLX($P(X,U,5))_U_$P($G(^VA(200,+$P(X,U,6),0)),U)_U_$P(X,U,3)
 S GMPL("COMMENT")=CNT D AUDIT^GMPLUTL2
 Q
 ;
VERIFY(GMPIFN,ERT) ; -- verify a transcribed problem
 I $$VERIFIED^GMPLDAL(GMPIFN) D ERR^GMPLAPIE(ERT,"PRBVERIFIED") Q 0 ; BAIL OUT - ALREADY VERIFIED
 Q:'$$LOCK^GMPLDAL(GMPIFN,0,ERT) 0
 D MKPERM^GMPLDAL(GMPIFN)
 D UNLOCK^GMPLDAL(GMPIFN,0)
 Q 1
 ;
