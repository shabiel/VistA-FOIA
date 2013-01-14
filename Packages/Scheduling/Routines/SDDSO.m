SDDSO ;BSN/GRR - DELETE ANCILLARY TESTS ;1/14/2013
 ;;5.3;Scheduling;**260003**;Aug 13, 1993
 S:'$D(DTIME) DTIME=300 D:'$D(DT) DT^SDUTL S HDT=DT,APL=""
RD ;
 N DFN,APTS,SDT,L,CNT
 S DFN=$$SELPAT^SDMUI() G END:DFN<0
 S %=$$LSTPAPTS^SDMAPI1(.APTS,+DFN,DT,,"ALL")
 S SDT=0,L=0,CNT=0
 S NAME=$P(DFN,"^",2) W ! I $O(APTS(""))'>0 G NO
 F SDT=0:0 S SDT=$O(APTS(SDT)) Q:'SDT  D
 . S STAT=APTS(SDT,"STATI")
 . I $S(STAT']"":1,STAT["I":1,1:0) D
 . . N TST,SEP,COMM S L=L+1,SEP="",TST="",COMM=""
 . . S:$G(APTS(SDT,"LAB"))>0 TST="LAB",SEP=","
 . . S:$G(APTS(SDT,"XRAY"))>0 TST=TST_SEP_"XRAY",SEP=","
 . . S:$G(APTS(SDT,"EKG"))>0 TST=TST_SEP_"EKG",SEP=","
 . . S:$L(TST)>0 COMM="("_TST_" TEST SCHEDULED)"
 . . S Z(L)=APTS(SDT,"SD")_U_APTS(SDT,"SC")_U_APTS(SDT,"LEN")_U_COMM
 . . S Z(L)=Z(L)_U_APTS(SDT,"CLINIC")_U_APTS(SDT,"OE")
WH1 G:L'>0 NO
 F ZZ=1:1:L  D
 . W !!,ZZ,") "
 . S Y=$P(Z(ZZ),"^",1) D AT^SDUTL S Y=$P(Y,"@",1)_" "_$P(Y,"@",2)
 . W " ",$J(Y,8)," (",$P(Z(ZZ),"^",3)," MINUTES)  ",$P(Z(ZZ),"^",5)," ",$P(Z(ZZ),"^",4)
WH R !!,"DELETE TEST(S) FOR WHICH NUMBERED APPOINTMENT: ",APP:DTIME G:APP=""!(APP="^") RD G:APP["?" WH1 I APP'?1N.N W !,"INVALID ENTRY, MUST BE NUMERIC" G WH
 I APP<1!(APP>ZZ) W !,"ENTER A NUMBER BETWEEN 1 AND ",ZZ G WH
 S APP=+APP,(SD,S)=$P(Z(APP),"^",1),I=$P(Z(APP),"^",2)
 I Z(APP)'["(" W !,*7,"NO TEST ASSOCIATED WITH THIS APPOINTMENT" G WH1
 N ERR
 S %=$$ISOECO^SDMAPI4(.ERR,DFN,S,"delete")
 I ERR W !,*7 D MSG^DIALOG("WE",,,,"ERR") G WH1
 K LAB,XRAY,EKG
 F ZDT="LAB","XRAY","EKG" D TST
 I '$D(LAB)&('$D(XRAY))&('$D(EKG)) W !,*7,"NOTHING DELETED" G RD
 S %=$$DELTSTS^SDMAPI4(.ERR,+DFN,S,.LAB,.XRAY,.EKG)
 I ERR=0 W !,*7 D MSG^DIALOG("WE",,,,"ERR")
 G RD
 ;
NO W !,"NO PENDING APPOINTMENTS",*7,*7,*7
 G RD
TST Q:Z(APP)'[ZDT  S %=1,DTOUT=0 W !,"WANT TO DELETE ",ZDT," TEST" D YN^DICN I '% W !,"RESPOND YES OR NO" G TST
 W:DTOUT " NO" I '(%-1) S @ZDT="" W ?40,"DELETED"
 Q
END K %DT,APL,APP,COMMENT,DA,DFN,DIC,HDT,I,J,L,NAME,NDT,S,SB,SC,SD,SDJ,SI,SL,SS,ST,STARTDAY,STR,X,Y,Z,ZL,ZZ Q
