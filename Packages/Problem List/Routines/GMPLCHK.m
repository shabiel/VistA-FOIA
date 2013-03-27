GMPLCHK ; RGI/CBR -- Problem List Validators ;3/27/13
 ;;2.0;Problem List;**260002**;Aug 25, 1994
PRBIEN(RETURN,PARM,OPT) ;Validate problem ien
 I '$D(PARM),+$G(OPT) Q 1
 I '($G(PARM)?1.N) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPIFN") Q 0 ; Invalid parameter value
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPIFN") Q 0 ; Invalid parameter value
 I '$$EXISTS^GMPLDAL(+PARM) D ERRX^GMPLAPIE(.RETURN,"PRBNFND") Q 0
 Q 1
 ;
BOOL(RETURN,PARM,PNAME) ;Validate boolean fields
 I $G(PARM)="" Q 1 ;"" defaults to false
 I PARM'="0",PARM'="1" D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0 
 Q 1
 ;
NUM(RETURN,PARM,PNAME,OPT,DEC,LOW,HIGH) ;Validate numeric field
 ;PARM=Parameter value
 ;PNAME=Parameter name
 ;OPT=Optional?
 ;DEC=Maximum number of decimals allowed (""=ANY,0=NONE)
 ;LOW=Lower limit
 ;HIGH=Higher limit
 I $G(PARM)="",+$G(OPT) Q 1
 I +$G(PARM)'=$G(PARM) D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0
 I $G(LOW)'="",PARM<+$G(LOW) W "LOW" D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0
 I $G(HIGH)'="",PARM>+$G(HIGH) W "HIGH" D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0
 N RES
 S RES=1
 I $G(DEC)'="" D
 . I +DEC=0,PARM?.E1".".N S RES=0 Q
 . N EXPR S EXPR=".E1""."""_(+DEC+1)_"N.N"
 . I PARM?@EXPR S RES=0 Q
 I 'RES D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0
 Q 1
 ;
DTIME(RETURN,PARM,OPT,RQTIME) ;Validate DateTime fields
 N DATE,TIME,M,D
 I $G(PARM)="",+$G(OPT) Q 1
 I '$D(PARM),'+$G(OPT) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 S DATE=$P(PARM,".")
 S TIME=$P(PARM,".",2)
 I '$$TIME(TIME,'+$G(RQTIME)) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 I DATE'?3.7N D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 S M=$E(DATE,4,5),D=$E(DATE,6,7)
 I M>12 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 I D>31 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 Q 1
 ;
TIME(TIME,OPT) ;Validate time
 N H,M,S
 I 'OPT,TIME="" D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 I TIME="" Q 1
 I TIME'?1.6N D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 S H=$E(TIME,1,2),M=$E(TIME,3,4),S=$E(TIME,5,6)
 I H>23 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 I M>59 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 I S>59 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","DATE") Q 0
 Q 1
 ;
PROVIEN(RETURN,PARM,PNAME,OPT) ;Validate provider IEN
 S PNAME=$G(PNAME,"GMPROV")
 I $G(PARM)="",+$G(OPT) Q 1
 I '($G(PARM)?1.N) D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0 ; Invalid parameter value
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0 ; Invalid parameter value
 I $$PROVNAME^GMPLEXT(PARM)="" D ERRX^GMPLAPIE(.RETURN,"PROVNFND") Q 0
 Q 1
 ;
CODESET(RETURN,PARM,PNAME,CODES,OPT,MULTI) ;Validate lists of codes
 I $G(PARM)="",+$G(OPT) Q 1
 N LEN,I,RES
 S LEN=$L($G(PARM))
 S PNAME=$G(PNAME)
 S MULTI=+$G(MULTI)
 I LEN=0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0
 I 'MULTI,LEN'=1 D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0
 S RES=1
 F I=1:1:LEN D
 . I CODES'[$E(PARM,I) D  Q
 . . D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME)
 . . S RES=0
 Q RES
 ;
LSTIEN(RETURN,PARM) ;Validate problem selection list IEN
 I $G(PARM)'?1.N D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLLST") Q 0
 I '$$FINDLST^GMPLDAL1(PARM) D ERRX^GMPLAPIE(.RETURN,"LISTNFND") Q 0
 Q 1
 ;
CTGIEN(RETURN,PARM,OPT) ;Validate problem selection category IEN
 I $G(PARM)'?1.N D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLGRP") Q 0
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPLGRP") Q 0
 I $$FINDCAT^GMPLDAL1(PARM)'>0 D ERRX^GMPLAPIE(.RETURN,"CTGNFND") Q 0
 Q 1
 ;
CTGITM(RETURN,PARM) ;Category list item
 I '$$CATITM^GMPLDAL1(+$G(PARM)) D ERRX^GMPLAPIE(.RETURN,"ITEMNFND") Q 0
 Q 1
 ;
PATIEN(RETURN,PARM,OPT) ;Patient
 I $G(PARM)="",+$G(OPT) Q 1
 I '($G(PARM)?1.N) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPDFN") Q 0 ; Invalid parameter value
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM","GMPDFN") Q 0 ; Invalid parameter value
 I $$PATNAME^GMPLEXT(PARM)="" D ERRX^GMPLAPIE(.RETURN,"PATNFND") Q 0
 Q 1
 ;
TERMIEN(RETURN,PARM,PNAME,OPT) ;Lexicon term
 I $G(PARM)="",+$G(OPT) Q 1
 S PNAME=$G(PNAME,"TERM")
 I '($G(PARM)?1.N) D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0 ; Invalid parameter value
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0 ; Invalid parameter value
 I $$CONTEXT^GMPLEXT(PARM)="" D ERRX^GMPLAPIE(.RETURN,"TERMNFND") Q 0
 Q 1
 ;
ICDCODE(RETURN,PARM,PNAME,OPT) ;ICD9 code (make sure it is active too)
 I $G(PARM)="",+$G(OPT) Q 1
 N CODE
 S PNAME=$G(PNAME)
 I $G(PARM)'?1.N D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0
 S CODE=$$CODEC^ICDCODE(PARM)
 I CODE=-1 D ERRX^GMPLAPIE(.RETURN,"ICDNFND") Q 0
 I +($$STATCHK^ICDAPIU(CODE,$$NOW^XLFDT))'>0 D ERRX^GMPLAPIE(.RETURN,"ICDINACT") Q 0
 Q 1
 ;
LSTNAME(RETURN,PARM,PNAME) ;Selection list/category names
 S PNAME=$G(PNAME)
 I $G(PARM)="" D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0
 I $L(PARM)>30!(PARM?.N)!($L(PARM)<3)!'(PARM'?1P.E) D ERRX^GMPLAPIE(.RETURN,"INVPARAM",PNAME) Q 0
 Q 1
 ;
SCIEN(RETURN,PARM,PNAME,OPT) ;Clinic IEN
 I $G(PARM)="",+$G(OPT) Q 1
 I '($G(PARM)?1.N) D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0 ; Invalid parameter value
 I PARM'>0 D ERRX^GMPLAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0 ; Invalid parameter value
 N CLIN
 D CLINDET^GMPLEXT(.CLIN,PARM)
 I CLIN("NAME")=""!(CLIN("TYPE")'="C") D ERRX^GMPLAPIE(.RETURN,"LOCNFND") Q 0
 Q 1
 ;
