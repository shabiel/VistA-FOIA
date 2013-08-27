DGPMV21 ;ALB/MRL/MIR - PASS/FAIL MOVEMENT DATE; 8/26/13
 ;;5.3;Registration;**40,95,131,260005**;Aug 13, 1993
 I $S('$D(DGPMY):1,DGPMY?7N:0,DGPMY'?7N1".".N:1,1:0) S DGPME="DATE EITHER NOT PASSED OR NOT IN EXPECTED VA FILEMANAGER FORMAT" G Q
 I $S('$D(DGPMT):1,'DGPMT:1,1:0) S DGPME="TRANSACTION TYPE IS NOT DEFINED" G Q
 D PTF^DGPMV22(DFN,DGPMDA,.DGPME,DGPMCA) G:$G(DGPME)]"" Q K DGPME
 G CONT:("^4^5^"[("^"_DGPMT_"^"))!DGPMN D PTF I $D(DGPME),DGPME="***" Q
CONT Q:'DGPMN  D CHK I $D(DGPME) G Q
 I DGPM1X Q  ;Don't ask to add a new one if discharge or check-out
ADD S Y=DGPMY,%=Y X ^DD("DD")
ADD1 W !!,"SURE YOU WANT TO ADD '",Y,"' AS A NEW ",DGPMUC," DATE" S:"^1^4^"'[("^"_DGPMT_"^") %=1 D YN^DICN Q:%=1  I '% W !?4,"Answer YES if you wish to add this new entry otherwise answer NO!" G ADD1
 S DGPME="NOTHING ADDED" G Q
 ;
CHK N CHK,PAR,RE
 S PAR("DATE")=DGPMY,PAR("ADMIFN")=DGPMCA,PAR("PATIENT")=DFN
 S CHK="S %=$$CHKDT^DGPMAPI"_DGPMT_"(.RE,.PAR)" X CHK I RE=0 S DGPME=$P(RE(0),U,2) Q
 Q
 ;
PTF N ADM,%
 S %=$$GETADM^DGPMAPI8(.ADM,DGPMCA)
 S PTF=+$G(ADM("PTF")) I $S('PTF:1,'$D(^DGPT(PTF,0)):1,1:0) D NOPTF Q
 I $D(^DGP(45.84,PTF)) S DGPME="***" W !,"PTF record is closed for this admission...cannot edit" G Q
 Q
 ;
NOPTF W *7 F I=1:1 S J=$P($T(NP+I),";;",2) Q:J=""  W !?4,J
 S DGPME="***"
Q S DGPMY=0 Q
 ;
NP ;
 ;;WARNING:  This  admission has no corresponding  PTF record.
 ;;A  PTF record is  required in order to continue  processing
 ;;this movement activity.   If you have the PTF option called
 ;;"Establish PTF record from Past Admission" on your menu, it
 ;;may be used to  create the PTF  record for this  admission.
 ;;Otherwise appropriate  Medical  Information  Section  (MIS)
 ;;personnel  and/or your supervisor  will need to be notified
 ;;that the PTF record is missing as soon as possible in order
 ;;to continue processing this movement.
