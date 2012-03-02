GMPLEXT ; / External functions mockup (to be deleted when the interfaces are fixed);02/27/2012
 ;;TBD;Problem List;;02/27/2012
PROVNAME(GMPROV) ; Returns provider name
 Q $P($G(^VA(200,+GMPROV,0)),U)
 ;
CLINNAME(GMCLIN) ; Returns Clinic name
 Q $P($G(^SC(+GMCLIN,0)),U)
 ;
PATNAME(GMPDFN) ; Returns patient name
 Q $P($G(^DPT(+GMPDFN,0)),U)
 ;
ICD9NAME(GMPICD) ;
 Q $P($G(^ICD9(+GMPICD,0)),U)
 ;
NOS ; Return PTR ^ 799.9 ICD code
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
