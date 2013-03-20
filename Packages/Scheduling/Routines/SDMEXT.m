SDMEXT ;RGI/CBR - EXTERNAL API; 3/20/13
 ;;5.3;scheduling;**260003**;08/13/93
CNSSTAT(IFN) ; Get consult status
 Q $P($G(^GMR(123,IFN,0)),U,12)
 ;
CNSEXST(IFN) ; Consult exists
 Q $D(^GMR(123,+$G(IFN)))
 ;
GETMOVDT(IFN) ; Get patient movement
 Q +$G(^DGPM(IFN,0))
 ;
HASMOV(DFN) ; Has movement?
 Q $D(^DGPM("C",DFN))
 ;
LSTSADM(RETURN,DFN,SD,CAN) ; Get scheduled admissions
 N LST,FLDS K RETURN
 D LSTSADM^SDMDALE(.LST,5,.SD,.CAN)
 S FLDS(13)="CANCEL DT",FLDS(2)="DATE"
 D BLDLST^SDMAPI(.RETURN,.LST,.FLDS)
 Q 1
 ;
