IBDEI0AW ; ; 12-JAN-2012
 ;;3.0;IB ENCOUNTER FORM IMP/EXP;;JAN 12, 2012
 Q:'DIFQR(358.4)  F I=1:2 S X=$T(Q+I) Q:X=""  S Y=$E($T(Q+I+1),4,999),X=$E(X,4,999) S:$A(Y)=126 I=I+1,Y=$E(Y,2,999)_$E($T(Q+I+1),5,99) S:$A(Y)=61 Y=$E(Y,2,999) X NO E  S @X=Y
Q Q
 ;;^UTILITY(U,$J,358.4,341,0)
 ;;=COLONOSCOPY^5^44
 ;;^UTILITY(U,$J,358.4,342,0)
 ;;=ERCP^6^44
 ;;^UTILITY(U,$J,358.4,343,0)
 ;;=G-TUBE^7^44
 ;;^UTILITY(U,$J,358.4,344,0)
 ;;=MISCELLANEOUS-PROCEDURES^8^44
 ;;^UTILITY(U,$J,358.4,345,0)
 ;;=IMMUNIZATIONS/INJECTIONS^9^44
 ;;^UTILITY(U,$J,358.4,346,0)
 ;;=NEW PATIENT^2^45
 ;;^UTILITY(U,$J,358.4,347,0)
 ;;=ESTABLISHED PATIENT^1^45
 ;;^UTILITY(U,$J,358.4,348,0)
 ;;=CONSULTATIONS^3^45
 ;;^UTILITY(U,$J,358.4,349,0)
 ;;=GYN PROCEDURES^1^46
 ;;^UTILITY(U,$J,358.4,350,0)
 ;;=INJECTIONS^3^46
 ;;^UTILITY(U,$J,358.4,351,0)
 ;;=ADMINISTRATION OF INJECTION^4^46
 ;;^UTILITY(U,$J,358.4,352,0)
 ;;=FOREIGN BODY^6^46
 ;;^UTILITY(U,$J,358.4,353,0)
 ;;=UA/FINGERSTICK^7^46
 ;;^UTILITY(U,$J,358.4,354,0)
 ;;=FLUSHES^5^46
 ;;^UTILITY(U,$J,358.4,355,0)
 ;;=DESTRUCTION OF LESIONS^2^46
 ;;^UTILITY(U,$J,358.4,356,0)
 ;;=GASTROINTESTINAL^3^47
 ;;^UTILITY(U,$J,358.4,357,0)
 ;;=GENITOURINARY & RENAL^2^47
 ;;^UTILITY(U,$J,358.4,358,0)
 ;;=GYNECOLOGICAL/BREAST^1^47
 ;;^UTILITY(U,$J,358.4,359,0)
 ;;=HOSPICE CARE SUPERVISION^1^48
 ;;^UTILITY(U,$J,358.4,360,0)
 ;;=NEW PATIENT^1^49
 ;;^UTILITY(U,$J,358.4,361,0)
 ;;=ESTABLISHED PATIENT^2^49
 ;;^UTILITY(U,$J,358.4,362,0)
 ;;=CONSULTATIONS^3^49
 ;;^UTILITY(U,$J,358.4,363,0)
 ;;=CANCER & HEMATOLOGIC CONDITIONS^2^50
 ;;^UTILITY(U,$J,358.4,364,0)
 ;;=PALLIATIVE/HOSPICE ENCOUNTER^1^50
 ;;^UTILITY(U,$J,358.4,365,0)
 ;;=CNS CONDITIONS OTHER THAN CANCER^3^50
 ;;^UTILITY(U,$J,358.4,366,0)
 ;;=CARDIOPULMONARY COND OTHER THAN CANCER^4^50
 ;;^UTILITY(U,$J,358.4,367,0)
 ;;=GASTROINTESTINAL COND OTHER THAN CANCER^5^50
 ;;^UTILITY(U,$J,358.4,368,0)
 ;;=RENAL COND OTHER THAN CANCER^6^50
 ;;^UTILITY(U,$J,358.4,369,0)
 ;;=DERMATOLOGIC CONDITIONS^7^50
 ;;^UTILITY(U,$J,358.4,370,0)
 ;;=RHEUMATOLOGIC/VASCULITIC/THROMBOEMBOLIC^8^50
 ;;^UTILITY(U,$J,358.4,371,0)
 ;;=INFECTIOUS CONDITIONS & SIRS^9^50
 ;;^UTILITY(U,$J,358.4,372,0)
 ;;=INITIAL OBSERVATION^1^51
 ;;^UTILITY(U,$J,358.4,373,0)
 ;;=INPT BEDSIDE VISIT-INITIAL CARE^3^51
 ;;^UTILITY(U,$J,358.4,374,0)
 ;;=INPT-CONSULTATIONS^5^51
 ;;^UTILITY(U,$J,358.4,375,0)
 ;;=OBSERVATION DISCHARGE^2^51
 ;;^UTILITY(U,$J,358.4,376,0)
 ;;=INPT BEDSIDE VISITS-DAILY VISITS^4^51
 ;;^UTILITY(U,$J,358.4,377,0)
 ;;=ADMIT & DISCHARGE SAME DAY^6^51
 ;;^UTILITY(U,$J,358.4,378,0)
 ;;=DISCHARGE DAY CODES^7^51
 ;;^UTILITY(U,$J,358.4,379,0)
 ;;=CARDIOVASCULAR^6^52
 ;;^UTILITY(U,$J,358.4,380,0)
 ;;=RESPIRATORY^7^52
 ;;^UTILITY(U,$J,358.4,381,0)
 ;;=MUSCULOSKELETAL^10^52
 ;;^UTILITY(U,$J,358.4,382,0)
 ;;=NEUROLOGIC^11^52
 ;;^UTILITY(U,$J,358.4,383,0)
 ;;=GASTROENTEROLOGY^8^52
 ;;^UTILITY(U,$J,358.4,384,0)
 ;;=GENITOURINARY^9^52
 ;;^UTILITY(U,$J,358.4,385,0)
 ;;=HEMATOLOGY/ONCOLOGY^12^52
 ;;^UTILITY(U,$J,358.4,386,0)
 ;;=INJURY/TRAUMA^5^52
 ;;^UTILITY(U,$J,358.4,387,0)
 ;;=SIGNS/SYMPTOMS^1^52
 ;;^UTILITY(U,$J,358.4,388,0)
 ;;=PAIN^2^52
 ;;^UTILITY(U,$J,358.4,389,0)
 ;;=COMPLICATIONS^4^52
 ;;^UTILITY(U,$J,358.4,390,0)
 ;;=MASS^3^52
 ;;^UTILITY(U,$J,358.4,391,0)
 ;;=SUBSEQUENT OBSERVATION^1^53
 ;;^UTILITY(U,$J,358.4,392,0)
 ;;=BLIND REHAB SERVICE CODES^1^54
 ;;^UTILITY(U,$J,358.4,393,0)
 ;;=REFRACTION^3^54
 ;;^UTILITY(U,$J,358.4,394,0)
 ;;=GLASSES/CONTACT LENSES^4^54
 ;;^UTILITY(U,$J,358.4,395,0)
 ;;=VISUAL FIELDS^5^54
 ;;^UTILITY(U,$J,358.4,396,0)
 ;;=PHOTOGRAPHY^6^54
 ;;^UTILITY(U,$J,358.4,397,0)
 ;;=LOW VISION^7^54
 ;;^UTILITY(U,$J,358.4,398,0)
 ;;=SPECIAL PROCEDURES^8^54
 ;;^UTILITY(U,$J,358.4,399,0)
 ;;=TEAM MEETINGS/COUNSELING^10^54
 ;;^UTILITY(U,$J,358.4,400,0)
 ;;=ESTABLISHED PATIENT^1^55
 ;;^UTILITY(U,$J,358.4,401,0)
 ;;=NEW PATIENT^2^55
 ;;^UTILITY(U,$J,358.4,402,0)
 ;;=VISION DDX (CODE BY BETTER EYE)^1^56
 ;;^UTILITY(U,$J,358.4,403,0)
 ;;=DIABETES^4^56
 ;;^UTILITY(U,$J,358.4,404,0)
 ;;=GLAUCOMA^4^56
 ;;^UTILITY(U,$J,358.4,405,0)
 ;;=VF HA EOM OTHER^5^56
 ;;^UTILITY(U,$J,358.4,406,0)
 ;;=LIDS AND LASHES^6^56
 ;;^UTILITY(U,$J,358.4,407,0)
 ;;=CONJUNCTIVA, CORNEA, AND SCLERA^7^56
 ;;^UTILITY(U,$J,358.4,408,0)
 ;;=PUPILS/IRIS^8^56
 ;;^UTILITY(U,$J,358.4,409,0)
 ;;=LENS AND VITREOUS^9^56
 ;;^UTILITY(U,$J,358.4,410,0)
 ;;=MACULA AND OPTIC NERVE^10^56
 ;;^UTILITY(U,$J,358.4,411,0)
 ;;=RETINA^11^56
 ;;^UTILITY(U,$J,358.4,412,0)
 ;;=GLOBE/ORBIT^12^56
 ;;^UTILITY(U,$J,358.4,413,0)
 ;;=NEW PATIENT^2^57
 ;;^UTILITY(U,$J,358.4,414,0)
 ;;=ESTABLISHED PATIENT^1^57
 ;;^UTILITY(U,$J,358.4,415,0)
 ;;=MEDICAL FOSTER HOME CODES^1^58
 ;;^UTILITY(U,$J,358.4,416,0)
 ;;=NURSING PROCEDURES^2^58
 ;;^UTILITY(U,$J,358.4,417,0)
 ;;=SPLINTS^3^58
 ;;^UTILITY(U,$J,358.4,418,0)
 ;;=CARDIOVASCULAR^2^59
 ;;^UTILITY(U,$J,358.4,419,0)
 ;;=ENDOCRINE/METABOLIC^4^59
 ;;^UTILITY(U,$J,358.4,420,0)
 ;;=PULMONARY^20^59
 ;;^UTILITY(U,$J,358.4,421,0)
 ;;=EENT^5^59
 ;;^UTILITY(U,$J,358.4,422,0)
 ;;=MUSCULOSKELETAL^10^59
 ;;^UTILITY(U,$J,358.4,423,0)
 ;;=NEURO^15^59
 ;;^UTILITY(U,$J,358.4,424,0)
 ;;=MENTAL HEALTH^13^59
 ;;^UTILITY(U,$J,358.4,425,0)
 ;;=GASTROENTEROLOGY^6^59
 ;;^UTILITY(U,$J,358.4,426,0)
 ;;=GU / RENAL^7^59
 ;;^UTILITY(U,$J,358.4,427,0)
 ;;=WOMEN'S HEALTH^28^59
 ;;^UTILITY(U,$J,358.4,428,0)
 ;;=HEMATOLOGY/ONCOLOGY^8^59
 ;;^UTILITY(U,$J,358.4,429,0)
 ;;=INFECTIOUS DISEASE^9^59
 ;;^UTILITY(U,$J,358.4,430,0)
 ;;=DERMATOLOGY^3^59
 ;;^UTILITY(U,$J,358.4,431,0)
 ;;=HISTORY OF ILLNESS^29^59
 ;;^UTILITY(U,$J,358.4,432,0)
 ;;=PREVENTIVE HEALTH/SCREENINGS^31^59
 ;;^UTILITY(U,$J,358.4,433,0)
 ;;=INJURY/TRAUMA^21^59
 ;;^UTILITY(U,$J,358.4,434,0)
 ;;=SIGNS, SYMPTOMS, CONDITIONS^35^59
 ;;^UTILITY(U,$J,358.4,435,0)
 ;;=SEXUAL TRAUMA^37^59
 ;;^UTILITY(U,$J,358.4,436,0)
 ;;=PAIN^17^59
 ;;^UTILITY(U,$J,358.4,437,0)
 ;;=OTHER REASONS^38^59
 ;;^UTILITY(U,$J,358.4,438,0)
 ;;=CAUSES OF INJURY (SECONDARY ONLY)^39^59
 ;;^UTILITY(U,$J,358.4,439,0)
 ;;=COMMON DIAGNOSES^1^59
 ;;^UTILITY(U,$J,358.4,440,0)
 ;;=IMMUNIZATION^2^60
 ;;^UTILITY(U,$J,358.4,441,0)
 ;;=INJECTION^3^60
 ;;^UTILITY(U,$J,358.4,442,0)
 ;;=SKIN TEST^4^60
 ;;^UTILITY(U,$J,358.4,443,0)
 ;;=NURSING PROCEDURES^5^60
 ;;^UTILITY(U,$J,358.4,444,0)
 ;;=MINOR PROCEDURES^6^60
 ;;^UTILITY(U,$J,358.4,445,0)
 ;;=SPLINTS^9^60
 ;;^UTILITY(U,$J,358.4,446,0)
 ;;=REPAIR-SIMPLE SCALP,NK,TRUNK,GENTIALS^7^60
 ;;^UTILITY(U,$J,358.4,447,0)
 ;;=REPAIR-SIMPLE FACE,MUCOUS^8^60
 ;;^UTILITY(U,$J,358.4,448,0)
 ;;=NEW PATIENT^2^61
 ;;^UTILITY(U,$J,358.4,449,0)
 ;;=ESTABLISHED PATIENT^1^61
 ;;^UTILITY(U,$J,358.4,450,0)
 ;;=PREVENTIVE MED ESTAB^3^61
 ;;^UTILITY(U,$J,358.4,451,0)
 ;;=PREVENTIVE MED NEW^4^61
 ;;^UTILITY(U,$J,358.4,452,0)
 ;;=CARDIOVASCULAR^1^62
 ;;^UTILITY(U,$J,358.4,453,0)
 ;;=ENDOCRINE/METABOLIC^5^62
 ;;^UTILITY(U,$J,358.4,454,0)
 ;;=PULMONARY^18^62
 ;;^UTILITY(U,$J,358.4,455,0)
 ;;=EENT^4^62
 ;;^UTILITY(U,$J,358.4,456,0)
 ;;=MUSCULOSKELETAL^13^62
 ;;^UTILITY(U,$J,358.4,457,0)
 ;;=NEURO^14^62
 ;;^UTILITY(U,$J,358.4,458,0)
 ;;=MENTAL HEALTH^12^62
 ;;^UTILITY(U,$J,358.4,459,0)
 ;;=GASTROENTEROLOGY^6^62
 ;;^UTILITY(U,$J,358.4,460,0)
 ;;=GU / RENAL^7^62
 ;;^UTILITY(U,$J,358.4,461,0)
 ;;=WOMEN'S HEALTH^21^62
 ;;^UTILITY(U,$J,358.4,462,0)
 ;;=HEMATOLOGY/ONCOLOGY^8^62
 ;;^UTILITY(U,$J,358.4,463,0)
 ;;=INFECTIOUS DISEASE^10^62
 ;;^UTILITY(U,$J,358.4,464,0)
 ;;=DERMATOLOGY^3^62
 ;;^UTILITY(U,$J,358.4,465,0)
 ;;=HISTORY OF ILLNESS^9^62
 ;;^UTILITY(U,$J,358.4,466,0)
 ;;=PREVENTIVE HEALTH/SCREENINGS^17^62
 ;;^UTILITY(U,$J,358.4,467,0)
 ;;=INJURY/TRAUMA^11^62
 ;;^UTILITY(U,$J,358.4,468,0)
 ;;=SIGNS, SYMPTOMS, CONDITIONS^20^62
 ;;^UTILITY(U,$J,358.4,469,0)
 ;;=SEXUAL TRAUMA^19^62
 ;;^UTILITY(U,$J,358.4,470,0)
 ;;=PAIN^16^62
 ;;^UTILITY(U,$J,358.4,471,0)
 ;;=OTHER REASONS^15^62
 ;;^UTILITY(U,$J,358.4,472,0)
 ;;=CAUSES OF INJURY (SECONDARY ONLY)^2^62
 ;;^UTILITY(U,$J,358.4,473,0)
 ;;=ADJUSTMENT DISORDERS^1^63
 ;;^UTILITY(U,$J,358.4,474,0)
 ;;=ANXIETY DISORDERS^3^63
 ;;^UTILITY(U,$J,358.4,475,0)
 ;;=AMNESTICS^2^63
 ;;^UTILITY(U,$J,358.4,476,0)
 ;;=ORGANIC DISORDERS^9^63
 ;;^UTILITY(U,$J,358.4,477,0)
 ;;=DEMENTIA^5^63
 ;;^UTILITY(U,$J,358.4,478,0)
 ;;=DELIRIUM^4^63
 ;;^UTILITY(U,$J,358.4,479,0)
 ;;=BIPOLAR DISORDERS^3.5^63
 ;;^UTILITY(U,$J,358.4,480,0)
 ;;=PSYCHOSIS/OTHER^12^63
 ;;^UTILITY(U,$J,358.4,481,0)
 ;;=PERSONALITY DISORDERS^11^63
 ;;^UTILITY(U,$J,358.4,482,0)
 ;;=SEXUAL DISORDERS^14^63
 ;;^UTILITY(U,$J,358.4,483,0)
 ;;=SLEEP DISORDERS^15^63
 ;;^UTILITY(U,$J,358.4,484,0)
 ;;=OTHER DISORDERS^18^63
 ;;^UTILITY(U,$J,358.4,485,0)
 ;;=SUBSTANCE RELATED DISORDERS^19^63
 ;;^UTILITY(U,$J,358.4,486,0)
 ;;=V CODES^17^63
 ;;^UTILITY(U,$J,358.4,487,0)
 ;;=PREVENTION/COUNSELING/SCREEN^21^63
 ;;^UTILITY(U,$J,358.4,488,0)
 ;;=DEPRESSION^6^63
 ;;^UTILITY(U,$J,358.4,489,0)
 ;;=MOOD DISORDERS (OTHER)^8^63
 ;;^UTILITY(U,$J,358.4,490,0)
 ;;=SCHIZOPHRENIA^13^63
 ;;^UTILITY(U,$J,358.4,491,0)
 ;;=SOMATIFORM DISORDERS^16^63
 ;;^UTILITY(U,$J,358.4,492,0)
 ;;=EATING DISORDERS^7^63
 ;;^UTILITY(U,$J,358.4,493,0)
 ;;=NEUROLEPTIC-INDUCED MOVEMENT DISORD^10^63
 ;;^UTILITY(U,$J,358.4,494,0)
 ;;=PRESCRIBER CODES^1^64
 ;;^UTILITY(U,$J,358.4,495,0)
 ;;=PSYCHOTHERAPY (Prescriber/LCSW/PhD)^2^64
 ;;^UTILITY(U,$J,358.4,496,0)
 ;;=OTHER CODES^3^64
 ;;^UTILITY(U,$J,358.4,497,0)
 ;;=CONSULTATIONS (MD/DO ONLY)^1^65
 ;;^UTILITY(U,$J,358.4,498,0)
 ;;=OTHER CODES^11^66
 ;;^UTILITY(U,$J,358.4,499,0)
 ;;=MH INTAKE CODES^1^66
 ;;^UTILITY(U,$J,358.4,500,0)
 ;;=OUTPATIENT PSYCHOTHERAPY^2^66
 ;;^UTILITY(U,$J,358.4,501,0)
 ;;=OUTPATIENT PSYCHOTHER W/ E&M^3^66
 ;;^UTILITY(U,$J,358.4,502,0)
 ;;=INPATIENT OR PPH PSYCHOTHERAPY^4^66
 ;;^UTILITY(U,$J,358.4,503,0)
 ;;=INPATIENT/PPH PSYCHOTHER W/ E&M^5^66
 ;;^UTILITY(U,$J,358.4,504,0)
 ;;=OTHER PSYCHOTHERAPY^6^66
 ;;^UTILITY(U,$J,358.4,505,0)
 ;;=MEDICATION MANAGEMENT^7^66
 ;;^UTILITY(U,$J,358.4,506,0)
 ;;=HOME VISITS^8^66
 ;;^UTILITY(U,$J,358.4,507,0)
 ;;=BIOFEEDBACK^9^66
 ;;^UTILITY(U,$J,358.4,508,0)
 ;;=CASE MANAGEMENT^10^66
 ;;^UTILITY(U,$J,358.4,509,0)
 ;;=ADJUSTMENT DISORDERS^1^67
 ;;^UTILITY(U,$J,358.4,510,0)
 ;;=ANXIETY DISORDERS^3^67
 ;;^UTILITY(U,$J,358.4,511,0)
 ;;=AMNESTICS^2^67
