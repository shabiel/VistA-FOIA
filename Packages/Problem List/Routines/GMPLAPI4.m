GMPLAPI4 ; RGI/CBR -- Problem List API - LIST ;3/27/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
LIST(RETURN,GMPDFN,GMPSTAT,GMPROV,GMPVIEW,GMPREV,GMPIDX) ;returns a filtered list of patient problems
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;       RETURN(0)=number of problems returned
 ;       RETURN(#)=problem_IEN^status^problem^ICD9^onset^last_modified^sc^exposures^condition^
 ;                 location^loc_type^provider^service^priority^has_comments^
 ;                 date_recorded^sc_condition^icd_inactive
 ;   GMPDFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   GMPSTAT [Optional,String] Status of problems to be returned. Can be any combination of (A)ctive, (I)nactive and (R)emoved.
 ;                             Default: A = returns active problems only
 ;   GMPROV [Optional,Numeric] Provider IEN (pointer to file 200). If present, the problems returned will be filtered by this provider.
 ;                             Default - return all problems
 ;   GMPVIEW [Optional,String] Filter by service location or clinic. Format "S/facility_ien/facility_ien/." or "C/clinic_ien/clinic_ien/.".
 ;                             If facility IEN's are not passed, returns inpatient problems when GMPVIEW="S" or outpatient ones when it is set to "C".
 ;                             Default - returns all problems.
 ;   GMPREV [Optional,Boolean] Reversed order. The problems will be sorted in reversed order of recorded date.
 ;   GMPIDX [Optional,Boolean] Create "B" index. If set to 1 will append a "B" index to the output array.
 ;                             RETURN("B",ien#)=#. Default - 0
 ;Output:
 ;  1=Success,0=Failure
 N PLIST,RVAL
 K RETURN
 I '$$GETPLIST(.PLIST,.GMPDFN,.GMPSTAT,.GMPREV,.GMPROV,.GMPVIEW,.GMPIDX) Q 0
 M RETURN=PLIST
 S RVAL=$$BUILDLST(.RETURN,.PLIST)
 S RETURN=$G(PLIST)
 Q RVAL
 ;
GETPLIST(RETURN,GMPDFN,GMPSTAT,GMPREV,GMPROV,GMPVIEW,GMPIDX) ; lists problem ien's
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;      RETURN=Total number of patient's problems that would be returned if GMPROV and GMPVIEW were not specified.
 ;             Depends on GMPSTAT value:if GMPSTAT="A", RETURN will be set to the number of patient's active problems,
 ;             if GMPSTAT="I" will be set to the number of patient's inactive problems, etc.
 ;      RETURN(0)=number of problems returned
 ;      RETURN(#)=IEN #
 ;   GMPDFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   GMPSTAT [Optional,String] Status of problems to be returned. Can be any combination of (A)ctive, (I)nactive and (R)emoved.
 ;                             Default: "AI" - returns both active and inactive problems (but not removed ones).
 ;   GMPREV [Optional,Boolean] Reversed order. The problems will be sorted in reversed order of recorded date.
 ;   GMPROV [Optional,Numeric] Responsible provider IEN (pointer to file 200). If passed, the problems returned will be filtered by this provider.
 ;                             Default: "" - return all problems
 ;   GMPVIEW [Optional,String] Filter by service location (inpatient problems) or clinic (outpatient problems).
 ;                             Format: "S/facility_ien/facility_ien/./" or "C/clinic_ien/clinic_ien/./".
 ;                             Note: the string should end in a forward slash. Default: "" - returns all problems.
 ;   GMPIDX [Optional,Boolean] Create "B" index. If set to 1 will append a "B" index to the output array.
 ;                             RETURN("B",problem_ien)=#. Default - 0
 ;Output:
 ;  1=Success,0=Failure
 N TOTAL
 S RETURN=0
 I '$$PATIEN^GMPLCHK(.RETURN,.GMPDFN) Q 0
 I '$$CODESET^GMPLCHK(.RETURN,.GMPSTAT,"GMPSTAT","AIR",1,1) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPREV,"GMPREV") Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV,,1) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPIDX,"GMPIDX") Q 0
 S GMPVIEW=$G(GMPVIEW)
 I GMPVIEW'="",$E(GMPVIEW,1,2)'="C/",$E(GMPVIEW,1,2)'="S/" D  Q 0
 . D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPVIEW")
 S GMPSTAT=$G(GMPSTAT)
 S GMPREV=+$G(GMPREV)
 S GMPROV=+$G(GMPROV)
 S GMPIDX=+$G(GMPIDX)
 D GETPLIST^GMPLDAL(.RETURN,.TOTAL,GMPDFN,GMPSTAT,GMPREV,GMPROV,GMPVIEW,GMPIDX)
 S RETURN=TOTAL
 Q 1
 ;
BUILDLST(RETURN,GMPLIST) ; Same as LIST but returns only problems passed in GMPLIST
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;       RETURN(0)=number of problems returned
 ;       RETURN(#)=problem_IEN^status^problem^ICD9^onset^last_modified^sc^exposures^condition^
 ;                 location^loc_type^provider^service^priority^has_comments^
 ;                 date_recorded^sc_condition^icd_inactive
 ;  .GMPLIST [Required,Array] List of problem IENs in the following format:
 ;       GMPLIST(0)=number of records
 ;       GMPLIST(1)=problem_IEN 1
 ;       .
 ;       GMPLIST(n)=problem_IEN n
 ;Output:
 ;  1=Success,0=Failure
 N I,GMPL,IFN,INACT,ST,ICD,ONSET,LASTMOD,SC,SP,LOC,LT,PROV,SERV,CNT
 N PRIO,HASCMT,DTREC,AO,IR,ENV,HNC,MST,CV,SHD,SCCOND,TOTAL,X,ORICD186
 S RETURN=0
 I $D(GMPLIST)<10 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLIST") Q 0
 I '$$NUM^GMPLCHK(.RETURN,$G(GMPLIST(0)),"GMPLIST",0,0,1) Q 0
 S ORICD186=$$PATCH^XPDUTL("ICD*18.0*6")
 S I=0,CNT=0
 F  S I=$O(GMPLIST(I)) Q:I'>0  D
 . S INACT=""
 . S IFN=+$G(GMPLIST(I))
 . Q:'$$DETAIL^GMPLDAL(IFN,.GMPL)
 . S CNT=CNT+1
 . S ST=GMPL(.12)
 . I +$G(ORICD186) D
 . . S ICD=$$CODEC^ICDCODE(+GMPL(.01))
 . . I '+$$STATCHK^ICDAPIU(ICD,DT) S INACT="#"
 . E  D
 . . S ICD=$$ICDCODE^GMPLEXT(GMPL(.01))
 . S ONSET=GMPL(.13)
 . S LASTMOD=GMPL(.03)
 . S SC=$S(+GMPL(1.10):"SC",GMPL(1.10)=0:"NSC",1:"")
 . S SP=""
 . F X=1.11,1.12,1.13 S:GMPL(X) SP=SP_$S(X=1.11:"A",X=1.12:"I",1:"P")
 . S LOC=GMPL(1.08)
 . S LT=""
 . I LOC'="" S LT=$$LOCTYPE^GMPLEXT(LOC),LOC=LOC_";"_$$CLINNAME^GMPLEXT(LOC)
 . S PROV=GMPL(1.05) ; responsible provider
 . I PROV'="" S PROV=PROV_";"_$$PROVNAME^GMPLEXT(PROV)
 . S SERV=GMPL(1.06)
 . I SERV=0 S SERV="" ; not sure how it gets set to 0, but need consistency in GUI
 . I SERV'="" S SERV=SERV_";"_$$SVCNAME^GMPLEXT(SERV)
 . S PRIO=GMPL(1.14)
 . S HASCMT=$$HASNOTE^GMPLDAL3(IFN)
 . S DTREC=GMPL(1.09)
 . S AO=$S(+GMPL(1.11):"/AO",1:"")
 . S IR=$S(+GMPL(1.12):"/IR",1:"")
 . S ENV=$S(+GMPL(1.13):"/EC",1:"")
 . S HNC=$S(+GMPL(1.15):"/HNC",1:"")
 . S MST=$S(+GMPL(1.16):"/MST",1:"")
 . S CV=$S(+GMPL(1.17):"/CV",1:"")
 . S SHD=$S(+GMPL(1.18):"/SHD",1:"")
 . S SCCOND=SC_AO_IR_ENV_HNC_MST_CV_SHD
 . S RETURN(CNT)=IFN_U_ST_U_$$PROBTEXT^GMPLX(IFN)_U_ICD_U_ONSET
 . S RETURN(CNT)=RETURN(CNT)_U_LASTMOD_U_SC_U_SP_U_GMPL(1.02)
 . S RETURN(CNT)=RETURN(CNT)_U_LOC_U_LT_U_PROV_U_SERV_U_PRIO_U_HASCMT_U_DTREC_U_SCCOND_U_INACT
 S RETURN(0)=CNT
 S RETURN=1
 Q 1
 ;
FLDNAME(RETURN) ;
 N FIELDS,NAMES,I
 K RETURN
 S FIELDS=".01^.05^.12^.13^1.01^1.05^1.07^1.08^1.09^1.10^1.11^1.12^1.13^1.15^1.16^1.17^1.18"
 S NAMES="DIAGNOSIS^NARRATIVE^STATUS^ONSET^LEXICON^PROVIDER^RESOLVED^LOCATION^RECORDED^SC^AO^IR^EC^HNC^MST^CV^SHD"
 F I=1:1:$L(FIELDS,"^") S RETURN($P(FIELDS,"^",I))=$P(NAMES,"^",I)
 Q 1
 ;
LASTMOD(RETURN,GMPIFN) ; last modified date for a problem
 ;Input:
 ;  .RETURN [Required,DateTime] Set to last modified date
 ;                              Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$LASTMOD^GMPLDAL3(GMPIFN)
 Q 1
 ;
DEFAULT(RETURN,GMPROB,GMPICD,GMPTERM,GMPROV,GMPCLIN,GMPELIG) ;Return default values for new problems
 ;Input:
 ;  .RETURN [Required,Array] An array passed by reference that will be initialized with the default values. 
 ;                           It has the same structure as GMPFLD array described in NEW^GMPLAPI2
 ;                           Set to Error description if the call fails
 ;   GMPROB [Required,String] Provider narrative
 ;   GMPICD [Required,String] The ICD9 code associated to this problem
 ;   GMPTERM [Required,Numeric] Lexicon term IEN (pointer to file 757.01)
 ;   GMPROV [Optional,Numeric] Provider IEN (pointer to file 200)
 ;   GMPCLIN [Optional, Numeric] Clinic IEN (pointer to file 44)
 ;   GMPELIG [Optional,Array] An array of eligibilities for the environmental exposures. If any of the following nodes are defined it will set the corresponding entry to 1:
 ;      GMPELIG("SC")=service connected
 ;      GMPELIG("AO")=agent orange
 ;      GMPELIG("IR")=ionizing radiation
 ;      GMPELIG("EC")=environment contaminants
 ;Output:
 ;  1=Success,0=Failure
 I '+$$STATCHK^ICDAPIU(GMPICD,DT) D ERRX^GMPLAPIE(.RETURN,"INACTICD") Q 0
 S RETURN(.01)=$$ICD9KEY^GMPLEXT(GMPICD)_U_GMPICD
 S:'RETURN(.01) RETURN(.01)=$$NOS^GMPLEXT ; cannot resolve code
 S RETURN(.05)=U_GMPROB
 S RETURN(.08)=DT_U_$$EXTDT^GMPLX(DT)
 S RETURN(.12)="A^ACTIVE"
 S RETURN(.13)=""
 S RETURN(1.01)=GMPTERM
 S RETURN(1.02)=$S('$$VERIFY^GMPLSITE:"P",$$CLINUSER^GMPLEXT:"P",1:"T")
 S RETURN(1.03)=DUZ
 S RETURN(1.04)=$G(GMPROV)
 S RETURN(1.05)=$G(GMPROV)
 S RETURN(1.06)=$$SERVICE^GMPLEXT(+$G(GMPROV))
 S RETURN(1.07)=""
 S RETURN(1.08)=$G(GMPCLIN)
 S RETURN(1.09)=DT_U_$$EXTDT^GMPLX(DT)
 S RETURN(1.14)=""
 S RETURN(1.10)=$S('$D(GMPELIG("SC")):"0^NO",1:"")
 S RETURN(1.11)=$S('$D(GMPELIG("AO")):"0^NO",1:"")
 S RETURN(1.12)=$S('$D(GMPELIG("IR")):"0^NO",1:"")
 S RETURN(1.13)=$S('$D(GMPELIG("EC")):"0^NO",1:"")
 S RETURN(10,0)=0
 Q 1
 ;
UNDELETE(RETURN,GMPIFN) ; Undeletes problem
 ;Input:
 ;  .RETURN [Required,Boolean] Set 1 if the call succeeded
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 N DELETED,%
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$DELETED^GMPLAPI2(.DELETED,.GMPIFN) Q 0
 I 'DELETED D ERRX^GMPLAPIE(.RETURN,"INVREC") Q 0
 D CHGCOND^GMPLDAL(GMPIFN,"H","P")
 S RETURN=1
 Q 1
 ;
DIAG(RETURN,GMPIFN) ; Returns ICD diagnosis: pointer_to_icd_file^icd
 ;Input:
 ;  .RETURN [Required,String]  Set to ICD code in the following format: pointer_to_icd_file^icd_code
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 N ICD,DET,%
 S RETURN=""
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 ;Q:'+$G(GMPIFN) 0
 S %=$$DETAIL^GMPLAPI2(.DET,GMPIFN)
 S ICD=$P(DET(.01),U)
 S RETURN=ICD_U_$$ICDCODE^GMPLEXT(ICD)
 Q 1
 ;
PROBNARR(RETURN,GMPIFN) ; Returns Provider Narrative
 ;Input:
 ;  .RETURN [Required,String] Set to provider_narrative_ien^problem_narrative
 ;                            Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 N PRB,DET,%
 S RETURN=""
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S %=$$DETAIL^GMPLAPI2(.DET,GMPIFN)
 S PRB=+DET(.05)
 S RETURN=PRB_U_$$NARR^GMPLEXT(PRB)
 Q 1
 ;
PRBCNT(RETURN) ;Return number of entries in PROBLEM LIST.
 S RETURN=$$PRBCNT^GMPLDAL3()
 Q 1
 ;
VALID(RETURN,GMPIFN) ;RETURN=1 if problem IEN is valid
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if PROBLEM file contains GMPIFN
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S RETURN=$$EXISTS^GMPLDAL(GMPIFN)
 Q 1
 ;
PATIENT(RETURN,GMPIFN) ; Returns patient IEN given problem IEN
 ;Input:
 ;  .RETURN [Required,Numeric] Set to patient IEN (pointer to file 2)
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;Output:
 ;  1=Success,0=Failure
 N VALID,%,DET
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 S %=$$DETAIL^GMPLAPI2(.DET,GMPIFN)
 S RETURN=+DET(.02)
 Q 1
 ;
REPLACE(RETURN,GMPIFN,NEWDIAG) ; Replace ICD diagnosis code
 ;Input:
 ;  .RETURN [Required,Boolean] Set 1 if the call succeeded
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;   NEWDIAG [Required,Numeric] ICD9 code IEN (pointer to file 80)
 ;Output:
 ;  1=Success,0=Failure
 N OLDDIAG,%
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$ICDCODE^GMPLCHK(.RETURN,.NEWDIAG,"NEWDIAG") Q 0
 S %=$$DIAG(.OLDDIAG,GMPIFN)
 S OLDDIAG=$P(OLDDIAG,U)
 S NEWDIAG=$P(NEWDIAG,U)
 Q:OLDDIAG=NEWDIAG 0
 D REPLACE^GMPLDAL(GMPIFN,OLDDIAG,NEWDIAG)
 S RETURN=1
 Q 1
 ;
HASPRBS(RETURN,GMPDFN,GMPSTAT) ; Returns 1 if patient DFN has problems with status GMPSTAT
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if patient file contains problems with status GMPSTAT
 ;                             Set to Error description if the call fails
 ;   GMPDFN [Required,Numeric] Patient IEN (pointer to file 2)
 ;   GMPSTAT [Optional,String] Problem status: Any combination of (A)ctive and (I)nactive.
 ;                             Default: AI = both active and inactive.
 ;Output:
 ;  1=Success,0=Failure
 S GMPSTAT=$G(GMPSTAT,"AI")
 S RETURN=0
 I '$$PATIEN^GMPLCHK(.RETURN,.GMPDFN) Q 0
 I '$$CODESET^GMPLCHK(.RETURN,.GMPSTAT,"GMPSTAT","AI",0,1) Q 0
 S RETURN=$$HASPRBS^GMPLDAL3(GMPDFN,GMPSTAT)
 Q 1
MODIFIED(RETURN,GMPDFN) ; Return the Date the Patients Problem List was Last Modified
 S RETURN=$$MODIFIED^GMPLDAL3(GMPDFN)
 Q 1
