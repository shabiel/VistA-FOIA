SDMAPI4 ;RGI/VSL - APPOINTMENT API; 5/31/13
 ;;5.3;scheduling;**260003**;08/13/93;
CHECKO(RETURN,DFN,SD,SC,CDT) ; Check out
 ;Input:
 ; .RETURN [Required,Boolean] Set to 1 if the check-out succeeded
 ;                            Set to Error description if the call fails
 ;                            Error format: RETURN(0) - [String] error_code^text^level (1 for error, 2 for warning, 3 for warning)
 ;    RETURN("COD") - [DateTime] Checked out date/time
 ;    RETURN("COVISIT") - [Boolean] Collateral visit (1=this patient has been seen as a collateral for another patient)
 ;    RETURN("LOCATION") - [Numeric] Encounter location (pointer to file 44)
 ;    RETURN("SDOE") - [Numeric] Pointer to the corresponding outpatient encounter (file 409.68)
 ;    RETURN("VISIT") - [Numeric] Visit file entry (pointer to file 9000010)
 ;  DFN [Required,Numeric] Patient IEN
 ;  SD [Required,DateTime] Appointment date/time
 ;  SC [Required,Numeric] Clinic IEN
 ;Output:
 ; 1=Success,0=Failure 
 N CAPT,OE,APT0,CD,%,STATUS,APT0
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 S %=$$CHKCLN^SDMAPI3(.RETURN,.SC) Q:'% 0
 I +$G(SD)=0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 S APT0=$$GETAPT0^SDMDAL2(+DFN,+SD)
 I APT0="" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNFND") Q 0
 S %=$$GETSCAP^SDMAPI1(.CAPT,+SC,+DFN,+SD)
 I '$G(CAPT("IFN")) D ERRX^SDAPIE(.RETURN,"APTCOCN") Q 0
 S APT0=$$GETAPT0^SDMDAL2(+DFN,+SD)
 S STATUS=$$STATUS^SDAM1(+DFN,+SD,+$G(APT0),$G(APT0))
 K % S %=$$CHKCO(.RETURN,+DFN,+SD,+STATUS)
 Q:'RETURN 0
 I '$$NEW^SDPCE(+SD) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCONW",,2) Q 0
 S:$G(CDT)'>0 CDT=$$NOW^XLFDT()
 S CD(304)=DUZ,CD(303)=$E(CDT,1,12)
 D UPDCAPT^SDMDAL4(.CD,+SC,+SD,CAPT("IFN"))
 S RETURN("SDOE")=$$GETAPT(+DFN,+SD,+SC)
 S OE(.07)=CDT
 D UPDOE^SDMDAL4(,.OE,RETURN("SDOE"))
 S %=$$GETCO(.RETURN,+DFN,+SD,+SC)
 I "^2^8^12^"[("^"_+STATUS_"^"),$P(STATUS,";",3)["CHECKED OUT" D
 . S RETURN("CO")=1 S RETURN=0
 . D ERRX^SDAPIE(.RETURN,"APTCOAC",,2)
 Q RETURN
 ;
GETCO(RETURN,DFN,SD,SC) ; Get check out info
 N CAPT,OE,APT0,CD,%,PAPT
 K RETURN S RETURN=0
 S %=$$GETSCAP^SDMAPI1(.CAPT,+SC,+DFN,+SD)
 D GETPAPT^SDMDAL4(.PAPT,DFN,SD)
 S RETURN("SDOE")=PAPT(21,"I")
 S RETURN("COD")=CAPT("CHECKOUT")
 S OE(.04)="",OE(.05)=""
 D GETOE^SDMDAL4(.OE,RETURN("SDOE"))
 S RETURN("LOCATION")=OE(.04)
 S RETURN("VISIT")=OE(.05)
 S RETURN("COVISIT")=PAPT(13,"I")
 S RETURN=1
 Q RETURN
 ;
GETAPT(DFN,SDT,SDCL,SDVIEN) ;Look-up Outpatient Encounter IEN for Appt
 ; Input  -- DFN      Patient file IEN
 ;           SDT      Appointment Date/Time
 ;           SDCL     Hospital Location file IEN for Appt
 ;           SDVIEN   Visit file pointer [optional]
 ; Output -- Outpatient Encounter file IEN
 N PAPT
 S PAPT(21)=""
 D GETPAPT^SDMDAL2(.PAPT,+DFN,+SDT)
 I 'PAPT(21) D APPT^SDVSIT(+DFN,+SDT,+SDCL,$G(SDVIEN)) D GETPAPT^SDMDAL2(.PAPT,+DFN,+SDT)
 I PAPT(21) D VIEN^SDVSIT2(PAPT(21),$G(SDVIEN))
 Q +$G(PAPT(21))
 ;
CHKCO(RETURN,DFN,SD,STATUS) ; Check in check out
 N APT0,%
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 I +$G(SD)=0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 S APT0=$$GETAPT0^SDMDAL2(+DFN,+SD)
 I APT0="" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNFND") Q 0
 I '$D(STATUS) D
 . S STATUS=$$STATUS^SDAM1(+DFN,+SD,+$G(APT0),$G(APT0))
 S %=$$CHKSPCO(.RETURN,+DFN,+SD,+STATUS) Q:'% 0
 I $P(+SD,".")>$$NOW^XLFDT S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCOTS") Q 0
 S RETURN=1
 Q 1
 ;
CHKSPCO(RETURN,DFN,SD,STATUS) ; Check if status permit check in
 N IND,STAT,STATS
 K RETURN S RETURN=0
 D LSTCOST1^SDMDAL2(.STAT)
 D BLDLST^SDMAPI(.STATS,.STAT)
 S IND=0
 F  S IND=$O(STATS(IND)) Q:IND=""!(RETURN=1)  D
 . I STATS(IND,"ID")=+STATUS S RETURN=1 Q
 I 'RETURN D ERRX^SDAPIE(.RETURN,"APTCOCE")
 Q RETURN
 ;
CHKDCO(RETURN,DFN,SD) ; Check delete check out
 N PAPT,CAPT,OE,SDATA,X,%
 K RETURN S RETURN=0
 S PAPT(21)="",PAPT(.01)=""
 S OE(.01)="",OE(.04)="",OE(.05)="",OE(.08)="",OE(.09)="",OE(.06)=""
 D GETPAPT^SDMDAL2(.PAPT,+DFN,+SD)
 S %=$$GETSCAP^SDMAPI1(.CAPT,PAPT(.01),+DFN,+SD)
 D GETOE^SDMDAL4(.OE,PAPT(21))
 I 'PAPT(21)!('CAPT("CHECKOUT")) D ERRX^SDAPIE(.RETURN,"APTDCOD") Q 0
 I '$$NEW^SDPCE(OE(.01)) D ERRX^SDAPIE(.RETURN,"APTDCOO") Q 0
 S RETURN=1
 Q 1
 ;
DELCOSD(RETURN,DFN,SD) ; Delete check out (SD)
 ;Input:
 ; .RETURN [Required,Boolean] Set to 1 if the check-out succeeded
 ;                            Set to Error description if the call fails
 ;                            Error format: RETURN(0) - [String] error_code^text^level (1 for error, 2 for warning, 3 for warning)
 ;    RETURN("OE") [Numeric]Pointer to the corresponding outpatient encounter (file 409.68)
 ;  DFN [Required,Numeric] Patient IEN
 ;  SD [Required,DateTime] Appointment date/time
 ;Output:
 ; 1=Success,0=Failure
 N %,SDELHDL,APT0
 K RETURN S RETURN=0
 I '$$CANDELCO^SDMAPI4(.RETURN) Q 0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 I +$G(SD)=0 S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 S APT0=$$GETAPT0^SDMDAL2(+DFN,+SD)
 I APT0="" S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNFND") Q 0
 S %=$$CHKDCO(.RETURN,+DFN,+SD)
 I RETURN=0 Q 0
 N SDOE,SC,OE,SDDA,X
 S %=$$SETCO(.SDOE,.DFN,.SD,.OE,.SC,.SDDA)
 I '$$NEW^SDPCE(+SD) D ERRX^SDAPIE(.RETURN,"APTDCOO") Q 0
 S SDELHDL=$$HANDLE^SDAMEVT(1)
 S X=$$DELVFILE^PXAPI("ALL",OE(.05),"","","")
 S %=$$DELCOL^SDMAPI3(.RETURN,+DFN,+SD,+SC,SDDA,+SDOE,.OE)
 S SDOE=$$GETAPT(+DFN,+SD,+SC)
 S RETURN("OE")=SDOE
 S RETURN=1
 Q 1
 ;
SETCO(SDOE,DFN,SD,OE,SC,SDDA) ; Set Check out params
 N PAPT,CAPT,%
 I '$D(SDOE) D
 . S PAPT(21)="",PAPT(.01)=""
 . D GETPAPT^SDMDAL2(.PAPT,+DFN,+SD)
 . S SDOE=PAPT(21),SC=PAPT(.01)
 S OE(.01)="",OE(.02)="",OE(.04)="",OE(.05)="",OE(.08)="",OE(.09)="",OE(.06)=""
 D GETOE^SDMDAL4(.OE,+SDOE)
 S DFN=OE(.02),SD=OE(.01),SC=OE(.04)
 S %=$$GETSCAP^SDMAPI1(.CAPT,+SC,+DFN,+SD)
 S SDDA=$S('$G(CAPT("IFN")):OE(.09),1:$G(CAPT("IFN")))
 Q 1
 ;
GETPAPT(RETURN,DFN,SD) ; Get patient appointment
 N IND,NAME,FLDS,NAMES,APT,%
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 S FLDS=".01;3;5;6;7;9;12;13;14;15;16;9.5;17;19;20;21;25;26;27;28"
 S NAMES="CLINIC;STATUS;LABDT;XRAYDT;EKGDT;PURPOSE;ARBK;CVISIT;NOSHOWBY;NOSHOWDT;"
 S NAMES=NAMES_"CREASON;TYPE;CREMARKS;ENTRY;MADEDT;OE;RTYPE;NEXTA;DDATE;FVISIT"
 I +$G(SD)=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 D GETPAPT^SDMDAL4(.APT,+DFN,+SD)
 F IND=0:0 S IND=$O(APT(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND)
 . S RETURN(NAME)=APT(IND,"I")_$S($G(APT(IND,"E"))=$G(APT(IND,"I")):"",1:U_$G(APT(IND,"E")))
 S RETURN=1
 Q 1
 ;
GETCAPT(RETURN,DFN,SD) ; Get clinic appointment
 N IND,NAME,FLDS,NAMES,CAPT,%
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 S FLDS=".01;1;3;7;8;9;10;30;309;302;303;304;306;222;333;444;555"
 S NAMES="PATIENT;LENGTH;OTHER;ENTRY;MADEDT;OVERBOOK;RQXRAY;EVISIT;CIDT;"
 S NAMES=NAMES_"CIUSER;CODT;COUSER;COENTER;222;333;RQXRAY;CONSULT"
 I +$G(SD)=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SD") Q 0
 D GETCAPT^SDMDAL4(.CAPT,+DFN,+SD,FLDS)
 I '$D(CAPT) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTNFND") Q 0
 F IND=0:0 S IND=$O(CAPT(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND) Q:NAME=""
 . S RETURN(NAME)=CAPT(IND,"I")_$S($G(CAPT(IND,"E"))=$G(CAPT(IND,"I")):"",1:U_$G(CAPT(IND,"E")))
 S RETURN("STATUS")=$$STATUS^SDAM1(+DFN,+SD,CAPT(222,"I"),CAPT(333,"I"))
 S RETURN=1
 Q 1
 ;
GETOE(RETURN,SDOE) ; Get outpatient encounter
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN [Boolean] Set to 1 if the the call succeeded
 ;    RETURN("CLINIC") [Numeric]Clinic IEN
 ;    RETURN("DATE") [DateTime]Encounter date/time
 ;    RETURN("PATIENT") [Numeric]Patient IEN
 ;    RETURN("SCODE") [Numeric] Clinic stop code
 ;    RETURN("VISIT") [Numeric] Visit IEN
 ;   SDOE [Required,Numeric] Outpatient encounter IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN S RETURN=0
 I +$G(SDOE)=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SDOE") Q 0
 I '$$OEEXST^SDMDAL4(+SDOE) D ERRX^SDAPIE(.RETURN,"OENFND") Q 0
 S RETURN(.07)="",RETURN(.08)="",RETURN(.01)="",RETURN(.02)=""
 S RETURN(.03)="",RETURN(.04)="",RETURN(.05)=""
 D GETOE^SDMDAL4(.RETURN,+SDOE)
 Q:'$D(RETURN) 0
 S RETURN("DATE")=RETURN(.01)
 S RETURN("PATIENT")=RETURN(.02)
 S RETURN("SCODE")=RETURN(.03)
 S RETURN("CLINIC")=RETURN(.04)
 S RETURN("VISIT")=RETURN(.05)
 S RETURN=1
 Q 1
 ;
GETPAT(RETURN,DFN) ; Get patient
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN [Boolean] Set to 1 if the the call succeeded
 ;    RETURN("NAME") [String] Patient name
 ;    RETURN("SEX") [String] Patient sex code. One of: M^MALE, F^FEMALE
 ;    RETURN("BIRTH") [DateTime] Birth date
 ;    RETURN("MSTATUS") [String] Marital status (pointer to file 11) (I^E)
 ;    RETURN("RELIG") [String] Religious preference  (pointer to file 13) (I^E)
 ;    RETURN("SSN") [String] Social security number
 ;    RETURN("DTODTH") [DateTime] Date of death
 ;    RETURN("REMARKS") [String] Short remarks
 ;    RETURN("PELIG") [String] Primary eligibility code (pointer to file 8) (I^E)
 ;    RETURN("PSERV") [String] Period of service (pointer to file 21) (I^E)
 ;    RETURN("PHONE") [String] Phone number (residence)
 ;    RETURN("ADD1") [String] Street address line 1
 ;    RETURN("CELL") [String] Phone number (cellular)
 ;    RETURN("ADD2") [String] Street address line 2
 ;    RETURN("PAGER") [String] Pager number
 ;    RETURN("COUNTRY") [Numeric] Contry
 ;    RETURN("ZIP") [Numeric] ZIP code
 ;    RETURN("CITY") [String] City
 ;    RETURN("STATE") [String] State (pointer to file 5) (I^E)
 ;    RETURN("EMAIL") [String] Email address
 ;    RETURN("EXPOI") [String] Radiation exposure. One of: Y^YES, N^NO., U^UNKNOWN
 ;    RETURN("POWSTAT") [String] POW status. One of: Y^YES, N^NO., U^UNKNOWN
 ;    RETURN("AGENTO") [String] Agent orange exposure. One of: Y^YES, N^NO., U^UNKNOWN
 ;    RETURN("AGENTOL") [String] Agent orange exposure location. One of: K^KOREAN DMZ, V^VIETNAM
 ;    RETURN("SASIA") [String] Environmental contaminants. One of: Y^YES, N^NO., U^UNKNOWN
 ;   DFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;Output:
 ;  1=Success,0=Failure
 N IND,NAME,FLDS,NAMES,PAT,%
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 S FLDS=".01;.02;.03;.05;.08;.09;.351;.091;.361;.323;.131;.111;.134;.112;.135;.117;.116;"
 S FLDS=FLDS_".114;.115;.1172;.1171;.133;.32103;.525;.32102;.3213;.32115;.322013;"
 S NAMES="NAME;SEX;BIRTH;MSTATUS;RELIG;SSN;DTODTH;REMARKS;PELIG;PSERV;PHONE;ADD1;"
 S NAMES=NAMES_"CELL;ADD2;PAGER;COUNTRY;ZIP;CITY;STATE;PCODE;PROVINCE;"
 S NAMES=NAMES_"EMAIL;EXPOI;POWSTAT;AGENTO;AGENTOL;PROJ;SASIA"
 D GETPAT^SDMDAL4(.PAT,+DFN,FLDS)
 F IND=0:0 S IND=$O(PAT(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND) Q:NAME=""
 . S RETURN(NAME)=PAT(IND,"I")_$S($G(PAT(IND,"E"))=$G(PAT(IND,"I")):"",1:U_PAT(IND,"E"))
 S RETURN=1
 Q 1
 ;
GETCHLD(RETURN,SDOE) ; Get children outpatient encounters
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN [Boolean] Set to 1 if the the call succeeded
 ;    RETURN(#,"ID") [Numeric] Child outpatient encounter IEN
 ;    RETURN(#,"CLINIC") [Numeric] Clinic IEN
 ;    RETURN(#,"DATE") [DateTime] Encounter date/time
 ;    RETURN(#,"PATIENT") [Numeric] Patient IEN
 ;    RETURN(#,"SCODE") [Numeric] Clinic stop code
 ;    RETURN(#,"VISIT") [Numeric] Visit IEN
 ;   SDOE [Required,Numeric] Outpatient encounter IEN
 ;Output:
 ;  1=Success,0=Failure
 K RETURN S RETURN=0
 I '$G(SDOE) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","SDOE") Q 0
 I '$$OEEXST^SDMDAL4(+SDOE) D ERRX^SDAPIE(.RETURN,"OENFND") Q 0
 D GETCHLD^SDMDAL4(.RETURN,+SDOE)
 S RETURN=1
 Q 1
 ; 
CANDELCO(RETURN) ; Check if user can delete check out data
 N KEYS,SUP K RETURN
 S KEYS("SD SUPERVISOR")=""
 D GETXUS^SDMDAL3(.SUP,.KEYS,DUZ)
 I '$D(SUP("SD SUPERVISOR")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"APTCOSU") Q 0
 S RETURN=1
 Q 1
 ;
ADDTSTS(RETURN,DFN,SD,LAB,XRAY,EKG) ; Append tests to pending appointment
 ;Input:
 ; .RETURN [Required,Boolean] Set to 1 if the update succeeded
 ;                            Set to Error description if the call fails
 ;  DFN [Required,Numeric] Patient IEN
 ;  SD [Required,DateTime] Appointment date/time
 ;  LAB [Optional,DateTime] If this patient is scheduled for laboratory tests in conjunction with this appointment, 
 ;                          set LAB to the time the patient should report.
 ;  XRAY [Optional,DateTime] If this patient is scheduled for x-ray in conjunction with this appointment,
 ;                           set XRAY to the time the patient should report.
 ;  EKG [Optional,DateTime] If this patient is scheduled for EKG in conjunction with this appointment,
 ;                          set EKG to the time the patient should.
 ;Output:
 ; 1=Success,0=Failure  
 N DATA,ERR,%,I
 K RETURN S RETURN=0
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 I '$$DTIME^SDCHK(.RETURN,.SD,"SD") S RETURN=0 Q 0
 S %=$$CHKLABS^SDMAPI5(.RETURN,SD,,$G(LAB),DFN,"LAB") Q:'RETURN 0
 S %=$$CHKLABS^SDMAPI5(.RETURN,SD,,$G(XRAY),DFN,"XRAY") Q:'RETURN 0
 S %=$$CHKLABS^SDMAPI5(.RETURN,SD,,$G(EKG),DFN,"EKG") Q:'RETURN 0
 Q:'RETURN 0
 S %=$$ISOECO^SDMAPI4(.ERR,+DFN,+SD,"add")
 I ERR=1 M RETURN=ERR S RETURN=0 Q 0
 S:$D(LAB) DATA(5)=$P(SD,".")_"."_+$P(LAB,".",2)
 S:$D(XRAY) DATA(6)=$P(SD,".")_"."_+$P(XRAY,".",2)
 S:$D(EKG) DATA(7)=$P(SD,".")_"."_+$P(EKG,".",2)
 D UPDPAPT^SDMDAL4(.DATA,+DFN,+SD)
 S RETURN=1
 Q 1
 ;
DELTSTS(RETURN,DFN,SD,LAB,XRAY,EKG) ; Delete tests from pending appointment
 ;Input:
 ; .RETURN [Required,Boolean] Set to 1 if the update succeeded
 ;                            Set to Error description if the call fails
 ;  DFN [Required,Numeric] Patient IEN
 ;  SD [Required,DateTime] Appointment date/time
 ;  LAB [Optional,Boolean] If is set to 1 LAB date/time will be removed.
 ;  XRAY [Optional,Boolean] If is set to 1 XRAY date/time will be removed.
 ;  EKG [Optional,Boolean] If is set to 1 EKG date/time will be removed.
 ;Output:
 ; 1=Success,0=Failure  
 N DATA,ERR,%,I
 K RETURN
 S %=$$CHKPAT^SDMAPI3(.RETURN,.DFN) Q:'% 0
 I '$$DTIME^SDCHK(.RETURN,.SD,"SD") S RETURN=0 Q 0
 S %=$$ISOECO^SDMAPI4(.ERR,+DFN,+SD,"delete")
 I ERR=1 M RETURN=ERR S RETURN=0 Q 0
 S:+$G(LAB)=1 DATA(5)="@"
 S:+$G(XRAY)=1 DATA(6)="@"
 S:+$G(EKG)=1 DATA(7)="@"
 D UPDPAPT^SDMDAL4(.DATA,+DFN,+SD)
 S RETURN=1
 Q 1
 ;
ISAPTCO(RETURN,DFN,SD) ; Is appointment checked out?
 N APT,FLDS
 K RETURN S RETURN=0
 S FLDS="303"
 D GETCAPT^SDMDAL4(.APT,+DFN,+SD,.FLDS,"I")
 S RETURN=1
 Q $G(APT(303,"I"))>0
 ;
ISOECO(RETURN,DFN,SD,OP) ; Is outpatient encounter checked out?
 N OE,APT,FLDS,PARAM
 K RETURN S RETURN=0,PARAM(1)=OP
 S OE(.12)="",FLDS="21"
 D GETPAPT^SDMDAL4(.APT,+DFN,+SD,.FLDS)
 I $G(APT(21,"I"))="" Q 1
 D GETOE^SDMDAL4(.OE,APT(21,"I"))
 I OE(.12)=2 D BLD^DIALOG(480000.03,.OP,,"RETURN","FS") S RETURN=1
 Q 1
 ;
GETHOL(RETURN,SD) ; Get holiday
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN [Boolean] Set to 1 if the specified date is a holiday, 0 otherwise.
 ;    RETURN(SD) [String] Set to date^holiday name if date is a holiday.
 ;   SD [Required,Date] The date checked if is a holiday
 ;Output:
 ;  1=Success,0=Failure
 K RETURN S RETURN=0
 I '$$DTIME^SDCHK(.RETURN,.SD,"SD") Q 0
 D GETHOL^SDMDAL1(.RETURN,+$P(SD,"."))
 Q 1
