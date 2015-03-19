SDNEXTAD ; THM/THM-Main driver for next available appointment display [01-074zzz-2015 13:28]
 ;;5.3;Scheduling;;Aug 13, 1993;Build 13 ;
 ;(Prototype version 12.0)
 ;
 Q  ; Enter properly
 ;
 S IOP="HOME" D ^%ZIS K IOP I '$D(DT) D DT^DICRW
 ;
EN W @IOF,"Display Next Available Appointments",!!!
 S X="T+90",%DT="" D ^%DT S SDEDATE=Y ; default ending date
 K SDPAGED K %DT S DIC("A")="Select a CLINIC: ",DIC="^SC(",DIC(0)="AEQM" D ^DIC G:Y<0 EXIT S SC=+Y
 S SDINACT=$P($G(^SC(SC,"I")),U)
 I SDINACT]"" W !!,$C(7),"This clinic is inactive.",!! H 2 G EN
 ;
ONE K SDONEDAT
 W !!,"Do you want only the first available appointment" S %=2 D YN^DICN S SDONEDAT=% G:%<0 EXIT
 ;
BDATE W !! S %DT("A")="Beginning date for the appointment search: ",%DT("B")="NOW",%DT="AEQ" D ^%DT G:Y<0 EXIT
 I Y<DT W $C(7),"The beginning date cannot be in the past." H 2 G BDATE
 S SDBDATE=Y-.0000001 X ^DD("DD") S SDBDATE1=Y
 I $G(SDONEDAT)=1 DO  G:$D(SDQUIT) EXIT G EN
 .K DIR,SDQUIT D ONE^SDNEXTAV(SC,SDBDATE,SDEDATE,$G(SDDELARR,1))
 .D EXIT
 ;
EDATE S %DT("A")=" Ending date for the appointment search: ",%DT="AEQ",%DT("B")="T+90" D ^%DT G:Y<0 EN
 I Y<DT W $C(7),"The ending date cannot be in the past.",! H 2 G EDATE
 I Y<SDBDATE W $C(7),!!,"The ending date cannot be before the beginning date.",! H 2 G EDATE
 S SDEDATE=Y,X1=SDBDATE,X2=365 D C^%DTC
 I SDEDATE>X W !!,$C(7),"You may not select more than a year in advance." H 2 G BDATE
 S Y=SDEDATE X ^DD("DD") S SDEDATE1=Y
 ;
ALL D ALL^SDNEXTAV(SC,SDBDATE,SDEDATE,$G(SDDELARR,1))
 I '$D(SDPAGED) S DIR(0)="E" D ^DIR
 D EXIT
 G EN
 ;
EXIT K %DT,%H,%T,%Y,DIC,DIR,DIRUT,DILN,SC,SDBDATE,SDEDATE,SDINACT,SDONEDAT,SDQUIT,X,X1,X2,Y
 Q

SDNEXTAV^INT^1^^0
SDNEXTAV ; THM/THM-NEXT AVAILABLE APPOINTMENTS UTILITY [01-07-2015 13:28]
 ;;5.3;Scheduling;;Aug 13, 1993;Build 13 ;
 ;(Prototype version 12.0)
 ;
 Q  ; Enter properly
 ;
QUIET(SC,SDBDATE,SDEDATE,SDDELARR) ; Quiet return of SDRETURN
 S SDQUIET=1,SDFIND=0
 K SDPAGED D SETUPA,SETUPCK G:$D(SDQUIT) EXIT
 F SDBDATE=(SDBDATE-.001):0 S SDBDATE=$O(^SC(SC,"ST",SDBDATE)) Q:SDBDATE>SDEDATE!(+SDBDATE=0)  D SETPAT G:$D(SDQUIT) EXIT D CALC
 F SDX=0:0 S SDX=$O(SDHR(SDX)) Q:SDX=""  I SDHR(SDX)>0 DO
 .D NOW^%DTC Q:%>SDX
 .S SDFIND=1,SDY=SDX,SDX=9999999.9999,SDRETURN=SDY_"^"_SDHR(SDY) ;FM date.time^available slots
 I SDFIND=0 S SDRETURN="NO_NEXT_AVAILABLE_APPOINTMENT_FOUND"
 G EXIT
 ;
ONE(SC,SDBDATE,SDEDATE,SDDELARR) ; show single next available appointment
 K SDPAGED D SETUPA,SETUPCK G:$D(SDQUIT) EXIT
 F SDBDATE=(SDBDATE-.001):0 S SDBDATE=$O(^SC(SC,"ST",SDBDATE)) Q:SDBDATE>SDEDATE!(+SDBDATE=0)  D SETPAT G:$D(SDQUIT) EXIT D CALC
 D HDR S SDFIND=0
 F SDX=0:0 S SDX=$O(SDHR(SDX)) Q:SDX=""  I SDHR(SDX)>0 DO
 .D NOW^%DTC Q:%>SDX
 .S SDSAMEDT=0 I $P(SDX,".")=DT S SDSAMEDT=1
 .S SDFIND=1,Y=SDX X ^DD("DD") W ?7,$S(SDSAMEDT=1:"Today",1:$P(Y,"@"))," ",$P(Y,"@",2)," (",SDHR(SDX),")",! S SDX=9999999.9999
 I SDFIND=0 W $C(7),SDNOAPP,! H 1
 K SDQUIT K DIR S DIR(0)="E" W !!! D ^DIR I X[U S SDQUIT=1
 G EXIT
 ;
ALL(SC,SDBDATE,SDEDATE,SDDELARR) ; All available appointments for date range
 K SDPAGED D SETUPA,SETUPCK G:$D(SDQUIT) EXIT
 F SDBDATE=(SDBDATE-.001):0 S SDBDATE=$O(^SC(SC,"ST",SDBDATE)) Q:SDBDATE>SDEDATE!(SDBDATE="")  D SETPAT G:$D(SDQUIT) EXIT D CALC
 S SDCNTR=0,SDCOL=1,SDMONTH="",SDOLDMON="ZZ"
 D HDR S SDFIND=0
 F SDX=0:0 S SDX=$O(SDHR(SDX)) Q:SDX=""!($D(SDQUIT))  I SDHR(SDX)>0 DO
 .S X=$P(SDX,".") D DW^%DTC S SDDOW=$E(X,1,3)
 .S SDDOW=$TR(SDDOW,"ABCDEFGHIJKLMNOPQRSTUVWXYZ","abcdefghijklmnopqrstuvwxyz")
 .S X=$E(SDDOW,1,1),SDDOW=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")_$E(SDDOW,2,999)
 .S SDFIND=1,Y=SDX ;
 .X ^DD("DD")
 .I SDCNTR#2=0 S SDCOL=1
 .I SDCNTR#2=1 S SDCOL=40
 .D NOW^%DTC Q:%>SDX
 .S SDCNTR=SDCNTR+1,SDMONTH=$E(SDX,4,5) I SDOLDMON'=SDMONTH,SDOLDMON'="ZZ" W !
 .;Check to see if appt (if available) is past current date/time
 .S SDSAMEDT=0 I $P(SDX,".")=DT S SDSAMEDT=1
 .W ?SDCOL,$S(SDCNTR<10:" "_SDCNTR,SDCNTR>9&(SDCNTR<100):" "_SDCNTR,SDCNTR>9&(SDCNTR<1000):" "_SDCNTR,1:SDCNTR),". ",$S(SDSAMEDT=1:"Today",1:SDDOW)," ",$P(Y,"@")," ",$P(Y,"@",2)," (",SDHR(SDX),")" W:SDCOL=40 !!
 .S SDOLDMON=$E(SDX,4,5)
 .I $Y>(IOSL-5) DO  Q:$D(SDQUIT)
 ..K SDQUIT,DIR S DIR(0)="E" D ^DIR S SDPAGED=1 I X[U S SDQUIT=1 Q
 ..D HDR
 I SDFIND=0 W $C(7),SDNOAPP,! H 1
 ;
EXIT W !!
 I $G(SDDELARR)=1 K SDHR
 K DIR,DIRUT,SDBDATE,SDCNTR,SDCOL,SDCSLOTS,SDEDATE,SDFIND,SDINCR,SDMINUTE,SDNOAPP,SDPAT,SDQUIET,SDSL,SDSTRT,SDDOW,SDSAMEDT
 K SDSTRTX,SDSLOTS,SDX,SDY,X,Y,SDHOLIDY,SDMONTH,SDONEDAT,SDOLDMON,SDANS,SDBDATE1,SDEDATE1,SDXY,X1,X2,SDQUIT
 ;Kill leftover Fileman variables
 K %,%H,%I,%T,%Y
 Q
 ;
SETPAT ; Transform the pattern into something useful
 S SDPAT=$G(^SC(SC,"ST",SDBDATE,1))
 I SDPAT=""!($G(^SC(SC,"ST",SDBDATE,1))["CANCELLED")!($D(^HOLIDAY(SDBDATE))) Q
 S SDPAT=$E(SDPAT,8,999)
 ;
 I SDPAT?1"["1.4N1"]".E DO  Q
 .; Pattern similar to: MO 18 [1] [1] [1] [1] [1] [1] [1] | [1] [1] [1] [1] [1]
 .N SDX,SDY S SDXY="" F SDX=2:4:$L(SDPAT) S SDY=$E(SDPAT,SDX,SDX+3),SDY=$TR(SDY,"[]| ",""),SDXY=SDXY_+SDY_U
 .S SDPAT=SDXY
 ;
 I SDPAT'?1"["1.4N1"]".E DO
 .; Pattern=Anything else
 .N SDX,SDY S SDXY="" F SDX=2:2:$L(SDPAT) S SDY=$E(SDPAT,SDX,SDX+1),SDY=$TR(SDY,"[]| ",""),SDXY=SDXY_SDY_U
 .S SDPAT=SDXY
 Q
 ;
SETUPA ;basic setup
 K SDHR,SDRETURN
 I $G(SDDELARR)="" S SDDELARR=1 ; delete SDHR=1 or leave SDHR=0 ; default is 1
 I '$D(DT) D DT^DICRW
 I $G(SDONEDAT)=1,$G(SDEDATE)="" S X1=SDBDATE,X2=90 D C^%DTC S SDEDATE=X ; 90 day display on one date
 I $G(SDEDATE)="" S X1=SDBDATE,X2=365 D C^%DTC S SDEDATE=X ; 365 day display for all appointments
 S SDNOAPP="There were no available appointments found for the date entered."
 Q
 ;
SETUPCK I '$D(^SC(SC)) DO  Q
 .I '$D(SDQUIET) W !,$C(7),"The clinic was not found",! H 2
 .S SDRETURN="CLINIC_NOT_FOUND",SDQUIT=1
 S SDSL=$G(^SC(SC,"SL")) I SDSL="" DO  Q
 .I '$D(SDQUIET) W $C(7),"The clinic setup information was not found.",! H 2
 .S SDRETURN="CLINIC_SETUP_INFO_NOT_FOUND",SDQUIT=1 Q
 S SDSTRT=$P(SDSL,U,3),SDINCR=$P(SDSL,U,6),SDHOLIDY=$P(SDSL,U,8) I +SDSTRT=0 S SDSTRT=8
 S SDMINUTE=$S(SDINCR=1:"0^",SDINCR=2:"0^30^",SDINCR=3:"0^20^40^",SDINCR=4:"0^15^30^45^",SDINCR=6:"0^10^20^30^40^50^",1:"")
 I SDMINUTE="" DO  Q
 .I '$D(SDQUIET) W $C(7),"There were no increments per hour found for the clinic.",! H 2
 .S SDRETURN="NO_CLINIC_INCREMENTS_PER_HOUR",SDQUIT=1
 Q
 ;
CALC ; calculate available times
 F SDX=1:1 S SDY=$P(SDPAT,U,SDX) Q:SDY=""  ; Count slots for day (value does not have to be >0)
 S SDSLOTS=SDX-1,SDCSLOTS=SDSLOTS/SDINCR,SDCNTR=1,SDSTRTX=SDSTRT/100
 I SDCSLOTS#1=.5 S SDCSLOTS=SDCSLOTS+.5 ; odd # of slots, need to finish out hour.
 F SDX=1:1:SDCSLOTS DO
 .F SDY=1:1:(SDINCR) DO
 ..S SDHR(SDBDATE_SDSTRTX+($P(SDMINUTE,U,SDY)/10000))=+$P(SDPAT,"^",SDCNTR),SDCNTR=SDCNTR+1
 .S SDSTRTX=SDSTRTX+.01
 Q
 ;
HDR ; Header for interactive APIs
 W @IOF,!
 I $G(SDONEDAT)=2 W "Available Appointments From ",SDBDATE1," to ",SDEDATE1,!
 I $G(SDONEDAT)=1 W "Next Available Appointment",!
 W "For Clinic: ",$P(^SC(SC,0),U)
 W " (",$S(SDINCR=1:60,SDINCR=2:30,SDINCR=3:20,SDINCR=4:15,SDINCR=6:10,1:"???")," minute appointments)",!!!
 Q
 ;
DOC ; Variable documentation and explanation
 ;SDCSLOTS=Total slots per increment, i.e. hourly, half hour, 20 min, 15 min, 10 min
 ;SDHR()=Array that has the date/time^slots available for the clinic and date supplied
 ;SDCNTR=Utility counter, usedand reused as needed
 ;SDRETURN=An array for the 'QUIET' entry point and has FM date/time^# slots available
 ;SDCOL=Column to print ALL output in two columns
 ;SDFIND=Indicates whether data is available when returning interactive data
 ;SDINCR=Number of increments per hour
 ;SDMINUTE=Clinic appointment time
 ;SDPAGED=Indicates if at least one page of data has been presented and if to show prompt to continue or ^ to end
 ;SDPAT=Pattern from clinic date
 ;SDSL=Basic clinic information from ^SC(SC,"SL") node
 ;SDSLOTS=Total slots for one day - total clinic hours
 ;SDSTRT=Clinic starting time, with 8AM being the default if not supplied in clinic setup
 ;SDQUIET=No output to screen (future development)
 ;SDX, SDY, SDXY, X, Y=Utility variables, used and reused as needed
 ;SDBDATE=Beginning date to return data for
 ;SDBDATE1=Human readable beginning date
 ;SDEDATE=A calculated ending date to return data for (90 days)
 ;SDEDATE1=Human readable ending date
 ;SDDELARR=Flag to remove the SDHR array (1) or leave it intact (0) ; the default is 1



