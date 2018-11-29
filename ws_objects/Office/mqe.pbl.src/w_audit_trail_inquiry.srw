$PBExportHeader$w_audit_trail_inquiry.srw
forward
global type w_audit_trail_inquiry from w_inquiry_ancestor
end type
end forward

global type w_audit_trail_inquiry from w_inquiry_ancestor
string title = "Audit Trail Inquiry"
string menuname = "m_audit_trail_inquiry"
end type
global w_audit_trail_inquiry w_audit_trail_inquiry

on w_audit_trail_inquiry.create
call super::create
if this.MenuName = "m_audit_trail_inquiry" then this.MenuID = create m_audit_trail_inquiry
end on

on w_audit_trail_inquiry.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_1 from w_inquiry_ancestor`st_1 within w_audit_trail_inquiry
end type

type dw_inquiry from w_inquiry_ancestor`dw_inquiry within w_audit_trail_inquiry
string dataobject = "dw_audit_trail_std"
boolean hsplitscroll = true
end type

event dw_inquiry::doubleclicked;STRING   l_s_ds, &
         l_s_serial 

dw_inquiry.DBCancel()

IF row < 1 THEN Return

l_s_ds  = String ( object.date_stamp [ row ] )
l_s_serial = String ( object.serial [ row ] ) 

OpenSheetWithParm ( w_at_geneology, l_s_serial, gnv_App.of_GetFrame(), 4, Original! )
end event

