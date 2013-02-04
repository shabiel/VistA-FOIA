SDMUTL ;RGI/CBR - UI UTILS; 1/14/2013
 ;;5.3;scheduling;**260003**;08/13/93;
FLDNAME(FLDS,NAMES,FLD)    ; Returns field name for display
 N NAME,I,J,S
 S J=0,NAME="",S=";"
 F I=1:1:$L(FLDS,S) I +$P(FLDS,S,I)=+FLD S J=I Q
 Q:J'>0 NAME
 S NAME=$P(NAMES,S,J)
 Q NAME
 ;
READ(TYPE,PROMPT,DEFAULT,HELP) ; Calls reader, returns response
 N DIR,DA,X,Y
 S DIR(0)=TYPE,DIR("A")=PROMPT I $D(DEFAULT) S DIR("B")=DEFAULT
 I $D(HELP) S DIR("?")=HELP
 D ^DIR
 Q Y
 ;
