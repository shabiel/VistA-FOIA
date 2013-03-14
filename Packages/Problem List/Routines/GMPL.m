GMPL ; SLC/MKB/AJB -- Problem List Driver ;3/13/13
 ;;2.0;Problem List;**3,11,28,260002**;Aug 25, 1994
EN ; -- main entry point for GMPL PROBLEM LIST
 S GMPLUSER=1
 D EN^VALM("GMPL PROBLEM LIST")
 Q
 ;
DE ; -- main entry point for GMPL DATA ENTRY
 K GMPLUSER
 D EN^VALM("GMPL DATA ENTRY")
 Q
 ;
ADD ; -- add a new problem 
 S VALMBCK="",GMPCLIN=""
 K GMPREBLD
 I +$P(GMPDFN,U,4),'$$CKDEAD^GMPLX1($P(GMPDFN,U,4)) G ADDQ
 S:$E(GMPLVIEW("VIEW"))'="S" GMPCLIN=$$CLINIC^GMPLX1("") G:GMPCLIN="^" ADDQ
 S GMPLSLST=$$USERLST^GMPLEXT(GMPCLIN)
 I GMPLSLST D  G ADD1
 . S $P(GMPLSLST,U,2)=$$LSTTEXT^GMPLEXT(GMPLSLST)
 . D EN^VALM("GMPL LIST MENU")
 W @IOF
 D FULL^VALM1
 F  D ADD^GMPL1 Q:$D(GMPQUIT)  S:$D(GMPSAVED) GMPREBLD=1 K DUOUT,DTOUT,GMPSAVED D EN^DDIOL($$EZBLD^DIALOG(1250000.001),"","!!!")
 S VALMBCK="R"
ADD1 I $D(GMPREBLD) D
 . S VALMBCK="R",GMPRINT=1
 . S VALMBG=$S(GMPARAM("REV"):1,VALMCNT<10:1,1:VALMCNT-9)
 . D BUILD^GMPLMGR(.GMPLIST),HDR^GMPLMGR
ADDQ D KILL^GMPLX S VALMSG=$$MSG^GMPLX S:'VALMCC VALMBCK="R"
 Q
 ;
STATUS ; -- inactivate a problem
 N GMPERR,GMPIFN,GMPLNO,GMPLNUM,GMPLSEL,GMPI,GMPQUIT,GMPSAVED,MSG
 S VALMBCK="" G:+$G(GMPCOUNT)'>0 STQ
 S MSG(1)=$C(7)
 S MSG(2)=$$EZBLD^DIALOG(1250000.002)
 S MSG(2,"F")="!!"
 S MSG(3,"F")="!"
 I GMPLVIEW("ACT")="I" D EN^DDIOL(.MSG) G STQ
 S GMPLSEL=$$SEL^GMPLX($$EZBLD^DIALOG(1250000.003)) G:GMPLSEL="^" STQ
 S GMPLNO=$L(GMPLSEL,",")
 S GMPSAVED=0
 F GMPI=1:1:GMPLNO S GMPLNUM=$P(GMPLSEL,",",GMPI) I GMPLNUM D  Q:$D(GMPQUIT)
 . S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) Q:GMPIFN'>0
 . I '$$STATUS^GMPL1(GMPIFN,$G(GMPROV),GMPVAMC,.GMPSAVED,"GMPERR") D EN^DDIOL($$FIRSTERR^GMPLAPIE("GMPERR"),"","!!") H 2 Q
 S VALMBCK="R",GMPRINT=1
 D BUILD^GMPLMGR(.GMPLIST),HDR^GMPLMGR
STQ ; cleanup
 D KILL^GMPLX
 S VALMSG=$$MSG^GMPLX
 S:'VALMCC VALMBCK="R"
 Q
 ;
NOTES ; -- annotate a problem
 N GMPLNUM,GMPERR,GMPIFN
 S VALMBCK=""
 G:+$G(GMPCOUNT)'>0 NTQ
 S GMPLNUM=$$SEL1^GMPLX($$EZBLD^DIALOG(1250000.004))
 G:GMPLNUM="^" NTQ
 S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) G:GMPIFN'>0 NTQ
 I '$$NEWNOTE^GMPL1(.GMPERR,GMPIFN,$G(GMPROV)) D EN^DDIOL($$ERRTXT^GMPLAPIE(.GMPERR),"","!!") H 2 G NTQ
 S VALMBCK="R",GMPRINT=1
 D BUILD^GMPLMGR(.GMPLIST)
NTQ ; cleanup
 D KILL^GMPLX
 S VALMSG=$$MSG^GMPLX
 S:'VALMCC VALMBCK="R"
 Q
 ;
EDIT ; -- edit allowable fields of a problem
 N GMPIFN,GMPLNUM,GMPSAVED,DELETED,MSG
 S VALMBCK="" G:+$G(GMPCOUNT)'>0 EDQ
 S GMPLNUM=$$SEL1^GMPLX("edit") G:GMPLNUM="^" EDQ
 S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) G:GMPIFN'>0 EDQ
 ; Code Set Versioning (CSV)
 ; I '$$CODESTS^GMPLX(GMPIFN,DT) W !!,$$PROBTEXT^GMPLX(GMPIFN),!,"has an inactive ICD code.",! H 3 G EDQ
 S %=$$DELETED^GMPLAPI2(.DELETED,GMPIFN)
 I DELETED D  H 2 G EDQ
 . S MSG(1)=$$PROBTEXT^GMPLX(GMPIFN)
 . S MSG(1,"F")="!!"
 . S MSG(2)=$$EZBLD^DIALOG(1250000.005)
 . S MSG(2,"F")="!"
 . S MSG(3,"F")="!"
 . D EN^DDIOL(.MSG)
 I '$$LOCK^GMPLDAL(GMPIFN,0) D  H 2 G EDQ
 . S MSG(1)=$C(7)
 . S MSG(1,"F")="?0"
 . S MSG(2)=$$LOCKED^GMPLX
 . S MSG(2,"F")="!!"
 . S MSG(3,"F")="!"
 . D EN^DDIOL(.MSG)
 D EN^VALM("GMPL EDIT PROBLEM")
 I $D(GMPSAVED) D BUILD^GMPLMGR(.GMPLIST),HDR^GMPLMGR S GMPRINT=1
 S VALMBCK="R"
 D UNLOCK^GMPLDAL(GMPIFN,0)
EDQ D KILL^GMPLX S VALMSG=$$MSG^GMPLX S:'VALMCC VALMBCK="R"
 Q
 ;
DELETE ; -- delete a problem
 N GMPLSEL,GMPLNO,GMPLNUM,GMPI,GMPQUIT,GMPIFN,GMPERR,GMPSAVED
 S VALMBCK="" G:+$G(GMPCOUNT)'>0 DELQ
 S GMPLSEL=$$SEL^GMPLX($$EZBLD^DIALOG(1250000.006))
 G:GMPLSEL="^" DELQ
 S GMPLNO=$L(GMPLSEL,",")
 G:'$$SUREDEL^GMPLEDT2(GMPLNO-1) DELQ
 S GMPSAVED=0
 F GMPI=1:1:GMPLNO S GMPLNUM=$P(GMPLSEL,",",GMPI) I GMPLNUM D  Q:$D(GMPQUIT)
 . S GMPIFN=$P($G(^TMP("GMPLIDX",$J,+GMPLNUM)),U,2) Q:GMPIFN'>0
 . I '$$DELETE^GMPL1(.GMPERR,GMPIFN,$G(GMPROV),.GMPSAVED) D EN^DDIOL($$ERRTXT^GMPLAPIE(.GMPERR),"","!!")
 I GMPSAVED D
 . S VALMBCK="R",GMPRINT=1 D BUILD^GMPLMGR(.GMPLIST),HDR^GMPLMGR
DELQ ; cleanup
 D KILL^GMPLX
 S VALMSG=$$MSG^GMPLX
 S:'VALMCC VALMBCK="R"
 Q
 ;
VERIFY ; -- verify a problem
 S VALMBCK="" Q:+$G(GMPCOUNT)'>0
 D EN^DDIOL($$EZBLD^DIALOG(1250000.007),"","!!")
 S GMPLSEL=$$SEL^GMPLX($$EZBLD^DIALOG(1250000.008))
 G:GMPLSEL="^" VERQ
 S GMPLNO=$L(GMPLSEL,",")
 F GMPI=1:1:GMPLNO S GMPLNUM=$P(GMPLSEL,",",GMPI) I GMPLNUM D
 . S GMPIFN=$P($G(^TMP("GMPLIDX",$J,GMPLNUM)),U,2)
 . D:GMPIFN VERIFY^GMPL1
 I +$G(GMPSAVED) D BUILD^GMPLMGR(.GMPLIST) S VALMBCK="R"
VERQ ; cleanup
 D KILL^GMPLX
 S VALMSG=$$MSG^GMPLX
 S:'VALMCC VALMBCK="R"
 Q
 ;
EXPAND ; -- detailed display of a problem
 S VALMBCK="" Q:+$G(GMPCOUNT)'>0
 S GMPLSEL=$$SEL^GMPLX("view")
 G:GMPLSEL="^" EXPQ
 S GMPLNO=$L(GMPLSEL,",")-1,GMPI=0
 D EN^VALM("GMPL DETAILED DISPLAY")
 S VALMBCK="R"
EXPQ D KILL^GMPLX S VALMSG=$$MSG^GMPLX S:'VALMCC VALMBCK="R"
 Q
