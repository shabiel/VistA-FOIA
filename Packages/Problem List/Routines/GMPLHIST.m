GMPLHIST ; SLC/MKB/KER -- Problem List Historical data ; 04/15/2002
 ;;2.0;Problem List;**7,26,,31,35**;Aug 25, 1994;Build 26
 ;
 ; External References
 ;   DBIA 10060  ^VA(200
 ;            
DT ; Add historical data (audit trail) to DT list
 ;   Called from ^GMPLDISP, requires AIFN and adds to GMPDT()
 N NODE,DATE,FLD,PROV,OLD,NEW,ROOT,CHNGE,REASON
 S NODE=$G(^GMPL(125.8,AIFN,0)) Q:NODE=""
 S DATE=$$EXTDT^GMPLX($P(NODE,U,3)),FLD=+$P(NODE,U,2),PROV=+$P(NODE,U,8)
 S:'PROV PROV=$P(NODE,U,4)
 S FLD=FLD_U_$$FLDNAME(+FLD),PROV=$P($G(^VA(200,PROV,0)),U)
 S OLD=$P(NODE,U,5),NEW=$P(NODE,U,6),LCNT=LCNT+1
 I +FLD=1101 D  Q
 . S REASON=" removed by "
 . S:OLD="C" REASON=" changed by "
 . S NODE=$G(^GMPL(125.8,AIFN,1))
 . S GMPDT(LCNT,0)=$J(DATE,10)_": NOTE "_$$EXTDT^GMPLX($P(NODE,U,5))_REASON_PROV_":"
 . S LCNT=LCNT+1,GMPDT(LCNT,0)="            "_$P(NODE,U,3)
 I +FLD=1.02 D  Q
 . S CHNGE=$S(NEW="H":"removed",OLD="T":"verified",1:"placed back on list")
 . S GMPDT(LCNT,0)=$J(DATE,10)_": PROBLEM "_CHNGE_" by "_PROV
 S GMPDT(LCNT,0)=$J(DATE,10)_": "_$P(FLD,U,2)_" changed by "_PROV,LCNT=LCNT+1
 I +FLD=.12 S GMPDT(LCNT,0)=$J("from ",17)_$S(OLD="A":"ACTIVE",OLD="I":"INACTIVE",1:"UNKNOWN")_" to "_$S(NEW="A":"ACTIVE",NEW="I":"INACTIVE",1:"UNKNOWN") Q
 I (+FLD=.13)!(+FLD=1.07) S GMPDT(LCNT,0)=$J("from ",17)_$$EXTDT^GMPLX(OLD)_" to "_$$EXTDT^GMPLX(NEW) Q
 I +FLD=1.14 S GMPDT(LCNT,0)=$J("from ",17)_$S(OLD="A":"ACUTE",OLD="C":"CHRONIC",1:"UNSPECIFIED")_" to "_$S(NEW="A":"ACUTE",NEW="C":"CHRONIC",1:"UNSPECIFIED") Q
 I +FLD>1.09 S GMPDT(LCNT,0)=$J("from ",17)_$S(+OLD:"YES",OLD=0:"NO",1:"UNKNOWN")_" to "_$S(+NEW:"YES",NEW=0:"NO",1:"UNKNOWN") Q
 I "^.01^.05^1.01^1.04^1.05^1.06^1.08^"[(U_+FLD_U) D
 . S ROOT=$S(+FLD=.01:"ICD9(",+FLD=.05:"AUTNPOV(",+FLD=1.01:"LEX(757.01,",(+FLD=1.04)!(+FLD=1.05):"VA(200,",+FLD=1.06:"DIC(49,",+FLD=1.08:"SC(",1:"") Q:ROOT=""
 . S GMPDT(LCNT,0)=$J("from ",17)_$S(OLD:$P(@(U_ROOT_OLD_",0)"),U),1:"UNSPECIFIED")
 . S LCNT=LCNT+1,GMPDT(LCNT,0)=$J("to ",17)_$S(NEW:$P(@(U_ROOT_NEW_",0)"),U),1:"UNSPECIFIED")
 Q
 ;            
GETHIST(GMPDT,GMPIFN) ;
 ; GMPDT - By reference, problem history details
 ;  GMPDT(I,0) - history line in format:
 ;   date of changes: what was changed by who
 ;        from "old value"
 ;          to "new value"
 ; GMIFN - Problem IFN
 N IDT,AIFN,LCNT
 S LCNT=0
 I '$D(^GMPL(125.8,"B",GMPIFN)) Q  ;BAIL OUT - NO CHANGES
 ;       get change history
 S IDT=""
 F  S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . S AIFN=""
 . F  S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D
 .. D DT^GMPLHIST
 Q
 ;
FLDNAME(NUM) ; Returns Field Name for Display
 N NAME,NM1,NM2,I,J S J=0,NAME="" D NUM(.NM1),ALP(.NM2) S:+($G(NM1(+NUM)))=+NUM J=+NUM
 S:$L($G(NM2(+J))) NAME=$G(NM2(+J))
 Q NAME
ALP(X) ; Alpha Field Names
 S X(.01)="DIAGNOSIS",X(.02)="PATIENT NAME",X(.03)="DATE LAST MODIFIED",X(.04)="CLASS",X(.05)="PROVIDER NARRATIVE"
 S X(.06)="FACILITY",X(.07)="NUMBER",X(.08)="DATE ENTERED",X(.12)="STATUS",X(.13)="DATE OF ONSET",X(1.01)="PROBLEM",X(1.02)="CONDITION"
 S X(1.03)="ENTERED BY",X(1.04)="RECORDING PROVIDER",X(1.05)="RESPONSIBLE PROVIDER",X(1.06)="SERVICE",X(1.07)="DATE RESOLVED"
 S X(1.08)="CLINIC",X(1.09)="DATE RECORDED",X(1.1)="SERVICE CONNECTED",X(1.11)="AGENT ORANGE EXP",X(1.12)="RADIATION EXP",X(1.13)="ENV CONTAMINANTS EXP"
 S X(1.14)="PRIORITY",X(1.15)="HEAD/NECK CANCER",X(1.16)="MIL SEXUAL TRAUMA",X(1.17)="COMBAT VET",X(1.18)="SHAD",X(1101)="NOTE"
 Q
NUM(X) ; Numeric Field Designations
 N FN F FN=.01:.01:.08 S X(+FN)=+FN
 F FN=.12:.01:.13 S X(+FN)=+FN
 F FN=1.01:.01:1.18 S X(+FN)=+FN
 S X(1101)=1101
 Q
GETAUDIT(RETURN,GMPIFN,FIELD,VALUE) ; Returns all problem audit data 
 ; (optional problem history can be filtered by modified field and his current value)
 ; RETURN - passed by reference
 ;  RETURN(I,0) - audit trail
 ; GMPIFN - Problem IFN
 ; Optional:
 ; FIELD - If is specified, will returns changes only made at this field
 ; VALUE - If both FIELD and VALUE is specified, will returns changes made at FIELD
 ;   and having current value equals with VALUE
 N IDT,AIFN,X0,X1,FLD,CNT
 S CNT=0,RETURN=CNT
 F IDT=0:0 S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . F AIFN=0:0 S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D
 .. S X0=$G(^GMPL(125.8,AIFN,0)),X1=$G(^(1)) Q:'$L(X0)
 .. I $G(FIELD),$P(X0,U,2)'=FIELD Q
 .. I $G(FIELD),$G(VALUE),$P(X0,U,6)'=VALUE Q
 .. S FLD=$$FLDNAME(+$P(X0,U,2))
 .. S CNT=CNT+1
 .. S RETURN(CNT,0)=$P(X0,U,2)_U_FLD_U_$P(X0,U,3,8)
 .. S:$L(X1) RETURN(CNT,1)=X1
 S RETURN=CNT
 Q
 ;
AUDITX(RETURN,GMPIFN,FIELD,VALUE) ; Returns problem audit data 
 ; RETURN - passed by reference
 ;  RETURN(I,"FIELD") - Modified field (Field no^Field name)
 ;  RETURN(I,"MODIFIED") - Date modified
 ;  RETURN(I,"MODIFIEDBY") - Who modified the problem (Provider name)
 ;  RETURN(I,"OLD") - Old value of the field
 ;  RETURN(I,"NEW") - New value of the field
 ;  RETURN(I,"REASON") - Reason for change
 ;  RETURN(I,"REQUESTINGBY") - Who requested the change
 ;  RETURN(I,"OLDPROBLEM") - Note details, if a note was changed
 ; GMPIFN - Problem IFN
 ; Optional:
 ; FIELD - If is specified, will returns changes only made at this field
 ; VALUE - If both FIELD and VALUE is specified, will returns changes made at FIELD
 ;   and having current value equals with VALUE
 N IDT,AIFN,X0,X1,FLD,CNT
 S CNT=0,RETURN=CNT
 F IDT=0:0 S IDT=$O(^GMPL(125.8,"AD",GMPIFN,IDT)) Q:IDT'>0  D
 . F AIFN=0:0 S AIFN=$O(^GMPL(125.8,"AD",GMPIFN,IDT,AIFN)) Q:AIFN'>0  D
 .. S X0=$G(^GMPL(125.8,AIFN,0)),X1=$G(^(1)) Q:'$L(X0)
 .. I $G(FIELD),$P(X0,U,2)'=FIELD Q
 .. I $G(FIELD),$G(VALUE),$P(X0,U,6)'=VALUE Q
 .. S FLD=$$FLDNAME(+$P(X0,U,2))
 .. S CNT=CNT+1
 .. S RETURN(CNT,"FIELD")=$P(X0,U,2)_U_FLD
 .. S RETURN(CNT,"MODIFIED")=$$EXTDT^GMPLX($P(X0,U,3))
 .. S RETURN(CNT,"MODIFIEDBY")=$$PROVNAME^GMPLEXT($P(X0,U,4))
 .. S RETURN(CNT,"OLD")=$P(X0,U,5)
 .. S RETURN(CNT,"NEW")=$P(X0,U,6)
 .. S RETURN(CNT,"REASON")=$P(X0,U,7)
 .. S RETURN(CNT,"REQUESTINGBY")=$$PROVNAME^GMPLEXT($P(X0,U,8))
 .. S:$L(X1) RETURN(CNT,"OLDPROBLEM")=X1,RETURN(CNT,"OLD")=$P(X1,U,3)
 S RETURN=CNT
 Q
 ;
