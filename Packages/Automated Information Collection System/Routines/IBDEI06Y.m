IBDEI06Y ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,9190,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9190,1,1,0)
 ;;=1^303.02
 ;;^UTILITY(U,$J,358.3,9190,1,2,0)
 ;;=2^AC ALC INTOX,EPISODIC
 ;;^UTILITY(U,$J,358.3,9190,2)
 ;;=^268185
 ;;^UTILITY(U,$J,358.3,9191,0)
 ;;=303.03^^69^533^3
 ;;^UTILITY(U,$J,358.3,9191,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9191,1,1,0)
 ;;=1^303.03
 ;;^UTILITY(U,$J,358.3,9191,1,2,0)
 ;;=2^AC ALC INTOX,IN REM
 ;;^UTILITY(U,$J,358.3,9191,2)
 ;;=^268186
 ;;^UTILITY(U,$J,358.3,9192,0)
 ;;=303.91^^69^533^4
 ;;^UTILITY(U,$J,358.3,9192,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9192,1,1,0)
 ;;=1^303.91
 ;;^UTILITY(U,$J,358.3,9192,1,2,0)
 ;;=2^CHR ALC DEP,CONTIN
 ;;^UTILITY(U,$J,358.3,9192,2)
 ;;=^268188
 ;;^UTILITY(U,$J,358.3,9193,0)
 ;;=303.92^^69^533^5
 ;;^UTILITY(U,$J,358.3,9193,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9193,1,1,0)
 ;;=1^303.92
 ;;^UTILITY(U,$J,358.3,9193,1,2,0)
 ;;=2^CHR ALC DEP,EPISODIC
 ;;^UTILITY(U,$J,358.3,9193,2)
 ;;=^268189
 ;;^UTILITY(U,$J,358.3,9194,0)
 ;;=303.93^^69^533^6
 ;;^UTILITY(U,$J,358.3,9194,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9194,1,1,0)
 ;;=1^303.93
 ;;^UTILITY(U,$J,358.3,9194,1,2,0)
 ;;=2^CHR ALC DEP,IN REM
 ;;^UTILITY(U,$J,358.3,9194,2)
 ;;=^268190
 ;;^UTILITY(U,$J,358.3,9195,0)
 ;;=291.1^^69^534^2
 ;;^UTILITY(U,$J,358.3,9195,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9195,1,1,0)
 ;;=1^291.1
 ;;^UTILITY(U,$J,358.3,9195,1,2,0)
 ;;=2^ALCOHOL AMNESTIC SYND
 ;;^UTILITY(U,$J,358.3,9195,2)
 ;;=^303492
 ;;^UTILITY(U,$J,358.3,9196,0)
 ;;=291.81^^69^534^4
 ;;^UTILITY(U,$J,358.3,9196,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9196,1,1,0)
 ;;=1^291.81
 ;;^UTILITY(U,$J,358.3,9196,1,2,0)
 ;;=2^ALCOHOL WITHDRAWAL
 ;;^UTILITY(U,$J,358.3,9196,2)
 ;;=^123498
 ;;^UTILITY(U,$J,358.3,9197,0)
 ;;=291.0^^69^534^1
 ;;^UTILITY(U,$J,358.3,9197,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9197,1,1,0)
 ;;=1^291.0
 ;;^UTILITY(U,$J,358.3,9197,1,2,0)
 ;;=2^ALC WITHDRAW DELIRIUM
 ;;^UTILITY(U,$J,358.3,9197,2)
 ;;=^4589
 ;;^UTILITY(U,$J,358.3,9198,0)
 ;;=291.3^^69^534^3
 ;;^UTILITY(U,$J,358.3,9198,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9198,1,1,0)
 ;;=1^291.3
 ;;^UTILITY(U,$J,358.3,9198,1,2,0)
 ;;=2^ALCOHOL HALLUCINOSIS
 ;;^UTILITY(U,$J,358.3,9198,2)
 ;;=^4562
 ;;^UTILITY(U,$J,358.3,9199,0)
 ;;=291.9^^69^534^7
 ;;^UTILITY(U,$J,358.3,9199,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9199,1,1,0)
 ;;=1^291.9
 ;;^UTILITY(U,$J,358.3,9199,1,2,0)
 ;;=2^ALC PSYCHOSIS
 ;;^UTILITY(U,$J,358.3,9199,2)
 ;;=^100586
 ;;^UTILITY(U,$J,358.3,9200,0)
 ;;=304.41^^69^535^1
 ;;^UTILITY(U,$J,358.3,9200,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9200,1,1,0)
 ;;=1^304.41
 ;;^UTILITY(U,$J,358.3,9200,1,2,0)
 ;;=2^AMPH DEP CONTINUOUS
 ;;^UTILITY(U,$J,358.3,9200,2)
 ;;=^268205
 ;;^UTILITY(U,$J,358.3,9201,0)
 ;;=304.42^^69^535^2
 ;;^UTILITY(U,$J,358.3,9201,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9201,1,1,0)
 ;;=1^304.42
 ;;^UTILITY(U,$J,358.3,9201,1,2,0)
 ;;=2^AMPH DEP EPISODIC
 ;;^UTILITY(U,$J,358.3,9201,2)
 ;;=^268206
 ;;^UTILITY(U,$J,358.3,9202,0)
 ;;=304.43^^69^535^3
 ;;^UTILITY(U,$J,358.3,9202,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9202,1,1,0)
 ;;=1^304.43
 ;;^UTILITY(U,$J,358.3,9202,1,2,0)
 ;;=2^AMPH DEP IN REMISS
 ;;^UTILITY(U,$J,358.3,9202,2)
 ;;=^268207
 ;;^UTILITY(U,$J,358.3,9203,0)
 ;;=304.31^^69^535^4
 ;;^UTILITY(U,$J,358.3,9203,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9203,1,1,0)
 ;;=1^304.31
 ;;^UTILITY(U,$J,358.3,9203,1,2,0)
 ;;=2^CANNABIS DEP CONTIN
 ;;^UTILITY(U,$J,358.3,9203,2)
 ;;=^268201
 ;;^UTILITY(U,$J,358.3,9204,0)
 ;;=304.32^^69^535^5
 ;;^UTILITY(U,$J,358.3,9204,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9204,1,1,0)
 ;;=1^304.32
 ;;^UTILITY(U,$J,358.3,9204,1,2,0)
 ;;=2^CANNABIS DEP EPISODIC
 ;;^UTILITY(U,$J,358.3,9204,2)
 ;;=^268202
 ;;^UTILITY(U,$J,358.3,9205,0)
 ;;=304.33^^69^535^6
 ;;^UTILITY(U,$J,358.3,9205,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9205,1,1,0)
 ;;=1^304.33
 ;;^UTILITY(U,$J,358.3,9205,1,2,0)
 ;;=2^CANNABIS DEP IN REMISS
 ;;^UTILITY(U,$J,358.3,9205,2)
 ;;=^268203
 ;;^UTILITY(U,$J,358.3,9206,0)
 ;;=304.21^^69^535^7
 ;;^UTILITY(U,$J,358.3,9206,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9206,1,1,0)
 ;;=1^304.21
 ;;^UTILITY(U,$J,358.3,9206,1,2,0)
 ;;=2^COCAINE DEP CONTIN
 ;;^UTILITY(U,$J,358.3,9206,2)
 ;;=^268198
 ;;^UTILITY(U,$J,358.3,9207,0)
 ;;=304.22^^69^535^8
 ;;^UTILITY(U,$J,358.3,9207,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9207,1,1,0)
 ;;=1^304.22
 ;;^UTILITY(U,$J,358.3,9207,1,2,0)
 ;;=2^COCAINE DEP EPISODIC
 ;;^UTILITY(U,$J,358.3,9207,2)
 ;;=^268199
 ;;^UTILITY(U,$J,358.3,9208,0)
 ;;=304.23^^69^535^9
 ;;^UTILITY(U,$J,358.3,9208,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9208,1,1,0)
 ;;=1^304.23
 ;;^UTILITY(U,$J,358.3,9208,1,2,0)
 ;;=2^COCAINE DEP REMISS
 ;;^UTILITY(U,$J,358.3,9208,2)
 ;;=^268200
 ;;^UTILITY(U,$J,358.3,9209,0)
 ;;=304.81^^69^535^10
 ;;^UTILITY(U,$J,358.3,9209,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9209,1,1,0)
 ;;=1^304.81
 ;;^UTILITY(U,$J,358.3,9209,1,2,0)
 ;;=2^COMB DRUG DEP CONTIN
 ;;^UTILITY(U,$J,358.3,9209,2)
 ;;=^268219
 ;;^UTILITY(U,$J,358.3,9210,0)
 ;;=304.82^^69^535^11
 ;;^UTILITY(U,$J,358.3,9210,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9210,1,1,0)
 ;;=1^304.82
 ;;^UTILITY(U,$J,358.3,9210,1,2,0)
 ;;=2^COMB DRUG DEP EPISOD
 ;;^UTILITY(U,$J,358.3,9210,2)
 ;;=^268220
 ;;^UTILITY(U,$J,358.3,9211,0)
 ;;=304.83^^69^535^12
 ;;^UTILITY(U,$J,358.3,9211,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9211,1,1,0)
 ;;=1^304.83
 ;;^UTILITY(U,$J,358.3,9211,1,2,0)
 ;;=2^COMB DRUG DEP REMISS
 ;;^UTILITY(U,$J,358.3,9211,2)
 ;;=^268221
 ;;^UTILITY(U,$J,358.3,9212,0)
 ;;=304.71^^69^535^15
 ;;^UTILITY(U,$J,358.3,9212,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9212,1,1,0)
 ;;=1^304.71
 ;;^UTILITY(U,$J,358.3,9212,1,2,0)
 ;;=2^OPIOID+OTH DEP CONTIN
 ;;^UTILITY(U,$J,358.3,9212,2)
 ;;=^268215
 ;;^UTILITY(U,$J,358.3,9213,0)
 ;;=304.72^^69^535^16
 ;;^UTILITY(U,$J,358.3,9213,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9213,1,1,0)
 ;;=1^304.72
 ;;^UTILITY(U,$J,358.3,9213,1,2,0)
 ;;=2^OPIOID+OTH DEP EPISOD
 ;;^UTILITY(U,$J,358.3,9213,2)
 ;;=^268216
 ;;^UTILITY(U,$J,358.3,9214,0)
 ;;=304.73^^69^535^17
 ;;^UTILITY(U,$J,358.3,9214,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9214,1,1,0)
 ;;=1^304.73
 ;;^UTILITY(U,$J,358.3,9214,1,2,0)
 ;;=2^OPIOID+OTH DEP REMISS
 ;;^UTILITY(U,$J,358.3,9214,2)
 ;;=^268217
 ;;^UTILITY(U,$J,358.3,9215,0)
 ;;=304.01^^69^535^13
 ;;^UTILITY(U,$J,358.3,9215,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9215,1,1,0)
 ;;=1^304.01
 ;;^UTILITY(U,$J,358.3,9215,1,2,0)
 ;;=2^OPIOID DEP CONT
 ;;^UTILITY(U,$J,358.3,9215,2)
 ;;=^268191
 ;;^UTILITY(U,$J,358.3,9216,0)
 ;;=304.03^^69^535^14
 ;;^UTILITY(U,$J,358.3,9216,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9216,1,1,0)
 ;;=1^304.03
 ;;^UTILITY(U,$J,358.3,9216,1,2,0)
 ;;=2^OPIOID DEP IN REM
 ;;^UTILITY(U,$J,358.3,9216,2)
 ;;=^268193
 ;;^UTILITY(U,$J,358.3,9217,0)
 ;;=304.10^^69^535^19
 ;;^UTILITY(U,$J,358.3,9217,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9217,1,1,0)
 ;;=1^304.10
 ;;^UTILITY(U,$J,358.3,9217,1,2,0)
 ;;=2^SED HYP ANX DEP
 ;;^UTILITY(U,$J,358.3,9217,2)
 ;;=^268194
 ;;^UTILITY(U,$J,358.3,9218,0)
 ;;=304.02^^69^535^18
 ;;^UTILITY(U,$J,358.3,9218,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9218,1,1,0)
 ;;=1^304.02
 ;;^UTILITY(U,$J,358.3,9218,1,2,0)
 ;;=2^Opioid Dep Episodic
 ;;^UTILITY(U,$J,358.3,9218,2)
 ;;=^268192
 ;;^UTILITY(U,$J,358.3,9219,0)
 ;;=292.0^^69^536^1
 ;;^UTILITY(U,$J,358.3,9219,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9219,1,1,0)
 ;;=1^292.0
 ;;^UTILITY(U,$J,358.3,9219,1,2,0)
 ;;=2^DRUG WITHDRAWAL SYND
 ;;^UTILITY(U,$J,358.3,9219,2)
 ;;=^265197
 ;;^UTILITY(U,$J,358.3,9220,0)
 ;;=292.83^^69^536^2
 ;;^UTILITY(U,$J,358.3,9220,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9220,1,1,0)
 ;;=1^292.83
 ;;^UTILITY(U,$J,358.3,9220,1,2,0)
 ;;=2^DRUG AMNESTIC SYNDROME
 ;;^UTILITY(U,$J,358.3,9220,2)
 ;;=^268027
 ;;^UTILITY(U,$J,358.3,9221,0)
 ;;=292.81^^69^536^3
 ;;^UTILITY(U,$J,358.3,9221,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9221,1,1,0)
 ;;=1^292.81
 ;;^UTILITY(U,$J,358.3,9221,1,2,0)
 ;;=2^DRUG INDUCED DELIRIUM
 ;;^UTILITY(U,$J,358.3,9221,2)
 ;;=^268022
 ;;^UTILITY(U,$J,358.3,9222,0)
 ;;=292.82^^69^536^4
 ;;^UTILITY(U,$J,358.3,9222,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9222,1,1,0)
 ;;=1^292.82
 ;;^UTILITY(U,$J,358.3,9222,1,2,0)
 ;;=2^DRUG INDUCED DEMENTIA
 ;;^UTILITY(U,$J,358.3,9222,2)
 ;;=^268025
 ;;^UTILITY(U,$J,358.3,9223,0)
 ;;=292.12^^69^536^5
 ;;^UTILITY(U,$J,358.3,9223,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9223,1,1,0)
 ;;=1^292.12
 ;;^UTILITY(U,$J,358.3,9223,1,2,0)
 ;;=2^DRUG HALLUCINOSIS
 ;;^UTILITY(U,$J,358.3,9223,2)
 ;;=^268019
 ;;^UTILITY(U,$J,358.3,9224,0)
 ;;=292.84^^69^536^6
 ;;^UTILITY(U,$J,358.3,9224,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9224,1,1,0)
 ;;=1^292.84
 ;;^UTILITY(U,$J,358.3,9224,1,2,0)
 ;;=2^DRUG DEPRESSIVE SYND
 ;;^UTILITY(U,$J,358.3,9224,2)
 ;;=^268030
 ;;^UTILITY(U,$J,358.3,9225,0)
 ;;=292.11^^69^536^7
 ;;^UTILITY(U,$J,358.3,9225,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9225,1,1,0)
 ;;=1^292.11
 ;;^UTILITY(U,$J,358.3,9225,1,2,0)
 ;;=2^DRUG PARANOID STATE
 ;;^UTILITY(U,$J,358.3,9225,2)
 ;;=^268017
 ;;^UTILITY(U,$J,358.3,9226,0)
 ;;=292.89^^69^536^8
 ;;^UTILITY(U,$J,358.3,9226,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9226,1,1,0)
 ;;=1^292.89
 ;;^UTILITY(U,$J,358.3,9226,1,2,0)
 ;;=2^DRUG MENTAL DISORDER
 ;;^UTILITY(U,$J,358.3,9226,2)
 ;;=^268021
 ;;^UTILITY(U,$J,358.3,9227,0)
 ;;=292.2^^69^536^9
 ;;^UTILITY(U,$J,358.3,9227,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9227,1,1,0)
 ;;=1^292.2
 ;;^UTILITY(U,$J,358.3,9227,1,2,0)
 ;;=2^PATHOLOGIC DRUG INTOX
 ;;^UTILITY(U,$J,358.3,9227,2)
 ;;=^265199
 ;;^UTILITY(U,$J,358.3,9228,0)
 ;;=300.6^^69^537^1
 ;;^UTILITY(U,$J,358.3,9228,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,9228,1,1,0)
 ;;=1^300.6
 ;;^UTILITY(U,$J,358.3,9228,1,2,0)
 ;;=2^DEPERSONALIZATION SYND
