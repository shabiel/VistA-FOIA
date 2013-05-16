GMPLAPI3 ; RGI/CBR -- Problem List API - NEW,UPDATE NOTES ; 5/15/13
 ;;2.0;Problem List;**260002**;Aug 24, 1994
NEWNOTE(RETURN,GMPIFN,GMPROV,NOTES) ; Creates New Note Entries for Problem
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the call succeeded.
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;   GMPROV [Required,Numeric] Provider IEN (pointer to file 200)
 ;  .NOTES [Required,Array] Array passed by reference that holds comment lines.
 ;                          It should be in the following format: NOTES(#)=comment
 ;Output:
 ;  1=Success,0=Failure
 N HDR,LAST,TOTAL,I,FAC,NIFN,DELETED,ICDACTV,GMPVAMC,NOTEOK,%
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV) Q 0
 I '$D(NOTES) D ERRX^GMPLAPIE(.RETURN,"INVPARAM","NOTES") Q 0
 I $D(NOTES)=1 S NOTES(1)=NOTES
 S NOTEOK=0
 F I=0:0 S I=$O(NOTES(I)) Q:I'>0  D
 . S NOTEOK=1
 I 'NOTEOK D ERRX^GMPLAPIE(.RETURN,"INVPARAM","NOTES") Q 0
 S GMPVAMC=$$GMPVAMC^GMPLAPI2
 S %=$$DELETED^GMPLAPI2(.DELETED,GMPIFN)
 I DELETED D ERRX^GMPLAPIE(.RETURN,"PRBDLTD"," ("_$$PROBTEXT^GMPLX(GMPIFN)_")") Q 0
 ; Code Set Versioning (CSV)
 S %=$$CODESTS^GMPLAPI2(.ICDACTV,GMPIFN,DT)
 I 'ICDACTV D ERRX^GMPLAPIE(.RETURN,"ICDINACT"," ("_$$PROBTEXT^GMPLX(GMPIFN)_")") Q 0
 I '$$LOCK^GMPLDAL(GMPIFN,11,"RETURN") Q 0
 D NEWNOTE^GMPLDAL3(GMPIFN,GMPVAMC,GMPROV,.NOTES)
 D UNLOCK^GMPLDAL(GMPIFN,11)
 S RETURN=1
 Q RETURN
 ;
UPDNOTE(RETURN,GMPIFN,NEWNOTE,GMPROV) ; Replace existing note
 ;Input:
 ;  .RETURN [Required,Boolean] Set to 1 if the call succeeded.
 ;                             Set to Error description if the call fails
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;   NEWNOTE [Required,String] New comment formatted as: note_IEN^facility_IEN^Text
 ;                             If Text is empty the comment will be deleted.
 ;   GMPROV [Required,Numeric] Provider IEN (pointer to file 200)
 ;Output:
 ;  1=Success,0=Failure
 N NIFN,FAC,TEXT,OLDTEXT
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$PROVIEN^GMPLCHK(.RETURN,.GMPROV) Q 0
 I $G(NEWNOTE)="" D ERRX^GMPLAPIE(.RETURN,"INVPARAM","NEWNOTE") Q 0
 S NIFN=$P(NEWNOTE,U)
 I '$$NUM^GMPLCHK(.RETURN,NIFN,"NEWNOTE",0,0,1) Q 0
 S FAC=$P(NEWNOTE,U,2)
 I '$$NUM^GMPLCHK(.RETURN,FAC,"NEWNOTE",0,0,1) Q 0
 S TEXT=$P(NEWNOTE,U,3)
 S OLDTEXT=$$NOTE^GMPLDAL(GMPIFN,FAC,NIFN)
 I OLDTEXT="" D ERRX^GMPLAPIE(.RETURN,"NOTENFND") Q 0
 I TEXT=OLDTEXT S RETURN=1 Q 1
 D:TEXT'="" UPDNOTE^GMPLDAL(GMPIFN,FAC,NIFN,TEXT,GMPROV)
 D:TEXT="" DELNOTE^GMPLDAL(GMPIFN,FAC,NIFN,GMPROV)
 S RETURN=1
 Q 1
 ;
NOTES(RETURN,GMPIFN,GMPACT,GMPFMT) ; Return comments for a problem - MULTI-DIVISIONAL
 ;Input:
 ;  .RETURN [Required,Array] Array passed by reference that will receive the data.
 ;                           Set to Error description if the call fails
 ;                           The output format depends on the value of GMPFMT
 ;   GMPIFN [Required,Numeric] Problem IEN (pointer to file 9000011)
 ;   GMPACT [Optional,Boolean] Active. If set to 1 only active comments will be returned. Default: 1
 ;   GMPFMT [Optional,Numeric] Format. Controls the output format. Default: 1. The following values are allowed:
 ;      1 -- RETURN(#)=note_narrative
 ;      2 -- RETURN(#)=date_note_added^author^note_narrative (external format)
 ;      3 -- RETURN(#)=note_nmbr^facility^note_narrative^status^date_note_added^author  (internal format)
 ;      4 -- RETURN(facility,note_nmbr)=note_nmbr^^note_narrative^status^date_note_added^author  (internal format)
 ;Output:
 ;  1=Success,0=Failure
 K RETURN
 S RETURN=0
 I '$$PRBIEN^GMPLCHK(.RETURN,.GMPIFN) Q 0
 I '$$BOOL^GMPLCHK(.RETURN,.GMPACT,"GMPACT") Q 0
 I '$$NUM^GMPLCHK(.RETURN,.GMPFMT,"GMPFMT",1,0,1,4) Q 0
 D NOTES^GMPLDAL3(.RETURN,GMPIFN,$G(GMPFMT,1),$G(GMPACT))
 Q 1
 ;
FULLNTE(RETURN,GMPIFN) ;Get active comments for a note
 K RETURN
 D NOTES^GMPLDAL3(.RETURN,GMPIFN,4,1)
 Q 1
