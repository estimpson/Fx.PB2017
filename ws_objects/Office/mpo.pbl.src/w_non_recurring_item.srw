$PBExportHeader$w_non_recurring_item.srw
forward
global type w_non_recurring_item from window
end type
type cb_apply from commandbutton within w_non_recurring_item
end type
type cb_save from commandbutton within w_non_recurring_item
end type
type cb_exit from commandbutton within w_non_recurring_item
end type
type dw_1 from datawindow within w_non_recurring_item
end type
end forward

global type w_non_recurring_item from window
integer x = 814
integer y = 488
integer width = 1303
integer height = 1224
windowtype windowtype = response!
long backcolor = 79741120
cb_apply cb_apply
cb_save cb_save
cb_exit cb_exit
dw_1 dw_1
end type
global w_non_recurring_item w_non_recurring_item

type variables
Long        i_l_PO

String       i_s_part


Boolean     i_b_column
end variables

on w_non_recurring_item.create
this.cb_apply=create cb_apply
this.cb_save=create cb_save
this.cb_exit=create cb_exit
this.dw_1=create dw_1
this.Control[]={this.cb_apply,&
this.cb_save,&
this.cb_exit,&
this.dw_1}
end on

on w_non_recurring_item.destroy
destroy(this.cb_apply)
destroy(this.cb_save)
destroy(this.cb_exit)
destroy(this.dw_1)
end on

event open;st_generic_structure l_st_parm

DataWindowChild  l_dwc_units

STRING	l_s_name, &
			l_s_req_no, &
			l_s_account, &
			l_s_unit
string taxable

DATETIME	l_d_date

DECIMAL	l_n_qty, &
			l_n_price, &
			l_n_other_charge

l_st_parm	= Message.PowerObjectParm 

i_l_po	= Long ( l_st_parm.value1 )
dw_1.setfocus()

i_s_part = l_st_parm.value2

dw_1.GetChild("units", l_dwc_units)
l_dwc_units.SetTransObject(SQLCA)
l_dwc_units.Retrieve()

dw_1.Reset()
dw_1.InsertRow(1)
dw_1.SetItem ( 1, 1, i_s_part )
 
 SELECT  po_detail.description,   
         po_detail.date_due,   
         po_detail.requisition_number,   
         po_detail.account_code,   
         po_detail.quantity,   
         po_detail.price,
			po_detail.unit_of_measure,
			po_detail.other_charge,
			po_detail.taxable
    INTO :l_s_name,   
         :l_d_date,
         :l_s_req_no,
         :l_s_account,
         :l_n_qty,
         :l_n_price,
			:l_s_unit,
			:l_n_other_charge,
			:taxable
    FROM po_detail  
   WHERE ( po_detail.po_number = :i_l_po ) AND  
         ( po_detail.part_number = :i_s_part )   ;

IF SQLCA.SQLCODE = 0 THEN
	dw_1.SetItem ( 1, 2, l_s_name )
	dw_1.SetItem ( 1, 3, l_d_date )
	dw_1.SetItem ( 1, 4, l_n_qty )
	dw_1.SetItem ( 1, 5, l_n_price )
	dw_1.SetItem ( 1, 6, l_s_account )
	dw_1.SetItem ( 1, 7, l_s_req_no )
	dw_1.SetItem ( 1, 8, l_s_unit )
	dw_1.SetItem ( 1, 9, l_n_other_charge )
	dw_1.SetItem (1, 10, taxable)
END IF

end event

type cb_apply from commandbutton within w_non_recurring_item
integer x = 914
integer y = 1008
integer width = 320
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Apply"
end type

event clicked;st_generic_structure l_st_parm

IF dw_1.Accepttext() <> 1 THEN RETURN

IF dw_1.Accepttext() <> 1 THEN RETURN

// If part number field is blank or null, then prompt user for input...								-  ADD 04-12-2000 KAZ
If ( dw_1.object.part[1] = '' OR isnull ( dw_1.object.part[1] ) ) Then								// ADD 04-12-2000 KAZ
	MessageBox ( monsys.msg_title, "Please enter a Part Number!", StopSign! )						// ADD 04-12-2000 KAZ
	dw_1.SetFocus()																									// ADD 04-12-2000 KAZ
	dw_1.SetColumn(1)																									// ADD 04-12-2000 KAZ
	Return																												// ADD 04-12-2000 KAZ
End If																													// ADD 04-12-2000 KAZ

// If GL account field is blank or null, then prompt user for input...								-  ADD 04-12-2000 KAZ
If ( dw_1.object.gl_account[1] = '' OR isnull ( dw_1.object.gl_account[1] ) ) Then				// ADD 04-12-2000 KAZ
	MessageBox ( monsys.msg_title, "Please enter a GL Account!", StopSign! )						// ADD 04-12-2000 KAZ
	dw_1.SetFocus()																									// ADD 04-12-2000 KAZ
	dw_1.SetColumn(6)																									// ADD 04-12-2000 KAZ
	Return																												// ADD 04-12-2000 KAZ
End If																													// ADD 04-12-2000 KAZ

l_st_parm.value1 = dw_1.object.part[1]
l_st_parm.value2 = dw_1.object.name[1]
l_st_parm.value3 = STRING ( dw_1.object.date[1] ) 
l_st_parm.value4 = STRING ( dw_1.object.qty[1] )
l_st_parm.value5 = STRING ( dw_1.object.price[1] )
l_st_parm.value6 = dw_1.object.gl_account[1]
l_st_parm.value7 = dw_1.object.project[1]
l_st_parm.value8 = dw_1.object.units[1]
l_st_parm.value9 = STRING ( dw_1.object.other_charge[1] )
l_st_parm.value10 = dw_1.object.taxable[1]

if isvalid ( w_normal_po_entry ) then
	w_normal_po_entry.Dynamic Trigger Event save_non_reoccuring_item ( l_st_parm )
end if

this.enabled = FALSE
end event

type cb_save from commandbutton within w_non_recurring_item
event ue_keydown pbm_keydown
integer x = 183
integer y = 1008
integer width = 320
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event ue_keydown;if keydown ( keyenter! ) then triggerevent ( clicked! )
	
end event

event clicked;/* 04-12-2000 KAZ Modified to make part number and GL account fields mandatory.  Issue # 11727. */

st_generic_structure l_st_parm

IF dw_1.Accepttext() <> 1 THEN RETURN

// If part number field is blank or null, then prompt user for input...								-  ADD 04-12-2000 KAZ
If ( dw_1.object.part[1] = '' OR isnull ( dw_1.object.part[1] ) ) Then								// ADD 04-12-2000 KAZ
	MessageBox ( monsys.msg_title, "Please enter a Part Number!", StopSign! )						// ADD 04-12-2000 KAZ
	dw_1.SetFocus()																									// ADD 04-12-2000 KAZ
	dw_1.SetColumn(1)																									// ADD 04-12-2000 KAZ
	Return																												// ADD 04-12-2000 KAZ
End If																													// ADD 04-12-2000 KAZ

// If GL account field is blank or null, then prompt user for input...								-  ADD 04-12-2000 KAZ
If ( dw_1.object.gl_account[1] = '' OR isnull ( dw_1.object.gl_account[1] ) ) Then				// ADD 04-12-2000 KAZ
	MessageBox ( monsys.msg_title, "Please enter a GL Account!", StopSign! )						// ADD 04-12-2000 KAZ
	dw_1.SetFocus()																									// ADD 04-12-2000 KAZ
	dw_1.SetColumn(6)																									// ADD 04-12-2000 KAZ
	Return																												// ADD 04-12-2000 KAZ
End If																													// ADD 04-12-2000 KAZ

l_st_parm.value1 = dw_1.object.part[1]
l_st_parm.value2 = dw_1.object.name[1]
l_st_parm.value3 = STRING ( dw_1.object.date[1] ) 
l_st_parm.value4 = STRING ( dw_1.object.qty[1] )
l_st_parm.value5 = STRING ( dw_1.object.price[1] )
l_st_parm.value6 = dw_1.object.gl_account[1]
l_st_parm.value7 = dw_1.object.project[1]
l_st_parm.value8 = dw_1.object.units[1]
l_st_parm.value9 = STRING ( dw_1.object.other_charge[1] )
l_st_parm.value10 = dw_1.object.taxable[1]

close ( parent )

if isvalid ( w_normal_po_entry ) then
	w_normal_po_entry.Dynamic Trigger Event save_non_reoccuring_item ( l_st_parm )
end if

end event

type cb_exit from commandbutton within w_non_recurring_item
event ue_keydown pbm_keydown
integer x = 553
integer y = 1008
integer width = 320
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event ue_keydown;if keydown ( keyenter! ) then close ( parent )
end event

event clicked;close ( parent )
end event

type dw_1 from datawindow within w_non_recurring_item
event ue_key_down pbm_dwnkey
integer x = 27
integer y = 24
integer width = 1234
integer height = 920
integer taborder = 10
string dataobject = "dw_non_reoccuring_item"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key_down;INTEGER 	l_i_column

l_i_column = this.getcolumn()

IF  KeyDown(KeyEnter!) THEN
	IF l_i_column = 8 THEN
		cb_save.setfocus()
	ELSE
		cb_save.triggerevent ( clicked! )
	END IF
END IF

end event

event itemchanged;string l_s_part

cb_apply.enabled = TRUE

IF dwo.name = 'part' THEN
	
	l_s_part = this.gettext()
	
	STRING	l_s_name, &
				l_s_req_no, &
				l_s_account, &
				l_s_unit
			
	DATETIME	l_d_date

	DECIMAL	l_n_qty, &
				l_n_price

 SELECT  po_detail.description,   
         po_detail.date_due,   
         po_detail.requisition_number,   
         po_detail.account_code,   
         po_detail.quantity,   
         po_detail.price,
			po_detail.unit_of_measure
    INTO :l_s_name,   
         :l_d_date,
         :l_s_req_no,
         :l_s_account,
         :l_n_qty,
         :l_n_price,
			:l_s_unit
    FROM po_detail  
   WHERE ( po_detail.po_number = :i_l_po ) AND  
         ( po_detail.part_number = :l_s_part )  ;

	IF SQLCA.SQLCODE = 0 THEN
		dw_1.SetItem ( 1, 2, l_s_name )
		dw_1.SetItem ( 1, 3, l_d_date )
		dw_1.SetItem ( 1, 4, l_n_qty )
		dw_1.SetItem ( 1, 5, l_n_price )
		dw_1.SetItem ( 1, 6, l_s_account )
		dw_1.SetItem ( 1, 7, l_s_req_no )
		dw_1.SetItem ( 1, 8, l_s_unit )
	END IF
	
	
ELSEIF this.getcolumn() = 8 THEN

		cb_save.setfocus()
		
END IF
end event

event itemfocuschanged;/* 04-12-2000 KAZ Created to make part number and GL account fields mandatory.  Issue # 11727. */

// If tabbed to part name and part number is blank or null, prompt user for input...			-  ADD 04-12-2000 KAZ
IF dwo.name = 'name' THEN
	If ( object.part[1] = ''  OR  isnull ( object.part[1] ) ) Then
		MessageBox ( monsys.msg_title, "Please enter a Part Number!", Information! )
		dw_1.setcolumn ( 1 )
	End If
End If

// If tabbed to project and GL account is blank or null, prompt user for input...
If dwo.name = 'project' Then
	If ( object.gl_account[1] = '' OR isnull ( object.gl_account[1] ) ) Then
		MessageBox ( monsys.msg_title, "Please enter a GL Account!", Information! )
		dw_1.setcolumn ( 6 )
	End If
End If																													// END 04-12-2000 KAZ

end event

