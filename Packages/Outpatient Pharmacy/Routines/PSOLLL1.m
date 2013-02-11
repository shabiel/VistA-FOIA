PSOLLL1 ;BIR/BHW - LASER LABELS ;10/24/2002
 ;;7.0;OUTPATIENT PHARMACY;**120,141,135,162,161,233,200,264,326,338,367**;DEC 1997;Build 62
 ;
 ;Reference to ^PSDRUG supported by DBIA 221
 ;Reference ^VA(200,D0,"PS" supported by DBIA 224
 ;External reference to ^PS(55 supported by DBIA 2228
 ;
ST I $P($G(^PSRX(RX,3)),"^",3) S PSOPROV=+$P(^(0),"^",4),PSOPROV=$S($G(RXP):+$P($G(RXP),"^",17),$G(RXF):+$P($G(^PSRX(RX,1,RXF,0)),"^",17),1:PSOPROV) S:'$G(PSOPROV) PSOPROV=+$P(^PSRX(RX,0),"^",4) D
 . I +$P($G(^VA(200,PSOPROV,"PS")),"^",7) S:'$P($G(PHYS),"/",2) PHYS=$G(PHYS)_"/"_+$P($G(^PSRX(RX,3)),"^",3)
 S $P(ULN,"_",34)="",PSOTRAIL=1
 S (Y,X1)=EXPDT X ^DD("DD") S EXPDT=Y,Y=$P(^PSRX(RX,0),"^",13) X ^DD("DD") S ISD=Y,X2=DT D ^%DTC S DIFF=X
 S Y=DATE X ^DD("DD") S DATE=Y
 S TECH="("_$S($P($G(^PSRX(+$G(RX),"OR1")),"^",5):$P($G(^PSRX(+$G(RX),"OR1")),"^",5),1:$P(RXY,"^",16))_"/"_$S($G(VRPH)&($P(PSOPAR,"^",32)):VRPH,1:" ")_")"
 S PSZIP=$P(PS,"^",5),PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
L1 I $G(PSOIO("BLH"))]"" X PSOIO("BLH")
 I 'SIGF,'SIGM,'PMIM K PSOSTLK,ZTKDRUG I $L($T(PSOSTALK^PSOTALK1)) D PSOSTALK^PSOTALK1 D  S PSOSTLK=1 ; PRINT ONE SCRIPTALK LABEL IF APPLICABLE
 .D 6^VADPT,PID^VADPT6 S SSNPN=""
 S T="VAMC "_$P(PS,"^",7)_", "_STATE_" "_$G(PSOHZIP) S:SIGF!($G(FILLCONT)) T=" " D PRINT(T)
 S T=$P(PS2,"^",2)_"  "_TECH_"  Ph: "_$P(PS,"^",3)_"-"_$P(PS,"^",4) S:SIGF!($G(FILLCONT)) T=" " D PRINT(T)
 S PSDU=$P($G(^PSDRUG($P($G(^PSRX(RX,0)),"^",6),660)),"^",8)
 I $G(PSOIO("BLB"))]"" X PSOIO("BLB")
 S XFONT=$E(PSOFONT,2,99)
 S T="Rx# "_RXN_"  " S:SIGF!($G(FILLCONT)) T=" " D PRINT(T,1)
 D STRT^PSOLLU1("RX#",T,.L) S PSOY=PSOY-PSOYI,OPSOX=PSOX,PSOX=L(XFONT)*300+PSOX
 S DR=$G(SIGF("DR"))
 S T="  "_DATE_"  "_$S('SIGF:"Fill "_(RXF+1)_" of "_(1+$P(RXY,"^",9)),1:"(label continued)") S:SIGF!($G(FILLCONT)) T=" " D PRINT(T)
 S PSOX=OPSOX,T=PNM S:SIGF!($G(FILLCONT)) T=" " I T'=" " D PRINT(T,1)
 I DR>1 S PSOX=OPSOX,T="Rx# "_RXN_"  (label continued)" D PRINT(T)
 D STRT^PSOLLU1("SIG",T,.L)
 S OPSOX=PSOX,PSOX=L(XFONT)*300+PSOX,PSOY=PSOY-PSOYI,T="  "_$G(SSNPN) S:SIGF!($G(FILLCONT)) T=" " D PRINT(T)
 S PSOX=OPSOX,LENGTH=0,PTEXT="",SIGF=0,XFONT=$E(PSOFONT,2,99)
 N DP,TEXTP,TEXTL,MORE
 I 'SIGM,'$G(FILLCONT) D COUNTSG^PSOLLLW
 S DR=SIGF("DR")
 I DR>1,'$D(NSGY(DR,4)) D
 .F I=4:-1:1 Q:$D(NSGY(DR,I))  S T=" " D PRINT(T) ; BOTTOM-JUSTIFY CONTINUED BOTTLE SIG JUST ABOVE 'DISCARD' LINE
 F I=1:1 Q:'$D(NSGY(DR,I))  S TEXT=NSGY(DR,I) D PRINT(TEXT)
 I I>4,$D(NSGY(DR,5)) S SIGF=1,SIGF("DR")=DR+1
 I $G(PSOIO("BLF"))]"" X PSOIO("BLF")
 S PSOY=PSODY-PSOYI,PSOFONT=PSODFONT
 I SIGF G WARN:'SIGM&('$G(FILLCONT)),CONT
 I '$D(NSGY) G CONT
 K NSGY,^TMP($J,"PSOSIG",RX)
 D NOW^%DTC S X1=X,X2=365 D C^%DTC S Y=X X ^DD("DD")
 S DEA=$P($G(^PSDRUG($P(RXY,"^",6),0)),"^",3),T=""
 I DEA'["S" S T="Discard after "_$S(DEA[0!(DEA["M"):"_________",1:Y)_"__________   "
 S T=T_"Mfr_________" D PRINT(T)
 S PSOY=PSOY-5
 D  S PSOFONT="F8"  D PRINT(T)
 . S NOR=$P(RXY,"^",9)-RXF
 . I $P(RXY,"^",9)=0 S T="NO REFILL" Q
 . I NOR=0 S T="NO REFILLS LEFT" Q
 . S T="May refill "_NOR_"X by "_EXPDT
 S PPHYS=$G(PHYS)
 S XFONT=$E(PSOQFONT,2,99)
 S TEXT="Qty: " D STRT^PSOLLU1("SIG",TEXT,.L) S Q(1)=L(XFONT)
 S TEXT=" "_PSDU D STRT^PSOLLU1("SIG",TEXT,.L) S Q(2)=L(XFONT)
 S TEXT="       "_$G(PHYS) D STRT^PSOLLU1("SIG",TEXT,.L) S Q(3)=L(XFONT)
 S TEXT=$G(QTY) D STRT^PSOLLU1("SIG",TEXT,.L) S LENGTH=Q(1)+Q(2)+Q(3)+L(XFONT+2),Q(4)=L(XFONT+2)
 I LENGTH>3 F I=$L(PHYS)-1:-1:1 S PPHYS=$E(PHYS,1,I),TEXT="       "_PPHYS D STRT^PSOLLU1("SIG",TEXT,.L) I Q(1)+Q(2)+Q(4)+L(XFONT)<3.3 Q 
 S PSOFONT=PSOTFONT,OPSOX=PSOX,PSOX=PSOX+(Q(1)*300),PSOY=PSOQY-PSOYI,T=$G(QTY) D PRINT(T)
 S PSOX=OPSOX,PSOFONT=PSOQFONT,PSOY=PSOY-PSOYI,T="Qty: " D PRINT(T)
 S PSOX=PSOX+(Q(1)+Q(4)*300),PSOY=PSOY-PSOYI,T=" "_$G(PSDU)_"       "_$G(PPHYS) D PRINT(T)
 S PSOFONT=PSOTFONT,PSOX=OPSOX,PSOY=PSOTY-PSOYI,T=DRUG D STRT^PSOLLU1("SIG",T,.L)
 I L($E(PSOFONT,2,99))>3 S PSOFONT=$S(PSOFONT="F12":"F10",PSOFONT="F10":"F9",PSOFONT="F9":F8,PSOFONT="F8":"F6")
 S ZTKDRUG="XXXXXX   SCRIPTALK RX   XXXXXX"
 I $G(PSOSTLK) S T=$S($G(PSOSTALK):ZTKDRUG,1:DRUG)
 D PRINT(T,1)
 I SIGM G CONT
 S ^PSRX(RX,"TYPE")=0
WARN ;PRINT WARNING LABELS
 I $G(PSOIO("WLI"))]"" X PSOIO("WLI")
 ; IF <5 WARNINGS, PRINT LABELS BOTTOM-JUSTIFIED
 K PSOWLBL
 S PSOLAN=$P($G(^PS(55,DFN,"LAN")),"^",2)
 S WARN5=WARN F  Q:$L(WARN5,",")>4  S WARN5=" ,"_WARN5
 F WWW=1:1:5 S PSOWARN=$P(WARN5,",",WWW) I PSOWARN'="" D
 . I PSOWARN["N" D NEWWARN^PSOLLLW Q
 . D WARN54^PSOLLLW
 ;RETURN MAIL
 S PS=$S($D(^PS(59,PSOSITE,0)):^(0),1:"") I $P(PSOSYS,"^",4),$D(^PS(59,+$P($G(PSOSYS),"^",4),0)) S PS=^PS(59,$P($G(PSOSYS),"^",4),0)
 S VAADDR1=$P(PS,"^"),VASTREET=$P(PS,"^",2),STATE=$S($D(^DIC(5,+$P(PS,"^",8),0)):$P(^(0),"^",2),1:"UNKNOWN")
 S PSZIP=$P(PS,"^",5),PSOHZIP=$S(PSZIP["-":PSZIP,1:$E(PSZIP,1,5)_$S($E(PSZIP,6,9)]"":"-"_$E(PSZIP,6,9),1:""))
 I $G(PSOIO("RMI"))]"" X PSOIO("RMI")
 S PSOYI=$G(PSOHYI,40),OFONT=PSOFONT,PSOFONT=$G(PSOHFONT)
 S BLNKLIN="",$P(BLNKLIN," ",40)=" "
 S T="Attn: (119)"_BLNKLIN_$$FMTE^XLFDT(DT) D PRINT(T,0)
 S T=$G(VASTREET) D PRINT(T,0)
 S T=$P(PS,"^",7)_", "_$G(STATE)_"  "_$G(PSOHZIP) D PRINT(T,0)
 S PSOY=PSOY+PSOYI,T=$S(PS55=2:"***DO NOT MAIL***",1:"") I T'="" D PRINT(T,0)
 I T'="***DO NOT MAIL***" S T=$S(PS55[0!(PS55[3)!(PS55=""):"REGULAR MAIL",1:"CERTIFIED MAIL") S T=T_"-"_$G(MAILCOM) S:$L(T)>25 PSOFONT="F8" D PRINT(T,0)
 S PSOFONT=OFONT
 S T=PNM
 S PSOY=PSOY+PSOYI,PSOYI=PSORYI D PRINT(T,0)
 I $G(VAPA(1))=""!(PS55=2) G W
 ; ADD CHECK FOR BAD ADDRESS INDICATOR OR FOREIGN ADDRESS
 N PSOBADR,PSOTEMP,PSOFORGN,I
 S PSOBADR=0,PSOTEMP=0
 S PSOFORGN=$P($G(VAPA(25)),"^",2) I PSOFORGN'="",PSOFORGN'["UNITED STATES" S PSOFORGN=1
 I 'PSOFORGN S PSOBADR=$$BADADR^DGUTL3(DFN)
 I 'PSOFORGN,PSOBADR S PSOTEMP=$$CHKTEMP^PSOBAI(DFN)
 F I=1:1:3 I $G(VAPA(I))]"" D
 . S T="" I I=1,'PSOFORGN,PSOBADR,'$G(PSOTEMP) S T="** BAD ADDRESS INDICATED **"
 . I I=1,T="",PSOFORGN S T="*** FOREIGN ADDRESS ***"
 . I T="" I 'PSOFORGN I 'PSOBADR!$G(PSOTEMP) S T=$G(VAPA(I))
 . D STRT^PSOLLU1("ML",T,.L) I L($E(PSOFONT,2,99))<2.37 D PRINT(T,0) Q
 . F F=12,10,9,8,6 I L(F)<2.37 S OFONT=PSOFONT,PSOFONT="F"_F D PRINT(T,0) S PSOFONT=OFONT Q
 S A=+$G(VAPA(5)) I A S A=$S($D(^DIC(5,A,0)):$P(^(0),"^",2),1:"UNKNOWN")
 S T="" I 'PSOFORGN I 'PSOBADR!$G(PSOTEMP) S T=$G(VAPA(4))_", "_A_"  "_$S($G(VAPA(11)):$P(VAPA(11),"^",2),1:$G(VAPA(6)))
 D PRINT(T,0)
W ;
 S T=$S(MW="WINDOW":"WINDOW -",1:"MAIL -")
 N XFONT
 S OFONT=PSOFONT,PSOYI=$G(PSOTYI,40),PSOFONT=PSOTFONT,XFONT=$E(PSOFONT,2,99),PSOY=PSOTY
 I T["WINDOW" D
 . I $G(^PSRX(RX,"MP"))'="" S PSOY=PSOY-PSOYI ; START 1 LINE HIGHER IF METHOD OF PICK-UP
 . S OPSOX=PSOX D PRINT(T,1) S PSOX=PSOX+200,PSOY=PSOY-PSOYI
 . S T=$G(^PSRX(RX,"MP")) I T="" S PSOFONT=OFONT,PSOX=OPSOX Q
 . N FIRST
 . S FIRST=1
 . D STRT^PSOLLU1("ML",T,.L)
 . I L(XFONT)<1.75 D PRINT(T,0) S PSOFONT=OFONT,PSOX=OPSOX Q
 . F F=10,9,8,6 I L(F)<4.5 Q
 . S XFONT=F,PSOFONT="F"_F,PSOYI=$S(PSOFONT="F12":40,PSOFONT="F10":35,PSOFONT="F9":30,PSOFONT="F8":25,1:20)
 . F J=$L(T," "):-1:1 S PTEXT=$P(T," ",1,J) D STRT^PSOLLU1("ML",PTEXT,.L) D  Q:T=""
 .. I FIRST I L(XFONT)<1.75 D PRINT(PTEXT,0) S T=$P(T," ",J+1,512),J=$L(T," ")+1,PTEXT="",FIRST=0,PSOX=OPSOX,PSOY=PSOY+20 Q
 .. I 'FIRST I L(XFONT)<2.3 D PRINT(PTEXT,0) S T=$P(T," ",J+1,512),J=$L(T," ")+1,PTEXT=""
 . D:PTEXT]"" PRINT(PTEXT,0)
 I T="MAIL -" D PRINT(T,1)
 S PSOFONT=OFONT
CONT I $G(SIDE) G BARC:'L5,CONT2
 I $G(COPIES)>1 G BARC
 I 'L2!PFM D ^PSOLLL2 S L2=1
 I 'L3 D ^PSOLLL3 S L3=1
 I 'L4!PMIM S PIMI=0 D ^PSOLLL4 S L4=1
 I L5 W @IOF G CONT2
BARC I $G(BOTTLBL) G BARCE ; ONLY PRINT BARCODE ON 1ST BOTTLE LABEL
 S BOTTLBL=1
 I $G(PSOIO("BLBC"))]"" X PSOIO("BLBC") I $G(NOBARC) G BARCE
 S X2=PSOINST_"-"_RX W X2
 I $G(PSOIO("EBLBC"))]"" X PSOIO("EBLBC")
BARCE W @IOF
COPY I SIGF S SIGM=1 G L1 ; NEED TO FINISH PRINTING CONTINUED BOTTLE LABEL
 S FILLCONT=0 I PFM!PMIM S FILLCONT=1 G L1
 I $G(COPIES)>1 D  G L1
 . S COPIES=COPIES-1
 . S (SIGM,PFM,PMIM,L2,L3,L4,L5,BOTTLBL)=0
 . K SIGF,PFF,PMIF S (SIGF,PFF,PMIF)=0 F I="DR","T" S (SIGF(I),PFF(I))=1
 . F I="A","B","I" S PMIF(I)=1
 S IR=0 F FDA=0:0 S FDA=$O(^PSRX(RX,"L",FDA)) Q:'FDA  S IR=FDA
 S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 S ^PSRX(RX,"L",IR,0)=PSOFNOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_$S($G(PCOMX)]"":$G(PCOMX),$G(PCOMH(RX))]"":PCOMH(RX),1:"From RX number "_$P(^PSRX(RX,0),"^"))_$S($G(RXP):" (Partial)",1:"")_$S($D(REPRINT):" (Reprint)",1:"")_"^"_PDUZ
 ;
 ;Storing FDA Medication Guide filename in the Prescription file
 I $$MGONFILE^PSOFDAUT(RX) D
 . I $G(RXRP(RX)),'$G(RXRP(RX,"MG")) Q
 . S ^PSRX(RX,"L",IR,"FDA")=$P($$MGONFILE^PSOFDAUT(RX),"^",2)
 ;
 N PSOBADR,PSOTEMP
 S PSOBADR=$$CHKRX^PSOBAI(RX)
 I $G(PSOBADR) S PSOTEMP=$P(PSOBADR,"^",2),PSOBADR=$P(PSOBADR,"^")
 I $G(PSOBADR),'$G(PSOTEMP) D
 .S IR=IR+1,^PSRX(RX,"L",0)="^52.032DA^"_IR_"^"_IR
 .S ^PSRX(RX,"L",IR,0)=PSOFNOW_"^"_$S($G(RXP):99-RXPI,1:RXF)_"^"_"ROUTING="_$G(MW)_" (BAD ADDRESS)"_"^"_PDUZ
 S L5=1
CONT2 I SIGF S SIGM=1 G L1 ; MORE BOTTLE LABEL SIG TO PRINT
 I PMIM G CONT ; MORE PMI INFO TO PRINT
 I $G(PSOBLALL)=1,$P(PPL,",",PI+1)="" D TRAIL
 Q
PRINT(T,B) ;
 S BOLD=$G(B)
 I 'BOLD,$G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT)
 I BOLD,$G(PSOIO(PSOFONT_"B"))]"" X PSOIO(PSOFONT_"B")
 I $G(PSOIO("ST"))]"" X PSOIO("ST")
 W T,!
 I $G(PSOIO("ET"))]"" X PSOIO("ET")
 I BOLD,$G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT) ;TURN OFF BOLDING
 Q
TRAIL I $G(SIDE) G END
 D ^PSOLLL5
 D ^PSOLLLH
 D ^PSOLLL6
 I '$P($G(^PS(59,PSOSITE,1)),"^",18) Q
 I '$G(REPRINT) D ^PSOLLL7
END I '$P(PSOPAR,"^",31) Q
 W @IOF
 I $G(PSOIO("PMII"))]"" X PSOIO("PMII")
 I $G(PSOIO(PSOFONT))]"" X PSOIO(PSOFONT)
 S T="NEXT PATIENT"
 S PSOX=1100-(L($E(PSOFONT,2,99))*300/2)
 I $G(PSOIO("ST"))]"" X PSOIO("ST")
 W T,!
 I $G(PSOIO("ET"))]"" X PSOIO("ET")
 Q
 ;
