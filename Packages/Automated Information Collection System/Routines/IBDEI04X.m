IBDEI04X ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,6390,1,4,0)
 ;;=4^558.9
 ;;^UTILITY(U,$J,358.3,6390,1,5,0)
 ;;=5^Inflammatory Bowel Disease
 ;;^UTILITY(U,$J,358.3,6390,2)
 ;;=^87311
 ;;^UTILITY(U,$J,358.3,6391,0)
 ;;=211.3^^59^425^10
 ;;^UTILITY(U,$J,358.3,6391,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6391,1,4,0)
 ;;=4^211.3
 ;;^UTILITY(U,$J,358.3,6391,1,5,0)
 ;;=5^Colon Polyps (current)
 ;;^UTILITY(U,$J,358.3,6391,2)
 ;;=Colon Polyps (current)^13295
 ;;^UTILITY(U,$J,358.3,6392,0)
 ;;=V12.72^^59^425^11
 ;;^UTILITY(U,$J,358.3,6392,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6392,1,4,0)
 ;;=4^V12.72
 ;;^UTILITY(U,$J,358.3,6392,1,5,0)
 ;;=5^Colon Polyps (removed)
 ;;^UTILITY(U,$J,358.3,6392,2)
 ;;=Colon Polyps (removed)^303401
 ;;^UTILITY(U,$J,358.3,6393,0)
 ;;=789.01^^59^425^74
 ;;^UTILITY(U,$J,358.3,6393,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6393,1,4,0)
 ;;=4^789.01
 ;;^UTILITY(U,$J,358.3,6393,1,5,0)
 ;;=5^RUQ Abdominal Pain
 ;;^UTILITY(U,$J,358.3,6393,2)
 ;;=^303318
 ;;^UTILITY(U,$J,358.3,6394,0)
 ;;=789.02^^59^425^58
 ;;^UTILITY(U,$J,358.3,6394,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6394,1,4,0)
 ;;=4^789.02
 ;;^UTILITY(U,$J,358.3,6394,1,5,0)
 ;;=5^LUQ Abdominal Pain
 ;;^UTILITY(U,$J,358.3,6394,2)
 ;;=^303319
 ;;^UTILITY(U,$J,358.3,6395,0)
 ;;=789.03^^59^425^72
 ;;^UTILITY(U,$J,358.3,6395,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6395,1,4,0)
 ;;=4^789.03
 ;;^UTILITY(U,$J,358.3,6395,1,5,0)
 ;;=5^RLQ Abdominal Pain
 ;;^UTILITY(U,$J,358.3,6395,2)
 ;;=^303320
 ;;^UTILITY(U,$J,358.3,6396,0)
 ;;=789.04^^59^425^56
 ;;^UTILITY(U,$J,358.3,6396,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6396,1,4,0)
 ;;=4^789.04
 ;;^UTILITY(U,$J,358.3,6396,1,5,0)
 ;;=5^LLQ Abdominal Pain
 ;;^UTILITY(U,$J,358.3,6396,2)
 ;;=^303321
 ;;^UTILITY(U,$J,358.3,6397,0)
 ;;=789.05^^59^425^69
 ;;^UTILITY(U,$J,358.3,6397,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6397,1,4,0)
 ;;=4^789.05
 ;;^UTILITY(U,$J,358.3,6397,1,5,0)
 ;;=5^Periumbilical Pain
 ;;^UTILITY(U,$J,358.3,6397,2)
 ;;=^303322
 ;;^UTILITY(U,$J,358.3,6398,0)
 ;;=789.06^^59^425^21
 ;;^UTILITY(U,$J,358.3,6398,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6398,1,4,0)
 ;;=4^789.06
 ;;^UTILITY(U,$J,358.3,6398,1,5,0)
 ;;=5^Epigastric Pain
 ;;^UTILITY(U,$J,358.3,6398,2)
 ;;=^303323
 ;;^UTILITY(U,$J,358.3,6399,0)
 ;;=789.61^^59^425^75
 ;;^UTILITY(U,$J,358.3,6399,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6399,1,4,0)
 ;;=4^789.61
 ;;^UTILITY(U,$J,358.3,6399,1,5,0)
 ;;=5^RUQ Abdominal Tenderness
 ;;^UTILITY(U,$J,358.3,6399,2)
 ;;=^303343
 ;;^UTILITY(U,$J,358.3,6400,0)
 ;;=789.62^^59^425^59
 ;;^UTILITY(U,$J,358.3,6400,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6400,1,4,0)
 ;;=4^789.62
 ;;^UTILITY(U,$J,358.3,6400,1,5,0)
 ;;=5^LUQ Abdominal Tenderness
 ;;^UTILITY(U,$J,358.3,6400,2)
 ;;=^303344
 ;;^UTILITY(U,$J,358.3,6401,0)
 ;;=789.63^^59^425^73
 ;;^UTILITY(U,$J,358.3,6401,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6401,1,4,0)
 ;;=4^789.63
 ;;^UTILITY(U,$J,358.3,6401,1,5,0)
 ;;=5^RLQ Abdominal Tenderness
 ;;^UTILITY(U,$J,358.3,6401,2)
 ;;=^303345
 ;;^UTILITY(U,$J,358.3,6402,0)
 ;;=789.64^^59^425^57
 ;;^UTILITY(U,$J,358.3,6402,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6402,1,4,0)
 ;;=4^789.64
 ;;^UTILITY(U,$J,358.3,6402,1,5,0)
 ;;=5^LLQ Abdominal Tenderness
 ;;^UTILITY(U,$J,358.3,6402,2)
 ;;=^303346
 ;;^UTILITY(U,$J,358.3,6403,0)
 ;;=789.65^^59^425^70
 ;;^UTILITY(U,$J,358.3,6403,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6403,1,4,0)
 ;;=4^789.65
 ;;^UTILITY(U,$J,358.3,6403,1,5,0)
 ;;=5^Periumbilical Tenderness
 ;;^UTILITY(U,$J,358.3,6403,2)
 ;;=^303347
 ;;^UTILITY(U,$J,358.3,6404,0)
 ;;=789.66^^59^425^22
 ;;^UTILITY(U,$J,358.3,6404,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6404,1,4,0)
 ;;=4^789.66
 ;;^UTILITY(U,$J,358.3,6404,1,5,0)
 ;;=5^Epigastric Tenderness
 ;;^UTILITY(U,$J,358.3,6404,2)
 ;;=^303348
 ;;^UTILITY(U,$J,358.3,6405,0)
 ;;=070.1^^59^425^39
 ;;^UTILITY(U,$J,358.3,6405,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6405,1,4,0)
 ;;=4^070.1
 ;;^UTILITY(U,$J,358.3,6405,1,5,0)
 ;;=5^Hepatitis A
 ;;^UTILITY(U,$J,358.3,6405,2)
 ;;=^126486
 ;;^UTILITY(U,$J,358.3,6406,0)
 ;;=070.30^^59^425^40
 ;;^UTILITY(U,$J,358.3,6406,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6406,1,4,0)
 ;;=4^070.30
 ;;^UTILITY(U,$J,358.3,6406,1,5,0)
 ;;=5^Hepatitis B, Acute
 ;;^UTILITY(U,$J,358.3,6406,2)
 ;;=^266626
 ;;^UTILITY(U,$J,358.3,6407,0)
 ;;=070.32^^59^425^41
 ;;^UTILITY(U,$J,358.3,6407,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6407,1,4,0)
 ;;=4^070.32
 ;;^UTILITY(U,$J,358.3,6407,1,5,0)
 ;;=5^Hepatitis B, Chronic
 ;;^UTILITY(U,$J,358.3,6407,2)
 ;;=^303249
 ;;^UTILITY(U,$J,358.3,6408,0)
 ;;=070.51^^59^425^42
 ;;^UTILITY(U,$J,358.3,6408,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6408,1,4,0)
 ;;=4^070.51
 ;;^UTILITY(U,$J,358.3,6408,1,5,0)
 ;;=5^Hepatitis C, Acute
 ;;^UTILITY(U,$J,358.3,6408,2)
 ;;=^266632
 ;;^UTILITY(U,$J,358.3,6409,0)
 ;;=070.54^^59^425^43
 ;;^UTILITY(U,$J,358.3,6409,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6409,1,4,0)
 ;;=4^070.54
 ;;^UTILITY(U,$J,358.3,6409,1,5,0)
 ;;=5^Hepatitis C, Chronic
 ;;^UTILITY(U,$J,358.3,6409,2)
 ;;=^303252
 ;;^UTILITY(U,$J,358.3,6410,0)
 ;;=571.41^^59^425^44
 ;;^UTILITY(U,$J,358.3,6410,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6410,1,4,0)
 ;;=4^571.41
 ;;^UTILITY(U,$J,358.3,6410,1,5,0)
 ;;=5^Hepatitis, Chronic Persist
 ;;^UTILITY(U,$J,358.3,6410,2)
 ;;=^259093
 ;;^UTILITY(U,$J,358.3,6411,0)
 ;;=571.1^^59^425^45
 ;;^UTILITY(U,$J,358.3,6411,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6411,1,4,0)
 ;;=4^571.1
 ;;^UTILITY(U,$J,358.3,6411,1,5,0)
 ;;=5^Hepatitis, ETOH Acute
 ;;^UTILITY(U,$J,358.3,6411,2)
 ;;=^2597
 ;;^UTILITY(U,$J,358.3,6412,0)
 ;;=070.59^^59^425^47
 ;;^UTILITY(U,$J,358.3,6412,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6412,1,4,0)
 ;;=4^070.59
 ;;^UTILITY(U,$J,358.3,6412,1,5,0)
 ;;=5^Hepatitis, Other Viral
 ;;^UTILITY(U,$J,358.3,6412,2)
 ;;=^266631
 ;;^UTILITY(U,$J,358.3,6413,0)
 ;;=573.3^^59^425^46
 ;;^UTILITY(U,$J,358.3,6413,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6413,1,4,0)
 ;;=4^573.3
 ;;^UTILITY(U,$J,358.3,6413,1,5,0)
 ;;=5^Hepatitis, Other
 ;;^UTILITY(U,$J,358.3,6413,2)
 ;;=^56268
 ;;^UTILITY(U,$J,358.3,6414,0)
 ;;=555.9^^59^425^13
 ;;^UTILITY(U,$J,358.3,6414,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6414,1,4,0)
 ;;=4^555.9
 ;;^UTILITY(U,$J,358.3,6414,1,5,0)
 ;;=5^Crohn's Disease
 ;;^UTILITY(U,$J,358.3,6414,2)
 ;;=Crohn's Disease^29356
 ;;^UTILITY(U,$J,358.3,6415,0)
 ;;=787.91^^59^425^14
 ;;^UTILITY(U,$J,358.3,6415,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6415,1,4,0)
 ;;=4^787.91
 ;;^UTILITY(U,$J,358.3,6415,1,5,0)
 ;;=5^Diarrhea
 ;;^UTILITY(U,$J,358.3,6415,2)
 ;;=^33921
 ;;^UTILITY(U,$J,358.3,6416,0)
 ;;=562.11^^59^425^15
 ;;^UTILITY(U,$J,358.3,6416,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6416,1,4,0)
 ;;=4^562.11
 ;;^UTILITY(U,$J,358.3,6416,1,5,0)
 ;;=5^Diverticulitis, Colon
 ;;^UTILITY(U,$J,358.3,6416,2)
 ;;=^270274
 ;;^UTILITY(U,$J,358.3,6417,0)
 ;;=562.10^^59^425^16
 ;;^UTILITY(U,$J,358.3,6417,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6417,1,4,0)
 ;;=4^562.10
 ;;^UTILITY(U,$J,358.3,6417,1,5,0)
 ;;=5^Diverticulosis, Colon
 ;;^UTILITY(U,$J,358.3,6417,2)
 ;;=^35917
 ;;^UTILITY(U,$J,358.3,6418,0)
 ;;=532.90^^59^425^17
 ;;^UTILITY(U,$J,358.3,6418,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6418,1,4,0)
 ;;=4^532.90
 ;;^UTILITY(U,$J,358.3,6418,1,5,0)
 ;;=5^Duodenal Ulcer Nos
 ;;^UTILITY(U,$J,358.3,6418,2)
 ;;=^37311
 ;;^UTILITY(U,$J,358.3,6419,0)
 ;;=536.8^^59^425^18
 ;;^UTILITY(U,$J,358.3,6419,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6419,1,4,0)
 ;;=4^536.8
 ;;^UTILITY(U,$J,358.3,6419,1,5,0)
 ;;=5^Dyspepsia
 ;;^UTILITY(U,$J,358.3,6419,2)
 ;;=^37612
 ;;^UTILITY(U,$J,358.3,6420,0)
 ;;=571.0^^59^425^27
 ;;^UTILITY(U,$J,358.3,6420,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6420,1,4,0)
 ;;=4^571.0
 ;;^UTILITY(U,$J,358.3,6420,1,5,0)
 ;;=5^Fatty Liver W/ Alcohol
 ;;^UTILITY(U,$J,358.3,6420,2)
 ;;=^45182
 ;;^UTILITY(U,$J,358.3,6421,0)
 ;;=571.3^^59^425^20
 ;;^UTILITY(U,$J,358.3,6421,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6421,1,4,0)
 ;;=4^571.3
 ;;^UTILITY(U,$J,358.3,6421,1,5,0)
 ;;=5^ETOH Liver Disease
 ;;^UTILITY(U,$J,358.3,6421,2)
 ;;=ETOH Liver Disease^4638
 ;;^UTILITY(U,$J,358.3,6422,0)
 ;;=530.10^^59^425^24
 ;;^UTILITY(U,$J,358.3,6422,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6422,1,4,0)
 ;;=4^530.10
 ;;^UTILITY(U,$J,358.3,6422,1,5,0)
 ;;=5^Esophagitis, Unsp.
 ;;^UTILITY(U,$J,358.3,6422,2)
 ;;=^295809
 ;;^UTILITY(U,$J,358.3,6423,0)
 ;;=530.81^^59^425^30
 ;;^UTILITY(U,$J,358.3,6423,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6423,1,4,0)
 ;;=4^530.81
 ;;^UTILITY(U,$J,358.3,6423,1,5,0)
 ;;=5^GERD
 ;;^UTILITY(U,$J,358.3,6423,2)
 ;;=^295749
 ;;^UTILITY(U,$J,358.3,6424,0)
 ;;=456.1^^59^425^23
 ;;^UTILITY(U,$J,358.3,6424,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6424,1,4,0)
 ;;=4^456.1
 ;;^UTILITY(U,$J,358.3,6424,1,5,0)
 ;;=5^Esoph Varices W/O Bleed
 ;;^UTILITY(U,$J,358.3,6424,2)
 ;;=^269836
 ;;^UTILITY(U,$J,358.3,6425,0)
 ;;=571.8^^59^425^28
 ;;^UTILITY(U,$J,358.3,6425,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6425,1,4,0)
 ;;=4^571.8
 ;;^UTILITY(U,$J,358.3,6425,1,5,0)
 ;;=5^Fatty Liver W/O Alcohol
 ;;^UTILITY(U,$J,358.3,6425,2)
 ;;=^87404
 ;;^UTILITY(U,$J,358.3,6426,0)
 ;;=792.1^^59^425^37
 ;;^UTILITY(U,$J,358.3,6426,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6426,1,4,0)
 ;;=4^792.1
 ;;^UTILITY(U,$J,358.3,6426,1,5,0)
 ;;=5^Heme+Stool
 ;;^UTILITY(U,$J,358.3,6426,2)
 ;;=^273412
 ;;^UTILITY(U,$J,358.3,6427,0)
 ;;=564.5^^59^425^29
 ;;^UTILITY(U,$J,358.3,6427,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6427,1,4,0)
 ;;=4^564.5
 ;;^UTILITY(U,$J,358.3,6427,1,5,0)
 ;;=5^Functional Diarrhea
 ;;^UTILITY(U,$J,358.3,6427,2)
 ;;=^270281
 ;;^UTILITY(U,$J,358.3,6428,0)
 ;;=578.9^^59^425^31
 ;;^UTILITY(U,$J,358.3,6428,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,6428,1,4,0)
 ;;=4^578.9
 ;;^UTILITY(U,$J,358.3,6428,1,5,0)
 ;;=5^GI Bleed
