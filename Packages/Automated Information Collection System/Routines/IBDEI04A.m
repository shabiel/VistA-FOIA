IBDEI04A ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5493,2)
 ;;=^272154
 ;;^UTILITY(U,$J,358.3,5494,0)
 ;;=715.36^^52^381^16
 ;;^UTILITY(U,$J,358.3,5494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5494,1,4,0)
 ;;=4^715.36
 ;;^UTILITY(U,$J,358.3,5494,1,5,0)
 ;;=5^Loc Osteoarth Nos-L/Leg
 ;;^UTILITY(U,$J,358.3,5494,2)
 ;;=^272155
 ;;^UTILITY(U,$J,358.3,5495,0)
 ;;=715.37^^52^381^14
 ;;^UTILITY(U,$J,358.3,5495,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5495,1,4,0)
 ;;=4^715.37
 ;;^UTILITY(U,$J,358.3,5495,1,5,0)
 ;;=5^Loc Osteoarth Nos-Ankle
 ;;^UTILITY(U,$J,358.3,5495,2)
 ;;=^272156
 ;;^UTILITY(U,$J,358.3,5496,0)
 ;;=715.38^^52^381^12
 ;;^UTILITY(U,$J,358.3,5496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5496,1,4,0)
 ;;=4^715.38
 ;;^UTILITY(U,$J,358.3,5496,1,5,0)
 ;;=5^Loc Osteoar Nos-Site Nec
 ;;^UTILITY(U,$J,358.3,5496,2)
 ;;=^272157
 ;;^UTILITY(U,$J,358.3,5497,0)
 ;;=724.2^^52^381^21
 ;;^UTILITY(U,$J,358.3,5497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5497,1,4,0)
 ;;=4^724.2
 ;;^UTILITY(U,$J,358.3,5497,1,5,0)
 ;;=5^Low Back Pain
 ;;^UTILITY(U,$J,358.3,5497,2)
 ;;=^71885
 ;;^UTILITY(U,$J,358.3,5498,0)
 ;;=274.00^^52^381^8
 ;;^UTILITY(U,$J,358.3,5498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5498,1,4,0)
 ;;=4^274.00
 ;;^UTILITY(U,$J,358.3,5498,1,5,0)
 ;;=5^Gouty Arthritis
 ;;^UTILITY(U,$J,358.3,5498,2)
 ;;=^338313
 ;;^UTILITY(U,$J,358.3,5499,0)
 ;;=781.0^^52^382^15
 ;;^UTILITY(U,$J,358.3,5499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5499,1,4,0)
 ;;=4^781.0
 ;;^UTILITY(U,$J,358.3,5499,1,5,0)
 ;;=5^Tremor
 ;;^UTILITY(U,$J,358.3,5499,2)
 ;;=^23827
 ;;^UTILITY(U,$J,358.3,5500,0)
 ;;=780.31^^52^382^2
 ;;^UTILITY(U,$J,358.3,5500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5500,1,4,0)
 ;;=4^780.31
 ;;^UTILITY(U,$J,358.3,5500,1,5,0)
 ;;=5^Convulsions, Febrile
 ;;^UTILITY(U,$J,358.3,5500,2)
 ;;=^28172
 ;;^UTILITY(U,$J,358.3,5501,0)
 ;;=780.4^^52^382^16
 ;;^UTILITY(U,$J,358.3,5501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5501,1,4,0)
 ;;=4^780.4
 ;;^UTILITY(U,$J,358.3,5501,1,5,0)
 ;;=5^Vertigo
 ;;^UTILITY(U,$J,358.3,5501,2)
 ;;=^35946
 ;;^UTILITY(U,$J,358.3,5502,0)
 ;;=729.2^^52^382^7
 ;;^UTILITY(U,$J,358.3,5502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5502,1,4,0)
 ;;=4^729.2
 ;;^UTILITY(U,$J,358.3,5502,1,5,0)
 ;;=5^Neuropathic Pain
 ;;^UTILITY(U,$J,358.3,5502,2)
 ;;=Neuropathic Pain^82605
 ;;^UTILITY(U,$J,358.3,5503,0)
 ;;=356.9^^52^382^9
 ;;^UTILITY(U,$J,358.3,5503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5503,1,4,0)
 ;;=4^356.9
 ;;^UTILITY(U,$J,358.3,5503,1,5,0)
 ;;=5^Peripheral Neuropathy
 ;;^UTILITY(U,$J,358.3,5503,2)
 ;;=^123931
 ;;^UTILITY(U,$J,358.3,5504,0)
 ;;=780.2^^52^382^13
 ;;^UTILITY(U,$J,358.3,5504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5504,1,4,0)
 ;;=4^780.2
 ;;^UTILITY(U,$J,358.3,5504,1,5,0)
 ;;=5^Syncope Or Presyncope
 ;;^UTILITY(U,$J,358.3,5504,2)
 ;;=^116707
 ;;^UTILITY(U,$J,358.3,5505,0)
 ;;=724.3^^52^382^11
 ;;^UTILITY(U,$J,358.3,5505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5505,1,4,0)
 ;;=4^724.3
 ;;^UTILITY(U,$J,358.3,5505,1,5,0)
 ;;=5^Sciatica
 ;;^UTILITY(U,$J,358.3,5505,2)
 ;;=^108484
 ;;^UTILITY(U,$J,358.3,5506,0)
 ;;=780.39^^52^382^12
 ;;^UTILITY(U,$J,358.3,5506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5506,1,4,0)
 ;;=4^780.39
 ;;^UTILITY(U,$J,358.3,5506,1,5,0)
 ;;=5^Seizure Disorder
 ;;^UTILITY(U,$J,358.3,5506,2)
 ;;=^28162
 ;;^UTILITY(U,$J,358.3,5507,0)
 ;;=782.0^^52^382^8
 ;;^UTILITY(U,$J,358.3,5507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5507,1,4,0)
 ;;=4^782.0
 ;;^UTILITY(U,$J,358.3,5507,1,5,0)
 ;;=5^Parasthesia
 ;;^UTILITY(U,$J,358.3,5507,2)
 ;;=Parasthesia^35757
 ;;^UTILITY(U,$J,358.3,5508,0)
 ;;=435.9^^52^382^14
 ;;^UTILITY(U,$J,358.3,5508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5508,1,4,0)
 ;;=4^435.9
 ;;^UTILITY(U,$J,358.3,5508,1,5,0)
 ;;=5^Transient Ischemic Attack
 ;;^UTILITY(U,$J,358.3,5508,2)
 ;;=^21635
 ;;^UTILITY(U,$J,358.3,5509,0)
 ;;=729.1^^52^382^6
 ;;^UTILITY(U,$J,358.3,5509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5509,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,5509,1,5,0)
 ;;=5^Fibromyalgia
 ;;^UTILITY(U,$J,358.3,5509,2)
 ;;=Fibromyalgia^80160
 ;;^UTILITY(U,$J,358.3,5510,0)
 ;;=434.91^^52^382^1
 ;;^UTILITY(U,$J,358.3,5510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5510,1,4,0)
 ;;=4^434.91
 ;;^UTILITY(U,$J,358.3,5510,1,5,0)
 ;;=5^CVA, Stroke
 ;;^UTILITY(U,$J,358.3,5510,2)
 ;;=^295738
 ;;^UTILITY(U,$J,358.3,5511,0)
 ;;=345.90^^52^382^5
 ;;^UTILITY(U,$J,358.3,5511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5511,1,4,0)
 ;;=4^345.90
 ;;^UTILITY(U,$J,358.3,5511,1,5,0)
 ;;=5^Epilepsy w/o Intr Epil
 ;;^UTILITY(U,$J,358.3,5511,2)
 ;;=^268477
 ;;^UTILITY(U,$J,358.3,5512,0)
 ;;=345.91^^52^382^4
 ;;^UTILITY(U,$J,358.3,5512,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5512,1,4,0)
 ;;=4^345.91
 ;;^UTILITY(U,$J,358.3,5512,1,5,0)
 ;;=5^Epilepsy w/ Intr Epil
 ;;^UTILITY(U,$J,358.3,5512,2)
 ;;=^268478
 ;;^UTILITY(U,$J,358.3,5513,0)
 ;;=345.90^^52^382^3
 ;;^UTILITY(U,$J,358.3,5513,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5513,1,4,0)
 ;;=4^345.90
 ;;^UTILITY(U,$J,358.3,5513,1,5,0)
 ;;=5^Epilep NOS w/o Intr Epil
 ;;^UTILITY(U,$J,358.3,5513,2)
 ;;=^268477
 ;;^UTILITY(U,$J,358.3,5514,0)
 ;;=780.33^^52^382^10
 ;;^UTILITY(U,$J,358.3,5514,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5514,1,4,0)
 ;;=4^780.33
 ;;^UTILITY(U,$J,358.3,5514,1,5,0)
 ;;=5^Post Traumatic Seizures
 ;;^UTILITY(U,$J,358.3,5514,2)
 ;;=^339635
 ;;^UTILITY(U,$J,358.3,5515,0)
 ;;=785.9^^52^383^1
 ;;^UTILITY(U,$J,358.3,5515,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5515,1,4,0)
 ;;=4^785.9
 ;;^UTILITY(U,$J,358.3,5515,1,5,0)
 ;;=5^Abdominal Bruit
 ;;^UTILITY(U,$J,358.3,5515,2)
 ;;=^273372
 ;;^UTILITY(U,$J,358.3,5516,0)
 ;;=789.30^^52^383^4
 ;;^UTILITY(U,$J,358.3,5516,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5516,1,4,0)
 ;;=4^789.30
 ;;^UTILITY(U,$J,358.3,5516,1,5,0)
 ;;=5^Abdominal/Pelvic Mass 
 ;;^UTILITY(U,$J,358.3,5516,2)
 ;;=^917
 ;;^UTILITY(U,$J,358.3,5517,0)
 ;;=578.1^^52^383^26
 ;;^UTILITY(U,$J,358.3,5517,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5517,1,4,0)
 ;;=4^578.1
 ;;^UTILITY(U,$J,358.3,5517,1,5,0)
 ;;=5^Melena
 ;;^UTILITY(U,$J,358.3,5517,2)
 ;;=^276839
 ;;^UTILITY(U,$J,358.3,5518,0)
 ;;=571.5^^52^383^8
 ;;^UTILITY(U,$J,358.3,5518,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5518,1,4,0)
 ;;=4^571.5
 ;;^UTILITY(U,$J,358.3,5518,1,5,0)
 ;;=5^Cirrhosis
 ;;^UTILITY(U,$J,358.3,5518,2)
 ;;=^24731
 ;;^UTILITY(U,$J,358.3,5519,0)
 ;;=558.9^^52^383^24
 ;;^UTILITY(U,$J,358.3,5519,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5519,1,4,0)
 ;;=4^558.9
 ;;^UTILITY(U,$J,358.3,5519,1,5,0)
 ;;=5^Inflammatory Bowel Disease
 ;;^UTILITY(U,$J,358.3,5519,2)
 ;;=^87311
 ;;^UTILITY(U,$J,358.3,5520,0)
 ;;=555.9^^52^383^10
 ;;^UTILITY(U,$J,358.3,5520,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5520,1,4,0)
 ;;=4^555.9
 ;;^UTILITY(U,$J,358.3,5520,1,5,0)
 ;;=5^Crohn's Disease
 ;;^UTILITY(U,$J,358.3,5520,2)
 ;;=Crohn's Disease^29356
 ;;^UTILITY(U,$J,358.3,5521,0)
 ;;=530.10^^52^383^15
 ;;^UTILITY(U,$J,358.3,5521,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5521,1,4,0)
 ;;=4^530.10
 ;;^UTILITY(U,$J,358.3,5521,1,5,0)
 ;;=5^Esophagitis
 ;;^UTILITY(U,$J,358.3,5521,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,5522,0)
 ;;=571.8^^52^383^16
 ;;^UTILITY(U,$J,358.3,5522,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5522,1,4,0)
 ;;=4^571.8
 ;;^UTILITY(U,$J,358.3,5522,1,5,0)
 ;;=5^Fatty Liver 
 ;;^UTILITY(U,$J,358.3,5522,2)
 ;;=^87404
 ;;^UTILITY(U,$J,358.3,5523,0)
 ;;=792.1^^52^383^21
 ;;^UTILITY(U,$J,358.3,5523,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5523,1,4,0)
 ;;=4^792.1
 ;;^UTILITY(U,$J,358.3,5523,1,5,0)
 ;;=5^Heme+Stool
 ;;^UTILITY(U,$J,358.3,5523,2)
 ;;=^273412
 ;;^UTILITY(U,$J,358.3,5524,0)
 ;;=578.9^^52^383^17
 ;;^UTILITY(U,$J,358.3,5524,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5524,1,4,0)
 ;;=4^578.9
 ;;^UTILITY(U,$J,358.3,5524,1,5,0)
 ;;=5^GI Bleed
 ;;^UTILITY(U,$J,358.3,5524,2)
 ;;=GI Bleed^49525
 ;;^UTILITY(U,$J,358.3,5525,0)
 ;;=535.50^^52^383^20
 ;;^UTILITY(U,$J,358.3,5525,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5525,1,4,0)
 ;;=4^535.50
 ;;^UTILITY(U,$J,358.3,5525,1,5,0)
 ;;=5^Gastritis
 ;;^UTILITY(U,$J,358.3,5525,2)
 ;;=^270181
 ;;^UTILITY(U,$J,358.3,5526,0)
 ;;=789.1^^52^383^23
 ;;^UTILITY(U,$J,358.3,5526,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5526,1,4,0)
 ;;=4^789.1
 ;;^UTILITY(U,$J,358.3,5526,1,5,0)
 ;;=5^Hepatomegaly
 ;;^UTILITY(U,$J,358.3,5526,2)
 ;;=^56494
 ;;^UTILITY(U,$J,358.3,5527,0)
 ;;=577.1^^52^383^27
 ;;^UTILITY(U,$J,358.3,5527,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5527,1,4,0)
 ;;=4^577.1
 ;;^UTILITY(U,$J,358.3,5527,1,5,0)
 ;;=5^Pancreatitis
 ;;^UTILITY(U,$J,358.3,5527,2)
 ;;=^259100
 ;;^UTILITY(U,$J,358.3,5528,0)
 ;;=789.2^^52^383^30
 ;;^UTILITY(U,$J,358.3,5528,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5528,1,4,0)
 ;;=4^789.2
 ;;^UTILITY(U,$J,358.3,5528,1,5,0)
 ;;=5^Splenomegaly
 ;;^UTILITY(U,$J,358.3,5528,2)
 ;;=^113452
 ;;^UTILITY(U,$J,358.3,5529,0)
 ;;=564.00^^52^383^9
 ;;^UTILITY(U,$J,358.3,5529,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5529,1,4,0)
 ;;=4^564.00
 ;;^UTILITY(U,$J,358.3,5529,1,5,0)
 ;;=5^Constipation
 ;;^UTILITY(U,$J,358.3,5529,2)
 ;;=Constipation^323537
 ;;^UTILITY(U,$J,358.3,5530,0)
 ;;=789.00^^52^383^2
 ;;^UTILITY(U,$J,358.3,5530,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5530,1,4,0)
 ;;=4^789.00
 ;;^UTILITY(U,$J,358.3,5530,1,5,0)
 ;;=5^Abdominal Pain
 ;;^UTILITY(U,$J,358.3,5530,2)
 ;;=^303317
 ;;^UTILITY(U,$J,358.3,5531,0)
 ;;=789.60^^52^383^3
 ;;^UTILITY(U,$J,358.3,5531,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5531,1,4,0)
 ;;=4^789.60
 ;;^UTILITY(U,$J,358.3,5531,1,5,0)
 ;;=5^Abdominal Tenderness
 ;;^UTILITY(U,$J,358.3,5531,2)
 ;;=^303342
 ;;^UTILITY(U,$J,358.3,5532,0)
 ;;=531.90^^52^383^18
 ;;^UTILITY(U,$J,358.3,5532,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,5532,1,4,0)
 ;;=4^531.90
 ;;^UTILITY(U,$J,358.3,5532,1,5,0)
 ;;=5^Gastric Ulcer, Unspec
