IBXS32 ; ;10/26/11
 S X=DE(35),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(1)=$S($D(^DGCR(399,D0,"MP")):^("MP"),1:"") S X=$P(Y(1),U,2),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,1,2.4)
 S X=DE(35),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=('$$REQMRA^IBEFUNC(DA)&$$NEEDMRA^IBEFUNC(DA)) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,5),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,2,2.4)
 S X=DE(35),DIC=DIE
 ;
 S X=DE(35),DIC=DIE
 K DIV S DIV=X,D0=DA,DIV(0)=D0 S Y(0)=X S X=$$DELETE^IBCEF84(DA) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"TX")):^("TX"),1:"") S X=$P(Y(1),U,8),X=X S DIU=X K Y S X="" X ^DD(399,.21,1,4,2.4)
