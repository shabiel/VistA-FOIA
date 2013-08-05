DGPARDAL ;RGI/VSL - Edit Parmaters DAL; 7/18/13
 ;;5.3;Registration;**260005**;
 ;
GETMPAR(RETURN,IFN,FLDS) ; Get Main Parameters
 N PAR,DIQ,DIC,DA,DR
 I '$D(FLDS) S FLDS="212;215;216;32;217;226;227;224;"
 S DIQ(0)="IE",DIQ="PAR(",DIC="^DG(43,",DA=+IFN,DR=FLDS D EN^DIQ1
 M RETURN=PAR(43,1)
 Q
 ;
UPDMPAR(RETURN,IFN,PARAM) ; Update Main Parameters
 D UPD(.RETURN,43,IFN,.PARAM)
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
GETDPAR(RETURN,IFN,FLDS) ; Get Division Parameters
 N PAR,DIQ,DIC,DA,DR
 I '$D(FLDS) S FLDS="30.01;30.02;30.03;30.04;"
 S DIQ(0)="IE",DIQ="PAR(",DIC="^DG(40.8,",DA=+IFN,DR=FLDS D EN^DIQ1
 M RETURN=PAR(40.8,IFN)
 Q
 ;
UPDDPAR(RETURN,IFN,PARAM) ; Update Division Parameters
 D UPD(.RETURN,40.8,IFN,.PARAM)
 Q
 ;
DIVEXST(DIV) ; Medical Center Division exists?
 Q $D(^DG(40.8,DIV))
 ;
GETDIV(DATA,IFN,FLDS) ; Get Medical Center Division
 N TMP,ERR
 I '$D(FLDS) S FLDS=".01;.07;"
 D GETS^DIQ(40.8,IFN,FLDS,"IE","TMP","ERR")
 I $D(ERR) S DATA=0 M DATA=ERR Q
 S DATA=1 M DATA=TMP(40.8,IFN_",")
 Q
 ;
LSTDIV(RETURN,SEARCH,START,NUMBER,FLDS) ; Return Medical Center Divisions
 N SCR,TMP,E
 S:'$D(FLDS) FLDS=".01;.07"
 S FLDS="@;"_FLDS
 D LIST^DIC(40.8,"",FLDS,"",.NUMBER,.START,.SEARCH,"B",.SCR,"","RETURN","E")
 I $D(E) M RETURN=E
 Q
 ;
MGRPEXST(MGRP) ; Mail group exists?
 Q $D(^XMB(3.8,MGRP))
 ;
FRMEXST(FRM) ; Form exists?
 Q $D(^IBE(357,FRM))
 ;
REPEXST(REP) ; Report exists?
 Q $D(^IBE(357.6,REP))
 ;
CONEXST(REP) ; Print condition exists?
 Q $D(^IBE(357.92,REP))
 ;
