$PBExportHeader$w_part_master.srw
$PBExportComments$Part master maintenance window.
forward
global type w_part_master from w_sheet_4t
end type
type tab_part_master from tab within w_part_master
end type
type tabpage_general from userobject within tab_part_master
end type
type sle_newpart from singlelineedit within tabpage_general
end type
type dw_part_general from datawindow within tabpage_general
end type
type tabpage_general from userobject within tab_part_master
sle_newpart sle_newpart
dw_part_general dw_part_general
end type
type tabpage_inventory from userobject within tab_part_master
end type
type dw_part_inventory from datawindow within tabpage_inventory
end type
type dw_header_inventory from datawindow within tabpage_inventory
end type
type tabpage_inventory from userobject within tab_part_master
dw_part_inventory dw_part_inventory
dw_header_inventory dw_header_inventory
end type
type tabpage_account_codes from userobject within tab_part_master
end type
type dw_sales_account from datawindow within tabpage_account_codes
end type
type dw_payment_account from datawindow within tabpage_account_codes
end type
type dw_header_accounts from datawindow within tabpage_account_codes
end type
type tabpage_account_codes from userobject within tab_part_master
dw_sales_account dw_sales_account
dw_payment_account dw_payment_account
dw_header_accounts dw_header_accounts
end type
type tabpage_ecc from userobject within tab_part_master
end type
type cb_3 from commandbutton within tabpage_ecc
end type
type cb_2 from commandbutton within tabpage_ecc
end type
type cb_1 from commandbutton within tabpage_ecc
end type
type dw_part_engineering_change_control from u_dw_ecc within tabpage_ecc
end type
type tabpage_ecc from userobject within tab_part_master
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_part_engineering_change_control dw_part_engineering_change_control
end type
type tabpage_kanban_inventory from userobject within tab_part_master
end type
type dw_kanban_inventory_details from datawindow within tabpage_kanban_inventory
end type
type dw_kanban_inventory_header from datawindow within tabpage_kanban_inventory
end type
type tabpage_kanban_inventory from userobject within tab_part_master
dw_kanban_inventory_details dw_kanban_inventory_details
dw_kanban_inventory_header dw_kanban_inventory_header
end type
type tabpage_issues from userobject within tab_part_master
end type
type dw_issues from datawindow within tabpage_issues
end type
type tabpage_issues from userobject within tab_part_master
dw_issues dw_issues
end type
type tabpage_where_used from userobject within tab_part_master
end type
type dw_where_used from datawindow within tabpage_where_used
end type
type tabpage_where_used from userobject within tab_part_master
dw_where_used dw_where_used
end type
type tab_part_master from tab within w_part_master
tabpage_general tabpage_general
tabpage_inventory tabpage_inventory
tabpage_account_codes tabpage_account_codes
tabpage_ecc tabpage_ecc
tabpage_kanban_inventory tabpage_kanban_inventory
tabpage_issues tabpage_issues
tabpage_where_used tabpage_where_used
end type
type st_2 from statictext within w_part_master
end type
type st_1 from statictext within w_part_master
end type
end forward

shared variables

end variables

global type w_part_master from w_sheet_4t
string title = "Part Master"
string menuname = "m_part_master"
event new_part ( )
event save_part ( )
event exit_routine ( )
event ue_open ( )
event copy_part ( )
event uom ( )
event sales ( )
event purchasing ( )
event flowrouter ( )
event notes ( )
event characteristics ( )
event packaging ( )
tab_part_master tab_part_master
st_2 st_2
st_1 st_1
end type
global w_part_master w_part_master

type variables
BOOLEAN	i_b_modified

STRING		i_s_part,&
		is_issue_select

DataWindowChild	i_dwc_type, &
		i_dwc_vendor

Long		il_clickedrow=0
end variables

forward prototypes
public function boolean uf_query_save ()
public subroutine uf_assign (datawindow ar_dwo, integer ar_colno)
public function integer uf_verifyunits ()
end prototypes

event new_part;IF uf_query_save ( ) THEN
	i_s_part = ""
	tab_part_master.tabpage_general.dw_part_general.Retrieve ( i_s_part )
	tab_part_master.tabpage_general.dw_part_general.SetColumn ( 1 )
	tab_part_master.tabpage_general.dw_part_general.SetFocus ( )
	tab_part_master.SelectTab ( 1 )
END IF
end event

event save_part;string	ls_unit, ls_newunit
string	ls_uccode

Pointer	l_ptr_old

//tab_part_master.tabpage_general.dw_part_general.AcceptText ( )
tab_part_master.tabpage_inventory.dw_part_inventory.AcceptText ( )

IF IsNull ( tab_part_master.tabpage_general.dw_part_general.object.part[1], '' ) = '' THEN
	MessageBox ( monsys.msg_title, "A valid part code is required", StopSign! )
	tab_part_master.SelectTab ( 1 )
	tab_part_master.tabpage_general.dw_part_general.SetColumn ( "part" )
	tab_part_master.tabpage_general.dw_part_general.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_general.dw_part_general.object.name[1], '' ) = '' THEN
	MessageBox ( monsys.msg_title, "A valid part name is required", StopSign! )
	tab_part_master.SelectTab ( 1 )
	tab_part_master.tabpage_general.dw_part_general.SetColumn ( "name" )
	tab_part_master.tabpage_general.dw_part_general.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_general.dw_part_general.object.class[1], '' ) = '' THEN
	MessageBox ( monsys.msg_title, "A valid part class is required", StopSign! )
	tab_part_master.SelectTab ( 1 )
	tab_part_master.tabpage_general.dw_part_general.SetColumn ( "class" )
	tab_part_master.tabpage_general.dw_part_general.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_general.dw_part_general.object.type[1], '' ) = '' THEN 
	IF	tab_part_master.tabpage_general.dw_part_general.object.class[1] <> 'A' AND &
		tab_part_master.tabpage_general.dw_part_general.object.class[1] <> 'N' THEN
		MessageBox ( monsys.msg_title, "A valid part type is required", StopSign! )
	   tab_part_master.SelectTab ( 1 )
	   tab_part_master.tabpage_general.dw_part_general.SetColumn ( "type" )
	   tab_part_master.tabpage_general.dw_part_general.SetFocus ( )
		Return
	END IF
ELSEIF IsNull ( tab_part_master.tabpage_inventory.dw_part_inventory.object.standard_pack[1], 0 ) = 0 THEN
	MessageBox ( monsys.msg_title, "A valid standard pack is required", StopSign! )
	tab_part_master.SelectTab ( 2 )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetColumn ( "standard_pack" )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_inventory.dw_part_inventory.object.standard_unit[1], '' ) = '' THEN
	MessageBox ( monsys.msg_title, "A valid standard unit is required", StopSign! )
	tab_part_master.SelectTab ( 2 )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetColumn ( "standard_unit" )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_inventory.dw_part_inventory.object.unit_weight[1], 0 ) = 0 THEN
	MessageBox ( monsys.msg_title, "A valid unit weight is required", StopSign! )
	tab_part_master.SelectTab ( 2 )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetColumn ( "unit_weight" )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetFocus ( )
	Return
ELSEIF IsNull ( tab_part_master.tabpage_inventory.dw_part_inventory.object.label_format[1], '' ) = '' THEN
	MessageBox ( monsys.msg_title, "A valid label format is required", StopSign! )
	tab_part_master.SelectTab ( 2 )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetColumn ( "label_format" )
	tab_part_master.tabpage_inventory.dw_part_inventory.SetFocus ( )
	Return
END IF

if uf_verifyunits() = 1 then return

gnv_App.of_GetFrame().SetMicroHelp ( "Saving..." )
l_ptr_old = SetPointer ( HourGlass! )


IF tab_part_master.tabpage_general.dw_part_general.Update ( TRUE ) = -1 THEN
	MessageBox ( monsys.msg_title, "Unable to save general information for part:  " + i_s_part + ".  Save aborted", StopSign! )
	Return
ELSE
	//set update on for part if dw update is true
	tab_part_master.tabpage_general.dw_part_general.modify ("part.Update = Yes")	
END IF
IF tab_part_master.tabpage_inventory.dw_part_inventory.Update ( TRUE ) = -1 THEN
	MessageBox ( monsys.msg_title, "Unable to save inventory information for part:  " + i_s_part + ".  Save aborted", StopSign! )
	SQLCA.uf_rollback ( )
	Return
END IF
IF tab_part_master.tabpage_account_codes.dw_payment_account.Update ( TRUE ) = -1 THEN
	MessageBox ( monsys.msg_title, "Unable to save purchasing information for part:  " + i_s_part + ".  Save aborted", StopSign! )
	SQLCA.uf_rollback ( )
	Return
END IF
IF tab_part_master.tabpage_account_codes.dw_sales_account.Update ( TRUE ) = -1 THEN
	MessageBox ( monsys.msg_title, "Unable to save customer information for part:  " + i_s_part + ".  Save aborted", StopSign! )
	SQLCA.uf_rollback ( )
	Return
END IF
// include kanban inventory info by gph on 7/22/98 at 9.59 am, the below if block
IF tab_part_master.tabpage_kanban_inventory.dw_kanban_inventory_details.Update ( TRUE ) = -1 THEN
	MessageBox ( monsys.msg_title, "Unable to save kanban inventory information for part:  " + i_s_part + ".  Save aborted", StopSign! )
	SQLCA.uf_rollback ( )
	Return
END IF
SQLCA.uf_commit ( )
tab_part_master.tabpage_general.dw_part_general.Retrieve ( i_s_part )
end event

event exit_routine;Close ( This )
end event

event ue_open;tab_part_master.tabpage_general.dw_part_general.Retrieve ( i_s_part )
tab_part_master.tabpage_general.dw_part_general.SetColumn ( 1 )
tab_part_master.tabpage_general.dw_part_general.SetFocus ( )

//included this line to retrieve where used report - sm 5/25/2000
tab_part_master.tabpage_where_used.dw_where_used.retrieve(i_s_part)

end event

event copy_part;tab_part_master.tabpage_general.sle_newpart.show()
tab_part_master.tabpage_general.sle_newpart.setfocus()
tab_part_master.tabpage_general.sle_newpart.text=''


end event

event uom();
OpenSheetWithParm(w_conversion_part_link, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event sales();
OpenSheetWithParm(w_customer_price_matrix, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event purchasing();
OpenSheetWithParm(w_vendor_price_matrix, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event flowrouter();
OpenSheetWithParm(w_router_maintenance, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event notes();
OpenSheetWithParm(w_notes, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event characteristics();
OpenSheetWithParm(w_part_char, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

event packaging();
OpenSheetWithParm(w_part_package_materials, i_s_part, gnv_App.of_GetFrame(), 3, Original!)

end event

public function boolean uf_query_save ();INTEGER	l_i_result

IF NOT i_b_modified THEN
	Return TRUE
END IF

l_i_result = MessageBox ( monsys.msg_title, "Save changes to part:  " + i_s_part + "?", Question!, YesNoCancel! )
CHOOSE CASE l_i_result
	CASE 1
		// part column being a key update is set to false 
		tab_part_master.tabpage_general.dw_part_general.modify ("part.Update = No")
		TRIGGER EVENT save_part ( )
		Return TRUE
	CASE 2
		Return TRUE
	CASE ELSE
		REturn FALSE
END CHOOSE
end function

public subroutine uf_assign (datawindow ar_dwo, integer ar_colno);//	Declarations
string	ls_vendor
long	ll_ponumber
datawindowchild ldwc_child

//	Initilization
ar_dwo.getchild("default_po_number", ldwc_child)	
ldwc_child.settransobject(sqlca)
setnull(ls_vendor)
setnull(ll_ponumber)

ar_dwo.Accepttext()
//	If the column id default vendor, do the following
if ar_colno = 1 then 
	//	Get vendor, retrieve all the POs for that vendor
	ls_vendor = ar_dwo.getitemstring ( 1, "default_vendor")	
	ldwc_child.retrieve(ls_vendor)
	ldwc_child.insertrow(1)
	ldwc_child.scrolltorow(0)
	//	If vendor is null, get all the POs	
	if isnull(ls_vendor) then 
		ar_dwo.setitem(1, 'default_po_number',ll_ponumber)		
		ldwc_child.retrieve('')
		ldwc_child.insertrow(1)
		ldwc_child.scrolltorow(0)
	end if	
else	
	//	Get po number and 
	ll_ponumber = ar_dwo.getitemnumber(1, "default_po_number")	
	//	If not null get the vendor for that po and assign to dw
	if isnull(ll_ponumber,0) > 0 then 
		select	vendor_code
		into	:ls_vendor 
		from	po_header
		where	po_number = :ll_ponumber;
		ar_dwo.setitem(1, 'default_vendor',ls_vendor)
	else	
		//	If PO is null, then assign null to vendor and retrieve all POs
		ar_dwo.setitem(1, 'default_vendor',ls_vendor)
		ldwc_child.retrieve('')
		ldwc_child.insertrow(1)
		ldwc_child.scrolltorow(0)
	end if 	
end if 
end subroutine

public function integer uf_verifyunits ();string	ls_unit, ls_uccode, ls_newunit, ls_parent, ls_bomunit
long	ll_fndunit
dec	ld_conversion, ld_qty, ld_newstdqty
boolean	lb_success = true

select	pi.standard_unit,
	puc.code
into	:ls_unit,
	:ls_uccode
from	part_inventory pi
	left outer join part_unit_conversion puc on puc.part = pi.part
where	pi.part = :i_s_part;

if isnull(ls_unit,'') > '' then
	ls_newunit = tab_part_master.tabpage_inventory.dw_part_inventory.object.standard_unit[1]
	if ls_unit <> ls_newunit then 
		if isnull(ls_uccode,'') > '' then
			select	count(1)
			into	:ll_fndunit
			from	unit_conversion
			where	code = :ls_uccode and
				unit1 = :ls_newunit;
				
			if isnull(ll_fndunit,0) = 0 then 	
				Messagebox ( monsys.msg_title, "Unit "+ls_newunit +" is not defined under unit conversion associated with part "+i_s_part)
				return 1
			else
				declare bomparts cursor for
				select	parent_part, unit_measure, quantity
				from	bill_of_material_ec 
				where	end_datetime is null and
					part = :i_s_part;
				
				open	bomparts;
				
				fetch	bomparts into :ls_parent, :ls_bomunit, :ld_qty;
				
				do while sqlca.sqlcode = 0 	
					select	conversion
					into	:ld_conversion
					from	unit_conversion as uc
					where	code = :ls_uccode and
						unit1= :ls_bomunit and	
						unit2= :ls_newunit ;

					if ld_conversion <> 0 then 
						ld_newstdqty = ld_qty * isnull(ld_conversion,1)
					else
						ld_newstdqty = ld_qty
					end if

					update	bill_of_material_ec
					set	std_qty = :ld_newstdqty
					where	parent_part = :ls_parent and
						part = :i_s_part and 
						end_datetime is null;

					if sqlca.sqlcode <> 0 then lb_success = false
					fetch	bomparts into :ls_parent, :ls_bomunit, :ld_qty;
				loop 
				close	bomparts;
				if lb_success then
					commit;
				else
					rollback;
				end if 	
			end if 	
		end if 
	end if 	
end if 
return 0
end function

on w_part_master.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_part_master" then this.MenuID = create m_part_master
this.tab_part_master=create tab_part_master
this.st_2=create st_2
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_part_master
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
end on

on w_part_master.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_part_master)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;call super::open;i_s_part = IsNull ( Message.StringParm, "" )

POST EVENT ue_open ( )
end event

event closequery;call super::closequery;IF uf_query_save ( ) THEN
	Return 0
ELSE
	Return 1
END IF
end event

type tab_part_master from tab within w_part_master
event create ( )
event destroy ( )
integer x = 14
integer y = 4
integer width = 2382
integer height = 1308
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean multiline = true
boolean raggedright = true
boolean powertips = true
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_inventory tabpage_inventory
tabpage_account_codes tabpage_account_codes
tabpage_ecc tabpage_ecc
tabpage_kanban_inventory tabpage_kanban_inventory
tabpage_issues tabpage_issues
tabpage_where_used tabpage_where_used
end type

on tab_part_master.create
this.tabpage_general=create tabpage_general
this.tabpage_inventory=create tabpage_inventory
this.tabpage_account_codes=create tabpage_account_codes
this.tabpage_ecc=create tabpage_ecc
this.tabpage_kanban_inventory=create tabpage_kanban_inventory
this.tabpage_issues=create tabpage_issues
this.tabpage_where_used=create tabpage_where_used
this.Control[]={this.tabpage_general,&
this.tabpage_inventory,&
this.tabpage_account_codes,&
this.tabpage_ecc,&
this.tabpage_kanban_inventory,&
this.tabpage_issues,&
this.tabpage_where_used}
end on

on tab_part_master.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_inventory)
destroy(this.tabpage_account_codes)
destroy(this.tabpage_ecc)
destroy(this.tabpage_kanban_inventory)
destroy(this.tabpage_issues)
destroy(this.tabpage_where_used)
end on

event selectionchanged;if newindex = 1 then 
	m_part_master.m_file.m_fastcopy.enabled = true
else
	m_part_master.m_file.m_fastcopy.enabled = false
end if 	
	
end event

type tabpage_general from userobject within tab_part_master
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 79741120
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
sle_newpart sle_newpart
dw_part_general dw_part_general
end type

on tabpage_general.create
this.sle_newpart=create sle_newpart
this.dw_part_general=create dw_part_general
this.Control[]={this.sle_newpart,&
this.dw_part_general}
end on

on tabpage_general.destroy
destroy(this.sle_newpart)
destroy(this.dw_part_general)
end on

type sle_newpart from singlelineedit within tabpage_general
boolean visible = false
integer x = 832
integer y = 40
integer width = 837
integer height = 68
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;if text > '' and LenA(trim(text)) > 0 then 
	//	Declare variables
	string	ls_newpart
	string	ls_oldpart
	string	ls_message
	string	ls_ExecuteStatement	
	long    ll_result
	long	ll_option
	
	//	Hide sle text
	tab_part_master.tabpage_general.sle_newpart.hide()	
	
	//	Check whether the procedure exists
	select	isnull(count(1),0)
	into	:ll_result
	from	sysobjects
	where	name = 'msp_copypart' and type = 'P';
	if ll_result = 0 then
		Messagebox ( Monsys.msg_title, 'Procedure msp_copypart is missing in the database, Contact your system administrator')
		return
	end if 		
	
	if Messagebox ( Monsys.msg_title, 'Do you wish to continue with copying process ', Question!, YesNo!, 2) = 2 then return
	
	//	Assign values to local variables
	ls_oldpart = i_s_part
	ls_newpart = text
	
	//	Declare the procedure & execute the same 
	declare copypart dynamic procedure for SQLSA;
	
	ls_ExecuteStatement = &
		"begin "+&
		"	declare @returnvalue integer "+&
		" "+&
		" 	execute msp_copypart " + &
		"		?, "+&
		"		?, "+&			
		"		@returnvalue OUTPUT "+&
		" "+&
		"	select @returnvalue "+&
		"end "
		
	prepare SQLSA from :ls_ExecuteStatement ;	
	
	execute dynamic copypart using :ls_oldpart, :ls_newpart;
	
	fetch	copypart
	into	:ll_result;
	
	close	copypart ;

	//	verify the results from the procedure and display appropriate message
	Choose Case ll_result
		Case -1
			rollback;								
			ls_message = 'Invalid Argument'
		Case -2
			rollback;				
			ls_message = 'Part ' + ls_newpart + ' already exists in the database'
		Case else
			commit ;	
			ls_message = 'Part ' + ls_oldpart + ' was copied successfully to part '+ls_newpart
			i_s_part = ls_newpart
			gnv_App.of_GetFrame().GetActiveSheet().TriggerEvent("ue_open")
			
	End Choose
	if ls_message > '' then Messagebox(Monsys.msg_title,ls_message)					
end if 	
end event

type dw_part_general from datawindow within tabpage_general
event editchanged pbm_dwnchanging
event itemfocuschanged pbm_dwnitemchangefocus
event losefocus pbm_dwnkillfocus
integer x = 5
integer y = 16
integer width = 1970
integer height = 1180
integer taborder = 10
string dataobject = "d_part_master_general"
boolean border = false
end type

event constructor;SetTransObject ( SQLCA )
GetChild ( "type", i_dwc_type )
end event

event itemchanged;CHOOSE CASE Integer ( dwo.ID )
	CASE 1
		IF uf_query_save ( ) THEN
			i_s_part = String ( data )
			Retrieve ( i_s_part )
			i_b_modified = FALSE
		ELSE
			object.part [ 1 ] = i_s_part
		END IF
	CASE 4
		i_b_modified = TRUE

		i_dwc_type.Retrieve ( Data )
		object.type[1] = ''
	CASE ELSE
		i_b_modified = TRUE
END CHOOSE
end event

event retrieveend;IF NOT rowcount > 0 THEN
	InsertRow ( 1 )
	object.part [ 1 ] = i_s_part
	object.quality_alert[1] = 'N'
	object.serial_type[1] = 'I'
END IF

i_dwc_type.Retrieve ( IsNull ( object.data [ 1, 4 ], "M" ) )
tab_part_master.tabpage_inventory.dw_part_inventory.Retrieve ( i_s_part )
tab_part_master.tabpage_account_codes.dw_payment_account.Retrieve ( i_s_part )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.Retrieve ( i_s_part )
// below line inc by gph for kanban inventory info retrieval
tab_part_master.tabpage_kanban_inventory.dw_kanban_inventory_details.Retrieve ( i_s_part )
commit;
if isnull(i_s_part,'') > '' then
	tab_part_master.tabpage_issues.dw_issues.object.datawindow.table.select = is_issue_select + " WHERE product_code = '" + i_s_part + "' OR product_component = '" + i_s_part + "'"
	tab_part_master.tabpage_issues.dw_issues.retrieve ( )
end if 

i_b_modified = FALSE

ShareData ( tab_part_master.tabpage_inventory.dw_header_inventory )
end event

event retrievestart;i_dwc_type.SetTransObject ( SQLCA )
i_dwc_type.Retrieve ( 'M' )
end event

type tabpage_inventory from userobject within tab_part_master
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 79741120
string text = "Inventory"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_part_inventory dw_part_inventory
dw_header_inventory dw_header_inventory
end type

on tabpage_inventory.create
this.dw_part_inventory=create dw_part_inventory
this.dw_header_inventory=create dw_header_inventory
this.Control[]={this.dw_part_inventory,&
this.dw_header_inventory}
end on

on tabpage_inventory.destroy
destroy(this.dw_part_inventory)
destroy(this.dw_header_inventory)
end on

type dw_part_inventory from datawindow within tabpage_inventory
integer x = 78
integer y = 364
integer width = 1623
integer height = 716
integer taborder = 30
string dataobject = "d_part_master_inventory"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( SQLCA )
end event

event itemchanged;i_b_modified = TRUE
end event

event retrieveend;IF NOT rowcount > 0 THEN
	InsertRow ( 1 )
	This.SetItem(1, "material_issue_type", "U")
	object.part [ 1 ] = i_s_part
END IF
end event

type dw_header_inventory from datawindow within tabpage_inventory
integer x = 55
integer y = 72
integer width = 1998
integer height = 304
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_part_heading"
boolean border = false
boolean livescroll = true
end type

event constructor;tab_part_master.tabpage_general.dw_part_general.ShareData ( this )
end event

type tabpage_account_codes from userobject within tab_part_master
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 78682240
string text = "Accounting Codes"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_sales_account dw_sales_account
dw_payment_account dw_payment_account
dw_header_accounts dw_header_accounts
end type

on tabpage_account_codes.create
this.dw_sales_account=create dw_sales_account
this.dw_payment_account=create dw_payment_account
this.dw_header_accounts=create dw_header_accounts
this.Control[]={this.dw_sales_account,&
this.dw_payment_account,&
this.dw_header_accounts}
end on

on tabpage_account_codes.destroy
destroy(this.dw_sales_account)
destroy(this.dw_payment_account)
destroy(this.dw_header_accounts)
end on

type dw_sales_account from datawindow within tabpage_account_codes
integer x = 114
integer y = 456
integer width = 1426
integer height = 92
integer taborder = 60
string dataobject = "d_part_master_sales_account"
boolean border = false
boolean livescroll = true
end type

event constructor;tab_part_master.tabpage_general.dw_part_general.ShareData ( this )
end event

event itemchanged;i_b_modified = TRUE
end event

type dw_payment_account from datawindow within tabpage_account_codes
integer x = 169
integer y = 368
integer width = 1518
integer height = 80
integer taborder = 50
string dataobject = "d_part_master_payment_account"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( SQLCA )
end event

event itemchanged;i_b_modified = TRUE
end event

event retrieveend;IF NOT rowcount > 0 THEN
	InsertRow ( 1 )
	object.part [ 1 ] = i_s_part
END IF
end event

type dw_header_accounts from datawindow within tabpage_account_codes
integer x = 160
integer y = 60
integer width = 1998
integer height = 308
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_part_heading"
boolean border = false
boolean livescroll = true
end type

event constructor;tab_part_master.tabpage_general.dw_part_general.ShareData ( this )
end event

type tabpage_ecc from userobject within tab_part_master
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 78682240
string text = "Engineering Change"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_part_engineering_change_control dw_part_engineering_change_control
end type

on tabpage_ecc.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_part_engineering_change_control=create dw_part_engineering_change_control
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_part_engineering_change_control}
end on

on tabpage_ecc.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_part_engineering_change_control)
end on

type cb_3 from commandbutton within tabpage_ecc
integer x = 846
integer y = 940
integer width = 389
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Delete"
end type

event clicked;datetime	ldt_effectivedate

ldt_effectivedate = tab_part_master.tabpage_ecc.dw_part_engineering_change_control.object.effective_date[il_clickedrow]

delete	effective_change_notice
where	part = :i_s_part and
	effective_date = :ldt_effectivedate;

tab_part_master.tabpage_ecc.dw_part_engineering_change_control.DeleteRow ( il_clickedrow )
end event

type cb_2 from commandbutton within tabpage_ecc
integer x = 430
integer y = 940
integer width = 389
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add"
end type

event clicked;tab_part_master.tabpage_ecc.dw_part_engineering_change_control.InsertRow ( 1 )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.SetRow ( 1 )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.SetColumn ( 1 )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.SelectRow ( 0, FALSE )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.SelectRow ( 1, TRUE )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.SetFocus ( )
end event

type cb_1 from commandbutton within tabpage_ecc
integer x = 18
integer y = 940
integer width = 389
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;tab_part_master.tabpage_ecc.dw_part_engineering_change_control.Update ( )
tab_part_master.tabpage_ecc.dw_part_engineering_change_control.Retrieve ( i_s_part )
end event

type dw_part_engineering_change_control from u_dw_ecc within tabpage_ecc
integer x = 18
integer y = 48
integer width = 1888
integer height = 860
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
end type

event dberror;//return 1
end event

event clicked;call super::clicked;il_clickedrow = row
end event

type tabpage_kanban_inventory from userobject within tab_part_master
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 79741120
string text = "Kanban Inv."
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_kanban_inventory_details dw_kanban_inventory_details
dw_kanban_inventory_header dw_kanban_inventory_header
end type

on tabpage_kanban_inventory.create
this.dw_kanban_inventory_details=create dw_kanban_inventory_details
this.dw_kanban_inventory_header=create dw_kanban_inventory_header
this.Control[]={this.dw_kanban_inventory_details,&
this.dw_kanban_inventory_header}
end on

on tabpage_kanban_inventory.destroy
destroy(this.dw_kanban_inventory_details)
destroy(this.dw_kanban_inventory_header)
end on

type dw_kanban_inventory_details from datawindow within tabpage_kanban_inventory
integer x = 146
integer y = 380
integer width = 1893
integer height = 516
integer taborder = 60
string dataobject = "d_kanban_inventory_details"
boolean border = false
boolean livescroll = true
end type

event retrieveend;IF NOT rowcount > 0 THEN
	InsertRow ( 1 )
	object.part [ 1 ] = i_s_part
END IF
end event

event constructor;SetTransObject (SQLCA)
datawindowchild ldwc_child,&
		ldwc_vendor
					 
getchild("default_po_number", ldwc_child)
ldwc_child.settransobject(sqlca)
ldwc_child.retrieve('')
ldwc_child.insertrow(1)
ldwc_child.scrolltorow(0)

getchild("default_vendor", ldwc_vendor)
ldwc_vendor.settransobject(sqlca)
ldwc_vendor.retrieve()
ldwc_vendor.insertrow(1)

end event

event itemchanged;i_b_modified = TRUE
if dwo.name = 'default_vendor' then 
	uf_assign(this,1)
elseif dwo.name = 'default_po_number' then 
	uf_assign(this,2)
end if 	

end event

event retrievestart;//i_dwc_vendor.SetTransObject ( SQLCA )
//i_dwc_vendor.Retrieve ()
end event

type dw_kanban_inventory_header from datawindow within tabpage_kanban_inventory
integer x = 55
integer y = 76
integer width = 2002
integer height = 292
integer taborder = 30
string dataobject = "d_part_heading"
boolean border = false
boolean livescroll = true
end type

event constructor;tab_part_master.tabpage_general.dw_part_general.ShareData ( this )
end event

type tabpage_issues from userobject within tab_part_master
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 79741120
string text = "Issues"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_issues dw_issues
end type

on tabpage_issues.create
this.dw_issues=create dw_issues
this.Control[]={this.dw_issues}
end on

on tabpage_issues.destroy
destroy(this.dw_issues)
end on

type dw_issues from datawindow within tabpage_issues
integer y = 12
integer width = 2249
integer height = 1168
integer taborder = 40
string dataobject = "d_issues_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( sqlca )
is_issue_select = object.datawindow.table.select
end event

event doubleclicked;st_generic_structure	lstr_parm

if row > 0 then
	lstr_parm.value1 = String ( GetItemNumber ( row, "issue_number" ) )
	OpenSheetWithParm ( w_issue_manager, lstr_parm, gnv_App.of_GetFrame(), 0, Original! )
end if
end event

event clicked;if row > 0 then
	SelectRow ( 0, FALSE )
	SelectRow ( row, TRUE )
end if
end event

type tabpage_where_used from userobject within tab_part_master
integer x = 18
integer y = 100
integer width = 2345
integer height = 1192
long backcolor = 79741120
string text = "Where Used"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_where_used dw_where_used
end type

on tabpage_where_used.create
this.dw_where_used=create dw_where_used
this.Control[]={this.dw_where_used}
end on

on tabpage_where_used.destroy
destroy(this.dw_where_used)
end on

type dw_where_used from datawindow within tabpage_where_used
integer y = 24
integer width = 2322
integer height = 1148
integer taborder = 40
string dataobject = "d_bom_where_used"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type st_2 from statictext within w_part_master
integer x = 2066
integer y = 1344
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Required"
boolean focusrectangle = false
end type

type st_1 from statictext within w_part_master
integer x = 1979
integer y = 1324
integer width = 69
integer height = 92
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 78682240
boolean enabled = false
string text = "*"
boolean focusrectangle = false
end type

