IBDEI02D ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2841,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2841,1,4,0)
 ;;=4^V12.55
 ;;^UTILITY(U,$J,358.3,2841,1,5,0)
 ;;=5^Hx of Pulmonary Embolism
 ;;^UTILITY(U,$J,358.3,2841,2)
 ;;=^340615
 ;;^UTILITY(U,$J,358.3,2842,0)
 ;;=271.3^^36^265^17
 ;;^UTILITY(U,$J,358.3,2842,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2842,1,4,0)
 ;;=4^271.3
 ;;^UTILITY(U,$J,358.3,2842,1,5,0)
 ;;=5^Glucose Intolerance
 ;;^UTILITY(U,$J,358.3,2842,2)
 ;;=^64790
 ;;^UTILITY(U,$J,358.3,2843,0)
 ;;=611.1^^36^265^22
 ;;^UTILITY(U,$J,358.3,2843,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2843,1,4,0)
 ;;=4^611.1
 ;;^UTILITY(U,$J,358.3,2843,1,5,0)
 ;;=5^Gynecomastia
 ;;^UTILITY(U,$J,358.3,2843,2)
 ;;=^60454
 ;;^UTILITY(U,$J,358.3,2844,0)
 ;;=704.1^^36^265^23
 ;;^UTILITY(U,$J,358.3,2844,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2844,1,4,0)
 ;;=4^704.1
 ;;^UTILITY(U,$J,358.3,2844,1,5,0)
 ;;=5^Hirsutism
 ;;^UTILITY(U,$J,358.3,2844,2)
 ;;=^57407
 ;;^UTILITY(U,$J,358.3,2845,0)
 ;;=251.2^^36^265^36
 ;;^UTILITY(U,$J,358.3,2845,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2845,1,4,0)
 ;;=4^251.2
 ;;^UTILITY(U,$J,358.3,2845,1,5,0)
 ;;=5^Hypoglycemia Nos
 ;;^UTILITY(U,$J,358.3,2845,2)
 ;;=^60580
 ;;^UTILITY(U,$J,358.3,2846,0)
 ;;=257.2^^36^265^37
 ;;^UTILITY(U,$J,358.3,2846,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2846,1,4,0)
 ;;=4^257.2
 ;;^UTILITY(U,$J,358.3,2846,1,5,0)
 ;;=5^Hypogonadism,Male
 ;;^UTILITY(U,$J,358.3,2846,2)
 ;;=^88213
 ;;^UTILITY(U,$J,358.3,2847,0)
 ;;=253.2^^36^265^41
 ;;^UTILITY(U,$J,358.3,2847,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2847,1,4,0)
 ;;=4^253.2
 ;;^UTILITY(U,$J,358.3,2847,1,5,0)
 ;;=5^Hypopituitarism
 ;;^UTILITY(U,$J,358.3,2847,2)
 ;;=^60686
 ;;^UTILITY(U,$J,358.3,2848,0)
 ;;=733.00^^36^265^52
 ;;^UTILITY(U,$J,358.3,2848,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2848,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,2848,1,5,0)
 ;;=5^Osteoporosis Nos
 ;;^UTILITY(U,$J,358.3,2848,2)
 ;;=^87159
 ;;^UTILITY(U,$J,358.3,2849,0)
 ;;=278.00^^36^265^48
 ;;^UTILITY(U,$J,358.3,2849,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2849,1,4,0)
 ;;=4^278.00
 ;;^UTILITY(U,$J,358.3,2849,1,5,0)
 ;;=5^Obesity
 ;;^UTILITY(U,$J,358.3,2849,2)
 ;;=^84823
 ;;^UTILITY(U,$J,358.3,2850,0)
 ;;=278.01^^36^265^47
 ;;^UTILITY(U,$J,358.3,2850,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2850,1,4,0)
 ;;=4^278.01
 ;;^UTILITY(U,$J,358.3,2850,1,5,0)
 ;;=5^Morbid Obesity
 ;;^UTILITY(U,$J,358.3,2850,2)
 ;;=^84844
 ;;^UTILITY(U,$J,358.3,2851,0)
 ;;=250.80^^36^265^15
 ;;^UTILITY(U,$J,358.3,2851,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2851,1,4,0)
 ;;=4^250.80
 ;;^UTILITY(U,$J,358.3,2851,1,5,0)
 ;;=5^Dm Type Ii With Le Ulcer
 ;;^UTILITY(U,$J,358.3,2851,2)
 ;;=DM Type II with LE Ulcer^267846^707.10
 ;;^UTILITY(U,$J,358.3,2852,0)
 ;;=250.00^^36^265^9
 ;;^UTILITY(U,$J,358.3,2852,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2852,1,4,0)
 ;;=4^250.00
 ;;^UTILITY(U,$J,358.3,2852,1,5,0)
 ;;=5^Dm Type Ii Dm W/O Complications
 ;;^UTILITY(U,$J,358.3,2852,2)
 ;;=^33605
 ;;^UTILITY(U,$J,358.3,2853,0)
 ;;=250.40^^36^265^11
 ;;^UTILITY(U,$J,358.3,2853,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2853,1,4,0)
 ;;=4^250.40
 ;;^UTILITY(U,$J,358.3,2853,1,5,0)
 ;;=5^Dm Type Ii Dm With Nephropathy
 ;;^UTILITY(U,$J,358.3,2853,2)
 ;;=^267837^583.81
 ;;^UTILITY(U,$J,358.3,2854,0)
 ;;=250.50^^36^265^14
 ;;^UTILITY(U,$J,358.3,2854,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2854,1,4,0)
 ;;=4^250.50
 ;;^UTILITY(U,$J,358.3,2854,1,5,0)
 ;;=5^Dm Type Ii W/ Pdr
 ;;^UTILITY(U,$J,358.3,2854,2)
 ;;=DM Type II w/ PDR^267839^362.02
 ;;^UTILITY(U,$J,358.3,2855,0)
 ;;=250.60^^36^265^12
 ;;^UTILITY(U,$J,358.3,2855,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2855,1,4,0)
 ;;=4^250.60
 ;;^UTILITY(U,$J,358.3,2855,1,5,0)
 ;;=5^Dm Type Ii Dm With Neuropathy
 ;;^UTILITY(U,$J,358.3,2855,2)
 ;;=^267841^357.2
 ;;^UTILITY(U,$J,358.3,2856,0)
 ;;=250.70^^36^265^13
 ;;^UTILITY(U,$J,358.3,2856,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2856,1,4,0)
 ;;=4^250.70
 ;;^UTILITY(U,$J,358.3,2856,1,5,0)
 ;;=5^Dm Type Ii Dm With Peripheral Vasc Dis
 ;;^UTILITY(U,$J,358.3,2856,2)
 ;;=^267843^443.81
 ;;^UTILITY(U,$J,358.3,2857,0)
 ;;=250.01^^36^265^8
 ;;^UTILITY(U,$J,358.3,2857,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2857,1,4,0)
 ;;=4^250.01
 ;;^UTILITY(U,$J,358.3,2857,1,5,0)
 ;;=5^Dm Type I Dm W/O Complications
 ;;^UTILITY(U,$J,358.3,2857,2)
 ;;=^33586
 ;;^UTILITY(U,$J,358.3,2858,0)
 ;;=272.0^^36^265^28
 ;;^UTILITY(U,$J,358.3,2858,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2858,1,4,0)
 ;;=4^272.0
 ;;^UTILITY(U,$J,358.3,2858,1,5,0)
 ;;=5^Hypercholesterolemia, Pure
 ;;^UTILITY(U,$J,358.3,2858,2)
 ;;=Hypercholesterolemia, Pure^59973
 ;;^UTILITY(U,$J,358.3,2859,0)
 ;;=272.1^^36^265^33
 ;;^UTILITY(U,$J,358.3,2859,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2859,1,4,0)
 ;;=4^272.1
 ;;^UTILITY(U,$J,358.3,2859,1,5,0)
 ;;=5^Hypertriglyceridemia, Pure
 ;;^UTILITY(U,$J,358.3,2859,2)
 ;;=Hypertriglyceridemia, Pure^101303
 ;;^UTILITY(U,$J,358.3,2860,0)
 ;;=272.2^^36^265^30
 ;;^UTILITY(U,$J,358.3,2860,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2860,1,4,0)
 ;;=4^272.2
 ;;^UTILITY(U,$J,358.3,2860,1,5,0)
 ;;=5^Hyperlipidemia, Mixed
 ;;^UTILITY(U,$J,358.3,2860,2)
 ;;=^78424
 ;;^UTILITY(U,$J,358.3,2861,0)
 ;;=275.42^^36^265^27
 ;;^UTILITY(U,$J,358.3,2861,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2861,1,4,0)
 ;;=4^275.42
 ;;^UTILITY(U,$J,358.3,2861,1,5,0)
 ;;=5^Hypercalcemia
 ;;^UTILITY(U,$J,358.3,2861,2)
 ;;=^59932
 ;;^UTILITY(U,$J,358.3,2862,0)
 ;;=275.41^^36^265^35
 ;;^UTILITY(U,$J,358.3,2862,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2862,1,4,0)
 ;;=4^275.41
 ;;^UTILITY(U,$J,358.3,2862,1,5,0)
 ;;=5^Hypocalcemia
 ;;^UTILITY(U,$J,358.3,2862,2)
 ;;=^60542
 ;;^UTILITY(U,$J,358.3,2863,0)
 ;;=276.7^^36^265^29
 ;;^UTILITY(U,$J,358.3,2863,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2863,1,4,0)
 ;;=4^276.7
 ;;^UTILITY(U,$J,358.3,2863,1,5,0)
 ;;=5^Hyperkalemia
 ;;^UTILITY(U,$J,358.3,2863,2)
 ;;=^60042
 ;;^UTILITY(U,$J,358.3,2864,0)
 ;;=275.2^^36^265^25
 ;;^UTILITY(U,$J,358.3,2864,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2864,1,4,0)
 ;;=4^275.2
 ;;^UTILITY(U,$J,358.3,2864,1,5,0)
 ;;=5^Hyper Or Hypomagnesemia
 ;;^UTILITY(U,$J,358.3,2864,2)
 ;;=^35626
 ;;^UTILITY(U,$J,358.3,2865,0)
 ;;=276.0^^36^265^31
 ;;^UTILITY(U,$J,358.3,2865,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2865,1,4,0)
 ;;=4^276.0
 ;;^UTILITY(U,$J,358.3,2865,1,5,0)
 ;;=5^Hypernatremia
 ;;^UTILITY(U,$J,358.3,2865,2)
 ;;=^60144
 ;;^UTILITY(U,$J,358.3,2866,0)
 ;;=276.1^^36^265^38
 ;;^UTILITY(U,$J,358.3,2866,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2866,1,4,0)
 ;;=4^276.1
 ;;^UTILITY(U,$J,358.3,2866,1,5,0)
 ;;=5^Hyponatremia
 ;;^UTILITY(U,$J,358.3,2866,2)
 ;;=Hyponatremia^60722
 ;;^UTILITY(U,$J,358.3,2867,0)
 ;;=275.3^^36^265^26
 ;;^UTILITY(U,$J,358.3,2867,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2867,1,4,0)
 ;;=4^275.3
 ;;^UTILITY(U,$J,358.3,2867,1,5,0)
 ;;=5^Hyper Or Hypophosphatemia
 ;;^UTILITY(U,$J,358.3,2867,2)
 ;;=^93796
 ;;^UTILITY(U,$J,358.3,2868,0)
 ;;=240.0^^36^265^20
 ;;^UTILITY(U,$J,358.3,2868,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2868,1,4,0)
 ;;=4^240.0
 ;;^UTILITY(U,$J,358.3,2868,1,5,0)
 ;;=5^Goiter, Simple
 ;;^UTILITY(U,$J,358.3,2868,2)
 ;;=^259806
 ;;^UTILITY(U,$J,358.3,2869,0)
 ;;=241.1^^36^265^19
 ;;^UTILITY(U,$J,358.3,2869,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2869,1,4,0)
 ;;=4^241.1
 ;;^UTILITY(U,$J,358.3,2869,1,5,0)
 ;;=5^Goiter, Nontox, Multinod
 ;;^UTILITY(U,$J,358.3,2869,2)
 ;;=^267790
 ;;^UTILITY(U,$J,358.3,2870,0)
 ;;=241.0^^36^265^59
 ;;^UTILITY(U,$J,358.3,2870,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2870,1,4,0)
 ;;=4^241.0
 ;;^UTILITY(U,$J,358.3,2870,1,5,0)
 ;;=5^Thyroid Nodule, Nontoxic
 ;;^UTILITY(U,$J,358.3,2870,2)
 ;;=^83865
 ;;^UTILITY(U,$J,358.3,2871,0)
 ;;=242.00^^36^265^21
 ;;^UTILITY(U,$J,358.3,2871,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2871,1,4,0)
 ;;=4^242.00
 ;;^UTILITY(U,$J,358.3,2871,1,5,0)
 ;;=5^Graves' Disease
 ;;^UTILITY(U,$J,358.3,2871,2)
 ;;=^267793
 ;;^UTILITY(U,$J,358.3,2872,0)
 ;;=242.01^^36^265^18
 ;;^UTILITY(U,$J,358.3,2872,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2872,1,4,0)
 ;;=4^242.01
 ;;^UTILITY(U,$J,358.3,2872,1,5,0)
 ;;=5^Goiter Diff Tox W Strm
 ;;^UTILITY(U,$J,358.3,2872,2)
 ;;=^267794
 ;;^UTILITY(U,$J,358.3,2873,0)
 ;;=252.1^^36^265^40
 ;;^UTILITY(U,$J,358.3,2873,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2873,1,4,0)
 ;;=4^252.1
 ;;^UTILITY(U,$J,358.3,2873,1,5,0)
 ;;=5^Hypoparathyroidism
 ;;^UTILITY(U,$J,358.3,2873,2)
 ;;=^60635
 ;;^UTILITY(U,$J,358.3,2874,0)
 ;;=242.90^^36^265^32
 ;;^UTILITY(U,$J,358.3,2874,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2874,1,4,0)
 ;;=4^242.90
 ;;^UTILITY(U,$J,358.3,2874,1,5,0)
 ;;=5^Hyperthyroid W/O Goiter Or Strm
 ;;^UTILITY(U,$J,358.3,2874,2)
 ;;=^267811
 ;;^UTILITY(U,$J,358.3,2875,0)
 ;;=242.91^^36^265^45
 ;;^UTILITY(U,$J,358.3,2875,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2875,1,4,0)
 ;;=4^242.91
 ;;^UTILITY(U,$J,358.3,2875,1,5,0)
 ;;=5^Hyprthy W/O Goit W Strm
 ;;^UTILITY(U,$J,358.3,2875,2)
 ;;=^267812
 ;;^UTILITY(U,$J,358.3,2876,0)
 ;;=244.0^^36^265^43
 ;;^UTILITY(U,$J,358.3,2876,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2876,1,4,0)
 ;;=4^244.0
 ;;^UTILITY(U,$J,358.3,2876,1,5,0)
 ;;=5^Hypothyroid, Postsurgical
 ;;^UTILITY(U,$J,358.3,2876,2)
 ;;=^267814
 ;;^UTILITY(U,$J,358.3,2877,0)
 ;;=244.2^^36^265^42
 ;;^UTILITY(U,$J,358.3,2877,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2877,1,4,0)
 ;;=4^244.2
 ;;^UTILITY(U,$J,358.3,2877,1,5,0)
 ;;=5^Hypothyroid Due To Iodine Rx
 ;;^UTILITY(U,$J,358.3,2877,2)
 ;;=^267817
 ;;^UTILITY(U,$J,358.3,2878,0)
 ;;=244.9^^36^265^44
 ;;^UTILITY(U,$J,358.3,2878,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2878,1,4,0)
 ;;=4^244.9
 ;;^UTILITY(U,$J,358.3,2878,1,5,0)
 ;;=5^Hypothyroid, Unspec Cause
 ;;^UTILITY(U,$J,358.3,2878,2)
 ;;=^123752
 ;;^UTILITY(U,$J,358.3,2879,0)
 ;;=245.0^^36^265^60
