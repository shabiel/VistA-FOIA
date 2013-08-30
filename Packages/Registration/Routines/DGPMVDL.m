DGPMVDL ;ALB/MIR - DELETE PATIENT MOVEMENTS ; 8/30/13
 ;;5.3;Registration;**161,517**;Aug 13, 1993
 ;
 ;D_DGPMT - these lines are used as DEL nodes.  If DGPMER=1, movement can
 ;          not be deleted.
 ;DGPMT   - once the movement is to be deleted, these are the other
 ;          updates that must also occur.
 ;
D1 N %,ERR S DGPMER=0
 S %=$$CANDEL^DGPMAPI1(.ERR,DGPMDA)
 S DGPMER='ERR I DGPMER D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
1 N %,ERR
 S %=$$DELADM^DGPMAPI1(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) H 2 Q
 Q
Q Q
D2 ;Can this transfer be deleted?
 N %,ERR
 S %=$$CANDEL^DGPMAPI2(.ERR,DGPMDA)
 S DGPMER='ERR I DGPMER D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
2 N %,ERR
 S %=$$DELTRA^DGPMAPI2(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) H 2 Q
 Q
