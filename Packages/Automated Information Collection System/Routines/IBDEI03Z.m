IBDEI03Z ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,5062,0)
 ;;=10120^^46^352^1^^^^1
 ;;^UTILITY(U,$J,358.3,5062,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5062,1,2,0)
 ;;=2^10120
 ;;^UTILITY(U,$J,358.3,5062,1,3,0)
 ;;=3^REMOVE FOREIGN BODY
 ;;^UTILITY(U,$J,358.3,5063,0)
 ;;=81002^^46^353^1^^^^1
 ;;^UTILITY(U,$J,358.3,5063,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5063,1,2,0)
 ;;=2^81002
 ;;^UTILITY(U,$J,358.3,5063,1,3,0)
 ;;=3^URINALYSIS BY DIP STICK
 ;;^UTILITY(U,$J,358.3,5064,0)
 ;;=82948^^46^353^2^^^^1
 ;;^UTILITY(U,$J,358.3,5064,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5064,1,2,0)
 ;;=2^82948
 ;;^UTILITY(U,$J,358.3,5064,1,3,0)
 ;;=3^FINGERSTICK, GLUCOSE
 ;;^UTILITY(U,$J,358.3,5065,0)
 ;;=J1642^^46^354^1^^^^1
 ;;^UTILITY(U,$J,358.3,5065,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5065,1,2,0)
 ;;=2^J1642
 ;;^UTILITY(U,$J,358.3,5065,1,3,0)
 ;;=3^HEP LOCK FLUSH PER 10U
 ;;^UTILITY(U,$J,358.3,5066,0)
 ;;=17000^^46^355^1^^^^1
 ;;^UTILITY(U,$J,358.3,5066,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5066,1,2,0)
 ;;=2^17000
 ;;^UTILITY(U,$J,358.3,5066,1,3,0)
 ;;=3^LIQUID N2-1ST LESION
 ;;^UTILITY(U,$J,358.3,5067,0)
 ;;=17003^^46^355^2^^^^1
 ;;^UTILITY(U,$J,358.3,5067,1,0)
 ;;=^358.31IA^3^2
 ;;^UTILITY(U,$J,358.3,5067,1,2,0)
 ;;=2^17003
 ;;^UTILITY(U,$J,358.3,5067,1,3,0)
 ;;=3^LIQUID N2-2-14 LESIONS
 ;;^UTILITY(U,$J,358.3,5068,0)
 ;;=571.5^^47^356^2
 ;;^UTILITY(U,$J,358.3,5068,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5068,1,3,0)
 ;;=3^571.5
 ;;^UTILITY(U,$J,358.3,5068,1,4,0)
 ;;=4^Cirrhosis Of Liver
 ;;^UTILITY(U,$J,358.3,5068,2)
 ;;=^24731
 ;;^UTILITY(U,$J,358.3,5069,0)
 ;;=530.81^^47^356^4
 ;;^UTILITY(U,$J,358.3,5069,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5069,1,3,0)
 ;;=3^530.81
 ;;^UTILITY(U,$J,358.3,5069,1,4,0)
 ;;=4^Esophageal Reflux (GERD)
 ;;^UTILITY(U,$J,358.3,5069,2)
 ;;=^295749
 ;;^UTILITY(U,$J,358.3,5070,0)
 ;;=558.9^^47^356^6
 ;;^UTILITY(U,$J,358.3,5070,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5070,1,3,0)
 ;;=3^558.9
 ;;^UTILITY(U,$J,358.3,5070,1,4,0)
 ;;=4^Gastroenteritis/Colitis, Noninfect
 ;;^UTILITY(U,$J,358.3,5070,2)
 ;;=^87311
 ;;^UTILITY(U,$J,358.3,5071,0)
 ;;=564.1^^47^356^9
 ;;^UTILITY(U,$J,358.3,5071,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5071,1,3,0)
 ;;=3^564.1
 ;;^UTILITY(U,$J,358.3,5071,1,4,0)
 ;;=4^Irritable Colon
 ;;^UTILITY(U,$J,358.3,5071,2)
 ;;=^65682
 ;;^UTILITY(U,$J,358.3,5072,0)
 ;;=211.3^^47^356^11
 ;;^UTILITY(U,$J,358.3,5072,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5072,1,3,0)
 ;;=3^211.3
 ;;^UTILITY(U,$J,358.3,5072,1,4,0)
 ;;=4^Polyps, Colon/Lg Bowel (Benign Neo
 ;;^UTILITY(U,$J,358.3,5072,2)
 ;;=^13295
 ;;^UTILITY(U,$J,358.3,5073,0)
 ;;=533.90^^47^356^12
 ;;^UTILITY(U,$J,358.3,5073,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5073,1,3,0)
 ;;=3^533.90
 ;;^UTILITY(U,$J,358.3,5073,1,4,0)
 ;;=4^Ulcer, Peptic
 ;;^UTILITY(U,$J,358.3,5073,2)
 ;;=^93051
 ;;^UTILITY(U,$J,358.3,5074,0)
 ;;=070.54^^47^356^8
 ;;^UTILITY(U,$J,358.3,5074,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5074,1,3,0)
 ;;=3^070.54
 ;;^UTILITY(U,$J,358.3,5074,1,4,0)
 ;;=4^Hepatitis C,Chronic,w/o Coma
 ;;^UTILITY(U,$J,358.3,5074,2)
 ;;=^303252
 ;;^UTILITY(U,$J,358.3,5075,0)
 ;;=455.6^^47^356^7
 ;;^UTILITY(U,$J,358.3,5075,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5075,1,3,0)
 ;;=3^455.6
 ;;^UTILITY(U,$J,358.3,5075,1,4,0)
 ;;=4^Hemorrhoids
 ;;^UTILITY(U,$J,358.3,5075,2)
 ;;=^123922
 ;;^UTILITY(U,$J,358.3,5076,0)
 ;;=789.00^^47^356^1
 ;;^UTILITY(U,$J,358.3,5076,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5076,1,3,0)
 ;;=3^789.00
 ;;^UTILITY(U,$J,358.3,5076,1,4,0)
 ;;=4^Abdominal Pain, Unsp
 ;;^UTILITY(U,$J,358.3,5076,2)
 ;;=^303317
 ;;^UTILITY(U,$J,358.3,5077,0)
 ;;=564.00^^47^356^3
 ;;^UTILITY(U,$J,358.3,5077,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5077,1,3,0)
 ;;=3^564.00
 ;;^UTILITY(U,$J,358.3,5077,1,4,0)
 ;;=4^Constipation
 ;;^UTILITY(U,$J,358.3,5077,2)
 ;;=^323537
 ;;^UTILITY(U,$J,358.3,5078,0)
 ;;=535.50^^47^356^5
 ;;^UTILITY(U,$J,358.3,5078,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5078,1,3,0)
 ;;=3^535.50
 ;;^UTILITY(U,$J,358.3,5078,1,4,0)
 ;;=4^Gastr&Gastroduodenit w/o hem
 ;;^UTILITY(U,$J,358.3,5078,2)
 ;;=^270181
 ;;^UTILITY(U,$J,358.3,5079,0)
 ;;=790.5^^47^356^10
 ;;^UTILITY(U,$J,358.3,5079,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5079,1,3,0)
 ;;=3^790.5
 ;;^UTILITY(U,$J,358.3,5079,1,4,0)
 ;;=4^LFT Abnormal
 ;;^UTILITY(U,$J,358.3,5079,2)
 ;;=^273402
 ;;^UTILITY(U,$J,358.3,5080,0)
 ;;=592.0^^47^357^5
 ;;^UTILITY(U,$J,358.3,5080,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5080,1,3,0)
 ;;=3^592.0
 ;;^UTILITY(U,$J,358.3,5080,1,4,0)
 ;;=4^Kidney Stones
 ;;^UTILITY(U,$J,358.3,5080,2)
 ;;=^67056
 ;;^UTILITY(U,$J,358.3,5081,0)
 ;;=599.0^^47^357^9
 ;;^UTILITY(U,$J,358.3,5081,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5081,1,3,0)
 ;;=3^599.0
 ;;^UTILITY(U,$J,358.3,5081,1,4,0)
 ;;=4^Urinary Tract Infection
 ;;^UTILITY(U,$J,358.3,5081,2)
 ;;=^124436
 ;;^UTILITY(U,$J,358.3,5082,0)
 ;;=593.9^^47^357^7
 ;;^UTILITY(U,$J,358.3,5082,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5082,1,3,0)
 ;;=3^593.9
 ;;^UTILITY(U,$J,358.3,5082,1,4,0)
 ;;=4^Renal Insufficiency
 ;;^UTILITY(U,$J,358.3,5082,2)
 ;;=^123849
 ;;^UTILITY(U,$J,358.3,5083,0)
 ;;=625.6^^47^357^1
 ;;^UTILITY(U,$J,358.3,5083,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5083,1,3,0)
 ;;=3^625.6
 ;;^UTILITY(U,$J,358.3,5083,1,4,0)
 ;;=4^Female Stress Incontinence
 ;;^UTILITY(U,$J,358.3,5083,2)
 ;;=^114717
 ;;^UTILITY(U,$J,358.3,5084,0)
 ;;=788.31^^47^357^8
 ;;^UTILITY(U,$J,358.3,5084,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5084,1,3,0)
 ;;=3^788.31
 ;;^UTILITY(U,$J,358.3,5084,1,4,0)
 ;;=4^Urge Incontinence
 ;;^UTILITY(U,$J,358.3,5084,2)
 ;;=^260046
 ;;^UTILITY(U,$J,358.3,5085,0)
 ;;=788.33^^47^357^6
 ;;^UTILITY(U,$J,358.3,5085,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5085,1,3,0)
 ;;=3^788.33
 ;;^UTILITY(U,$J,358.3,5085,1,4,0)
 ;;=4^Mixed Incontinence (M)(F)
 ;;^UTILITY(U,$J,358.3,5085,2)
 ;;=^293936
 ;;^UTILITY(U,$J,358.3,5086,0)
 ;;=599.70^^47^357^2
 ;;^UTILITY(U,$J,358.3,5086,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5086,1,3,0)
 ;;=3^599.70
 ;;^UTILITY(U,$J,358.3,5086,1,4,0)
 ;;=4^Hematuria NOS
 ;;^UTILITY(U,$J,358.3,5086,2)
 ;;=^336751
 ;;^UTILITY(U,$J,358.3,5087,0)
 ;;=599.71^^47^357^3
 ;;^UTILITY(U,$J,358.3,5087,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5087,1,3,0)
 ;;=3^599.71
 ;;^UTILITY(U,$J,358.3,5087,1,4,0)
 ;;=4^Hematuria, Gross
 ;;^UTILITY(U,$J,358.3,5087,2)
 ;;=^336611
 ;;^UTILITY(U,$J,358.3,5088,0)
 ;;=599.72^^47^357^4
 ;;^UTILITY(U,$J,358.3,5088,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5088,1,3,0)
 ;;=3^599.72
 ;;^UTILITY(U,$J,358.3,5088,1,4,0)
 ;;=4^Hematuria, Microscopic
 ;;^UTILITY(U,$J,358.3,5088,2)
 ;;=^336612
 ;;^UTILITY(U,$J,358.3,5089,0)
 ;;=795.00^^47^358^4
 ;;^UTILITY(U,$J,358.3,5089,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5089,1,3,0)
 ;;=3^795.00
 ;;^UTILITY(U,$J,358.3,5089,1,4,0)
 ;;=4^Abnormal Pap
 ;;^UTILITY(U,$J,358.3,5089,2)
 ;;=^328609
 ;;^UTILITY(U,$J,358.3,5090,0)
 ;;=626.8^^47^358^27
 ;;^UTILITY(U,$J,358.3,5090,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5090,1,3,0)
 ;;=3^626.8
 ;;^UTILITY(U,$J,358.3,5090,1,4,0)
 ;;=4^Dysfunctional Bleeding
 ;;^UTILITY(U,$J,358.3,5090,2)
 ;;=^87521
 ;;^UTILITY(U,$J,358.3,5091,0)
 ;;=628.9^^47^358^41
 ;;^UTILITY(U,$J,358.3,5091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5091,1,3,0)
 ;;=3^628.9
 ;;^UTILITY(U,$J,358.3,5091,1,4,0)
 ;;=4^Female Infertility Nos
 ;;^UTILITY(U,$J,358.3,5091,2)
 ;;=^62820
 ;;^UTILITY(U,$J,358.3,5092,0)
 ;;=610.1^^47^358^42
 ;;^UTILITY(U,$J,358.3,5092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5092,1,3,0)
 ;;=3^610.1
 ;;^UTILITY(U,$J,358.3,5092,1,4,0)
 ;;=4^Fibrocystic Breast
 ;;^UTILITY(U,$J,358.3,5092,2)
 ;;=^46167
 ;;^UTILITY(U,$J,358.3,5093,0)
 ;;=V10.3^^47^358^45
 ;;^UTILITY(U,$J,358.3,5093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5093,1,3,0)
 ;;=3^V10.3
 ;;^UTILITY(U,$J,358.3,5093,1,4,0)
 ;;=4^Hx Of Breast Cancer
 ;;^UTILITY(U,$J,358.3,5093,2)
 ;;=^295217
 ;;^UTILITY(U,$J,358.3,5094,0)
 ;;=V10.43^^47^358^46
 ;;^UTILITY(U,$J,358.3,5094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5094,1,3,0)
 ;;=3^V10.43
 ;;^UTILITY(U,$J,358.3,5094,1,4,0)
 ;;=4^Hx Of Ovarian Cancer
 ;;^UTILITY(U,$J,358.3,5094,2)
 ;;=^295221
 ;;^UTILITY(U,$J,358.3,5095,0)
 ;;=611.72^^47^358^52
 ;;^UTILITY(U,$J,358.3,5095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5095,1,3,0)
 ;;=3^611.72
 ;;^UTILITY(U,$J,358.3,5095,1,4,0)
 ;;=4^Lump Or Mass In Breast
 ;;^UTILITY(U,$J,358.3,5095,2)
 ;;=^72018
 ;;^UTILITY(U,$J,358.3,5096,0)
 ;;=625.9^^47^358^66
 ;;^UTILITY(U,$J,358.3,5096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5096,1,3,0)
 ;;=3^625.9
 ;;^UTILITY(U,$J,358.3,5096,1,4,0)
 ;;=4^Pelvic Pain
 ;;^UTILITY(U,$J,358.3,5096,2)
 ;;=^123993
 ;;^UTILITY(U,$J,358.3,5097,0)
 ;;=627.1^^47^358^70
 ;;^UTILITY(U,$J,358.3,5097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5097,1,3,0)
 ;;=3^627.1
 ;;^UTILITY(U,$J,358.3,5097,1,4,0)
 ;;=4^Postmenopausal Bleeding
 ;;^UTILITY(U,$J,358.3,5097,2)
 ;;=^97040
 ;;^UTILITY(U,$J,358.3,5098,0)
 ;;=616.10^^47^358^92
 ;;^UTILITY(U,$J,358.3,5098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5098,1,3,0)
 ;;=3^616.10
 ;;^UTILITY(U,$J,358.3,5098,1,4,0)
 ;;=4^Vaginitis/Vaginal Infection
 ;;^UTILITY(U,$J,358.3,5098,2)
 ;;=^125233
 ;;^UTILITY(U,$J,358.3,5099,0)
 ;;=626.0^^47^358^10
 ;;^UTILITY(U,$J,358.3,5099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5099,1,3,0)
 ;;=3^626.0
 ;;^UTILITY(U,$J,358.3,5099,1,4,0)
 ;;=4^Amenorrhea
 ;;^UTILITY(U,$J,358.3,5099,2)
 ;;=^5871
 ;;^UTILITY(U,$J,358.3,5100,0)
 ;;=783.0^^47^358^11
 ;;^UTILITY(U,$J,358.3,5100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5100,1,3,0)
 ;;=3^783.0
 ;;^UTILITY(U,$J,358.3,5100,1,4,0)
 ;;=4^Anorexia
 ;;^UTILITY(U,$J,358.3,5100,2)
 ;;=^7939
 ;;^UTILITY(U,$J,358.3,5101,0)
 ;;=V76.10^^47^358^15
 ;;^UTILITY(U,$J,358.3,5101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,5101,1,3,0)
 ;;=3^V76.10
