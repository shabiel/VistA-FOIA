SDCODEL ;ALB/RMO,ESW - Delete - Check Out; 5/31/13
 ;;5.3;Scheduling;**20,27,44,97,105,110,132,257,260003**;Aug 13, 1993
 ;
EN(SDOE,SDMOD,SDELHDL,SDELSRC) ;Delete Check Out
 ; Input  -- SDOE     Outpatient Encounter file IEN
 ;           SDMOD    1=Interactive and 0=Non-interactive
 ;           SDELHDL  Check Out Deletion Handle  [Optional]
 ;           SDELSRC  Source of delete
 ; Output -- Delete Check Out
 N DFN,SDDA,SDEVTF,SDOEP,SDT,SDVFLG
 S %=$$SETCO^SDMAPI4(.SDOE,.DFN,.SDT,.OE,.SC,.SDDA)
 ;
 ; -- ok to delete?
 IF '$$EDITOK^SDCO3(SDOE,.SDMOD) G ENQ
 ;
 IF $G(SDELSRC)'="PCE" S X=$$DELVFILE^PXAPI("ALL",OE(.05),"","","",1)
 S SDVFLG=1
 ;
 ; -- get handle if not passed and do 'before'
 I '$G(SDELHDL) N SDATA,SDELHDL S SDEVTF=1 D EVT^SDCOU1(SDOE,"BEFORE",.SDELHDL,.SDATA)
 ;
 I $G(SDMOD) W !!,">>> Deleting check out information..."
 ;
 ; -- delete child data for appts, dispos and stop code addition
 I "^1^2^3^"[("^"_OE(.08)_"^") D DELCHLD(SDOE,.SDMOD) ;SD/257
 ;
 ; -- delete SDOE pointers and co d/t
 I OE(.08)=1 D
 . S PDATA(21)="@"
 . D UPDPAPT^SDMDAL4(.PDATA,+DFN,+SDT)
 . N CDATA S CDATA(303)="@"
 . I $G(SDMOD) W !?3,"...deleting check out date/time"
 . D UPDCAPT^SDMDAL4(.CDATA,+SC,+SDT,SDDA)
 I OE(.08)=3 D
 . S PDATA(18)="@"
 . D UPDPAPT^SDMDAL4(.PDATA,+DFN,+SDT)
 ;
 ; -- do final deletes for sdoe
 I 'OE(.06),$$HASCLS^SDMDAL4(+SDOE) D
 . I $G(SDMOD) W !?3,"...deleting classifications"
 . D DELCLS^SDMDAL4(+SDOE)
 D DELOE(+SDOE,.OE,.SDMOD)
 ;
 I $G(SDMOD) W !,">>> done."
 ;
 ; -- if handle not passed, then 'after' and event
 I $G(SDEVTF) D EVT^SDCOU1(SDOE,"AFTER",SDELHDL,.SDATA,SDOE0)
 ;
 ; -- call pce to make sure its data is gone
 I $G(SDVFLG) D DEAD^PXUTLSTP(OE(.05))
ENQ Q
 ;
COMDT(SDOE,SDMOD) ;Delete Check Out Process Completion Date
 N RETURN
 I $G(SDMOD) W !?3,"...deleting check out process completion date"
 S DA=SDOE,DIE="^SCE(",DR=".07///@" D ^DIE
 Q
DELOE(SDOE,OE,SDMOD) ; Delete Outpatient Encounter
 N X
 I '$D(OE) D
 . S OE(.05)="",OE(.01)="",OE(.08)=""
 . D GETOE^SDMDAL4(.OE,+SDOE)
 I '$$EDITOK^SDCO3(SDOE,.SDMOD) Q
 D DELOE^SDMDAL4(+SDOE)
 S X=$$KILL^VSITKIL(OE(.05))
 Q
 ;
DELCHLD(SDOEP,SDMOD) ;Delete Children
 N SDOEC,CHLD
 S SDOEC=0
 D GETCHLD^SDMDAL4(.CHLD,SDOEP)
 F  S SDOEC=$O(CHLD(SDOEC)) Q:'SDOEC  D
 . D DELOE(SDOEC,,.SDMOD)
 Q
 ;
