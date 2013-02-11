PRC5B4 ;WISC/PLT-COLLECT ACTIVE P.O. ORDER F.O.B. ; 10/14/94  12:30 PM
V ;;5.0;IFCAP;;4/21/95
 QUIT  ;invalid entry
 ;
EN ;START SENDING P.O. AND FOB TO FMS
 N A,PRCDUZ
 D EN^DDIOL("This task is going to send all active purchase orders dated")
 D EN^DDIOL("after 12/31/1988 to FMS with F.O.B. data only.")
 D EN^DDIOL("Please schedule this task one day before your site IFCAP V5 INSTALLATION")
 D EN^DDIOL(" ")
 S PRCDUZ=DUZ
 S A=$$TASK^PRC0B2("EN1^PRC5B4~IFCAP V5 sending purchase order F.O.B. data to FMS","PRCDUZ",1)
 I A<1 D EN^DDIOL("Submit to the Task Manager fails, try later!") G EXIT
 D EN^DDIOL("Task number "_$P(A,"^",1)_" assigned with schedule date/time: "_$P($$DT^PRC0B2($P(A,"^",2),"H"),"^",4))
 G EXIT
 ;
EN1 ;entry from task manager
 N PRCRI,PRCA,PRCB,PRCC,PRCD,PRCFOB,PRCE,PRCRE,PRCSTN,PRCF,PRCPOD
 N PRCST,PRCDT,PRCCT,PRCNT
 N A
 D:'$D(ZTQUEUED) EN^DDIOL("START SENDING P.O. AND F.O.B TO FMS")
 S PRCNT=0,PRCSTN=$O(^PRC(411,0)),PRCSTN=$E(PRCSTN+1000,2,999)
 S A=$$DT^PRC0B2("N","E","S"),A=$P(A,"^"),B=$P(A,".",2)
 S PRCDT=$P(A,".",1)+17000000_"^"_$E(B+1000000,2,999)
 S PRCCT="CTL^IFC^FMS^"_PRCSTN_"^FOB^^^^^"_PRCDT_"^001^001^001^~"
 S $P(PRCCT,"^",6)=$J("",2),$P(PRCCT,"^",7)=$J("",4)
 S $P(PRCCT,"^",8)=$J("",6),$P(PRCCT,"^",9)=$J("",11)
 S PRCPOD=2890000,PRCE=0
 F  S PRCPOD=$O(^PRC(442,"AB",PRCPOD)) Q:PRCPOD>2999999!'PRCPOD  D
 . S PRCRI(442)=0
 . F  S PRCRI(442)=$O(^PRC(442,"AB",PRCPOD,PRCRI(442))) Q:'PRCRI(442)  S A=$G(^PRC(442,PRCRI(442),0)) I A]"" D:$P(A,"^",2)'=21
 .. S PRCST=$P($G(^PRC(442,PRCRI(442),7)),"^"),PRCST="/"_PRCST_"/",PRCFOB=$P($G(^(1)),"^",6)
 .. QUIT:"/6/7/25/26/30/31/35/36/42/43/"'[PRCST
 .. S A=$P(A,"^",1),A=$E($P(A,"-")+1000,2,999)_$P(A,"-",2,999)
 .. S PRCF="FOB^"_A_"^"_PRCFOB_"^~{"
 .. W:'$D(ZTQUEUED) !,PRCF,"   ",PRCE,"   ",PRCRI(442),"   ",PRCPOD
 .. D MM S PRCNT=PRCNT+1
 .. QUIT
 . QUIT
 D MMEND
 D:'$D(ZTQUEUED)
 . D EN^DDIOL("FOB TOTAL RECORD SENT: "_PRCNT)
 . D EN^DDIOL("END SENDING P.O. AND F.O.B")
 . QUIT
 D
 . N X,Y
 . S X(1)="TOTAL IFCAP V5 FOB RECORDS SENT TO FMS: "_PRCNT
 . S Y(.5)="",Y(PRCDUZ)=""
 . D MM^PRC0B2("IFCAP V5 INSTALLATION FOB RECORD COUNT^TASK MANAGER","X(",.Y)
 . QUIT
EXIT K PRCDUZ QUIT
 ;
MM ;send to mailman
 N A,B
 I PRCE=0 D
 . S XMSUB="IFCAP V5 FOB DOCUMENTS",XMDUZ="IFCAP V5 INSTALLATION"
 . D XMZ^XMA2
 . QUIT
 S PRCE=PRCE+1
 S ^XMB(3.9,XMZ,2,PRCE,0)=PRCCT
 S PRCE=PRCE+1
 S ^XMB(3.9,XMZ,2,PRCE,0)=PRCF
 D MMEND:PRCE>500
 QUIT
 ;
MMEND ;end of message
 QUIT:'PRCE
 S XMDUN="IFCAP V5 INSTALLATION"
 S ^XMB(3.9,XMZ,2,0)="^3.92A^"_PRCE_"^"_PRCE_"^"_DT
 S XMY("XXX@Q-FMZ.DOMAIN.EXT")=""
 D ENT1^XMD
 S PRCE=0
 QUIT
 ;
