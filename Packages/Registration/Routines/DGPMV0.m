DGPMV0 ;ALB/MRL/MIR - SPECIAL LOOK-UP FOR LODGERS; 8/26/13
 ;;5.3;Registration;**260005**;Aug 13, 1993
SPCLU ;Special (quick) look-up for check-out lodgers
 N DIC
 S DGER=0,DIC="^DPT(",DIC(0)="EQMZ" R !,"Check-out PATIENT:  ",X:DTIME I '$T!(X["^")!(X="") S DGER=1 Q
 N %,CI
 S %=$$LSTCOPAT^DGPMAPI9(.CI,$S(X["?":"",1:X))
 I X["?" D COHELP G SPCLU
 D ^DIC I Y'>0 G SPCLU
 I '$G(CI(0)) W !?5,"Patient was never a lodger ??" G SPCLU
 S DFN=+Y
 Q
COHELP ;help for check-out lodgers...list patients to choose from
 W !," ANSWER WITH PATIENT, OR SOCIAL SECURITY NUMBER, OR WARD LOCATION, OR",!,"     ROOM-BED",!,"CHOOSE FROM:"
 N IN,DGCT,DGFL
 S (DGCT,DGFL)=0
 F IN=0:0 S IN=$O(CI(IN)) Q:'IN  S DGCT=DGCT+1 D WRITE Q:DGFL
 K DGCT,DGFL,DFN,DIR,X,Y Q
WRITE ;write out identifiers
 I DGCT>(IOSL-4) S DIR(0)="E" D ^DIR I 'Y S DGFL=1 Q
 N SSN,DOB S SSN=$E(CI(IN,"SSN"),1,3)_"-"_$E(CI(IN,"SSN"),4,7)_"-"_$E(CI(IN,"SSN"),8,13)
 S DOB=$G(CI(IN,"BIRTH"))
 W !?4,CI(IN,"NAME"),"   ",SSN,"   " I DOB W $E(DOB,1,2),"-",$E(DOB,4,5),"-",$E(DOB,9,10)
 Q
