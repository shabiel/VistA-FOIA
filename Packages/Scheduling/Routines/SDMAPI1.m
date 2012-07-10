SDMAPI1 ;MAKE APPOINTMENT API; 05/28/2012  11:46 AM
 ;;;Scheduling;;05/28/2012;
CLNCK(RETURN,CLN) ;Check clinic for valid stop code restriction.
 ;  INPUT:   CLN   = IEN of Clinic
 ;           DSP   = Error Message Display, 1 - Display or 0 No Display
 ;
 ;  OUTPUT:  1 if no error or 0^error message
 N PSC,SSC,ND0,VAL,FLDS
 S RETURN=0
 I CLN="" D ERRX^SDAPIE(.RETURN,"CLNINV") Q 0
 D GETCLN^SDMDAL1(.FLDS,CLN,1,0,0)
 I '$D(FLDS) D ERRX^SDAPIE(.RETURN,"CLNNDFN") Q 0
 I $G(FLDS(2))'="C" Q 1     ;not a Clinic
 S %=$$SCREST(.RETURN,FLDS(8),"P")
 Q:'% %  Q:FLDS(2503)="" 1
 S %=$$SCREST(.RETURN,FLDS(2503),"S")
 S RETURN=%
 Q RETURN
 ;
SCREST(RETURN,SCIEN,TYP) ;check stop code restriction in file 40.7 for a clinic. 
 ;  INPUT:   SCIEN = IEN of Stop Code
 ;           TYP   = Stop Code Type, Primary (P) or Secondary (S)
 ;           DIS   = Message Display, 1 - Display or 0 No Display
 ;
 ;  OUTPUT:  1 if no error, or 0^error message
 ;          
 N SCN,RTY,CTY,RDT,STR,STYP,FLDS,TEXT
 S STYP="("_$S(TYP="P":"Prim",1:"Second")_"ary)"
 S RETURN=0
 I +SCIEN<1 S TEXT(1)=STYP D ERRX^SDAPIE(.RETURN,"CLNSCIN",.TEXT) Q 0
 S CTY=$S(TYP="P":"^P^E^",1:"^S^E^")
 D GETCSC^SDMDAL1(.FLDS,SCIEN)
 S RTY=$G(FLDS(5)),RDT=$G(FLDS(6))
 I RTY="" D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=STYP
 . D ERRX^SDAPIE(.RETURN,"CLNSCNR",.TEXT)
 I CTY'[("^"_RTY_"^") D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=$S(TYP="P":"Prim",1:"Second")_"ary"
 . D ERRX^SDAPIE(.RETURN,"CLNSCPS",.TEXT)
 I RDT>DT D  Q 0
 . S TEXT(1)=$G(FLDS(1)),TEXT(2)=$$FMTE^XLFDT(RDT,"1F"),TEXT(3)=STYP
 . D ERRX^SDAPIE(.RETURN,"CLNSCRD",.TEXT)
 S RETURN=1
 Q 1
 ;
GETCLN(RETURN,CLN) ; Get Clinic data
 ;  INPUT:   CLN = IEN of Clinic
 D GETCLN^SDMDAL1(.RETURN,CLN,1,1,1)
 Q 1
 ;
LSTCLNS(RETURN,SEARCH,START,NUMBER) ; Return clinics filtered by name.
 N LST
 D LSTCLNS^SDMDAL1(.LST,$G(SEARCH),.START,$G(NUMBER))
 D BLDLST^SDMAPI(.RETURN,.LST)
 Q RETURN
 ;
CLNRGHT(RETURN,CLN) ; Verifies (DUZ) user access to Clinic
 N DATA,TXT
 S RETURN=0
 D GETCLN^SDMDAL1(.DATA,CLN,1)
 I DATA(2500)="Y"  D  Q RETURN
 . I $D(DATA(2501,DUZ,.01))>0 S RETURN=1 Q
 . E  D
 . . S RETURN=0 S TXT(1)=DATA(.01),TXT(2)=$C(10)
 . . D ERRX^SDAPIE(.RETURN,"CLNURGT",.TXT)
 . . S RETURN("CLN")=DATA(.01)
 E  S RETURN=1 Q 1
 Q 1
 ;
CLNVSC(RETURN,SC) ; Verifies clinic stop code validation
 N DATA
 S RETURN=0
 D GETCSC^SDMDAL1(.DATA,+SC)
 I $S('$D(DATA):1,'DATA(2):0,1:$G(DATA(2))'>DT) D  Q RETURN
 . S TEXT(1)=+SC
 . D ERRX^SDAPIE(.RETURN,"CLNSCIN",.TEXT) 
 . S RETURN=0
 S RETURN=1
 Q RETURN
 ;
GETSCAP(RETURN,SC,DFN,SD) ; Get clinic appointment
 D GETSCAP^SDMDAL1(.RETURN,SC,DFN,SD)
 Q 1
 ;
