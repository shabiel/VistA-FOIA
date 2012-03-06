GMPL1 ; SLC/MKB/AJB -- Problem List actions ; 04/22/03
 ;;2.0;Problem List;**3,20,28**;Aug 25, 1994
 ; 10 MAR 2000 - MA - Added to the routine another user prompt
 ; to backup and refine Lexicon search if ICD code 799.9
ADD ;add new entry to list - Requires GMPDFN
 N GMPROB,GMPTERM,GMPICD,Y,DUP,GMPIFN,GMPFLD
 W !
 S GMPROB=$$TEXT^GMPLEDT4("") I GMPROB="^" S GMPQUIT=1 Q
 I 'GMPARAM("CLU")!('$D(GMPLUSER)&('$D(^XUSEC("GMPL ICD CODE",DUZ)))) S GMPTERM="",GMPICD="799.9" G ADD1
 F  D  Q:$D(GMPQUIT)!(+$G(Y))
 . D SEARCH^GMPLX(.GMPROB,.Y,"PROBLEM: ","1")
 . I +Y'>0 S GMPQUIT=1 Q
 . S DUP=$$DUPL^GMPLAPI2(+GMPDFN,+Y,GMPROB)
 . I DUP,'$$DUPLOK^GMPLX(DUP) S (Y,GMPROB)=""
 . I +Y=1 D ICDMSG
 Q:$D(GMPQUIT)
 S GMPTERM=$S(+$G(Y)>1:Y,1:""),GMPICD=$G(Y(1))
 S:'$L(GMPICD) GMPICD="799.9"
ADD1 ; set up default values
 ; -- May enter here with GMPROB=text,GMPICD=code,GMPTERM=#^term
 ; added for Code Set Versioning (CSV)
 I '+$$STATCHK^ICDAPIU(GMPICD,DT) W !,GMPROB,!,"has an inactive code.  Please edit before adding." H 3 Q
 N OK,GMPI,GMPFLD
 K GMPLJUMP
 S GMPFLD(1.01)=GMPTERM,GMPFLD(.05)=U_GMPROB
 S GMPFLD(.01)=$$ICD9KEY^GMPLEXT(GMPICD)_U_GMPICD
 S:'GMPFLD(.01) GMPFLD(.01)=$$NOS^GMPLEXT ; cannot resolve code
 S (GMPFLD(1.04),GMPFLD(1.05))=$G(GMPROV),GMPFLD(1.03)=DUZ
 S GMPFLD(1.06)=$$SERVICE^GMPLEXT(+GMPFLD(1.04)),GMPFLD(1.08)=$G(GMPCLIN)
 S (GMPFLD(.08),GMPFLD(1.09))=DT_U_$$EXTDT^GMPLX(DT)
 S GMPFLD(.12)="A^ACTIVE",GMPFLD(1.14)="",GMPFLD(10,0)=0
 S GMPFLD(1.02)=$S('$G(GMPARAM("VER")):"P",$D(GMPLUSER):"P",1:"T")
 S (GMPFLD(.13),GMPFLD(1.07))="" ; initialize dates
 S GMPFLD(1.1)=$S('GMPSC:"0^NO",1:""),GMPFLD(1.11)=$S('GMPAGTOR:"0^NO",1:"")
 S GMPFLD(1.12)=$S('GMPION:"0^NO",1:""),GMPFLD(1.13)=$S('GMPGULF:"0^NO",1:"")
ADD2 ; prompt for values
 D FLDS^GMPLEDT3 ; set GMPFLD("FLD") of editable fields
 F GMPI=2:1:7 D @(GMPFLD("FLD",GMPI)_"^GMPLEDT1") Q:$D(GMPQUIT)  K GMPLJUMP ; cannot ^-jump here
 Q:$D(GMPQUIT)
ADD3 ; Ok to save?
 S OK=$$ACCEPT^GMPLDIS1(.GMPFLD),GMPLJUMP=0 ; ok to save values?
 I OK="^" W !!?10,"< Nothing Saved !! >",! S GMPQUIT=1 H 1 Q
 I OK D  Q  ; ck DA for error?
 . N I W !!,"Saving ..." S GMPIFN=$$NEW^GMPLAPI2(GMPDFN,GMPROV,GMPVAMC,.GMPFLD,"GMPERR")
 . I GMPIFN'>0 W $$FIRSTERR^GMPLAPIE("GMPERR") G ADD4
 . S I=$S(GMPLIST(0)'>0:1,GMPARAM("REV"):$O(GMPLIST(0))-.01,1:GMPLIST(0)+1)
 . S GMPLIST(I)=GMPIFN,GMPLIST("B",GMPIFN)=I,GMPLIST(0)=$G(GMPLIST(0))+1
 . S GMPSAVED=1
 . W " done."
ADD4
 ; Not ok -- edit values, ask again
 F GMPI=1:1:GMPFLD("FLD",0) D @(GMPFLD("FLD",GMPI)_"^GMPLEDT1") Q:$D(GMPQUIT)!($D(GMPSAVED))  I $G(GMPLJUMP) S GMPI=GMPLJUMP-1 S GMPLJUMP=0 ; reset GMPI to desired fld
 Q:$D(DTOUT)  K GMPQUIT,DUOUT G ADD3
 Q
 ;
 ; *********************************************************************
 ; *  GMPIFN expected for the following calls:
 ;
STATUS(GMPIFN,GMPROV,GMPVAMC,GMPSAVED,ERT) ; -- inactivate problem
 N PROBTEXT,GMPFLD,PROMPT,DEFAULT
 S PROBTEXT=$$PROBTEXT^GMPLX(GMPIFN)
 I $$STATUS^GMPLAPI2(GMPIFN)="I" D ERR^GMPLAPIE(ERT,"PRBINACTIVE"," ("_PROBTEXT_")") Q 0
 I $$COND^GMPLAPI2(GMPIFN)="H" D ERR^GMPLAPIE(ERT,"PRBDELETED"," ("_PROBTEXT_")") Q 0
 S GMPFLD(.13)=$$ONSET^GMPLAPI2(GMPIFN)
 W !!,PROBTEXT
 D RESOLVED^GMPLEDT4 Q:$D(GMPQUIT) 0
 S PROMPT="COMMENT (<60 char): ",DEFAULT="" D EDNOTE^GMPLEDT4 Q:$D(GMPQUIT) 0
 W !
 D INACTV^GMPLAPI2(GMPIFN,$G(GMPROV),GMPVAMC,Y,$G(GMPFLD(1.07)),ERT)
 W "... inactivated!",!
 H 1
 S GMPSAVED=1
 Q 1
 ;
NEWNOTE(GMPIFN,GMPROV,GMPVAMC,ERT) ; -- add a new comment
 N GMPFLD,NOTES,GMPQUIT
 W !!,$$PROBTEXT^GMPLX(GMPIFN)
 I '$$CODESTS^GMPLAPI2(GMPIFN,DT) W !,"is inactive.  Edit the problem before adding comments.",! H 2 Q 0
 D NOTE^GMPLEDT1
 Q:$D(GMPQUIT)!($D(GMPFLD(10,"NEW"))'>9) 0
 M NOTES=GMPFLD(10,"NEW")
 Q $$NEWNOTE^GMPLAPI3(GMPIFN,GMPROV,GMPVAMC,.NOTES,ERT)
 ;
DELETE(GMPIFN,GMPROV,GMPVAMC,GMPSAVED,ERT) ; -- delete a problem
 N PROMPT,DEFAULT,X,Y,SAVED
 W !!,$$PROBTEXT^GMPLX(GMPIFN)
 I $$COND^GMPLAPI2(GMPIFN)="H" D ERR^GMPLAPIE(ERT,"PRBDELETED") H 2 Q 0
 S PROMPT="REASON FOR REMOVAL: ",DEFAULT=""
 D EDNOTE^GMPLEDT4 Q:$D(GMPQUIT) 0 W !
 S SAVED=$$DELETE^GMPLAPI2(GMPIFN,GMPROV,GMPVAMC,Y)
 W:SAVED "...... removed!"
 W ! H 1
 S:SAVED GMPSAVED=1
 Q SAVED
 ;
VERIFY ; -- verify a transcribed problem, if parameter on
 N GMPERR
 W !!,$$PROBTEXT^GMPLX(GMPIFN),!
 I '$$CODESTS^GMPLX(GMPIFN,DT) W "has an inactive ICD9 code. Edit the problem before verification.",! H 2 Q
 I $$COND^GMPLAPI2(GMPIFN)'="T" W "does not require verification.",! H 2 Q
 S GMPSAVED=$$VERIFY^GMPLAPI2(GMPIFN,"GMPERR")
 W:GMPSAVED " verified.",!
 W:'GMPSAVED $$FIRSTERR^GMPLAPIE("GMPERR")
 Q
ICDMSG ; If Lexicon returns ICD code 799.9
 N DIR,DTOUT,DUOUT
 S DIR(0)="YAO"
 S DIR("A",1)="<< If you PROCEED WITH THIS NON SPECIFIC TERM, an ICD CODE OF 799.9 >>"
 S DIR("A",2)="<< OTHER UNKNOWN AND UNSPECIFIED CAUSE OF MORBIDITY OR MORTALITY    >>"
 S DIR("A",3)="<< will be assigned.  Adding more specificity to your diagnosis may >>"
 S DIR("A",4)="<< allow a more accurate ICD code.                                  >>"
 S DIR("A",5)=""
 S DIR("A")="Continue (YES/NO) ",DIR("B")="NO"
 S DIR("T")=DTIME
 D ^DIR
 I $D(DTOUT)!$D(DUOUT) S Y=0
 I +Y=0 S (GMPLY,GMPROB)=""
 Q
