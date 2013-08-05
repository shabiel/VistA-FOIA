SDPARAPI ;RGI/VSL - Edit Parmaters API;07/18/13  10:56
 ;;5.3;Scheduling;**260003**;
 ;
GETMPAR(RETURN) ; Get Main Parameters
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("STRTDAYS") [Numeric] Appointment search threshold
 ;      RETURN("UPDMAIL") [Numeric] Appointment update mail group (from the Mail Group file #3.8 in internal^external)
 ;      RETURN("NPCMAIL") [Numeric] NPCDB mail group (from the Mail Group file #3.8 in internal^external)
 ;      RETURN("DEFCOSCR") [Boolean] View check out info default
 ;      RETURN("LATMAIL") [Numeric] Late activity mail group (from the Mail Group file #3.8 in internal^external)
 ;      RETURN("APIMAIL") [Numeric] API errors mail group (from the Mail Group file #3.8 in internal^external)
 ;      RETURN("APILEVEL") [String] API notifications to process. One of: E^ERRORS ONLY, WE^WARNINGS & ERRORS, N^NONE
 ;      RETURN("UPARROW") [Boolean] Allow up-arrow out of class
 ;Output:
 ;  1=Success,0=Failure
 N IND,NAME,FLDS,NAMES,PAR
 K RETURN S RETURN=0
 S FLDS="212;215;216;32;217;226;227;224;"
 S NAMES="STRTDAYS;UPDMAIL;NPCMAIL;DEFCOSCR;LATMAIL;APIMAIL;APILEVEL;UPARROW"
 D GETMPAR^DGPARDAL(.PAR,1,FLDS)
 F IND=0:0 S IND=$O(PAR(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND)
 . S RETURN(NAME)=PAR(IND,"I")_$S($G(PAR(IND,"E"))=$G(PAR(IND,"I")):"",1:U_$G(PAR(IND,"E")))
 S RETURN=1
 Q 1
 ;
UPDMPAR(RETURN,PARAM) ; Update Main Parameters
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Optional,Array] Array passed by reference that holds the new data.
 ;      PARAM("STRTDAYS") [Optional,Numeric] Appointment search threshold (1-30 days).
 ;      PARAM("UPDMAIL") [Optional,Numeric] Appointment update mail group (pointer to the Mail Group file #3.8)
 ;      PARAM("NPCMAIL") [Optional,Numeric] NPCDB mail group (pointer to the Mail Group file #3.8)
 ;      PARAM("DEFCOSCR") [Optional,Boolean] View check out info default
 ;      PARAM("LATMAIL") [Optional,Numeric] Late activity mail group (pointer to the Mail Group file #3.8)
 ;      PARAM("APIMAIL") [Optional,Numeric] API errors mail group (pointer to the Mail Group file #3.8)
 ;      PARAM("APILEVEL") [Optional,String] API notifications to process. One of: E^ERRORS ONLY, WE^WARNINGS & ERRORS, N^NONE
 ;      PARAM("UPARROW") [Optional,Boolean] Allow up-arrow out of class
 ;Output:
 ;  1=Success,0=Failure
 N %,PAR,OLD K RETURN S RETURN=1
 Q:'$D(PARAM) 1 Q:$O(PARAM(""))="" 1
 S RETURN=0
 S %=$$GETMPAR^SDPARAPI(.OLD)
 S %=$$CHKMUPD(.RETURN,.PARAM,.OLD,.PAR) Q:'RETURN 0
 D UPDMPAR^DGPARDAL(.RETURN,1,.PAR)
 S RETURN=1
 Q 1
 ;
CHKMUPD(RETURN,PARAM,OLD,NEW) ; Check Main parameters
 N DAYS,LVLS,E1,TXT
 S RETURN=1
 I $G(PARAM("DEFCOSCR"))'="",$P($G(PARAM("DEFCOSCR")),U)'=$P(OLD("DEFCOSCR"),U) D  Q:'RETURN 0
 . I $P($G(PARAM("DEFCOSCR")),U)'=0&($P($G(PARAM("DEFCOSCR")),U)'=1) D  Q
 . . S TXT(1)="PARAM(""DEFCOSCR"")",RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT)
 . S NEW(32)=+PARAM("DEFCOSCR")
 S DAYS=$P($G(PARAM("STRTDAYS")),U)
 I $G(DAYS)'="",$G(PARAM("STRTDAYS"))'=OLD("STRTDAYS") D  Q:'RETURN 0
 . I +DAYS'=DAYS!(DAYS>30)!(DAYS<1)!(DAYS?.E1"."1N.N) D  Q
 . . S TXT(1)="PARAM(""STRTDAYS"")",RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT)
 . S NEW(212)=+PARAM("STRTDAYS")
 I $G(PARAM("UPDMAIL"))'="",$G(OLD("UPDMAIL"))'=$G(PARAM("UPDMAIL")) D  Q:'RETURN 0
 . I '$$CHKMGRP(.RETURN,$G(PARAM("UPDMAIL")),"PARAM(""UPDMAIL"")") Q
 . S NEW(215)=+PARAM("UPDMAIL")
 I $G(PARAM("NPCMAIL"))'="",$G(OLD("NPCMAIL"))'=$G(PARAM("NPCMAIL")) D  Q:'RETURN 0
 . I '$$CHKMGRP(.RETURN,$G(PARAM("NPCMAIL")),"PARAM(""NPCMAIL"")") Q
 . S NEW(216)=+PARAM("NPCMAIL")
 I $G(PARAM("LATMAIL"))'="",$G(OLD("LATMAIL"))'=$G(PARAM("LATMAIL")) D  Q:'RETURN 0
 . I '$$CHKMGRP(.RETURN,$G(PARAM("LATMAIL")),"PARAM(""LATMAIL"")") Q
 . S NEW(217)=+PARAM("LATMAIL")
 I $G(PARAM("APIMAIL"))'="",$G(OLD("APIMAIL"))'=$G(PARAM("APIMAIL")) D  Q:'RETURN 0
 . I '$$CHKMGRP(.RETURN,$G(PARAM("APIMAIL")),"PARAM(""APIMAIL"")") Q
 . S NEW(226)=+PARAM("APIMAIL")
 I $G(PARAM("UPARROW"))'="",$P($G(PARAM("UPARROW")),U)'=$P(OLD("UPARROW"),U) D  Q:'RETURN 0
 . I $P($G(PARAM("UPARROW")),U)'=0&($P($G(PARAM("UPARROW")),U)'=1) D  Q
 . . S TXT(1)="PARAM(""UPARROW"")",RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT)
 . S NEW(224)=+PARAM("UPARROW")
 I $G(PARAM("APILEVEL"))'="",$P($G(PARAM("APILEVEL")),U)'=$P(OLD("APILEVEL"),U) D  Q:'RETURN 0
 . D LSTSCOD^SDMDAL(43,227,.LVLS)
 . N IND,FND S FND=0
 . F IND=0:0 S IND=$O(LVLS(IND)) Q:'IND!(FND)  D
 . . I $P($G(PARAM("APILEVEL")),U)=$P(LVLS(IND),U) S FND=1
 . I 'FND S TXT(1)="PARAM(""APILEVEL"")",RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",.TXT)
 . S NEW(227)=+PARAM("APILEVEL")
 Q 1
 ;
CHKMGRP(RETURN,MGRP,NAME) ; Check mail group parameter
 N TXT
 I '$G(MGRP) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",NAME) Q 0
 I '$$MGRPEXST^DGPARDAL(+MGRP) S RETURN=0 D ERRX^SDAPIE(.RETURN,"MGRPNFND") Q 0
 Q 1
 ;
GETDPAR(RETURN,DIV) ; Get Division Parameters
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("ADDLOC") [Numeric] Address location on letters. One of: 1^BOTTOM, 0^TOP.
 ;      RETURN("OPLABST") [String] OP LAB test start time
 ;      RETURN("OPEKGST") [String] OP EKG test start time
 ;      RETURN("OPXRAYST") [String] OP X-RAY test start time
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N %,IND,NAME,FLDS,NAMES,PAR,MPAR
 K RETURN S RETURN=0
 S FLDS="30.01;30.02;30.03;30.04;"
 S NAMES="ADDLOC;OPLABST;OPEKGST;OPXRAYST;"
 S %=$$CHKDIV(.RETURN,.DIV) Q:'RETURN 0
 D GETDPAR^DGPARDAL(.PAR,DIV,FLDS)
 F IND=0:0 S IND=$O(PAR(IND)) Q:IND=""  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND)
 . S RETURN(NAME)=PAR(IND,"I")_$S($G(PAR(IND,"E"))=$G(PAR(IND,"I")):"",1:U_$G(PAR(IND,"E")))
 S RETURN=1
 Q 1
 ;
UPDDPAR(RETURN,PARAM,DIV) ; Update Division Parameters
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  .PARAM [Optional,Array] Array passed by reference that holds the new data.
 ;      PARAM("ADDLOC") [Optional,Numeric] Address location on letters. One of: 1^BOTTOM, 0^TOP.
 ;      PARAM("OPLABST") [Optional,String] OP LAB test start time - in Military time format (0900).
 ;      PARAM("OPEKGST") [Optional,String] OP EKG test start time - in Military time format (0900).
 ;      PARAM("OPXRAYST") [Optional,String] OP X-RAY test start time - in Military time format (0900).
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N %,PAR,OLD K RETURN S RETURN=1
 Q:'$D(PARAM) 1 Q:$O(PARAM(""))="" 1
 S RETURN=0
 S %=$$CHKDIV(.RETURN,.DIV) Q:'RETURN 0
 S %=$$GETDPAR^SDPARAPI(.OLD,.DIV)
 I 'OLD M RETURN=OLD Q 0
 S %=$$CHKDUPD(.RETURN,.PARAM,.OLD,.PAR) Q:'RETURN 0
 D UPDDPAR^DGPARDAL(.RETURN,DIV,.PAR)
 S RETURN=1
 Q 1
 ;
CHKDIV(RETURN,DIV) ; Check division
 N %,PAR S RETURN=0
 S %=$$GETDIV^DGPARAPI(.RETURN,.DIV) Q:'RETURN 0
 D GETMPAR^DGPARDAL(.PAR,1,"11")
 I $G(PAR(11,"I")),DIV>1 S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","DIV>1") Q 0
 S RETURN=1
 Q 1
 ;
CHKDUPD(RETURN,PARAM,OLD,NEW) ; Check parameters
 N DAYS,LVLS
 S RETURN=1
 I $G(PARAM("ADDLOC"))'="",$P($G(PARAM("ADDLOC")),U)'=$P(OLD("ADDLOC"),U) D  Q:'RETURN 0
 . I $P($G(PARAM("ADDLOC")),U)'=0&($P($G(PARAM("ADDLOC")),U)'=1) D  Q
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","PARAM(""ADDLOC"")")
 . S NEW(30.01)=+PARAM("ADDLOC")
 I '$$CHKSTIME(.RETURN,.NEW,.OLD,$G(PARAM("OPLABST")),"OPLABST",30.02) Q 0
 I '$$CHKSTIME(.RETURN,.NEW,.OLD,$G(PARAM("OPEKGST")),"OPEKGST",30.03) Q 0
 I '$$CHKSTIME(.RETURN,.NEW,.OLD,$G(PARAM("OPXRAYST")),"OPXRAYST",30.04) Q 0
 Q 1
 ;
CHKSTIME(RETURN,NEW,OLD,TIME,FLD,PART) ; Check OP start time
 I $G(TIME)'="",$G(TIME)'=OLD(FLD) D  Q:'RETURN 0
 . I $L(TIME)>4!($L(TIME)<4)!'(TIME?4N)!($E(TIME,3,4)>59)!(TIME>2400) D  Q
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","PARAM("""_FLD_""")")
 . S NEW(PART)=+TIME
 Q 1
 ;
GETPMCS(RETURN,SC) ; Get Print Manager Clinic Setup
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("CLINIC") [String] Clinic (from the Hospital Location file #44 in internal^external)
 ;      RETURN("DEFEFRM") [String] Basic default encounter form (from the Encounter Form file #357 in internal^external)
 ;      RETURN("SUPFRM1") [String] Supplmntl form #1 all patients (from the Encounter Form file #357 in internal^external)
 ;      RETURN("SUPFRM2") [String] Supplmntl form #2 all patients (from the Encounter Form file #357 in internal^external)
 ;      RETURN("SUPFRM3") [String] Supplmntl form #3 all patients (from the Encounter Form file #357 in internal^external)
 ;      RETURN("SUPFRMEP") [String] Supplmntl form - estblshed pt. (from the Encounter Form file #357 in internal^external)
 ;      RETURN("SUPFRMFV") [String] Supplmntl form - first visit (from the Encounter Form file #357 in internal^external)
 ;      RETURN("FRMWO") [String] Form w/o patient data (from the Encounter Form file #357 in internal^external)
 ;      RETURN("REZFU") [String] Reserved for future use (from the Encounter Form file #357 in internal^external)
 ;      RETURN("UPCMM") [Boolean] Don't use pcmm providers
 ;  	RETURN(1) [Array] List of reports that should be printed under certain circumstances.
 ;        RETURN(1,#,"REPORT") [String] Report (from the Package Interface file #357.6 in internal^external)
 ;        RETURN(1,#,"COND") [String] Print condition (from the Print Conditions file #357.92 in internal^external)
 ;        RETURN(1,#,"SIDES") [String] Simplex/Duplex. One of: 0^SIMPLEX, 1^DUPLEX,LONG-EDGE BINDING, 2^DUPLEX,SHORT-EDGE BINDING
 ;  	RETURN(2) [Array] Reports defined to print for the division will not print if they are excluded for the clinic.
 ;        RETURN(2,#,"REPORT") [String] Report (from the Package Interface file #357.6 in internal^external)
 ;  SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;Output:
 ;  1=Success,0=Failure
 N %,IND,NAME,FLDS,NAMES,PAR,TMP,CIFN,REP,EREP
 K RETURN S RETURN=0
 S FLDS=".01;.02;.06;.08;.09;.03;.04;.05;.07;.1;"
 S NAMES="CLINIC;DEFEFRM;SUPFRM1;SUPFRM2;SUPFRM3;SUPFRMEP;SUPFRMFV;FRMWO;REZFU;UPCMM"
 S %=$$CHKCLN^SDMAPI3(.RETURN,.SC) Q:'% 0
 S CIFN=$$GETCSIFN^SDPARDAL(+SC)
 I 'CIFN S CIFN=$$ADDPMCS^SDPARDAL(+SC)
 D GETPMCS^SDPARDAL(.TMP,CIFN,"**")
 M PAR=TMP(409.95,CIFN_",")
 F IND=0:0 S IND=$O(PAR(IND)) Q:'IND  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND)
 . S RETURN(NAME)=PAR(IND,"I")_$S($G(PAR(IND,"E"))=$G(PAR(IND,"I")):"",1:U_$G(PAR(IND,"E")))
 M REP=TMP(409.9501),EREP=TMP(409.9502)
 D GETREP(.RETURN,.REP,1)
 D GETREP(.RETURN,.EREP,2)
 S RETURN=1
 Q 1
 ;
GETREP(RETURN,PAR,NODE) ;
 N IND,CNT,FLD,FLDS,NAME,NAMES
 S FLDS=".01;.02;.03;"
 S NAMES="REPORT;COND;SIDES;"
 S IND="",CNT=0
 F  S IND=$O(PAR(IND)) Q:IND=""  D
 . S CNT=CNT+1
 . F FLD=0:0 S FLD=$O(PAR(IND,FLD)) Q:'FLD  D
 . . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,FLD)
 . . S RETURN(NODE,CNT,NAME)=PAR(IND,FLD,"I")_U_PAR(IND,FLD,"E")
 Q
 ;
UPDPMCS(RETURN,SC,PARAM) ; Update Print Manager Clinic Setup
 ;Input:
 ;  .RETURN [Required,Array] Set to 1 if the operation succeeds, 0 otherwise.
 ;      RETURN(0)            Set to Error description if the call fails
 ;  SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("DEFEFRM") [Optional,Numeric] Basic default encounter form (pointer to the Encounter Form file #357)
 ;      PARAM("SUPFRM1") [Optional,Numeric] Supplmntl form #1 all patients (pointer to Encounter Form file #357)
 ;      PARAM("SUPFRM2") [Optional,Numeric] Supplmntl form #2 all patients (pointer to Encounter Form file #357)
 ;      PARAM("SUPFRM3") [Optional,Numeric] Supplmntl form #3 all patients (pointer to Encounter Form file #357)
 ;      PARAM("SUPFRMEP") [Optional,Numeric] Supplmntl form - estblshed pt. (pointer to Encounter Form file #357)
 ;      PARAM("SUPFRMFV") [Optional,Numeric] Supplmntl form - first visit (pointer to Encounter Form file #357)
 ;      PARAM("FRMWO") [Optional,Numeric] Form w/o patient data (pointer to Encounter Form file #357)
 ;      PARAM("REZFU") [Optional,Numeric] Reserved for future use (pointer to Encounter Form file #357)
 ;      PARAM("UPCMM") [Optional,Boolean] Don't use pcmm providers
 ;  	PARAM(1) [Optional,Array] List of reports that should be printed under certain circumstances.
 ;        PARAM(1,#,"REPORT") [Required,Numeric] Report (pointer to the Package Interface file #357.6)
 ;        PARAM(1,#,"COND") [Required,Numeric] Print condition (pointer to the Print Conditions file #357.92)
 ;        PARAM(1,#,"SIDES") [Required,Numeric] Simplex/Duplex. One of: 0^SIMPLEX, 1^DUPLEX,LONG-EDGE BINDING, 2^DUPLEX,SHORT-EDGE BINDING
 ;		PARAM(2) [Array] Reports defined to print for the division will not print if they are excluded for the clinic.
 ;        PARAM(2,#,"REPORT") [Required,Numeric] Report (pointer to the Package Interface file #357.6)
 ;Output:
 ;  1=Success,0=Failure
 N %,OLD,IND,REPS,EREPS,REP,EREP,OLDR,OLDER,CIFN,PAR,TMP
 K RETURN S RETURN=0
 M REPS=PARAM(1) K PARAM(1)
 M EREPS=PARAM(2) K PARAM(2)
 S %=$$CHKCLN^SDMAPI3(.RETURN,.SC) Q:'% 0
 S CIFN=$$GETCSIFN^SDPARDAL(+SC)
 I 'CIFN S CIFN=$$ADDPMCS^SDPARDAL(+SC)
 S %=$$GETPMCS^SDPARAPI(.OLD,SC)
 S %=$$CHKPMCS(.RETURN,.PARAM,.OLD,.PAR) Q:'RETURN 0
 S %=$$CHKREPS(.RETURN,.REPS,1) Q:'RETURN 0
 S %=$$CHKREPS(.RETURN,.EREPS,2) Q:'RETURN 0
 D UPDPMCS^SDPARDAL(.RETURN,CIFN,.PAR)
 D GETPMCS^SDPARDAL(.TMP,CIFN,"**")
 M OLDR=TMP(409.9501) D UPDREPS(.RETURN,CIFN,.REPS,.OLDR)
 M OLDER=TMP(409.9502) D UPDEREPS(.RETURN,CIFN,.EREPS,.OLDER)
 S RETURN=1
 Q 1
 ;
UPDREPS(RETURN,IFN,REPS,OLD) ; Update reports
 N NEW,IND,SIFN,PAR
 D BLDREPS(.RETURN,.REPS,.OLD,.NEW,1)
 F IND=0:0 S IND=$O(NEW(IND)) Q:'IND  D
 . S SIFN=NEW(IND,"IFN") K NEW(IND,"IFN")
 . K PAR M PAR=NEW(IND)
 . I SIFN<0 D DELREP^SDPARDAL(IFN,-SIFN) Q
 . I 'SIFN D ADDREP^SDPARDAL(.RETURN,IFN,.PAR) Q
 . E  D UPDREP^SDPARDAL(.RETURN,IFN,SIFN,.PAR) Q
 Q
 ;
UPDEREPS(RETURN,IFN,REPS,OLD) ; Update excluded reports
 N NEW,IND,SIFN,PAR
 D BLDREPS(.RETURN,.REPS,.OLD,.NEW,2)
 F IND=0:0 S IND=$O(NEW(IND)) Q:'IND  D
 . S SIFN=NEW(IND,"IFN") K NEW(IND,"IFN")
 . K PAR M PAR=NEW(IND)
 . I SIFN<0 D DELEREP^SDPARDAL(IFN,-SIFN) Q
 . I 'SIFN D ADDEREP^SDPARDAL(.RETURN,IFN,.PAR) Q
 . E  D UPDEREP^SDPARDAL(.RETURN,IFN,SIFN,.PAR) Q
 Q
 ;
BLDREPS(RETURN,REPS,OLD,NEW,NODE) ;Build reports
 N PAR,FND,IND,IND1,CNT
 S CNT=0
 F IND=0:0 S IND=$O(REPS(IND)) Q:'IND  D
 . S FND=0,CNT=CNT+1
 . S NEW(CNT,.01)=REPS(IND,"REPORT")
 . S:NODE=1 NEW(CNT,.02)=REPS(IND,"COND")
 . S:NODE=1 NEW(CNT,.03)=REPS(IND,"SIDES")
 . S IND1="" F  S IND1=$O(OLD(IND1)) Q:IND1=""!FND  D
 . . S:+OLD(IND1,.01,"I")=+REPS(IND,"REPORT") FND=+IND1
 . S NEW(CNT,"IFN")=FND
 S IND1="" F  S IND1=$O(OLD(IND1)) Q:IND1=""  D
 . S FND=0
 . F IND=0:0 S IND=$O(REPS(IND)) Q:'IND!FND  D
 . . S:+OLD(IND1,.01,"I")=+REPS(IND,"REPORT") FND=+IND1
 . I 'FND S CNT=CNT+1,NEW(CNT,"IFN")=-IND1
 Q
 ;
CHKREPS(RETURN,REPS,NODE) ; Check Reports
 N %,IND,REP S RETURN=1
 F IND=0:0 S IND=$O(REPS(IND)) Q:'IND!('RETURN)  D
 . K REP M REP=REPS(IND)
 . S %=$$CHKREP(.RETURN,.REP,NODE,IND)
 Q 1
 ;
CHKREP(RETURN,REP,NODE,IND) ; Check Report
 N NAME
 S RETURN=1
 S NAME="PARAM("_$G(NODE)_","_IND_","
 ;report parameter
 I '$G(REP("REPORT")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",NAME_"""REPORT"")") Q 0
 I '$$REPEXST^DGPARDAL(+REP("REPORT")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"REPNFND",+REP("REPORT")) Q 0
 Q:NODE=2 1
 ;print condition parameter
 I '$G(REP("COND")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",NAME_"""COND"")") Q 0
 I '$$CONEXST^DGPARDAL(+REP("COND")) S RETURN=0 D ERRX^SDAPIE(.RETURN,"CONNFND",+REP("COND")) Q 0
 ;simplex/duplex parameter
 I $P($G(REP("SIDES")),U)'=0&($P($G(REP("SIDES")),U)'=1)&($P($G(REP("SIDES")),U)'=2) D  Q 0
 . S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",NAME_"""SIDES"")")
 Q 1
 ;
CHKPMCS(RETURN,PARAM,OLD,NEW) ; Check Print Manager Clinic Setup
 S RETURN=1
 I $G(PARAM("DEFEFRM"))'="",$G(OLD("DEFEFRM"))'=$G(PARAM("DEFEFRM")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("DEFEFRM")),"PARAM(""DEFEFRM"")") Q
 . S NEW(.02)=+PARAM("DEFEFRM")
 I $G(PARAM("SUPFRM1"))'="",$G(OLD("SUPFRM1"))'=$G(PARAM("SUPFRM1")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("SUPFRM1")),"PARAM(""SUPFRM1"")") Q
 . S NEW(.06)=+PARAM("SUPFRM1")
 I $G(PARAM("SUPFRM2"))'="",$G(OLD("SUPFRM2"))'=$G(PARAM("SUPFRM2")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("SUPFRM2")),"PARAM(""SUPFRM2"")") Q
 . S NEW(.08)=+PARAM("SUPFRM2")
 I $G(PARAM("SUPFRM3"))'="",$G(OLD("SUPFRM3"))'=$G(PARAM("SUPFRM3")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("SUPFRM3")),"PARAM(""SUPFRM3"")") Q
 . S NEW(.09)=+PARAM("SUPFRM3")
 I $G(PARAM("SUPFRMEP"))'="",$G(OLD("SUPFRMEP"))'=$G(PARAM("SUPFRMEP")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("SUPFRMEP")),"PARAM(""SUPFRMEP"")") Q
 . S NEW(.03)=+PARAM("SUPFRMEP")
 I $G(PARAM("SUPFRMFV"))'="",$G(OLD("SUPFRMFV"))'=$G(PARAM("SUPFRMFV")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("SUPFRMFV")),"PARAM(""SUPFRMFV"")") Q
 . S NEW(.04)=+PARAM("SUPFRMFV")
 I $G(PARAM("FRMWO"))'="",$G(OLD("FRMWO"))'=$G(PARAM("FRMWO")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("FRMWO")),"PARAM(""FRMWO"")") Q
 . S NEW(.05)=+PARAM("FRMWO")
 I $G(PARAM("REZFU"))'="",$G(OLD("REZFU"))'=$G(PARAM("REZFU")) D  Q:'RETURN 0
 . I '$$CHKFRM(.RETURN,$G(PARAM("REZFU")),"PARAM(""REZFU"")") Q
 . S NEW(.07)=+PARAM("REZFU")
 I $G(PARAM("UPCMM"))'="",$P($G(PARAM("UPCMM")),U)'=$P(OLD("UPCMM"),U) D  Q:'RETURN 0
 . I $P($G(PARAM("UPCMM")),U)'=0&($P($G(PARAM("UPCMM")),U)'=1) D  Q
 . . S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM","PARAM(""UPCMM"")")
 . S NEW(.1)=+PARAM("UPCMM")
 Q 1
 ;
CHKFRM(RETURN,FRM,NAME) ; Check form
 N TXT
 I '$G(FRM) S RETURN=0 D ERRX^SDAPIE(.RETURN,"INVPARAM",NAME) Q 0
 I '$$FRMEXST^DGPARDAL(+FRM) S RETURN=0 D ERRX^SDAPIE(.RETURN,"FRMNFND") Q 0
 Q 1
 ;
DELPMCS(RETURN,SC) ; Delete Print Manager Clinic Setup
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;   SC [Required,Numeric] Clinic IEN (pointer to the Hospital Location file #44)
 ;Output:
 ;  1=Success,0=Failure
 N %,CIFN
 K RETURN S RETURN=0
 S %=$$CHKCLN^SDMAPI3(.RETURN,.SC) Q:'RETURN 0
 S CIFN=$$GETCSIFN^SDPARDAL(+SC)
 Q:'CIFN 0
 D DELPMCS^SDPARDAL(CIFN)
 Q 1
 ;
GETPMDS(RETURN,DIV) ; Get Print Manager Division Setup
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data
 ;                           Set to Error description if the call fails
 ;      RETURN("MCDIV") [String] Division (from the Medical Center Division file #40.8 in internal^external)
 ;  	RETURN(1) [Array] The reports that should print.
 ;        RETURN(1,#,"REPORT") [String] Report (from the Package Interface file #357.6 in internal^external)
 ;        RETURN(1,#,"COND") [String] Print condition (from the Print Conditions file #357.92 in internal^external)
 ;        RETURN(1,#,"SIDES") [String] Simplex/Duplex. One of: 0^SIMPLEX, 1^DUPLEX,LONG-EDGE BINDING, 2^DUPLEX,SHORT-EDGE BINDING
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N IFN,%,TMP
 K RETURN S RETURN=0
 S %=$$GETDIV^DGPARAPI(.RETURN,.DIV) Q:'RETURN 0
 S IFN=$$GETDSIFN^SDPARDAL(+DIV)
 I 'IFN S IFN=$$ADDPMDS^SDPARDAL(+DIV)
 D GETPMDS^SDPARDAL(.TMP,IFN,"**")
 S RETURN("MCDIV")=TMP(409.96,IFN_",",.01,"I")_U_TMP(409.96,IFN_",",.01,"E")
 S RETURN=1
 Q 1
 ;
UPDPMDS(RETURN,DIV,PARAM) ; Update Print Manager Division Setup
 ;Input:
 ;  .RETURN [Required,Array] Set to 1 if the operation succeeds, 0 otherwise.
 ;      RETURN(0)            Set to Error description if the call fails
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;  	PARAM(1) [Optional,Array] The reports that should print.
 ;        PARAM(1,#,"REPORT") [Required,Numeric] Report (pointer to the Package Interface file #357.6)
 ;        PARAM(1,#,"COND") [Required,Numeric] Print condition (pointer to the Print Conditions file #357.92)
 ;        PARAM(1,#,"SIDES") [Required,Numeric] Simplex/Duplex. One of: 0^SIMPLEX, 1^DUPLEX,LONG-EDGE BINDING, 2^DUPLEX,SHORT-EDGE BINDING
 ;Output:
 ;  1=Success,0=Failure
 N %,IFN,REPS,NEW,PAR,IND,OLDR,SIFN,TMP
 K RETURN S RETURN=0
 M REPS=PARAM(1)
 S %=$$GETDIV^DGPARAPI(.RETURN,.DIV) Q:'RETURN 0
 S IFN=$$GETDSIFN^SDPARDAL(+DIV)
 I 'IFN S IFN=$$ADDPMDS^SDPARDAL(+DIV)
 D GETPMDS^SDPARDAL(.TMP,IFN,"**")
 S %=$$CHKREPS(.RETURN,.REPS,1) Q:'RETURN 0
 M OLDR=TMP(409.961) D BLDREPS(.RETURN,.REPS,.OLDR,.NEW,1)
 F IND=0:0 S IND=$O(NEW(IND)) Q:'IND  D
 . S SIFN=NEW(IND,"IFN") K NEW(IND,"IFN")
 . K PAR M PAR=NEW(IND)
 . I SIFN<0 D DELDREP^SDPARDAL(IFN,-SIFN) Q
 . I 'SIFN D ADDDREP^SDPARDAL(.RETURN,IFN,.PAR) Q
 . E  D UPDDREP^SDPARDAL(.RETURN,IFN,SIFN,.PAR) Q
 S RETURN=1
 Q 1
 ;
DELPMDS(RETURN,DIV) ; Delete Print Manager Division Setup
 ;Input:
 ;  .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                             Set to Error description if the call fails
 ;  DIV [Required,Numeric] Division IEN (pointer to the Medical Center Division file #40.8)
 ;Output:
 ;  1=Success,0=Failure
 N %,IFN
 K RETURN S RETURN=0
 S %=$$GETDIV^DGPARAPI(.RETURN,.DIV) Q:'RETURN 0
 S IFN=$$GETDSIFN^SDPARDAL(+DIV)
 Q:'IFN 0
 D DELPMDS^SDPARDAL(IFN)
 Q 1
 ;
