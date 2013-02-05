SDMDALE ;RGI/CBR - EXTERNAL DAL; 1/5/2013
 ;;5.3;scheduling;**260003**;
LSTSADM(RETURN,DFN,SD,CAN) ; Get scheduled admissions
 N FILE,FIELDS,RET,SCR,SEP
 S FILE="41.1",FIELDS="@;.01;2IE;3IE;4IE;5IE;13IE"
 S ST="I ",SEP=""
 I $D(SD(0)) S SCR="$P(^(0),U,2)'<SD(0)",SEP=","
 I $D(SD(1)) S SCR=SCR_SEP_"$P(^(0),U,2)'>SD(1)",SEP=","
 I $D(CAN) S SCR=SCR_SEP_"$S(CAN=0:'$P(^(0),U,13),1:$P(^(0),U,13))",SEP=","
 S:$L(SEP)>0 SCR=ST_SCR
 D LIST^DIC(FILE,"",FIELDS,"",,,,"B",.SCR,"","RETURN")
 Q
