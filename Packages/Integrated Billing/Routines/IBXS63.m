IBXS63 ; ;10/26/11
 S X=DG(DQ),DIC=DIE
 X ^DD(399,161,1,1,1.3) I X S X=DIV S Y(1)=$S($D(^DGCR(399,D0,"U")):^("U"),1:"") S X=$P(Y(1),U,12),X=X S DIU=X K Y S X=DIV D DIS^IBCU S X=X S DIH=$G(^DGCR(399,DIV(0),"U")),DIV=X S $P(^("U"),U,12)=DIV,DIH=399,DIG=162 D ^DICR
