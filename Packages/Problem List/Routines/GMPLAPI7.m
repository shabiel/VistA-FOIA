GMPLAPI7 ; RGI/VSL -- Problem List - REPORTS ;5/15/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
 Q
 ;
PPROBCNT(TARGET) ; List patients with active and inactive problems.
 ;Input:
 ;  TARGET [Required,String] Root name of a local or global array that will receive data.
 ;     @TARGET [Numeric] Number of patients.
 ;     @TARGET(patient_name) [String] number_of_active_problems^number_of_inactive_problems
 ;Output:
 ;  1=Success,-1=Failure
 I $G(TARGET)="" Q -1
 Q $$PPROBCNT^GMPLDAL4(TARGET)
 ;
PPRBSPEC(TARGET,GMPTERM,GMPTEXT,STATUS) ; List patients with specified active or inactive problems
 ;Input:
 ;  TARGET [Required,String] Root name of a local or global array that will receive data.
 ;     @TARGET(patient_name) [String] problem_status (can be one of "active", "inactive" or "active, inactive")
 ;  GMPTERM [Optional,Numeric] Lexicon term IEN. If specified, only patients having this particular problem will be included.
 ;  GMPTEXT [Optional,String] Provider narrative. If specified, only patients whose problems match this particular provider narrative will be included.
 ;  STATUS [Optional,String] Problem status. Can be any combination of A - active and I - inactive
 ;Output:
 ;  1=Success,-1=Failure
 N RETURN
 I $G(TARGET)="" Q -1
 I '$$TERMIEN^GMPLCHK(.RETURN,.GMPTERM,,1) Q -1
 I '$$CODESET^GMPLCHK(.RETURN,.STATUS,"STATUS","AI",1,1) Q -1
 Q $$PPRBSPEC^GMPLDAL4(TARGET,.GMPTERM,.GMPTEXT,.STATUS)
 ;
