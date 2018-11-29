$PBExportHeader$w_issue_manager.srw
forward
global type w_issue_manager from w_sheet_4t
end type
type tab_1 from tab within w_issue_manager
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type ole_1 from olecontrol within tabpage_3
end type
type dw_3 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
ole_1 ole_1
dw_3 dw_3
end type
type tab_1 from tab within w_issue_manager
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_issue_manager from w_sheet_4t
string title = "Issue Manager"
string menuname = "m_issues_manager"
tab_1 tab_1
end type
global w_issue_manager w_issue_manager

type variables
boolean		ib_changed,&
		ib_status_changed

long	il_First, &
	il_Last, &
	il_Current

Long	il_IssueNumbers[]
Any	ia_IssueNumbers[]
end variables

on w_issue_manager.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_issues_manager" then this.MenuID = create m_issues_manager
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_issue_manager.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event resize;call super::resize;tab_1.width = width - 50
tab_1.height = height - 110
tab_1.Trigger Event ue_resize ( )
end event

event open;call super::open;st_generic_structure	lstr_parm

lstr_parm = Message.PowerObjectParm

if isnull(lstr_parm.value1,'') > '' then
	il_Current = Long ( lstr_parm.value1 )	
	il_First   = Long ( lstr_parm.value2 )	
	il_Last	   = Long ( lstr_parm.value3 )	
	if isvalid ( w_customerservice_old) then 
		ia_issuenumbers = w_customerservice_old.uo_1.dw_1.object.issue_number.primary //ia_issuenoAry
	end if 	
	il_Last    = UpperBound ( ia_issuenumbers ) 
	if isnull(il_Last) or il_Last < 0 then il_last = 0
	for il_first = 1 to il_Last
		if long(ia_issuenumbers[il_first]) = il_Current then
			il_Current = il_First
			il_first = il_last
		end if 	
	next
	il_first = 1
	if il_Last > 0 then 
		tab_1.Post Event ue_retrieve ( long( ia_issuenumbers [il_Current]) )
	else
		tab_1.Post Event ue_retrieve ( il_current )
	end if 	
else
	tab_1.Post Event ue_new ( lstr_parm )
end if

end event

type tab_1 from tab within w_issue_manager
event type integer ue_retrieve ( long al_issue )
event type integer ue_new ( st_generic_structure astr_parm )
event ue_save ( )
event ue_enter_history ( )
event ue_load_ole ( )
event ue_paste_ole ( )
event ue_new_ole ( )
event ue_resize ( )
event ue_newissue ( )
integer width = 2249
integer height = 1408
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

event ue_retrieve;tabpage_1.dw_1.Retrieve ( al_issue )
tabpage_2.dw_2.Retrieve ( al_issue )
tabpage_3.dw_3.Retrieve ( String ( al_issue ) )

return 1
end event

event ue_new;string				ls_product_line,&
						ls_category,&
						ls_sub_category,&
						ls_status,&
						ls_message,&
						ls_temp
datawindowchild	ldwc_dddw

m_issues_manager.m_edit.m_addfile.enabled = false
m_issues_manager.m_edit.m_adddocument.enabled = false

tabpage_1.dw_1.InsertRow ( 1 )
tabpage_1.dw_1.SetItem ( 1, "origin_type", astr_parm.value2 )
if isnull(astr_parm.value2, '') > '' then
	choose case astr_parm.value2
		case 'E'
			tabpage_1.dw_1.modify ( "origin.dddw.name='d_issues_employee_list'" )
		case 'C'
			tabpage_1.dw_1.modify ( "origin.dddw.name='d_issues_customer_list'" )
	end choose
	tabpage_1.dw_1.getchild ( "origin", ldwc_dddw )
	ldwc_dddw.SetTransObject ( sqlca )
	if ldwc_dddw.retrieve ( ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if
tabpage_1.dw_1.SetItem ( 1, "origin", astr_parm.value3 )
tabpage_1.dw_1.SetItem ( 1, "product_code", astr_parm.value4 )

if isnull(astr_parm.value4,'')>'' then
	sqlca.of_get_product_line_for_part ( astr_parm.value4, ls_product_line )
	if isnull(ls_product_line,'') > '' then
		tabpage_1.dw_1.getchild ( "product_code", ldwc_dddw )
		ldwc_dddw.SetTransObject ( sqlca )
		if ldwc_dddw.retrieve ( ls_product_line ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if
	end if
end if

sqlca.of_get_defaults_for_issue ( ls_category, ls_sub_category, ls_status )
tabpage_1.dw_1.setitem ( 1, "priority_level", 10 )
tabpage_1.dw_1.setitem ( 1, "status", ls_status )
tabpage_1.dw_1.setitem ( 1, "category", ls_category )
tabpage_1.dw_1.setitem ( 1, "sub_category", ls_sub_category )

if isnull(tabpage_1.dw_1.object.environment_message[1],'') = '' then
	select 	issues_environment_message
	into		:ls_message
	from		parameters  ;
	if isnull(ls_message,'') = '' then
		ls_message = 'Environment:'
	end if
	tabpage_1.dw_1.object.environment_message[1] = ls_message
end if

ls_temp = tabpage_1.dw_1.object.product_line[1]
if isnull(ls_temp,'') > '' then
	tabpage_1.dw_1.getchild ( "product_code", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

ls_temp = tabpage_1.dw_1.object.product_code[1]
if isnull(ls_temp,'') > '' then
	tabpage_1.dw_1.getchild ( "product_component", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

ls_temp = tabpage_1.dw_1.object.category[1]
if isnull(ls_temp,'') > '' then
	tabpage_1.dw_1.getchild ( "sub_category", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

return 1
end event

event ue_save;blob 		lb_object
long		ll_issue_number
string	ls_desc

Choose case selectedtab
	case 1
		st_generic_structure	lstr_parm
		
		tabpage_1.dw_1.AcceptText ( )
		
		if isnull(tabpage_1.dw_1.GetItemNumber ( 1, "issue_number" ), 0 ) = 0 then
			if sqlca.of_get_next_issue_number ( ll_issue_number ) = 0 then
				tabpage_1.dw_1.SetItem ( 1, "issue_number", ll_issue_number )
			else
				MessageBox ( "Issues System", "Unable to get next issue number.  Issue will not be saved.", Information! )
				return
			end if
		end if
		
		if isnull(tabpage_1.dw_1.getitemstring(1, "origin"),'') = '' then
			MessageBox ( "Save of Issue", "You must choose a valid origin to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "origin" )
			tabpage_1.dw_1.SetFocus ( )
			return
		elseif isnull(tabpage_1.dw_1.getitemstring(1,"category"),'') = '' then
			MessageBox ( "Save of Issue", "You must choose a valid category to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "category" )
			tabpage_1.dw_1.SetFocus ( )
			return			
		elseif isnull(tabpage_1.dw_1.getitemstring(1,"product_line"),'') = '' then
			MessageBox ( "Save of Issue", "You must choose a valid product line to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "product_line" )
			tabpage_1.dw_1.SetFocus ( )
			return			
		elseif isnull(tabpage_1.dw_1.getitemstring(1,"product_code"),'') = '' then
			MessageBox ( "Save of Issue", "You must choose a valid product code to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "product_code" )
			tabpage_1.dw_1.SetFocus ( )
			return			
		elseif isnull(tabpage_1.dw_1.getitemstring(1,"status"),'') = '' then
			MessageBox ( "Save of Issue", "You must choose a valid status to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "status" )
			tabpage_1.dw_1.SetFocus ( )
			return			
		elseif isnull(tabpage_1.dw_1.getitemnumber(1,"priority_level"),0) = 0 then
			tabpage_1.dw_1.setitem ( 1, "priority_level", 10 )
		elseif isnull(tabpage_1.dw_1.getitemstring(1,"issue"),'') = '' then
			MessageBox ( "Save of Issue", "You must enter an issue to continue!", Information! )
			tabpage_1.dw_1.SetColumn ( "issue" )
			tabpage_1.dw_1.SetFocus ( )
			return			
		end if
		
		if ib_status_changed then
			
			lstr_parm.value1 = String ( tabpage_1.dw_1.GetItemNumber ( 1, "issue_number" ) )
			lstr_parm.value2 = ''
			lstr_parm.value3 = tabpage_1.dw_1.GetItemString ( 1, "status" )
			
			OpenWithParm ( w_issue_change_entry, lstr_parm )
			
			if Message.DoubleParm = 0 then 
				tabpage_2.dw_2.Retrieve ( tabpage_1.dw_1.GetItemNumber ( 1, "issue_number" ) )
			else
				return
			end if

			tabpage_1.dw_1.setitem(1,"solution", tabpage_2.dw_2.getitemstring(1, "notes"))
		end if
		
		if tabpage_1.dw_1.Update ( ) = 1 then
			commit ;
			m_issues_manager.m_edit.m_addfile.enabled = true
			m_issues_manager.m_edit.m_adddocument.enabled = true
		else
			rollback ;
			MessageBox ( "Issues System", "Unable to save issue due to database error.", Information! )
		end if
	case 2
	case 3
end choose
end event

event ue_resize;tabtriggerevent ( "ue_resize" )
end event

event ue_newissue;st_generic_structure	lstr_parm
lstr_parm = Message.PowerObjectParm
lstr_parm.value2 = ''
lstr_parm.value3 = ''
tab_1.Post Event ue_new ( lstr_parm )
end event

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event key;Choose case Key
	case KeyPageUp!
		if il_First > 0 then
			if il_Current > il_First then
				il_Current --
			else
				il_Current = il_Last
			end if 	
			tab_1.Post Event ue_retrieve ( long ( ia_issuenumbers[il_Current] ))	
		end if 	
	case KeyPageDown!
		if il_Last > 0 then
			if il_Current < il_last then
				il_Current ++
			else
				il_Current = il_First
			end if 	
			tab_1.Post Event ue_retrieve ( long ( ia_issuenumbers[il_Current] ))
		end if 	
end choose
end event

type tabpage_1 from userobject within tab_1
event ue_resize ( )
integer x = 18
integer y = 112
integer width = 2213
integer height = 1280
long backcolor = 79741120
string text = "Header Information"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

event ue_resize;dw_1.height = height 
dw_1.width = width 
end event

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_1
event ue_stupid_powerbuilder_error ( )
event ue_key pbm_dwnkey
integer y = 16
integer width = 2048
integer height = 1264
integer taborder = 20
string dataobject = "d_issue_header"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_stupid_powerbuilder_error;string	ls_temp

ls_temp = object.issue[1]
object.issue[1] = ''
object.issue[1] = ls_temp

ls_temp = object.environment[1]
object.environment[1] = ''
object.environment[1] = ls_temp

end event

event ue_key;Choose case Key
	case KeyPageUp!
		if il_First > 0 then
			if il_Current > il_First then
				il_Current --
			else
				il_Current = il_Last
			end if 	
			tab_1.Post Event ue_retrieve ( long ( ia_issuenumbers[il_Current] ))	
		end if 	
	case KeyPageDown!
		if il_Last > 0 then
			if il_Current < il_last then
				il_Current ++
			else
				il_Current = il_First
			end if 	
			tab_1.Post Event ue_retrieve ( long ( ia_issuenumbers[il_Current] ))
		end if 	
end choose
end event

event itemchanged;datawindowchild	ldwc_dddw

choose case dwo.name
	case "origin_type"
		choose case data
			case 'E'
				modify ( "origin.dddw.name='d_issues_employee_list'" )
			case 'C'
				modify ( "origin.dddw.name='d_issues_customer_list'" )
		end choose
		setitem ( 1, "origin", '' )
		getchild ( "origin", ldwc_dddw )
		ldwc_dddw.SetTransObject ( sqlca )
		if ldwc_dddw.retrieve ( ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if
	case "product_line"
		setitem ( 1, "product_code", '' )
		getchild ( "product_code", ldwc_dddw )
		if ldwc_dddw.retrieve ( data ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if
	case "product_code"
		setitem ( 1, "product_component", '' )
		getchild ( "product_component", ldwc_dddw )
		if ldwc_dddw.retrieve ( data ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if
	case "category"
		setitem ( 1, "sub_category", '' )
		getchild ( "sub_category", ldwc_dddw )
		if ldwc_dddw.retrieve ( data ) < 1 then
			ldwc_dddw.InsertRow ( 1 )
		end if
	case "status"
		if isnull(GetItemNumber ( 1, "issue_number" ), 0 ) > 0 then &
			ib_status_changed = TRUE
end choose
end event

event constructor;datawindowchild	ldwc_dddw

getchild ( "sub_category", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

getchild ( "product_code", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

getchild ( "product_component", ldwc_dddw )
ldwc_dddw.SetTransObject ( sqlca )
ldwc_dddw.InsertRow ( 1 )

SetTransObject ( sqlca )
end event

event updatestart;if IsNull(GetItemDateTime ( 1, "start_date" )) then &
	SetItem ( 1, "start_date", Now ( ) )
end event

event retrieveend;string				ls_message,&
						ls_temp
datawindowchild	ldwc_dddw

Post Event ue_stupid_powerbuilder_error ( )

select 	issues_environment_message
into		:ls_message
from		parameters  ;
if isnull(ls_message,'') = '' then
	ls_message = 'Environment:'
end if
object.environment_message[1] = ls_message

ls_temp = object.product_line[1]
if isnull(ls_temp,'') > '' then
	getchild ( "product_code", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

ls_temp = object.product_code[1]
if isnull(ls_temp,'') > '' then
	getchild ( "product_component", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

ls_temp = object.category[1]
if isnull(ls_temp,'') > '' then
	getchild ( "sub_category", ldwc_dddw )
	if ldwc_dddw.Retrieve ( ls_temp ) < 1 then
		ldwc_dddw.InsertRow ( 1 )
	end if
end if

end event

type tabpage_2 from userobject within tab_1
event ue_resize ( )
integer x = 18
integer y = 112
integer width = 2213
integer height = 1280
long backcolor = 79741120
string text = "History"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

event ue_resize;dw_2.height = height
dw_2.width = width 
end event

on tabpage_2.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_2.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_2
integer width = 1883
integer height = 1088
integer taborder = 30
string dataobject = "d_issue_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( sqlca )
end event

type tabpage_3 from userobject within tab_1
event ue_paste ( )
event ue_add_document ( )
event ue_add_file ( )
event ue_save ( )
event ue_resize ( )
event ue_delete ( )
integer x = 18
integer y = 112
integer width = 2213
integer height = 1280
long backcolor = 79741120
string text = "Documents"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
ole_1 ole_1
dw_3 dw_3
end type

event ue_paste;int 	li_rc

//saved or abandon the control changes

//copies the data in the clipboard to the ole control
li_rc = ole_1.paste( ) 
If li_rc <> 0 Then 
	Messagebox("Paste","The contents of the clipboard was not copied to the OLE control")
	return
end if

Post Event ue_save ( )

end event

event ue_add_document;//saved or abandon the control changes

// Using the ole funtion insertobject() the user will
// be prompted from a listing for avialable ole servers on their system.
// The ole control will then be loaded with a blank ole object of that type.
if ole_1.insertobject( ) = 0 then
	Post Event ue_save ( )
end if
end event

event ue_add_file;string	ls_path,&
			ls_filename
			
// make sure previous object is saved if changed

GetFileOpenName("Select File to Attach",ls_path,ls_filename)

If ls_filename = "" Then return

if ole_1.insertfile(ls_path) = 0 then
	Post Event ue_save ( )
end if

end event

event ue_save;string	ls_issue_number,&
			ls_desc
blob		lb_object
int		li_count

ls_issue_number = String ( tabpage_1.dw_1.GetItemNumber ( 1, "issue_number" ) )

if isnull(ls_issue_number) or ls_issue_number <= '' then 
	Messagebox ("System Message", "Can't save the file without saving the issue")
	return
end if 

DO
	Open ( w_get_ole_description )
	ls_desc = Message.StringParm
	
	select	count(*)
	into		:li_count 
	from		ole_objects
	where		id = :ls_desc and
				parent_id = :ls_issue_number ;
	
	if ls_desc = "" Then
		Messagebox ( "Save Document", "Please supply a unique name for this document." )
	end if
	
LOOP WHILE li_count > 0

lb_object = tabpage_3.ole_1.objectdata

INSERT INTO ole_objects ( id, ole_object, parent_id, date_stamp, serial, parent_type )  
	values ( :ls_desc, ' ', :ls_issue_number, GetDate(), 0, 'I' ) ;

if SQLCA.SQLCode = -1 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
	return
end if

sqlca.autocommit = TRUE

updateblob ole_objects set ole_object = :lb_object
	where id = :ls_desc and
			parent_id = :ls_issue_number ;

if SQLCA.SQLCode = -1 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
	return
end if

commit;

sqlca.autocommit = FALSE

tabpage_3.dw_3.retrieve( ls_issue_number )

end event

event ue_resize;dw_3.height = height
dw_3.width = width

//ole_1.height = height
//ole_1.width = .50 * width - 15
//ole_1.x = dw_3.width + 15
end event

event ue_delete;string	ls_id,&
			ls_parent_id

if dw_3.GetRow ( ) > 0 then
	if dw_3.IsSelected ( dw_3.GetRow ( ) ) then
		ls_id = dw_3.GetItemString ( dw_3.GetRow ( ), "id" )
		ls_parent_id = dw_3.GetItemString ( dw_3.GetRow ( ), "parent_id" )
		if MessageBox ( "Delete", "Are you sure about deleting document '" + ls_id + "'?", Question!, YesNo!, 2 ) = 1 then
			delete from ole_objects where id = :ls_id and parent_id = :ls_parent_id ;
			if sqlca.sqlcode = 0 then
				commit;
				dw_3.Retrieve ( String ( tabpage_1.dw_1.GetItemNumber ( 1, "issue_number" ) ) )
			else
				rollback;
			end if
		end if
	end if
end if
end event

on tabpage_3.create
this.ole_1=create ole_1
this.dw_3=create dw_3
this.Control[]={this.ole_1,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.ole_1)
destroy(this.dw_3)
end on

type ole_1 from olecontrol within tabpage_3
boolean visible = false
integer x = 1010
integer y = 4
integer width = 1202
integer height = 1280
integer taborder = 30
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_issue_manager.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

event doubleclicked;//ole_1.Activate ( OffSite! )
end event

type dw_3 from datawindow within tabpage_3
integer y = 4
integer width = 1682
integer height = 1280
integer taborder = 30
string dataobject = "d_ole_object_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string 	ls_id
blob 		ole_blob
int 		li_rc

If row <=0 Then return

//change selected row
this.selectrow(0, false)
this.selectrow(row, true)

ls_id = object.id[row]

//this actually loads the ole control from the database into a blob variable
selectblob ole_object  into :ole_blob from ole_objects
 	where id = :ls_id;

if SQLCA.SQLCode <> 0 then
	MessageBox("SQL error",SQLCA.SQLErrText,Information!)
end if

//assigning the blob data to the actual data control
ole_1.objectdata = ole_blob

//show the type of ole control at the bottom
//st_type.text = ole_1.classlongname
end event

event constructor;SetTransObject ( sqlca )
end event

event doubleclicked;ole_1.Activate ( OffSite! )
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_issue_manager.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_issue_manager.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
