GMPLSITE    ;RGI GMPL Site parameters ;02/22/12  18:19
 ;;3.0;Problem List;**
 Q  ;
 ;
GET(PARAMS) ;
 N X
 S X=$G(^GMPL(125.99,1,0))
 S PARAMS("VER")=+$P(X,"^",2)
 S PARAMS("PRT")=+$P(X,"^",3)
 S PARAMS("CLU")=+$P(X,"^",4)
 S PARAMS("REV")=$S($P(X,"^",5)="R":1,1:0)
 S PARAMS("SDP")=+$P(X,"^",3)
 Q
VERIFY()    ;
 N PARAMS
 D GET(.PARAMS)
 Q PARAMS("VER")
 ;