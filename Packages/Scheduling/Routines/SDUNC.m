SDUNC ;MAN/GRR - RESTORE CLINIC AVAILABILITY ; 8/7/13
 ;;5.3;Scheduling;**79,303,380,452,260003**;Aug 13, 1993
 F EXT=0:0 Q:EXT  D
 . D DT^DICRW S DIC=44,DIC(0)="MEQA",DIC("S")="I $P(^(0),""^"",3)=""C"",'$G(^(""OOS""))",DIC("A")="Select CLINIC NAME: " D ^DIC K DIC("S"),DIC("A")
 . I "^"[X!(Y<0) S EXT=1 Q
 . S SC=+Y
 . N SDRES S %=$$RESTAV^SDAVAPI(.SDRES,SC)
 . I 'SDRES,SDRES(0)'["INVPARAM" D  Q
 . . D EN^DDIOL("     "_$P(SDRES(0),U,2))
 . . W !,?5,"Clinic MUST be corrected before continuing."
 . S %DT="AEXF",%DT("A")="RESTORE '"_$P(Y,U,2)_"' FOR WHAT DATE: " D ^%DT K %DT Q:Y<0
 . S (SD,CDATE)=Y
 . S %=$$RESTAV^SDAVAPI(.SDRES,SC,SD)
 . I 'SDRES,SDRES(0)["INVPARAM" S SEL=$$SEL() S EXT=1 Q:SEL=1
 . I 'SDRES,SDRES(0)'["RESTCBR" D EN^DDIOL($$UP^XLFSTR($P(SDRES(0),U,2))) Q
 . I 'SDRES,SDRES(0)["RESTCBR" D ERRM^SDUNC1 Q
 . S EXT=1 W !,"RESTORED!",*7
 Q
SEL() S %=$$GETCANP^SDAVAPI(.CANP,SC,SD)
 N EXT1
 W !,"Clinic has been cancelled for the following periods:",!
 K SDTEMP,SDZZ S SDZZ=0
 F I=SD:0 S I=$O(CANP(I)) Q:'I!(I\1-SD)  D
 . S SDZZ=SDZZ+1,X=I D TM
 . S SDFR=X,SDFRX=X1,X="."_CANP(I,"END") D TM
 . S SDTO=X,SDTEMP(SDFRX_"-"_X1)=SDFR_"^"_SDTO
 . S SDZZ(SDZZ)=SDFRX_"-"_X1,SDZZ(SDZZ,"B")=CANP(I,"BEGIN")
 F I1=0:0 S I1=$O(SDZZ(I1)) Q:'I1  D
 . S I=SDTEMP(SDZZ(I1))
 . W !,?9,"(",$J(I1,2),") ","From: ",$J($P(I,"^",1),8),"   To: ",$J($P(I,"^",2),8)
 F EXT1=0:0 Q:EXT1  D
 . K SDFRX,X1,SDFR,SDTO R !!,"RESTORE WHICH PERIOD?: ",X:DTIME I "^"[X S EXT1=1 Q
 . I X?1"?".E W !,"Enter the # that precedes the time period you want to restore." Q
 . S SDR=X I $D(SDZZ(SDR)),$D(SDTEMP(SDZZ(SDR))) W "      ",$P(SDTEMP(SDZZ(SDR)),"^",1)," - ",$P(SDTEMP(SDZZ(SDR)),"^",2) S %=$$RESTAV^SDAVAPI(.SDRES,SC,SDZZ(SDR,"B")),EXT1=2 Q
 . W !,*7,"INVALID CHOICE, TRY AGAIN" Q
 Q EXT1
TM S X=$E($P(X,".",2)_"0000",1,4),X1=X,%=X>1159 S:X>1259 X=X-1200 S X=X\100_":"_$E(X#100+100,2,3)_" "_$E("AP",%+1)_"M" Q
