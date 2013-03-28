GMPLAPI2 ; RGI/CBR Problem List API - NEW,DELETE,VERIFY,VIEW DETAILED INFO,ADD NOTE ;3/26/13
 ;;2.0;Problem List;**260002**;Aug 25,1994
NEW(RETURN,GMPDFN,GMPROV,GMPFLD,GMPLUSER) ; Save Collected Values in new Problem Entry
 ; Input
 ;  RETURN (R)  Passed by reference. Returns GMPIFN. On fail RETURN(1)=error message
 ;  GMPDFN (R)   
 ;  GMPROV (R)  
 ;  GMPFLD (R)  
 ; Output: 1=SUCCESS,0=FAIL
 S RETURN=0
 I '$$PATIEN^GMPLCHK(.RETURN,.GMPDFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPLUSER,"GMPLUSER") Q 0
 I '$$VLDFLD(.RETURN,.GMPFLD) Q 0
  ;Defaults
 N GMPIFN,GMPLNOW,NOTES,%,ICD,NIEN,NARR,I,ERR
 S GMPLNOW=$$NOW^XLFDT
 S GMPFLD(.08)=GMPLNOW_U_$$EXTDT^GMPLX(GMPLNOW)
 S:$G(GMPFLD(.12))="" GMPFLD(.12)="A^ACTIVE"
 S GMPFLD(1.02)=$S('$$VERIFY^GMPLSITE:"P",+$G(GMPLUSER):"P",1:"T")
 S GMPFLD(1.03)=DUZ
 ;Save
 S GMPIFN=$$CREATE^GMPLDAL(GMPDFN,$$GMPVAMC,.GMPFLD,"RETURN")
 Q:GMPIFN'>0 0
 I $D(GMPFLD(10,"NEW"))>9 D 
 . M NOTES=GMPFLD(10,"NEW")
 . S %=$$NEWNOTE^GMPLAPI3(.RETURN,GMPIFN,GMPROV,.NOTES)
 S RETURN=GMPIFN
 Q 1
 ;
UPDATE(RETURN,GMPIFN,GMPFLD,GMPLUSER,GMPROV) ; Save Changes made to Existing Problem
 ; GMPIFN
 ; GMPFLD
 ; GMPLUSER
 ; GMPROV
 N I,TEXT,OLDTEXT,NOTES,GMPSAVED,%,GMPORIG
 S RETURN=-1
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPLUSER,"GMPLUSER") Q 0
 I '$$VLDFLD(.RETURN,.GMPFLD) Q 0
 I '$$DETAIL(.GMPORIG,GMPIFN,GMPROV) Q 0
 S:'GMPORIG(1.01) GMPORIG(1.01)="1^Unresolved"
 S GMPSAVED=$$UPDATE^GMPLDAL(GMPIFN,.GMPORIG,.GMPFLD,GMPLUSER,GMPROV,"RETURN")
 ; Save Changes to Notes
 F I=0:0 S I=$O(GMPORIG(10,I)) Q:I'>0  D
 . Q:GMPORIG(10,I)=$G(GMPFLD(10,I))
 . S %=$$UPDNOTE^GMPLAPI3(.RETURN,GMPIFN,$G(GMPFLD(10,I)),GMPROV)
 I $D(GMPFLD(10,"NEW"))>9 D 
 . M NOTES=GMPFLD(10,"NEW")
 . S %=$$NEWNOTE^GMPLAPI3(.RETURN,GMPIFN,GMPROV,.NOTES)
 ; Quit Saving Changes
 D:GMPSAVED DTMOD^GMPLDAL(GMPIFN)
 S:GMPSAVED RETURN=GMPIFN
 Q GMPSAVED
 ;
DELETE(RETURN,GMPIFN,GMPROV,REASON) ; DELETE A PROBLEM
 ; Input   GMPIFN   IEN of PROBLEM file
 ;         GMPROV   pointer to NEW PERSON file
 ;         REASON   comment
 N DELETED,%,VALID
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S %=$$DELETED(.DELETED,GMPIFN)
 I DELETED D ERRX^GMPLAPIE(.RETURN,"PRBDLTD") Q 0 ; Already deleted
 I '$$PROVIEN^GMPLCHK(.RETURN,$P($G(GMPROV),U)) Q 0
 I $G(REASON)'="" S %=$$NEWNOTE^GMPLAPI3(.RETURN,GMPIFN,+GMPROV,$G(REASON))
 S RETURN=$$DELETE^GMPLDAL(GMPIFN,GMPROV,"RETURN")
 Q RETURN
 ;
DETAIL(RETURN,GMPIFN,GMPROV) ; 
 N DIC,DIQ,DR,I,CNT,EXT,FOUND,NOTES
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV,,1) Q 0
 S FOUND=$$DETAIL^GMPLDALF(GMPIFN,.RETURN,"")
 Q:'FOUND 0
 F I=.03,.08,.13,1.07,1.09 S $P(RETURN(I),U,2)=$$EXTDT^GMPLX($P(RETURN(I),U))
 S RETURN(1.11)=+$P(RETURN(1.11),U)_U_$S($P(RETURN(1.11),U):"AGENT ORANGE",1:"")
 S RETURN(1.12)=+$P(RETURN(1.12),U)_U_$S($P(RETURN(1.12),U):"RADIATION",1:"")
 S RETURN(1.13)=+$P(RETURN(1.13),U)_U_$S($P(RETURN(1.13),U):"ENV CONTAMINANTS",1:"")
 S RETURN(1.15)=+$P(RETURN(1.15),U)_U_$S($P(RETURN(1.15),U):"HEAD/NECK CANCER",1:"")
 S RETURN(1.16)=+$P(RETURN(1.16),U)_U_$S($P(RETURN(1.16),U):"MIL SEXUAL TRAUMA",1:"")
 S RETURN(1.17)=+$P(RETURN(1.17),U)_U_$S($P(RETURN(1.17),U):"COMBAT VET",1:"")
 S RETURN(1.18)=+$P(RETURN(1.18),U)_U_$S($P(RETURN(1.18),U):"SHAD",1:"")
 ;COMMENTS
 D NOTES^GMPLDAL3(.NOTES,GMPIFN,3,,$$GMPVAMC,.GMPROV)
 S (RETURN(10),RETURN(10,0))=NOTES
 I NOTES>0 M RETURN(10)=NOTES
 Q 1
 ;
DETAILX(RETURN,GMPIFN,GMPMULTI) ; Returns Formatted Detailed Data for Problem
 ;                
 ; Input   GMPIFN  Pointer to Problem file #9000011
 ;         GMPMULTI Multi divisional
 ; Output  RETURN Array, passed by reference
 ;         RETURN("DATA NAME") = External Format of Value
 ;
 ;         RETURN("DIAGNOSIS")  ICD Code
 ;         RETURN("PATIENT")    Patient Name
 ;         RETURN("MODIFIED")   Date Last Modified
 ;         RETURN("NARRATIVE")  Provider Narrative 
 ;         RETURN("ENTERED")    Date Entered ^ Entered by
 ;         RETURN("STATUS")     Status
 ;         RETURN("PRIORITY")   Priority Acute/Chronic
 ;         RETURN("ONSET")      Date of Onset
 ;         RETURN("PROVIDER")   Responsible Provider
 ;         RETURN("RECORDED")   Date Recorded ^ Recorded by
 ;         RETURN("CLINIC")     Hospital Location
 ;         RETURN("SC")         Service Connected SC/NSC/""
 ;
 ;         RETURN("EXPOSURE") = #
 ;         RETURN("EXPOSURE",X)="AGENT ORANGE"
 ;         RETURN("EXPOSURE",X)="RADIATION"
 ;         RETURN("EXPOSURE",X)="ENV CONTAMINANTS"
 ;         RETURN("EXPOSURE",X)="HEAD AND/OR NECK CANCER"
 ;         RETURN("EXPOSURE",X)="MILITARY SEXUAL TRAUMA"
 ;         RETURN("EXPOSURE",X)="COMBAT VET"
 ;         RETURN("EXPOSURE",X)="SHAD"
 ;
 ;         RETURN("COMMENT") = #
 ;         RETURN("COMMENT",CNT) = Date ^ Author ^ Text of Note
 ;              
 N GMPFLD,GMPLP,X,I,CNT,NOTES
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPMULTI,"GMPMULTI") Q 0
 S GMPFLD=""
 S GMPMULTI=+$G(GMPMULTI,1)
 Q:'$$DETAIL(.GMPFLD,GMPIFN) 0
 S RETURN("DIAGNOSIS")=$P(GMPFLD(.01),U,2)
 S RETURN("PATIENT")=$P(GMPFLD(.02),U,2)
 S RETURN("MODIFIED")=$P(GMPFLD(.03),U,2)
 S RETURN("NARRATIVE")=$$PROBTEXT^GMPLX(GMPIFN)
 S RETURN("ENTERED")=$P(GMPFLD(.08),U,2)_U_$P(GMPFLD(1.03),U,2)
 S RETURN("STATUS")=$P(GMPFLD(.12),U,2)
 S X=$S($P(GMPFLD(.12),U)'="A":"",1:$P(GMPFLD(1.14),U))
 S RETURN("PRIORITY")=$S(X="A":"ACUTE",X="C":"CHRONIC",1:"")
 S RETURN("ONSET")=$P(GMPFLD(.13),U,2)
 S RETURN("CONDITION")=$P(GMPFLD(1.02),U,2)
 S RETURN("PROVIDER")=$P(GMPFLD(1.05),U,2)
 S RETURN("SERVICE")=$P(GMPFLD(1.06),U,2)
 S RETURN("RESOLVED")=$P(GMPFLD(1.07),U,2)
 S RETURN("RECORDED")=$P(GMPFLD(1.09),U,2)_U_$P(GMPFLD(1.04),U,2)
 S RETURN("CLINIC")=$P(GMPFLD(1.08),U,2)
 S RETURN("SC")=$S($P(GMPFLD(1.10),U)'="":$P(GMPFLD(1.10),U,2),1:"UNKNOWN")
 S RETURN("EXPOSURE")=0
 F I=1.11,1.12,1.13,1.15,1.16,1.17,1.18 I GMPFLD(I) D
 . S X=RETURN("EXPOSURE")+1
 . S RETURN("EXPOSURE",X)=$P(GMPFLD(I),U,2)
 . S RETURN("EXPOSURE")=X
 ;NOTES
 D NOTES^GMPLDAL3(.NOTES,GMPIFN,2,0,$S(GMPMULTI:"",1:$$GMPVAMC))
 S RETURN("COMMENT")=NOTES
 I NOTES>0 M RETURN("COMMENT")=NOTES
 ;HISTORY
 N HIST
 D GETHIST^GMPLDAL2(.HIST,GMPIFN)
 S CNT=0
 I $D(HIST) D
 . M RETURN("HISTORY")=HIST
 . S CNT=$O(HIST(""),-1)
 S RETURN("HISTORY")=CNT
 Q 1
 ;
VERIFY(RETURN,GMPIFN) ; Verify a transcribed problem
 ;
 ; Input   GMPIFN  Pointer to Problem file #9000011
 ;
 ; Output 
 N INACTV
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$CODESTS(.INACTV,GMPIFN,DT) D ERRX^GMPLAPIE(.RETURN,"ICDINACT") Q 0
 I $$VERIFIED^GMPLDAL(GMPIFN) D ERRX^GMPLAPIE(.RETURN,"PRBVRFD") Q 0 ; BAIL OUT - ALREADY VERIFIED
 Q:'$$LOCK^GMPLDAL(GMPIFN,0,"RETURN") 0
 D MKPERM^GMPLDAL(GMPIFN)
 D UNLOCK^GMPLDAL(GMPIFN,0)
 S RETURN=1
 Q 1
 ;
DUPL(RETURN,GMPDFN,TERM,TEXT,GMPBOTH) ; Check's for Duplicate Entries
 N IFN,DUPTERM,DUPTEXT,PLIST,TOTAL,I,DET,%,TMPL
 S RETURN=0,TEXT=$$UP^XLFSTR($G(TEXT))
 I '$$PATIEN^GMPLCHK(.RETURN,.GMPDFN) Q 0
 I '$$TERMIEN^GMPLCHK(.RETURN,.TERM) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPBOTH,"GMPBOTH") Q 0
 S GMPBOTH=+$G(GMPBOTH)
 D GETPLIST^GMPLDAL(.PLIST,.TOTAL,GMPDFN,"AI")
 Q:PLIST(0)=0 1
 F I=1:1:PLIST(0) S TMPL(PLIST(I))=""
 S IFN=0
 F  S IFN=$O(TMPL(IFN)) D  Q:(IFN="")!(RETURN>0)
 . S (DUPTERM,DUPTEXT)=0
 . S %=$$DETAIL(.DET,IFN)
 . I TERM>1 S:+DET(1.01)=TERM DUPTERM=1
 . S:TEXT=$$UP^XLFSTR($$NARR^GMPLEXT(+DET(.05))) DUPTEXT=1
 . I GMPBOTH,DUPTERM&DUPTEXT S RETURN=IFN Q
 . I 'GMPBOTH,DUPTERM!DUPTEXT S RETURN=IFN Q
 Q 1
 ;
CODESTS(RETURN,GMPIFN,ADATE) ;check status of code associated with a problem
 ; Input:
 ;    GMPIFN  = pointer to the PROBLEM (#9000011) file
 ;    ADATE = FM date on which to check the status of ICD9 code  (opt.) 
 ;
 ; Output:
 ;   1  = ACTIVE on the date passed or current date if not passed
 ;   0  = INACTIVE on the date passed or current date if not passed
 ;
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$DTIME^GMPLCHK(.RETURN,.ADATE,1) Q 0
 I $G(ADATE)="" S ADATE=$$NOW^XLFDT
 S GMPIFN=$$DIAG^GMPLDAL(GMPIFN)
 S RETURN=+($$STATCHK^ICDAPIU($$CODEC^ICDCODE(+(GMPIFN)),ADATE))
 Q RETURN
 ;
DELETED(RETURN,GMPIFN) ; RETURN=1 if problem is deleted
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$DELETED^GMPLDAL(GMPIFN)
 Q 1
 ;
VERIFIED(RETURN,GMPIFN) ; RETURN=1 if problem is not transcribed
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$VERIFIED^GMPLDAL(GMPIFN)
 Q 1
 ;
ACTIVE(RETURN,GMPIFN) ; RETURN=1 if problem is ACTIVE
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$ACTIVE^GMPLDAL(GMPIFN)
 Q 1
 ;
ONSET(RETURN,GMPIFN) ; Returns the date of onset
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$ONSET^GMPLDAL(GMPIFN)
 Q 1
 ;
INACTV(RETURN,GMPIFN,GMPROV,NOTE,RESOLVED) ; Inactivate problem
 N DA,DR,DIE,DELETED,ACTIVE,%,CHNGE
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV) Q 0
 I '$$DTIME^GMPLCHK(.RETURN,.RESOLVED,1) Q 0
 S %=$$ACTIVE(.ACTIVE,GMPIFN)
 I 'ACTIVE D ERRX^GMPLAPIE(.RETURN,"PRBINACT"," ("_$$PROBTEXT^GMPLX(GMPIFN)_")") Q 0
 S %=$$DELETED(.DELETED,GMPIFN)
 I DELETED D ERRX^GMPLAPIE(.RETURN,"PRBDLTD"," ("_$$PROBTEXT^GMPLX(GMPIFN)_")") Q 0
 S:$G(NOTE)'="" %=$$NEWNOTE^GMPLAPI3(.RETURN,GMPIFN,GMPROV,NOTE)
 D INACTV^GMPLDAL(GMPIFN,$P($G(RESOLVED),U))
 S RETURN=1
 Q RETURN
 ;
GMPVAMC() ;
 Q +$G(DUZ(2))
GLBINST() ;^AUPNPROB is installed?
 Q $$AUPNEXST^GMPLDAL()
 ;
VLDFLD(RETURN,GMPFLD) ;Internal entry to validate and set defaults to GMPFLD
 N GMPIFN,NOTES,%,ICD,NIEN,NARR,I,ERR
 ;Validate GMPFLD
 ;ICD9
 I $D(GMPFLD)<10 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPFLD") Q 0
 S ICD=$P($G(GMPFLD(.01)),U)
 I ICD=-1 S GMPFLD(.01)=$$NOS^GMPLEXT ;chk for error from ICD
 I '$$ICDCODE^GMPLCHK(.RETURN,ICD,"GMPFLD(.01)",1) Q 0
 I ICD="" S GMPFLD(.01)=$$NOS^GMPLEXT
 ;Lexicon text
 I '$$TERMIEN^GMPLCHK(.RETURN,$P($G(GMPFLD(1.01)),U),"GMPFLD(1.01)",1) Q 0
 I '$G(GMPFLD(1.01)) S GMPFLD(1.01)="1^Unresolved"
 ;Provider narrative
 S NIEN=$P($G(GMPFLD(.05)),U),NARR=$P($G(GMPFLD(.05)),U,2)
 I NIEN="",NARR="" D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPFLD(.05)") Q 0
 I NIEN'="",'$$NARREXST^GMPLEXT(NIEN) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPFLD(.05)") Q 0
 I NIEN="" S GMPFLD(.05)=$$PROVNARR^GMPLEXT(NARR,+GMPFLD(1.01))
 ;Status
 I '$$CODESET^GMPLCHK(.RETURN,$P($G(GMPFLD(.12)),U),"GMPFLD(.12)","AI",1,0) Q 0
 I '$$SVCIEN^GMPLCHK(.RETURN,$P($G(GMPFLD(1.06)),U),"GMPFLD(1.06)",1) Q 0
 I '$$SCIEN^GMPLCHK(.RETURN,$P($G(GMPFLD(1.08)),U),"GMPFLD(1.08)",1) Q 0
 S ERR=0
 F I=.13,1.07,1.09 I '$$DTIME^GMPLCHK(.RETURN,$P($G(GMPFLD(I)),U),1) S ERR=1 Q
 I ERR Q 0
 F I=1.04,1.05 I '$$PROVIEN^GMPLCHK(.RETURN,$P($G(GMPFLD(I)),U),"GMPFLD("_I_")",1) S ERR=1 Q
 I ERR Q 0
 F I=1.1:.01:1.13 I '$$BOOL^GMPLCHK(.RETURN,$P($G(GMPFLD(I)),U),"GMPFLD("_I_")") S ERR=1 Q
 I ERR Q 0
 F I=1.15:.01:1.18 I '$$BOOL^GMPLCHK(.RETURN,$P($G(GMPFLD(I)),U),"GMPFLD("_I_")") S ERR=1 Q
 I ERR Q 0
 I $P($G(GMPFLD(1.14)),U)="0" D
 . I '$D(GMPFLD(1.18)) S GMPFLD(1.18)=GMPFLD(1.14)
 . S GMPFLD(1.14)=""
 I '$$CODESET^GMPLCHK(.RETURN,$P($G(GMPFLD(1.14)),U),"GMPFLD(1.14)","AC",1,0) Q 0
 Q 1
