DGPMV33 ;ALB/MIR - DISCHARGE A PATIENT, CONTINUED ; 3/28/2013
 ;;5.3;Registration;**204,544,260005**;Aug 13, 1993
 ;
 I $G(PAR("TYPE")) D
 . S %=$$GETMVTT^DGPMAPI8(.MVTT,PAR("TYPE"))
 . S %=$$GETMASMT^DGPMAPI8(.MAS,MVTT("MAS"))
 I '$G(PAR("TYPE"))!$S(+$G(MVTT("MAS"))'=10:0,'$G(PAR("FCTY")):1,1:0) S DGQUIT=1 W !,"Incomplete Discharge deleted" D  G Q
 . S DGPMPTF=+$G(ADM("PTF")) G DQ:'DGPMPTF
 ;S X=$S($D(^DG(405.2,+$P(DGPMA,"^",18),0)):$P(^(0),"^",8),1:""),DR=$S(+DGPMA:"70////"_+DGPMA_";",1:"")_$S(X:"72////"_X,1:""),DIE="^DGPT(",DA=DGPMPTF K DQ,DG D ^DIE
 ;I +DGPMP=+DGPMA G Q
DQ S DGPMER=0 I +ADM("MASTYPE")=40 D SET^DGPMV32 I DGPMAB S X1=+DGPMAB,X2=30 D C^%DTC I X'<+$G(ADM("DATE")) D ASIH^DGPMV331
 ;I 'DGPMER,$D(^DGPM(+DGPMDA,0)) D ADM
Q Q
DICS ;input transform on discharge type
 S DGX1=$P(^DG(405.1,+Y,0),"^",3),DGSV=$S($D(^DIC(42,+PMVT("WARD"),0)):$P(^(0),"^",3),1:"")
 I DGX1=33,$S(DGSV="":1,DGSV'="D":1,1:0) S DGER=1 Q
 I DGX1=35,$S(DGSV="":1,DGSV'="NH":1,1:0) S DGER=1 Q
 I $S(DGX1=31:1,DGX1=32:1,1:0),$S(DGSV="":0,"NHD"[DGSV:1,1:0) S DGER=1 Q
 I DGX1=34,$S(DGSV="":1,DGSV="NH":1,1:0) S DGER=1 Q
 ;I "^21^47^48^49^"[("^"_DGX1_"^") S DGER=1 Q
 I DGX1=42,+DGPMDA>0,'$O(^DGPM("ATID2",+OLD("PATIENT"),9999999.9999999-OLD("DATE"))) S DGER=1 Q
 S DGX=+$G(OLD("MASTYPE")) I DGX,"^41^46^"[("^"_DGX_"^"),(DGX1'=DGX) S DGER=1 Q
 I "^42^47^"[("^"_DGX1_"^"),(DGX1'=+$G(OLD("MASTYPE"))) S DGER=1 Q
 I "^42^47^"[("^"_DGX_"^"),(DGX1'=+$G(OLD("MASTYPE"))) S DGER=1 Q
 I DGX,"^41^42^46^47^"'[("^"_DGX_"^"),("^41^42^46^47^"[("^"_DGX1_"^")) S DGER=1 Q
 I +$G(ADM("MASTYPE"))=40,("^42^47^"[("^"_DGX1_"^")) S DGER=1 Q  ;if admission type is TO ASIH and d/c type is WHILE ASIH
 I +$G(ADM("MASTYPE"))'=40,("^41^46^"[("^"_DGX1_"^")) S DGER=1 Q  ;if adm type not TO ASIH and d/c type FROM ASIH or CONTINUED ASIH (O.F.)
 I +$G(ADM("MASTYPE"))'=40 S DGER=0 Q
 I "^41^46^"'[("^"_DGX1_"^") S DGER=0 Q
 D SET^DGPMV32 S X1=+DGPMAB,X2=30,DGHX=X D C^%DTC I $G(OLD("DATE"))>X S DGER=1,X=DGHX K DGHX Q
 S X=DGHX,DGER=0 K DGHX
 I $D(^DGPM(+$G(ADM("ASIHTRA")),0)),$D(^DGPM(+$P(^(0),"^",14),0)),$D(^DGPM(+$P(^(0),"^",17),0)),($P(^(0),"^",18)=47) S DGER=1 Q  ;if discharge from NHCU/DOM is type 47
 S DGER=0 Q
SI ;
 N WARD,T S WARD=0,%=$$GETMVTT^DGPMAPI8(.MVTT,$G(PAR("TYPE")))
 Q:"^25^26^"[("^"_+$G(MVTT("MAS"))_"^")
 S %=$$GETPAT^DGPMAPI8(.PAT,DFN)
 I $S($P(PAT("WARD"),U)="":1,1:0)&($L(PAT("SRILL"))) S DR="401.3///@",DIE="^DPT(",DA=DFN K DQ,DG D ^DIE:$P(PAT("SRILL"),U)="S" K DR,DIC Q
 I '$G(PAR("WARD")),'$L($P(PAT("WARD"),U)) K PAR("SERILL") Q
 I WARD=0 S %=$$LSTWARD^DGPMAPI7(.WARD,$P(PAT("WARD"),U))
 S WARD=$S($G(PAR("WARD")):PAR("WARD"),1:$G(WARD(1,"ID")))
 S %=$$GETWARD^DGPMAPI8(.WARD,WARD)
 S T="SERIOUSLY ILL"
 I WARD("SRILL"),(+$G(MVTT("MAS"))>3) D  Q
 . S DR="401.3//"_$S("^22^23^24^"[("^"_+$G(MVTT("MAS"))_"^"):$S($P(PAT("SRILL"),U)="":"",$L($P(PAT("SRILL"),U)):T,1:""),DGPMN:T,1:"")
 . I $P(DR,"//",2)=T S DR=$S("^1^2^"[("^"_DGPMT_"^")&+PAR("DATE"):DR_";S:X'=""S"" Y=0;401.4////"_$P(PAR("DATE"),"."),1:DR)
 . S DIE="^DPT(",DA=DFN K DQ,DG D ^DIE K DIE,T,W
 I $L($P(PAT("SRILL"),U)) S DA=DFN,DR=401.3,DIE="^DPT(" K DQ,DG D ^DIE
 K DIE,T,W Q
ADM ;update admission or check-in mvt with discharge/check-out mvt pointer
 Q
 Q:$S('DGPMN:1,'$D(^DGPM(+DGPMCA,0)):1,1:0)
 S ^UTILITY("DGPM",$J,1,+DGPMCA,"P")=DGPMAN,^UTILITY("DGPM",$J,1,+DGPMCA,"A")=$G(^DGPM(+DGPMCA,0))
 Q
