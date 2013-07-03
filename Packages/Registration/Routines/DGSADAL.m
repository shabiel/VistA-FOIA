DGSADAL ;RGI/CBR - SHARING AGREEMENTS UTILITY FUNCTIONS ;07/03/13  12:02
 ;;5.3;Registration;**114,194,216,260003*****;Aug 13, 1993
LSTSAC(RETURN,TYPE,ACTIVE) ; Lists Sharing agreement Category
 N FILE,FIELDS,RET,SCR
 S FILE="35.1",FIELDS="@;.02IE;.03IE"
 S SCR="I $P(^DG(35.1,Y,0),U)=$G(TYPE)"_$S($G(ACTIVE):",$P(^DG(35.1,Y,0),U,3)=1",1:"")
 D LIST^DIC(FILE,"",FIELDS,"",,,,"B",.SCR,"","RETURN")
 Q
 ;
ADDSASC(RETURN,PARAMS) ; Add Sharing Agreement Sub-Category
 D ADDNEW(.RETURN,35.2,.PARAMS)
 Q
ADDSAC(RETURN,PARAMS) ; Add Sharing Agreement Category
 D ADDNEW(.RETURN,35.1,.PARAMS)
 Q
ADDNEW(RETURN,FILE,PARAMS) ; Add to file
 N FLD,IENS,FDA
 S IENS="+1,"
 S FLD=0
 F  S FLD=$O(PARAMS(FLD)) Q:'FLD  D
 . S FDA(FILE,IENS,FLD)=PARAMS(FLD)
 D UPDATE^DIE("","FDA","IENS","RETURN")
 S RETURN=IENS(1)
 Q
UPDSASC(RETURN,PARAMS,IFN) ; Update Sharing Agreement Sub-Category
 D UPD(.RETURN,35.2,IFN,.PARAMS)
 Q
 ;
UPDSAC(RETURN,PARAMS,IFN) ; Update Sharing Agreement Category
 D UPD(.RETURN,35.1,IFN,.PARAMS)
 Q
 ;
UPD(RETURN,FILE,IFN,PARAMS) ; Update file
 N FLD,IENS,FDA
 S IENS=IFN_","
 S FLD=0
 F  S FLD=$O(PARAMS(FLD)) Q:'FLD  D
 . S FDA(FILE,IENS,FLD)=PARAMS(FLD)
 D FILE^DIE("","FDA","RETURN")
 Q
 ;
SACEXST(IFN) ; Sharing Agreement Category exists
 Q $D(^DG(35.1,$G(IFN)))
 ;
SASCEXST(IFN) ; Sharing Agreement Sub-Category exists
 Q $D(^DG(35.2,$G(IFN)))
 ;
SCNEXST(NAME) ; Sharing Agreement Sub-Category name already exists
 Q $D(^DG(35.2,"B",$G(NAME)))
 ;
