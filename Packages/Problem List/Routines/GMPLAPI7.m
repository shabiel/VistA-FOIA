GMPLAPI7 ; RGI -- Problem List Group Data ;1/26/95  10:00
 ;;3.0;Problem List;**2**;Aug 25, 1994
 Q
 ;
 ; Temporary.  To be merged with others.
GETPAT(DFN,PATIENT) ;
 N NODE0 
 S NODE0=^DPT(DFN,0)
 S PATIENT("NAME")=$P(NODE0,"^",1)
 Q
 ;
 ; Temporary.  To be merged with others.
GETPROB(IFN,PROBLEM) ;
 N NODE0,NODE1
 S NODE0=^AUPNPROB(IFN,0)
 S NODE1=$G(^AUPNPROB(IFN,1)) 
 S PROBLEM("ACTFLAG")=$P(NODE0,"^",12)
 S PROBLEM("DFN")=$P(NODE0,"^",2)
 S PROBLEM("TEXT")=$P(NODE0,"^",5)
 S PROBLEM("DELETED")=($P(NODE1,"^",2)="H")
 Q
 ;
 ; Finds patients with active and inactive problems.
 ;   TARGET: Root of the target local or global.
 ;   SCREEN: Executed before each patient node is put into TARGET.
 ; Results stored as TARGET(PATIENT_NAME)=<# Active Problems>_"^"_<# Inactive Problems>
 ; Returns number of patients.
PPROBCNT(TARGET,SCREEN)
 N DFN,IFN,CNT,PATCNT,ST,PATIENT,PROBLEM
 S:'$D(SCREEN) SCREEN=""
 S PATCNT=0
 F DFN=0:0 S DFN=$O(^AUPNPROB("AC",DFN)) Q:DFN'>0  D
 . S (CNT("A"),CNT("I"),IFN)=0
 . F  S IFN=$O(^AUPNPROB("AC",DFN,IFN)) Q:IFN'>0  D
 . . K PROBLEM D GETPROB(IFN,.PROBLEM)
 . . Q:PROBLEM("DELETED")
 . . S ST=PROBLEM("ACTFLAG")
 . . S CNT(ST)=CNT(ST)+1
 . I (CNT("A")>0)!(CNT("I")>0) D
 . . X:SCREEN]"" SCREEN Q:'$T
 . . S PATCNT=PATCNT+1
 . . K PATIENT D GETPAT(DFN,.PATIENT)
 . . S @TARGET@(PATIENT("NAME"))=CNT("A")_"^"_CNT("I")
 Q PATCNT
 ;
 ; Finds patients with specified active or inactive problems
 ;   TARGET: Root of the target local or global.
 ;   GMPTERM: Problem code
 ;   GMPTEXT: Problem text
 ;   STATUS: Problem status
PPRBSPEC(TARGET,GMPTERM,GMPTEXT,STATUS) ;
 N IFN,PROBLEM,ST,DFN,TXT,PATIENT,STWORD,PATCNT,NAME,LINE
 S PATCNT=0
 F IFN=0:0 S IFN=$O(^AUPNPROB("C",+GMPTERM,IFN)) Q:IFN'>0  D
 . K PROBLEM D GETPROB(IFN,.PROBLEM)
 . Q:PROBLEM("DELETED")
 . S ST=PROBLEM("ACTFLAG")
 . Q:STATUS'[ST
 . I GMPTERM'>1,GMPTEXT'=$$UP^XLFSTR($P(^AUTNPOV(+TXT,0),"^")) Q
 . S DFN=PROBLEM("DFN"),TXT=PROBLEM("TEXT")
 . K PATIENT D GETPAT(DFN,.PATIENT)
 . S NAME=PATIENT("NAME")
 . S STWORD=$S(ST="A":"active",1:"inactive")
 . I '$D(@TARGET@(NAME)) S PATCNT=PATCNT+1,@TARGET@(NAME)=STWORD Q
 . S LINE=@TARGET@(NAME)
 . Q:(" "_LINE)[(" "_STWORD)  ; already included
 . S:$E(STWORD)="a" @TARGET@(NAME)=STWORD_", "_LINE
 . S:$E(STWORD)="i" @TARGET@(NAME)=LINE_", "_STWORD
 Q PATCNT
 ;
