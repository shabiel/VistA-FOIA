DGSAAPI ;RGI/CBR - SHARING AGREEMENTS UTILITY FUNCTIONS ;7/10/13
 ;;5.3;Registration;**114,194,216,260003*****;Aug 13, 1993
LSTACAT(RETURN,AREG,ACTIVE) ; List Admitting Categories
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN(0) [String] # of entries found
 ;    RETURN(#,ID) [Numeric] Sharing agreement category IEN (pointer to the Sharing Agreement Category file #35.1)
 ;    RETURN(#,SUBCAT) [String] Sub-category IEN^Sub-category name (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;    RETURN(#,STATUS) [String] Sharing agreement category status (I^E)
 ;   AREG [Required,Numeric] Admitting regulation IEN (pointer to the VA Admitting regulation file #43.4)
 ;   ACTIVE [Optional,Boolean] If is set to 1 returns only active sub-categories, otherwise all.
 ;Output:
 ;  1=Success,0=Failure
 N %,LST,FLDS,APPT K RETURN S RETURN=0
 I '$$CHKAREG^DGPMAPI8(.RETURN,.AREG,"AREG") Q 0
 S %=$$LSTSAC^DGSAAPI(.RETURN,+AREG_";DIC(43.4,",.ACTIVE)
 S RETURN=1
 Q RETURN
 ;
LSTSAC(RETURN,TYPE,ACTIVE) ; List Sharing Agreement Categories
 N FLDS,NAMES,LST K RETURN S RETURN=0
 S FLDS=".02;.03;",NAMES="SUBCAT;STATUS;"
 D LSTSAC^DGSADAL(.LST,$G(TYPE),+$G(ACTIVE))
 D BLDLST^DGPMAPI7(.RETURN,.LST,FLDS,NAMES)
 S RETURN=1,RETURN(0)=+$G(RETURN(0))
 Q RETURN
 ;
ADDACAT(RETURN,AREG,SUBCAT,STATUS) ; Add Admitting category
 ;Input:
 ; .RETURN [Required,Numeric] Set to the new sharing agreement category IEN, 0 otherwise.
 ;                            Set to Error description if the call fails
 ;  AREG [Required,Numeric] Admitting regulation IEN (pointer to the Admitting Regulation file #43.4)
 ;  SUBCAT [Required,Numeric] Sub-Category IFN (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;  STATUS [Optional,Boolean] Sharing Agreement Category status. Defaults to 0.
 ;Output:
 ; 1=Success,0=Failure
 N %,PAR
 K RETURN S RETURN=0
 I '$$CHKAREG^DGPMAPI8(.RETURN,.AREG,"AREG") Q 0
 S %=$$ADDSAC^DGSAAPI(.RETURN,+AREG_";DIC(43.4,",.SUBCAT,.STATUS) Q:'RETURN 0
 Q 1
 ;
UPDCAT(RETURN,SACAT,STATUS) ; Update Sharing Agreement Category
 ;Input:
 ; .RETURN [Required,Numeric] Set to 1 if the operation succeeds
 ;                            Set to Error description if the call fails
 ;  SACAT [Required,Numeric] Sharing Agreement Category IFN (pointer to the Sharing Agreement Category file #35.1)
 ;  STATUS [Optional,Boolean] Sharing Agreement Category status. Defaults to 0.
 ;Output:
 ; 1=Success,0=Failure
 N PAR
 K RETURN S RETURN=0
 I '+$G(SACAT) D ERRX^DGPMAPIE(.RETURN,"INVPARM","SACAT") Q 0
 I '$$SACEXST^DGSADAL(+SACAT) D ERRX^DGPMAPIE(.RETURN,"SACNFND") Q 0
 I $G(STATUS)'=""&(+$G(STATUS)'=0&(+$G(STATUS)'=1)) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","STATUS")
 I $G(STATUS)'="" D
 . S PAR(.03)=+STATUS
 . D UPDSAC^DGSADAL(.RETURN,.PAR,+SACAT)
 S RETURN=1
 Q 1
 ;
ADDSAC(RETURN,TYPE,SUBCAT,STATUS) ; Add Sharing Agreement Category
 N PAR,CATS,IND,CATEX,%
 K RETURN S RETURN=0,CATEX=0
 I '+$G(SUBCAT) D ERRX^DGPMAPIE(.RETURN,"INVPARM","SUBCAT") Q 0
 I '$$SASCEXST^DGSADAL(+SUBCAT) D ERRX^DGPMAPIE(.RETURN,"SASCNFND") Q 0
 I $G(STATUS)'=""&(+$G(STATUS)'=0&(+$G(STATUS)'=1)) D  Q 0
 . S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"INVPARM","STATUS")
 S %=$$LSTSAC^DGSAAPI(.CATS,TYPE)
 F IND=0:0 S IND=$O(CATS(IND)) Q:'IND  I +CATS(IND,"SUBCAT")=+SUBCAT S CATEX=IND
 I CATEX S RETURN=0 D ERRX^DGPMAPIE(.RETURN,"SACEXST",$P(CATS(CATEX,"SUBCAT"),U,2)) Q 0
 S PAR(.01)=TYPE
 S PAR(.02)=+SUBCAT
 S:$G(STATUS)'="" PAR(.03)=+STATUS
 D ADDSAC^DGSADAL(.RETURN,.PAR)
 Q 1
 ;
ADDSASC(RETURN,NAME) ; Add Sharing Agreement Sub-Category
 ;Input:
 ; .RETURN [Required,Numeric] Set to the new sharing agreement sub-category IEN, 0 otherwise.
 ;                            Set to Error description if the call fails
 ;  NAME [Required,String] Sharing Agreement Sub-Category name
 ;Output:
 ; 1=Success,0=Failure
 N PAR
 K RETURN S RETURN=0
 I $L($G(NAME))<3!($L($G(NAME))>30) D ERRX^DGPMAPIE(.RETURN,"SASCINV") Q 0
 I $$SCNEXST^DGSADAL(NAME) D ERRX^DGPMAPIE(.RETURN,"SASCAEX",NAME) Q 0
 S PAR(.01)=NAME
 D ADDSASC^DGSADAL(.RETURN,.PAR)
 Q 1
 ;
UPDSASC(RETURN,IFN,NAME) ; Update Sharing Agreement Sub-Category
 ;Input:
 ; .RETURN [Required,Boolean] Set to 1 if the update succeeded, 0 otherwise.
 ;                            Set to Error description if the call fails
 ;  IFN [Required,Numeric] Sharing Agreement Sub-Category IFN (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;  NAME [Required,String] Sharing Agreement Sub-Category name
 ;Output:
 ; 1=Success,0=Failure
 N PAR,EFN
 K RETURN S RETURN=0
 I '$G(IFN) D ERRX^DGPMAPIE(.RETURN,"INVPARM","IFN") Q 0
 I '$$SASCEXST^DGSADAL(+IFN) D ERRX^DGPMAPIE(.RETURN,"SASCNFND") Q 0
 I $L($G(NAME))<3!($L($G(NAME))>30) D ERRX^DGPMAPIE(.RETURN,"SASCINV") Q 0
 S EFN=$$SCNEXST^DGSADAL(NAME)
 I EFN,EFN'=+IFN D ERRX^DGPMAPIE(.RETURN,"SASCAEX",NAME) Q 0
 S PAR(.01)=NAME
 D UPDSASC^DGSADAL(.RETURN,.PAR,+IFN)
 S RETURN=1
 Q 1
 ;
CHKACAT(RETURN,ADMREG,ADMCAT,NAME) ; Check admitting regulation
 N %,TMP,TXT,IND,FND K RETURN S RETURN=0
 I '$G(ADMCAT) S TXT(1)=$G(NAME) D ERRX^DGPMAPIE(.RETURN,"INVPARM",.TXT) Q 0
 S %=$$LSTACAT^DGSAAPI(.TMP,+ADMREG)
 S FND=0
 F IND=0:0 S IND=$O(TMP(IND)) Q:'IND!FND  D
 . I +TMP(IND,"SUBCAT")=+ADMCAT S FND=IND
 I 'FND D ERRX^DGPMAPIE(.RETURN,"SACNFND") Q 0
 I 'TMP(FND,"STATUS") D ERRX^DGPMAPIE(.RETURN,"ACATINAC",$P(TMP(FND,"SUBCAT"),U,2)) Q 0
 S RETURN=1
 Q 1
 ;
