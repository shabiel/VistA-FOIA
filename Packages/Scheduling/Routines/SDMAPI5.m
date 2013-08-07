SDMAPI5 ;RGI/VSL - APPOINTMENT API;07/03/13  12:04
 ;;5.3;scheduling;**260003**;08/13/93;
CHKTYPE(RETURN,DFN,TYPE) ; Check patient appointment type
 N PAT,ERR,ELIG,ATYP
 K RETURN S RETURN=0
 I '$$CHKATYPE(.RETURN,.TYPE) Q 0
 S RETURN=0
 D GETPAT^SDMDAL3(.PAT,+DFN,1) S ERR=0
 I PAT(.301)=""!('+PAT(.361)),+TYPE=11 S ERR=1
 I PAT(.301)="N",(+PAT(.302)>0)!(PAT(.361)=1)!(PAT(.361)=3),+TYPE=11 S ERR=1
 I PAT(.301)="Y",+PAT(.302)<50,PAT(.361)'=3,+TYPE=11 S ERR=1
 I PAT(.301)="Y",+PAT(.302)>49,PAT(.361)'=1,+TYPE=11 S ERR=1
 I ERR D ERRX^SDAPIE(.RETURN,"TYPINVSC") Q 0
 D GETELIG^SDMDAL2(.ELIG,PAT(.361),1)
 D GETAPPT^SDMDAL2(.ATYP,+TYPE,1)
 I '$G(ATYP(3)),$S($G(ELIG(4))["Y":1,1:$G(ATYP(5))),$S('$G(ATYP(6)):1,$D(PAT(361,+ATYP(6))):1,+PAT(.361)=ATYP(6):1,1:0) S RETURN=1
 I RETURN=0 D ERRX^SDAPIE(.RETURN,"TYPINVD") Q 0
 S RETURN=1
 Q 1
 ;
CHKATYPE(RETURN,TYPE) ; Check appointment type
 N ATYP
 K RETURN S RETURN=0
 I '+$G(TYPE) D ERRX^SDAPIE(.RETURN,"INVPARAM","TYPE") Q 0
 I '$$TYPEXST^SDMDAL3(+TYPE) D ERRX^SDAPIE(.RETURN,"TYPNFND") Q 0
 D GETAPPT^SDMDAL2(.ATYP,+TYPE,1)
 I $G(ATYP(3)) D ERRX^SDAPIE(.RETURN,"TYPINAC",ATYP(.01)) Q 0
 S RETURN=1
 Q 1
 ;
CHKSTYP(RETURN,TYPE,STYP) ; Check appointment subtype
 N LST,I,%
 K RETURN S RETURN=0
 I $G(STYP)=""!($G(STYP)=0) S RETURN=1 Q 1
 I $G(STYP)]"",'+$G(STYP) D ERRX^SDAPIE(.RETURN,"INVPARAM","STYP") Q 0
 S %=$$LSTASTYP^SDMAPI5(.LST,+$G(TYPE),1)
 F I=0:0 S I=$O(LST(I)) Q:I=""  D
 . I +LST(I,"SUBCAT")=+STYP,LST(I,"STATUS") S RETURN=1
 I 'RETURN D ERRX^SDAPIE(.RETURN,"STYPNFND") Q 0
 Q 1
 ;
CHKSRT(RETURN,SRT) ; Check scheduling request type
 N LST,I,DL,%
 K RETURN S RETURN=0
 I $G(SRT)="" S RETURN=1 Q 1
 S %=$$LSTSRT^SDMAPI1(.LST)
 F I=0:0 S I=$O(LST(I)) Q:I=""!RETURN  D
 . I $P(LST(I),U)=$P(SRT,U) S RETURN=1
 I 'RETURN D ERRX^SDAPIE(.RETURN,"SRTNFND") Q 0
 Q 1
 ;
CHKLABS(RETURN,SD,CLN,TEST,DFN,PNAME) ; Check tests date
 N APT,SD1,%
 K RETURN S RETURN=0
 I $G(TEST)="" S RETURN=1 Q 1
 I '$G(TEST) D ERRX^SDAPIE(.RETURN,"INVPARAM",$G(PNAME)) Q 0
 I '$$DTIME^SDCHK(.RETURN,$P(SD,".")_"."_+$P(TEST,".",2),$G(PNAME)) S RETURN=0 Q 0
 S SD1=+$G(TEST)
 S %=$$GETAPTS^SDMAPI1(.APT,DFN,SD1)
 I +SD1=+SD D ERRX^SDAPIE(.RETURN,"TSTAHAPT",$S($D(CLN(.01)):CLN(.01),1:$P(APT("APT",SD1,"CLINIC"),U,2))) Q 0
 I $D(APT("APT",SD1)),("I"[$P($G(APT("APT",SD1,"STATUS")),U,1)) D  Q 0
 . D ERRX^SDAPIE(.RETURN,"TSTAHAPT",$P(APT("APT",SD1,"CLINIC"),U,2))
 S RETURN=1
 Q 1
 ;
CHKCONS(RETURN,CONS) ; Check request/consultation
 N REQ
 K RETURN S RETURN=0
 I $G(CONS)="" S RETURN=1 Q 1
 I +$G(CONS)'>0 D ERRX^SDAPIE(.RETURN,"INVPARAM","CONS") Q 0
 I '$$CNSEXST^SDMEXT(+CONS) D ERRX^SDAPIE(.RETURN,"CNSNFND") Q 0
 S RETURN=1
 Q 1
 ;
LSTASTYP(RETURN,TYPE,ACTIVE) ; List appointment type sub-categories
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;    RETURN(0) [String] # of entries found
 ;    RETURN(#,ID) [Numeric] Sharing agreement category IEN (pointer to the Sharing Agreement Category file #35.1)
 ;    RETURN(#,SUBCAT) [String] Sub-category IEN^Sub-category name (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;    RETURN(#,STATUS) [String] Sharing agreement category status (I^E)
 ;   TYPE [Required,Numeric] Appointment type IEN (pointer to the Appointment Type file #409.1)
 ;   ACTIVE [Optional,Boolean] If is set to 1 returns only active sub-categories, otherwise all.
 ;Output:
 ;  1=Success,0=Failure
 N %,LST,FLDS,APPT K RETURN S RETURN=0
 I '$$CHKATYPE^SDMAPI5(.RETURN,.TYPE) Q 0
 S %=$$LSTSAC^DGSAAPI(.RETURN,+TYPE_";SD(409.1,",.ACTIVE)
 S RETURN=1
 Q RETURN
 ;
DOW(SD) ;
 N Y,%
 S %=$E(SD,1,3),Y=$E(SD,4,5),Y=Y>2&'(%#4)+$E("144025036146",Y)
 F %=%:-1:281 S Y=%#4=1+1+Y
 S Y=$E(SD,6,7)+Y#7
 Q Y
 ;
SETST(RETURN,SC,SD) ;
 N SDD,ST,PATT,CLN,DATA,SI,DOW
 K RETURN S RETURN=0
 S SDD=$P(+SD,".",1)
 S ST=$$GETDST^SDMDAL1(+SC,SDD)
 I $G(ST)']"" D  Q:RETURN=0 0
 . S DOW=$$DOW(+SD)
 . D GETDPATT^SDMDAL1(.PATT,+SC,SDD,DOW)
 . I PATT("IEN")'>0!($G(PATT("PAT"))="") D ERRX^SDAPIE(.RETURN,"APTWHEN") Q
 . S ST=PATT("PAT")
 . S CLN(1917)=""
 . D GETCLNX^SDMDAL1(.CLN,+SC)
 . S SI=CLN(1917),SI=$S(SI="":4,SI<3:4,SI:SI,1:4)
 . N DAY S DAY=$P("SU^MO^TU^WE^TH^FR^SA","^",DOW+1)
 . S ST=DAY_" "_$E(+SD,6,7)_$J("",SI+SI-6)_ST
 . S DATA(.01)=SDD,DATA(1)=ST
 . D ADDPATT^SDMDAL1(.DATA,+SC,SDD)
 . S RETURN=1
 S RETURN=1
 Q 1
 ;
GETCAPT(RETURN,DFN,SD) ; Get clinic appointment
 N IND,NAME,FLDS,NAMES,CAPT,% K RETURN
 S FLDS="1;3;10;30;309;303;"
 S NAMES="LENGTH;OTHER;RQXRAY;EVISIT;CIDT;CODT;"
 S RETURN("LENGTH")="",RETURN("OTHER")="",RETURN("RQXRAY")=""
 S RETURN("EVISIT")="",RETURN("CIDT")="",RETURN("CODT")=""
 D GETCAPT^SDMDAL4(.CAPT,+DFN,+SD,FLDS,"IE")
 I '$D(CAPT) Q 0
 F IND=0:0 S IND=$O(CAPT(IND)) Q:'IND  D
 . S NAME=$$FLDNAME^SDMUTL(FLDS,NAMES,IND) Q:NAME=""
 . S RETURN(NAME)=CAPT(IND,"I")_U_CAPT(IND,"E")
 . S:RETURN(NAME)=U RETURN(NAME)=""
 . S:$P(RETURN(NAME),U)=$P(RETURN(NAME),U,2) RETURN(NAME)=$P(RETURN(NAME),U)
 S RETURN("RQXRAY")=CAPT(444,"I")
 S RETURN("CSTATUS")=$$STATUS^SDAM1(+DFN,+SD,CAPT(222,"I"),CAPT(333,"I"))
 Q 1
 ;
ADDASC(RETURN,TYPE,SUBCAT,STATUS) ; Add Appointment Sub-category
 ;Input:
 ; .RETURN [Required,Numeric] Set to the new sharing agreement category IEN, 0 otherwise.
 ;                            Set to Error description if the call fails
 ;  TYPE [Required,Numeric] Appointment type IEN (pointer to the Appointment Type file #409.1)
 ;  SUBCAT [Required,Numeric] Sub-Category IFN (pointer to the Sharing Agreement Sub-Category file #35.2)
 ;  STATUS [Optional,Boolean] Sharing Agreement Category status. Defaults to 0.
 ;Output:
 ; 1=Success,0=Failure
 N %,PAR
 K RETURN S RETURN=0
 I '$$CHKATYPE^SDMAPI5(.RETURN,.TYPE) Q 0
 S %=$$ADDSAC^DGSAAPI(.RETURN,+TYPE_";SD(409.1,",.SUBCAT,.STATUS) Q:'RETURN 0
 Q 1
 ;
