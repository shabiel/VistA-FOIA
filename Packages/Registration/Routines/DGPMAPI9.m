DGPMAPI9 ;RGI/VSL - PATIENT MOVEMENT API; 5/24/13
 ;;5.3;Registration;**260005**;
LOCKMVT(RETURN,DFN) ; Lock movement
 N % K RETURN S RETURN=0
 S %=$$CHKPAT^DGPMAPI8(.RETURN,.DFN) Q:'RETURN 0
 S RETURN=$$LOCKMVT^DGPMDAL1(+DFN) I RETURN=0 D ERRX^DGPMAPIE(.RETURN,"FILELOCK") Q 0
 Q RETURN
 ;
ULOCKMVT(DFN) ; Unlock patient movements
 Q:'+$G(DFN)
 D ULOCKMVT^DGPMDAL1(+DFN)
 Q
ABS(RETURN,PARAM,LMVT) ; Absence transfer
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new transfer IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;    If movement type is: FROM UNAUTHORIZED ABSENCE, FROM AUTHORIZED ABSENCE or FROM AUTH. ABSENCE OF 96 HOURS OR LESS:
 ;      PARAM("ROOMBED") [Optional,Numeric] Room-bed IEN (pointer to file 405.4)
 ;      PARAM("FTSPEC") [Optional,Numeric] Facility treating specialty IEN (pointer to file 45.7)
 ;      PARAM("ATNDPHY") [Optional,Numeric] Attending physician IEN (pointer to file 200)
 ;      PARAM("PRYMPHY") [Optional,Numeric] Primary physician IEN (pointer to file 200)
 ;      PARAM("DIAG") [Optional,Array] Array of detailed diagnosis description.
 ;         PARAM("DIAG",n) [Optional,String] Detailed diagnosis description.
 ;    If movement type is: AUTHORIZED ABSENCE, UNAUTHORIZED ABSENCE or AUTH ABSENCE 96 HOURS OR LESS:
 ;      PARAM("RABSDT") [Optional,DateTime] Absence return date
 ;Output:
 ;  1=Success,0=Failure
 N TFN
 S PARAM("WARD")=$G(LMVT("WARD"))
 S PARAM("ADMIFN")=$G(LMVT("ADMIFN"))
 S TFN=$$ADDTRA^DGPMAPI2(.RETURN,.PARAM)
 D SETTEVT^DGPMDAL1(TFN,,"A")
 S RETURN=+TFN
 Q 1
 ;
ASIHOF(RETURN,PARAM) ; ASIH (Other facility) transfer
 ;Input:
 ;  .RETURN [Required,Numeric] Set to the new transfer IEN, 0 otherwise.
 ;                             Set to Error description if the call fails
 ;  .PARAM [Required,Array] Array passed by reference that holds the new data.
 ;      PARAM("FCTY") [Required,Numeric] Transfer facility (pointer to file 4)
 ;Output:
 ;  1=Success,0=Failure
 N %,TFN,LMVT
 S %=$$GETLASTM^DGPMAPI8(.LMVT,+PARAM("PATIENT"))
 S PARAM("WARD")=+$G(LMVT("WARD"))
 S TFN=$$ADDTRA^DGPMAPI2(.RETURN,.PARAM)
 S %=$$ASHODIS(.RETURN,.PARAM)
 D SETTEVT^DGPMDAL1(TFN,,"A")
 S RETURN=TFN
 Q 1
 ;
ASHODIS(RETURN,PARAM) ;
 N %,DIS M DIS=PARAM
 S DIS("TYPE")=34 K DIS("FCTY")
 S DIS("DATE")=$$FMADD^XLFDT(+PARAM("DATE"),30)
 S %=$$ADDDIS^DGPMAPI3(.RETURN,.DIS,+PARAM("PATIENT"),34)
 D SETDEVT^DGPMDAL1(+RETURN,"A")
 Q 1
 ;
CHKUPTF(RETURN,PARAM,PFN,OLD,NEW) ;
 N %
 D GETPTF^DGPMDAL1(.OLD,PFN,"20;20.1;")
 I $G(PARAM("ADMSRC"))'="",+PARAM("ADMSRC")'=+OLD(20,"I") D  Q:'RETURN 0
 . S %=$$CHKASRC^DGPMAPI1(.RETURN,$G(PARAM("ADMSRC"))) Q:'RETURN
 . S NEW(20)=+PARAM("ADMSRC")
 S RETURN=1
 Q 1
 ;
UPDPTF(RETURN,PARAM,PFN) ; Update ptf
 N %,PTF,OLD,NEW K RETURN
 S %=$$CHKUPTF(.RETURN,.PARAM,+PFN,.OLD,.NEW) Q:'% 0
 I RETURN=0 S:'$D(RETURN(0)) RETURN=1 Q $S('$D(RETURN(0)):1,1:0)
 ; source of admission
 S:$D(NEW(20)) PTF(20)=NEW(20)
 S PTF(20.1)=$S($G(PARAM("ELIGIB")):PARAM("ELIGIB"),1:0) ; eligibility
 D UPDPTF^DGPMDAL1(,.PTF,PFN)
 Q 1
 ;
