IBDEI0A0 ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,13477,0)
 ;;=216.4^^103^842^6
 ;;^UTILITY(U,$J,358.3,13477,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13477,1,4,0)
 ;;=4^Benign Lesion, Neck
 ;;^UTILITY(U,$J,358.3,13477,1,5,0)
 ;;=5^216.4
 ;;^UTILITY(U,$J,358.3,13477,2)
 ;;=Benign Neoplasm of Skin of Neck^267633
 ;;^UTILITY(U,$J,358.3,13478,0)
 ;;=216.5^^103^842^8
 ;;^UTILITY(U,$J,358.3,13478,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13478,1,4,0)
 ;;=4^Benign Lesion, Trunk
 ;;^UTILITY(U,$J,358.3,13478,1,5,0)
 ;;=5^216.5
 ;;^UTILITY(U,$J,358.3,13478,2)
 ;;=Benign Neoplasm of Skin of Trunk^267634
 ;;^UTILITY(U,$J,358.3,13479,0)
 ;;=216.6^^103^842^9
 ;;^UTILITY(U,$J,358.3,13479,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13479,1,4,0)
 ;;=4^Benign Lesion, Upper Limb
 ;;^UTILITY(U,$J,358.3,13479,1,5,0)
 ;;=5^216.6
 ;;^UTILITY(U,$J,358.3,13479,2)
 ;;=Benign Neoplasm of Skin of Arm^267635
 ;;^UTILITY(U,$J,358.3,13480,0)
 ;;=216.7^^103^842^5
 ;;^UTILITY(U,$J,358.3,13480,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13480,1,4,0)
 ;;=4^Benign Lesion, Lower Limb
 ;;^UTILITY(U,$J,358.3,13480,1,5,0)
 ;;=5^216.7
 ;;^UTILITY(U,$J,358.3,13480,2)
 ;;=Benign Neoplasm of of skin of leg^267636
 ;;^UTILITY(U,$J,358.3,13481,0)
 ;;=216.8^^103^842^7
 ;;^UTILITY(U,$J,358.3,13481,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13481,1,4,0)
 ;;=4^Benign Lesion, Skin Other
 ;;^UTILITY(U,$J,358.3,13481,1,5,0)
 ;;=5^216.8
 ;;^UTILITY(U,$J,358.3,13481,2)
 ;;=Ben Neoplasm, Skin, Unspec^267637
 ;;^UTILITY(U,$J,358.3,13482,0)
 ;;=216.3^^103^842^3
 ;;^UTILITY(U,$J,358.3,13482,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13482,1,4,0)
 ;;=4^Benign Lesion, Face
 ;;^UTILITY(U,$J,358.3,13482,1,5,0)
 ;;=5^216.3
 ;;^UTILITY(U,$J,358.3,13482,2)
 ;;=^267632
 ;;^UTILITY(U,$J,358.3,13483,0)
 ;;=173.00^^103^843^4
 ;;^UTILITY(U,$J,358.3,13483,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13483,1,4,0)
 ;;=4^Ca Of Skin Of Lip
 ;;^UTILITY(U,$J,358.3,13483,1,5,0)
 ;;=5^173.00
 ;;^UTILITY(U,$J,358.3,13483,2)
 ;;=MALIG NEOPL SKIN LIP NOS^340596
 ;;^UTILITY(U,$J,358.3,13484,0)
 ;;=173.10^^103^843^2
 ;;^UTILITY(U,$J,358.3,13484,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13484,1,4,0)
 ;;=4^Ca Of Skin Of Eyelid
 ;;^UTILITY(U,$J,358.3,13484,1,5,0)
 ;;=5^173.10
 ;;^UTILITY(U,$J,358.3,13484,2)
 ;;=MAL NEO EYELID/CANTH NOS^340597
 ;;^UTILITY(U,$J,358.3,13485,0)
 ;;=173.20^^103^843^1
 ;;^UTILITY(U,$J,358.3,13485,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13485,1,4,0)
 ;;=4^Ca Of Skin Of Ear
 ;;^UTILITY(U,$J,358.3,13485,1,5,0)
 ;;=5^173.20
 ;;^UTILITY(U,$J,358.3,13485,2)
 ;;=MALIG NEO SKIN EAR NOS^340598
 ;;^UTILITY(U,$J,358.3,13486,0)
 ;;=173.30^^103^843^3
 ;;^UTILITY(U,$J,358.3,13486,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13486,1,4,0)
 ;;=4^Ca Of Skin Of Face
 ;;^UTILITY(U,$J,358.3,13486,1,5,0)
 ;;=5^173.30
 ;;^UTILITY(U,$J,358.3,13486,2)
 ;;=MAL NEO SKN FACE NEC/NOS^340599
 ;;^UTILITY(U,$J,358.3,13487,0)
 ;;=173.40^^103^843^9
 ;;^UTILITY(U,$J,358.3,13487,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13487,1,4,0)
 ;;=4^Ca of Skin Scalp/Neck
 ;;^UTILITY(U,$J,358.3,13487,1,5,0)
 ;;=5^173.40
 ;;^UTILITY(U,$J,358.3,13487,2)
 ;;=MAL NEO SCLP/SKN NCK NOS^340600
 ;;^UTILITY(U,$J,358.3,13488,0)
 ;;=173.50^^103^843^5
 ;;^UTILITY(U,$J,358.3,13488,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13488,1,4,0)
 ;;=4^Ca Of Skin Of Trunk
 ;;^UTILITY(U,$J,358.3,13488,1,5,0)
 ;;=5^173.50
 ;;^UTILITY(U,$J,358.3,13488,2)
 ;;=MALIG NEO SKIN TRUNK NOS^340601
 ;;^UTILITY(U,$J,358.3,13489,0)
 ;;=173.60^^103^843^7
 ;;^UTILITY(U,$J,358.3,13489,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13489,1,4,0)
 ;;=4^Ca of Skin Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,13489,1,5,0)
 ;;=5^173.60
 ;;^UTILITY(U,$J,358.3,13489,2)
 ;;=MAL NEO SKIN UP LIMB NOS^340602
 ;;^UTILITY(U,$J,358.3,13490,0)
 ;;=173.70^^103^843^8
 ;;^UTILITY(U,$J,358.3,13490,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13490,1,4,0)
 ;;=4^Ca of Skin Leg/Hip
 ;;^UTILITY(U,$J,358.3,13490,1,5,0)
 ;;=5^173.70
 ;;^UTILITY(U,$J,358.3,13490,2)
 ;;=MAL NEO SKN LOW LIMB NOS^340603
 ;;^UTILITY(U,$J,358.3,13491,0)
 ;;=173.80^^103^843^6
 ;;^UTILITY(U,$J,358.3,13491,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13491,1,4,0)
 ;;=4^Ca Of Skin, Other Part
 ;;^UTILITY(U,$J,358.3,13491,1,5,0)
 ;;=5^173.80
 ;;^UTILITY(U,$J,358.3,13491,2)
 ;;=MAL NEO SKN SITE NEC/NOS^340604
 ;;^UTILITY(U,$J,358.3,13492,0)
 ;;=172.0^^103^844^6
 ;;^UTILITY(U,$J,358.3,13492,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13492,1,4,0)
 ;;=4^ Melanoma Of Lip
 ;;^UTILITY(U,$J,358.3,13492,1,5,0)
 ;;=5^172.0
 ;;^UTILITY(U,$J,358.3,13492,2)
 ;;=Malig Melanoma of Lip^267175
 ;;^UTILITY(U,$J,358.3,13493,0)
 ;;=172.1^^103^844^3
 ;;^UTILITY(U,$J,358.3,13493,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13493,1,4,0)
 ;;=4^ Melanoma Of Eyelid
 ;;^UTILITY(U,$J,358.3,13493,1,5,0)
 ;;=5^172.1
 ;;^UTILITY(U,$J,358.3,13493,2)
 ;;=Malig Melanoma of Eyelid^267176
 ;;^UTILITY(U,$J,358.3,13494,0)
 ;;=172.2^^103^844^2
 ;;^UTILITY(U,$J,358.3,13494,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13494,1,4,0)
 ;;=4^ Melanoma Of Ear
 ;;^UTILITY(U,$J,358.3,13494,1,5,0)
 ;;=5^172.2
 ;;^UTILITY(U,$J,358.3,13494,2)
 ;;=Malig Melanoma of Ear^267177
 ;;^UTILITY(U,$J,358.3,13495,0)
 ;;=172.3^^103^844^4
 ;;^UTILITY(U,$J,358.3,13495,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13495,1,4,0)
 ;;=4^ Melanoma Of Face
 ;;^UTILITY(U,$J,358.3,13495,1,5,0)
 ;;=5^172.3
 ;;^UTILITY(U,$J,358.3,13495,2)
 ;;=Malig Melanoma of Face^267178
 ;;^UTILITY(U,$J,358.3,13496,0)
 ;;=172.4^^103^844^7
 ;;^UTILITY(U,$J,358.3,13496,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13496,1,4,0)
 ;;=4^ Melanoma Of Neck/Scalp
 ;;^UTILITY(U,$J,358.3,13496,1,5,0)
 ;;=5^172.4
 ;;^UTILITY(U,$J,358.3,13496,2)
 ;;=Malignant Melanoma of Neck^267179
 ;;^UTILITY(U,$J,358.3,13497,0)
 ;;=172.5^^103^844^9
 ;;^UTILITY(U,$J,358.3,13497,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13497,1,4,0)
 ;;=4^ Melanoma Of Trunk
 ;;^UTILITY(U,$J,358.3,13497,1,5,0)
 ;;=5^172.5
 ;;^UTILITY(U,$J,358.3,13497,2)
 ;;=Malignant Melanoma of Trunk^267180
 ;;^UTILITY(U,$J,358.3,13498,0)
 ;;=172.6^^103^844^1
 ;;^UTILITY(U,$J,358.3,13498,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13498,1,4,0)
 ;;=4^ Melanoma Of Arm/Shoulder
 ;;^UTILITY(U,$J,358.3,13498,1,5,0)
 ;;=5^172.6
 ;;^UTILITY(U,$J,358.3,13498,2)
 ;;=Malignant Melanoma of Arm^267181
 ;;^UTILITY(U,$J,358.3,13499,0)
 ;;=172.7^^103^844^5
 ;;^UTILITY(U,$J,358.3,13499,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13499,1,4,0)
 ;;=4^ Melanoma Of Leg/Hip
 ;;^UTILITY(U,$J,358.3,13499,1,5,0)
 ;;=5^172.7
 ;;^UTILITY(U,$J,358.3,13499,2)
 ;;=Malignant Melanoma of Leg^267182
 ;;^UTILITY(U,$J,358.3,13500,0)
 ;;=172.8^^103^844^8
 ;;^UTILITY(U,$J,358.3,13500,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13500,1,4,0)
 ;;=4^ Melanoma Of Skin
 ;;^UTILITY(U,$J,358.3,13500,1,5,0)
 ;;=5^172.8
 ;;^UTILITY(U,$J,358.3,13500,2)
 ;;=Malignant Melanoma of Skin^267183
 ;;^UTILITY(U,$J,358.3,13501,0)
 ;;=873.8^^103^845^14
 ;;^UTILITY(U,$J,358.3,13501,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13501,1,4,0)
 ;;=4^Laceration, Head, Nec
 ;;^UTILITY(U,$J,358.3,13501,1,5,0)
 ;;=5^873.8
 ;;^UTILITY(U,$J,358.3,13501,2)
 ;;=Laceration, Head, NEC^274970
 ;;^UTILITY(U,$J,358.3,13502,0)
 ;;=872.01^^103^845^2
 ;;^UTILITY(U,$J,358.3,13502,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13502,1,4,0)
 ;;=4^Laceration, Auricle
 ;;^UTILITY(U,$J,358.3,13502,1,5,0)
 ;;=5^872.01
 ;;^UTILITY(U,$J,358.3,13502,2)
 ;;=Laceration, Auricle^274898
 ;;^UTILITY(U,$J,358.3,13503,0)
 ;;=873.42^^103^845^11
 ;;^UTILITY(U,$J,358.3,13503,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13503,1,4,0)
 ;;=4^Laceration, Forehead
 ;;^UTILITY(U,$J,358.3,13503,1,5,0)
 ;;=5^873.42
 ;;^UTILITY(U,$J,358.3,13503,2)
 ;;=Laceration, Forehead^274943
 ;;^UTILITY(U,$J,358.3,13504,0)
 ;;=873.41^^103^845^5
 ;;^UTILITY(U,$J,358.3,13504,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13504,1,4,0)
 ;;=4^Laceration, Cheek
 ;;^UTILITY(U,$J,358.3,13504,1,5,0)
 ;;=5^873.41
 ;;^UTILITY(U,$J,358.3,13504,2)
 ;;=Laceration, Cheek^274940
 ;;^UTILITY(U,$J,358.3,13505,0)
 ;;=873.44^^103^845^16
 ;;^UTILITY(U,$J,358.3,13505,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13505,1,4,0)
 ;;=4^Laceration, Jaw/Chin
 ;;^UTILITY(U,$J,358.3,13505,1,5,0)
 ;;=5^873.44
 ;;^UTILITY(U,$J,358.3,13505,2)
 ;;=Laceration, Jaw/Chin^274947
 ;;^UTILITY(U,$J,358.3,13506,0)
 ;;=872.8^^103^845^6
 ;;^UTILITY(U,$J,358.3,13506,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13506,1,4,0)
 ;;=4^Laceration, Ear
 ;;^UTILITY(U,$J,358.3,13506,1,5,0)
 ;;=5^872.8
 ;;^UTILITY(U,$J,358.3,13506,2)
 ;;=Laceration, Ear^274918
 ;;^UTILITY(U,$J,358.3,13507,0)
 ;;=873.40^^103^845^8
 ;;^UTILITY(U,$J,358.3,13507,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13507,1,4,0)
 ;;=4^Laceration, Face, Nos
 ;;^UTILITY(U,$J,358.3,13507,1,5,0)
 ;;=5^873.40
 ;;^UTILITY(U,$J,358.3,13507,2)
 ;;=Laceration, Face, NOS^274939
 ;;^UTILITY(U,$J,358.3,13508,0)
 ;;=874.8^^103^845^18
 ;;^UTILITY(U,$J,358.3,13508,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13508,1,4,0)
 ;;=4^Laceration, Neck
 ;;^UTILITY(U,$J,358.3,13508,1,5,0)
 ;;=5^874.8
 ;;^UTILITY(U,$J,358.3,13508,2)
 ;;=Laceration, Neck^274988
 ;;^UTILITY(U,$J,358.3,13509,0)
 ;;=873.20^^103^845^19
 ;;^UTILITY(U,$J,358.3,13509,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13509,1,4,0)
 ;;=4^Laceration, Nose
 ;;^UTILITY(U,$J,358.3,13509,1,5,0)
 ;;=5^873.20
 ;;^UTILITY(U,$J,358.3,13509,2)
 ;;=Laceration, Nose^274924
 ;;^UTILITY(U,$J,358.3,13510,0)
 ;;=873.0^^103^845^20
 ;;^UTILITY(U,$J,358.3,13510,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13510,1,4,0)
 ;;=4^Laceration, Scalp
 ;;^UTILITY(U,$J,358.3,13510,1,5,0)
 ;;=5^873.0
 ;;^UTILITY(U,$J,358.3,13510,2)
 ;;=Laceration, Scalp^274921
 ;;^UTILITY(U,$J,358.3,13511,0)
 ;;=880.02^^103^845^3
 ;;^UTILITY(U,$J,358.3,13511,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,13511,1,4,0)
 ;;=4^Laceration, Axilla
