SDMDAL2 ;RGI/VSL - APPOINTMENT API; 5/31/13
 ;;5.3;scheduling;**260003**;08/13/93;
FRSTAVBL(RETURN,SC,SD) ; Get first available date
 S RETURN=$O(^SC(+SC,"ST",SD))
 Q
 ;
SLOTS(RETURN,SC) ; Get available slots
 M RETURN=^SC(+SC,"ST")
 S RETURN(0)=$P($G(^SC(+SC,"SL")),U,3)
 Q
 ;
SCEXST(RETURN,CSC) ; Returns Outpatient Classification Stop Code Exception status
 N FILE,STOPN,IENACT,FLDS,FS S RETURN=0
 S STOPN=$$GET1^DIQ(40.7,+CSC_",",1) Q:STOPN=""
 S IENACT=""
 S IENACT=$O(^SD(409.45,"B",STOPN,IENACT))
 S FILE="409.45"
 S FLDS("*")=""
 S FS("75")="",FS("75","F")="409.4575",FS("75","N")="EFFECTIVE DATE"
 S RETURN=0
 I $G(IENACT) D
 . D GETREC^SDMDAL(.RETURN,IENACT,FILE,.FLDS,.FS,1,1,1) S RETURN=1
 Q
 ;
LSTAPPT(RETURN,SEARCH,START,NUMBER) ; Lists appointment types
 N FILE,FIELDS,RET
 S FILE="409.1",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B","","","RETURN")
 Q
 ;
LSTASTYP(RETURN,SEARCH,START,NUMBER,TYPE) ; Lists appointment subtypes
 N FILE,FIELDS,RET,SCR
 S FILE="35.1",FIELDS="@;.01;.02;.03"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S SCR="I $P(^DG(35.1,Y,0),U)=($G(TYPE)_"";SD(409.1,"")"
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN")
 Q
 ;
GETAPPT(RETURN,TYPE,INT,EXT,REZ) ; Get Appointment Type
 N FILE,FLDS,SF
 S FILE=409.1,FLDS("*")=""
 D GETREC^SDMDAL(.RETURN,TYPE,FILE,.FLDS,.SF,$G(INT),$G(EXT),$G(REZ))
 Q
 ;
GETELIG(RETURN,ELIG,INT,EXT,REZ) ; Get eligibility code
 N FILE,FLDS
 S FILE=8,FLDS("*")=""
 D GETREC^SDMDAL(.RETURN,ELIG,FILE,.FLDS,,$G(INT),$G(EXT),$G(REZ))
 Q
 ;
HASPEND(RETURN,PAT,SDT) ; Return 1 if patient has pending appointment
 S RETURN=0
 I '$D(^DPT(+$G(PAT),0)) D ERRX^SDAPIE(.RETURN,"PATNFND") Q RETURN
 S:$O(^DPT(PAT,"S",SDT)) RETURN=1
 Q 1
 ;
GETPEND(RETURN,PAT,SDT) ; Get pending appointments
 N Y,AP
 F Y=SDT:0 S Y=$O(^DPT(PAT,"S",Y)) Q:Y'>0  D
 . S AP=^DPT(PAT,"S",Y,0)
 . I "I"[$P(AP,U,2) D
 . . S RETURN(Y,.01)=$P(AP,U,1)
 . . S RETURN(Y,13)=$P(AP,U,11)
 . . S RETURN(Y,9.5)=$P(AP,U,16)
 . . S RETURN(Y,2)=$P(AP,U,3)
 . . S RETURN(Y,3)=$P(AP,U,4)
 . . S RETURN(Y,4)=$P(AP,U,5)
 Q
 ;
APTYNAME(TYPE) ; Get appointment type name
 Q $$GET1^DIQ(409.1,TYPE_",",.01)
 ;
GETAPTS(RETURN,DFN,SD) ; Get patient appointments
 N FILE,SFILES,APTS,TDT,SDT,EDT
 S FILE=2
 S SFILES("1900")="",SFILES("1900","N")="APT",SFILES("1900","F")="2.98"
 D GETREC^SDMDAL(.APTS,DFN,FILE,,.SFILES,1,1,1)
 I '$G(SD) M RETURN=APTS Q
 I $G(SD)>0&'$D(SD(0)) D  Q
 . I $D(APTS("APT",+SD)) M RETURN("APT",+SD)=APTS("APT",+SD) Q
 S (SDT,TDT)=$S(+SD(0)=1:+SD,1:0)
 S EDT=$S(+SD(0)=0:SD,1:9999999)
 F  S TDT=$O(APTS("APT",TDT)) Q:TDT=""!(TDT>EDT)  D
 . M RETURN("APT",TDT)=APTS("APT",TDT)
 Q
 ;
GETPAPTS(RETURN,DFN,SDT,EDT) ; Get patient appointments
 N NOD,IND,END
 S RETURN=0
 S IND=$S($G(SDT):SDT,1:0),END=$S($G(EDT):EDT,1:9999999)
 F  S IND=$O(^DPT(DFN,"S",IND)) Q:IND=""!(+IND>END)  D
 . S NOD=^DPT(DFN,"S",IND,0)
 . S RETURN(IND,1)=$P(NOD,U,1)
 . S RETURN(IND,2)=$P(NOD,U,2)
 S RETURN=1
 Q
 ;
LSTCRSNS(RETURN,SEARCH,START,NUMBER) ; Return cancelation reasons.
 N FILE,FIELDS,RET,SCR,TYP
 S FILE="409.2",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 I $D(RETURN("TYPE")) S TYP=RETURN("TYPE"),SCR="I '$P(^(0),U,4),(TYP_""B""[$P(^(0),U,2))"
 K RETURN
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"B",.SCR,"","RETURN","ERR")
 Q
 ;
LSTCSTA1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow cancellation.
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACAN",.SCR,"","RETURN","ERR")
 Q
 ;
LSTCIST1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow check in.
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACI",.SCR,"","RETURN","ERR")
 Q
 ;
LSTCOST1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow check in.
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ACO",.SCR,"","RETURN","ERR")
 Q
 ;
LSTNSTA1(RETURN,SEARCH,START,NUMBER) ; Returns the list of states that allow no-show.
 N FILE,FIELDS,RET,SCR
 S FILE="409.63",FIELDS="@;.01"
 S:$D(START)=0 START="" S:$D(SEARCH)=0 SEARCH=""
 S START(1)=1
 S START(2)=0
 D LIST^DIC(FILE,"",FIELDS,"",$G(NUMBER),.START,SEARCH,"ANS",,"","RETURN","ERR")
 Q
 ;
GETAPT0(DFN,SD) ; Get appointment 0 node
 Q $G(^DPT(DFN,"S",SD,0))
 ;
GETPAPT(RETURN,DFN,SD) ; Get patient appointment
 N IND
 F IND=0:0 S IND=$O(RETURN(IND)) Q:IND=""  D
 . S RETURN(IND)=$$GET1^DIQ(2.98,SD_","_DFN_",",IND,"I")
 S RETURN=1
 Q
 ;
