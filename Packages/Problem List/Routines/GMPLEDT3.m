GMPLEDT3 ; SLC/MKB/KER -- Problem List edit utilities ; 09/13/12
 ;;2.0;Problem List;**26,35,260002**;Aug 25, 1994
 ;
 ; External References
 ;   DBIA   872  ^ORD(101
 ;   DBIA 10026  ^XUSEC("GMPL ICD CODE"
 ;   DBIA 10015  EN^DIQ1
 ;   DBIA 10026  ^DIR
 ;   DBIA 10104  $$UP^XLFSTR
 ;                     
MSG() ; List Manager Message Bar
 Q "Enter the number of the item(s) you wish to change"
 ;
KEYS ; Setup XQORM("KEY") array
 ;   Numbers ref'd also in IN4^-EDIT, NTES^-EDT4
 N I,PROTCL,NUM,ICD
 S ICD=$$HASKEY^GMPLEXT("GMPL ICD CODE")
 S XQORM("KEY","1")=$O(^ORD(101,"B","GMPL EDIT REFORMULATE",0))_"^1"
 S XQORM("KEY","2")=$O(^ORD(101,"B","GMPL EDIT ONSET",0))_"^1"
 S XQORM("KEY","3")=$O(^ORD(101,"B","GMPL EDIT STATUS",0))_"^1"
 S XQORM("KEY","4")=$O(^ORD(101,"B","GMPL EDIT PROVIDER",0))_"^1"
 S XQORM("KEY","5")=$O(^ORD(101,"B","GMPL EDIT SERVICE",0))_"^1",NUM=5
 S:ICD XQORM("KEY","6")=$O(^ORD(101,"B","GMPL EDIT ICD",0))_"^1",NUM=6
 I GMPVA D
 . S NUM=NUM+1,XQORM("KEY",NUM)=$O(^ORD(101,"B","GMPL EDIT SC",0))_"^1"
 . S NUM=NUM+1,XQORM("KEY",NUM)=$O(^ORD(101,"B","GMPL EDIT SP",0))_"^1"
 S PROTCL=$O(^ORD(101,"B","GMPL EDIT NOTES",0))_"^1"
 I GMPFLD(10,0) F I=1:1:GMPFLD(10,0) S NUM=NUM+1,XQORM("KEY",NUM)=PROTCL
 S XQORM("KEY",NUM+1)=$O(^ORD(101,"B","GMPL EDIT NEW NOTE",0))_"^1"
 S:$G(GMPARAM("VER"))&$D(GMPLUSER) XQORM("KEY","$")=$O(^ORD(101,"B","GMPL EDIT VERIFY",0))_"^1"
 S XQORM("KEY","=")=$O(^ORD(101,"B","VALM NEXT SCREEN",0))_"^1"
 S VALMSG=$$MSG
 Q
 ;
GETFLDS(DA) ; Define GMPFLD(#) and GMPORIG(#) Arrays with Current Values
 N MGR
 K GMPORIG,GMPFLD
 S MGR=($D(GMPLMGR)>0)
 I '$$DETAIL^GMPLAPI2(.GMPORIG,DA,MGR,$G(GMPROV)) K GMPORIG Q
 M GMPFLD=GMPORIG
 Q
 ;
FLDS ; Define GMPFLD("FLD") Array for Editing
 S (GMPFLD("FLD",2),GMPFLD("FLD",6),GMPFLD("FLD",7))="Q"
 S GMPFLD("FLD",1)="TERM",GMPFLD("FLD","PROBLEM")=1
 S:$$HASKEY^GMPLEXT("GMPL ICD CODE") GMPFLD("FLD",2)="ICD",GMPFLD("FLD","ICD CODE")=2
 S GMPFLD("FLD",3)="NOTE",GMPFLD("FLD","COMMENT")=3
 S GMPFLD("FLD",4)="ONSET",GMPFLD("FLD","DATE OF ONSET")=4
 S GMPFLD("FLD",5)="STATUS",GMPFLD("FLD","STATUS")=5
 S:GMPSC GMPFLD("FLD",6)="SC",GMPFLD("FLD","IS THIS PROBLEM RELATED TO A SERVICE-CONNECTED CONDITION?")=6
 S:GMPAGTOR GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO AGENT ORANGE EXPOSURE?")=7
 S:GMPION GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO RADIATION EXPOSURE?")=7
 S:GMPGULF GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO ENVIRONMENTAL CONTAMINANTS EXPOSURE?")=7
 S:GMPHNC GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO DIAGNOSED HEAD AND/OR NECK CANCER?")=7
 S:GMPMST GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO REPORTED MILITARY SEXUAL TRAUMA?")=7
 S:GMPCV GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO REPORTED COMBAT VET?")=7
 S:GMPSHD GMPFLD("FLD",7)="SP",GMPFLD("FLD","IS THIS PROBLEM RELATED TO REPORTED SHIPBOARD HAZARD AND DEFENSE?")=7
 S GMPFLD("FLD",8)="PROV",GMPFLD("FLD","RESPONSIBLE PROVIDER")=8
 S GMPFLD("FLD",9)="SOURCE"
 S:$E(GMPLVIEW("VIEW"))="C" GMPFLD("FLD","CLINIC")=9
 S:$E(GMPLVIEW("VIEW"))'="C" GMPFLD("FLD","SERVICE")=9
 S GMPFLD("FLD",10)="RECORDED",GMPFLD("FLD","DATE RECORDED")=10
 S GMPFLD("FLD",11)="AUTHOR",GMPFLD("FLD","RECORDING PROVIDER")=11
 S GMPFLD("FLD",0)=11
 Q
 ;
JUMP(XFLD) ; Resolve ^- Jump Out of Field Order in Edit
 N I,MATCH,CNT,PROMPT,DIR,X,Y
 ;   Passed in as ^XXX
 S XFLD=$$UP^XLFSTR($P(XFLD,U,2))
 I (XFLD="")!(XFLD["^") S GMPQUIT=1 Q
 I '$D(GMPLJUMP) W $C(7),"  ^-jumping not allowed now!" S GMPLJUMP=0 Q
 ;   Field is Exact
 I $G(GMPFLD("FLD",XFLD)) S GMPLJUMP=GMPFLD("FLD",XFLD) Q
 S CNT=0,PROMPT=" "
 F  S PROMPT=$O(GMPFLD("FLD",PROMPT)) Q:PROMPT=""  D
 . Q:$E(PROMPT,1,$L(XFLD))'=XFLD
 . S CNT=CNT+1,MATCH(CNT)=GMPFLD("FLD",PROMPT)_U_PROMPT
 I CNT=0 W $C(7),"  ??" Q
 I CNT=1 S PROMPT=$P(MATCH(1),U,2),GMPLJUMP=+MATCH(1) W $E(PROMPT,$L(XFLD)+1,$L(PROMPT)) Q
 ;   Select which Field to Jump To.
 F I=1:1:CNT S DIR("A",I)=I_"  "_$P(MATCH(I),U,2)
 S DIR("A")="Select 1-"_CNT_": ",DIR(0)="NAO^1:"_CNT
 S DIR("?")="Select the field you wish to jump to, by number"
 D ^DIR I $D(DTOUT)!($D(DUOUT))!(Y="") Q
 S GMPLJUMP=+MATCH(+Y)
 Q
 ;
CK ; Check whether to Stop Processing
 ;   Called from Exit Action of GMPL EDIT XXX Protocols
 S:$D(GMPQUIT) XQORPOP=1 S:'$D(GMPQUIT) GMPREBLD=1 K GMPQUIT
 I $D(DTOUT)!($G(VALMBCK)="Q") S VALMBCK="Q" Q
 S VALMBCK="R",VALMSG=$$MSG
 Q
