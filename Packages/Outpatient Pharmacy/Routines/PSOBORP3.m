PSOBORP3 ;ALBANY/BLD - TRICARE BYPASS/OVERRIDE AUDIT REPORT ;7/1/2010
 ;;7.0;OUTPATIENT PHARMACY;**358,359**;DEC 1997;Build 27
 ;
 ;Uses API 
 ;this routine will process the Tricare Bypass / Override Report based on the filtering criteria in routine PSOBORP0
 ;
 ;
EN(PSOSEL) ;
 ;
 ;THE INFORMATION FOR THE TRICARE BYPASS / OVERRIDE REPORT WILL BE GATHERED BY LOOPING THROUGH 
 ;FILE 52.87 (PSO TRICARE AUDIT LOG FILE) TO RETRIEVE THE INFORMATION BASED UPON THE FILTERING 
 ;REQUIREMENTS IN ROUTINE PSOBORP0.
 ;
 ;  SEE TRICARE BYPASS / OVERRIDE REPORT SDD FOR MOCK UP OF REPORT
 ;
 ;
 N ACTDT,AMT,BEGDT,DASH,DETSUM,ENDDT,EQUAL,HDR1,HDR2,HDR3,HDR4,HDR5,HDR6,MEAN,PAGE,PAGENBR,RXCNT
 N PSONOW,RJHDR,SPACE,STAR,PSOAUD,SUBTOTAL,SUBTOT,PROVTOT,PRORXTOT
 D INIT
 D PROCESS^PSOBORP2(.PSOSEL,.PSOAUD)                           ;process file 52.87 (Tricare Audit File)
 W:'PSOEXCEL @IOF D HDR
 I PSOSEL("SUM_DETAIL")="S" D SUMMARY(.PSOSEL,.PSOAUD)
 I PSOSEL("SUM_DETAIL")="D" D DETAIL(.PSOSEL,.PSOAUD)
 ;
 D END^PSOBORP2
 Q
 ;
DETAIL(PSOSEL,PSOAUD) ;for detail report
 ;
 N PAGELOC,AMT,PROV
 N GRDTOTAL,DIVISION,DIVTOT,DIVRXTOT,RXCNT,GRDRXTOT,ACTDT,TCTOTAL,TCTYPE,PROVIDER,PROVTOT,PROVRXT,SUBTOT,SUBTOTAL
 ;
 I PSOEXCEL D EDETAIL(.PSOSEL,.PSOAUD) Q        ;if Excel format chosen
 S PAGENBR=1
 D DETHDR
 ;
 S (GRDTOTAL,DIVISION,DIVTOT,DIVRXTOT,RXCNT,GRDRXTOT,ACTDT,TCTOTAL,TCTYPE,PROVIDER,PROVTOT,PROVRXT,PRORXTOT,PROVTOT,SUBTOTAL)=""
 ;
 I PSOSEL("TOTALS BY")="P"!(PSOSEL("TOTALS BY")="R") D  Q
 .F  S DIVISION=$O(PSOAUD(DIVISION)) Q:DIVISION=""!($G(PSOUT))  D
 ..S (PROVTOT,PRORXTOT,DIVTOT,DIVRXTOT)=""
 ..I ($Y+8)>IOSL D DETHDR Q:$G(PSOUT)
 ..W !!,$E(DASH,1,110)
 ..W !,"DIVISION: ",DIVISION
 ..F  S TCTYPE=$O(PSOAUD(DIVISION,TCTYPE)) Q:TCTYPE=""!($G(PSOUT))  D
 ...S TCT=TCTYPE,(TCRXTOT,TCTOTAL)="" D TCHDR(TCT)
 ...F  S PROVIDER=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER)) Q:PROVIDER=""!($G(PSOUT))  D
 ....S (PROVTOT,PRORXTOT)=""
 ....F  S ACTDT=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT))  Q:ACTDT=""!($G(PSOUT))  D
 .....S PROV=PROVIDER
 .....S AMT=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",9)
 .....S PROVTOT=$FN(PROVTOT+AMT,"T",2)
 .....S PRORXTOT=PRORXTOT+1
 .....S TCTOTAL=$FN(TCTOTAL+AMT,"T",2)
 .....S TCRXTOT=TCRXTOT+1
 .....S DIVTOT=$FN(DIVTOT+AMT,"T",2)
 .....S DIVRXTOT=DIVRXTOT+1
 .....S GRDTOTAL=$FN(GRDTOTAL+AMT,"T",2)
 .....S GRDRXTOT=GRDRXTOT+1
 .....Q:$G(PSOUT)  D:($Y+8)>IOSL DETHDR Q:$G(PSOUT)  D TCDSUMP(TCT,PROV,ACTDT)             ;detail print
 ....Q:$G(PSOUT)  D:($Y+8)>IOSL DETHDR Q:$G(PSOUT)  D PROVTOT(TCT,PROV,PROVTOT,PRORXTOT)
 ...Q:$G(PSOUT)  D:($Y+8)>IOSL DETHDR Q:$G(PSOUT)  D TCTOT(TCTOTAL,TCRXTOT,TCT)
 ..Q:$G(PSOUT)  D:($Y+8)>IOSL DETHDR Q:$G(PSOUT)  D DIVTOTP(DIVTOT,DIVRXTOT)
 .Q:$G(PSOUT)  D:($Y+8)>IOSL DETHDR Q:$G(PSOUT)  D GRDTOTP(GRDTOTAL,GRDRXTOT)
 ;
 Q
 ;
EDETAIL(PSOSEL,PSOAUD) ;for detail report
 ;
 N PAGELOC,AMT
 N GRDTOTAL,DIVISION,DIVTOT,DIVRXTOT,RXCNT,GRDRXTOT,ACTDT,TCTOTAL,TCTYPE,PROVIDER,PROVTOT,PROVRXT,SUBTOT,SUBTOTAL,PROV
 ;
 S PAGENBR=1
 D DETHDR
 ;
 S (GRDTOTAL,DIVISION,DIVTOT,DIVRXTOT,RXCNT,GRDRXTOT,ACTDT,TCTOTAL,TCTYPE,PROVIDER,PROVTOT,PROVRXT,SUBTOT,SUBTOTAL)=""
 ;
 I PSOSEL("TOTALS BY")="P"!(PSOSEL("TOTALS BY")="R") D  Q
 .F  S DIVISION=$O(PSOAUD(DIVISION)) Q:DIVISION=""!($G(PSOUT))  D
 ..F  S TCTYPE=$O(PSOAUD(DIVISION,TCTYPE)) Q:TCTYPE=""!($G(PSOUT))  D
 ...S TCT=TCTYPE
 ...F  S PROVIDER=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER)) Q:PROVIDER=""!($G(PSOUT))  D
 ....F  S ACTDT=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT))  Q:ACTDT=""!($G(PSOUT))  D
 .....S PROV=PROVIDER
 .....S AMT=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",9)
 .....Q:$G(PSOUT)  D TCDSUMP(TCTYPE,PROV,ACTDT)             ;detail print
 ....Q:$G(PSOUT)
 ...Q:$G(PSOUT)
 ..Q:$G(PSOUT)
 .Q:$G(PSOUT)
 ;
 Q
 ;
SUMMARY(PSOSEL,PSOAUD) ;for summary report
 ;
 N AMT,ACTDT,ACTDATE,DIVISION,PROVIDER,PHAMCST,PAGELOC,PROVIDER,TCTOTAL,TCTYPE,RXTOTAL,RXCNT,GRDTOTAL,SUBTOT,MEAN
 ;
 S PAGENBR=1
 D SUMHDR
 S (GRDTOTAL,DIVISION,DIVTOT,DIVRXTOT,RXCNT,GRDRXTOT,ACTDT,TCTOTAL,TCRXTOT,TCTYPE,PROVIDER,PROVTOT,PRORXTOT,SUBTOTAL)=""
 ;
 ;subtotals by provider
 I PSOSEL("TOTALS BY")="P"!(PSOSEL("TOTALS BY")="R") D
 .F  S DIVISION=$O(PSOAUD(DIVISION)) Q:DIVISION=""!($G(PSOUT))  D
 ..S (PROVTOT,PRORXTOT,RXCNT,DIVTOT,DIVRXTOT)=""
 ..I ($Y+8)>IOSL D SUMHDR Q:$G(PSOUT)
 ..W !!,$E(DASH,1,110)
 ..W !,"DIVISION: ",DIVISION
 ..F  S TCTYPE=$O(PSOAUD(DIVISION,TCTYPE)) Q:TCTYPE=""!($G(PSOUT))  D
 ...S TCT=TCTYPE,(TCRXTOT,TCTOTAL)="" D TCHDR(TCT)
 ...F  S PROVIDER=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER)) Q:PROVIDER=""!($G(PSOUT))  D
 ....S (PROVTOT,PRORXTOT)=0
 ....F  S ACTDT=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT))  Q:ACTDT=""!($G(PSOUT))  D
 .....S PROV=PROVIDER
 .....S AMT=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",9)
 .....S PROVTOT=$FN(PROVTOT+AMT,"T",2)
 .....S PRORXTOT=PRORXTOT+1
 .....S TCTOTAL=$FN(TCTOTAL+AMT,"T",2)
 .....S TCRXTOT=TCRXTOT+1
 .....S DIVTOT=$FN(DIVTOT+AMT,"T",2)
 .....S DIVRXTOT=DIVRXTOT+1
 .....S GRDTOTAL=$FN(GRDTOTAL+AMT,"T",2)
 .....S GRDRXTOT=GRDRXTOT+1
 ....Q:$G(PSOUT)  D:($Y+8)>IOSL SUMHDR Q:$G(PSOUT)  D TCSSUMP(PROVTOT,PRORXTOT,TCT,PROV)             ;summary print
 ...Q:$G(PSOUT)  D:($Y+8)>IOSL SUMHDR Q:$G(PSOUT)  D TCTOT(TCTOTAL,TCRXTOT,TCT)
 ..Q:$G(PSOUT)  D:($Y+8)>IOSL SUMHDR Q:$G(PSOUT)  D DIVTOTP(DIVTOT,DIVRXTOT)
 .Q:$G(PSOUT)  D:($Y+8)>IOSL SUMHDR Q:$G(PSOUT)  D GRDTOTP(GRDTOTAL,GRDRXTOT)
 ;
 Q
 ;
SUMHDR ;
 ;this will print the header and page breaks for summary report.
 ;
 ;
 I PAGENBR>1 D PAUSE^PSOBORP1 Q:$G(PSOUT)  W @IOF
 S PAGELOC=132-($L(PAGE)+$L(PAGENBR))
 W !,HDR1,?PAGELOC,PAGE,PAGENBR S PAGENBR=PAGENBR+1
 W !,HDR2,!,HDR3,!,HDR4 W !,$E(EQUAL,1,110)
 ;
 Q
 ;
DETHDR ;
 ;this will print the header and page breaks for the detail report
 ;
 I PAGENBR>1,PSOEXCEL Q                                       ;if Excel spreadsheet format
 ;
 I PAGENBR>1 D PAUSE^PSOBORP1 Q:$G(PSOUT)  W @IOF
 S PAGELOC=132-($L(PAGE)+$L(PAGENBR))
 I 'PSOEXCEL D
 .W !,HDR1,?PAGELOC,PAGE,PAGENBR S PAGENBR=PAGENBR+1
 .W !,HDR2,!,HDR3,!,HDR4,!,$E(EQUAL,1,110),!,HDR5,!,HDR6,!,$E(EQUAL,1,110)
 ;
 I PSOEXCEL D
 .W !,"BENEFICIARY NAME"_"^"_"ID"_"^"_"RX#"_"^"_"REF/ECME#"_"^"_"RX DATE"_"^"_"FILL LOC"_"^"_"STATUS"_"^"_"ACTION DATE"_"^"_"USER NAME"_"^"_"$BILLED"
 .W "^"_"QTY"_"^"_"NDC#"_"^"_"DRUG"_"^"_"REJECT CODE(S)"_"^"_"REJECT CODE"_"^"_"REJECT EXPLANATION"_"^"_"TRICARE JUSTIFICATION"
 ;
 Q
 ;
PROVTOT(TCT,PROVIDER,PROVTOT,PROVRXT) ;prints totals by provider
 ;
 Q:PSOEXCEL                           ;if Excel spreadsheet format
 ; 
 Q:TCTYPE="TRICARE INPATIENT"
 W !!,?10,PROV
 W !,?10,"SUBTOTALS",?51,PROVTOT
 W !,?10,"RX COUNT",?51,PROVRXT
 W !,?10,"MEAN",?51,$FN(PROVTOT/PROVRXT,"T",2),!
 S (PROVRXT,PROVTOT)=""
 ;
 Q
 ;
 ;
TCTOT(TCTOTAL,TCRXTOT,TCTYPE) ;
 ;print tctypes totals
 ;
 Q:PSOEXCEL                           ;if Excel spreadsheet format
 ;
 W !!,?5,TCTYPE
 W !,?5,"SUBTOTALS",?51,TCTOTAL
 W !,?5,"RX COUNT",?51,TCRXTOT
 W !,?5,"MEAN",?51,$FN(TCTOTAL/TCRXTOT,"T",2)
 ;
 ;
 Q
 ;
DIVTOTP(DIVTOT,DIVRXTOT) ;
 ;print the totals for a division
 ;
 Q:PSOEXCEL                           ;if Excel spreadsheet format
 ;
 W !!,"DIVISION ",DIVISION,?51,$E(DASH,1,13)
 W !,"SUBTOTALS",?51,DIVTOT
 W !,"RX COUNT",?51,DIVRXTOT
 W !,"MEAN",?51,$FN(DIVTOT/DIVRXTOT,"T",2)
 ;
 Q
 ;
GRDTOTP(GRDTOTAL,GRDRXTOT) ;
 ;
 Q:PSOEXCEL                           ;if Excel spreadsheet format
 ;
 N I
 ;
 I '$D(PSOAUD) W !!,?26,"NO INFORMATION FOUND..." Q
 F I=1:1:2 W !,?51,$E(DASH,1,13)
 W !!!,"GRAND TOTALS",?51,GRDTOTAL
 W !,"RX COUNT",?51,GRDRXTOT
 W !,"MEAN",?51,$FN(GRDTOTAL/GRDRXTOT,"T",2)
 W !,?51,$E(DASH,1,13)
 ;
 Q
 ;
 ;
TCDSUMP(TCTYPE,PROVIDER,ACTDT) ;print the summary
 ;
 N AMTBILL,DFN,NAME,ID,REFILL,RXNBR,RX,ECMENBR,RXDATE,RXINFO,RXQTY,NDCNBR,RXDRUG,VADM,USER,TRIJUST
 S RJHDR=$E(STAR,1,30)_$E(SPACE,1,3)_TCTYPE_$E(SPACE,1,3)_$E(STAR,1,(57-$L(TCTYPE)))
 S DFN=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",4)
 D DEM^VADPT
 S NAME=VADM(1)
 S ID=$P(VADM(2),"^",1),ID=$E(ID,$L(ID)-3,999)
 S RXNBR=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",2)
 S RX=$$GET1^DIQ(52,RXNBR,.01)
 S REFILL=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",3)
 S ECMENBR=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",10) I ECMENBR="" S ECMENBR="N/A"
 S ECMENBR=REFILL_"/"_ECMENBR
 S RXDATE=$$DATTIM($P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,1)),"^",6))
 S RXINFO=$$RXINFO(RXNBR)
 S USER=$P(^VA(200,$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,1)),"^",4),0),"^",1)
 S AMTBILL=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",9)
 S RXQTY=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",11)
 S NDCNBR=$TR($P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",7),"-","")
 S RXDRUG=$E($P($G(^PSDRUG($P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,0)),"^",8),0)),"^",1),1,24)
 S TRIJUST=$P($G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,2)),"^",1)
 ;
 ;for standard output
 I 'PSOEXCEL D
 .W !!,$E(NAME,1,30)_"/"_ID,?36,RX,?54,ECMENBR,?72,RXDATE,?90,RXINFO
 .W !,?4,$$DATTIM($P(ACTDT,".",1)),?22,$E(USER,1,20),?58,$FN(AMTBILL,"T",2),?72,RXQTY,?84,NDCNBR,?103,RXDRUG
 .I $D(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3)) D NCPDPRC(.PSOAUD)
 .;
 .;tricare justification
 .I $E(IOST,1,2)="C-" D
 ..I $L(TRIJUST)>125 W !,?4,$E(TRIJUST,1,125)_"..."
 ..I $L(TRIJUST)<125 W !,?4,TRIJUST
 ;
 ;if Excell format is selected
 I PSOEXCEL D
 .N REJIEN,FILE,FIELD,NCPDIEN,RJCDS,REJEXP
 .S REJIEN=0,FILE=9002313.93,FIELD=.02,RJCDS="",REJEXP=""
 .I $D(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3)) F  S REJIEN=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3,REJIEN)) Q:'REJIEN  D
 ..S NCPDIEN=$G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3,REJIEN))
 ..S RJCDS=$S($G(RJCDS)="":NCPDIEN,1:RJCDS_","_NCPDIEN)
 .I RJCDS'="",$P(RJCDS,":",1)'="eT" S REJEXP=$$GET1^DIQ(FILE,+$P(RJCDS,",",1),FIELD)
 .I RJCDS'="",$P(RJCDS,":",1)="eT" S REJEXP="TRICARE-DRUG NON BILLABLE"
 .W !,$E(NAME,1,30)_"^"_ID_"^"_RX_"^"_ECMENBR_"^"_RXDATE_"^"_RXINFO_"^"_$$DATTIM($P(ACTDT,".",1))_"^"_$E(USER,1,20)_"^"_$FN(AMTBILL,"T",2)_"^"_RXQTY_"^"_NDCNBR_"^"_RXDRUG_"^"_RJCDS_"^"_$P(RJCDS,",",1)_"^"_REJEXP_"^"_TRIJUST
 ;
 Q
 ;
NCPDPRC(PSOAUD) ;
 ;writes the NCPD reject code
 ;
 N REJIEN,FILE,FIELD,NCPDIEN,REJTXT
 S REJIEN=0,FILE=9002313.93,FIELD=.02
 F  S REJIEN=$O(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3,REJIEN)) Q:'REJIEN  D
 .S NCPDIEN=$G(PSOAUD(DIVISION,TCTYPE,PROVIDER,ACTDT,3,REJIEN))
 .I NCPDIEN'="eT" S REJTXT=$$GET1^DIQ(FILE,+NCPDIEN,FIELD)
 .I NCPDIEN="eT" S REJTXT="TRICARE-DRUG NON BILLABLE"
 .I 'PSOEXCEL W !,?4,NCPDIEN_":"_REJTXT
 .I PSOEXCEL W !,NCPDIEN_":"_REJTXT
 ;
 Q
 ;
RXINFO(RXNBR) ;
 ;this will return the data needed for the RX INFO on the Audit Report.
 ;
 ;
 N RFL,CMOP,RXSTATUS,FILLOC,BILLTYPE,RELDATE,RELSTATUS
 S RFL=$$LSTRFL^PSOBPSU1(RXNBR)
 S BILLTYPE="**"
 S FILLOC=$$MWC^PSOBPSU2(RXNBR,RFL)
 S RXSTATUS=$$GET1^DIQ(52,RXNBR,100,"I")
 S RXSTATUS=$$RXSTANAM(RXSTATUS)
 S RELDATE=$$RXRLDT^PSOBPSUT(RXNBR,RFL)
 S RELSTATUS=$S(RELDATE'="":"R",1:"N")
 I 'PSOEXCEL Q FILLOC_" "_BILLTYPE_" "_RXSTATUS_"/"_RELSTATUS
 I PSOEXCEL Q FILLOC_"^"_RXSTATUS_"/"_RELSTATUS
 ;
RXSTANAM(BPRXSTAT) ;*/
 Q:BPRXSTAT=0 "AC"  ; ACTIVE; 
 Q:BPRXSTAT=1 "NV"  ; NON-VERIFIED; 
 Q:BPRXSTAT=3 "HL"  ; HOLD; 
 Q:BPRXSTAT=5 "SU"  ; SUSPENDED; 
 Q:BPRXSTAT=11 "EX"  ; EXPIRED; 
 Q:BPRXSTAT=12 "DS"  ; DISCONTINUED; 
 Q:BPRXSTAT=13 "DL"  ; DELETED; 
 Q:BPRXSTAT=14 "DS"  ; DISCONTINUED BY PROVIDER; 
 Q:BPRXSTAT=15 "DS"  ; DISCONTINUED (EDIT); 
 Q:BPRXSTAT=16 "HL"  ; PROVIDER HOLD; 
 Q:BPRXSTAT=-1 "??"
 Q ""
 ;
 ;
TCSSUMP(SUBTOT,RXCNT,TCTYPE,PROVIDER,PHARMCST) ;print the summary
 ;
 I TCTYPE="TRICARE INPATIENT" Q
 S RJHDR=$E(STAR,1,30)_$E(SPACE,1,3)_TCTYPE_$E(SPACE,1,3)_$E(STAR,1,(57-$L(TCTYPE)))
 ;
 ;subtotals by provider
 W !!,?7,$S(PSOSEL("TOTALS BY")="P":"PROVIDER: ",1:"PHARMACIST: "),PROVIDER,?44,$E(DASH,1,13)
 W !,?7,"SUB-TOTALS",?51,SUBTOT
 W !,?7,"RX COUNT",?51,RXCNT
 W !,?7,"MEAN",?51,$FN(SUBTOT/RXCNT,"T",2),!
 ;
 Q
 ;
TCHDR(TCTYPE) ;print report header
 ;
 S (SUBTOT,RXCNT)=""
 I 'PSOEXCEL D  Q
 .S RJHDR=$E(STAR,1,30)_$E(SPACE,1,3)_TCTYPE_$E(SPACE,1,3)_$E(STAR,1,(57-$L(TCTYPE)))
 .W !!,RJHDR
 ;
 ;
 Q
 ;
HDR ;
 ;
 ;
 S HDR1="TRICARE BYPASS/OVERRIDE AUDIT REPORT -    "_DETSUM_" Print Date: "_PSONOW
 S HDR2="DIVISION(S): "_$$DIVISION()
 S HDR3="TC TYPES: "_$$HDR4(.PSOSEL)
 S HDR4="ALL PRESCRIPTIONS BY AUDIT DATE: From "_BEGDT_" through "_ENDDT
 I PSOSEL("SUM_DETAIL")="D" D
 .S HDR5="BENEFICIARY NAME/ID"_$E(SPACE,1,17)_"RX#"_$E(SPACE,1,15)_"REF/ECME#"_$E(SPACE,1,9)_"RX DATE"_$E(SPACE,1,11)_"RX INFO"
 .S HDR6=$E(SPACE,1,4)_"ACTION DATE"_$E(SPACE,1,8)_"USER NAME"_$E(SPACE,1,26)_"$BILLED "_$E(SPACE,1,6)_"QTY"_$E(SPACE,1,9)_"NDC#"_$E(SPACE,1,15)_"DRUG"
 ;
 ;
 Q
 ;
HDR4(PSOSEL) ;
 ;
 N TCTYPE,RCODE
 S (RCODE,TCTYPE)=""
 F  S TCTYPE=$O(PSOSEL("REJECT CODES",TCTYPE)) Q:TCTYPE=""  D
 .I $G(RCODE)="" S RCODE=PSOSEL("REJECT CODES",TCTYPE)
 .E  S RCODE=RCODE_", "_PSOSEL("REJECT CODES",TCTYPE)
 ;
 Q RCODE
 ;
 ;
DIVISION() ;list of divisions for header
 ;
 N DIV,DIVISION
 S (DIVISION,DIV)=""
 I PSOSEL("DIVISION")="A" Q "ALL"
 F  S DIV=$O(PSOSEL("DIVISION",DIV)) Q:DIV=""  D
 .I DIVISION="" S DIVISION=$P(PSOSEL("DIVISION",DIV),"^",2) Q
 .S DIVISION=DIVISION_$P(PSOSEL("DIVISION",DIV),"^",2)
 Q DIVISION
 ;
 ;
REJECTS() ;list the reject types for the header
 ;
 N REJ,REJECTS
 S (REJECTS,REJ)=""
 F  S REJ=$O(PSOSEL("REJECT CODES",REJ)) Q:REJ=""  D
 .I REJECTS="" S REJECTS=$S(REJ="I":"TRICARE INPATIENT",REJ="N":"TRICARE NON-BILLABLE PRODUCT",REJ="R":"TRICARE REJECT OVERRIDE",1:"ALL")
 .E  S REJECTS=REJECTS_"  "_$S(REJ="I":"TRICARE INPATIENT",REJ="N":"TRICARE NON-BILLABLE PRODUCT",REJ="R":"TRICARE REJECT OVERRIDE",1:"ALL")
 ;
 Q REJECTS
 ;
 ;
INIT ;
 ;
 N %,Y
 D NOW^%DTC S Y=% D DD^%DT S PSONOW=Y
 S $P(SPACE," ",150)=""
 S $P(DASH,"-",150)=""
 S $P(EQUAL,"=",150)=""
 S $P(STAR,"*",150)=""
 S PAGE="PAGE: "
 S DETSUM=$S(PSOSEL("SUM_DETAIL")="S":"SUMMARY",1:"DETAIL")
 S BEGDT=$$DATTIM(PSOSEL("BEGIN DATE"))
 S ENDDT=$$DATTIM(PSOSEL("END DATE"))
 S PSOEXCEL=$G(PSOSEL("EXCEL"))
 K SUBTOTAL,MEAN,SUBTOT,DIVISION,PROVIDER,TCTYPE,TCTYPE,RXCNT
 ;
 Q
 ;
 ;Convert FM date or date.time to displayable (mm/dd/yy HH:MM) format
 ;
DATTIM(X) ;
 N DATE,BPT,BPM,BPH,BPAP
 S DATE=$S(X:$E(X,4,5)_"/"_$E(X,6,7)_"/"_$E(X,2,3),1:"")
 S BPT=$P(X,".",2) S:$L(BPT)<4 BPT=BPT_$E("0000",1,4-$L(BPT))
 S BPH=$E(BPT,1,2),BPM=$E(BPT,3,4)
 S BPAP="AM" I BPH>12 S BPH=BPH-12,BPAP="PM" S:$L(BPH)<2 BPH="0"_BPH
 I BPT S:'BPH BPH=12 S DATE=DATE_" "_BPH_":"_BPM_BPAP
 Q $G(DATE)
 ;
