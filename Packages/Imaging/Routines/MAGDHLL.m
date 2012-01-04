MAGDHLL ;WOIFO/MLH - IHE-based ADT interface for PACS - log to gateway ; 11/15/2006 08:36
 ;;3.0;IMAGING;**49**;Mar 19, 2002;Build 2033;Apr 07, 2011
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
 ;
LOGGW(XTYP) ; SUBROUTINE - log a generated message to the DICOM/text gateway
 ; input:    XTYP      message type (= MSH-9.1)
 ; expects:  HL()      array of HL7 variables
 ;           HLHDR()   array containing MSH segment info
 ;           HLA()     array of HL7 segments
 ;
 N MSGDT ; ----- message date and time from MSH-7 (in HL7 format)
 N MSGDFM ; ---- MSGDT date only (no time) in FileMan format
 N MSGDTFM ; --- MSGDT date and time in FileMan format
 N GWIX ; ------ gateway message index
 N GWHDR ; ----- 0 node of gateway message file
 N MSH ; ------- message header for gateway
 N GWSGIX ; ---- gateway segment index
 ;
 L +^MAGDHL7(2006.5,0):1E9 E  Q
 S GWIX=$O(^MAGDHL7(2006.5," "),-1)+1
 S GWHDR=$G(^MAGDHL7(2006.5,0))
 S $P(GWHDR,U,3)=GWIX,$P(GWHDR,U,4)=$P(GWHDR,U,4)+1
 S ^MAGDHL7(2006.5,0)=GWHDR
 S MSH=HLHDR(1),$P(MSH,HL("FS"),5)="VISTA DICOM/TEXT GATEWAY"
 S ^MAGDHL7(2006.5,GWIX,1,1,0)=MSH
 S IX=0,GWSGIX=1
 F I=1:1 S IX=$O(HLA("HLS",IX)) Q:'IX  D
 . S GWSGIX=GWSGIX+1
 . S ^MAGDHL7(2006.5,GWIX,1,GWSGIX,0)=HLA("HLS",IX)
 . Q
 S MSGDT=$P($P(HLHDR(1),HL("FS"),7),"-",1) ; omit TZ offset
 S MSGDFM=$E(MSGDT,1,8)-17000000
 S MSGDTFM=+(MSGDFM_"."_$E(MSGDT,9,12))
 S ^MAGDHL7(2006.5,GWIX,1,0)=U_U_GWSGIX_U_GWSGIX_U_MSGDFM
 S ^MAGDHL7(2006.5,GWIX,0)=MSGDFM_U_XTYP_U_MSGDTFM
 L -^MAGDHL7(2006.5,0)
 Q
