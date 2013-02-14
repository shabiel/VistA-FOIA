XQALSUR2 ;FO-OAK.SEA/JLI-Continuation of alert surrogate processing ;07/24/11  15:15
 ;;8.0;KERNEL;**366,513**;Jul 10, 1995;Build 13
 ;Per VHA Directive 2004-038, this routine should not be modified
 Q
 ; added to handle adjustment for manual or Fileman editing of surrogate on top zero node
CHEKSUBS(XQAUSER) ;
 N XQA0,XQASTR1,XQANOW,XQB0,XQB1
 S XQANOW=$$NOW^XLFDT()
 S XQA0=$G(^XTV(8992,XQAUSER,0)) I $P(XQA0,U,2)>0 D
 . N XQAFDA,XQAIEN,XQADA
 . S XQASTR1=$P(XQA0,U,3) S:XQASTR1'>0 XQASTR1=XQANOW,XQAFDA(8992,XQAUSER_",",.03)=XQASTR1 D
 . . S XQADA=0 F  S XQADA=$O(^XTV(8992,XQAUSER,2,"B",XQASTR1,XQADA)) Q:XQADA'>0  Q:$P(^XTV(8992,XQAUSER,2,XQADA,0),U,2)=$P(XQA0,U,2)
 . . S XQAIEN=$S(XQADA>0:XQADA,1:"+1")_","_XQAUSER_"," S XQAFDA(8992.02,XQAIEN,.01)=XQASTR1
 . . S XQAFDA(8992.02,XQAIEN,.02)=$P(XQA0,U,2) S:$P(XQA0,U,4)>0 XQAFDA(8992.02,XQAIEN,.03)=$P(XQA0,U,4)
 . . D:XQADA'>0 UPDATE^DIE("","XQAFDA")
 . . D:XQADA>0 FILE^DIE("","XQAFDA")
 . . Q
 . Q
 Q
 ;
CHKCRIT(ZERONODE) ;EXTRINSIC - check for critical indication for alert
 ; ZERONODE - input - Value for zero node for alert data
 ; RETURN VALUE - 1 if the alert is indicated as critical
 ;                0 otherwise
 N RESULT,IEN
 S RESULT=0
 F IEN=0:0 S IEN=$O(^XTV(8992.3,IEN)) Q:IEN'>0  D  Q:RESULT
 . N IENS,RES,MSG,CRITTEXT,PKGID,ALERTTXT
 . S IENS=IEN_","
 . D GETS^DIQ(8992.3,IENS,".01:.02",,"RES","MSG")
 . S CRITTEXT=$$UP^XLFSTR(RES(8992.3,IENS,.01)),PKGID=$$UP^XLFSTR(RES(8992.3,IENS,.02))
 . I PKGID'="",$$UP^XLFSTR($P(ZERONODE,U,2))'[PKGID Q
 . S ALERTTXT=$$UP^XLFSTR($P(ZERONODE,U,3))
 . I ALERTTXT[CRITTEXT,ALERTTXT'["NOT "_CRITTEXT S RESULT=1
 Q RESULT
