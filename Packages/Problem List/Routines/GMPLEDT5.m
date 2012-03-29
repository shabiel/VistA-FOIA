GMPLEDT5    ;Edit Site parameters ;3-29-12 16:00
  ;;3.0;Problem List;**
 Q  ;
 ;
CHOOSE(VALUE,PARAMS) ;
 N DIR,X,X1,Y,IND,OLDVAL,VAL,KEY,SEP,LCNT,HCNT,HIND
CH ; for recursive call
 S DIR(0)="SAO^",SEP="",IND="",OLDVAL=""
 S DIR("L",1)="     Choose from:",LCNT=1
 F  S IND=$O(PARAMS("OPT",IND)) Q:IND=""  D
 . S KEY=$P(PARAMS("OPT",IND),U,1)
 . S VAL=$P(PARAMS("OPT",IND),U,2)
 . S LCNT=LCNT+1
 . S DIR("L",LCNT)="       "_KEY_"        "_VAL
 . S DIR(0)=DIR(0)_SEP_KEY_":"_VAL
 . S SEP=";"
 S IND=0
 S DIR("L")=DIR("L",LCNT) K DIR("L",LCNT)
 F  S IND=$O(PARAMS("OPT",IND)) Q:IND=""  D
 . I $P(PARAMS("OPT",IND),U,1)=VALUE S OLDVAL=$P(PARAMS("OPT",IND),U,2) Q
 S HCNT=0,HIND=""
 F  S HIND=$O(PARAMS("H1",HIND)) Q:HIND=""  D
 . S HCNT=HCNT+1
 . S DIR("?",HCNT)=PARAMS("H1",HIND)
 S DIR("?")=PARAMS("H1")
 S DIR("??")=PARAMS("H2")
 S DIR("B")=OLDVAL
 S DIR("A")=PARAMS("FLD")_": "
 D ^DIR
 I X="@" S X1=X I $$ASKDEL() S Y=X1  E  G CH
 I $G(DUOUT),$G(DIRUT),Y'="^",'$G(DIROUT) G CH
 Q Y
 ;
ASKDEL() ;
 S DIR(0)="YO"
 S DIR("A")="   SURE YOU WANT TO DELETE"
 S DIR("?")="    Answer with 'Yes' or 'No'"
 D ^DIR
 Q Y
 ;
SELPAR(FIELD,VALUE) ;
 N PARAMS S PARAMS=""
 I FIELD="VER" D
 . S PARAMS("OPT",1)="1^YES"
 . S PARAMS("OPT",2)="0^NO"
 . S PARAMS("FLD")="VERIFY TRANSCRIBED PROBLEMS"
 . S PARAMS("H1")="     Enter YES to flag transcribed entries for clinician verification."
 I FIELD="PRT" D
 . S PARAMS("OPT",1)="1^YES, ASK"
 . S PARAMS("OPT",2)="0^NO, DON'T ASK"
 . S PARAMS("FLD")="PROMPT FOR CHART COPY"
 . S PARAMS("H1",1)="     Enter YES to be prompted to print a new copy before exiting the patient's"
 . S PARAMS("H1")="     list, if it has been updated."
 I FIELD="CLU" D
 . S PARAMS("OPT",1)="1^YES"
 . S PARAMS("OPT",2)="0^NO"
 . S PARAMS("FLD")="USE CLINICAL LEXICON"
 . S PARAMS("H1",1)="     Enter YES to allow the user to search the Clinical Lexicon when adding to"
 . S PARAMS("H1",2)="     or editing a problem list; NO will bypass the search, capturing ONLY the"
 . S PARAMS("H1")="     free text."
 I FIELD="REV" D
 . S PARAMS("OPT",1)="C^CHRONOLOGICAL"
 . S PARAMS("OPT",2)="R^REVERSE-CHRONOLOGICAL"
 . S PARAMS("FLD")="DISPLAY ORDER"
 . S PARAMS("H1",1)="     Enter the order in which the problems should be displayed for your site,"
 . S PARAMS("H1")="     according to the date each problem was recorded."
 I FIELD="SDP" D
 . S PARAMS("OPT",1)="1^YES"
 . S PARAMS("FLD")="SCREEN DUPLICATE ENTRIES"
 . S PARAMS("H1",1)="     Enter '1' or 'YES' and non-interactive duplicate problems will be"
 . S PARAMS("H1")="     screened."
 S PARAMS("H2")="^D PARHLP^GMPLEDT5("""_FIELD_""",.PARAMS)"
 S NEWVAL=$$CHOOSE(VALUE,.PARAMS)
 Q NEWVAL
 ;
PARHLP(FIELD,PARAMS) ;
 I FIELD="VER" D
 . W ?8,"This is a toggle which determines whether the PL application will"
 . W !?8,"flag entries made by a non-clinical user, and allow for subsequent"
 . W !?8,"confirmation of the entry by a clinician.",!
 I FIELD="PRT" D
 . W ?8,"This is a toggle which determines whether the PL application will"
 . W !,?8,"prompt the user to print a new chartable copy of the patient's list"
 . W !,?8,"when exiting the application or changing patients, if the current"
 . W !,?8,"patient's list has been modified.",!
 I FIELD="CLU" D
 . W ?8,"This is a toggle which determines whether the PL application will"
 . W !,?8,"allow the user to search the Clinical Lexicon when adding or editing"
 . W !,?8,"a problem; if a term is selected from the CL Utility, the standardized"
 . W !,?8,"text will be displayed on the problem list, otherwise the text entered"
 . W !,?8,"by the user to search on will be displayed.  Problems which are taken"
 . W !,?8,"from the CLU may already be coded to ICD9, and this code is returned"
 . W !,?8,"to the PL application if available.  Duplicate problems can be screened"
 . W !,?8,"out, and searches by problem performed when this link to the CLU exists."
 . W !!,?8,"If this flag is set to NO, the user will be prompted for his/her free"
 . W !,?8,"text description of the problem only, when adding or editing a problem."
 . W !,?8,"No search will be performed at that time on the CLU, and no link made"
 . W !,?8,"from the problem to an entry in the CLU.",!
 I FIELD="REV" D
 . W ?8,"This flag allows each site to control how the problem list is displayed,"
 . W !,?8,"whether chronologically or reverse-chronologically by date recorded."
 . W !,?8,"This ordering will be the same both onscreen and on the printed copy."
 . W !,?8,"When new problems are added to a patient's list, they will be added as the"
 . W !,?8,"most recent problems, i.e. at the top of the list if reverse-chronological"
 . W !,?8,"or at the bottom if chronological.",!
 I FIELD="SDP" D
 . W ?8,"If YES is entered in this field duplicate problems (those having the same"
 . W !,?8,"ICD9 code) will NOT be added to the problem list.  The primary purpose of"
 . W !,?8,"this field in to screen entries added via the scannable encounter form.",!
 W !,?5,"Choose from:"
 N IND S IND=""
 F  S IND=$O(PARAMS("OPT",IND)) Q:IND=""  D
 . W !,?7,$P(PARAMS("OPT",IND),U,1)_"        "_$P(PARAMS("OPT",IND),U,2)
 Q
 ;
