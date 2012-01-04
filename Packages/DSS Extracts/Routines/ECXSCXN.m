ECXSCXN ;ALB/JAP  Clinic Extract ;10/14/10  18:07
 ;;3.0;DSS EXTRACTS;**24,27,29,30,31,32,33,39,46,49,52,71,84,92,107,105,120,124,127,132**;Dec 22, 1997;Build 18
 ;
BEG ;entry point from option
 D SETUP Q:ECFILE=""  D ^ECXTRAC,^ECXKILL
 Q
 ;
START ;entry point from taskmgr
 N DIC,EXNUM,I,LOCARR,OUT,P1,P2,P3,PROCESS,SOURCE,STOP,STAT,TOSEND
 N TIU,X,Y,ECXNPRFI
 F I=1:1:8 S @("ECXCPT"_I)=""
 F I=1:1:4 S @("ECXICD9"_I)=""
 S (OUT,QFLG,ECRN)=0,(ECXICD9P,ECXOBI)=""
 K ^TMP($J,"ECXS"),^TMP($J,"ECXCL")
 ;get ien for tiu in file #839.7
 S DIC="^PX(839.7,",DIC(0)="X",X="TEXT INTEGRATION UTILITIES"
 D ^DIC S TIU=+Y,ECED=ECED+.3,ECXCLIN=0 K DIC,Y
 ;get clinic default appt length, type, division
 F  S ECXCLIN=$O(^SC(ECXCLIN)) Q:'ECXCLIN  D
 .K LOCARR S DIC=44,DA=ECXCLIN,DR="2;3.5;1912",DIQ(0)="I",DIQ="LOCARR"
 .D EN^DIQ1
 .Q:$G(LOCARR(44,ECXCLIN,2,"I"))'="C"
 .S ALEN=+$G(LOCARR(44,ECXCLIN,1912,"I"))
 .S ^TMP($J,"ECXCL",ECXCLIN)=ALEN,ALEN=$$RJ^XLFSTR(ALEN,3,0)
 .S ^TMP($J,"ECXCL",ECXCLIN)=^TMP($J,"ECXCL",ECXCLIN)_"^"_ALEN_"^"_$G(LOCARR(44,ECXCLIN,2,"I"))_"^"_+$G(LOCARR(44,ECXCLIN,3.5,"I"))
 .D FEEDER^ECXSCX1(ECXCLIN,ECSD1,.P1,.P2,.P3,.TOSEND,.ECXDIV)
 .K P1,P2,P3,TOSEND,ECXDIV
 ;get from file #44 any no-shows & get encounters from #409.68
 D NOSHOW^ECXSCXN1(ECSD1,ECED),ENCNTR(ECSD1,ECED)
 ;send missing clinic msg
 D:$D(^TMP($J,"ECXS")) EN^ECXSCX1
 K ^TMP($J,"ECXS"),^TMP($J,"ECXCL")
 Q
 ;
ENCNTR(ECSD1,ECED) ;search file #409.68 for encounter data
 N CHKOUT,ECD,JJ,K,OUT,PNODE,PP,STAT,STOP,MDIV
 S ECD=ECSD1
 F  S ECD=$O(^SCE("B",ECD)) Q:('ECD!(ECD>ECED))!(QFLG)  S ECXIEN=0 D
 .F  S ECXIEN=$O(^SCE("B",ECD,ECXIEN)) Q:'ECXIEN  D  Q:QFLG
 ..Q:'$D(^SCE(ECXIEN,0))
 ..D INTPAT^ECXSCX2 K LOCARR S DIC=409.68,DA=ECXIEN
 ..S DR=".01;.02;.03;.04;.05;.06;.07;.08;.11;.12;.13",DIQ(0)="I",DIQ="LOCARR"
 ..D EN^DIQ1
 ..S ECXTI=$P($$FMTE^XLFDT(+$G(LOCARR(409.68,ECXIEN,.01,"I")),1),"@",2)
 ..S ECXTI=$E(($TR(ECXTI,":","")_"000000"),1,6)
 ..S:ECXTI="000000" ECXTI="000300" S MDIV=+$G(LOCARR(409.68,ECXIEN,.11,"I"))
 ..S STOP=+$G(LOCARR(409.68,ECXIEN,.03,"I"))
 ..S CHKOUT=+$G(LOCARR(409.68,ECXIEN,.07,"I"))
 ..S PROCESS=+$G(LOCARR(409.68,ECXIEN,.08,"I"))
 ..S STAT=$G(LOCARR(409.68,ECXIEN,.12,"I"))
 ..S ECXDFN=+$G(LOCARR(409.68,ECXIEN,.02,"I"))
 ..Q:(ECXDFN=0)!('CHKOUT)
 ..S:STAT="" STAT="ZZ" S STAT=";"_STAT_";"
 ..Q:";3;4;5;6;7;9;10;13;"[STAT
 ..Q:('STOP)!(PROCESS=4)!(+$G(LOCARR(409.68,ECXIEN,.06,"I")))
 ..S ECXDATE=+$G(LOCARR(409.68,ECXIEN,.01,"I"))
 ..S ECXCLIN=+$G(LOCARR(409.68,ECXIEN,.04,"I"))
 ..Q:$P($G(^TMP($J,"ECXCL",ECXCLIN)),U,3)'="C"
 ..S ECXVISIT=+$G(LOCARR(409.68,ECXIEN,.05,"I"))
 ..S ECXENEL=+$G(LOCARR(409.68,ECXIEN,.13,"I"))
 ..Q:'ECXVISIT
 ..S ECXERR=0
 ..D PAT1^ECXSCX2(ECXDFN,ECXDATE,.ECXERR) Q:ECXERR
 ..D FEEDER^ECXSCX1(ECXCLIN,ECSD1,.P1,.P2,.P3,.TOSEND,.ECXDIV)
 ..Q:TOSEND=6
 ..K LOCARR S DIC=40.7,DA=STOP,DR="1",DIQ(0)="I",DIQ="LOCARR" D EN^DIQ1
 ..S ECXSTOP=$$RJ^XLFSTR($G(LOCARR(40.7,STOP,1,"I")),3,0)
 ..; ******* - PATCH 127, ADD PATCAT CODE ********
 ..S ECXPATCAT=$$PATCAT^ECXUTL(ECXDFN)
 ..;get date specific patient data
 ..D PAT2^ECXSCX2(ECXDFN,ECXDATE)
 ..;get national patient record flag if exist
 ..D NPRF^ECXUTL5
 ..;get visit specific data
 ..S ECXERR=0 D VISIT^ECXSCX1(ECXDFN,ECXVISIT,.ECXVIST,.ECXERR) Q:ECXERR
 ..F I=1:1:8 S @("ECXCPT"_I)=$G(ECXVIST("CPT"_I))
 ..S ECXICD9P=$G(ECXVIST("ICD9P"))
 ..F I=1:1:4 S @("ECXICD9"_I)=$G(ECXVIST("ICD9"_I))
 ..S SOURCE=ECXVIST("SOURCE"),ECXAO=ECXVIST("AO"),ECXIR=ECXVIST("IR")
 ..S ECXMIL=ECXVIST("MST"),ECXPROV=ECXVIST("PROV"),ECXSHAD=ECXVIST("SHAD")
 ..S ECPRNPI=$$NPI^XUSNPI("Individual_ID",ECXPROV,ECXDATE)
 ..S:+ECPRNPI'>0 ECPRNPI="" S ECPRNPI=$P(ECPRNPI,U)
 ..S ECXPROVP=ECXVIST("PROV CLASS"),ECXPROVN=ECXVIST("PROV NPI")
 ..F I=1:1:5 S @("ECSP"_I)=$P($G(ECXVIST("PROVS"_I)),U)
 ..F I=1:1:5 S @("ECSPPC"_I)=$P($G(ECXVIST("PROVS"_I)),U,2)
 ..F I=1:1:5 S @("ECSPNPI"_I)=$P($G(ECXVIST("PROVS"_I)),U,3)
 ..S ECXECE=ECXVIST("PGE"),ECXHNC=ECXVIST("HNC")
 ..K LOCARR S DIC=8,DA=ECXENEL,DR="8",DIQ(0)="I",DIQ="LOCARR" D EN^DIQ1
 ..S ECXENEL=+$G(LOCARR(8,ECXENEL,8,"I"))
 ..S:ECXENEL ECXENEL=$$ELIG^ECXUTL3(ECXENEL,ECXSVC)
 ..S ECXCBOC=$S(MDIV'="":$$CBOC^ECXSCX2(.MDIV),1:"")  ;is cboc facility?
 ..;setup feeder key and file in extract records
 ..S (ECXKEY,ECXDSSD)=""
 ..;xray (105) or lab (108)
 ..I (ECXSTOP=105)!(ECXSTOP=108) D  Q
 ...S ECXKEY=ECXSTOP_"00003000000",ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 ...S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE       ;- Don't file rec if no encounter num
 ..;appointments
 ..I PROCESS=1 D  Q     ;get appt length
 ...S (ALEN,JJ,OUT)=0
 ...F  S JJ=$O(^SC(ECXCLIN,"S",ECXDATE,JJ)) Q:('JJ)!(OUT)  S K=0 D
 ....F  S K=$O(^SC(ECXCLIN,"S",ECXDATE,JJ,K)) Q:('K)!(OUT)  D
 .....S ECXOBI=$G(^SC(ECXCLIN,"S",ECXDATE,JJ,K,"OB")),PP=$P($G(^SC(ECXCLIN,"S",ECXDATE,JJ,K,0)),U)
 .....S:PP=ECXDFN OUT=1,ALEN=$P(^(0),U,2),ALEN=$$RJ^XLFSTR(ALEN,3,0)
 .....S:+ALEN=0 ALEN=$P($G(^TMP($J,"ECXCL",ECXCLIN)),U,2)
 ....S ECXSTOP=P1
 ....S PNODE=$G(^DPT(ECXDFN,"S",ECXDATE,0)),ECXPVST=$P(PNODE,U,7),ECXATYP=$P(PNODE,U,16)  ;Get purpose of visit & appt type
 ....I TOSEND'=3 D
 .....S ECXKEY=P1_P2_ALEN_P3_"0",ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 .....S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE
 ....I TOSEND=3 D
 .....S ECXKEY=P1_"000"_ALEN_P3_"0",ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 .....S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE
 ....I TOSEND=3 D
 .....S ECXKEY=P2_"000"_ALEN_P3_"0",ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 .....S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE
 ..I PROCESS=2 D  Q
 ...S ALEN=0
 ...I SOURCE=TIU S ALEN=$P($G(^TMP($J,"ECXCL",ECXCLIN)),U,2)
 ...S:+ALEN=0 ALEN="030" S ECXKEY=P1_P2_ALEN_P3_"0",ECXSTOP=P1
 ...S ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 ...S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE
 ..;dispositions
 ..I PROCESS=3 D  Q
 ...S ECXKEY=ECXSTOP_"47906000000",ECXOBS=$$OBSPAT^ECXUTL4(ECXA,ECXTS,ECXKEY)
 ...S ECXENC=$$ENCNUM^ECXUTL4(ECXA,ECXSSN,ECXADMDT,ECXDATE,ECXTS,ECXOBS,ECHEAD,ECXKEY,) D:ECXENC'="" FILE
 Q
 ;
FILE ;record setup for file #727.827
 N STR
 S ECXPDIV=$$GETDIV^ECXDEPT(ECXDIV)  ; Get production division
 S EC7=$O(^ECX(727.827,999999999),-1),EC7=EC7+1
 S STR(0)=EC7_U_EC23_U_ECXDIV_U_ECXDFN_U_ECXSSN_U_ECXPNM_U_ECXA_U
 S STR(0)=STR(0)_$$ECXDATE^ECXUTL(ECXDATE,ECXYM)_U_ECXKEY_U_ECXOBI_U
 ;convert specialty to PTF Code for transmission
 N ECXDATA,ECXTSC
 S ECXDATA=$$TSDATA^DGACT(42.4,+ECXTS,.ECXDATA)
 S ECXTSC=$G(ECXDATA(7))
 ;done
 S STR(0)=STR(0)_ECXCLIN_U_ECXTSC_U_ECXTI_U_ECPTTM_U_ECPTPR_U_ECCLAS_U
 S STR(0)=STR(0)_ECXPROV_U_ECXPROVP_U_ECXCPT1_U_ECXCPT2_U_ECXCPT3_U
 S STR(0)=STR(0)_ECXCPT4_U_ECXCPT5_U
 S STR(1)=ECXCPT6_U_ECXCPT7_U_ECXCPT8_U_ECXICD9P_U_ECXICD91_U_ECXICD92_U
 S STR(1)=STR(1)_ECXICD93_U_ECXICD94_U_ECXDOB_U_ECXELIG_U_ECXVET_U
 S STR(1)=STR(1)_ECXRACE_U_ECXPST_U_ECXPLOC_U_ECXRST_U_ECXIR_U_ECXAST_U
 S STR(1)=STR(1)_ECXAO_U_ECXMPI_U_ECXDSSD_U_ECXSEX_U_ECXZIP_U
 S STR(1)=STR(1)_$G(ECXPCPNP)_U_U_ECXENEL_U_ECXMST_U
 S STR(1)=STR(1)_ECXMIL_U_U_U_ECXENRL_U_ECXSTATE_U
 S STR(1)=STR(1)_ECXCNTY_U_ECASPR_U_ECCLAS2_U_U_ECXDOM_U_ECXCAT_U
 S STR(2)=ECXSTAT_U_$S(ECXLOGIC<2005:ECXPRIOR,ECXLOGIC>2010:ECXSHADI,1:"")_U_ECXPHI_U_ECXPOS_U_ECXOBS_U_ECXENC_U
 S STR(2)=STR(2)_ECXAOL_U_ECXPDIV_U_ECXATYP_U_ECXPVST_U_ECXMTST_U
 S STR(2)=STR(2)_ECXHNCI_U_ECXETH_U_ECXRC1
 I ECXLOGIC>2003 S STR(2)=STR(2)_U_ECXCBOC
 I ECXLOGIC>2004 S STR(2)=STR(2)_U_U_ECXPRIOR_ECXSBGRP_U_ECXUESTA_U_ECXPTYPE_U_ECXCVE_U_ECXCVEDT_U_ECXCVENC_U_ECXNPRFI
 I ECXLOGIC>2005 S STR(2)=STR(2)_U_ECXEST_U_ECXECE
 I ECXLOGIC>2006 S STR(2)=STR(2)_U_ECXERI_U_ECXHNC
 I ECXLOGIC>2007 S STR(2)=STR(2)_U_ECXOEF_U_ECXOEFDT_U_ECASNPI_U_ECPTNPI_U_$G(ECPRNPI)_U
 I ECXLOGIC>2009 S STR(3)=ECXCNTRY
 ;added patcat status, N3 P3
 I ECXLOGIC>2010 S STR(3)=STR(3)_U_ECXSHAD_U_ECXPATCAT
 I ECXLOGIC>2011 S STR(3)=STR(3)_U_ECSP1_U_ECSPPC1_U_ECSPNPI1_U_ECSP2_U_ECSPPC2_U_ECSPNPI2_U_ECSP3_U_ECSPPC3_U_ECSPNPI3_U_ECSP4_U_ECSPPC4_U_ECSPNPI4_U_ECSP5_U_ECSPPC5_U_ECSPNPI5
 D FILE2^ECXSCX2(727.827,EC7,.STR)
 S ECRN=ECRN+1,$P(^ECX(727.827,0),U,3)=EC7
 Q
 ;
SETUP ;set required input for ECXTRAC
 S ECHEAD="CLI"
 D ECXDEF^ECXUTL2(ECHEAD,.ECPACK,.ECGRP,.ECFILE,.ECRTN,.ECPIECE,.ECVER)
 Q
