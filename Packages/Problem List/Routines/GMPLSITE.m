GMPLSITE ;RGI -- GMPL Site parameters ;5/15/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
 Q  ;
 ;
GET(RETURN) ;Get site parameters
 ;Input:
 ;  .RETURN [Required,Array] Set to site parameters.
 ;      RETURN("VER") [Boolean] Automatically verify problems
 ;      RETURN("PRT") [Boolean] Prompt to print a chart copy on exit
 ;      RETURN("CLU") [Boolean] Use Clinical Lexicon
 ;      RETURN("REV") [String] Problem display order: C = chronological, R = reverse chronological
 ;      RETURN("SDP") [Boolean] Screen duplicate ICD9 entries.
 N %
 K RETURN
 S %=$$GETPAR(.RETURN)
 S RETURN("REV")=$S(RETURN("REV")="R":1,1:0)
 Q
 ;
VERIFY() ;
 N PARAMS
 D GET(.PARAMS)
 Q PARAMS("VER")
 ;
GETPAR(RETURN) ;
 K RETURN
 D GETPARM^GMPLDAL3(.RETURN)
 Q 1
 ;
SET(RETURN,PARAMS) ; Set site parameters
 ;Input:
 ;  .RETURN [Required,Array] Set to site parameters.
 ;                           Set to Error description if the call fails
 ;      RETURN("VER") [Boolean] Automatically verify problems
 ;      RETURN("PRT") [Boolean] Prompt to print a chart copy on exit
 ;      RETURN("CLU") [Boolean] Use Clinical Lexicon
 ;      RETURN("REV") [String] Problem display order: C = chronological, R = reverse chronological
 ;      RETURN("SDP") [Boolean] Screen duplicate ICD9 entries.
 ;Output:
 ;  1=Success,0=Failure
 N CHOICES,HASERR,HASELEM,I
 S CHOICES=",VER,PRT,CLU,REV,SDP,"
 S HASELEM=0,HASERR=0,I=""
 F  S I=$O(PARAMS(I)) Q:I=""  S HASELEM=1 D
 . I CHOICES'[(","_I_",") S HASERR=1 D ERR^GMPLAPIE("RETURN","INVPARAM",I) Q
 . I PARAMS(I)="" Q
 . I I'="REV",PARAMS(I)'=1,PARAMS(I)'=0,PARAMS(I)'="@" S HASERR=1 D ERR^GMPLAPIE("RETURN","INVPARAM",PARAMS(I)_" @"_I) Q
 . I I="REV",PARAMS(I)'="R",PARAMS(I)'="C",PARAMS(I)'="@" S HASERR=1 D ERR^GMPLAPIE("RETURN","INVPARAM",PARAMS(I)_" @"_I) Q
 I HASERR Q 0
 I 'HASELEM D ERR^GMPLAPIE("RETURN","INVPARAM","NO KEY") Q 0
 D SETPARM^GMPLDAL3(.PARAMS)
 Q 1
 ;
