SDCI ;SF/GFT,MAN/GRR - CHECK-IN/UNSCHEDULED APPOINTMENT ; 5/31/13
 ;;5.3;Scheduling;**260003**;Aug 13, 1993
 ;
PT ;
 N DFN,APTS,SDD W !!
 S DFN=$$SELPAT^SDMUI() G PTQ:DFN<0
 S %=$$LSTPAPTS^SDMAPI1(.APTS,+DFN,$$DT^XLFDT(),$$FMADD^XLFDT($$DT^XLFDT(),1))
 S SDD=0
 F SDT=0:0 S SDT=$O(APTS(SDT)) Q:'SDT  D
 . Q:"^5^7^9^10^4^6^"[(U_+APTS(SDT,"STAT")_U)
 . W !!,"Appointment at "_$E(APTS(SDT,"DATE")_"000",9,12)_" on ",$$FDATE^VALM1(APTS(SDT,"DATE"))," in "_$P(APTS(SDT,"CLINIC"),U,2)
 . D ONE^SDAM2(+DFN,+APTS(SDT,"CLINIC"),+APTS(SDT,"DATE"),,1,"") S SDD=SDD+1
 W:'SDD *7,!,"This patient has no appointments scheduled today."
 W ! S DIR("A")="Do you want to add a new 'unscheduled' appointment'",DIR(0)="Y"
 D ^DIR K DIR G PTQ:Y'=1
 S SDY=$$CL^SDAMWI(DFN)
PTQ Q
