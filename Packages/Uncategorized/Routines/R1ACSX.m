R1ACSX ;VISN21/vhamachillsg - Generate postcard data stream
 ;;3.0;Region 1 Appointment Card;;March 23, 2011;Build 9
 ;
 ; This routine is the utility API that will perform the file creation,
 ; generation of postcard data, and coordinate the file transfer of the
 ; postcard information.
 Q
 ;
OFILE(X) ;
 ; Open XEROX data stream file - return POP for user to check
 ;                               and see if ile was opened
 N R1ACFILE,R1ACSTA,R1ACPATH,R1ACFTST,R1ACJUNK,R1ACFCNT,POP,R1ACDEST
 K ^TMP("R1ACSX",$J)
 S R1ACPATH=$P($G(^DIZ(612418.5,1,0)),U,2)
 S R1ACPATH=$P(R1ACPATH,"]",1)_".PCARD]"
 S R1ACSTA=$$KSP^XUPARAM("INST")
 S R1ACFILE="R1AC_"_R1ACSTA_"_"_$J_"_"_$P($H,",",2)_".TXT"
 S R1ACMG=$P($G(^DIZ(612418.5,1,2)),U,6)
 S R1ACDEST=R1ACPATH_R1ACFILE
 ; test and see if file exists, if so create a new file.
 F  K R1ACFTST,R1ACJUNK S R1ACFTST(R1ACFILE)="" Q:'$$LIST^%ZISH(R1ACPATH,"R1ACFTST","R1ACJUNK")  D
 . S R1ACFCNT=$G(R1ACFCNT)+1
 . S R1ACFILE="R1AC_"_R1ACSTA_"_"_$J_"_"_$P($H,",",2)_"_"_R1ACFCNT_".TXT"
 . S R1ACDEST=R1ACPATH_R1ACFILE
 S ^TMP("R1ACSX",$J,0)=DT_U_DT
 S ^TMP("R1ACSX",$J,1,"VIPP","DESTINATION")=R1ACDEST
 D OPEN^%ZISH("VIPP",R1ACPATH,R1ACFILE,"W")
 Q POP
 ;
CFILE ; Close XEROX data stream file
 D CLOSE^%ZISH("VIPP")
 I '$D(^TMP("R1ACSX",$J,1,"VIPP","DESTINATION")) K ^TMP("R1ACSX",$J) Q
 D PREFTP
 K ^TMP("R1ACSX",$J),R1ACMG
 Q
 ;
PREFTP ; prepare a FTP session
 ; read postcard file and check if 1 or more records were written, if not no need to transmit
 N R1ACZZ,R1ACREC,R1ACPATH,R1ACFILE,R1ACFDEL,R1ACDEST,X,POP
 S R1ACDEST=^TMP("R1ACSX",$J,1,"VIPP","DESTINATION")
 S R1ACPATH=$P(R1ACDEST,"]")_"]",R1ACZZ=0
 S R1ACFILE=$P(R1ACDEST,"]",2)
 D OPEN^%ZISH("R1ACTXT",R1ACPATH,R1ACFILE,"R",512)
 I POP D
 .S R1ACZZ=-1
 E  D
 .U IO
 .F  R R1ACREC:DTIME Q:$$STATUS^%ZISH  S R1ACZZ=$G(R1ACZZ)+1
 .D CLOSE^%ZISH("R1ACTXT")
 ;
 I '$D(ZTQUEUED) D HOME^%ZIS U IO
 ;
 I R1ACZZ<1 D  Q
 .I $E($G(IOST),1,2)="C-" W !,"File "_R1ACDEST_" has nothing to transmit",!
 .S R1ACFDEL(R1ACFILE)="",X=$$DEL^%ZISH(R1ACPATH,$NA(R1ACFDEL)) ; delete postcard file
 D BLDFTP^R1ACSX1   ; build FTP script
 D REGFTP^R1ACSX1   ; register FTP script in tracking file
 D FTP^R1ACSX1      ; transmit file to POSTALSOFT server
 Q
 ;
 ;
BLDDS(DFN,CIEN,ADT,PCARD,CADT,CCLN) ;
 ; PCARD == Communication Type    <---- determines which template gets used
 ;     User must pass:  Patient IEN, Clinic IEN, Appotment date/time, Post Card Type
 N CHK1,R1ACCLN,REACT,RESULT,R1ACLS2
 D  Q:'CHK1
 .S CHK1=1
 .I PCARD<1!(PCARD>15) S CHK1=0
 .I +DFN=0 S CHK1=0
 .I CIEN=0&(PCARD'=13) S CHK1=0
 .I PCARD=13&((+$G(CADT)=0)!(+$G(CCLN)=0)) S CHK1=0
 .I (+$G(ADT)=0)&((+PCARD'=1)&(PCARD'=13)) S CHK1=0 W "FAIL"
 .I PCARD'=13&'$D(^DIZ(612418,+CIEN,0)) S CHK1=0
 .I PCARD=13&'$D(^DIZ(612418,+$G(CCLN),0)) S CHK1=0
 .Q
 I PCARD=13 S R1ACCLN=CCLN
 E  S R1ACCLN=CIEN
 ;check BAD ADDRESS INDICATOR on file #2 for patient, if not "" quit
 I $$GET1^DIQ(2,DFN,.121)'="" Q  ;Quit if flagged for Bad Address Indicator
 ;Quit if Test Patient
 S R1ACLS2=$E($$GET1^DIQ(2,DFN,.01),1,2),R1ACLS2=$TR(R1ACLS2,"z","Z") Q:R1ACLS2="ZZ"
 I $E($$GET1^DIQ(2,DFN,.09),1,5)="00000" Q
 ;
 I PCARD=1 S ADT=0
 N ACT,R1ACCP,STOPCD,CLNNME,X,Y,Z,INACT
 ;if clinic not active quit
 D  Q:RESULT=0
 .S RESULT=1 ;Active Clinic with no entry in X-Walk File
 .I $P(^SC(+R1ACCLN,0),"^",3)'="C" S RESULT=0
 .S INACT="" I $D(^SC(+R1ACCLN,"I")) S INACT=$P($G(^SC(+R1ACCLN,"I")),U)
 .S REACT="" I $D(^SC(+R1ACCLN,"I")) S REACT=$P($G(^SC(+R1ACCLN,"I")),U,2)
 .I INACT]""&(((INACT<DT)&(REACT=""))) S RESULT=0
 .I (INACT]""&(REACT]""))&((INACT<DT)&(REACT>DT)) S RESULT=0
 .Q
 ; end of active clinic check
 N CT,LL,X,Y,STANUM,PADD1,PADD2,PADD3,PADD4,ADT1,ADT2,DOW,%DT
 D BLDDTL
 Q
 ;
BLDDTL ; build data stream
 N DPTNAME,R1ACNME,R1ACCR1,R1ACPST,R1ACPZIP,R1ACADD,R1ACCAD1,R1ACCAD2,R1ACCFN,R1ACCMS,R1ACPAD,R1ACPL,ADTD,ADTT
 N R1ACBBL1,R1ACBBL2,R1ACBBL3,R1ACBBL4,R1ACBBL5,R1ACBBL6,R1ACBBL7,R1ACBBL8,R1ACBBL9,DIVI,CNAME,CDOW,CADTD,CNAME,CADTT
 N R1ACF1,R1ACF2,R1ACF3,R1ACF4,R1ACF5,R1ACF6,R1ACF7,R1ACF8,R1ACF9,R1ACF10,R1ACPH,R1ACPL1,R1ACPL2,R1ACPL3,R1ACCPH,R1ACCR2
 N VAPA
 ;
 S DPTNAME("FILE")=2,DPTNAME("FIELD")=".01",DPTNAME("IENS")=(+DFN)_","
 S R1ACNME=$$NAMEFMT^XLFNAME(.DPTNAME,"G","M")
 S R1ACCR1=$G(^DIZ(612418,+R1ACCLN,0)) ;crosswalk file node 0
 S R1ACCR2=$G(^DIZ(612418,+R1ACCLN,2)) ;crosswalk file node 0
 S R1ACCMS=$P(R1ACCR1,U,2)  ;clinic mail stop
 S R1ACCFN=$P(R1ACCR1,U,3)  ;clinic friendly name
 I R1ACCFN="" S R1ACCFN=$P($G(^SC(R1ACCLN,0)),U)  ;clinic name
 S R1ACPL=$P(R1ACCR1,U,4)   ; physical location #1
 S R1ACPL2=$P(R1ACCR1,U,7)  ; physical location #2
 S R1ACPL3=$P(R1ACCR1,U,8)  ; physical location #3
 S R1ACCPH="" ;initialize variable
 S R1ACCPH=$P(R1ACCR1,U,5)  ;SFVAMC/clinic phone # for override of postcard CANCEL number
 I PCARD="1"!(PCARD="13")!(PCARD="10") S R1ACCPH=$P(R1ACCR1,U,6) ;SFVAMC/****clinic phone # for override of postcard MAKE APPT number
 ;
 ; get blue box/special comments
 N BBNODE
 S BBNODE=$S(PCARD=2:3,PCARD=3:4,PCARD=4:5,PCARD=5:6,PCARD=6:7,PCARD=7:8,PCARD=8:9,PCARD=9:10,PCARD=10:11,PCARD=11:12,PCARD=12:13,PCARD=13:14,PCARD=14:15,PCARD=15:16,1:1)
 S R1ACBBL1=$G(^DIZ(612418,+R1ACCLN,BBNODE,1,0))
 S R1ACBBL2=$G(^DIZ(612418,+R1ACCLN,BBNODE,2,0))
 S R1ACBBL3=$G(^DIZ(612418,+R1ACCLN,BBNODE,3,0))
 S R1ACBBL4=$G(^DIZ(612418,+R1ACCLN,BBNODE,4,0))
 S R1ACBBL5=$G(^DIZ(612418,+R1ACCLN,BBNODE,5,0))
 S R1ACBBL6=$G(^DIZ(612418,+R1ACCLN,BBNODE,6,0))
 S R1ACBBL7=$G(^DIZ(612418,+R1ACCLN,BBNODE,7,0))
 S R1ACBBL8=$G(^DIZ(612418,+R1ACCLN,BBNODE,8,0))
 S R1ACBBL9=$G(^DIZ(612418,+R1ACCLN,BBNODE,9,0))
 ;
 ;get patient address info
 D
 .; patient address
 . D ADD^VADPT
 . F LL=1:1:4 S R1ACPAD(LL)=VAPA(LL)
 . S R1ACPST=$P(VAPA(5),U,1) I R1ACPST'="" S R1ACPST=$P(^DIC(5,R1ACPST,0),U,2)
 . S R1ACPZIP=$P(VAPA(11),U,2) ;ZIP +4
 . D KVAR^VADPT
 . Q
 I R1ACPZIP="" Q  ;If zipcode "", then quit - not valid mailing address
 ; clinic address
 S R1ACCAD1=$P(R1ACCR2,U,1)
 S R1ACCAD2=$P(R1ACCR2,U,2)
 K Y,Z
 S Z=+$P(^SC(+R1ACCLN,0),U,4)
 I Z="" S (R1ACCAD1,R1ACCAD2)="" Q  ;Set Address Line 1&2 ="" if no INSTITUTION field entered
 S STANUM=$P(^SC(+R1ACCLN,0),U,15),Y=$P($G(^DIC(4,Z,1)),U,2),STANUM=$P($G(^DG(40.8,STANUM,0)),U,2)
 I R1ACCAD1="" S R1ACCAD1=+$P(^SC(+R1ACCLN,0),U,4),R1ACCAD1=$P($G(^DIC(4,R1ACCAD1,1)),U)
 I R1ACCAD2="" S R1ACCAD2=$P($G(^DIC(4,Z,1)),U,3)_", "_$P(^DIC(5,$P($G(^DIC(4,Z,0)),U,2),0),U,2)_"  "_$P($G(^DIC(4,Z,1)),U,4)
 I $D(^DIZ(612418.7,Z)) D  ; override facility address with a mailing address
 .S R1ACCAD1=$P($G(^DIZ(612418.7,Z,0)),U,2)
 .S R1ACCAD2=$P($G(^DIZ(612418.7,Z,0)),U,4)_" "_$P($G(^DIZ(612418.7,Z,0)),U,5)_"  "_$P($G(^DIZ(612418.7,Z,0)),U,6)
 .Q
 ;
 ; format appointment date ==> Friday, Jun 06, 2006
 ;   time a separate field ==> 12:12 pm
 I $G(ADT)>0 D
 .S DOW=$$DOW^XLFDT($S(ADT[".":$P(ADT,"."),1:ADT))
 .S ADTD=$$FMTE^XLFDT(ADT,"1P"),ADTT=$P(ADTD," ",4,5),ADTD=$P(ADTD," ",1,3),ADTD=DOW_", "_ADTD
 E  S (DOW,ADTD,ADTT)=""
 ;
 I $G(CADT)>0 D
 .S CDOW=$$DOW^XLFDT($S(CADT[".":$P(CADT,"."),1:CADT))
 .S CADTD=$$FMTE^XLFDT(CADT,"1P"),CADTT=$P(CADTD," ",4,5),CADTD=$P(CADTD," ",1,3),CADTD=CDOW_", "_CADTD
 E  S (CDOW,CADTD,CADTT)=""
 ;
 D WRTPCARD
 Q
 ;
WRTPCARD ;
 ; send data to XEROX print stream - if BLUEBOX information null do not print the postcard.
 N BAILOUT,BIGSTRG
 D
 .S BAILOUT=0
 .S BIGSTRG=R1ACBBL1_R1ACBBL2_R1ACBBL3_R1ACBBL4_R1ACBBL5_R1ACBBL6_R1ACBBL7_R1ACBBL8_R1ACBBL9
 .I $TR(BIGSTRG," ","")="" S BAILOUT=1 Q
 .D  ;check and strip any control characters
 ..N Y,X,ERR
 ..S X=BIGSTRG
 ..S Y="" F Y("CTRL1")=0:1:32,128:1:255 S Y=Y_$C(Y("CTRL1"))
 ..S X=$TR(X,Y,"") K Y I X="" S BAILOUT=1
 ..I $L(R1ACBBL1)>65 S ERR(1)="",BAILOUT=1
 ..I $L(R1ACBBL2)>65 S ERR(2)="",BAILOUT=1
 ..I $L(R1ACBBL3)>65 S ERR(3)="",BAILOUT=1
 ..I $L(R1ACBBL4)>65 S ERR(4)="",BAILOUT=1
 ..I $L(R1ACBBL5)>65 S ERR(5)="",BAILOUT=1
 ..I $L(R1ACBBL6)>65 S ERR(6)="",BAILOUT=1
 ..I $L(R1ACBBL7)>65 S ERR(7)="",BAILOUT=1
 ..I $L(R1ACBBL8)>65 S ERR(8)="",BAILOUT=1
 ..I $L(R1ACBBL9)>65 S ERR(9)="",BAILOUT=1
 ..I BAILOUT&$D(ERR) D
 ...Q
 ..Q
 Q:BAILOUT
 ;
 ;
 W PCARD_U_STANUM_U_R1ACNME_U_$G(R1ACPAD(1))_U_$G(R1ACPAD(2))_U_$G(R1ACPAD(3))_U_$G(R1ACPAD(4))_U_$G(R1ACPST)_U_$G(R1ACPZIP)_U_ADTD_U_ADTT_U_CADTD_U_CADTT
 W U_CIEN_U_R1ACCFN_U_R1ACCMS_U_R1ACPL_U_R1ACCAD1_U_R1ACCAD2
 W U_R1ACBBL1_U_R1ACBBL2_U_R1ACBBL3_U_R1ACBBL4_U_R1ACBBL5_U_R1ACBBL6_U_R1ACBBL7_U_R1ACBBL8_U_R1ACBBL9_U_R1ACCPH_U_R1ACPL2_U_R1ACPL3
 W !
 ; log activity
 I $G(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST"))'=1 D
 .N R1ACFDA,R1ACIEN,X,R1ACDATA,Y
 .S X="N" D ^%DT
 .I '$D(^DIZ(612418.3,Y)) D
 ..S R1ACFDA(612418.3,"+1,",.01)=Y
 ..S R1ACIEN(1)=Y
 .. D UPDATE^DIE(,"R1ACFDA","R1ACIEN")
 .. Q
 .S R1ACDATA(612418.31,"+2,"_Y_",",.01)=$P($H,",",2)
 .S R1ACDATA(612418.31,"+2,"_Y_",",1)=DFN
 .S R1ACDATA(612418.31,"+2,"_Y_",",2)=R1ACCLN
 .S R1ACDATA(612418.31,"+2,"_Y_",",3)=ADT
 .S R1ACDATA(612418.31,"+2,"_Y_",",4)=PCARD
 .S R1ACDATA(612418.31,"+2,"_Y_",",5)=DUZ
 .D UPDATE^DIE("","R1ACDATA","R1ACIEN","MSG")
 .Q
 E  S ^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST","CNT")=$G(^TMP("R1ACSCRD",$J,1,"VIPP","R1ACTEST","CNT"))+1
 ;
 Q
