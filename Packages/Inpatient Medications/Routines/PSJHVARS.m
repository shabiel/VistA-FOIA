PSJHVARS ;BIR/RSB-SAVE/RESTORE VARIABLES FOR HIDDEN MENUS  ;24 Feb 99 / 10:42 AM
 ;;5.0;INPATIENT MEDICATIONS ;**16,22,30,58,181,258**;16 DEC 97;Build 3
 ;
 ; Reference to ^ORD(101 is supported by DBIA 872.
 ; Reference to ^%RCR is supported by DBIA 10022.
 ; Reference to ^DIR is supported by DBIA 10026.
 ;
 ; PSJ*5*181 added: P(24),P(25) & PSGS0Y (it's zero & not O)
 ;PSJHIDFG will be defined if the user already in the hidden menu.
 I $$HIDCHK() D  Q
 . W !,"HIDDEN MENUS MAY NOT BE CALLED RECURSIVELY!" S XQORQUIT=1
 . N DIR S DIR(0)="E" D ^DIR
 ;  saves the variables in ^TMP
 K ^TMP("PSJVARS",$J),^TMP("PSJ_ON_HIDDEN",$J)
 F PSJRSB1=1:1 S PSJRSBV=$P($T(LIST+PSJRSB1),";;",2) Q:PSJRSBV=""  D
 .I $D(@PSJRSBV) S:$D(@PSJRSBV)'=10 ^TMP("PSJVARS",$J,PSJRSBV)=@PSJRSBV
 I $D(DRG) MERGE ^TMP("PSJHDRG",$J)=DRG
 ;save off ^TMP("PSJON",$J) because it gets killed down in hidden options
 F PSJRSB1L=0:0 S PSJRSB1L=$O(^TMP("PSJON",$J,PSJRSB1L)) Q:'PSJRSB1L  D
 .S ^TMP("PSJ_ON_HIDDEN",$J,PSJRSB1L)=^TMP("PSJON",$J,PSJRSB1L)
 K PSJRSB1,PSJRSB1L,PSJRSBV
 NEW PSJX
 F PSJX="P(","PSGEFN(","PSGVADR(","PSGVALG(","VADM(","VAIN(","VAIP(" D SVARRAY
 I $D(^TMP("PSIV",$J)) S %X="^TMP(""PSIV"",$J,",%Y="^TMP(""PSJHTMP"",$J,""PSIV""," D %XY^%RCR
 I $D(^TMP("PSJALL",$J)) S %X="^TMP(""PSJALL"",$J,",%Y="^TMP(""PSJHTMP"",$J,""PSJALL""," D %XY^%RCR
 I $D(^TMP("PSJI",$J)) S %X="^TMP(""PSJI"",$J,",%Y="^TMP(""PSJHTMP"",$J,""PSJI""," D %XY^%RCR
 I $D(^TMP("PSJPRO",$J)) S %X="^TMP(""PSJPRO"",$J,",%Y="^TMP(""PSJHTMP"",$J,""PSJPRO""," D %XY^%RCR
 D SAVEPS ; Save the ^PS(53.45,DUZ,2) entry
 Q
SVARRAY ;  Save array to ^TMP
 NEW PSJVARX,X S PSJVARX=PSJX_"X)"
 S X="" F  S X=$O(@PSJVARX) Q:X=""  S ^TMP("PSJVARS",$J,PSJX_$S(+X=X:X,1:""""_X_"""")_")")=@PSJVARX
 Q
RESTORE ;  restores the variables from ^TMP
 Q:$G(PSJHIDFG)
 S PSJRSBV="" F  S PSJRSBV=$O(^TMP("PSJVARS",$J,PSJRSBV)) Q:PSJRSBV=""  D
 .S @PSJRSBV=^TMP("PSJVARS",$J,PSJRSBV)
 I $D(^TMP("PSJHDRG",$J)) K DRG MERGE DRG=^TMP("PSJHDRG",$J)
 ;restore ^TMP("PSJON",$J) if it is not there
 I '$D(^TMP("PSJON",$J)) D
 .F PSJRSB1=0:0 S PSJRSB1=$O(^TMP("PSJ_ON_HIDDEN",$J,PSJRSB1)) Q:'PSJRSB1  D
 ..S ^TMP("PSJON",$J,PSJRSB1)=^TMP("PSJ_ON_HIDDEN",$J,PSJRSB1)
 I $D(^TMP("PSJHTMP",$J,"PSIV")) S %X="^TMP(""PSJHTMP"",$J,""PSIV"",",%Y="^TMP(""PSIV"",$J," D %XY^%RCR K ^TMP("PSJHTMP",$J,"PSIV")
 I $D(^TMP("PSJHTMP",$J,"PSJALL")) S %X="^TMP(""PSJHTMP"",$J,""PSJALL"",",%Y="^TMP(""PSJALL"",$J," D %XY^%RCR K ^TMP("PSJHTMP",$J,"PSJALL")
 I $D(^TMP("PSJHTMP",$J,"PSJI")) S %X="^TMP(""PSJHTMP"",$J,""PSJI"",",%Y="^TMP(""PSJI"",$J," D %XY^%RCR K ^TMP("PSJHTMP",$J,"PSJI")
 I $D(^TMP("PSJHTMP",$J,"PSJPRO")) S %X="^TMP(""PSJHTMP"",$J,""PSJPRO"",",%Y="^TMP(""PSJPRO"",$J," D %XY^%RCR K ^TMP("PSJHTMP",$J,"PSJPRO")
 K ^TMP("PSJVARS",$J),^TMP("PSJ_ON_HIDDEN",$J),^TMP("PSJHDRG",$J)
 K PSJRSBV,PSJRSB1
 D RESPS ; Restore any saved ^PS(53.45,DUZ,2) and ^PS(53.45,DUZ,4) entries
 Q
HIDCHK() ;  XQORNEST(X) contains a list of selected protocols.
 K ^TMP("PSJHIDCHK",$J) N PSJ,X,Y
 F X=0:0 S X=$O(XQORNEST(X)) Q:'X  S ^TMP("PSJHIDCHK",$J,+$P(XQORNEST(X),";"))=""
 S X=+$O(^ORD(101,"B","PSJI LM LBLI",0))
 S Y=+$O(^ORD(101,"B","PSJ LM RETURNS/DESTROYED MENU",0))
 S PSJ=$S($D(^TMP("PSJHIDCHK",$J,X)):1,$D(^TMP("PSJHIDCHK",$J,Y)):1,1:0)
 K ^TMP("PSJHIDCHK",$J)
 Q PSJ
SAVEPS ; Save the ^PS(53.45,DUZ,2) entry
 ; Save the 2,0) node
 I $D(^PS(53.45,DUZ,2,0)) D
 .S ^TMP("PSJ5345",$J,DUZ,2,0)=^PS(53.45,DUZ,2,0)
 ;Save the 2,n,0) nodes
 S PSJLOOP=0
 F PSJLOOP=$O(^PS(53.45,DUZ,2,PSJLOOP)) Q:(PSJLOOP="")!(PSJLOOP="B")  D
 .S ^TMP("PSJ5345",$J,DUZ,2,PSJLOOP,0)=^PS(53.45,DUZ,2,PSJLOOP,0)
 ;Save the 2,"B" node
 I $D(^PS(53.45,DUZ,2,"B")) D
 .S PSJBLOOP=""
 .F PSJBLOOP=$O(^PS(53.45,DUZ,2,"B",PSJBLOOP)) Q:PSJBLOOP=""  D
 ..S PSJCOUNT=""
 ..F PSJCOUNT=$O(^PS(53.45,DUZ,2,"B",PSJBLOOP,PSJCOUNT)) Q:PSJCOUNT=""  D
 ...S ^TMP("PSJ5345",$J,DUZ,2,"B",PSJBLOOP,PSJCOUNT)=^PS(53.45,DUZ,2,"B",PSJBLOOP,PSJCOUNT)
 ; Save the 4,0) node
 ;I $D(^PS(53.45,DUZ,4,0)) D
 ;.S ^TMP("PSJ5345",$J,DUZ,4,0)=^PS(53.45,DUZ,4,0)
 ; Save the 4,n,0) nodes
 ;S PSJLOOP=0
 ;F PSJLOOP=$O(^PS(53.45,DUZ,4,PSJLOOP)) Q:PSJLOOP=""  D
 ;.S ^TMP("PSJ5345",$J,DUZ,4,PSJLOOP,0)=^PS(53.45,DUZ,4,PSJLOOP,0)
 Q
RESPS ; Restore any saved ^PS(53.45,DUZ,2) entry
 ;Restore the 2,0 node
 I $D(^TMP("PSJ5345",$J,DUZ,2,0)) D
 .S ^PS(53.45,DUZ,2,0)=^TMP("PSJ5345",$J,DUZ,2,0)
 ;Restore the 2,n,o) nodes
 S PSJLOOP=0
 F PSJLOOP=$O(^TMP("PSJ5345",$J,DUZ,2,PSJLOOP)) Q:(PSJLOOP="")!(PSJLOOP="B")  D
 .S ^PS(53.45,DUZ,2,PSJLOOP,0)=^TMP("PSJ5345",$J,DUZ,2,PSJLOOP,0)
 ;Restore the 2,"B" nodes
 I $D(^TMP("PSJ5345",$J,DUZ,2,"B")) D
 .S PSJBLOOP=""
 .F PSJBLOOP=$O(^TMP("PSJ5345",$J,DUZ,2,"B",PSJBLOOP)) Q:PSJBLOOP=""  D
 ..S PSJCOUNT=""
 ..F PSJCOUNT=$O(^TMP("PSJ5345",$J,DUZ,2,"B",PSJBLOOP,PSJCOUNT)) Q:PSJCOUNT=""  D
 ...S ^PS(53.45,DUZ,2,"B",PSJBLOOP,PSJCOUNT)=^TMP("PSJ5345",$J,DUZ,2,"B",PSJBLOOP,PSJCOUNT)
 ;Restore the 4,0) node
 ;I $D(^TMP("PSJ5345",$J,DUZ,4,0)) D
 ;.S ^PS(53.45,DUZ,4,0)=^TMP("PSJ5345",$J,DUZ,4,0)
 ;Restore the 4,n,0) nodes
 ;S PSJLOOP=0
 ;F PSJLOOP=$O(^TMP("PSJ5345",$J,DUZ,4,PSJLOOP)) Q:PSJLOOP=""  D
 ;.S ^PS(53.45,DUZ,4,PSJLOOP,0)=^TMP("PSJ5345",$J,DUZ,4,PSJLOOP,0)
 K ^TMP("PSJ5345",$J,DUZ)
 Q
LIST ;
 ;;ADM
 ;;AL
 ;;C
 ;;CHK
 ;;DDH
 ;;DFN
 ;;DN
 ;;DRGI
 ;;DRGN
 ;;DRGT
 ;;DX
 ;;DY
 ;;FIL
 ;;FQ
 ;;GMRA
 ;;GMRAL
 ;;HDT
 ;;I
 ;;INFUSE
 ;;J
 ;;LIMIT
 ;;LINE
 ;;LOC
 ;;N
 ;;NAD
 ;;ND
 ;;ND0
 ;;ND2
 ;;ND4
 ;;ND6
 ;;NDP2
 ;;NEXT
 ;;NF
 ;;NO
 ;;O
 ;;ON
 ;;ON55
 ;;ORIFN
 ;;P16
 ;;P17
 ;;P(2)
 ;;P(3)
 ;;P(4)
 ;;P(5)
 ;;P(6)
 ;;P(7)
 ;;P(8)
 ;;P(9)
 ;;P(10)
 ;;P(11)
 ;;P(12)
 ;;P(13)
 ;;P(14)
 ;;P(15)
 ;;P(16)
 ;;P(17)
 ;;P(18)
 ;;P(19)
 ;;P(20)
 ;;P(21)
 ;;P(22)
 ;;P(23)
 ;;P(24)
 ;;P(25)
 ;;P("21FLG")
 ;;P("CLRK")
 ;;P("CUM")
 ;;P("DO")
 ;;P("DTYP")
 ;;P("FRES")
 ;;P("INS")
 ;;P("IVRM")
 ;;P("LF")
 ;;P("LFA")
 ;;P("LOG")
 ;;P("MR")
 ;;P("NEWON")
 ;;P("OLDON")
 ;;P("OPI")
 ;;P("OT")
 ;;P("PD")
 ;;P("PON")
 ;;P("PRY")
 ;;P("REM")
 ;;P("REN")
 ;;P("RES")
 ;;P("SYRS")
 ;;PF
 ;;PPAGE
 ;;PPN
 ;;PROVIDER
 ;;PS
 ;;PSFDT
 ;;PSGACT
 ;;PSGADR
 ;;PSGADR(1)
 ;;PSGAT
 ;;PSGCANFL
 ;;PSGDFLG
 ;;PSGDI
 ;;PSGDRG
 ;;PSGDRGN
 ;;PSGDO
 ;;PSGDT
 ;;PSGEB
 ;;PSGEBN
 ;;PSGEFN
 ;;PSGF
 ;;PSGFD
 ;;PSGFDN
 ;;PSGHSM
 ;;PSGID
 ;;PSGIVAC
 ;;PSGIVBR
 ;;PSGLAD
 ;;PSGLAGE
 ;;PSGLBID
 ;;PSGLBSS
 ;;PSGLDOB
 ;;PSGLDT
 ;;PSGLDX
 ;;PSGLI
 ;;PSGLIN
 ;;PSGLPID
 ;;PSGLPN
 ;;PSGLPR
 ;;PSGLRB
 ;;PSGLSEX
 ;;PSGLSSN
 ;;PSGLTM
 ;;PSGLTS
 ;;PSGLWD
 ;;PSGLWDN
 ;;PSGLWGN
 ;;PSGLWP1
 ;;PSGLWP2
 ;;PSGMR
 ;;PSGMRN
 ;;PSGNEDFD
 ;;PSGNEF
 ;;PSGNESD
 ;;PSGOAT
 ;;PSGOD
 ;;PSGODDD
 ;;PSGODDD(1)
 ;;PSGODO
 ;;PSGODT
 ;;PSGOEA
 ;;PSGOEAV
 ;;PSGOEDMR
 ;;PSGOEEG
 ;;PSGOEEND
 ;;PSGOEEWF
 ;;PSGOENG
 ;;PSGOENOF
 ;;PSGOEPR
 ;;PSGOFD
 ;;PSGOFDN
 ;;PSGOHSM
 ;;PSGOINST
 ;;PSGOL
 ;;PSGOMR
 ;;PSGOMRN
 ;;PSGONC
 ;;PSGOP
 ;;PSGOPD
 ;;PSGOPDN
 ;;PSGOPR
 ;;PSGOPRN
 ;;PSGORD
 ;;PSGOSCH
 ;;PSGOSD
 ;;PSGOSDN
 ;;PSGOSI
 ;;PSGOSM
 ;;PSGOST
 ;;PSGOSTN
 ;;PSGP
 ;;PSGP(0)
 ;;PSGPD
 ;;PSGPDN
 ;;PSGPDRG
 ;;PSGPDRGN
 ;;PSGPI
 ;;PSGPR
 ;;PSGPRIO
 ;;PSGPRN
 ;;PSGPTMP
 ;;PSGPTS
 ;;PSGRRF
 ;;PSGSCH
 ;;PSGSD
 ;;PSGSDN
 ;;PSGSI
 ;;PSGSM
 ;;PSGSOXT
 ;;PSGSOY
 ;;PSGS0Y
 ;;PSGSS
 ;;PSGSSH
 ;;PSGST
 ;;PSGSTAT
 ;;PSGSTN
 ;;PSGVADR
 ;;PSGVALG
 ;;PSGVBPN
 ;;PSGVBTM
 ;;PSGVBWN
 ;;PSGVBWW
 ;;PSGVBY
 ;;PSIVAC
 ;;PSIVBR
 ;;PSIVDT
 ;;PSIVON
 ;;PSIVOF
 ;;PSIVOV1
 ;;PSIVOV2
 ;;PSIV
 ;;PSIVORF
 ;;PSIVPL
 ;;PSIVPR
 ;;PSIVRD
 ;;PSIVREA
 ;;PSIVSITE
 ;;PSIVSN
 ;;PSIVST
 ;;PSIVUP
 ;;PSIVX1
 ;;PSIVX2
 ;;PSJ
 ;;PSJAC
 ;;PSJACND
 ;;PSJACNWP
 ;;PSJACOK
 ;;PSJACPF
 ;;PSJASK
 ;;PSJCNT
 ;;PSJF
 ;;PSJHLMTN
 ;;PSJINDEX
 ;;PSJIVOF
 ;;PSJIVORF
 ;;PSJL
 ;;PSJLABEL
 ;;PSJLK
 ;;PSJLM
 ;;PSJLMCON
 ;;PSJLMPRO
 ;;PSJLN
 ;;PSJNARC
 ;;PSJNV
 ;;PSJO
 ;;PSJOCNT
 ;;PSJOE
 ;;PSJOEPF
 ;;PSJOL
 ;;PSJORD
 ;;PSJORF
 ;;PSJORIFN
 ;;PSJORL
 ;;PSJORQF
 ;;PSJORVP
 ;;PSJOS
 ;;PSJPAC
 ;;PSJPAD
 ;;PSJPAGE
 ;;PSJPBID
 ;;PSJPCAF
 ;;PSJPDD
 ;;PSJPDOB
 ;;PSJPDT
 ;;PSJPDX
 ;;PSJPEN
 ;;PSJPHT
 ;;PSJPHTD
 ;;PSJPN
 ;;PSJPPID
 ;;PSJPRB
 ;;PSJPROT
 ;;PSJPSEX
 ;;PSJPSSN
 ;;PSJP
 ;;PSJPTS
 ;;PSJPTSP
 ;;PSJPWD
 ;;PSJPWDN
 ;;PSJPWT
 ;;PSJPWTD
 ;;PSJSCHT
 ;;PSJSEL
 ;;PSJSEL1
 ;;PSJSTOP
 ;;PSJSYSL
 ;;PSJSYSP
 ;;PSJSYSP0
 ;;PSJSYSU
 ;;PSJSYSW
 ;;PSJSYSW0
 ;;PSJTF
 ;;PSJTOO
 ;;PSJUDPRF
 ;;PSJX
 ;;PSSPSP0
 ;;Q
 ;;QQ
 ;;QUD
 ;;QUX1
 ;;RTE
 ;;SCH
 ;;SD
 ;;SEGMENT(0)
 ;;SM
 ;;ST
 ;;START
 ;;STAT
 ;;STATUS
 ;;STOP
 ;;STT
 ;;SUB
 ;;TYPE
 ;;UDU
 ;;V
 ;;VA200
 ;;VADM
 ;;VAIN
 ;;VAIP
 ;;VALMCNT
 ;;VALM("TITLE")
 ;;WRD
 ;;WS
 ;;X
 ;;X3
 ;;X4
 ;;X5
 ;;XRTN
 ;;Y
