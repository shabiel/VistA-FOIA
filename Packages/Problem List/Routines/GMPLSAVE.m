GMPLSAVE ; SLC/MKB/KER -- Save Problem List data ; 03/12/13
 ;;2.0;Problem List;**26,31,35,37,38,260002**;Aug 25, 1994
 ;
 ; External References
 ;   DBIA 10018  ^DIE
 ;   DBIA 10013  ^DIK
 ;   DBIA 10013  IX1^DIK
 ;   DBIA 10103  $$HTFM^XLFDT
 ;
EN ; Save Changes made to Existing Problem
 N GMPERR
 S GMPSAVED=$$UPDATE^GMPLAPI2(.GMPERR,GMPIFN,.GMPORIG,.GMPFLD,$G(GMPLUSER),+$G(GMPROV))
 Q
 ;
NEW ; Save Collected Values in new Problem Entry
 ;   Output   DA (left defined)
 S DA=0
 I '$$NEW^GMPLAPI2(.DA,GMPDFN,+$G(GMPROV),.GMPFLD,.GMPLUSER) D  Q
 . W !!,$$ERRTXT^GMPLAPIE(.DA)
 Q
