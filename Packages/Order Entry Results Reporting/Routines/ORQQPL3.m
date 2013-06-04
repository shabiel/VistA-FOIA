ORQQPL3 ; ALB/PDR/REV - Problem List RPCs ; 3/25/13
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,148,173,243,280,260002**;Dec 17, 1997;Build 85
 ;
 ;---------------- LIST PATIENT PROBLEMS ------------------------
 ;
PROBL(ROOT,DFN,CONTEXT)        ;  GET LIST OF PATIENT PROBLEMS
 N DIWL,DIWR,DIWF
 N ST,ORI,ORX
 S (LCNT,NUM)=0
 S DIWL=1,DIWR=48,DIWF="C48"
 S CONTEXT=";;"_$G(CONTEXT)
 I CONTEXT=";;" S CONTEXT=";;A"
 S ST=$P(CONTEXT,";",3)
 ;
 I ST="R" D DELLIST(.ROOT,+DFN) ; show deleted only
 I ST'="R"  D LIST(.ROOT,+DFN,ST) ; show others - don't trust ELSE here
 ;
 I ROOT(0)<1 D
 . S LCNT=1
 . S ROOT(1)="     "_$$PAD^ORCHTAB("No data available.",49)_"|"
 Q
 ;
 ;
LIST(GMPL,GMPDFN,GMPSTAT)       ; -- Returns list of problems for patient GMPDFN
 ;    in GMPL(#)=ifn^status^description^ICD^onset^last modified^SC^SpExp^Condition^Loc^
 ;                          loc.type^prov^service
 ;     & GMPL(0)=number of problems returned
 ; This is virtually same as LIST^GMPLUTL2 except that it appends the
 ; condition - T)ranscribed or P)ermanent,location,loc type,provider, service.
 ;
 N GMPREV,GMPARAM,%
 Q:$G(GMPDFN)'>0
 D GET^GMPLSITE(.GMPARAM)
 S %=$$LIST^GMPLAPI4(.GMPL,GMPDFN,GMPSTAT,"","",GMPARAM("REV"),0)
 Q
 ;
 ;
 ;------------------------------------- GET LIST OF DELETED PROBLEMS -----------------------------
 ;
DELLIST(RETURN,GMPDFN) ; GET LIST OF DELETED PROBLEMS
 ; see GETPLIST^GMPLMGR1 and LIST^GMPUTL2
 N %
 K RETURN
 S %=$$LIST^GMPLAPI4(.GMPL,GMPDFN,"R","","",0,0)
 F I=1:1:GMPL D
 . S $P(GMPL(I),"^",10)=$P($P(GMPL(I),"^",10),";")
 . S $P(GMPL(I),"^",12)=$P($P(GMPL(I),"^",12),";")
 M RETURN=GMPL
 Q
 ;
 ;
 ; ----------------------- GET USER PROBLEM CATEGORIES --------------
 ;
CAT(TMP,ORDUZ,CLIN) ; Get user category list
 N GSEQ,GCNT,IFN,TG,GMPLSLST,RETURN,%
 ; S TG=$NAME(^TMP("GMPLMENU",$J)) ; put list in global for testing
 S TG=$NAME(TMP) ; put list in local
 K @TG
 S (GSEQ,GCNT)=0
 ;
 S GMPLSLST=$$GETUSLST(DUZ,CLIN)  ; get approp list for user
 ; Build multiple of category\problems
 ; Iterate categories
 S %=$$GETLIST^GMPLAPI1(.RETURN,+GMPLSLST)
 F  S GSEQ=$O(RETURN("SEQ",GSEQ)) Q:GSEQ'>0  D
 . S IFN=RETURN("SEQ",GSEQ)
 . S GCNT=GCNT+1
 . S @TG@(GCNT)=$P(RETURN(IFN),U,2,4) ; put category into temp global
 Q
 ;
GETUSLST(ORDUZ,CLIN) ; GET AN APPROPRIATE CATEGORY LIST FOR THE USER
 N GMPLSLST,RETURN,%
 S %=$$GETULST^GMPLAPI6(.RETURN,DUZ)
 S GMPLSLST=RETURN
 I 'GMPLSLST,CLIN S %=$$GETCLST^GMPLAPI6(.RETURN,+CLIN) S GMPLSLST=RETURN
 Q +GMPLSLST
 ;
 ;----------------------- USER PROBLEM LIST --------------------------
 ;
PROB(TMP,GROUP) ; Get user problem list for given group
 N PSEQ,PCNT,IFN,TG,CODE,ORICD186,RETURN,%
 ; S TG=$NAME(^TMP("GMPLMENU",$J)) ; put list in global for testing
 S TG=$NAME(TMP) ; put list in local
 K @TG
 S ORICD186=$$PATCH^XPDUTL("ICD*18.0*6")
 ;
 ; iterate through problems in category
 S %=$$GETCAT^GMPLAPI1(.RETURN,+GROUP)
 S (PSEQ,PCNT)=0
 F  S PSEQ=$O(RETURN("SEQ",PSEQ)) Q:PSEQ'>0  D
 . S IFN=RETURN("SEQ",PSEQ)
 . ; SEE DD for GMPL(125.12,4 :
 . ; "...code which is to be displayed... generally assumed to be ICD"
 . I +ORICD186,$D(RETURN(IFN,"CODE"))'>0 Q
 . S CODE=RETURN(IFN,"CODE")
 . I $P(CODE,U,2)=1 Q
 . S PCNT=PCNT+1
 . ; RETURN:
 . ; PROBLEM^DISPLAY TEXT^CODE^CODE IFN
 . I +ORICD186 D
 . . S @TG@(PCNT)=$P(RETURN(IFN),U,2,4)_U_$$CODEN^ICDCODE($P(CODE,U,1),80)
 . E  D
 . . S @TG@(PCNT)=$P(RETURN(IFN),U,2,4)_U_$$ICDCODE($P(CODE,U,1))
 Q
 ;
ICDCODE(COD)    ; RETURN INTERNAL ICD FOR EXTERNAL CODE  (obsolete after CSV patches released - RV)
 N CODIEN
 I COD="" Q ""
 S CODIEN=$$CODEN^ICDCODE($P(COD,U),80) ;ICR #3990
 Q CODIEN
 ;
 ;------------------ Filter Providers ---------------------
 ;
GETRPRV(RETURN,INP) ; GET LIST OF RESPONSIBLE PROVIDERS FROM PRBLM LIST
 ; RETURN - aa list of responsible providers from which to select for filtering
 ; INP - array of problem list providers to select from
 ;
 N S
 S S=""
 F I=1:1 S S=$O(INP(S)) Q:S=""  D
 . I INP(S)'="",$G(^VA(200,INP(S),0))'="" D  Q  ; get next
 .. S RETURN(I)=INP(S)_U_$P(^VA(200,INP(S),0),U)
 S RETURN(0)="-1"_U_"<None recorded>" ; return empty provider
 Q
 ;
 ;---------------------------------------------------- GET FILTERED CLINIC LIST ------------------------
 ;
GETCLIN(RETURN,INP) ; Get FILTERED LIST OF CLINICS
 ; RETURN NAMES FOR LIST OF CLINICS PASSED IN
 N I,S
 S S=""
 F I=1:1 S S=$O(INP(S)) Q:S=""  D
 . I INP(S)'="",$G(^SC(INP(S),0))'="" D  Q  ; get next
 .. S RETURN(I)=INP(S)_U_$P(^SC(INP(S),0),U,1)
 ;. S RETURN(I)="-1"_U_"None" ; return empty location
 Q
 ;
GETSRVC(RETURN,INP) ; GET FILTERED LIST OF INPATIENT SERVICES
 ; RETURN NAMES FOR LIST OF IEN PASSED IN
 N I,S
 S S=""
 F I=1:1 S S=$O(INP(S)) Q:S=""  D
 . I INP(S)'="",$G(^DIC(49,INP(S),0))'="" D  Q  ; get next
 .. S RETURN(I)=INP(S)_U_$P(^DIC(49,INP(S),0),U,1)
 ;. S RETURN(I)="-1"_U_"None" ; return empty service
 Q
