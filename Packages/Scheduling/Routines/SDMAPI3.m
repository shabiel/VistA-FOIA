SDMAPI3 ;RGI/VSL - APPOINTMENT API; 1/25/2013
 ;;5.3;scheduling;**260003**;08/13/93;
LSTPATS(RETURN,SEARCH,START,NUMBER) ; Get patients by name
 N RET,DL,IN,DG
 S:'$D(START) START="" S:'$D(SEARCH) SEARCH=""
 S:'$G(NUMBER) NUMBER=""
 K RETURN S RETURN=0
 D GETPATS^SDMDAL3(.RET,$$UP^XLFSTR(SEARCH),.START,NUMBER)
 S RETURN(0)=RET("DILIST",0)
 S DL="DILIST"
 F IN=1:1:$P(RETURN(0),U,1) D
 . D SENS^DGSEC4(.DG,RET(DL,2,IN),DUZ)
 . S RETURN(IN)=""
 . S RETURN(IN,"ID")=RET(DL,2,IN)
 . S RETURN(IN,"NAME")=RET(DL,"ID",IN,".01")
 . S RETURN(IN,"BIRTHDATE")=$S(DG(1)=2:"*SENSITIVE*",1:RET(DL,"ID",IN,".03"))
 . S RETURN(IN,"SSN")=$S(DG(1)=2:"*SENSITIVE*",1:RET(DL,"ID",IN,".09"))
 . S RETURN(IN,"TYPE")=RET(DL,"ID",IN,"391")
 . S RETURN(IN,"VETERAN")=RET(DL,"ID",IN,"1901")
 S RETURN=1
 Q 1
 ;
GETPAT(RETURN,PATIENT,LVL) ; Get a patient
 N TEXT
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,+PATIENT) Q:'% 0
 S:'$G(LVL) LVL=7
 I LVL>1 D SENS^DGSEC4(.DG,+PATIENT,DUZ) I DG(1)>0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"PATSENS",.TEXT) Q 0
 D GETPAT^SDMDAL3(.RETURN,+PATIENT,1,1,1)
 S RETURN=1
 Q RETURN
 ;
LSTETNS(RETURN,SEARCH,START,NUMBER) ; Get ethnicities
 N LST
 K RETURN S RETURN=0
 D LSTETNS^SDMDAL3(.LST,$G(SEARCH),.START,$G(NUMBER))
 D BLDLST^SDMAPI(.RETURN,.LST)
 S RETURN=1
 Q RETURN
 ;
SETETN(RETURN,PAT,ETN) ; Set patient ethnicity.
 K RETURN S RETURN=0
 D SETETN^SDMDAL3(+PAT,$P(ETN,U,1))
 S RETURN=1
 Q 1
 ;
LSTRACES(RETURN,SEARCH,START,NUMBER) ; Get races
 N LST
 K RETURN S RETURN=0
 D LSTRACES^SDMDAL3(.LST,$G(SEARCH),.START,$G(NUMBER))
 D BLDLST^SDMAPI(.RETURN,.LST)
 S RETURN=1
 Q RETURN
 ;
SETRACE(RETURN,PAT,RACE) ; Set patient race.
 K RETURN S RETURN=0
 D ADDRACE^SDMDAL3(+PAT,+RACE)
 S RETURN=1
 Q 1
 ;
GETPRES(RETURN,PAT) ; Get patient races
 N LST,IND,CNT
 K RETURN S RETURN=0
 D GETPRES^SDMDAL3(.LST,+PAT)
 S IND=0,CNT=0
 S RETURN(0)=0
 F  S IND=$O(LST(2,IND)) Q:IND=""  D
 . S CNT=CNT+1
 . S RETURN(CNT)="",RETURN(CNT,"ID")=IND
 . S RETURN(CNT,"NAME")=LST(2,IND,.01)
 . S RETURN(0)=CNT_"^*^0^"
 S RETURN=1
 Q 1
 ;
CHKDISCH(RETURN,ENS,DFN,OENS) ; Check discharge
 N SC,TXT,IND,APTS,ERR,APT
 K RETURN S RETURN=0
 S ERR=0
 S SC=$O(ENS(""))
 S TXT(1)=ENS(SC,"NAME")
 I OENS(SC,"STATUS")]"" D ERRX^SDAPIE(.RETURN,"PATDARD",.TXT) Q RETURN
 I '$D(OENS(SC,"EN")) D ERRX^SDAPIE(.RETURN,"PATDNEN",.TXT) Q RETURN
 F IND=0:0 S IND=$O(ENS(SC,"EN",IND)) Q:IND=""!(ERR>0)  D
 . Q:$D(ENS(SC,"EN",IND,"DISCHARGE"))&(ENS(SC,"EN",IND,"DISCHARGE")=OENS(SC,"EN",IND,"DISCHARGE"))
 . D LSTPAPTS^SDMDAL1(.APTS,+DFN,ENS(SC,"EN",IND,"DISCHARGE"),9999999)
 . F APT=0:0 S APT=$O(APTS(APT)) Q:APT=""!(ERR>0)  D
 . . I APTS(APT,"SC")=SC,$P(APTS(APT,"SDATA"),U,2)'["C",$P(APTS(APT,"SDATA"),U,2)'["N" S ERR=1
 I ERR D ERRX^SDAPIE(.RETURN,"PATDHFA") Q RETURN
 S RETURN=1
 Q RETURN
 ;
DISCH(RETURN,ENS,DFN) ; Discharge from clinic
 N OENS,IND,SC,NENS
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,+DFN) Q:'% 0
 S SC=$O(ENS(""))
 S %=$$GETPENRL(.OENS,+DFN,SC)
 S %=$$CHKDISCH(.RETURN,.ENS,+DFN,.OENS)
 Q:RETURN=0 0
 F IND=0:0 S IND=$O(ENS(SC,"EN",IND)) Q:IND=""  D
 . S:ENS(SC,"EN",IND,"DISCHARGE")'=OENS(SC,"EN",IND,"DISCHARGE") NENS(SC,"EN",IND,"DISCHARGE")=ENS(SC,"EN",IND,"DISCHARGE")
 . S:ENS(SC,"EN",IND,"REASON")'=OENS(SC,"EN",IND,"REASON") NENS(SC,"EN",IND,"REASON")=$E(ENS(SC,"EN",IND,"REASON"),1,80)
 S NENS(SC,"IEN")=ENS(SC,"IEN")
 D BEFORE^SCMCEV3(+DFN)
 D UPDENRL^SDMDAL3(.NENS,+DFN)
 D AFTER^SCMCEV3(+DFN)
 D INVOKE^SCMCEV3(+DFN)
 S RETURN=1
 Q 1
 ;
GETPENRL(RETURN,DFN,SC,STAT) ; Get patient enrollments filtered by status
 N ENS,EN,IND,CLN,SSC
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,+$G(DFN)) Q:'% 0
 D GETCENRL^SDMDAL3(.ENS,+DFN,+$G(SC))
 F SSC=0:0 S SSC=$O(ENS(SSC)) Q:SSC=""  D
 . Q:$G(STAT)>0&($P(ENS(SSC,0),U,3)]"")
 . S RETURN(SSC,"STATUS")=$P(ENS(SSC,0),U,3)
 . S RETURN(SSC,"IEN")=$P(ENS(SSC,0),U,1)
 . D GETCLN^SDMDAL1(.CLN,SSC)
 . S RETURN(SSC,"NAME")=CLN(.01)
 . F IND=0:0 S IND=$O(ENS(SSC,IND)) Q:IND=""  D
 . . S EN=ENS(SSC,IND)
 . . S RETURN(SSC,"EN",IND,"ENROLLMENT")=$P(EN,U,1)
 . . S RETURN(SSC,"EN",IND,"OA")=$P(EN,U,2)
 . . S RETURN(SSC,"EN",IND,"DISCHARGE")=$P(EN,U,3)
 . . S RETURN(SSC,"EN",IND,"REASON")=$P(EN,U,4)
 . . S RETURN(SSC,"EN",IND,"REVIEW")=$P(EN,U,5)
 I +$G(SC)>0 D
 . Q:$D(RETURN(+SC))
 . D GETCLN^SDMDAL1(.CLN,+SC)
 . S RETURN(+SC,"NAME")=CLN(.01)
 S RETURN=1
 Q 1
 ;
CHKCIN(RETURN,DFN,SD,STATUS) ; Check in check
 N DT
 K RETURN S RETURN=0
 S %=$$CHKSPCI(.RETURN,+DFN,+SD,+STATUS) Q:'% 0
 S DT=$$NOW^XLFDT
 I $P(SD,".")>DT D ERRX^SDAPIE(.RETURN,"APTCITS") Q 0
 S RETURN=1
 Q 1
 ;
CHKSPCI(RETURN,DFN,SD,STATUS) ; Check if status permit check in
 N IND,STAT,STATS
 K RETURN S RETURN=0
 D LSTCIST1^SDMDAL2(.STAT)
 D BLDLST^SDMAPI(.STATS,.STAT)
 S IND=0
 F  S IND=$O(STATS(IND)) Q:IND=""!(RETURN=1)  D
 . I STATS(IND,"ID")=STATUS S RETURN=1 Q
 I 'RETURN D ERRX^SDAPIE(.RETURN,"APTCIPE")
 S RETURN=1
 Q RETURN
 ;
CHKNS(RETURN,APT0,STATUS,LVL) ; Check no-show
 N STAT
 K RETURN S RETURN=1
 S %=$$CHKSPNS(.RETURN,+STATUS) Q:'% 0
 S STAT=$P(APT0,U,2)
 I STAT="I" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNSIA") Q RETURN
 I LVL>1,STAT["A" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNSAR",,2) Q RETURN
 I LVL>1,STAT]"",STAT'["A" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNSAL",,2) Q RETURN
 Q RETURN
 ;
CHKSPNS(RETURN,STATUS) ; Check if status of appt permits no-show
 N IND,STAT,STATS
 K RETURN S RETURN=0
 D LSTNSTA1^SDMDAL2(.STAT)
 D BLDLST^SDMAPI(.STATS,.STAT)
 S IND=0
 F  S IND=$O(STATS(IND)) Q:IND=""!(RETURN=1)  D
 . I STATS(IND,"ID")=STATUS S RETURN=1 Q
 I 'RETURN D ERRX^SDAPIE(.RETURN,"APTNSCE")
 S RETURN=1
 Q RETURN
 ;
CHKCAN(RETURN,DFN,SC,SD) ; Verify cancel
 N APT,RET,%
 K RETURN S RETURN=0
 D GETAPTS^SDMDAL2(.APT,+DFN,.SD)
 I APT("APT",SD,"STATUS")["C" D  Q RETURN
 . D ERRX^SDAPIE(.RETURN,"APTCAND")
 I $$ISAPTCO^SDMAPI4(,+DFN,+SD) D  Q RETURN
 . D ERRX^SDAPIE(.RETURN,"APTCCHO")
 S %=$$CLNRGHT^SDMAPI1(.RET,+SC)
 I RET=0 D  Q RETURN
 . S TXT(1)=RET("CLN"),TXT(2)=" "
 . D ERRX^SDAPIE(.RETURN,"APTCRGT",.TXT)
 I '$$CHKSPC(.STAT,+DFN,+SD) D  Q RETURN
 . D ERRX^SDAPIE(.RETURN,"APTCNPE",.TXT)
 S RETURN=1
 Q RETURN
 ;
CHKSPC(RETURN,DFN,SD) ; Check if status permit cancelation
 N APT0,STATUS,IND,STAT,STATS
 K RETURN S RETURN=0
 S APT0=$$GETAPT0^SDMDAL2(+DFN,+SD)
 S STATUS=+$$STATUS^SDAM1(+DFN,+SD,+$G(APT0),$G(APT0))
 D LSTCSTA1^SDMDAL2(.STAT)
 D BLDLST^SDMAPI(.STATS,.STAT)
 S IND=0
 F  S IND=$O(STATS(IND)) Q:IND=""!(RETURN=1)  D
 . I STATS(IND,"ID")=STATUS S RETURN=1 Q
 Q RETURN
 ;
CHKPAT(RETURN,DFN) ; Check patient
 N PAT
 K RETURN S RETURN=0
 I '+$G(DFN) D ERRX^SDAPIE(.RETURN,"INVPARAM","DFN") Q 0
 I '$$PATEXST^SDMDAL3(+DFN) D ERRX^SDAPIE(.RETURN,"PATNFND") Q 0
 S RETURN=1
 Q 1
CHKCLN(RETURN,SC) ; Check patient
 N PAT
 K RETURN S RETURN=0
 I '+$G(SC) D ERRX^SDAPIE(.RETURN,"INVPARAM","SC") Q 0
 I '$$CLNEXST^SDMDAL3(+SC) D ERRX^SDAPIE(.RETURN,"CLNNFND") Q 0
 S RETURN=1
 Q 1
CHKOVB(RETURN,CLN,SC,SD,LEN,LVL) ; Check overbook
 N TXT,ACC,SM,MAXOB,OBNO,PP,KEYS
 S RETURN=1 S:'$G(LVL) LVL=7
 S SM=$$DECAVA(.CLN,+SC,+SD,+LEN,.PP)
 Q:'SM 0
 S KEYS("SDOB")="",KEYS("SDMOB")=""
 D GETXUS^SDMDAL3(.ACC,.KEYS,DUZ)
 I '$D(ACC("SDOB")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNOST") Q 0
 S MAXOB=CLN(1918)
 S OBNO=$$GETOBNO(+SC,+SD)
 S TXT(1)=MAXOB,TXT(2)=$S(OBNO>1:"S",1:"")
 I OBNO>MAXOB,'$D(ACC("SDMOB")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOAPD",.TXT) Q 0
 I OBNO>MAXOB,+LVL>1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTEXOB",,2) Q 0
 I SM=6,+LVL>1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOVBK",,2) Q 0
 I SM=7 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOVOS",,2) Q 0
 I SM=1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCBCP") Q 0
 Q RETURN
 ;
GETOBNO(SC,SD) ;
 N IND,CNT,APTS
 S IND="",CNT=0
 D GETDAYA^SDMDAL1(.APTS,+SC,+SD)
 F  S IND=$O(APTS(IND)) Q:IND=""  S:APTS(IND,"OB")>0 CNT=CNT+1
 Q CNT
 ;
DECAVA(CLN,SC,SD,LEN,PATT) ; Decrease availability
 N AV,S,SB,X,Y,I,SS,ST,STR,STARTDAY,HSI,SI,SDDIF,SM,CAN,SDNOT
 S SM=0,CAN=0
 D GETPATT^SDMDAL1(.AV,+SC,+SD)
 S S=$G(AV(0)),SB=CLN(1914)
 S STARTDAY=$S($L(SB):SB,1:8),SB=STARTDAY-1/100
 S X=CLN(1917),HSI=$S(X=1:X,X:X,1:4),SI=$S(X="":4,X<3:4,X:X,1:4)
 S STR="#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz",SDDIF=$S(HSI<3:8/HSI,1:2)
 S I=SD#1-SB*100,ST=I#1*SI\.6+($P(I,".")*SI),SS=LEN*HSI/60*SDDIF+ST+ST
 I SM<7 S %=$F(S,"[",SS-1) S:'%!(CLN(1917)<3) %=999 I $F(S,"]",SS)'<%!(SDDIF=2&$E(S,ST+ST+1,SS-1)["[") S SM=7
 I ST+ST>$L(S),$L(S)<80 S S=S_" "
 S SDNOT=1   ;SD*5.3*490 naked Do added below
 F I=ST+ST:SDDIF:SS-SDDIF S ST=$E(S,I+1) S:ST="" ST=" " S Y=$E(STR,$F(STR,ST)-2) S:S["CAN"!(ST="X"&($D(AV(1)))) CAN=1 Q:CAN  S:Y'?1NL&(SM<6) SM=6 S ST=$E(S,I+2,999) D  S:ST="" ST=" " S S=$E(S,1,I)_Y_ST
 .Q:ST'=""
 .Q:+LEN'>CLN(1912)
 .S ST="   "
 .Q
 S PATT=S
 Q:CAN CAN
 Q SM
 ;
DELCOL(RETURN,DFN,SD,SC,SDDA,SDOE,OE) ; Delete check out
 N SDATA,SDELHDL,SDORG,VSIT
 K RETURN S RETURN=0
 S SDORG=OE(.08),VSIT=OE(.05)
 I "^1^2^3^"[("^"_SDORG_"^") D DELCHLD(+SDOE)
 N PDATA
 I SDORG=1 D
 . S PDATA(21)="@"
 . N CDATA S CDATA(303)="@"
 . D UPDCAPT^SDMDAL4(.CDATA,+SC,+SD,SDDA)
 I SDORG=3 D
 . S PDATA(18)="@"
 D UPDPAPT^SDMDAL4(.PDATA,+DFN,+SD)
 D DELCLS^SDMDAL4(+SDOE)
 D DELOE(+SDOE,.OE)
 ; -- call pce to make sure its data is gone
 D DEAD^PXUTLSTP(VSIT)
 S RETURN=1
 Q 1
 ;
DELOE(SDOE,OE) ; Delete Outpatient Encounter
 I '$D(OE) D
 . S OE(.05)="",OE(.01)="",OE(.08)=""
 . D GETOE^SDMDAL4(.OE,+SDOE)
 I '$$NEW^SDPCE(OE(.01)) Q
 D DELOE^SDMDAL4(+SDOE)
 S X=$$KILL^VSITKIL(OE(.05))
 Q
 ;
DELCHLD(SDOEP) ;Delete Children
 N SDOEC,CHLD
 S SDOEC=0
 D GETCHLD^SDMDAL4(.CHLD,SDOEP)
 F  S SDOEC=$O(CHLD(SDOEC)) Q:'SDOEC  D
 . D DELOE(SDOEC)
 Q
 ;
