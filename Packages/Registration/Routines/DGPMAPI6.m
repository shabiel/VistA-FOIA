DGPMAPI6 ;RGI/VSL - FACILITY TRATING SPECIALTY API; 1/10/2013
 ;;5.3;Registration;**260003**;
UPDFTS(RETURN,PARAM,MFN) ; Update facility treating specialty
 N MVT,DIAG
 S MVT(.08)=PARAM("PRYMPHY")  ; primary physician
 S MVT(.09)=PARAM("FTSPEC")   ; facility treating specialty
 S MVT(.19)=PARAM("ATNDPHY")  ; attending physician
 D UPDMVT^DGPMDAL1(.RETURN,.MVT,MFN)
 M DIAG=PARAM("DIAG")
 D UPDDIAG^DGPMDAL1(.RETURN,.DIAG,MFN)
 Q 1
 ;
ADDFTS(RETURN,PARAM) ; Add ralated physical movement
 N PM6,IFN6,DIAG
 S PM6(.01)=PARAM("DATE") ; admission date
 D ADDMVMTX^DGPMDAL1(.RETURN,.PM6)
 S IFN6=+RETURN
 S PM6(.02)=6  ; transaction
 D UPDMVT^DGPMDAL1(.RETURN,.PM6,IFN6)
 S PM6(.03)=PARAM("PATIENT")  ; patient
 S PM6(.14)=PARAM("ADMIFN")  ; admission checkin movement
 S PM6(.24)=PARAM("RELIFN")  ; related physical movement
 S PM6(100)=DUZ,PM6(101)=$$NOW^XLFDT()
 S PM6(102)=DUZ,PM6(103)=$$NOW^XLFDT()
 D UPDMVT^DGPMDAL1(.RETURN,.PM6,IFN6)
 K PM6
 S PM6(.04)=42
 S PM6(.08)=PARAM("PRYMPHY")  ; primary physician
 S PM6(.09)=PARAM("FTSPEC")  ; facility treating specialty
 S PM6(.19)=PARAM("ATNDPHY")  ; attending physician
 D UPDMVT^DGPMDAL1(.RETURN,.PM6,IFN6)
 S:'$D(PARAM("DIAG")) DIAG(1)=PARAM("SHDIAG")
 M:$D(PARAM("DIAG")) DIAG=PARAM("DIAG")
 D UPDDIAG^DGPMDAL1(.RETURN,.DIAG,IFN6)
 S RETURN=IFN6
 Q 1
 ;
