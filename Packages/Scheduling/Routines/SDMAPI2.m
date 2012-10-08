SDMAPI2 ;RGI/CBR - APPOINTMENT API; 10/08/2012
 ;;5.3;scheduling;**260003**;08/13/93
CHKAPP(RETURN,SC,DFN,SD,LEN,LVL) ; Check make appointment
 N PAT,CLN,VAL,PATT,HOL,TXT,X1,X2,APT,CAPT,FRSTA,SDEDT,SDSOH
 K RETURN
 S RETURN=1
 S:'$G(LVL) LVL=7
 D GETPAT^SDMDAL3(.PAT,DFN,1) ; get patient data
 D GETCLN^SDMDAL1(.CLN,SC,1) ; get clinic data
 ;check patient, stop code and inactive
 S %=$$CHKAPTU(.RETURN,SC,DFN,SD,.CLN,.PAT) Q:RETURN=0 0
 ;check user permissions
 S VAL=$$CLNRGHT^SDMAPI1(.RETURN,SC) Q:VAL=0 VAL
 S %=$$SETST^SDMAPI4(.RETURN,SC,SD) Q:RETURN=0 0
 ;verify that day hasn't been canceled via "SET UP A CLINIC"
 D GETPATT^SDMDAL1(.PATT,SC,SD) I $G(PATT(0))'["[" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCLUV") Q 0
 ;check if schedule on holiday is permited
 D GETHOL^SDMDAL1(.HOL,$P(SD,"."))
 S SDSOH=$S('$D(CLN(1918.5)):0,CLN(1918.5)']"":0,1:1)
 I $D(HOL(0)),'SDSOH S TXT(1)=$P(HOL(0),U,2) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTSHOL",.TXT) Q 0
 ;check if exceed max days for future appointment
 S X1=DT,SDEDT=$G(CLN(2002))
 S:SDEDT'>0 SDEDT=365
 S X2=SDEDT D C^%DTC S SDEDT=X
 I $P(SD,".")'<SDEDT S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTEXCD") Q 0
 ;check if patient has an active appointment on the same time
 D GETAPTS^SDMDAL2(.APT,DFN,SD)
 I $D(APT),APT("APT",SD,"STATUS")'["C"  D
 . D GETSCAP^SDMAPI1(.CAPT,SC,DFN,SD) Q:'$D(CAPT)
 . S TXT(1)="("_CAPT("LENGTH")_" MINUTES)"
 . S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPAHA",.TXT,2)
 Q:RETURN=0 0
 ;check if patient has an active appointment on the same day
 I LVL>2 D
 . K APT N IDX S IDX=""
 . D GETDAPTS^SDMDAL2(.APT,DFN,$P(SD,"."))
 . F  S IDX=$O(APT(IDX)) Q:IDX=""  I APT(IDX,2)'["C"  D  Q
 . . K TXT S TXT(1)="(AT "_$E(IDX_0,9,10)_":"_$E(IDX_"000",11,12)_")"
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPHSD",.TXT,3)
 Q:RETURN=0 0
 ;check if patient has an canceled appointment on the same time
 I LVL'<2 D
 . K APT
 . D GETAPTS^SDMDAL2(.APT,DFN,SD)
 . I $D(APT),APT("APT",SD,"STATUS")["P" D 
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPPCP",,2)
 Q:RETURN=0 0
 ;check if date is prior to patient birth date
 I $P(SD,".",1)<$P(PAT(.03),U,1) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPPAB") Q RETURN
 ;check if date is prior to clinic availability
 S FRSTA=$$GETFSTA^SDMDAL1(SC) I FRSTA,$P(SD,".",1)<FRSTA S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPCLA") Q 0
 ;check overbook
 S %=$$CHKOVB(.RETURN,.CLN,SC,SD,LEN,LVL) Q:RETURN=0 RETURN
 S RETURN=1
 Q RETURN
 ;
CHKOVB(RETURN,CLN,SC,SD,LEN,LVL) ; Check overbook
 N TXT,ACC,SM,MAXOB,OBNO,PP
 S RETURN=1 S:'$G(LVL) LVL=7
 S SM=$$DECAVA(.CLN,SC,SD,LEN,.PP)
 Q:'SM 0
 D GETXUS^SDMDAL3(.ACC,DUZ)
 I '$D(ACC("SDOB")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNOST") Q 0
 S MAXOB=CLN(1918)
 S OBNO=$$GETOBNO(SC,SD)
 S TXT(1)=MAXOB,TXT(2)=$S(OBNO>1:"S",1:"") 
 I OBNO>MAXOB,'$D(ACC("SDMOB")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOAPD",.TXT) Q 0
 I OBNO>MAXOB,LVL>1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTEXOB",,2) Q 0
 I SM=6,LVL>1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOVBK",,2) Q 0
 I SM=7 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTOVOS",,2) Q 0
 I SM=1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCBCP") Q 0
 Q RETURN
 ;
GETOBNO(SC,SD) ;
 N IND,CNT,APTS
 S IND="",CNT=0
 D GETDAYA^SDMDAL1(.APTS,SC,SD)
 F  S IND=$O(APTS(IND)) Q:IND=""  S:APTS(IND,"OB")>0 CNT=CNT+1
 Q CNT
 ;
CHKAPTU(RETURN,SC,DFN,SD,CLN,PAT) ; Check make unscheduled appointment
 N PAPT,PAT,CLN,TXT
 D:'$D(PAT) GETPAT^SDMDAL3(.PAT,DFN,1) ; get patient data
 D:'$D(CLN) GETCLN^SDMDAL1(.CLN,SC,1) ; get clinic data
 ;check if patient already has appointment
 S PAPT(.01)="" D GETPAPT^SDMDAL2(.PAPT,DFN,SD)
 S TXT(1)=$$FTIME^VALM1(SD)
 I PAPT(.01)>0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTPAHU",.TXT) Q RETURN
 ;check if patient is dead
 I +$G(PAT(.351))>0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"PATDIED") Q RETURN
 ;check if clinic is valid (stop code)
 S VAL=$$CLNCK^SDMAPI1(.RETURN,SC) Q:VAL=0 VAL
 ;check inactive clinic period
 I CLN(2505),$P(SD,".")'<CLN(2505),$S('CLN(2506):1,CLN(2506)>$P(SD,".")!('CLN(2506)):1,1:0) D  Q 0
 . S TXT(1)=$$DTS^SDMAPI(CLN(2505))
 . S:CLN(2506) TXT(2)=" and reactivated on "_$$DTS^SDMAPI(CLN(2506))
 . S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCINV",.TXT) 
 Q 1
 ;
MAKEUS(RETURN,DFN,SC,SD,TYP,STYP) ; Make unscheduled appointment
 N SCAP,STAT,CHKIN
 S RETURN=0
 S %=$$CHKAPTU(.RETURN,SC,DFN,SD) Q:RETURN=0 0
 S STAT=$$INP^SDAM2(DFN,SD)
 D GETCLN^SDMDAL1(.CLN,SC,1)
 D MAKE^SDMDAL3(DFN,SD,SC,TYP,.STYP,STAT,4,DUZ,DT,"W",0)
 D MAKE^SDMDAL1(SC,SD,DFN,CLN(1912),,DUZ)
 S %=$$LOCKST^SDMDAL1(SC,SD) I '% S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTLOCK") Q 0
 S SM=$$DECAVA(.CLN,SC,SD,CLN(1912),.S)
 D SETST^SDMDAL1(SC,SD,S)
 D UNLCKST^SDMDAL1(SC,SD)
 D GETSCAP^SDMAPI1(.SCAP,SC,DFN,SD)
 D MAKE^SDAMEVT(DFN,SD,SC,SCAP("IFN"))
 Q 1
 ;
MAKE(RETURN,DFN,SC,SD,TYPE,STYP,LEN,SRT,OTHR,CIO,LAB,XRAY,EKG,RQXRAY,LVL) ; Make appointment
 S:'$G(LVL) LVL=7
 S RETURN=1
 F I="SC","DFN","SD","LEN" I '$D(@I) S RETURN=0,TXT(1)=I D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT)
 I RETURN=0 Q 0
 S %=$$CHKAPP(.RETURN,SC,DFN,SD,LEN,LVL)
 I RETURN=0,$P(RETURN(0),U,3)'>LVL Q RETURN
 I RETURN=0,$P(RETURN(0),U)="APTPAHA" D
 . D CANCEL(.RETURN,DFN,SC,SD,"C",13,"")
 E  Q:'$G(RETURN)&('$G(LVL)) 0
 N CLN,S,SM,SDY,SCAP,SRT0
 S %=$$LOCKST^SDMDAL1(SC,SD) I '% S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTLOCK") Q 0
 S %=$$LOCKS^SDMDAL1(SC,SD) I '% S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTLOCK") Q 0
 D GETCLN^SDMDAL1(.CLN,SC,1)
 S SM=$$DECAVA(.CLN,SC,SD,+LEN,.S)
 D SETST^SDMDAL1(SC,SD,S)
 D MAKE^SDMDAL1(SC,SD,DFN,+LEN,SM,DUZ,$G(OTHR),.RQXRAY)
 D UNLCKS^SDMDAL1(SC,SD)
 D UNLCKST^SDMDAL1(SC,SD)
 S STAT=$$INP^SDAM2(DFN,SD)
 S:SD<DT SRT="W"
 S SRT0=$$NAVA^SDMANA(SC,SD,.SRT)
 D MAKE^SDMDAL3(DFN,SD,SC,.TYPE,.STYP,STAT,3,DUZ,DT,SRT,SRT0,.LAB,.XRAY,.EKG)
 N DATA S DATA(27)=DT,DATA(28)=$$PTFU^SDMAPI1(,DFN,SC)
 D UPDPAPT^SDMDAL4(.DATA,DFN,SD)
 D GETSCAP^SDMAPI1(.SCAP,SC,DFN,SD)
 D MAKE^SDAMEVT(DFN,SD,SC,$G(SCAP("IFN")))
 I $D(CIO),CIO="CI" S %=$$CHECKIN^SDMAPI2(.CHKIN,DFN,SD,SC,SD)
 Q 1
 ;
DECAVA(CLN,SC,SD,LEN,PATT) ; Decrease availability
 N AV,S,SB,X,Y,I,SS,ST,STR,STARTDAY,HSI,SI,SDDIF,SM,CAN,SDNOT
 S SM=0,CAN=0
 D GETPATT^SDMDAL1(.AV,SC,SD)
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
CANCEL(RETURN,DFN,SC,SD,TYP,RSN,RMK) ; Cancel appointment
 N CDATE,CDT,ERR,ODT,OIFN,OUSR
 S RETURN=0
 D CHKCAN^SDMAPI3(.RETURN,DFN,SC,SD) Q:RETURN=0 0
 S CDATE=$$NOW^XLFDT
 D GETSCAP^SDMAPI1(.CAPT,SC,DFN,SD)
 S CIFN=CAPT("IFN")
 S OUSR=CAPT("USER"),ODT=CAPT("DATE")
 N SDATA,SDCPHDL
 S SDCPHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCPHDL)
 S CDT=$$NOW^XLFDT()
 D CANCEL^SDMDAL3(.ERR,DFN,SD,TYP,RSN,RMK,$E(CDT,1,12),DUZ,OUSR,ODT)
 S OIFN=$$COVERB^SDMDAL1(SC,SD,CIFN)
 D CANCEL^SDMDAL1(SC,SD,DFN,CIFN)
 D CANCEL^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,0,SDCPHDL)
 S RETURN=1
 Q RETURN
 ;
CHECKIN(RETURN,DFN,SD,SC,CIDT) ; Check in appointment
 N CAPT
 D GETSCAP^SDMAPI1(.CAPT,SC,DFN,SD)
 S CIFN=CAPT("IFN")
 I 'CIFN D ERRX^SDAPIE(.RETURN,"APTCIPE") Q 0
 N SDATA,SDCIHDL,X 
 S SDATA=CIFN_U_DFN_U_SD_U_SC,SDCIHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCIHDL)
 S %=$$CHKCIN^SDMAPI3(.RETURN,DFN,SD,+SDATA("BEFORE","STATUS")) Q:'% 0
 S CD(302)=DUZ,CD(309)=$E(CIDT,1,12)
 D UPDCAPT^SDMDAL4(.CD,SC,SD,CAPT("IFN"))
 D AFTER^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDCIHDL)
 M RETURN=SDATA
 I SDATA("BEFORE","STATUS")'=SDATA("AFTER","STATUS") D
 . D EVT^SDAMEVT(.SDATA,4,0,SDCIHDL) ; 4 := ci evt , 0 := interactive mode
 Q 1
 ;
NOSHOW(RETURN,DFN,SC,SD,LVL) ; No-show appointment
 N APT0,STATUS,APTSTAT,AUTO,CNSTLNK,NSDA,NSDIE
 S:'$D(LVL) LVL=7
 S APT0=$$GETAPT0^SDMDAL2(DFN,SD)
 S APTSTAT=$P(APT0,U,2)
 S STATUS=$$STATUS^SDAM1(DFN,SD,+$G(APT0),$G(APT0))
 S RETURN=0
 S %=$$CHKNS^SDMAPI3(.RETURN,APT0,+STATUS,LVL)
 I RETURN=0,$P(RETURN(0),U,3)'>LVL Q RETURN
 N FDA,CIFN,CAPT
 D GETSCAP^SDMAPI1(.CAPT,SC,DFN,SD)
 S CIFN=CAPT("IFN")
 S CNSTLNK=$G(CAPT("CONSULT"))
 S RETURN("BEFORE")=STATUS
 N SDNSHDL S SDNSHDL=$$HANDLE^SDAMEVT(1)
 D BEFORE^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,SDNSHDL)
 I APTSTAT=""!(APTSTAT="NT") D
 . S FDA(3)="N",FDA(14)=DUZ,FDA(15)=$$NOW^XLFDT()
 E  D
 . S FDA(3)="@",FDA(14)="@",FDA(15)="@"
 D UPDPAPT^SDMDAL4(.FDA,DFN,SD)
 D NOSHOW^SDAMEVT(.SDATA,DFN,SD,SC,CIFN,2,SDNSHDL)
 D:+$G(CNSTLNK) NOSHOW^SDCNSLT(SC,SD,DFN,CNSTLNK,CIFN,.AUTO,.NSDIE,.NSDA)
 S APT0=$$GETAPT0^SDMDAL2(DFN,SD)
 S APTSTAT=$P(APT0,U,2)
 S STATUS=$$STATUS^SDAM1(DFN,SD,+$G(APT0),$G(APT0))
 S RETURN("AFTER")=STATUS
 Q 1
 ;
