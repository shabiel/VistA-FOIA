SDMEXT ;RGI/CBR - EXTERNAL API; 08/10/2012
 ;;5.3;scheduling;**260003**;08/13/93
CNSSTAT(IFN) ; Get consult status
 Q $P($G(^GMR(123,IFN,0)),U,12)
 ;
GETMOVDT(IFN) ; Get patient movement
 Q +$G(^DGPM(IFN,0))
 ;
HASMOV(DFN) ; Has movement?
 Q $D(^DGPM("C",DFN))
 ;
