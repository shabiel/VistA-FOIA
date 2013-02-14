SDAM1 ;MJK/ALB - Appt Mgt (Patient);2/14/2012
 ;;5.3;Scheduling;**149,155,193,189,445,478,466,567,591,260003**;Aug 13, 1993;Build 2
 ;
INIT ; -- get init pat appt data
 ;  input:          DFN := ifn of pat
 ; output:  ^TMP("SDAM" := appt array
 S X=$P($G(^DG(43,1,"SCLR")),U,12),SDPRD=$S(X:X,1:2)
 S X1=DT,X2=-SDPRD D C^%DTC S SDBEG=X
 S X1=DT,X2=999 D C^%DTC S SDEND=X
 D CHGCAP^VALM("NAME","Clinic")
 S X="ALL" D LIST^SDAM
 Q
 ;
BLD ; -- scan apts
 N SDAMDD,SDNAME,SDMAX,SDLARGE,DFN,SDCL,BL,XC,XW,AC,AW,TC,TW,NC,NW,SC,SW,SDT,CC,CW,CN,CNPAT,CNSTLNK,CSTAT ; done for speed see INIT
 N %,RETURN
 D INIT^SDAM10
 S DFN=SDFN
 S %=$$LSTPAPTS^SDMAPI1(.RETURN,DFN,SDBEG,SDEND,SDAMLIST)
 D BLD1^SDAM1(.RETURN)
 D NUL^SDAM10,LARGE^SDAM10:$D(SDLARGE)
 S $P(^TMP("SDAM",$J,0),U,4)=VALMCNT
 Q
 ;
BLD1(APTS) ; -- build array
 N X,Y,Y1,IND,SDT,BID,GAF,NAME,CSTAT,STAT,DFN,SDDA
 F IND=0:0 S IND=$O(APTS(IND)) Q:IND=""  D
 . S SDT=APTS(IND,"SD"),BID=APTS(IND,"BID")
 . S GAF=APTS(IND,"GAF")
 . S NAME=$S(SDAMTYP="P":APTS(IND,"CLINIC"),1:BID_" "_APTS(IND,"NAME"))
 . S DFN=APTS(IND,"DFN"),SDCL=APTS(IND,"SC")
 . S SDDA=APTS(IND,"SDDA"),STAT=APTS(IND,"STAT")
 . S:$D(APTS(IND,"CSTAT")) CSTAT=APTS(IND,"CSTAT")
 . S X="",$P(X," ",VALMWD+1)=""
 . W:(IND#10)=0 "."
 . I IND=SDMAX,$P(SDT,".")'=SDEND S SDEND=$P(SDT,"."),SDLARGE=""
 . S SDACNT=IND
 . S X=$S(GAF:"*",1:" ")_$E(X,2,AC-1)_$E(IND_BL,1,AW)_$E(X,AC+AW+1,VALMWD)
 . S X=$E(X,1,NC-1)_$E($$LOWER(NAME)_BL,1,NW)_$E(X,NC+NW+1,VALMWD)
 . S X=$E(X,1,XC-1)_$E($$FMTE^XLFDT(SDT,"5Z")_BL,1,XW)_$E(X,XC+XW+1,VALMWD)
 . S:'$D(CSTAT) CSTAT="" ;SD/478
 . S X=$E(X,1,CC-1)_$E($S((CSTAT=1!(CSTAT=2)!(CSTAT=13)):" ",$G(CSTAT):"Consult",1:"        ")_BL,1,CW)_$E(X,CC+CW+1,VALMWD) K CSTAT ;SD/478
 . S Y=$P(STAT,";",3)
 . I Y'["FUTURE" S X=$E(X,1,SC-1)_$E($$LOWER(Y)_BL,1,SW)_$E(X,SC+SW+1,VALMWD)
 . S SDATA=APTS(IND,"LAB")_U_APTS(IND,"XRAY")_U_APTS(IND,"EKG")
 . I Y["FUTURE" S X=$E(X,1,SC-1)_$E($$LOWER(Y)_$$ANC_BL,1,SW+TW+1)
 . S Y1=$S($P(STAT,";",5):$P(STAT,";",5),1:$P(STAT,";",4)),Y1=$S($P(Y1,".")=DT:$$TIME($P(Y1,".",2)),1:"")
 . S:Y1]"" X=$E(X,1,TC-1)_$E(Y1_BL,1,TW)_$E(X,TC+TW+1,VALMWD)
 . D SET(X)
 . I $D(SDAMBOLD(DFN,SDT,SDCL)) D FLDCTRL^VALM10(VALMCNT,"STAT",IOINHI,IOINORM),FLDCTRL^VALM10(VALMCNT,"TIME",IOINHI,IOINORM)
 . S ^TMP("SDAMIDX",$J,SDACNT)=VALMCNT_U_DFN_U_SDT_U_SDCL_U_$S($D(SDDA):SDDA,1:"")
BLD1Q Q
 ;
ANC() ; -- set ancillary info
 N I,Y,C
 S Y="",C=0
 F I=1:1:3 I $P(SDATA,U,I)]"" S Y=Y_" "_$P("Lab^XRay^EKG",U,I)_"@"_$$TIME($P($P(SDATA,U,I),".",2)),C=C+1 Q:C=2
 I Y]"" S Y="/"_$E(Y,2,99)
 Q Y
 ;  
SET(X) ;
 S VALMCNT=VALMCNT+1,^TMP("SDAM",$J,VALMCNT,0)=X
 S:SDACNT ^TMP("SDAM",$J,"IDX",VALMCNT,SDACNT)=""
 Q
 ;
CHK(DFN,SDT,SDCL,SDATA,SDAMLIST,SDSTAT,SDDA) ; -- does appt meet criteria
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;               SDATA := 0th node of pat appt entry
 ;            SDAMLIST := list definition
 ;              SDSTAT := appt status data from $$STATUS call
 ;                SDDA := ifn for ^SC(clinic,"S",date,1,ifn) {optional}
 ;  output: [returned] := meets criteria for list [0 - no | 1 - yes ]
 ;
 S Y=0
 I $D(SDAMLIST(+SDSTAT)) S Y=1 G CHKQ
 I $P(SDAMLIST,U)="ALL" S Y=1
 I $P(SDAMLIST,U)="CHECKED IN" I $P(SDSTAT,";",3)="ACT REQ/CHECKED IN" S Y=1  ; - SD*5.3*445
CHKQ I Y,$D(SDAMLIST("SCR")) X SDAMLIST("SCR") S Y=$T
 Q Y
 ;
STATUS(DFN,SDT,SDCL,SDATA,SDDA) ; -- return appt status
 ;   input:        DFN := ifn of pat.
 ;                 SDT := appt d/t
 ;                SDCL := ifn of clinic
 ;               SDATA := 0th node of pat appt entry
 ;                SDDA := ifn for ^SC(clinic,"S",date,1,ifn) {optional}
 ;  output: [returned] := appt status ifn ^ status name ^ print status ^
 ;                        check in d/t ^ check out d/t ^ adm mvt ifn
 ;
 ;S = status ; C = ci/co indicator ; Y = 'C' node ; P = print status
 N S,C,Y,P,VADMVT,VAINDT
 ;
 ; -- get data for evaluation
 S:'$G(SDDA) SDDA=+$$FIND^SDAM2(DFN,SDT,SDCL)
 S Y=$G(^SC(SDCL,"S",SDT,1,SDDA,"C"))
 ;retrieve CHECK OUT from OUTPATIENT ENCOUNTER file if not in Hospital Location file 
 I 'Y,SDT<$$NOW^XLFDT N SDSCE S SDSCE=$P($G(^DPT(DFN,"S",SDT,0)),U,20) D  ;pointer to OE
 .I SDSCE S $P(Y,U,3)=$P($G(^SCE(SDSCE,0)),U,7) ;check out date
 ;
 ; -- set initial status value ; non-count clinic?
 S S=$S($P(SDATA,"^",2)]"":$P($P($P(^DD(2.98,3,0),"^",3),$P(SDATA,"^",2)_":",2),";"),$P($G(^SC(SDCL,0)),U,17)="Y":"NON-COUNT",1:"")
 ;
 ; -- inpatient?
 S VAINDT=SDT D ADM^VADPT2
 I S["INPATIENT",$S('VADMVT:1,'$P(^DG(43,1,0),U,21):0,1:$P($G(^DIC(42,+$P($G(^DGPM(VADMVT,0)),U,6),0)),U,3)="D") S S=""
 ;
 ; -- determine ci/co indicator
 S C=$S($P(Y,"^",3):"CHECKED OUT",Y:"CHECKED IN",S]"":"",SDT>(DT+.2359):"FUTURE",1:"NO ACTION TAKEN") S:S="" S=C
 I S="NO ACTION TAKEN",$P(SDT,".")=DT,C'["CHECKED" S C="TODAY"
 ; -- $$REQ & $$COCMP in SDM1A not used for speed
 I S="CHECKED OUT"!(S="CHECKED IN"),SDT'<$P(^DG(43,1,"SCLR"),U,23),'$P($G(^SCE(+$P(SDATA,U,20),0)),U,7) S S="NO ACTION TAKEN"
 ;
 ; -- determine print status
 S P=$S(S=C!(C=""):S,1:"")
 I P="" D
 .I S["INPATIENT",$P($G(^SC(SDCL,0)),U,17)'="Y",$P($G(^SCE(+$P(SDATA,U,20),0)),U,7)="" S P=$P(S," ")_"/ACT REQ" Q
 .I S="NO ACTION TAKEN",C="CHECKED OUT"!(C="CHECKED IN") S P="ACT REQ/"_C Q
 .S P=$S(S="NO ACTION TAKEN":S,1:$P(S," "))_"/"_C
 I S["INPATIENT",C="" D
 .I SDT>(DT+.2359) S P=$P(S," ")_"/FUTURE" Q
 .S P=$P(S," ")_"/NO ACT TAKN"
 ;
STATUSQ Q +$O(^SD(409.63,"AC",S,0))_";"_S_";"_P_";"_$P(Y,"^")_";"_$P(Y,"^",3)_";"_+VADMVT
 ;
 ;
LOWER(X) ; convert to lowercase ; same as LOWER^VALM1 ; here for speed
 N Y,C,I
 S Y=$E(X)_$TR($E(X,2,999),"ABCDEFGHIJKLMNOPQRSTUVWXYZ@","abcdefghijklmnopqrstuvwxyz ")
 F C=" ",",","/" S I=0 F  S I=$F(Y,C,I) Q:'I  S Y=$E(Y,1,I-1)_$TR($E(Y,I),"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(Y,I+1,999)
 Q Y
 ;
TIME(X) ; -- format time only :=   hr:min
 Q $E(X_"0000",1,2)_":"_$E(X_"0000",3,4)
