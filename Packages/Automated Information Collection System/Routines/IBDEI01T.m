IBDEI01T ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.3)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.3,2047,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2047,1,2,0)
 ;;=2^701.3
 ;;^UTILITY(U,$J,358.3,2047,1,5,0)
 ;;=5^Striae Atrophicae
 ;;^UTILITY(U,$J,358.3,2047,2)
 ;;=^265898
 ;;^UTILITY(U,$J,358.3,2048,0)
 ;;=V10.83^^27^205^0
 ;;^UTILITY(U,$J,358.3,2048,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2048,1,2,0)
 ;;=2^V10.83
 ;;^UTILITY(U,$J,358.3,2048,1,5,0)
 ;;=5^History of Skin Cancer (excised)
 ;;^UTILITY(U,$J,358.3,2048,2)
 ;;=History of Skin Cancer^295241
 ;;^UTILITY(U,$J,358.3,2049,0)
 ;;=173.00^^27^205^1
 ;;^UTILITY(U,$J,358.3,2049,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2049,1,2,0)
 ;;=2^173.00
 ;;^UTILITY(U,$J,358.3,2049,1,5,0)
 ;;=5^Malig Neopl Lip NOS
 ;;^UTILITY(U,$J,358.3,2049,2)
 ;;=^340596
 ;;^UTILITY(U,$J,358.3,2050,0)
 ;;=173.01^^27^205^2
 ;;^UTILITY(U,$J,358.3,2050,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2050,1,2,0)
 ;;=2^173.01
 ;;^UTILITY(U,$J,358.3,2050,1,5,0)
 ;;=5^BCC of skin of lip
 ;;^UTILITY(U,$J,358.3,2050,2)
 ;;=^340464
 ;;^UTILITY(U,$J,358.3,2051,0)
 ;;=173.02^^27^205^3
 ;;^UTILITY(U,$J,358.3,2051,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2051,1,2,0)
 ;;=2^173.02
 ;;^UTILITY(U,$J,358.3,2051,1,5,0)
 ;;=5^SCC of skin of lip
 ;;^UTILITY(U,$J,358.3,2051,2)
 ;;=^340465
 ;;^UTILITY(U,$J,358.3,2052,0)
 ;;=173.09^^27^205^4
 ;;^UTILITY(U,$J,358.3,2052,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2052,1,2,0)
 ;;=2^173.09
 ;;^UTILITY(U,$J,358.3,2052,1,5,0)
 ;;=5^Other specified neoplasm of lip
 ;;^UTILITY(U,$J,358.3,2052,2)
 ;;=^340466
 ;;^UTILITY(U,$J,358.3,2053,0)
 ;;=173.10^^27^205^5
 ;;^UTILITY(U,$J,358.3,2053,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2053,1,2,0)
 ;;=2^173.10
 ;;^UTILITY(U,$J,358.3,2053,1,5,0)
 ;;=5^Malig neoplasm of eyelid NOS
 ;;^UTILITY(U,$J,358.3,2053,2)
 ;;=^340597
 ;;^UTILITY(U,$J,358.3,2054,0)
 ;;=173.11^^27^205^6
 ;;^UTILITY(U,$J,358.3,2054,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2054,1,2,0)
 ;;=2^173.11
 ;;^UTILITY(U,$J,358.3,2054,1,5,0)
 ;;=5^BCC of skin of eyelid/canthus
 ;;^UTILITY(U,$J,358.3,2054,2)
 ;;=^340467
 ;;^UTILITY(U,$J,358.3,2055,0)
 ;;=173.12^^27^205^7
 ;;^UTILITY(U,$J,358.3,2055,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2055,1,2,0)
 ;;=2^173.12
 ;;^UTILITY(U,$J,358.3,2055,1,5,0)
 ;;=5^SCC of skin of eyelid/canthus
 ;;^UTILITY(U,$J,358.3,2055,2)
 ;;=^340468
 ;;^UTILITY(U,$J,358.3,2056,0)
 ;;=173.19^^27^205^8
 ;;^UTILITY(U,$J,358.3,2056,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2056,1,2,0)
 ;;=2^173.19
 ;;^UTILITY(U,$J,358.3,2056,1,5,0)
 ;;=5^Other specified neoplasm eyelid
 ;;^UTILITY(U,$J,358.3,2056,2)
 ;;=^340469
 ;;^UTILITY(U,$J,358.3,2057,0)
 ;;=173.20^^27^205^9
 ;;^UTILITY(U,$J,358.3,2057,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2057,1,2,0)
 ;;=2^173.20
 ;;^UTILITY(U,$J,358.3,2057,1,5,0)
 ;;=5^Malig neoplasm skin, ear/ear canal NOS
 ;;^UTILITY(U,$J,358.3,2057,2)
 ;;=^340598
 ;;^UTILITY(U,$J,358.3,2058,0)
 ;;=173.21^^27^205^10
 ;;^UTILITY(U,$J,358.3,2058,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2058,1,2,0)
 ;;=2^173.21
 ;;^UTILITY(U,$J,358.3,2058,1,5,0)
 ;;=5^BCC of skin of ear/ear canal
 ;;^UTILITY(U,$J,358.3,2058,2)
 ;;=^340470
 ;;^UTILITY(U,$J,358.3,2059,0)
 ;;=173.22^^27^205^11
 ;;^UTILITY(U,$J,358.3,2059,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2059,1,2,0)
 ;;=2^173.22
 ;;^UTILITY(U,$J,358.3,2059,1,5,0)
 ;;=5^SCC of skin of ear/ear canal
 ;;^UTILITY(U,$J,358.3,2059,2)
 ;;=^340471
 ;;^UTILITY(U,$J,358.3,2060,0)
 ;;=173.29^^27^205^12
 ;;^UTILITY(U,$J,358.3,2060,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2060,1,2,0)
 ;;=2^173.29
 ;;^UTILITY(U,$J,358.3,2060,1,5,0)
 ;;=5^Other spec neoplasm skin, ear/ear canal
 ;;^UTILITY(U,$J,358.3,2060,2)
 ;;=^340472
 ;;^UTILITY(U,$J,358.3,2061,0)
 ;;=173.30^^27^205^13
 ;;^UTILITY(U,$J,358.3,2061,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2061,1,2,0)
 ;;=2^173.30
 ;;^UTILITY(U,$J,358.3,2061,1,5,0)
 ;;=5^Malig neoplasm skin, face NOS
 ;;^UTILITY(U,$J,358.3,2061,2)
 ;;=^340599
 ;;^UTILITY(U,$J,358.3,2062,0)
 ;;=173.31^^27^205^14
 ;;^UTILITY(U,$J,358.3,2062,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2062,1,2,0)
 ;;=2^173.31
 ;;^UTILITY(U,$J,358.3,2062,1,5,0)
 ;;=5^BCC of skin of face
 ;;^UTILITY(U,$J,358.3,2062,2)
 ;;=^340473
 ;;^UTILITY(U,$J,358.3,2063,0)
 ;;=173.32^^27^205^15
 ;;^UTILITY(U,$J,358.3,2063,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2063,1,2,0)
 ;;=2^173.32
 ;;^UTILITY(U,$J,358.3,2063,1,5,0)
 ;;=5^SCC of skin of face
 ;;^UTILITY(U,$J,358.3,2063,2)
 ;;=^340474
 ;;^UTILITY(U,$J,358.3,2064,0)
 ;;=173.39^^27^205^16
 ;;^UTILITY(U,$J,358.3,2064,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2064,1,2,0)
 ;;=2^173.39
 ;;^UTILITY(U,$J,358.3,2064,1,5,0)
 ;;=5^Other spec neoplasm skin, face
 ;;^UTILITY(U,$J,358.3,2064,2)
 ;;=^340475
 ;;^UTILITY(U,$J,358.3,2065,0)
 ;;=173.40^^27^205^17
 ;;^UTILITY(U,$J,358.3,2065,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2065,1,2,0)
 ;;=2^173.40
 ;;^UTILITY(U,$J,358.3,2065,1,5,0)
 ;;=5^Malig neoplasm skin, scalp/neck
 ;;^UTILITY(U,$J,358.3,2065,2)
 ;;=^340600
 ;;^UTILITY(U,$J,358.3,2066,0)
 ;;=173.41^^27^205^18
 ;;^UTILITY(U,$J,358.3,2066,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2066,1,2,0)
 ;;=2^173.41
 ;;^UTILITY(U,$J,358.3,2066,1,5,0)
 ;;=5^BCC of skin of scalp/neck
 ;;^UTILITY(U,$J,358.3,2066,2)
 ;;=^340476
 ;;^UTILITY(U,$J,358.3,2067,0)
 ;;=173.42^^27^205^19
 ;;^UTILITY(U,$J,358.3,2067,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2067,1,2,0)
 ;;=2^173.42
 ;;^UTILITY(U,$J,358.3,2067,1,5,0)
 ;;=5^SCC of skin of scalp/neck
 ;;^UTILITY(U,$J,358.3,2067,2)
 ;;=^340477
 ;;^UTILITY(U,$J,358.3,2068,0)
 ;;=173.49^^27^205^20
 ;;^UTILITY(U,$J,358.3,2068,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2068,1,2,0)
 ;;=2^173.49
 ;;^UTILITY(U,$J,358.3,2068,1,5,0)
 ;;=5^Other spec neoplasm skin, scalp/neck
 ;;^UTILITY(U,$J,358.3,2068,2)
 ;;=^340478
 ;;^UTILITY(U,$J,358.3,2069,0)
 ;;=173.50^^27^205^21
 ;;^UTILITY(U,$J,358.3,2069,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2069,1,2,0)
 ;;=2^173.50
 ;;^UTILITY(U,$J,358.3,2069,1,5,0)
 ;;=5^Malig neoplasm skin, trunk
 ;;^UTILITY(U,$J,358.3,2069,2)
 ;;=^340601
 ;;^UTILITY(U,$J,358.3,2070,0)
 ;;=173.51^^27^205^22
 ;;^UTILITY(U,$J,358.3,2070,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2070,1,2,0)
 ;;=2^173.51
 ;;^UTILITY(U,$J,358.3,2070,1,5,0)
 ;;=5^BCC of skin of trunk
 ;;^UTILITY(U,$J,358.3,2070,2)
 ;;=^340479
 ;;^UTILITY(U,$J,358.3,2071,0)
 ;;=173.52^^27^205^23
 ;;^UTILITY(U,$J,358.3,2071,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2071,1,2,0)
 ;;=2^173.52
 ;;^UTILITY(U,$J,358.3,2071,1,5,0)
 ;;=5^SCC of skin of trunk
 ;;^UTILITY(U,$J,358.3,2071,2)
 ;;=^340480
 ;;^UTILITY(U,$J,358.3,2072,0)
 ;;=173.59^^27^205^24
 ;;^UTILITY(U,$J,358.3,2072,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2072,1,2,0)
 ;;=2^173.59
 ;;^UTILITY(U,$J,358.3,2072,1,5,0)
 ;;=5^Other spec neoplasm skin, trunk
 ;;^UTILITY(U,$J,358.3,2072,2)
 ;;=^340481
 ;;^UTILITY(U,$J,358.3,2073,0)
 ;;=173.60^^27^205^25
 ;;^UTILITY(U,$J,358.3,2073,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2073,1,2,0)
 ;;=2^173.60
 ;;^UTILITY(U,$J,358.3,2073,1,5,0)
 ;;=5^Malig neoplasm skin, arm/shoulder
 ;;^UTILITY(U,$J,358.3,2073,2)
 ;;=^340602
 ;;^UTILITY(U,$J,358.3,2074,0)
 ;;=173.61^^27^205^26
 ;;^UTILITY(U,$J,358.3,2074,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2074,1,2,0)
 ;;=2^173.61
 ;;^UTILITY(U,$J,358.3,2074,1,5,0)
 ;;=5^BCC of skin of arm/shoulder
 ;;^UTILITY(U,$J,358.3,2074,2)
 ;;=^340482
 ;;^UTILITY(U,$J,358.3,2075,0)
 ;;=173.62^^27^205^27
 ;;^UTILITY(U,$J,358.3,2075,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2075,1,2,0)
 ;;=2^173.62
 ;;^UTILITY(U,$J,358.3,2075,1,5,0)
 ;;=5^SCC of skin of arm/shoulder
 ;;^UTILITY(U,$J,358.3,2075,2)
 ;;=^340483
 ;;^UTILITY(U,$J,358.3,2076,0)
 ;;=173.69^^27^205^28
 ;;^UTILITY(U,$J,358.3,2076,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2076,1,2,0)
 ;;=2^173.69
 ;;^UTILITY(U,$J,358.3,2076,1,5,0)
 ;;=5^Other spec neoplasm skin, arm/shoulder
 ;;^UTILITY(U,$J,358.3,2076,2)
 ;;=^340484
 ;;^UTILITY(U,$J,358.3,2077,0)
 ;;=173.70^^27^205^29
 ;;^UTILITY(U,$J,358.3,2077,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2077,1,2,0)
 ;;=2^173.70
 ;;^UTILITY(U,$J,358.3,2077,1,5,0)
 ;;=5^Malig neoplasm skin, leg/hip
 ;;^UTILITY(U,$J,358.3,2077,2)
 ;;=^340603
 ;;^UTILITY(U,$J,358.3,2078,0)
 ;;=173.71^^27^205^30
 ;;^UTILITY(U,$J,358.3,2078,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2078,1,2,0)
 ;;=2^173.71
 ;;^UTILITY(U,$J,358.3,2078,1,5,0)
 ;;=5^BCC of skin of leg/hip
 ;;^UTILITY(U,$J,358.3,2078,2)
 ;;=^340485
 ;;^UTILITY(U,$J,358.3,2079,0)
 ;;=173.72^^27^205^31
 ;;^UTILITY(U,$J,358.3,2079,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2079,1,2,0)
 ;;=2^173.72
 ;;^UTILITY(U,$J,358.3,2079,1,5,0)
 ;;=5^SCC of skin of leg/hip
 ;;^UTILITY(U,$J,358.3,2079,2)
 ;;=^340486
 ;;^UTILITY(U,$J,358.3,2080,0)
 ;;=173.79^^27^205^32
 ;;^UTILITY(U,$J,358.3,2080,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2080,1,2,0)
 ;;=2^173.79
 ;;^UTILITY(U,$J,358.3,2080,1,5,0)
 ;;=5^Other spec neoplasm skin, leg/hip
 ;;^UTILITY(U,$J,358.3,2080,2)
 ;;=^340487
 ;;^UTILITY(U,$J,358.3,2081,0)
 ;;=173.80^^27^205^33
 ;;^UTILITY(U,$J,358.3,2081,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2081,1,2,0)
 ;;=2^173.80
 ;;^UTILITY(U,$J,358.3,2081,1,5,0)
 ;;=5^Malig neoplasm skin, other sites NOS
 ;;^UTILITY(U,$J,358.3,2081,2)
 ;;=^340604
 ;;^UTILITY(U,$J,358.3,2082,0)
 ;;=173.81^^27^205^34
 ;;^UTILITY(U,$J,358.3,2082,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2082,1,2,0)
 ;;=2^173.81
 ;;^UTILITY(U,$J,358.3,2082,1,5,0)
 ;;=5^BCC of skin of specified sites
 ;;^UTILITY(U,$J,358.3,2082,2)
 ;;=^340488
 ;;^UTILITY(U,$J,358.3,2083,0)
 ;;=173.82^^27^205^35
 ;;^UTILITY(U,$J,358.3,2083,1,0)
 ;;=^358.31IA^5^2
 ;;^UTILITY(U,$J,358.3,2083,1,2,0)
 ;;=2^173.82
 ;;^UTILITY(U,$J,358.3,2083,1,5,0)
 ;;=5^SCC of skin of specified sites
 ;;^UTILITY(U,$J,358.3,2083,2)
 ;;=^340489
 ;;^UTILITY(U,$J,358.3,2084,0)
 ;;=173.89^^27^205^36
 ;;^UTILITY(U,$J,358.3,2084,1,0)
 ;;=^358.31IA^5^2
