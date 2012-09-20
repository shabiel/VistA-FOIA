GMPLEXT ; RGI/CBR -- External functions mockup (to be deleted when the interfaces are fixed); 09/14/12
 ;;2.0;Problem List;**260002**;Aug 25, 1994
PROVNAME(GMPROV) ; Returns provider name
 Q $P($G(^VA(200,+GMPROV,0)),U)
 ;
CLINNAME(GMCLIN) ; Returns Clinic name
 Q $P($G(^SC(+GMCLIN,0)),U)
 ;
LOCTYPE(GMPLOC) ; Returns location type
 Q $P($G(^SC(GMPLOC,0)),U,3)
 ;
PATNAME(GMPDFN) ; Returns patient name
 Q $P($G(^DPT(+GMPDFN,0)),U)
 ;
ICDCODE(GMPICD) ;
 Q $P($G(^ICD9(+GMPICD,0)),U)
 ;
NOS() ; Return PTR ^ 799.9 ICD code
 N X
 S X=$O(^ICD9("BA",799.9,0))
 Q (+X_"^799.9")
 ;
PROVNARR(X,CL) ; Returns IFN ^ Text of Narrative (#9999999.27)
 N DIC,Y,DLAYGO,DD,DO,DA
 S:$L(X)>80 X=$E(X,1,80)
 S DIC="^AUTNPOV(",DIC(0)="L",DLAYGO=9999999.27,(DA,Y)=0
 F  S DA=$O(^AUTNPOV("B",$E(X,1,30),DA)) Q:DA'>0  D
 . I $P(^AUTNPOV(DA,0),U)=X S Y=DA_U_X Q
 I '(+Y) D
 . K DA,Y
 . D FILE^DICN
 . S:Y'>0 Y=U_X
 . I Y>0,CL>1 S ^AUTNPOV(+Y,757)=CL
 Q $P(Y,U,1,2)
 ;
LSTTEXT(GMPLSLST) ; Returns list name
 Q $P($G(^GMPL(125,+GMPLSLST,0)),U)
 ;
USERLST(GMPCLIN) ; Returns user list or clinic's
 N GMPLSLST
 S GMPLSLST=$P($G(^VA(200,DUZ,125)),U,2)
 I 'GMPLSLST,$G(GMPCLIN),$D(^GMPL(125,"C",+GMPCLIN)) S GMPLSLST=$O(^(+GMPCLIN,0)) ; if user has no list but clinic does, use clinic list
 Q GMPLSLST
 ;
UPUSRLST(PRIVW,SELLIST) ;Update user list
 S ^VA(200,DUZ,125)=PRIVW_U_SELLIST
 Q
 ;
ICD9KEY(GMPICD) ; Returns KEY IN icd9 File
 Q $O(^ICD9("AB",GMPICD_" ",0))
 ;
SERVICE(USER) ; Returns User's service/section from file #49
 S:$G(USER)="" USER=DUZ
 N X S X=+$P($G(^VA(200,USER,5)),U)
 I $P($G(^DIC(49,X,0)),U,9)'="C" S X=0
 S:X>0 X=X_U_$$SVCNAME(X) S:X'>0 X=""
 Q X
 ;
SVCNAME(SVC) ; Return service name
 Q $P($G(^DIC(49,SVC,0)),U)
 ;
SVCABBV(SVC) ;Service abbreviation
 Q $P($G(^DIC(49,SVC,0)),U,2)
 ;
USERVIEW(USER) ; Returns user's preferred view
 S USER=+$G(USER,DUZ)
 Q $P($G(^VA(200,USER,125)),U)
 ;
CLINUSER() ;is this a clinical user?
 N GMPLUSER
 S GMPLUSER=0
 I $$KCHK^XUSRB("PROVIDER") S GMPLUSER=1
 I $$KCHK^XUSRB("ORES") S GMPLUSER=1
 I $$KCHK^XUSRB("ORELSE") S GMPLUSER=1
 Q GMPLUSER
 ;
NARR(PRB) ; Returns problem narrative
 Q:'+$G(PRB) ""
 Q $P($G(^AUTNPOV(+PRB,0)),U)
PROTKEY(NAME) ;PROTOCOL IEN from name
 Q $O(^ORD(101,"B",NAME,0))
 ;
ENACT(KEY) ;PROTOCOL entry action
 Q $G(^ORD(101,KEY,20))
 ;
UPDITEM(KEY,ITEM,MN,NAME) ;Update protocol item details
 N DA,DR,DIE,X
 S DA=$O(^ORD(101,KEY,10,"B",ITEM,0)) Q:'DA
 S DR="2////"_MN_";6///^S X=NAME"
 S DIE="^ORD(101,"_KEY_",10,"
 D ^DIE
 Q
 ;
CONTEXT(LEXIEN) ;Returns concept displayable text
 Q $G(^LEX(757.01,LEXIEN,0))
 ;
