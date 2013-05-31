SDMUTL ;RGI/CBR - UI UTILS; 5/31/13
 ;;5.3;scheduling;**260003**;08/13/93;
FLDNAME(FLDS,NAMES,FLD)    ; Returns field name for display
 N NAME,I,J,S
 S J=0,NAME="",S=";"
 F I=1:1:$L(FLDS,S) I +$P(FLDS,S,I)=+FLD S J=I Q
 Q:J'>0 NAME
 S NAME=$P(NAMES,S,J)
 Q NAME
 ;
