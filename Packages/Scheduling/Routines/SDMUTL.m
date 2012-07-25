SDMUTL ;UI Utils; 06/28/2012  10:17 AM
 ;;;Scheduling;;06/28/2012;
SELECT(ROUTINE,PRMPT,FILE,FLDS,FLDOR,HLP1,HLP2,ROU1) ;
 N LNAME,Y,RETURN,R1,R2,R3,EXS
 S R1=ROUTINE_"(.LSTS)"
 S:$D(ROU1) R3=ROU1_"(.EXS)"
 S L="L",R2=ROUTINE_"(.LSTS,X)"
LS ;
 S Y=-1
 W !,PRMPT R X:$S($D(DTIME):DTIME,1:300) I "^"[X!($G(X)="") S Y=-1 Q "^"
 I X="?" D
 . D @R1
 . I $$LSTSH1(.LSTS,FILE,.FIELDS)  D
 . . I $L($G(R3))>0 D @R3 D PRINTALL(.EXS,0)
 . . D:$L(L)>0&($G(HLP1(0))'="") @HLP1(0)
 . . D PRINTALL(.LSTS,1,.FLDOR) 
 . D:$L(L)>0&($G(HLP1)'="") @HLP1
 I X?1"??".E D
 . I X="??"  D
 . . I $L($G(R3))>0 D @R3 D PRINTALL(.EXS,0)
 . . D:$L(L)>0&($G(HLP2(0))'="") @HLP2(0)
 . . D @R1 D PRINTALL(.LSTS,1,.FLDOR) D:$L(L)>0&($G(HLP2)'="") @HLP2
 E  D:X'="?"
 . D @R2
 . S Y=$$SELLST(.LSTS,X,.FLDOR)
 G:Y<0 LS I Y=0,$L(L)'>0 W " ??",! G LS
 I Y=0 D
 . I $L(X)>30!(X?.N)!($L(X)<3)!'(X'?1P.E) W " ??",! G LS
 S:Y<0 Y(1)=Y,Y="^"
 Q Y
 ;
SELLST(LSTS,X,FLDOR) ;
 N CNT,Y,MAXP,CLINE,SEL,OUT,RE
 I $D(LSTS)=0 Q -1
 S CNT=$P(LSTS(0),U,1)
 Q:CNT=0 0
 I CNT=1 W $E(LSTS(1,"NAME"),$L(X)+1,$L(LSTS(1,"NAME"))) Q LSTS(1,"ID")_U_LSTS(1,"NAME")
 S MAXP=5,CLINE=1,SEL=0,OUT=0,RE=0
 F IND=1:1:CNT  D  Q:OUT
 . S CLINE=CLINE+1,STR=""
 . I $D(FLDOR) S STR="   "_IND F FIND=1:1 S FLD=$P(FLDOR,U,FIND) Q:'$L(FLD)  S STR=STR_"   "_LSTS(IND,FLD)
 . E  S STR=$C(9)_IND_$C(9)_LSTS(IND,"NAME")
 . W !,STR
 . I CLINE>MAXP D
 . . W !,"Press <RETURN> to see more, '^' to exit this list, OR"
 . I CLINE>MAXP!(IND=CNT) D
 . . S RE=1
 . . W !,"CHOOSE 1-"_IND_": " R SEL:$S($D(DTIME):DTIME,1:300) S:'$T OUT=1 Q
 . I RE D  Q
 . . S RE=0
 . . I SEL="^" S OUT=1 Q
 . . I $G(SEL)="" S CLINE=1 Q
 . . I $G(SEL)>IND S SEL=0,OUT=1 Q
 . . E  S OUT=1 Q
 Q:SEL>0 LSTS(SEL,"ID")_U_LSTS(SEL,"NAME") Q -1
 ;
PRINTALL(LSTS,CHOOSE,FLDOR) ;
 N IND,CNT,GMPQUIT,LINE,STR,FLD,FIND
 S GMPQUIT=0,LINE=1
 I $D(LSTS)=0 Q
 S CNT=$P(LSTS(0),U,1) Q:CNT=0
 W:$G(CHOOSE) !,"   Choose from:"
 F IND=1:1:CNT D
 . S LINE=LINE+1,STR=""
 . I $D(FLDOR) F FIND=1:1 S FLD=$P(FLDOR,U,FIND) Q:'$L(FLD)  S STR=STR_"   "_LSTS(IND,FLD)
 . E  S STR="   "_LSTS(IND,"NAME")
 . W !,STR
 . I LINE>(IOSL-4) S LINE=1 S:'$$CONTINUE GMPQUIT=1 Q:$D(GMPQUIT)  Q
 W !
 Q
 ;
CONTINUE() ; -- end of page prompt
 N DIR,X,Y
 S DIR(0)="E",DIR("A")=$C(9)_"'^' TO STOP"
 D ^DIR
 Q +Y
 ;
LSTSH1(LSTS,FILE,FIELDS) ; All items ??
 N DIR,X,Y,CNT
 S CNT=$P(LSTS(0),U,1) Q:CNT=0 1
 W !," Answer with "_FILE_" "_FIELDS
 Q:CNT<(IOSL-4) 1
 S:CNT>(IOSL-4) DIR("A")=" Do you want the entire "_CNT_"-Entry "_FILE_" List"
 S DIR(0)="YO"
 D ^DIR Q Y
 ;
