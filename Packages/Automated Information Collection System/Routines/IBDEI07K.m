IBDEI07K ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,10091,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10091,1,3,0)
 ;;=3^Gangrene W/Atherosclerosis
 ;;^UTILITY(U,$J,358.3,10091,1,4,0)
 ;;=4^440.24
 ;;^UTILITY(U,$J,358.3,10092,0)
 ;;=342.90^^79^618^20
 ;;^UTILITY(U,$J,358.3,10092,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10092,1,3,0)
 ;;=3^Hemiplegia, Unsp side
 ;;^UTILITY(U,$J,358.3,10092,1,4,0)
 ;;=4^342.90
 ;;^UTILITY(U,$J,358.3,10092,2)
 ;;=^303267
 ;;^UTILITY(U,$J,358.3,10093,0)
 ;;=733.81^^79^618^26
 ;;^UTILITY(U,$J,358.3,10093,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10093,1,3,0)
 ;;=3^Malunion Fracture
 ;;^UTILITY(U,$J,358.3,10093,1,4,0)
 ;;=4^733.81
 ;;^UTILITY(U,$J,358.3,10094,0)
 ;;=733.82^^79^618^29
 ;;^UTILITY(U,$J,358.3,10094,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10094,1,3,0)
 ;;=3^Nonunion Fracture
 ;;^UTILITY(U,$J,358.3,10094,1,4,0)
 ;;=4^733.82
 ;;^UTILITY(U,$J,358.3,10095,0)
 ;;=729.1^^79^618^28
 ;;^UTILITY(U,$J,358.3,10095,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10095,1,3,0)
 ;;=3^Myalgia/Myositis 
 ;;^UTILITY(U,$J,358.3,10095,1,4,0)
 ;;=4^729.1
 ;;^UTILITY(U,$J,358.3,10096,0)
 ;;=732.7^^79^618^32
 ;;^UTILITY(U,$J,358.3,10096,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10096,1,3,0)
 ;;=3^Osteochondrit Dissecans
 ;;^UTILITY(U,$J,358.3,10096,1,4,0)
 ;;=4^732.7
 ;;^UTILITY(U,$J,358.3,10097,0)
 ;;=756.51^^79^618^33
 ;;^UTILITY(U,$J,358.3,10097,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10097,1,3,0)
 ;;=3^Osteogenesis Imperfecta
 ;;^UTILITY(U,$J,358.3,10097,1,4,0)
 ;;=4^756.51
 ;;^UTILITY(U,$J,358.3,10098,0)
 ;;=996.78^^79^618^42
 ;;^UTILITY(U,$J,358.3,10098,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10098,1,3,0)
 ;;=3^Prosthesis, Oth Comp
 ;;^UTILITY(U,$J,358.3,10098,1,4,0)
 ;;=4^996.78
 ;;^UTILITY(U,$J,358.3,10098,2)
 ;;=^276301
 ;;^UTILITY(U,$J,358.3,10099,0)
 ;;=356.9^^79^618^36
 ;;^UTILITY(U,$J,358.3,10099,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10099,1,3,0)
 ;;=3^Periph Neurpthy 
 ;;^UTILITY(U,$J,358.3,10099,1,4,0)
 ;;=4^356.9
 ;;^UTILITY(U,$J,358.3,10100,0)
 ;;=337.1^^79^618^37
 ;;^UTILITY(U,$J,358.3,10100,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10100,1,3,0)
 ;;=3^Periph Neurpthy Diabetes
 ;;^UTILITY(U,$J,358.3,10100,1,4,0)
 ;;=4^337.1
 ;;^UTILITY(U,$J,358.3,10101,0)
 ;;=443.9^^79^618^38
 ;;^UTILITY(U,$J,358.3,10101,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10101,1,3,0)
 ;;=3^Periph Vascular Dis Nos
 ;;^UTILITY(U,$J,358.3,10101,1,4,0)
 ;;=4^443.9
 ;;^UTILITY(U,$J,358.3,10102,0)
 ;;=443.81^^79^618^39
 ;;^UTILITY(U,$J,358.3,10102,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10102,1,3,0)
 ;;=3^Periph Vascular Dz In Diab
 ;;^UTILITY(U,$J,358.3,10102,1,4,0)
 ;;=4^443.81
 ;;^UTILITY(U,$J,358.3,10103,0)
 ;;=996.66^^79^618^41
 ;;^UTILITY(U,$J,358.3,10103,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10103,1,3,0)
 ;;=3^Prosthesis, Infected
 ;;^UTILITY(U,$J,358.3,10103,1,4,0)
 ;;=4^996.66
 ;;^UTILITY(U,$J,358.3,10104,0)
 ;;=996.77^^79^618^43
 ;;^UTILITY(U,$J,358.3,10104,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10104,1,3,0)
 ;;=3^Prosthesis, Painful
 ;;^UTILITY(U,$J,358.3,10104,1,4,0)
 ;;=4^996.77
 ;;^UTILITY(U,$J,358.3,10105,0)
 ;;=337.21^^79^618^47
 ;;^UTILITY(U,$J,358.3,10105,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10105,1,3,0)
 ;;=3^Reflex Symp Dyst Up L
 ;;^UTILITY(U,$J,358.3,10105,1,4,0)
 ;;=4^337.21
 ;;^UTILITY(U,$J,358.3,10106,0)
 ;;=337.22^^79^618^45
 ;;^UTILITY(U,$J,358.3,10106,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10106,1,3,0)
 ;;=3^Reflex Symp Dyst Ll
 ;;^UTILITY(U,$J,358.3,10106,1,4,0)
 ;;=4^337.22
 ;;^UTILITY(U,$J,358.3,10107,0)
 ;;=337.29^^79^618^46
 ;;^UTILITY(U,$J,358.3,10107,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10107,1,3,0)
 ;;=3^Reflex Symp Dyst Oth Site
 ;;^UTILITY(U,$J,358.3,10107,1,4,0)
 ;;=4^337.29
 ;;^UTILITY(U,$J,358.3,10108,0)
 ;;=714.0^^79^618^48
 ;;^UTILITY(U,$J,358.3,10108,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10108,1,3,0)
 ;;=3^Rheumatoid Arthritis
 ;;^UTILITY(U,$J,358.3,10108,1,4,0)
 ;;=4^714.0
 ;;^UTILITY(U,$J,358.3,10109,0)
 ;;=701.4^^79^618^50
 ;;^UTILITY(U,$J,358.3,10109,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10109,1,3,0)
 ;;=3^Scar,Hypertrophic
 ;;^UTILITY(U,$J,358.3,10109,1,4,0)
 ;;=4^701.4
 ;;^UTILITY(U,$J,358.3,10110,0)
 ;;=709.2^^79^618^49
 ;;^UTILITY(U,$J,358.3,10110,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10110,1,3,0)
 ;;=3^Scar & Fibrosis Skin
 ;;^UTILITY(U,$J,358.3,10110,1,4,0)
 ;;=4^709.2
 ;;^UTILITY(U,$J,358.3,10111,0)
 ;;=715.90^^79^618^31
 ;;^UTILITY(U,$J,358.3,10111,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10111,1,3,0)
 ;;=3^Osteoarthros Nos-Unspec
 ;;^UTILITY(U,$J,358.3,10111,1,4,0)
 ;;=4^715.90
 ;;^UTILITY(U,$J,358.3,10112,0)
 ;;=719.00^^79^618^23
 ;;^UTILITY(U,$J,358.3,10112,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10112,1,3,0)
 ;;=3^Joint Effusion-Unspec
 ;;^UTILITY(U,$J,358.3,10112,1,4,0)
 ;;=4^719.00
 ;;^UTILITY(U,$J,358.3,10113,0)
 ;;=848.9^^79^618^53
 ;;^UTILITY(U,$J,358.3,10113,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10113,1,3,0)
 ;;=3^Sprain Nos
 ;;^UTILITY(U,$J,358.3,10113,1,4,0)
 ;;=4^848.9
 ;;^UTILITY(U,$J,358.3,10114,0)
 ;;=879.8^^79^618^30
 ;;^UTILITY(U,$J,358.3,10114,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10114,1,3,0)
 ;;=3^Open Wound Site Nos
 ;;^UTILITY(U,$J,358.3,10114,1,4,0)
 ;;=4^879.8
 ;;^UTILITY(U,$J,358.3,10115,0)
 ;;=781.92^^79^618^1
 ;;^UTILITY(U,$J,358.3,10115,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10115,1,3,0)
 ;;=3^Abnormal Posture
 ;;^UTILITY(U,$J,358.3,10115,1,4,0)
 ;;=4^781.92
 ;;^UTILITY(U,$J,358.3,10115,2)
 ;;=^322158
 ;;^UTILITY(U,$J,358.3,10116,0)
 ;;=714.9^^79^618^2
 ;;^UTILITY(U,$J,358.3,10116,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10116,1,3,0)
 ;;=3^Arthritis, Inflammatory 
 ;;^UTILITY(U,$J,358.3,10116,1,4,0)
 ;;=4^714.9
 ;;^UTILITY(U,$J,358.3,10116,2)
 ;;=^272122
 ;;^UTILITY(U,$J,358.3,10117,0)
 ;;=696.0^^79^618^3
 ;;^UTILITY(U,$J,358.3,10117,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10117,1,3,0)
 ;;=3^Arthritis, Psoriatic
 ;;^UTILITY(U,$J,358.3,10117,1,4,0)
 ;;=4^696.0
 ;;^UTILITY(U,$J,358.3,10117,2)
 ;;=^100320
 ;;^UTILITY(U,$J,358.3,10118,0)
 ;;=829.0^^79^618^16
 ;;^UTILITY(U,$J,358.3,10118,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10118,1,3,0)
 ;;=3^Fracture Nos-Closed
 ;;^UTILITY(U,$J,358.3,10118,1,4,0)
 ;;=4^829.0
 ;;^UTILITY(U,$J,358.3,10118,2)
 ;;=^48084
 ;;^UTILITY(U,$J,358.3,10119,0)
 ;;=274.9^^79^618^19
 ;;^UTILITY(U,$J,358.3,10119,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10119,1,3,0)
 ;;=3^Gout Nos
 ;;^UTILITY(U,$J,358.3,10119,1,4,0)
 ;;=4^274.9
 ;;^UTILITY(U,$J,358.3,10119,2)
 ;;=^52625
 ;;^UTILITY(U,$J,358.3,10120,0)
 ;;=781.91^^79^618^24
 ;;^UTILITY(U,$J,358.3,10120,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10120,1,3,0)
 ;;=3^Loss Of Height
 ;;^UTILITY(U,$J,358.3,10120,1,4,0)
 ;;=4^781.91
 ;;^UTILITY(U,$J,358.3,10120,2)
 ;;=^322157
 ;;^UTILITY(U,$J,358.3,10121,0)
 ;;=707.10^^79^618^57
 ;;^UTILITY(U,$J,358.3,10121,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10121,1,3,0)
 ;;=3^Ulcer, Unsp. Lower Limb
 ;;^UTILITY(U,$J,358.3,10121,1,4,0)
 ;;=4^707.10
 ;;^UTILITY(U,$J,358.3,10121,2)
 ;;=^322142
 ;;^UTILITY(U,$J,358.3,10122,0)
 ;;=707.19^^79^618^56
 ;;^UTILITY(U,$J,358.3,10122,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10122,1,3,0)
 ;;=3^Ulcer Of Oth Part Lower Limb
 ;;^UTILITY(U,$J,358.3,10122,1,4,0)
 ;;=4^707.19
 ;;^UTILITY(U,$J,358.3,10122,2)
 ;;=^322150
 ;;^UTILITY(U,$J,358.3,10123,0)
 ;;=733.90^^79^618^7
 ;;^UTILITY(U,$J,358.3,10123,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10123,1,3,0)
 ;;=3^Bone Disease, Nos
 ;;^UTILITY(U,$J,358.3,10123,1,4,0)
 ;;=4^733.90
 ;;^UTILITY(U,$J,358.3,10123,2)
 ;;=^35593
 ;;^UTILITY(U,$J,358.3,10124,0)
 ;;=353.0^^79^618^8
 ;;^UTILITY(U,$J,358.3,10124,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10124,1,3,0)
 ;;=3^Brachial Plexus 
 ;;^UTILITY(U,$J,358.3,10124,1,4,0)
 ;;=4^353.0
 ;;^UTILITY(U,$J,358.3,10124,2)
 ;;=^16605
 ;;^UTILITY(U,$J,358.3,10125,0)
 ;;=710.0^^79^618^25
 ;;^UTILITY(U,$J,358.3,10125,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10125,1,3,0)
 ;;=3^Lupus, Nos
 ;;^UTILITY(U,$J,358.3,10125,1,4,0)
 ;;=4^710.0
 ;;^UTILITY(U,$J,358.3,10125,2)
 ;;=^72159
 ;;^UTILITY(U,$J,358.3,10126,0)
 ;;=198.5^^79^618^27
 ;;^UTILITY(U,$J,358.3,10126,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10126,1,3,0)
 ;;=3^Met. Ca Of Bone/Bone Marrow
 ;;^UTILITY(U,$J,358.3,10126,1,4,0)
 ;;=4^198.5
 ;;^UTILITY(U,$J,358.3,10126,2)
 ;;=^267336
 ;;^UTILITY(U,$J,358.3,10127,0)
 ;;=733.00^^79^618^34
 ;;^UTILITY(U,$J,358.3,10127,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10127,1,3,0)
 ;;=3^Osteoporosis, Nos
 ;;^UTILITY(U,$J,358.3,10127,1,4,0)
 ;;=4^733.00
 ;;^UTILITY(U,$J,358.3,10127,2)
 ;;=^87159
 ;;^UTILITY(U,$J,358.3,10128,0)
 ;;=731.0^^79^618^35
 ;;^UTILITY(U,$J,358.3,10128,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10128,1,3,0)
 ;;=3^Pagets Disease Of Bone
 ;;^UTILITY(U,$J,358.3,10128,1,4,0)
 ;;=4^731.0
 ;;^UTILITY(U,$J,358.3,10128,2)
 ;;=^86892
 ;;^UTILITY(U,$J,358.3,10129,0)
 ;;=355.3^^79^618^40
 ;;^UTILITY(U,$J,358.3,10129,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10129,1,3,0)
 ;;=3^Peroneal Nerve Palsy (Traum)
 ;;^UTILITY(U,$J,358.3,10129,1,4,0)
 ;;=4^355.3
 ;;^UTILITY(U,$J,358.3,10129,2)
 ;;=^268515
 ;;^UTILITY(U,$J,358.3,10130,0)
 ;;=354.3^^79^618^44
 ;;^UTILITY(U,$J,358.3,10130,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10130,1,3,0)
 ;;=3^Radial Nerve Palsy
 ;;^UTILITY(U,$J,358.3,10130,1,4,0)
 ;;=4^354.3
 ;;^UTILITY(U,$J,358.3,10130,2)
 ;;=^268507
 ;;^UTILITY(U,$J,358.3,10131,0)
 ;;=355.0^^79^618^51
 ;;^UTILITY(U,$J,358.3,10131,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10131,1,3,0)
 ;;=3^Sciatic Nerve Palsy
 ;;^UTILITY(U,$J,358.3,10131,1,4,0)
 ;;=4^355.0
 ;;^UTILITY(U,$J,358.3,10131,2)
 ;;=^268513
 ;;^UTILITY(U,$J,358.3,10132,0)
 ;;=958.90^^79^618^10
 ;;^UTILITY(U,$J,358.3,10132,1,0)
 ;;=^358.31IA^4^2
 ;;^UTILITY(U,$J,358.3,10132,1,3,0)
 ;;=3^Compartment Syndrome,Unspec
