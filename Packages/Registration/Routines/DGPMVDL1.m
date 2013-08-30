DGPMVDL1 ;ALB/MIR - DELETE PATIENT MOVEMENTS, CONTINUED ; 11 JAN 88 @9
 ;;5.3;Registration;;Aug 13, 1993
D3 ;can this discharge be deleted?
 N %,ERR,TXT S DGPMER=0
 S %=$$CANDEL^DGPMAPI3(.ERR,DGPMDA)
 S DGPMER='ERR
 S TXT="There is a check-in movement following this discharge."
 I DGPMER D:$P(ERR(0),U)="DCHDODLM" EN^DDIOL(TXT) D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
3 N %,ERR
 S %=$$DELDSCH^DGPMAPI3(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
D4 Q
4 ;check-in...delete all related lodger movements
 N %,ERR
 S %=$$DELLDGIN^DGPMAPI4(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
D5 ;can't be followed by another movement
 N %,ERR,TXT S DGPMER=0
 S %=$$CANDEL^DGPMAPI5(.ERR,DGPMDA)
 S DGPMER='ERR
 S TXT="There is an admission movement following this check-out."
 I DGPMER D:$P(ERR(0),U)="DCHDODLM" EN^DDIOL(TXT) D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
5 ;check-out...delete pointer in check-out movement
 N %,ERR
 S %=$$DELLDGOU^DGPMAPI5(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) H 2 Q
 Q
D6 ;can't delete ts mvt associated w/CA
 N %,ERR S DGPMER=0
 S %=$$CANDEL^DGPMAPI6(.ERR,DGPMDA)
 S DGPMER='ERR I DGPMER D EN^DDIOL($P(ERR(0),U,2)) Q
 Q
6 ; -- treating specialty xfrs
 N %,ERR
 S %=$$DELFTS^DGPMAPI6(.ERR,DGPMDA)
 I 'ERR D EN^DDIOL($P(ERR(0),U,2)) H 2 Q
 Q
