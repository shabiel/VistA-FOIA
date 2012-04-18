GMPLBLDF ; SLC/MKB -- Build Problem Selection List from IB Enc Form ;5/12/94  10:26
 ;;2.0;Problem List;;Aug 25, 1994
EN ; Start here.
 S X="IBDF18" X ^%ZOSF("TEST") I '$T D  Q
 . W !!,">>>  The IB Encounter Form utility is not available.",!
EN0 S GMPLFORM=$$GETFORM^IBDF18 G:'GMPLFORM EXIT
 W !,"Searching for the problems ..."
 S X=$$COPYFORM^IBDF18(+GMPLFORM,"GMPL"),GMPL(0)=X
 I 'X W !!,"No problems found.  Please select another form.",! G EN0
EN1 ; Create list to copy problems into
 S DIR(0)="FA^3:30",DIR("A")="LIST NAME: "
 N RETURN
 D GETLIST^GMPLAPI1(.RETURN,$P(GMPLFORM,U,2))
 M ^TMP("GMPLLIST",$J)=RETURN
 S:'RETURN DIR("B")=$P(GMPLFORM,U,2)
 S DIR("?",1)="Enter the name you wish to give this list; use meaningful"
 S DIR("?")="text, as it will be used as a title when presenting this list."
 W !!,">>>  Please create a new selection list in which to store these problems:"
EN2 D ^DIR G:$D(DUOUT)!($D(DTOUT)) EXIT
 N ERR,CLINIC K ^TMP("GMPLLIST",$J)
 S ERR=$$NEWLST^GMPLAPI1(.RETURN,Y)
 I ERR=0,$P(RETURN(0),U,1)="LISTXST" W $C(7),!,"There is already a list by this name!",! G EN2
 I RETURN'>0 W !!,"ERROR -- Cannot create new list!",$C(7) G EXIT
 S GMPLSLST=RETURN
 S CLINIC=$$CLINIC^GMPLBLD3
 I CLINIC D ADDLOC^GMPLAPI5(.RETURN,GMPLSLST,CLINIC)
EN3 ; Here we go ...
 W !!,"Copying problems from "_$P(GMPLFORM,U,2)_" form into "
 W:(42+$L($P(GMPLFORM,U,2))+$L($P(GMPLSLST,U,2))>80) !
 W $P(GMPLSLST,U,2)_" list ..."
 N RET,GSEQ,PSEG,NSEQ,GMPLI,GHDR,ITEM,SOURCE
 S (GSEQ,PSEQ,GMPLI)=0,GHDR="" S:'+GMPL(1) GHDR=$P(GMPL(1),U,2),GMPLI=1
 K ^TMP("GMPLIST",$J),^TMP("GMPGRP",$J)
 S GSEQ=GSEQ+1,GMPLGRP=$$NEWGRP(GMPLFORM,GHDR,GSEQ)
 F  S GMPLI=$O(GMPL(GMPLI)) Q:GMPLI'>0  D
 . S ITEM=$G(GMPL(GMPLI)) Q:'$L(ITEM)
 . I '+ITEM D  Q
 . . K SOURCE M SOURCE=^TMP("GMPGRP",$J)
 . . D SAVGRP^GMPLAPI1(.RET,+GMPLGRP,.SOURCE)
 . . K ^TMP("GMPGRP",$J)
 . . S GSEQ=GSEQ+1,PSEQ=0,GMPLGRP=$$NEWGRP(GMPLFORM,$P(ITEM,U,2),GSEQ)
 . S PSEQ=PSEQ+1,ITEM=PSEQ_U_ITEM
 . S NSEQ=$E("0000",1,4-$L(PSEQ))_PSEQ_"N"
 . S ^TMP("GMPGRP",$J,NSEQ)=ITEM W "."
 K SOURCE M SOURCE=^TMP("GMPGRP",$J)
 D SAVGRP^GMPLAPI1(.RET,+GMPLGRP,.SOURCE)
 K SOURCE M SOURCE=^TMP("GMPLIST",$J)
 D SAVLST^GMPLAPI1(.RET,+GMPLSLST,.SOURCE)
 K ^TMP("GMPLIST",$J),^TMP("GMPGRP",$J)
 W " <done>"
EXIT ; Clean-up
 K GMPL,GMPLSLST,GMPLGRP,GMPLI,GMPLFORM,GHDR,GSEQ,PSEQ,NSEQ,ITEM
 Q
 ;
NEWGRP(FORM,HDR,SEQ) ; Create new group entries in #125.1 and #125.11
 N RETURN,NAME,ANAME,GRP,ITEM,NSEQ
 S ANAME=$E($P(FORM,U,2),1,23-$L(SEQ))_" GROUP "_SEQ
 I $L(HDR) S NAME=$$UP^XLFSTR(HDR) E  S NAME=ANAME
 D NEWCAT^GMPLAPI1(.RETURN,NAME)
 I RETURN=0 S NAME=ANAME D NEWCAT^GMPLAPI1(.RETURN,NAME,1)
 S ITEM=SEQ_U_+RETURN_U_HDR_"^1",NSEQ=$E("0000",1,4-$L(SEQ))_SEQ_"N"
 S ^TMP("GMPLIST",$J,NSEQ)=ITEM
NGQ S GRP=$P(RETURN,U,1,2)
 Q GRP
 ;
