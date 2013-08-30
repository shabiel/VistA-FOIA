DGPMDAL1 ;RGI/VSL - PATIENT MOVEMENT DAL; 8/28/13
 ;;5.3;Registration;**260005**;
ADDMVMT(RETURN,PARAMS) ; Add new patient movement
 N FLD,IENS,FDA
 S IENS="+1,"
 S FLD=0
 F  S FLD=$O(PARAMS(FLD)) Q:'FLD  D
 . S FDA(405,IENS,FLD)=PARAMS(FLD)
 D UPDATE^DIE("","FDA","IENS","RETURN")
 S RETURN=IENS(1)
 Q
 ;
ADDMVMTX(RETURN,PARAMS) ; Add new patient movement
 N X,Y,DD,DO,DIC,DGIDX,DA,DIK
 S (DIK,DIC)="^DGPM(",DIC(0)="L",X=PARAMS(.01)
 K DD,DO
 D FILE^DICN S DA=+Y
 I PARAMS(.02)=1!(PARAMS(.02)=4) S PARAMS(.14)=+Y
 D UPDMVT^DGPMDAL1(.RETURN,.PARAMS,+Y)
 D IX1^DIK
 S RETURN=DA
 Q
 ;
ADDPTF(RETURN,PARAMS) ; Add PTF
 N DFN,DGPTDATA,DD,DIC,DO,X,Y S DFN=PARAMS(.01)
 S DGPTDATA=U_PARAMS(2),DIC="^DGPT(",DIC("DR")="[DG PTF CREATE PTF ENTRY]"
 S DIC(0)="FLZ",X=DFN K DD,DO D FILE^DICN
 S RETURN=+Y
 Q
 ;
UPDPTF(RETURN,PARAMS,IFN) ; Update PTF
 N FLD,IENS,FDA
 S IENS=IFN_","
 S FLD=0
 F  S FLD=$O(PARAMS(FLD)) Q:'FLD  D
 . S FDA(45,IENS,FLD)=PARAMS(FLD)
 D FILE^DIE("","FDA","RETURN")
 S RETURN=IFN
 Q
 ;
UPDMVT(RETURN,DATA,IFN) ; Update patient movement
 N IENS,I S I=0
 S IENS=IFN_","
 N FDA
 F I=0:0 S I=$O(DATA(I)) Q:I=""  D
 . S FDA(405,IENS,I)=DATA(I)
 D FILE^DIE("","FDA","RETURN")
 Q
 ;
UPDSCADM(RETURN,DATA,IFN) ; Update scheduled admission
 N IENS,I S I=0
 S IENS=IFN_","
 N FDA
 F  S I=$O(DATA(I)) Q:I=""  D
 . S FDA(41.1,IENS,I)=DATA(I)
 D FILE^DIE("","FDA","RETURN")
 S RETURN=1
 Q
 ;
UPDDIAG(RETURN,DATA,PM) ; Update patient movement diagnostic
 N I,CNT S I=0,CNT=0
 K ^DGPM(PM,"DX")
 Q:'$D(DATA)
 S ^DGPM(PM,"DX",0)="^^0^0^"_$P($$NOW^XLFDT(),".")_"^^^"
 F  S I=$O(DATA(I)) Q:'I  D
 . S CNT=CNT+1
 . S $P(^DGPM(PM,"DX",0),U,3)=$P(^DGPM(PM,"DX",0),U,3)+1
 . S $P(^DGPM(PM,"DX",0),U,4)=$P(^DGPM(PM,"DX",0),U,4)+1
 . S ^DGPM(PM,"DX",CNT,0)=DATA(I)
 S RETURN=$P(^DGPM(PM,"DX",0),3,4)_$G(^DGPM(PM,"DX",1,0))
 Q
 ;
GETMVT0(MFN) ;
 Q $G(^DGPM(MFN,0))
 ;
INITEVT() ;
 K ^UTILITY("DGPM",$J)
 Q
 ;
SETCIEVT(MFN,PA) ; Sets lodger check-in prior/after event
 S ^UTILITY("DGPM",$J,4,MFN,PA)=$G(^DGPM(MFN,0))
 S:'$D(^UTILITY("DGPM",$J,4,MFN,"P")) ^UTILITY("DGPM",$J,4,MFN,"P")=""
 Q
SETCOEVT(MFN,PA) ; Sets lodger check-out prior/after event
 S ^UTILITY("DGPM",$J,5,MFN,PA)=$G(^DGPM(MFN,0))
 S:'$D(^UTILITY("DGPM",$J,5,MFN,"P")) ^UTILITY("DGPM",$J,5,MFN,"P")=""
 Q
SETAEVT(MFN,RFN,PA) ; Sets admission prior/after event
 S ^UTILITY("DGPM",$J,1,MFN,PA)=$G(^DGPM(MFN,0))
 S:'$D(^UTILITY("DGPM",$J,1,MFN,"P")) ^UTILITY("DGPM",$J,1,MFN,"P")=""
 Q
 ;
SETREVT(RFN,PA,DEF) ;
 S ^UTILITY("DGPM",$J,6,RFN,PA)=$S($D(DEF):DEF,1:$G(^DGPM(RFN,0)))
 S:'$D(^UTILITY("DGPM",$J,6,RFN,"P")) ^UTILITY("DGPM",$J,6,RFN,"P")=""
 S ^UTILITY("DGPM",$J,6,RFN,"DX"_PA)=$S($D(DEF):DEF,1:$P($G(^DGPM(RFN,"DX",0)),U,3,4)_$G(^DGPM(RFN,"DX",1,0)))
 S:'$D(^UTILITY("DGPM",$J,6,RFN,"DXP")) ^UTILITY("DGPM",$J,6,RFN,"DXP")=""
 S ^UTILITY("DGPM",$J,6,RFN,"PTF"_PA)=$S($D(DEF):DEF,1:$G(^DGPM(RFN,"PTF")))
 S:'$D(^UTILITY("DGPM",$J,6,RFN,"PTFP")) ^UTILITY("DGPM",$J,6,RFN,"PTFP")=""
 Q
SETTEVT(MFN,RFN,PA) ; Sets transfer prior/after event
 S ^UTILITY("DGPM",$J,2,MFN,PA)=$G(^DGPM(MFN,0))
 S:'$D(^UTILITY("DGPM",$J,2,MFN,"P")) ^UTILITY("DGPM",$J,2,MFN,"P")=""
 Q
 ;
SETDEVT(MFN,PA) ; Sets discharge prior/after event
 S ^UTILITY("DGPM",$J,3,MFN,PA)=$G(^DGPM(MFN,0))
 S:'$D(^UTILITY("DGPM",$J,3,MFN,"P")) ^UTILITY("DGPM",$J,3,MFN,"P")=""
 Q
 ;
SETDLEVT(AFN) ; Sets delete prior/after event
 N I,TYPE S I=0
 F  S I=$O(^DGPM("CA",AFN,I)) Q:I=""  D
 . S TYPE=$P(^DGPM(I,0),U,2)
 . I TYPE=6 D SETREVT(I,"P"),SETREVT(I,"A","")
 . S ^UTILITY("DGPM",$J,TYPE,I,"P")=$G(^DGPM(AFN,0))
 . S ^UTILITY("DGPM",$J,TYPE,I,"A")=""
 Q
 ;
LOCKMVT(DFN) ; Lock patient movements
 L +^DGPM("C",DFN):1
 Q $T
ULOCKMVT(DFN) ; Unlock patient movements
 L -^DGPM("C",DFN)
 Q
GETLASTM(RETURN,DFN,DGDT,ADT) ; Get last patient movement
 N NOWI,VAX,VAIP,DGPMVI,NOW
 S NOWI=DGDT,NOW=DGDT,VAIP("D")="L"
 S:'$G(ADT) VAIP("L")=""
 D INP^DGPMV10
 M RETURN=DGPMVI
 Q
 ;
GETMVT(DATA,MFN,FLDS) ; Get patient movement
 N TMP,ERR
 I '$D(FLDS) S FLDS="*"
 D GETS^DIQ(405,MFN,FLDS,"IE","TMP","ERR")
 I $D(ERR) S DATA=0 M DATA=ERR Q
 S DATA=1 M DATA=TMP(405,MFN_",")
 Q
 ;
GETAPRD(DATA,DFN,DGDT,FLDS) ; Get next movement
 N IFN,NEXT
 S NEXT=$O(^DGPM("APRD",+DFN,+DGDT))
 I NEXT>0 S IFN=$O(^DGPM("APRD",+DFN,NEXT,0))
 I +$G(IFN)>0 D
 . D GETMVT(.DATA,IFN,.FLDS)
 . S DATA("ID")=IFN
 Q
 ;
GETRPHY(MFN) ; Get related physical movement
 Q $O(^DGPM("APHY",MFN,0))
 ;
GETPTF(DATA,MFN,FLDS) ; Get ptf record
 N TMP,ERR
 I '$D(FLDS) S FLDS="*"
 D GETS^DIQ(45,MFN,FLDS,"IE","TMP","ERR")
 I $D(ERR) S DATA=0 M DATA=ERR Q
 S DATA=1 M DATA=TMP(45,MFN_",")
 Q
 ;
LSTCA(MVTS,MFN,FLDS) ; Get corresponding admission movements
 N I,MVT S I=0 K MVTS
 I '$D(FLDS) S FLDS=".02;.03"
 F  S I=$O(^DGPM("CA",MFN,I)) Q:I=""  D
 . K MVT D GETMVT(.MVT,I,FLDS)
 . M MVTS(I)=MVT
 Q
 ;
LSTAPMV(MVTS,MFN,FLDS) ; Get corresponding admission movements
 N I,DFN,ID,MVT S I=0 K MVTS
 I '$D(FLDS) S FLDS=".02;.03"
 S DFN=$P(^DGPM(MFN,0),U,3)
 F  S I=$O(^DGPM("APMV",DFN,MFN,I)) Q:I=""  D
 . S ID=$O(^DGPM("APMV",DFN,MFN,I,0))
 . K MVT D GETMVT(.MVT,ID,FLDS)
 . M MVTS(ID)=MVT
 Q
 ;
GETPVTS(DFN,AFN,DGDT) ; Get previous TS movement.
 N X,Y,D,TS
 S D=9999999.9999999-DGDT
 S D=$O(^DGPM("ATS",DFN,AFN,D))
 I D S TS=$O(^DGPM("ATS",DFN,AFN,D,""))
 I TS S X=$O(^DGPM("ATS",DFN,AFN,D,TS,""))
 Q X
 ;
DELMVT(MFN) ; Delete movement
 N DA,DIK,DGIDX
 S DA=MFN,DIK="^DGPM(" D ^DIK
 Q
DELPTF(PTF) ; Delete PTF
 N DA,DIK
 S DA=PTF,DIK="^DGPT(" D ^DIK
 Q
ISPTFCEN(PTF) ;
 I $O(^DGPT("ACENSUS",+PTF,0)) Q $O(^DGPT("ACENSUS",+PTF,0))
 Q 0
