IBDEI030 ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,3715,1,4,0)
 ;;=4^V70.0
 ;;^UTILITY(U,$J,358.3,3715,1,5,0)
 ;;=5^Routine Med Exam
 ;;^UTILITY(U,$J,358.3,3715,2)
 ;;=^295590
 ;;^UTILITY(U,$J,358.3,3716,0)
 ;;=V77.91^^36^278^3
 ;;^UTILITY(U,$J,358.3,3716,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3716,1,4,0)
 ;;=4^V77.91
 ;;^UTILITY(U,$J,358.3,3716,1,5,0)
 ;;=5^Screen For High Cholesterol
 ;;^UTILITY(U,$J,358.3,3716,2)
 ;;=Screen for High Cholesterol^322093
 ;;^UTILITY(U,$J,358.3,3717,0)
 ;;=V76.44^^36^278^4
 ;;^UTILITY(U,$J,358.3,3717,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3717,1,4,0)
 ;;=4^V76.44
 ;;^UTILITY(U,$J,358.3,3717,1,5,0)
 ;;=5^Screen For Prostate Ca
 ;;^UTILITY(U,$J,358.3,3717,2)
 ;;=Screen for Prostate CA^321548
 ;;^UTILITY(U,$J,358.3,3718,0)
 ;;=V74.5^^36^278^6
 ;;^UTILITY(U,$J,358.3,3718,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3718,1,4,0)
 ;;=4^V74.5
 ;;^UTILITY(U,$J,358.3,3718,1,5,0)
 ;;=5^Screening For Std'S
 ;;^UTILITY(U,$J,358.3,3718,2)
 ;;=Screening for STD's^295637
 ;;^UTILITY(U,$J,358.3,3719,0)
 ;;=V73.89^^36^278^5
 ;;^UTILITY(U,$J,358.3,3719,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3719,1,4,0)
 ;;=4^V73.89
 ;;^UTILITY(U,$J,358.3,3719,1,5,0)
 ;;=5^Screening For Hiv
 ;;^UTILITY(U,$J,358.3,3719,2)
 ;;=^295833
 ;;^UTILITY(U,$J,358.3,3720,0)
 ;;=919.1^^36^279^1
 ;;^UTILITY(U,$J,358.3,3720,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3720,1,4,0)
 ;;=4^919.1
 ;;^UTILITY(U,$J,358.3,3720,1,5,0)
 ;;=5^Abrasion, Infected
 ;;^UTILITY(U,$J,358.3,3720,2)
 ;;=^275358
 ;;^UTILITY(U,$J,358.3,3721,0)
 ;;=919.0^^36^279^2
 ;;^UTILITY(U,$J,358.3,3721,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3721,1,4,0)
 ;;=4^919.0
 ;;^UTILITY(U,$J,358.3,3721,1,5,0)
 ;;=5^Abrasion, Not Infected
 ;;^UTILITY(U,$J,358.3,3721,2)
 ;;=^1305
 ;;^UTILITY(U,$J,358.3,3722,0)
 ;;=924.9^^36^279^3
 ;;^UTILITY(U,$J,358.3,3722,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3722,1,4,0)
 ;;=4^924.9
 ;;^UTILITY(U,$J,358.3,3722,1,5,0)
 ;;=5^Bite, Human, Contusion
 ;;^UTILITY(U,$J,358.3,3722,2)
 ;;=^28117
 ;;^UTILITY(U,$J,358.3,3723,0)
 ;;=879.8^^36^279^4
 ;;^UTILITY(U,$J,358.3,3723,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3723,1,4,0)
 ;;=4^879.8
 ;;^UTILITY(U,$J,358.3,3723,1,5,0)
 ;;=5^Bite, Human, Penetrating
 ;;^UTILITY(U,$J,358.3,3723,2)
 ;;=^275021
 ;;^UTILITY(U,$J,358.3,3724,0)
 ;;=919.3^^36^279^5
 ;;^UTILITY(U,$J,358.3,3724,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3724,1,4,0)
 ;;=4^919.3
 ;;^UTILITY(U,$J,358.3,3724,1,5,0)
 ;;=5^Blister, Infected
 ;;^UTILITY(U,$J,358.3,3724,2)
 ;;=^275359
 ;;^UTILITY(U,$J,358.3,3725,0)
 ;;=919.2^^36^279^6
 ;;^UTILITY(U,$J,358.3,3725,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3725,1,4,0)
 ;;=4^919.2
 ;;^UTILITY(U,$J,358.3,3725,1,5,0)
 ;;=5^Blister, Not Infected
 ;;^UTILITY(U,$J,358.3,3725,2)
 ;;=^15350
 ;;^UTILITY(U,$J,358.3,3726,0)
 ;;=919.5^^36^279^7
 ;;^UTILITY(U,$J,358.3,3726,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3726,1,4,0)
 ;;=4^919.5
 ;;^UTILITY(U,$J,358.3,3726,1,5,0)
 ;;=5^Insect Bite, Infected
 ;;^UTILITY(U,$J,358.3,3726,2)
 ;;=^275360
 ;;^UTILITY(U,$J,358.3,3727,0)
 ;;=919.4^^36^279^8
 ;;^UTILITY(U,$J,358.3,3727,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3727,1,4,0)
 ;;=4^919.4
 ;;^UTILITY(U,$J,358.3,3727,1,5,0)
 ;;=5^Insect Bite, Not Infected
 ;;^UTILITY(U,$J,358.3,3727,2)
 ;;=^63612
 ;;^UTILITY(U,$J,358.3,3728,0)
 ;;=919.7^^36^279^9
 ;;^UTILITY(U,$J,358.3,3728,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3728,1,4,0)
 ;;=4^919.7
 ;;^UTILITY(U,$J,358.3,3728,1,5,0)
 ;;=5^Sup Foreign Body Infected
 ;;^UTILITY(U,$J,358.3,3728,2)
 ;;=^275362
 ;;^UTILITY(U,$J,358.3,3729,0)
 ;;=919.6^^36^279^10
 ;;^UTILITY(U,$J,358.3,3729,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3729,1,4,0)
 ;;=4^919.6
 ;;^UTILITY(U,$J,358.3,3729,1,5,0)
 ;;=5^Sup Foreign Body No Infec
 ;;^UTILITY(U,$J,358.3,3729,2)
 ;;=^275361
 ;;^UTILITY(U,$J,358.3,3730,0)
 ;;=919.9^^36^279^11
 ;;^UTILITY(U,$J,358.3,3730,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3730,1,4,0)
 ;;=4^919.9
 ;;^UTILITY(U,$J,358.3,3730,1,5,0)
 ;;=5^Sup Injury, Infected
 ;;^UTILITY(U,$J,358.3,3730,2)
 ;;=^275364
 ;;^UTILITY(U,$J,358.3,3731,0)
 ;;=919.8^^36^279^12
 ;;^UTILITY(U,$J,358.3,3731,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3731,1,4,0)
 ;;=4^919.8
 ;;^UTILITY(U,$J,358.3,3731,1,5,0)
 ;;=5^Sup Injury, Not Infected
 ;;^UTILITY(U,$J,358.3,3731,2)
 ;;=^275363
 ;;^UTILITY(U,$J,358.3,3732,0)
 ;;=840.0^^36^279^13
 ;;^UTILITY(U,$J,358.3,3732,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3732,1,4,0)
 ;;=4^840.0
 ;;^UTILITY(U,$J,358.3,3732,1,5,0)
 ;;=5^Shoulder Sprain
 ;;^UTILITY(U,$J,358.3,3732,2)
 ;;=Shoulder Sprain^274465
 ;;^UTILITY(U,$J,358.3,3733,0)
 ;;=840.4^^36^279^14
 ;;^UTILITY(U,$J,358.3,3733,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3733,1,4,0)
 ;;=4^840.4
 ;;^UTILITY(U,$J,358.3,3733,1,5,0)
 ;;=5^Sprain, Rotator Cuff
 ;;^UTILITY(U,$J,358.3,3733,2)
 ;;=Sprain, Rotator Cuff^274469
 ;;^UTILITY(U,$J,358.3,3734,0)
 ;;=841.9^^36^279^15
 ;;^UTILITY(U,$J,358.3,3734,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3734,1,4,0)
 ;;=4^841.9
 ;;^UTILITY(U,$J,358.3,3734,1,5,0)
 ;;=5^Sprain, Elbow
 ;;^UTILITY(U,$J,358.3,3734,2)
 ;;=Sprain, Elbow^274480
 ;;^UTILITY(U,$J,358.3,3735,0)
 ;;=842.00^^36^279^16
 ;;^UTILITY(U,$J,358.3,3735,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3735,1,4,0)
 ;;=4^842.00
 ;;^UTILITY(U,$J,358.3,3735,1,5,0)
 ;;=5^Sprain, Wrist
 ;;^UTILITY(U,$J,358.3,3735,2)
 ;;=Sprain, Wrist^274483
 ;;^UTILITY(U,$J,358.3,3736,0)
 ;;=844.8^^36^279^17
 ;;^UTILITY(U,$J,358.3,3736,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3736,1,4,0)
 ;;=4^844.8
 ;;^UTILITY(U,$J,358.3,3736,1,5,0)
 ;;=5^Sprain Of Knee
 ;;^UTILITY(U,$J,358.3,3736,2)
 ;;=Sprain of Knee^274503
 ;;^UTILITY(U,$J,358.3,3737,0)
 ;;=845.00^^36^279^18
 ;;^UTILITY(U,$J,358.3,3737,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3737,1,4,0)
 ;;=4^845.00
 ;;^UTILITY(U,$J,358.3,3737,1,5,0)
 ;;=5^Sprain, Ankle
 ;;^UTILITY(U,$J,358.3,3737,2)
 ;;=^274507
 ;;^UTILITY(U,$J,358.3,3738,0)
 ;;=919.1^^36^280^27
 ;;^UTILITY(U,$J,358.3,3738,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3738,1,4,0)
 ;;=4^919.1
 ;;^UTILITY(U,$J,358.3,3738,1,5,0)
 ;;=5^Abrasion, Infected
 ;;^UTILITY(U,$J,358.3,3738,2)
 ;;=^275358
 ;;^UTILITY(U,$J,358.3,3739,0)
 ;;=919.0^^36^280^28
 ;;^UTILITY(U,$J,358.3,3739,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3739,1,4,0)
 ;;=4^919.0
 ;;^UTILITY(U,$J,358.3,3739,1,5,0)
 ;;=5^Abrasion, Not Infected
 ;;^UTILITY(U,$J,358.3,3739,2)
 ;;=^1305
 ;;^UTILITY(U,$J,358.3,3740,0)
 ;;=780.02^^36^280^30
 ;;^UTILITY(U,$J,358.3,3740,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3740,1,4,0)
 ;;=4^780.02
 ;;^UTILITY(U,$J,358.3,3740,1,5,0)
 ;;=5^Altered Awareness, Transient
 ;;^UTILITY(U,$J,358.3,3740,2)
 ;;=^293932
 ;;^UTILITY(U,$J,358.3,3741,0)
 ;;=780.01^^36^280^31
 ;;^UTILITY(U,$J,358.3,3741,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3741,1,4,0)
 ;;=4^780.01
 ;;^UTILITY(U,$J,358.3,3741,1,5,0)
 ;;=5^Altered Consciousness, Coma
 ;;^UTILITY(U,$J,358.3,3741,2)
 ;;=^263540
 ;;^UTILITY(U,$J,358.3,3742,0)
 ;;=783.0^^36^280^32
 ;;^UTILITY(U,$J,358.3,3742,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3742,1,4,0)
 ;;=4^783.0
 ;;^UTILITY(U,$J,358.3,3742,1,5,0)
 ;;=5^Anorexia
 ;;^UTILITY(U,$J,358.3,3742,2)
 ;;=Anorexia^7939
 ;;^UTILITY(U,$J,358.3,3743,0)
 ;;=V58.61^^36^280^33
 ;;^UTILITY(U,$J,358.3,3743,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3743,1,4,0)
 ;;=4^V58.61
 ;;^UTILITY(U,$J,358.3,3743,1,5,0)
 ;;=5^Anticoagulant Rx, Long Term
 ;;^UTILITY(U,$J,358.3,3743,2)
 ;;=^303459
 ;;^UTILITY(U,$J,358.3,3744,0)
 ;;=724.2^^36^280^115
 ;;^UTILITY(U,$J,358.3,3744,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3744,1,4,0)
 ;;=4^724.2
 ;;^UTILITY(U,$J,358.3,3744,1,5,0)
 ;;=5^Low Back Pain
 ;;^UTILITY(U,$J,358.3,3744,2)
 ;;=^71885
 ;;^UTILITY(U,$J,358.3,3745,0)
 ;;=724.5^^36^280^37
 ;;^UTILITY(U,$J,358.3,3745,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3745,1,4,0)
 ;;=4^724.5
 ;;^UTILITY(U,$J,358.3,3745,1,5,0)
 ;;=5^Back Pain, Thoracic
 ;;^UTILITY(U,$J,358.3,3745,2)
 ;;=^12250
 ;;^UTILITY(U,$J,358.3,3746,0)
 ;;=919.3^^36^280^39
 ;;^UTILITY(U,$J,358.3,3746,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3746,1,4,0)
 ;;=4^919.3
 ;;^UTILITY(U,$J,358.3,3746,1,5,0)
 ;;=5^Blister, Infected
 ;;^UTILITY(U,$J,358.3,3746,2)
 ;;=^275359
 ;;^UTILITY(U,$J,358.3,3747,0)
 ;;=919.2^^36^280^40
 ;;^UTILITY(U,$J,358.3,3747,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3747,1,4,0)
 ;;=4^919.2
 ;;^UTILITY(U,$J,358.3,3747,1,5,0)
 ;;=5^Blister, Not Infected
 ;;^UTILITY(U,$J,358.3,3747,2)
 ;;=^15350
 ;;^UTILITY(U,$J,358.3,3748,0)
 ;;=799.4^^36^280^42
 ;;^UTILITY(U,$J,358.3,3748,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3748,1,4,0)
 ;;=4^799.4
 ;;^UTILITY(U,$J,358.3,3748,1,5,0)
 ;;=5^Cachexia
 ;;^UTILITY(U,$J,358.3,3748,2)
 ;;=Cachexia^17920
 ;;^UTILITY(U,$J,358.3,3749,0)
 ;;=780.71^^36^280^48
 ;;^UTILITY(U,$J,358.3,3749,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3749,1,4,0)
 ;;=4^780.71
 ;;^UTILITY(U,$J,358.3,3749,1,5,0)
 ;;=5^Chronic Fatigue Syndrome
 ;;^UTILITY(U,$J,358.3,3749,2)
 ;;=^304659
 ;;^UTILITY(U,$J,358.3,3750,0)
 ;;=781.5^^36^280^49
 ;;^UTILITY(U,$J,358.3,3750,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3750,1,4,0)
 ;;=4^781.5
 ;;^UTILITY(U,$J,358.3,3750,1,5,0)
 ;;=5^Clubbing Of Fingers
 ;;^UTILITY(U,$J,358.3,3750,2)
 ;;=^273354
 ;;^UTILITY(U,$J,358.3,3751,0)
 ;;=780.39^^36^280^145
 ;;^UTILITY(U,$J,358.3,3751,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3751,1,4,0)
 ;;=4^780.39
 ;;^UTILITY(U,$J,358.3,3751,1,5,0)
 ;;=5^Seizures
 ;;^UTILITY(U,$J,358.3,3751,2)
 ;;=Seizures^28162
 ;;^UTILITY(U,$J,358.3,3752,0)
 ;;=780.4^^36^280^61
 ;;^UTILITY(U,$J,358.3,3752,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,3752,1,4,0)
 ;;=4^780.4
 ;;^UTILITY(U,$J,358.3,3752,1,5,0)
 ;;=5^Dizziness And Giddiness
 ;;^UTILITY(U,$J,358.3,3752,2)
 ;;=^35946
 ;;^UTILITY(U,$J,358.3,3753,0)
 ;;=782.3^^36^280^72
 ;;^UTILITY(U,$J,358.3,3753,1,0)
 ;;=^358.31IA^5^2
