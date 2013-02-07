GMPLHSPL ; SLC/MKB -- Problem List HS Component Driver (for export) ;09/20/12
 ;;2.0;Problem List;**260002**;Aug 25, 1994
GMTSPLST ; SLC/DJP -- Problem List HS Component Driver ;5/27/93  15:35
 ;;2.5;Health Summary;;
ACTIVE ;
 S STATUS="A" D MAIN,KILL Q
INACT S STATUS="I" D MAIN,KILL Q
ALL S STATUS="ALL" D MAIN,KILL Q
MAIN ;Driver
 D CKP^GMTSUP Q:$D(GMTSQIT)  I 'GMTSNPG D BREAK^GMTSUP
 D ^GMPLHS
 I '$D(^TMP("GMPLHS",$J)) D NOPROBS Q
 W ! D SUBHDR
 D CKP^GMTSUP Q:$D(GMTSQIT)  W !
 D WRT
 Q
 ;
KILL ;D KILL^GMPLHS
 Q
 ;
NOPROBS ;Indicates problems not on file for patient
 D CKP^GMTSUP Q:$D(GMTSQIT)
 N MSG
 D BLD^DIALOG(1250000.302,,,"MSG")
 D EN^DDIOL(.MSG)
 Q
SUBHDR ; Subheader for Problem List Component
 N NUM S NUM=GMPCOUNT S:GMPTOTAL>GMPCOUNT NUM=NUM_" of "_GMPTOTAL
 S NUM=$$EZBLD^DIALOG($S(STATUS="A":1250000.303,STATUS="I":1250000.304,1:1250000.319),NUM)
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 D EN^DDIOL(NUM,,"?56")
 D EN^DDIOL("",,"!")
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 D EN^DDIOL($$EZBLD^DIALOG(1250000.305),,"?6")
 D EN^DDIOL($$EZBLD^DIALOG(1250000.306),,"?46")
 D EN^DDIOL($$EZBLD^DIALOG(1250000.307),,"?56")
 D EN^DDIOL("",,"!")
 Q
 ;
WRT ; Writes Problem List Component
 S GMPI=0 F GMPI=0:0  S GMPI=$O(^TMP("GMPLHS",$J,STATUS,GMPI)) Q:GMPI'>0  D LINE
 Q
 ;
LINE ;Prints individual line
 D CKP^GMTSUP Q:$D(GMTSQIT)  ;I 'GMTSNPG D BREAK^GMTSUP
 N PROBLEM,TEXT,I,PROB,MAX
 S PROBLEM=$G(^TMP("GMPLHS",$J,STATUS,GMPI,0))
 S PROB=$P(PROBLEM,U,2),MAX=38 D WRAP^GMPLX(PROB,MAX,.TEXT)
 I STATUS="ALL" D EN^DDIOL($P(PROBLEM,"^",1),,"?3")
 D EN^DDIOL(TEXT(1),,"?6")
 D EN^DDIOL($P(PROBLEM,"^",3),,"?46")
 D EN^DDIOL($P(PROBLEM,"^",4),,"?56")
 D EN^DDIOL("",,"!")
 I TEXT>1 F I=2:1:TEXT D
 . D EN^DDIOL(TEXT(I),,"?8")
 . D EN^DDIOL("",,"!")
 Q
