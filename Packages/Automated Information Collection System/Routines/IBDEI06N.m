IBDEI06N ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,8757,1,5,0)
 ;;=5^Anorexia Nervosa
 ;;^UTILITY(U,$J,358.3,8757,2)
 ;;=^7942
 ;;^UTILITY(U,$J,358.3,8758,0)
 ;;=307.51^^63^492^2
 ;;^UTILITY(U,$J,358.3,8758,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8758,1,2,0)
 ;;=2^307.51
 ;;^UTILITY(U,$J,358.3,8758,1,5,0)
 ;;=5^Bulemia
 ;;^UTILITY(U,$J,358.3,8758,2)
 ;;=^17407
 ;;^UTILITY(U,$J,358.3,8759,0)
 ;;=307.50^^63^492^3
 ;;^UTILITY(U,$J,358.3,8759,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8759,1,2,0)
 ;;=2^307.50
 ;;^UTILITY(U,$J,358.3,8759,1,5,0)
 ;;=5^Eating Disorder, NOS
 ;;^UTILITY(U,$J,358.3,8759,2)
 ;;=^37864
 ;;^UTILITY(U,$J,358.3,8760,0)
 ;;=333.99^^63^493^3
 ;;^UTILITY(U,$J,358.3,8760,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8760,1,2,0)
 ;;=2^333.99
 ;;^UTILITY(U,$J,358.3,8760,1,5,0)
 ;;=5^Acute Akathisia
 ;;^UTILITY(U,$J,358.3,8760,2)
 ;;=^303698
 ;;^UTILITY(U,$J,358.3,8761,0)
 ;;=332.0^^63^493^1
 ;;^UTILITY(U,$J,358.3,8761,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8761,1,2,0)
 ;;=2^332.0
 ;;^UTILITY(U,$J,358.3,8761,1,5,0)
 ;;=5^Parkinsonism
 ;;^UTILITY(U,$J,358.3,8761,2)
 ;;=^304847
 ;;^UTILITY(U,$J,358.3,8762,0)
 ;;=333.79^^63^493^2
 ;;^UTILITY(U,$J,358.3,8762,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8762,1,2,0)
 ;;=2^333.79
 ;;^UTILITY(U,$J,358.3,8762,1,5,0)
 ;;=5^Acute Dystonia
 ;;^UTILITY(U,$J,358.3,8762,2)
 ;;=^334068
 ;;^UTILITY(U,$J,358.3,8763,0)
 ;;=333.85^^63^493^4
 ;;^UTILITY(U,$J,358.3,8763,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,8763,1,2,0)
 ;;=2^333.85
 ;;^UTILITY(U,$J,358.3,8763,1,5,0)
 ;;=5^Tardive Dyskinesia
 ;;^UTILITY(U,$J,358.3,8763,2)
 ;;=^334069
 ;;^UTILITY(U,$J,358.3,8764,0)
 ;;=90805^^64^494^5^^^^1
 ;;^UTILITY(U,$J,358.3,8764,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8764,1,2,0)
 ;;=2^90805
 ;;^UTILITY(U,$J,358.3,8764,1,3,0)
 ;;=3^Psychotherapy w/E&M 20-30 min-VERA
 ;;^UTILITY(U,$J,358.3,8765,0)
 ;;=90807^^64^494^7^^^^1
 ;;^UTILITY(U,$J,358.3,8765,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8765,1,2,0)
 ;;=2^90807
 ;;^UTILITY(U,$J,358.3,8765,1,3,0)
 ;;=3^Psychotherapy w/E&M, 45-50 min-VERA
 ;;^UTILITY(U,$J,358.3,8766,0)
 ;;=90809^^64^494^6^^^^1
 ;;^UTILITY(U,$J,358.3,8766,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8766,1,2,0)
 ;;=2^90809
 ;;^UTILITY(U,$J,358.3,8766,1,3,0)
 ;;=3^Psychotherapy w/E&M 75-80 min-VERA
 ;;^UTILITY(U,$J,358.3,8767,0)
 ;;=90862^^64^494^4^^^^1
 ;;^UTILITY(U,$J,358.3,8767,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8767,1,2,0)
 ;;=2^90862
 ;;^UTILITY(U,$J,358.3,8767,1,3,0)
 ;;=3^Medication Management w/o Psychotherapy
 ;;^UTILITY(U,$J,358.3,8768,0)
 ;;=90813^^64^494^2^^^^1
 ;;^UTILITY(U,$J,358.3,8768,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8768,1,2,0)
 ;;=2^90813
 ;;^UTILITY(U,$J,358.3,8768,1,3,0)
 ;;=3^Intac Psytx w/E&M45-50min-VERA
 ;;^UTILITY(U,$J,358.3,8769,0)
 ;;=90815^^64^494^3^^^^1
 ;;^UTILITY(U,$J,358.3,8769,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8769,1,2,0)
 ;;=2^90815
 ;;^UTILITY(U,$J,358.3,8769,1,3,0)
 ;;=3^Intac Psytx w/E&M75-80min-VERA
 ;;^UTILITY(U,$J,358.3,8770,0)
 ;;=90811^^64^494^1^^^^1
 ;;^UTILITY(U,$J,358.3,8770,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8770,1,2,0)
 ;;=2^90811
 ;;^UTILITY(U,$J,358.3,8770,1,3,0)
 ;;=3^Intac Psytx w/ E&M 20-30 min
 ;;^UTILITY(U,$J,358.3,8771,0)
 ;;=90804^^64^495^1^^^^1
 ;;^UTILITY(U,$J,358.3,8771,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8771,1,2,0)
 ;;=2^90804
 ;;^UTILITY(U,$J,358.3,8771,1,3,0)
 ;;=3^Psychotherapy, 20-30 min
 ;;^UTILITY(U,$J,358.3,8772,0)
 ;;=90806^^64^495^2^^^^1
 ;;^UTILITY(U,$J,358.3,8772,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8772,1,2,0)
 ;;=2^90806
 ;;^UTILITY(U,$J,358.3,8772,1,3,0)
 ;;=3^Psychotherapy, 45-50 min
 ;;^UTILITY(U,$J,358.3,8773,0)
 ;;=90808^^64^495^3^^^^1
 ;;^UTILITY(U,$J,358.3,8773,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8773,1,2,0)
 ;;=2^90808
 ;;^UTILITY(U,$J,358.3,8773,1,3,0)
 ;;=3^Psychotherapy, 75-80 min
 ;;^UTILITY(U,$J,358.3,8774,0)
 ;;=90853^^64^495^4^^^^1
 ;;^UTILITY(U,$J,358.3,8774,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8774,1,2,0)
 ;;=2^90853
 ;;^UTILITY(U,$J,358.3,8774,1,3,0)
 ;;=3^Group Psychotherapy
 ;;^UTILITY(U,$J,358.3,8775,0)
 ;;=90846^^64^495^5^^^^1
 ;;^UTILITY(U,$J,358.3,8775,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8775,1,2,0)
 ;;=2^90846
 ;;^UTILITY(U,$J,358.3,8775,1,3,0)
 ;;=3^Family Psychotherapy w/o pt.
 ;;^UTILITY(U,$J,358.3,8776,0)
 ;;=90847^^64^495^6^^^^1
 ;;^UTILITY(U,$J,358.3,8776,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8776,1,2,0)
 ;;=2^90847
 ;;^UTILITY(U,$J,358.3,8776,1,3,0)
 ;;=3^Family Psychotherpy w/pt.
 ;;^UTILITY(U,$J,358.3,8777,0)
 ;;=90875^^64^495^8^^^^1
 ;;^UTILITY(U,$J,358.3,8777,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8777,1,2,0)
 ;;=2^90875
 ;;^UTILITY(U,$J,358.3,8777,1,3,0)
 ;;=3^with Biofeedback, 20-30 min
 ;;^UTILITY(U,$J,358.3,8778,0)
 ;;=90876^^64^495^9^^^^1
 ;;^UTILITY(U,$J,358.3,8778,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8778,1,2,0)
 ;;=2^90876
 ;;^UTILITY(U,$J,358.3,8778,1,3,0)
 ;;=3^with Biofeedback, 45-50 min
 ;;^UTILITY(U,$J,358.3,8779,0)
 ;;=90899^^64^496^9^^^^1
 ;;^UTILITY(U,$J,358.3,8779,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8779,1,2,0)
 ;;=2^90899
 ;;^UTILITY(U,$J,358.3,8779,1,3,0)
 ;;=3^NOS Psych Service
 ;;^UTILITY(U,$J,358.3,8780,0)
 ;;=90801^^64^496^4^^^^1
 ;;^UTILITY(U,$J,358.3,8780,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8780,1,2,0)
 ;;=2^90801
 ;;^UTILITY(U,$J,358.3,8780,1,3,0)
 ;;=3^Complete Diagnostic Interview
 ;;^UTILITY(U,$J,358.3,8781,0)
 ;;=J1631^^64^496^5^^^^1
 ;;^UTILITY(U,$J,358.3,8781,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8781,1,2,0)
 ;;=2^J1631
 ;;^UTILITY(U,$J,358.3,8781,1,3,0)
 ;;=3^Haldol, per 50 mg
 ;;^UTILITY(U,$J,358.3,8782,0)
 ;;=J2680^^64^496^13^^^^1
 ;;^UTILITY(U,$J,358.3,8782,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8782,1,2,0)
 ;;=2^J2680
 ;;^UTILITY(U,$J,358.3,8782,1,3,0)
 ;;=3^Prolixin, per 25mg
 ;;^UTILITY(U,$J,358.3,8783,0)
 ;;=97545^^64^496^21^^^^1
 ;;^UTILITY(U,$J,358.3,8783,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8783,1,2,0)
 ;;=2^97545
 ;;^UTILITY(U,$J,358.3,8783,1,3,0)
 ;;=3^Work Therapy, Init 2 hrs
 ;;^UTILITY(U,$J,358.3,8784,0)
 ;;=97546^^64^496^20^^^^1
 ;;^UTILITY(U,$J,358.3,8784,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8784,1,2,0)
 ;;=2^97546
 ;;^UTILITY(U,$J,358.3,8784,1,3,0)
 ;;=3^Work Ther, addl hrs after 2
 ;;^UTILITY(U,$J,358.3,8785,0)
 ;;=97537^^64^496^3^^^^1
 ;;^UTILITY(U,$J,358.3,8785,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8785,1,2,0)
 ;;=2^97537
 ;;^UTILITY(U,$J,358.3,8785,1,3,0)
 ;;=3^Community/Work Reintegration per 15 min
 ;;^UTILITY(U,$J,358.3,8786,0)
 ;;=97532^^64^496^2^^^^1
 ;;^UTILITY(U,$J,358.3,8786,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8786,1,2,0)
 ;;=2^97532
 ;;^UTILITY(U,$J,358.3,8786,1,3,0)
 ;;=3^Cognitive Sk Dev (PhD/OT)per 15min
 ;;^UTILITY(U,$J,358.3,8787,0)
 ;;=97533^^64^496^16^^^^1
 ;;^UTILITY(U,$J,358.3,8787,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8787,1,2,0)
 ;;=2^97533
 ;;^UTILITY(U,$J,358.3,8787,1,3,0)
 ;;=3^Sensory Intetgrat per 15 min
 ;;^UTILITY(U,$J,358.3,8788,0)
 ;;=97535^^64^496^1^^^^1
 ;;^UTILITY(U,$J,358.3,8788,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8788,1,2,0)
 ;;=2^97535
 ;;^UTILITY(U,$J,358.3,8788,1,3,0)
 ;;=3^ADL Train per 15 min
 ;;^UTILITY(U,$J,358.3,8789,0)
 ;;=H0004^^64^496^6^^^^1
 ;;^UTILITY(U,$J,358.3,8789,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8789,1,2,0)
 ;;=2^H0004
 ;;^UTILITY(U,$J,358.3,8789,1,3,0)
 ;;=3^Ind Counseling, per 15 min
 ;;^UTILITY(U,$J,358.3,8790,0)
 ;;=H0046^^64^496^12^^^^1
 ;;^UTILITY(U,$J,358.3,8790,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8790,1,2,0)
 ;;=2^H0046
 ;;^UTILITY(U,$J,358.3,8790,1,3,0)
 ;;=3^PTSD Group
 ;;^UTILITY(U,$J,358.3,8791,0)
 ;;=96119^^64^496^10^^^^1
 ;;^UTILITY(U,$J,358.3,8791,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8791,1,2,0)
 ;;=2^96119
 ;;^UTILITY(U,$J,358.3,8791,1,3,0)
 ;;=3^Neuropsych Test by tech,per hr
 ;;^UTILITY(U,$J,358.3,8792,0)
 ;;=96402^^64^496^7^^^^1
 ;;^UTILITY(U,$J,358.3,8792,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8792,1,2,0)
 ;;=2^96402
 ;;^UTILITY(U,$J,358.3,8792,1,3,0)
 ;;=3^Injec,IM,anti-neplastic horm
 ;;^UTILITY(U,$J,358.3,8793,0)
 ;;=96102^^64^496^14^^^^1
 ;;^UTILITY(U,$J,358.3,8793,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8793,1,2,0)
 ;;=2^96102
 ;;^UTILITY(U,$J,358.3,8793,1,3,0)
 ;;=3^Psych Test by Tech,per hr
 ;;^UTILITY(U,$J,358.3,8794,0)
 ;;=96103^^64^496^15^^^^1
 ;;^UTILITY(U,$J,358.3,8794,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8794,1,2,0)
 ;;=2^96103
 ;;^UTILITY(U,$J,358.3,8794,1,3,0)
 ;;=3^Psych Test by computer
 ;;^UTILITY(U,$J,358.3,8795,0)
 ;;=96120^^64^496^11^^^^1
 ;;^UTILITY(U,$J,358.3,8795,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8795,1,2,0)
 ;;=2^96120
 ;;^UTILITY(U,$J,358.3,8795,1,3,0)
 ;;=3^Neuropsych Tst Admin w/Comp
 ;;^UTILITY(U,$J,358.3,8796,0)
 ;;=96125^^64^496^17^^^^1
 ;;^UTILITY(U,$J,358.3,8796,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8796,1,2,0)
 ;;=2^96125
 ;;^UTILITY(U,$J,358.3,8796,1,3,0)
 ;;=3^Stan Cog Perf Tst, per hr
 ;;^UTILITY(U,$J,358.3,8797,0)
 ;;=96372^^64^496^19^^^^1
 ;;^UTILITY(U,$J,358.3,8797,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8797,1,2,0)
 ;;=2^96372
 ;;^UTILITY(U,$J,358.3,8797,1,3,0)
 ;;=3^Ther/Proph/Diag Inj,SC/IM
 ;;^UTILITY(U,$J,358.3,8798,0)
 ;;=90802^^64^496^8^^^^1
 ;;^UTILITY(U,$J,358.3,8798,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8798,1,2,0)
 ;;=2^90802
 ;;^UTILITY(U,$J,358.3,8798,1,3,0)
 ;;=3^Intac Psy DX Interview
 ;;^UTILITY(U,$J,358.3,8799,0)
 ;;=Q3014^^64^496^18^^^^1
 ;;^UTILITY(U,$J,358.3,8799,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,8799,1,2,0)
 ;;=2^Q3014
 ;;^UTILITY(U,$J,358.3,8799,1,3,0)
 ;;=3^Telehealth Facility Fee
 ;;^UTILITY(U,$J,358.3,8800,0)
 ;;=99241^^65^497^1
 ;;^UTILITY(U,$J,358.3,8800,1,0)
 ;;=^358.31IA^2^2
 ;;^UTILITY(U,$J,358.3,8800,1,1,0)
 ;;=1^Prob Focused
 ;;^UTILITY(U,$J,358.3,8800,1,2,0)
 ;;=2^99241
