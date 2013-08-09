SDAVAPI ;RGI/VSL - AVAILABILITY API ; 7/22/13
 ;;5.3;Scheduling;**260003**;;
RESTAV(RETURN,SC,SD) ; Restore clinic availability
 ;Input:
 ;  .RETURN [Required,Array] Set to 1 if the operation succeeds
 ;                           Set to Error description if the call fails
 ;   SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;   SD [Required,DateTime] Date/time to restore clinic availability
 ;Output:
 ;  1=Success,0=Failure
 N %,PATT,SPATT,CANP,ERR,X,%DT,I5,DOW,SDBEG,SDEND,STARTDAY,SDREST
 N CLN,FR,HOLD,SDFR1,SI,TO,TXT,Y
 K RETURN
 S %=$$GETCANP^SDAVAPI(.CANP,.SC,.SD)
 I 'CANP M RETURN=CANP Q 0
 S RETURN=0
 D GETPATT^SDMDAL1(.PATT,+SC,+SD)
 I $G(PATT(0))["X" D  Q:ERR 0
 . S X=+SD,%DT="SXT" D ^%DT
 . S ERR=$S('Y:1,Y'?7N1".".N:1,1:0) D:ERR ERRX^SDAPIE(.RETURN,"INVPARAM","SD")
 D GETCLN^SDAVDAL(.CLN,+SC,"1914;1917;2505;2506")
 I CLN(2505,"I"),$P(SD,".")'<CLN(2505,"I"),$S('CLN(2506,"I"):1,CLN(2506,"I")>$P(SD,".")!('CLN(2506,"I")):1,1:0) D  Q 0
 . S TXT(1)=$$DTS^SDMAPI(CLN(2505,"I"))
 . S:CLN(2506,"I") TXT(2)=" "_$$EZBLD^DIALOG(480000.133)_" "_$$DTS^SDMAPI(CLN(2506,"I"))
 . S TXT(1)=$S(CLN(2506,"I"):$$EZBLD^DIALOG(480000.134)_" ",1:$$EZBLD^DIALOG(480000.135))_TXT(1)_$G(TXT(2))
 . S RETURN=0 D ERRX^SDAPIE(.RETURN,"RESTCIN",.TXT)
 I '$D(PATT(0))!($G(PATT(0))'["CANCELLED"&($G(PATT(0))'["X")) D ERRX^SDAPIE(.RETURN,"RESTCNC") Q 0
 I $D(PATT(2)),PATT(2)="" D ERRX^SDAPIE(.RETURN,"RESTCBR") Q 0
 S %=CLN(1917,"I"),SI=$S(%="":4,%<3:4,%:%,1:4)
 S %=CLN(1914,"I"),STARTDAY=$S(%'="":%,1:8)
 S DOW=$$DOW^XLFDT(SD,1)
 I $D(PATT(2)) S SDREST=PATT(2),HOLD=PATT(2)
 E  D
 . S HOLD=$$GETTMPL^SDAVDAL(+SC,+SD,DOW)
 . S HOLD=$P("SU^MO^TU^WE^TH^FR^SA","^",DOW+1)_" "_$E(SD,6,7)_$J("",SI+SI-6)_HOLD
 . S SDREST=HOLD
 I PATT(0)["X" D
 . S FR=$P(CANP(+SD,"BEGIN"),".",2),SDBEG=$$TC($P(CANP(+SD,"BEGIN"),".",2),STARTDAY,SI)+SI+SI
 . S TO=CANP(+SD,"END"),SDEND=$$TC(CANP(+SD,"END"),STARTDAY,SI)+SI+SI
 . S SDFR1=$P(SD,".")+(FR/10000)
 . S HOLD=PATT(0),HOLD=$E(HOLD,1,SDBEG-1)_$E(SDREST,SDBEG,SDEND)_$E(HOLD,SDEND+1,80)
 . D DELSDCAN^SDAVDAL(+SC,+SD)
 . D DELSMES^SDAVDAL(+SC,+SD)
 I HOLD'["[" S I5=$F(HOLD,"|"),HOLD=$E(HOLD,1,(I5-2))_"["_$E(HOLD,I5,999)
 D SETPATT^SDAVDAL(+SC,$P(SD,"."),HOLD)
 I HOLD'["X" D DELSTCAN^SDAVDAL(+SC,$P(SD,"."))
 S RETURN=1
 Q 1
 ;
GETCANP(RETURN,SC,SD) ; Get cancelled periods
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN(T) [Array] Array of cancelled periods. T is the date/time when cancel period begin.
 ;        RETURN(T,"BEGIN") [DateTime] Cancel date/time begin
 ;       RETURN(T,"END") [String] Cancel ending time
 ;       RETURN(T,"MESS") [String] Cancel message
 ;   SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;   SD [Required,Date] Date for desired cancelled periods
 ;Output:
 ;  1=Success,0=Failure
 N %
 S %=$$CLNCK^SDMAPI1(.RETURN,.SC) Q:'% 0
 I '$G(SD)!($G(SD)<1800000) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 D GETCANP^SDAVDAL(.RETURN,+SC,+$P(SD,"."))
 S RETURN=1
 Q 1
 ;
TC(X,STARTDAY,SI) N % S %=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2
 Q %
 ;
ADDHOL(RETURN,HDT,NAME) ; Add holiday
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  HDT [Required,DateTime] The date for the observance of the holiday.
 ;  NAME [Optional,String] Name of the holiday.
 ;Output:
 ;  1=Success,0=Failure
 N PAR,HOL K RETURN S RETURN=0
 I '$G(HDT)!($G(HDT)<1800000) D ERRX^SDAPIE(.RETURN,"INVPARAM","HDT") Q 0
 D GETHOL^SDMDAL1(.HOL,+$P(HDT,"."))
 I $D(HOL(+$P(HDT,"."))) D ERRX^SDAPIE(.RETURN,"HOLAEXST") Q 0
 I $G(NAME)'="",$L(NAME)<3!($L(NAME)>40) D ERRX^SDAPIE(.RETURN,"INVPARAM","NAME") Q 0
 S PAR(.01)=+$P(HDT,".")
 S PAR(2)=$G(NAME)
 D ADDHOL^SDAVDAL(.RETURN,.PAR)
 S RETURN=1
 Q 1
 ;
UPDHOL(RETURN,HDT,NAME) ; Update holiday
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  HDT [Required,DateTime] The date for the observance of the holiday.
 ;  NAME [Optional,String] Name of the holiday.
 ;Output:
 ;  1=Success,0=Failure
 N PAR,HOL K RETURN S RETURN=0
 I '$G(HDT)!($G(HDT)<1800000) D ERRX^SDAPIE(.RETURN,"INVPARAM","HDT") Q 0
 D GETHOL^SDMDAL1(.HOL,+$P(HDT,"."))
 I '$D(HOL(+$P(HDT,"."))) D ERRX^SDAPIE(.RETURN,"HOLNFND") Q 0
 I $G(NAME)'="",$L(NAME)<3!($L(NAME)>40) D ERRX^SDAPIE(.RETURN,"INVPARAM","NAME") Q 0
 S PAR(2)=$G(NAME)
 D UPDHOL^SDAVDAL(.RETURN,+$P(HDT,"."),.PAR)
 S RETURN=1
 Q 1
 ;
DELHOL(RETURN,HDT) ; Delete holiday
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   HDT [Required,DateTime] The date of the holiday to delete.
 ;Output:
 ;  1=Success,0=Failure
 N HOL K RETURN S RETURN=0
 I '$G(HDT)!($G(HDT)<1800000) D ERRX^SDAPIE(.RETURN,"INVPARAM","HDT") Q 0
 D GETHOL^SDMDAL1(.HOL,+$P(HDT,"."))
 I '$D(HOL(+$P(HDT,"."))) D ERRX^SDAPIE(.RETURN,"HOLNFND") Q 0
 D DELHOL^SDAVDAL(.RETURN,+$P(HDT,"."))
 S RETURN=1
 Q 1
 ;
REMAP(RETURN,SC,SDBD,SDED) ; Remap Clinic
 ;Input:
 ;  .RETURN [Required,Array] Set to 1 if the operation succeeds
 ;                           Set to Error description if the call fails
 ;      RETURN(0) [Numeric] Number of the warning messages
 ;          RETURN(#,"CLNIC") [String] Clinic (from the Hospital Location file #44 in internal^external)
 ;          RETURN(#,"DATE") [Date] Availability date for which the warning occurred
 ;          RETURN(#,"MSG") [String] Warning message. One of:
 ;              "Bogus clinic day- Appts!" - when the date and day of the week do not correspond
 ;              "[HOLIDAY NAME]- Appts!" - when appointments exist on a holiday and the clinic
 ;                                         does not schedule on holidays
 ;              "no master pattern for this day" - when no day of the week template exists for this day of the week
 ;              "Cancelled" - when availability was cancelled
 ;   SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;   SDBD [Required,Date] Begining date for the remap
 ;   SDED [Required,Date] Ending date for the remap
 ;Output:
 ;  1=Success,0=Failure
 N %,CLN,FLDS,SL,X,STARTDAY,HSI,SI,SDSI,SDSOH,SDIN,SDRE,SDNODE,DATE
 K RETURN S RETURN=0
 S %=$$CHKCLN^SDMAPI3(.RETURN,.SC) Q:'RETURN 0
 S RETURN=0
 I '$G(SDBD)!($G(SDBD)<1800000) D ERRX^SDAPIE(.RETURN,"INVPARAM","SDBD") Q 0
 I '$G(SDED)!($G(SDED)<1800000) D ERRX^SDAPIE(.RETURN,"INVPARAM","SDED") Q 0
 I SDED<SDBD D ERRX^SDAPIE(.RETURN,"REMEDABD") Q 0
 ;;      DIV;LEN;START;INCR;ONHOLI;INAC;REAC;
 S FLDS=".01;3.5;1912;1914;1917;1918.5;2505;2506;"
 D GETCLN^SDAVDAL(.CLN,+SC,FLDS)
 D GETSCSL^SDAVDAL(.SL,+SC)
 S SC=+SC_U_CLN(.01,"E")
 I SL=""!'CLN(3.5,"I") D ERRX^SDAPIE(.RETURN,"CLNINV",$S(SL="":"SL node",1:"Division")) Q 0
 S SDBD=$P(SDBD,"."),SDED=$P(SDED,".")
 S SL=CLN(1912,"I"),X=CLN(1914,"I"),STARTDAY=$S($L(X):X,1:8)
 S X=CLN(1917,"I"),HSI=$S('X:4,X<3:8/X,1:2),SI=$S(X:X,1:4),SDSI=SI
 S:SI=1 SI=4 S:SI=2 SI=4
 S SDSOH=$S(CLN(1918.5,"I")']"":0,1:1)
 I CLN(2505,"I") S SDIN=CLN(2505,"I"),SDRE=CLN(2506,"I")
 F DATE=$$FMADD^XLFDT(+SDBD,-1):0 S DATE=$$FMADD^XLFDT(+DATE,1) Q:DATE'>0!(DATE>SDED)  D
 . I $S('$D(SDIN):1,'SDIN:1,SDIN>DATE:1,SDRE'>DATE&(SDRE):1,1:0) D
 . . D REMDATE(.RETURN,SC,DATE,SDSOH,SI,HSI,STARTDAY,SDSI,SL)
 S RETURN=1
 Q 1
 ;
REMDATE(RETURN,SC,DATE,SDSOH,SI,HSI,STARTDAY,SDSI,SL) ; Remap date
 N X,Y,DAY,DOW,PATT,HOL,DATE2,APTS,MSG,SB,SDAPPT,SM,SS
 S DATE2=$$FMADD^XLFDT(DATE,1),DATE2=$$FMADD^XLFDT(DATE2,,,-1)
 S X=DATE D DW^%DTC S DAY=$P("SUN^MON^TUES^WEDNES^THURS^FRI^SATUR",U,Y+1),DOW=Y
 D LSTCAPTS^SDAVDAL(.APTS,+SC,DATE,DATE2)
 S SDAPPT=($D(APTS)>1)
 D GETPATT^SDMDAL1(.PATT,+SC,+DATE)
 I $D(PATT(0)),PATT(0)'[$E(DAY,1,2)&(PATT(0)["]") S MSG="Bogus clinic day"_$S(SDAPPT:"- Appts!",1:"") D MSG(.RETURN,SC,DATE,MSG)
 I $D(PATT(0)),PATT(0)["CANCEL"!($E(PATT(0),$F(PATT(0),"["),999)?."X") S MSG="Cancelled" D MSG(.RETURN,SC,DATE,MSG) Q
 D GETHOL^SDMDAL1(.HOL,+DATE)
 I $D(HOL(DATE)),'SDSOH D  Q
 . N POS
 . I 'SDAPPT D SETPATT^SDAVDAL(+SC,DATE,"   "_$E(DATE,6,7)_"    "_$P(HOL(DATE),U,2)) S POS="- Inserted" I 1
 . E  S POS="- Appts!"
 . D MSG(.RETURN,SC,DATE,$P(HOL(DATE),U,2)_POS)
 D DELPATT^SDAVDAL(+SC,DATE)
 S SM=$$GETTMPL^SDAVDAL(+SC,DATE,DOW),SM=$$SM(SM,DOW,DATE,SI),SS=1
 I $D(PATT(2)),PATT(2)]"" S SM=PATT(2),SS=0
 I $$GETTMPL^SDAVDAL(+SC,DATE,DOW)="" D:$D(PATT(0)) MSG(.RETURN,SC,DATE,"no master pattern for this day") Q
 I SDAPPT S SM=$$GETSM(.APTS,SM,DATE,STARTDAY,SI,SC,HSI,SDSI,SL)
 I $L(SM)>SM D SETPATT^SDAVDAL(+SC,DATE,SM,$S('SS:1,1:0))
 Q
 ;
GETSM(APTS,SM,DATE,STARTDAY,SI,SC,HSI,SDSI,SL) ; Update pattern
 N DR,I,S,APT,SB,STR,SDSL,ST
 S SB=STARTDAY-1/100,STR="{}&%?#@!$* XXWVUTSRQPONMLKJIHGFEDCBA0123456789jklmnopqrstuvwxyz"
 F DR=0:0 S DR=$O(APTS(DR)) Q:'DR  D
 . S I=APTS(DR,"DATE")#1-SB*100,I=I#1*SI\.6+(I\1*SI)*2,S=$E(SM,I,999),SM=$E(SM,1,I-1)
 . I $D(APTS(DR,"MES")) S SM=$$CAN(APTS(DR,"DATE"),SC,STARTDAY,SI,S,SM) Q
 . S APT=APTS(DR,"APT")
 . I $P(APT,"^",9)'["C" S SDSL=$P(APT,U,2)/SL*(SL\(60/SDSI))*HSI-HSI F I=0:HSI:SDSL S ST=$E(S,I+2) S:ST="" ST=" " S S=$E(S,1,I+2-1)_$E(STR,$F(STR,ST)-2)_$E(S,I+3,999)
 . S SM=SM_S
 Q SM
 ;
CAN(DR,SC,STARTDAY,SI,S,SM) ; Cancelled periods
 N %,CANP,EN,ST,X,I,P,Y
 S %=$$GETCANP^SDAVAPI(.CANP,.SC,.DR)
 Q:'$D(CANP)
 S I=SM_S
 S ST=$$TT($E($P(DR,".",2)_"0000",1,4),STARTDAY,SI)
 S EN=$$TT(CANP(DR,"END"),STARTDAY,SI)
 S I=I_$J("",EN-$L(I)),Y=""
 F X=0:2:EN S S=$E(I,X+SI+SI),P=$S(X<ST:S_$E(I,X+1+SI+SI),X=EN:$S(Y="[":Y,1:S)_$E(I,X+1+SI+SI),1:$S(Y="["&(X=ST):"]",1:"X")_"X"),Y=$S(S="]":"",S="[":S,1:Y),I=$E(I,1,X-1+SI+SI)_P_$E(I,X+2+SI+SI,999)
 S SM=I Q SM
 ;
TT(X,STARTDAY,SI) ; Get time position
 S %=$E(X,3,4),%=X\100-STARTDAY*SI+(%*SI\60)*2
 Q %
 ;
MSG(RETURN,SC,DATE,MSG) ; Message
 S RETURN(0)=$G(RETURN(0))+1
 S RETURN(RETURN(0),"MSG")=MSG
 S RETURN(RETURN(0),"CLINIC")=SC
 S RETURN(RETURN(0),"DATE")=DATE
 Q
 ;
SM(DH,DOW,DATE,SI) ; Get pattern
 N SM
 S SM=$P("SU^MO^TU^WE^TH^FR^SA",U,DOW+1)_" "_$E(DATE,6,7)_$J("",SI+SI-6)_DH_$J("",64-$L(DH))
 Q SM
