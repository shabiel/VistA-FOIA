DGPMVA ;RGI/VSL - ADMIT PATIENT; 2/20/2013
 ;;5.3;Registration;**260005**;
ADMIT ;
 N DFN,ADMS
 S DFN=$$SELPAT^DGPMVN() Q:'DFN
 D MEANST^DGPMVN(DFN)
 D PATSTAT^DGPMVN(DFN,1)
 S %=$$CONTINUE^DGPMVN()
 G:%="Q"!(%="") ADMIT
ADMIT1 ;
 N RE,ERR
 S %=$$LSTPADMS^DGPMAPI7(.ADMS,DFN)
 S AFN=$$SELMVT^DGPMVN(.ADMS,.NEW,4070000.003)
 G:AFN'>0 ADMIT
 I NEW D NEWADM(.RE,AFN,DFN) I 1
 E  D UPDADM(.RE,AFN)
 I RE=0 D
 . I $P(RE(0),U)="FILELOCK" D BLD^DIALOG(4070000.083,,,"ERR") I 1
 . E  S ERR(1)=$P(RE(0),U,2)
 . D EN^DDIOL(.ERR)
 G ADMIT
 Q
 ;
UPDADM(RETURN,AFN) ;
 N OADM,NADM,DELETED
 S RETURN=1
 S %=$$GETADM^DGPMAPI8(.OADM,AFN)
UPD ;
 S %=$$SELDATE(OADM("DATE")) Q:%="^"
 I %="@" S DELETED=$$DELADM(AFN) I DELETED Q
 G:$D(DELETED) UPD
 S NADM("DATE")=%
 D SEL(.NADM,.OADM,OADM("PATIENT"),.AFN)
 S %=$$UPDADM^DGPMAPI1(.RETURN,.NADM,AFN)
 Q
 ;
DELADM(AFN) ; Delete admission
 N %,TXT,PARAM,DEFAULT,RETURN,ERR
 S TXT(1)="ADMISSION"
 S PARAM("PROMPT")=4070000.084,PARAM("HELPT")=$$EZBLD^DIALOG(4070000.085,.TXT)
 S DEFAULT=2
 S %=$$CANDEL^DGPMAPI1(.ERR,AFN)
 I ERR=0 D EN^DDIOL($P(ERR(0),U,2)) Q 0
 S %=$$YN^DGPMUTL1(.PARAM,.DEFAULT)
 Q:%'=1 0
 S %=$$DELADM^DGPMAPI1(.RETURN,AFN)
 I RETURN=0 D EN^DDIOL($P(RETURN(0),U,2)) Q 0
 Q 1
 ;
SELDATE(DGDT) ;
 N PAR
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.076))
 S PAR("HELP1")=4070000.077,PAR("HELP2")=4070000.077
 S PAR("VALID")="VALDT^DGPMVA"
 Q $$SELTEXT^DGPMUTL1(.PAR,$P(DGDT,U,2))
 ;
VALDT(DGDT,VAL) ; Is selected date valid
 N %DT,Y,X
 S VAL=0,X=DGDT
 I DGDT="@"!(DGDT="^") S VAL=-1 Q
 S %DT="SRXE",%DT(0)="-NOW"
 D ^%DT I Y<0 Q
 S VAL=Y
 Q
SELADM(ADMS,NEW) ;
 N I,LN,LNO,ADMDT,TMP,DDT,X,Y,DIR S LNO=0,NEW=1
SELADM1 ;
 I +$G(ADMS(0))>0,'$D(TMP) D
 . D EN^DDIOL($$UP^XLFSTR($$EZBLD^DIALOG(8068)))
 . F I=0:0 S I=$O(ADMS(I)) Q:I=""  D
 . . S LNO=LNO+1,TMP(LNO)=ADMS(I,"ID"),TMP(+ADMS(I,"DATE"))=ADMS(I,"ID")
 . . I ADMS(I,"DISCH")="" S NEW=0
 . . S LN(LNO)=LNO_"> "_$P(ADMS(I,"DATE"),U,2)_$C(9)_$P(ADMS(I,"TYPE"),U,2)
 . . S LN(LNO)=LN(LNO)_$C(9)_" TO: "_$P(ADMS(I,"WARD"),U,2)_" ["_$P(ADMS(I,"ROOMBED"),U,2)_"]"
 . . I '$D(ADMDT) S ADMDT=ADMS(I,"DATE")
 . . I +ADMDT<+ADMS(I,"DATE") S ADMDT=ADMS(I,"DATE")
 . D EN^DDIOL(.LN)
 I '$D(ADMDT) S ADMDT="^"_$$EZBLD^DIALOG(37007)
 S DDT=$S(NEW:$$EZBLD^DIALOG(37007),1:$P(ADMDT,U,2))
 S DIR(0)="FAO^"
 S DIR("A")=$$EZBLD^DIALOG(4070000.003)_" "_DDT_"//"
 D ^DIR
 I $G(TMP(+Y))>0 S NEW=0 Q TMP(+Y)
 I Y="" S Y=DDT
 S X=Y,%DT="SEXT",%DT(0)="-NOW" D ^%DT I $G(TMP(+Y)) Q TMP(+Y)
 Q:NEW!(Y<0) Y
 G SELADM1
 Q 0
 ;
NEWADM(RETURN,AFN,DFN) ;
 N %,ADM,RE,DIAG
 S %=$$ASK^DGPMVN(AFN)
 I %'=1 G ADMIT1
 S ADM("DATE")=AFN
 S ADM("PATIENT")=DFN
 D SEL(.ADM,,DFN)
 S %=$$ADMIT^DGPMAPI1(.RETURN,.ADM)
 Q %
 ;
SEL(ADM,OADM,DFN,AFN) ;
 S ADM("FDEXC")=$$FDEXC($G(OADM("FDEXC")))
 S ADM("ADMREG")=$$SELADREG($G(OADM("ADMREG")))
 S ADM("ADMSCC")=$$SCCOND($G(OADM("ADMSCC")))
 S ADM("TYPE")=$$SELTYPE($G(OADM("TYPE")),DFN,$G(OADM("DATE")),.AFN)
 S ADM("SHDIAG")=$$DIAG($P($G(OADM("SHDIAG")),U))
 S ADM("WARD")=$$SELWARD($G(OADM("WARD")))
 S ADM("ROOMBED")=$$SELBED(ADM("WARD"),$G(OADM("ROOMBED")))
 Q
SELO(ADM,OADM,DFN,AFN) ;
 D SELALL^DGPMVF(.ADM,.OADM,.DFN,.AFN)
 S ADM("ADMSRC")=$$SELSRC($G(OADM("ADMSRC")))
 S ADM("ELIGIB")=$$ELIG^DGUTL3(+DFN,1,$P($G(OADM("ELIGIB")),U))
 S ADM("SERILL")=$$SERILL($G(OADM("SERILL"),"S^SERIOUSLY ILL"))
 Q
FDEXC(DEFAULT) ; Select Facility directory exclusion
 N Y,DIR
FDEXC1 ;
 S:$G(DEFAULT)'="" DIR("B")=$G(DEFAULT)
 S DIR("?")="^D H1^DGPMVA(4070000.168)",DIR("??")="^D H2^DGPMVA(4070000.009)"
 S DIR("A")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.162))
 S DIR("L")=""
 S DIR(0)="SOA^0:NO;1:YES" D ^DIR
 I X="^" D EN^DDIOL("EXIT NOT ALLOWED ??") G FDEXC1
 I X="@" D EN^DDIOL("?? Required",,"*1") G FDEXC1
 I X="" D EN^DDIOL("??",,"*1") D H1(4070000.168) G FDEXC1
 Q Y
 ;
H1(DIALOG) ; Facility directory exclusion help
 N HLP,I,IF S IF=0
 D BLD^DIALOG(DIALOG,,,"HLP")
 D EN^DDIOL(.HLP),CH
 Q
H2(DIALOG) ; Facility directory exclusion help
 N HLP,I,IF S IF=0
 D BLD^DIALOG(DIALOG,,,"HLP")
 D EN^DDIOL(.HLP),CH
 Q
CH ;
 N TXT
 S TXT(1)="Choose from:"
 S TXT(2)="  0      NO"
 S TXT(3)="  1      YES"
 D EN^DDIOL(.TXT)
 Q
TEST
 S DIE="^DGPM(",DIC=DIE,DP=405,DL=1,DIEL=0,DU="",DNM="DGPMX1N",DIE("NO^")=""
 D 5^DGPMX1N
 Q
SELADREG(DEFAULT) ; Select admitting regulation
 N Y,DIR
SELADRE1
 S:$G(DEFAULT)'="" DIR("B")=$G(DEFAULT)
 S DIR(0)="PO^DIC(43.4," D ^DIR
 I X="^" D EN^DDIOL("EXIT NOT ALLOWED ??") G SELADRE1
 I X="@" D EN^DDIOL("?? Required",,"*1") G SELADRE1
 I Y<0 D EN^DDIOL("??",,"*1") D EN^DDIOL("TEST") G SELADRE1
 Q Y
 ;
SCCOND(DEFAULT) ; Admitted for sc condition?
 N Y,DIR
SCCOND1 ;
 S:$G(DEFAULT)'="" DIR("B")=$G(DEFAULT)
 S DIR("?")="^D H1^DGPMVA(4070000.17)",DIR("??")="^D H2^DGPMVA(4070000.171)"
 S DIR("A")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.169))_":"
 S DIR("L")=""
 S DIR(0)="SOA^0:NO;1:YES" D ^DIR
 I X="@",$G(DEFAULT)'="" D EN^DDIOL("?? Required",,"*1") G SCCOND1
 I X="@",$G(DEFAULT)="" D EN^DDIOL("??",,"*1") G SCCOND1
 ;I X="" D EN^DDIOL("??",,"*1") D H1(4070000.168) G SCCOND1
 Q Y
 ;
SELTYPE(DEFAULT,DFN,DGDT,AFN) ; Select admission type
 N PAR
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.018)),PAR("ENTITY")=PAR("PROMPT")
 S PAR("RTN")="LSTADTYP^DGPMVA",PAR("FLDS")="ID;NAME;TYPE;STATUS",PAR("FLAG")="R"
 S PAR("HELP1")=4070000.019,PAR("HELP2")=4070000.02,PAR("HELP3")=4070000.021
 Q $$SELECT^DGPMUTL1(.PAR,,DEFAULT)
 ;
DIAG(DEFAULT) ; Get short diagnosis
 N PAR
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.022)),PAR("FLAG")="R"
 S PAR("HELP1")=4070000.023,PAR("HELP2")=4070000.024
 S PAR("MIN")=3,PAR("MAX")=30
 Q $$SELTEXT^DGPMUTL1(.PAR,DEFAULT)
 ;
SELWARD(DEFAULT) ; Select ward
 N PAR
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.025)),PAR("ENTITY")=PAR("PROMPT")
 S PAR("RTN")="LSTWARD^DGPMVA",PAR("FLAG")="R"
 S PAR("HELP1")=4070000.026,PAR("HELP2")=4070000.027,PAR("HELP3")=4070000.028
 Q $$SELECT^DGPMUTL1(.PAR,,DEFAULT)
 ;
SELBED(WARD,DEFAULT) ; Select bed
 N PAR
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.029)),PAR("ENTITY")=PAR("PROMPT")
 S PAR("RTN")="LSTWBED^DGPMVA",PAR("FLDS")="NAME;DESC"
 S PAR("HELP1")=4070000.03,PAR("HELP2")=4070000.031
 Q $$SELECT^DGPMUTL1(.PAR,,DEFAULT)
 ;
SELSRC(DEFAULT) ; Select admission source
 N PAR S PAR("FLDS")="CODE;NAME;PLACE"
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.043)),PAR("ENTITY")=PAR("PROMPT")
 S PAR("RTN")="LSTADSRC^DGPMVA",PAR("HELP1")=4070000.044
 S PAR("HELP2")=4070000.045,PAR("HELP3")=4070000.046
 Q $$SELECT^DGPMUTL1(.PAR,,DEFAULT)
 ;
SERILL(DEFAULT) ; Seriously ill
 N PAR,LIST
 S PAR("FLDS")="ID;NAME;"
 S LIST(1,"ID")="S",LIST(1,"NAME")="SERIOUSLY ILL",LIST(0)=1
 S PAR("PROMPT")=$$UP^XLFSTR($$EZBLD^DIALOG(4070000.047)),PAR("ENTITY")=PAR("PROMPT")
 S PAR("HELP1")=4070000.048,PAR("HELP2")=4070000.049
 Q $$SELECT^DGPMUTL1(.PAR,.LIST,DEFAULT)
 ;
LSTADTYP(RETURN,SEARCH,START,NUMBER) ; Lists admission types
 S %=$$LSTADTYP^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER,DFN)
 Q
LSTPATS(RETURN,SEARCH,START,NUMBER) ; Lists patients
 S %=$$LSTPATS^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER)
 Q
LSTADREG(RETURN,SEARCH,START,NUMBER) ; Lists admitting regulation
 S %=$$LSTADREG^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER)
 Q
LSTWARD(RETURN,SEARCH,START,NUMBER) ; Lists wards
 S %=$$LSTWARD^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER)
 Q
LSTWBED(RETURN,SEARCH,START,NUMBER) ; Lists beds
 S %=$$LSTWBED^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER,.WARD,.DFN)
 Q
LSTADSRC(RETURN,SEARCH,START,NUMBER) ; Lists admitting regulation
 S %=$$LSTADSRC^DGPMAPI7(.RETURN,.SEARCH,.START,.NUMBER)
 Q
