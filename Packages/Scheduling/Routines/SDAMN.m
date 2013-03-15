SDAMN ;ALB/MJK - No-Show Appt Action ; 3/15/13
 ;;5.3;Scheduling;**478,260003**;Aug 13, 1993
 ;
EN ; -- protocol SDAM APPT NO-SHOW entry pt
 ; input:  VALMY := array entries
 ;
 N VALMY,SDI,SDAT,SDTIME,SDNSACT,DFN,SDCL,SDT,SDSTB,SDSTA,SDSTOP
 S VALMBCK="",(SDNSACT,SDSTOP)=0
 D SEL^VALM2 G ENQ:'$O(VALMY(0))
 D FULL^VALM1 S VALMBCK="R",SDI=0
 F  S SDI=$O(VALMY(SDI)) Q:'SDI  I $D(^TMP("SDAMIDX",$J,SDI)) K SDAT S SDAT=^(SDI) D  Q:SDSTOP
 . D NOW^%DTC S SDTIME=%
 . W !,^TMP("SDAM",$J,+SDAT,0),!
 . S DFN=+$P(SDAT,U,2),SDT=+$P(SDAT,U,3),SDCL=+$P(SDAT,U,4)
 . S SDSTOP=$$NOSHOW(.RETURN,DFN,SDT,SDCL)
 . S SDSTB=$G(RETURN("BEFORE")) ; before status
 . S SDSTA=$G(RETURN("AFTER")) ; after status
 . I '$$UPD(SDSTB,SDSTA,SDAT,$G(CNSTLNK)) S SDNSACT=2
 ; values for SDNSACT :   0 = no re-build
 ;                        1 = re-build because of re-book
 ;                        2 = re-build because after not for list
 I SDAMTYP="P" D BLD^SDAM1
 I SDAMTYP="C" D BLD^SDAM3
ENQ Q
 ;
NOSHOW(ERR,DFN,SD,SC,LVL) ; No-show appointment
 N NERR,QUIT,STAT S QUIT=0
 S %=$$CHKNS^SDMAPI3(.NERR,DFN,SC,SD,.LVL,.STAT)
 S SDMSG=" DOES NOT HAVE A NO-SHOW LETTER ASSIGNED TO IT!"
 S SDLT1="",SDYES="",SDDT=DT,I=SDT,SDT=$P(I,".")
 I 'NERR,$P(NERR(0),U,3)=1 D EN^DDIOL($P(NERR(0),U,2),,"!!") D PAUSE^VALM1 Q 1
 I 'NERR,$P(NERR(0),U,3)>1 D
 . S OV=$$ALNS($P(NERR(0),U,2)) I OV=2 S QUIT=1 Q
 . I OV=1 D
 . . D EN^DDIOL($$EZBLD^DIALOG(480000.111),,"*1")
 . . S QUIT=1,%=$$NOSHOW^SDMAPI2(.NERR,DFN,SC,SD,1)
 I QUIT D PAUSE^VALM1 Q 'Y
 S STAT=$P(STAT,";",3),STAT=$P(STAT,"/",2)
 S STAT="NO-SHOW"_$S(STAT["CHECKED":"/"_STAT,1:"")
 D EN^DDIOL($$EZBLD^DIALOG(480000.11,.STAT))
 S %=$$NOSHOW^SDMAPI2(.NERR,DFN,SC,SD,.LVL)
 I NERR=1 S SDYES=1 D 73^SDN,PAUSE^VALM1
 Q 'Y
ALNS(TXT) ;
ALNS1 ;
 S %=2 W *7,!,TXT D YN^DICN
 I '% W !,"RESPOND YES OR NO" G ALNS1
 Q %
 ;
UPD(BEFORE,AFTER,SDAT,CNST) ; can just the 1 display line be changed w/o re-build
 ; input:   BEFORE := before status info in $$STATUS format
 ;           AFTER := after     "     "   "     "      "
 ;            SDAT := selected VALMY entry's data
 ;            CNST := consult status (null, consult link ien)
 N Y S Y=0
 I +BEFORE=+AFTER S Y=1 G UPDQ
 I $D(SDAMLIST(+AFTER)) S Y=1 I $D(SDAMLIST("SCR")) X SDAMLIST("SCR") S Y=$T
 I 'Y,$P(SDAMLIST,U)="ALL" S Y=1
 I Y D
 . S ^TMP("SDAM",$J,+SDAT,0)=$$SETFLD^VALM1($P(AFTER,";",3),^TMP("SDAM",$J,+SDAT,0),"STAT")
 . I '$G(CNST) S ^TMP("SDAM",$J,+SDAT,0)=$$SETFLD^VALM1("    ",^TMP("SDAM",$J,+SDAT,0),"CONSULT")
UPDQ Q Y
