IBDEI0AX ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,512,0)
 ;;=ORGANIC DISORDERS^12^67
 ;;^UTILITY(U,$J,358.4,513,0)
 ;;=DEMENTIA^7^67
 ;;^UTILITY(U,$J,358.4,514,0)
 ;;=DELIRIUM^6^67
 ;;^UTILITY(U,$J,358.4,515,0)
 ;;=BIPOLAR DISORDERS^5^67
 ;;^UTILITY(U,$J,358.4,516,0)
 ;;=PSYCHOSIS/OTHER^14^67
 ;;^UTILITY(U,$J,358.4,517,0)
 ;;=PERSONALITY DISORDERS^13^67
 ;;^UTILITY(U,$J,358.4,518,0)
 ;;=SEXUAL DISORDERS^16^67
 ;;^UTILITY(U,$J,358.4,519,0)
 ;;=SLEEP DISORDERS^17^67
 ;;^UTILITY(U,$J,358.4,520,0)
 ;;=OTHER DISORDERS^21^67
 ;;^UTILITY(U,$J,358.4,521,0)
 ;;=SUBSTANCE RELATED DISORDERS^19^67
 ;;^UTILITY(U,$J,358.4,522,0)
 ;;=V CODES^20^67
 ;;^UTILITY(U,$J,358.4,523,0)
 ;;=PREVENTION/COUNSELING/SCREEN^22^67
 ;;^UTILITY(U,$J,358.4,524,0)
 ;;=DEPRESSION^8^67
 ;;^UTILITY(U,$J,358.4,525,0)
 ;;=MOOD DISORDERS (OTHER)^10^67
 ;;^UTILITY(U,$J,358.4,526,0)
 ;;=SCHIZOPHRENIA^15^67
 ;;^UTILITY(U,$J,358.4,527,0)
 ;;=SOMATIFORM DISORDERS^18^67
 ;;^UTILITY(U,$J,358.4,528,0)
 ;;=EATING DISORDERS^9^67
 ;;^UTILITY(U,$J,358.4,529,0)
 ;;=NEUROLEPTIC-INDUCED MOVEMENT DISORD^11^67
 ;;^UTILITY(U,$J,358.4,530,0)
 ;;=BRAIN DAMAGE DISORDERS^4^67
 ;;^UTILITY(U,$J,358.4,531,0)
 ;;=PRIMARY DIAGNOSIS^1^68
 ;;^UTILITY(U,$J,358.4,532,0)
 ;;=AFFECTIVE PSYCHOSIS^1^69
 ;;^UTILITY(U,$J,358.4,533,0)
 ;;=ALCOHOL DEPENDENCE^3^69
 ;;^UTILITY(U,$J,358.4,534,0)
 ;;=ALCOHOL PSYCHOSIS^4^69
 ;;^UTILITY(U,$J,358.4,535,0)
 ;;=DRUG DEPENDENCE^5^69
 ;;^UTILITY(U,$J,358.4,536,0)
 ;;=DRUG PSYCHOSIS^6^69
 ;;^UTILITY(U,$J,358.4,537,0)
 ;;=NEUROTIC/PHOBIC DISORDERS^13^69
 ;;^UTILITY(U,$J,358.4,538,0)
 ;;=NONDEPENDENT ABUSE OF DRUGS/ALCOHOL^7^69
 ;;^UTILITY(U,$J,358.4,539,0)
 ;;=DEMENTIA^8^69
 ;;^UTILITY(U,$J,358.4,540,0)
 ;;=OTHER NONORGANIC PSYCHOSES^11^69
 ;;^UTILITY(U,$J,358.4,541,0)
 ;;=DELUSIONAL DISORDERS^10^69
 ;;^UTILITY(U,$J,358.4,542,0)
 ;;=PERSONALITY DISORDERS^14^69
 ;;^UTILITY(U,$J,358.4,543,0)
 ;;=ACUTE REACTION TO STRESS^17^69
 ;;^UTILITY(U,$J,358.4,544,0)
 ;;=SCHIZOPHRENIC DISORDERS^2^69
 ;;^UTILITY(U,$J,358.4,545,0)
 ;;=SEXUAL DEVIATIONS AND DISORDERS^15^69
 ;;^UTILITY(U,$J,358.4,546,0)
 ;;=TRANSIENT ORGANIC PSYCHOTIC DISORDERS^9^69
 ;;^UTILITY(U,$J,358.4,547,0)
 ;;=SPECIFIC DISORDERS ORGANIC BRAIN DAMAGE^16^69
 ;;^UTILITY(U,$J,358.4,548,0)
 ;;=OTHER^19^69
 ;;^UTILITY(U,$J,358.4,549,0)
 ;;=ANXIETY DISORDERS^12^69
 ;;^UTILITY(U,$J,358.4,550,0)
 ;;=ADJUSTMENT REACTION^18^69
 ;;^UTILITY(U,$J,358.4,551,0)
 ;;=COMMONLY USED CODES^.01^69
 ;;^UTILITY(U,$J,358.4,552,0)
 ;;=SECONDARY DX ONLY^20^69
 ;;^UTILITY(U,$J,358.4,553,0)
 ;;=NEW PATIENT^1^70
 ;;^UTILITY(U,$J,358.4,554,0)
 ;;=ESTABLISHED PATIENT^2^70
 ;;^UTILITY(U,$J,358.4,555,0)
 ;;=EDUCATION & TRAINING FOR SELF MANAGEMENT^3^70
 ;;^UTILITY(U,$J,358.4,556,0)
 ;;=ESTABLISHED PATIENT^1^71
 ;;^UTILITY(U,$J,358.4,557,0)
 ;;=CONSULTATIONS/OPINIONS^2^71
 ;;^UTILITY(U,$J,358.4,558,0)
 ;;=NEWPATIENTS^3^71
 ;;^UTILITY(U,$J,358.4,559,0)
 ;;=CEREBROVASCULAR DIS^2^72
 ;;^UTILITY(U,$J,358.4,560,0)
 ;;=SEIZURES/EPILEPSY/SPELLS^5^72
 ;;^UTILITY(U,$J,358.4,561,0)
 ;;=HEADACHE^6^72
 ;;^UTILITY(U,$J,358.4,562,0)
 ;;=DIZZINESS^3^72
 ;;^UTILITY(U,$J,358.4,563,0)
 ;;=NEURODEGENERATIVE DIS^9^72
 ;;^UTILITY(U,$J,358.4,564,0)
 ;;=PAIN^12^72
 ;;^UTILITY(U,$J,358.4,565,0)
 ;;=NEUROPATHIES^10^72
 ;;^UTILITY(U,$J,358.4,566,0)
 ;;=ENCEPALOPATHY^4^72
 ;;^UTILITY(U,$J,358.4,567,0)
 ;;=SPINAL CONDITIONS^14^72
 ;;^UTILITY(U,$J,358.4,568,0)
 ;;=VISION DISTURBANCES^16^72
 ;;^UTILITY(U,$J,358.4,569,0)
 ;;=MOVEMENT DISORDERS^15^72
 ;;^UTILITY(U,$J,358.4,570,0)
 ;;=OTHER^13^72
 ;;^UTILITY(U,$J,358.4,571,0)
 ;;=CARDIAC DISORDERS^1^72
 ;;^UTILITY(U,$J,358.4,572,0)
 ;;=NEOPLASMS^8^72
 ;;^UTILITY(U,$J,358.4,573,0)
 ;;=SYMPTOMS^17^72
 ;;^UTILITY(U,$J,358.4,574,0)
 ;;=NEUROLOGY/SEIZURE^1^73
 ;;^UTILITY(U,$J,358.4,575,0)
 ;;=EEG^2^73
 ;;^UTILITY(U,$J,358.4,576,0)
 ;;=SLEEP TESTING^3^73
 ;;^UTILITY(U,$J,358.4,577,0)
 ;;=MUSCLE TESTING/EMG^4^73
 ;;^UTILITY(U,$J,358.4,578,0)
 ;;=EVOKED POTENTIAL^5^73
 ;;^UTILITY(U,$J,358.4,579,0)
 ;;=BIOPSY^5.5^73
 ;;^UTILITY(U,$J,358.4,580,0)
 ;;=AUTONOMIC FUNCTION TESTS^8^73
 ;;^UTILITY(U,$J,358.4,581,0)
 ;;=ANEMIA^1^74
 ;;^UTILITY(U,$J,358.4,582,0)
 ;;=COAGULATION DISORDERS^2^74
 ;;^UTILITY(U,$J,358.4,583,0)
 ;;=MYELOID NEOPLASMS & DISORDERS^3^74
 ;;^UTILITY(U,$J,358.4,584,0)
 ;;=LYMPHOID NEOPLASMS^4^74
 ;;^UTILITY(U,$J,358.4,585,0)
 ;;=GI CANCER^5^74
 ;;^UTILITY(U,$J,358.4,586,0)
 ;;=HEAD, NECK & LUNG NEOPLASMS^6^74
 ;;^UTILITY(U,$J,358.4,587,0)
 ;;=MISC. NEOPLASMS^7^74
 ;;^UTILITY(U,$J,358.4,588,0)
 ;;=METASTATIC SITES^8^74
 ;;^UTILITY(U,$J,358.4,589,0)
 ;;=COUNSELING & SCREENING^9^74
 ;;^UTILITY(U,$J,358.4,590,0)
 ;;=HEMOGLOBINOPATHIES^1.5^74
 ;;^UTILITY(U,$J,358.4,591,0)
 ;;=GENITOURINARY NEOPLASMS^6.5^74
 ;;^UTILITY(U,$J,358.4,592,0)
 ;;=BREAST & GYN NEOPLASMS^6.75^74
 ;;^UTILITY(U,$J,358.4,593,0)
 ;;=ARTIFICIAL OPENING STATUS^14^74
 ;;^UTILITY(U,$J,358.4,594,0)
 ;;=PERSONAL HX OF CANCER^15^74
 ;;^UTILITY(U,$J,358.4,595,0)
 ;;=SPECIAL SERVICES^5^75
 ;;^UTILITY(U,$J,358.4,596,0)
 ;;=TREATMENT^4^75
 ;;^UTILITY(U,$J,358.4,597,0)
 ;;=MISCELLANEOUS^7^75
 ;;^UTILITY(U,$J,358.4,598,0)
 ;;=IMMUNIZATIONS^6^75
 ;;^UTILITY(U,$J,358.4,599,0)
 ;;=CHEMO ADMINISTRATION^1^75
 ;;^UTILITY(U,$J,358.4,600,0)
 ;;=CHEMO DRUGS^2^75
 ;;^UTILITY(U,$J,358.4,601,0)
 ;;=OTHER DRUGS^3^75
 ;;^UTILITY(U,$J,358.4,602,0)
 ;;=NEW PATIENT^2^76
 ;;^UTILITY(U,$J,358.4,603,0)
 ;;=ESTABLISHED PATIENT^1^76
 ;;^UTILITY(U,$J,358.4,604,0)
 ;;=CONSULTATIONS^3^76
 ;;^UTILITY(U,$J,358.4,605,0)
 ;;=INJECTION/ASPIRATION^2^77
 ;;^UTILITY(U,$J,358.4,606,0)
 ;;=FRACTURE DISLOCATION^3^77
 ;;^UTILITY(U,$J,358.4,607,0)
 ;;=APPLICATION CAST^4^77
 ;;^UTILITY(U,$J,358.4,608,0)
 ;;=APPLICATION SPLINTS^5^77
 ;;^UTILITY(U,$J,358.4,609,0)
 ;;=OTHER/REMOVAL/REVISION^6^77
 ;;^UTILITY(U,$J,358.4,610,0)
 ;;=FOLLOW-UP VISITS^1^77
 ;;^UTILITY(U,$J,358.4,611,0)
 ;;=SUPPLIES/SOFT GOODS^7^77
 ;;^UTILITY(U,$J,358.4,612,0)
 ;;=SUPPLIES/DRUGS^8^77
 ;;^UTILITY(U,$J,358.4,613,0)
 ;;=REPAIR/CLOSURE^9^77
 ;;^UTILITY(U,$J,358.4,614,0)
 ;;=NEW PATIENT^2^78
 ;;^UTILITY(U,$J,358.4,615,0)
 ;;=ESTABLISHED PATIENT^1^78
 ;;^UTILITY(U,$J,358.4,616,0)
 ;;=CONSULTATIONS^3^78
 ;;^UTILITY(U,$J,358.4,617,0)
 ;;=FOOT/TOE^1^79
 ;;^UTILITY(U,$J,358.4,618,0)
 ;;=OTHER^3^79
 ;;^UTILITY(U,$J,358.4,619,0)
 ;;=PAIN^2^79
 ;;^UTILITY(U,$J,358.4,620,0)
 ;;=HAND/FINGER^2^80
 ;;^UTILITY(U,$J,358.4,621,0)
 ;;=WRIST^3^80
 ;;^UTILITY(U,$J,358.4,622,0)
 ;;=FOREARM^4^80
 ;;^UTILITY(U,$J,358.4,623,0)
 ;;=ELBOW^5^80
 ;;^UTILITY(U,$J,358.4,624,0)
 ;;=HUMERUS^1^81
 ;;^UTILITY(U,$J,358.4,625,0)
 ;;=SHOULDER^2^81
 ;;^UTILITY(U,$J,358.4,626,0)
 ;;=SPINE/GENERAL^3^81
 ;;^UTILITY(U,$J,358.4,627,0)
 ;;=CERVICAL SPINE^4^81
 ;;^UTILITY(U,$J,358.4,628,0)
 ;;=THORACIC^5^81
 ;;^UTILITY(U,$J,358.4,629,0)
 ;;=LUMBAR SPINE^6^81
 ;;^UTILITY(U,$J,358.4,630,0)
 ;;=SACRUM/COCCYX^7^81
 ;;^UTILITY(U,$J,358.4,631,0)
 ;;=PELVIS/HIP^8^81
 ;;^UTILITY(U,$J,358.4,632,0)
 ;;=FEMUR/THIGH^4^82
 ;;^UTILITY(U,$J,358.4,633,0)
 ;;=KNEE^5^82
 ;;^UTILITY(U,$J,358.4,634,0)
 ;;=TIBIA/FIBULA^6^82
 ;;^UTILITY(U,$J,358.4,635,0)
 ;;=ANKLE^7^82
 ;;^UTILITY(U,$J,358.4,636,0)
 ;;=SECONDARY DX ONLY^3^83
 ;;^UTILITY(U,$J,358.4,637,0)
 ;;=FOLLOW-UP DIAGNOSIS^2^83
 ;;^UTILITY(U,$J,358.4,638,0)
 ;;=SUTURES/DRESSINGS^1^83
 ;;^UTILITY(U,$J,358.4,639,0)
 ;;=INCISION & DRAINAGE^3^84
 ;;^UTILITY(U,$J,358.4,640,0)
 ;;=DEBRIDEMENT^5^84
 ;;^UTILITY(U,$J,358.4,641,0)
 ;;=SHAVING EPIDERMAL/DERMAL LESIONS^6^84
 ;;^UTILITY(U,$J,358.4,642,0)
 ;;=NAILS^2^84
 ;;^UTILITY(U,$J,358.4,643,0)
 ;;=PARING OR CUTTING^4^84
 ;;^UTILITY(U,$J,358.4,644,0)
 ;;=DESTRUCTION, BENIGN OR PREMALIGANT^7^84
 ;;^UTILITY(U,$J,358.4,645,0)
 ;;=EXCISION-BENIGN LESION (EXCEPT SKIN TAG)^9^84
 ;;^UTILITY(U,$J,358.4,646,0)
 ;;=EXCISION-MALIGNANT LESIONS^10^84
 ;;^UTILITY(U,$J,358.4,647,0)
 ;;=REPAIR/CLOSURE^11^84
 ;;^UTILITY(U,$J,358.4,648,0)
 ;;=BURNS^12^84
 ;;^UTILITY(U,$J,358.4,649,0)
 ;;=OTHER SKIN PROCEDURES^13^84
 ;;^UTILITY(U,$J,358.4,650,0)
 ;;=INJECTIONS^15^84
 ;;^UTILITY(U,$J,358.4,651,0)
 ;;=INJECTION SUBSTANCE^16^84
 ;;^UTILITY(U,$J,358.4,652,0)
 ;;=REPAIR, REVISE and/or RECONSTRUCT^17^84
 ;;^UTILITY(U,$J,358.4,653,0)
 ;;=INCISION - FOOT & TOES^17^84
 ;;^UTILITY(U,$J,358.4,654,0)
 ;;=EXCISION - FOOT & TOES^18^84
 ;;^UTILITY(U,$J,358.4,655,0)
 ;;=OTHER PROCEDURES^19^84
 ;;^UTILITY(U,$J,358.4,656,0)
 ;;=OPEN OR CLOSED TREATMENT OF FRACTURES^20^84
 ;;^UTILITY(U,$J,358.4,657,0)
 ;;=ARTHRODESIS^21^84
 ;;^UTILITY(U,$J,358.4,658,0)
 ;;=CASTS/SPLINTS/STRAPPING APPLICATION^23^84
 ;;^UTILITY(U,$J,358.4,659,0)
 ;;=REMOVAL/REPAIR OF CASTS^24^84
 ;;^UTILITY(U,$J,358.4,660,0)
 ;;=OTHER ORTHOTICS^25^84
 ;;^UTILITY(U,$J,358.4,661,0)
 ;;=SUPPLIES^26^84
 ;;^UTILITY(U,$J,358.4,662,0)
 ;;=REMOVAL^14^84
 ;;^UTILITY(U,$J,358.4,663,0)
 ;;=AMPUTATION^22^84
 ;;^UTILITY(U,$J,358.4,664,0)
 ;;=NEW PATIENT^2^85
 ;;^UTILITY(U,$J,358.4,665,0)
 ;;=ESTABLISHED PATIENT^1^85
 ;;^UTILITY(U,$J,358.4,666,0)
 ;;=CONSULTATIONS^3^85
 ;;^UTILITY(U,$J,358.4,667,0)
 ;;=ALPHA ORDER (A)^2^86
 ;;^UTILITY(U,$J,358.4,668,0)
 ;;=ALPHA ORDER (B)^3^86
 ;;^UTILITY(U,$J,358.4,669,0)
 ;;=ALPHA ORDER (C)^4^86
 ;;^UTILITY(U,$J,358.4,670,0)
 ;;=ALPHA ORDER (D)^5^86
 ;;^UTILITY(U,$J,358.4,671,0)
 ;;=ALPHA ORDER (E)^6^86
 ;;^UTILITY(U,$J,358.4,672,0)
 ;;=ALPHA ORDER (F)^7^86
 ;;^UTILITY(U,$J,358.4,673,0)
 ;;=ALPHA ORDER (G)^8^86
 ;;^UTILITY(U,$J,358.4,674,0)
 ;;=ALPHA ORDER (H)^9^86
 ;;^UTILITY(U,$J,358.4,675,0)
 ;;=ALPHA ORDER (I)^10^86
 ;;^UTILITY(U,$J,358.4,676,0)
 ;;=ALPHA ORDER (K)^11^86
 ;;^UTILITY(U,$J,358.4,677,0)
 ;;=ALPHA ORDER (L)^12^86
 ;;^UTILITY(U,$J,358.4,678,0)
 ;;=ALPHA ORDER (M)^13^86
 ;;^UTILITY(U,$J,358.4,679,0)
 ;;=ALPHA ORDER (N)^14^86
 ;;^UTILITY(U,$J,358.4,680,0)
 ;;=ALPHA ORDER (O)^15^86
 ;;^UTILITY(U,$J,358.4,681,0)
 ;;=ALPHA ORDER (P)^16^86
 ;;^UTILITY(U,$J,358.4,682,0)
 ;;=ALPHA ORDER (R)^17^86
 ;;^UTILITY(U,$J,358.4,683,0)
 ;;=ALPHA ORDER (S)^18^86
