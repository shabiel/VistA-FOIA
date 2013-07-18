SDPARDAL ;RGI/VSL - Edit Parmaters DAL 7/18/13
 ;;5.3;Scheduling;**260003**;
 ;
GETPMCS(RETURN,IFN,FLDS) ; Get Print Manager Clinic Setup
 N PAR,DIQ,DIC,DA,DR
 I '$D(FLDS) S FLDS="**"
 D GETS^DIQ(409.95,IFN_",",FLDS,"IE","RETURN")
 Q
 ;
GETCSIFN(SC) ; Get Print Manager Clinic Setup IFN
 Q $O(^SD(409.95,"B",SC,0))
 ;
ADDPMCS(SC) ; Add Print Manager Clinic Setup
 N DIC,DO,DD,DINUM,X,Y
 S DIC="^SD(409.95,",DIC(0)="",X=SC
 D FILE^DICN K DIC
 Q $S(+Y<1:0,1:+Y)
 ;
UPDPMCS(RETURN,IFN,PARAM) ; Update Print Manager Clinic Setup
 D UPD(.RETURN,409.95,IFN,.PARAM)
 Q
 ;
GETPMDS(RETURN,IFN,FLDS) ; Get Print Manager Division Setup
 N PAR,DIQ,DIC,DA,DR
 I '$D(FLDS) S FLDS="**"
 D GETS^DIQ(409.96,IFN_",",FLDS,"IE","RETURN")
 Q
 ;
GETDSIFN(DIV) ; Get Print Manager Division Setup IFN
 Q $O(^SD(409.96,"B",DIV,0))
 ;
ADDPMDS(DIV) ; Add Print Manager Division Setup
 N DIC,DO,DD,DINUM,X,Y
 S DIC="^SD(409.96,",DIC(0)="",X=DIV
 D FILE^DICN K DIC
 Q $S(+Y<1:0,1:+Y)
 ;
UPDPMDS(RETURN,IFN,PARAM) ; Update Print Manager Division Setup
 D UPD(.RETURN,409.96,IFN,.PARAM)
 Q
 ;
DELPMDS(IFN) ; Delete Print Manager Division Setup
 N DA,DIK,DGIDX
 S DA=IFN,DIK="^SD(409.96," D ^DIK
 Q
 ;
UPD(RETURN,FILE,IFN,PARAM) ; Update file
 N FLD,DR,DA,DIE,FDA
 S FLD=0,FDA="",DA=IFN,DIE=FILE,DR=""
 F  S FLD=$O(PARAM(FLD)) Q:'FLD  D
 . S DR=DR_FLD_"////"_PARAM(FLD)_";"
 D ^DIE
 Q
 ;
DELPMCS(IFN) ; Delete Print Manager Clinic Setup
 N DA,DIK,DGIDX
 S DA=IFN,DIK="^SD(409.95," D ^DIK
 Q
 ;
ADDREP(RETURN,IFN,PARAM) ; Add report
 D UPDFILE(.RETURN,409.9501,IFN,"+1",.PARAM)
 Q
 ;
UPDREP(RETURN,IFN,SIEN,PARAM) ; Update report
 D UPDFILE(.RETURN,409.9501,IFN,SIEN,.PARAM)
 Q
 ;
DELREP(IFN,SIFN) ; Delete report
 N DA,DIK,DGIDX
 S DA=IFN,DA(1)=SIFN,DIK="^SD(409.95,"_IFN_",1," D ^DIK
 Q
 ;
ADDEREP(RETURN,IFN,PARAM) ; Add excluded report
 D UPDFILE(.RETURN,409.9502,IFN,"+1",.PARAM)
 Q
 ;
UPDEREP(RETURN,IFN,SIEN,PARAM) ; Update excluded report
 D UPDFILE(.RETURN,409.9502,IFN,SIEN,.PARAM)
 Q
 ;
DELEREP(IFN,SIFN) ; Delete excluded report
 N DA,DIK,DGIDX
 S DA=IFN,DA(1)=SIFN,DIK="^SD(409.95,"_IFN_",2," D ^DIK
 Q
 ;
ADDDREP(RETURN,IFN,PARAM) ; Add division report
 D UPDFILE(.RETURN,409.961,IFN,"+1",.PARAM)
 Q
 ;
UPDDREP(RETURN,IFN,SIEN,PARAM) ; Update division report
 D UPDFILE(.RETURN,409.961,IFN,SIEN,.PARAM)
 Q
 ;
DELDREP(IFN,SIFN) ; Delete division report
 N DA,DIK,DGIDX
 S DA=IFN,DA(1)=SIFN,DIK="^SD(409.96,"_IFN_",1," D ^DIK
 Q
 ;
UPDFILE(RETURN,SFILE,IEN,SIEN,PARAMS) ; Add/update entry to subfile
 N FLD,IENS,FDA
 S IENS=SIEN_","_IEN_","
 S FLD=0
 F  S FLD=$O(PARAMS(FLD)) Q:'FLD  D
 . S FDA(SFILE,IENS,FLD)=PARAMS(FLD)
 I $E(SIEN,1,1)="+" D  I 1
 . D UPDATE^DIE("","FDA","IENS","RETURN")
 . S RETURN=IENS(1)
 E  D FILE^DIE("","FDA","RETURN") S RETURN=1
 Q
 ;
