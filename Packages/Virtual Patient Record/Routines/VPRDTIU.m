VPRDTIU ;SLC/MKB -- TIU extract ;8/2/11  15:29
 ;;1.0;VIRTUAL PATIENT RECORD;;Sep 01, 2011;Build 12
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
 ; External References          DBIA#
 ; -------------------          -----
 ; ^SC(                         10040
 ; ^TIU(8925.1              2321,5677
 ; ^TIU(8926.1                   5678
 ; ^VA(200                      10060
 ; DIQ                           2056
 ; TIUCNSLT                      5546
 ; TIUCP                         3568
 ; TIULQ                         2693
 ; TIULX                         3058
 ; TIUSROI                       5676
 ; TIUSRVLO                 2834,2865
 ; TIUSRVR1                      2944
 ;
 ; ------------ Get documents from VistA ------------
 ;
EN(DFN,BEG,END,MAX,ID) ; -- find patient's documents
 N VPRITM,VPRN,VPRX,VPRY,VPRCNT
 S DFN=+$G(DFN) Q:$G(DFN)<1
 S BEG=$G(BEG,1410101),END=$G(END,4141015),MAX=$G(MAX,9999)
 ;
 ; get one document
 I $L($G(ID)),ID[";" D RPT1^VPRDLRA(DFN,ID,.VPRITM),XML(.VPRITM) Q  ;Lab
 I $G(ID),ID["-" D  Q  ;Radiology
 . S (BEG,END)=9999999.9999-+ID D EN1^RAO7PC1(DFN,BEG,END,"99P")
 . D RPT1^VPRDRA(DFN,ID,.VPRITM),XML(.VPRITM)
 . K ^TMP($J,"RAE1")
 I $G(ID) D  Q
 . N SHOWADD S SHOWADD=1
 . S VPRX=ID_U_$$RESOLVE^TIUSRVLO(ID)
 . D EN1(ID,.VPRITM),XML(.VPRITM)
 ;
 ; get all documents
 N CLASS,SUBCLASS,TITLE,SERVICE,SUBJECT,NOTSUBJ,VPRC,CLS
 D SETUP S VPRCNT=0 ;search criteria
 I CLASS="RA" D RPTS^VPRDRA(DFN,BEG,END,MAX) Q
 I CLASS="LR" D RPTS^VPRDLRA(DFN,BEG,END,MAX) Q
 F VPRC=1:1:$L(CLASS,U) S CLS=$P(CLASS,U,VPRC) D  Q:VPRCNT'<MAX
 . D CONTEXT^TIUSRVLO(.VPRY,CLS,1,DFN,BEG,END,,,,1)
 . S VPRN=0 F  S VPRN=$O(@VPRY@(VPRN)) Q:VPRN<1  D  Q:VPRCNT'<MAX
 .. S VPRX=$G(@VPRY@(VPRN)),IFN=+VPRX
 .. Q:($P(VPRX,U,3)<BEG)!($P(VPRX,U,3)>END)  Q:'$$MATCH(IFN)
 .. K VPRITM D EN1(IFN,.VPRITM)
 .. I $D(VPRITM) D XML(.VPRITM) S VPRCNT=VPRCNT+1
 Q
 ;
EN1(IEN,DOC) ; -- return a document in DOC("attribute")=value
 ;  Expects DFN, VPRX=IEN^$$RESOLVE^TIUSRVLO(IEN)
 N X,NAME,VPRTIU,ES,I K DOC
 S IEN=+$G(IEN) Q:IEN<1  ;invalid ien
 Q:"UNKNOWN"[$P($G(VPRX),U,2)  ;null or invalid
 S NAME=$P(VPRX,U,2) I $P(VPRX,U,14),$P(NAME," ")="Addendum" Q
 S DOC("id")=IEN,DOC("localTitle")=NAME
 D EXTRACT^TIULQ(IEN,"VPRTIU",,".01:.04;1501:1508")
 S X=$$GET1^DIQ(8925,IEN_",",".01:1501","I") I X D
 . N IENS,TIU,Y,FNUM
 . S IENS=X_"," D GETS^DIQ(8926.1,IENS,"*","IE","TIU")
 . S DOC("nationalTitle")=$G(TIU(8926.1,IENS,99.99,"E"))_U_$G(TIU(8926.1,IENS,.01,"E"))
 . F I=".04^Subject^2",".05^Role^3",".06^Setting^4",".07^Service^5",".08^Type^6" D
 .. S Y=+$G(TIU(8926.1,IENS,+I,"I")) Q:Y'>0
 .. S FNUM="8926."_+$P(I,U,3)
 .. S DOC("nationalTitle"_$P(I,U,2))=$$VUID^VPRD(Y,FNUM)_U_$G(TIU(8926.1,IENS,+I,"E"))
 S:$G(FILTER("loinc")) DOC("loinc")=$P(FILTER("loinc"),U)
 S X=$G(VPRTIU(IEN,.04,"E")) S:$L(X) DOC("documentClass")=X
 S X=$G(VPRTIU(IEN,.04,"I")),DOC("type")=$$DTYP(+X)
 S DOC("referenceDateTime")=$P(VPRX,U,3)
 S X=$P(VPRX,U,6) D  ;S:$L(X) DOC("location")=X
 . N LOC S LOC=$S($L(X):+$O(^SC("B",X,0)),1:0)
 . S DOC("facility")=$$FAC^VPRD(LOC)
 S X=$P(VPRX,U,7) S:$L(X) DOC("status")=X
 S:$L($P(VPRX,U,12)) DOC("subject")=$P(VPRX,U,12)
 ; X=$S($P(VPRX,U,13)[">":"C",$P(VPRX,U,13)["<":"I",1:"") ;componentType
 S DOC("encounter")=$G(VPRTIU(IEN,.03,"I"))
 S:$G(VPRTEXT) DOC("content")=$$TEXT(IEN)
 ; providers &/or signatures
 S X=$P(VPRX,U,5),I=0 S:X I=I+1,DOC("clinician",I)=+X_U_$P(X,";",3)_"^A" ;author
 M ES=VPRTIU(IEN) I ES(1501,"I") D
 . S I=I+1
 . S DOC("clinician",I)=ES(1502,"I")_U_ES(1502,"E")_"^S^"_ES(1501,"I")_U_$$SIG(ES(1502,"I"))
 I ES(1507,"I") D  ; cosigner
 . S I=I+1
 . S DOC("clinician",I)=ES(1508,"I")_U_ES(1508,"E")_"^C^"_ES(1507,"I")_U_$$SIG(ES(1508,"I"))
 Q
 ;
DTYP(DA) ; -- Return a code for document type #8925.1 DA
 N X
 D ISCNSLT^TIUCNSLT(.X,DA) I X Q "CR"  ;consult result
 I $$ISA^TIULX(DA,25) Q "CW"           ;CWAD note/Allergy
 I $$ISA^TIULX(DA,27) Q "CW"           ;CWAD note/Advance Directive
 I $$ISA^TIULX(DA,30) Q "CW"           ;CWAD note/Crisis Note
 I $$ISA^TIULX(DA,31) Q "CW"           ;CWAD note/Clinical Warning
 I $$ISA^TIULX(DA,3) Q "PN"            ;progress note
 ;
 I $$ISA^TIULX(DA,244) Q "DS"          ;discharge summary
 D ISCP^TIUCP(.X,DA) I X Q "CP"        ;clinical procedure
 D ISSURG^TIUSROI(.X,DA) I X Q "SR"    ;surgery
 I $$ISA^TIULX(DA,$$LR) Q "LR"         ;laboratory
 Q ""
 ;
LR() ; -- Return ien of Lab class
 N Y S Y=+$O(^TIU(8925.1,"B","LR LABORATORY REPORTS",0))
 I Y>0,$S($P($G(^TIU(8925.1,Y,0)),U,4)="CL":0,$P($G(^(0)),U,4)="DC":0,1:1) S Y=0
 Q Y
 ;
SIG(X) ; -- Return Signature Block Name_Title
 N X20,Y S X20=$G(^VA(200,+$G(X),20))
 S Y=$P(X20,U,2)_" "_$P(X20,U,3)
 Q Y
 ;
RPT(VPRY,IFN) ; -- Return text of document in @VPRY@(n)
 D TGET^TIUSRVR1(.VPRY,IFN)
 Q
 ;
TEXT(IFN) ; -- Return document IFN as a text string
 N I,Y,VPRY S IFN=+$G(IFN),Y=""
 I IFN D
 . D TGET^TIUSRVR1(.VPRY,IFN)
 . S I=0 F  S I=$O(@VPRY@(I)) Q:I<1  S Y=Y_$S($L(Y):$C(13,10),1:"")_@VPRY@(I)
 Q Y
 ;
 ; ------------ Return data to middle tier ------------
 ;
XML(DOC) ; -- Return patient documents as XML
 N ATT,X,Y,NAMES,TYPE
 D ADD("<document>") S VPRTOTL=$G(VPRTOTL)+1
 S ATT="" F  S ATT=$O(DOC(ATT)) Q:ATT=""  D  D:$L(Y) ADD(Y)
 . I $O(DOC(ATT,0)) D  S Y="" Q  ;multiples
 .. D ADD("<"_ATT_"s>")
 .. S I=0 F  S I=$O(DOC(ATT,I)) Q:I<1  D
 ... S X=$G(DOC(ATT,I)),NAMES=""
 ... I ATT="clinician" S NAMES="code^name^role^dateTime^signature^Z"
 ... S Y="<"_ATT_" "_$$LOOP_"/>" D ADD(Y)
 .. D ADD("</"_ATT_"s>")
 . S X=$G(DOC(ATT)),Y="" Q:'$L(X)
 . I ATT="content" S Y="<"_ATT_" xml:space='preserve'>"_$$ESC^VPRD(X)_"</"_ATT_">" Q
 . I X'["^" S Y="<"_ATT_" value='"_$$ESC^VPRD(X)_"' />" Q
 . I $L(X)>1 S NAMES="code^name^Z",Y="<"_ATT_" "_$$LOOP_"/>"
 D ADD("</document>")
 Q
 ;
LOOP() ; -- build sub-items string from NAMES and X
 N STR,P,TAG S STR=""
 F P=1:1 S TAG=$P(NAMES,U,P) Q:TAG="Z"  I $L($P(X,U,P)) S STR=STR_TAG_"='"_$$ESC^VPRD($P(X,U,P))_"' "
 Q STR
 ;
ADD(X) ; Add a line @VPR@(n)=X
 S VPRI=$G(VPRI)+1
 S @VPR@(VPRI)=X
 Q
 ;
 ; ------------ Get/apply search criteria ------------
 ;
SETUP ; -- convert FILTER("attribute") = value to TIU criteria
 ; Expects either: FILTER("loinc") = LOINC
 ;             or: FILTER("type")  = code (see $$DTYP)
 ; Returns CLASS,[SUBCLASS,TITLE,SERVICE,SUBJECT]
 ;
 N LOINC,TYPE,CP
 S LOINC=+$G(FILTER("loinc")),TYPE=$$UP^XLFSTR($G(FILTER("type")))
 S CLASS="3^244",(SUBCLASS,TITLE,SERVICE,SUBJECT,NOTSUBJ)=""
 ;
 ; progress notes
 I TYPE="PN" S CLASS=3 Q
 I TYPE="CR"!(LOINC=11488) S CLASS=3,SUBCLASS=+$$CLASS^TIUCNSLT Q
 ; LOINC=26442 S CLASS=3,SUBJECT="^114^" Q          ;OB/GYN
 I LOINC=34117 S CLASS=3,SERVICE="^88^" Q           ;H&P
 I TYPE="CW" S CLASS=3,SUBCLASS="25^27^30^31" Q     ;CWAD
 I TYPE="AD" S CLASS=3,SUBCLASS=27 Q                ;Adv Directive
 ;
 ; discharge summaries
 I TYPE="DS"!(LOINC=18842) S CLASS=244 Q
 ;
 ; procedures
 I TYPE="SR"!(LOINC=29752) S CLASS=+$$CLASS^TIUSROI("SURGICAL REPORTS") Q
 D CPCLASS^TIUCP(.CP)
 I TYPE="CP" S CLASS=CP Q                           ;CLINICAL PROCEDURES
 I LOINC=26441 D  Q                                 ;CARDIOLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^18^142^174^",SERVICE="^75^76^115^"
 I LOINC=27896 D  Q                                 ;PULMONARY
 . S CLASS=CP_"^3"
 . S SUBJECT="^23^142^",SERVICE="^75^76^115^"
 I LOINC=27895 D  Q                                 ;GASTROENTEROLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^20^",SERVICE="^75^76^115^"
 I LOINC=27897 D  Q                                 ;NEUROLOGY
 . S CLASS=CP_"^3"
 . S SUBJECT="^44^45^52^111^112^143^146^",SERVICE="^75^76^115^"
 I LOINC=28619 D  Q                                 ;OPHTH/OPTOMETRY
 . S CLASS=CP_"^3"
 . S SUBJECT="^13^14^103^",SERVICE="^75^76^115^"
 I LOINC=28634 D  Q                                 ;MISC/ALL OTHERS
 . S CLASS=CP_"^3",SERVICE="^75^76^115^"
 . S NOTSUBJ="^18^142^174^23^142^20^44^45^52^111^112^143^146^13^14^103^"
 I LOINC=28570 D  Q                                 ;UNSPECIFIED/ALL
 . S CLASS=CP_"^3"
 . S SERVICE="^75^76^115^"
 ;
 ; pathology/lab
 I TYPE="LR"!(LOINC=27898) S CLASS="LR" Q
 ;
 ; radiology
 I TYPE="RA"!(LOINC=18726) S CLASS="RA" Q
 ;
 ; unknown
 I $L(TYPE)!LOINC S CLASS=0
 Q
 ;
MATCH(DA) ; -- Return 1 or 0, if document DA matches search criteria
 N Y,LOCAL,NATL,X0,OK S Y=0
 S LOCAL=$$GET1^DIQ(8925,DA_",",.01,"I") ;local Title 8925.1 ien
 I $L(SUBCLASS) D  G:'OK MQ
 . N I,X S OK=0
 . F I=1:1:$L(SUBCLASS,"^") S X=$P(SUBCLASS,U,I) I $$ISA^TIULX(LOCAL,SUBCLASS) S OK=1 Q
 S NATL=+$$GET1^DIQ(8925.1,LOCAL_",",1501,"I") ;Natl Title 8926.1 ien
 I $L(TITLE) G:TITLE'[(U_+NATL_U) MQ
 S X0=$G(^TIU(8926.1,NATL,0))
 I $L(SERVICE) G:SERVICE'[(U_+$P(X0,U,7)_U) MQ
 I $L(SUBJECT) G:SUBJECT'[(U_+$P(X0,U,4)_U) MQ
 I $L(NOTSUBJ) G:NOTSUBJ[(U_+$P(X0,U,4)_U) MQ
 S Y=1
MQ Q Y
