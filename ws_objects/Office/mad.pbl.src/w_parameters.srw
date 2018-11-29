$PBExportHeader$w_parameters.srw
forward
global type w_parameters from w_sheet_4t
end type
type tab_1 from tab within w_parameters
end type
type tabpage_company from userobject within tab_1
end type
type dw_company from datawindow within tabpage_company
end type
type tabpage_company from userobject within tab_1
dw_company dw_company
end type
type tabpage_general from userobject within tab_1
end type
type dw_parm_general from datawindow within tabpage_general
end type
type sle_1 from singlelineedit within tabpage_general
end type
type dw_beginning_numbers from datawindow within tabpage_general
end type
type gb_3 from groupbox within tabpage_general
end type
type tv_1 from treeview within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type tabpage_general from userobject within tab_1
dw_parm_general dw_parm_general
sle_1 sle_1
dw_beginning_numbers dw_beginning_numbers
gb_3 gb_3
tv_1 tv_1
gb_4 gb_4
end type
type tabpage_inventory from userobject within tab_1
end type
type dw_inventory from datawindow within tabpage_inventory
end type
type cb_1 from commandbutton within tabpage_inventory
end type
type dw_inventory_transactions from datawindow within tabpage_inventory
end type
type st_trans from statictext within tabpage_inventory
end type
type ddlb_trans_list from dropdownlistbox within tabpage_inventory
end type
type tabpage_inventory from userobject within tab_1
dw_inventory dw_inventory
cb_1 cb_1
dw_inventory_transactions dw_inventory_transactions
st_trans st_trans
ddlb_trans_list ddlb_trans_list
end type
type tabpage_query from userobject within tab_1
end type
type dw_query from datawindow within tabpage_query
end type
type tabpage_query from userobject within tab_1
dw_query dw_query
end type
type tabpage_forms from userobject within tab_1
end type
type lv_1 from listview within tabpage_forms
end type
type st_1 from statictext within tabpage_forms
end type
type cb_4 from commandbutton within tabpage_forms
end type
type cb_3 from commandbutton within tabpage_forms
end type
type cb_2 from commandbutton within tabpage_forms
end type
type tabpage_forms from userobject within tab_1
lv_1 lv_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
end type
type tabpage_cop from userobject within tab_1
end type
type dw_cop from datawindow within tabpage_cop
end type
type tabpage_cop from userobject within tab_1
dw_cop dw_cop
end type
type tab_1 from tab within w_parameters
tabpage_company tabpage_company
tabpage_general tabpage_general
tabpage_inventory tabpage_inventory
tabpage_query tabpage_query
tabpage_forms tabpage_forms
tabpage_cop tabpage_cop
end type
end forward

global type w_parameters from w_sheet_4t
integer x = 214
integer y = 221
integer width = 3054
integer height = 1796
string title = "General Parameters"
string menuname = "m_parm_menu"
event ue_save ( )
event ue_exit ( )
tab_1 tab_1
end type
global w_parameters w_parameters

type variables
Boolean	ib_CompanyInfo, &
	ib_ShowProg, &
	ib_BegNumbers, &
	ib_Password
end variables

forward prototypes
public function boolean wf_check_valid_alt_part (string a_s_main_part, string a_s_alt_part)
public subroutine wf_01_getcolumn (long arg_selectionno)
public subroutine wf_02_resetall ()
end prototypes

event ue_save;tab_1.TRIGGER EVENT ue_save ( )
end event

event ue_exit;Close ( This )
end event

public function boolean wf_check_valid_alt_part (string a_s_main_part, string a_s_alt_part);int		li_sqlca_code,&
			li_count1,&
			li_count2
string	ls_code


// Check package types
SELECT count(part_packaging.part)  
  INTO :li_count1
  FROM part_packaging  
 WHERE part_packaging.part = :a_s_main_part   ;

SELECT count(part_packaging.part)  
  INTO :li_count2
  FROM part_packaging  
 WHERE part_packaging.part = :a_s_alt_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE comparison CURSOR FOR  
 SELECT part_packaging.code  
   FROM part_packaging  
  WHERE part_packaging.part = :a_s_main_part  ;

Open comparison ;
Fetch comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_packaging.part)
     INTO :li_count1  
     FROM part_packaging  
    WHERE ( part_packaging.part = :a_s_alt_part ) AND  
          ( part_packaging.code = :ls_code )   ;

	if li_count1 < 1 then
		sqlca.sqlcode = -1
	end if

	li_sqlca_code = sqlca.sqlcode

	Fetch comparison into :ls_code;

Loop
Close comparison ;

if li_sqlca_code = -1 then
	return FALSE
end if

SELECT count(part_unit_conversion.part)  
  INTO :li_count1
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :a_s_main_part   ;

SELECT count(part_unit_conversion.part)  
  INTO :li_count2
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :a_s_alt_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE unit_comparison CURSOR FOR  
 SELECT part_unit_conversion.code  
   FROM part_unit_conversion  
  WHERE part_unit_conversion.part = :a_s_main_part  ;

Open unit_comparison ;
Fetch unit_comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_unit_conversion.part)
     INTO :li_count1  
     FROM part_unit_conversion  
    WHERE ( part_unit_conversion.part = :a_s_alt_part ) AND  
          ( part_unit_conversion.code = :ls_code )   ;

	if li_count1 < 1 then
		sqlca.sqlcode = -1
	end if

	li_sqlca_code = sqlca.sqlcode

	Fetch unit_comparison into :ls_code;

Loop
Close unit_comparison ;

if li_sqlca_code = -1 then
	return FALSE
else
	return TRUE
end if

end function

public subroutine wf_01_getcolumn (long arg_selectionno);Choose Case arg_selectionno
//	Case 1   // Time interval & show program name
//		   // heading 
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval_t.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval_t.Y='8'")
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval_t.visible='1'")			
//			// column 
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval.Y='108'")
//			tab_1.tabpage_general.dw_parm_general.Modify("time_interval.visible='1'")
//			
//		   // heading
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name_t.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name_t.Y='216'")
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name_t.visible='1'")
//		   // column 
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name.Y='312'")
//			tab_1.tabpage_general.dw_parm_general.Modify("show_program_name.visible='1'")
//			
	Case 2 // GL account
			// heading 
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account_t.Y='8'")
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account.Y='108'")
			tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account.visible='1'")
			
			// heading 
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account_t.Y='216'")
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account.Y='312'")
			tab_1.tabpage_general.dw_parm_general.Modify("freight_account.visible='1'")
			
	Case 3 // order type & minicop
		   // heading 
			tab_1.tabpage_general.dw_parm_general.Modify("order_type_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("order_type_t.Y='8'")
			tab_1.tabpage_general.dw_parm_general.Modify("order_type_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("order_type.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("order_type.Y='108'")
			tab_1.tabpage_general.dw_parm_general.Modify("order_type.visible='1'")
			
			// heading
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop_t.Y='216'")
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop_t.visible='1'")			
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop.Y='312'")
			tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop.visible='1'")			
			
	Case 4 // invoice column, suffix required & package type
		   // heading
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col_t.Y='8'")
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col.Y='108'")
			tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col.visible='1'")
			
			// heading
  		   tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type_t.Y='456'")
			tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type_t.visible='1'")

			// column 
  		   tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type.Y='528'")
			tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type.visible='1'")
			
	Case 5 // Shop floor data
		   // heading 
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required_t.Y='8'")
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required.Y='108'")
			tab_1.tabpage_general.dw_parm_general.Modify("plant_required.visible='1'")
			
//	Case 6 // dimensional data required or not 
//		   // heading 
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required_t.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required_t.Y='8'")
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required_t.visible='1'")
//			// column 
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required.X='19'")
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required.Y='108'")
//			tab_1.tabpage_general.dw_parm_general.Modify("dda_required.visible='1'")
//			
////			// heading 
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type_t.X='19'")
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type_t.Y='216'")
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type_t.visible='1'")
////			// column 
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type.X='19'")
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type.Y='312'")
////			tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type.visible='1'")
//
	Case 7 // receiving dock switches
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required_t.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required_t.Y='8'")
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required_t.visible='1'")
			// column 
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required.X='19'")
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required.Y='108'")
			tab_1.tabpage_general.dw_parm_general.Modify("shipper_required.visible='1'")
	 
End choose

end subroutine

public subroutine wf_02_resetall ();tab_1.tabpage_general.dw_parm_general.Modify("time_interval.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("show_program_name.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("freight_account.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("order_type.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("dda_required.visible='0'")
//tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("plant_required_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("shipper_required_t.visible='0'")

tab_1.tabpage_general.dw_parm_general.Modify("time_interval_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("show_program_name_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("sales_tax_account_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("freight_account_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("order_type_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("ask_for_minicop_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("inv_reg_col_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("pallet_package_type_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("dda_required_t.visible='0'")
//tab_1.tabpage_general.dw_parm_general.Modify("dda_formula_type_t.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("plant_required.visible='0'")
tab_1.tabpage_general.dw_parm_general.Modify("shipper_required.visible='0'")
end subroutine

on w_parameters.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_parm_menu" then this.MenuID = create m_parm_menu
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_parameters.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event resize;tab_1.Resize ( Width - 60, Height - 50 )
end event

event pfc_postopen;call super::pfc_postopen;
//	Validate administrative password.
integer returnValue 
Open(w_password)
returnValue = Message.DoubleParm
if	returnValue <> SUCCESS then
	post event ue_exit ( )
end if

end event

type tab_1 from tab within w_parameters
event ue_save ( )
integer x = 32
integer y = 16
integer width = 2862
integer height = 1516
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean multiline = true
integer selectedtab = 1
tabpage_company tabpage_company
tabpage_general tabpage_general
tabpage_inventory tabpage_inventory
tabpage_query tabpage_query
tabpage_forms tabpage_forms
tabpage_cop tabpage_cop
end type

event ue_save();tab_1.TabTriggerEvent ( "ue_save" )
commit;
end event

event selectionchanged;Control [ newindex ].PostEvent ( 'ue_get_focus' )
end event

on tab_1.create
this.tabpage_company=create tabpage_company
this.tabpage_general=create tabpage_general
this.tabpage_inventory=create tabpage_inventory
this.tabpage_query=create tabpage_query
this.tabpage_forms=create tabpage_forms
this.tabpage_cop=create tabpage_cop
this.Control[]={this.tabpage_company,&
this.tabpage_general,&
this.tabpage_inventory,&
this.tabpage_query,&
this.tabpage_forms,&
this.tabpage_cop}
end on

on tab_1.destroy
destroy(this.tabpage_company)
destroy(this.tabpage_general)
destroy(this.tabpage_inventory)
destroy(this.tabpage_query)
destroy(this.tabpage_forms)
destroy(this.tabpage_cop)
end on

type tabpage_company from userobject within tab_1
event ue_get_focus pbm_custom01
event ue_save pbm_custom02
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "Company"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_company dw_company
end type

event ue_get_focus;IF dw_company.RowCount ( ) = 0 THEN
	dw_company.Retrieve ( )
END IF
end event

event ue_save;dw_company.AcceptText ( )
IF dw_company.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_company.Update (true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to save Company Information!' )
	END IF
END IF
end event

on tabpage_company.create
this.dw_company=create dw_company
this.Control[]={this.dw_company}
end on

on tabpage_company.destroy
destroy(this.dw_company)
end on

type dw_company from datawindow within tabpage_company
integer y = 24
integer width = 2816
integer height = 1272
integer taborder = 11
string dataobject = "d_parameters"
boolean border = false
boolean livescroll = true
end type

event clicked;STRING	ls_file_name, &
			ls_dummy

IF dwo.Name = 'company_logo' THEN
	GetFileOpenName ( 'Locate Company Logo', ls_file_name, ls_dummy, 'bmp', 'Bitmap Files ( *.bmp),*.bmp' )
	IF ls_file_name > '' THEN
		SetItem ( 1, 'company_logo', ls_file_name )
	END IF
END IF
end event

event constructor;SetTransObject ( SQLCA )
end event

type tabpage_general from userobject within tab_1
event ue_get_focus pbm_custom01
event create ( )
event destroy ( )
event ue_save pbm_custom02
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "General"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_parm_general dw_parm_general
sle_1 sle_1
dw_beginning_numbers dw_beginning_numbers
gb_3 gb_3
tv_1 tv_1
gb_4 gb_4
end type

event ue_get_focus;IF dw_parm_general.RowCount ( ) = 0 THEN
	dw_parm_general.Retrieve ( ) 
	dw_beginning_numbers.Retrieve ( )
END IF
	
end event

on tabpage_general.create
this.dw_parm_general=create dw_parm_general
this.sle_1=create sle_1
this.dw_beginning_numbers=create dw_beginning_numbers
this.gb_3=create gb_3
this.tv_1=create tv_1
this.gb_4=create gb_4
this.Control[]={this.dw_parm_general,&
this.sle_1,&
this.dw_beginning_numbers,&
this.gb_3,&
this.tv_1,&
this.gb_4}
end on

on tabpage_general.destroy
destroy(this.dw_parm_general)
destroy(this.sle_1)
destroy(this.dw_beginning_numbers)
destroy(this.gb_3)
destroy(this.tv_1)
destroy(this.gb_4)
end on

event ue_save;IF dw_parm_general.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_parm_general.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to Save General Information!' )
	END IF
END IF

IF dw_beginning_numbers.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_beginning_numbers.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to Save Beginning Numbers!' )
	END IF
END IF
end event

event constructor;dw_parm_general.settransobject(sqlca)
end event

type dw_parm_general from datawindow within tabpage_general
integer x = 14
integer y = 568
integer width = 1883
integer height = 720
integer taborder = 14
string dataobject = "d_parm_general"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type sle_1 from singlelineedit within tabpage_general
event modified pbm_enmodified
integer x = 1221
integer y = 848
integer width = 512
integer height = 96
integer taborder = 13
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
boolean autohscroll = false
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

on modified;ib_Password = TRUE
end on

type dw_beginning_numbers from datawindow within tabpage_general
event editchanged pbm_dwnchanging
event itemchanged pbm_dwnitemchange
event itemerror pbm_dwnitemvalidationerror
integer x = 1938
integer y = 136
integer width = 850
integer height = 768
integer taborder = 12
string dataobject = "d_next_numbers"
boolean border = false
boolean livescroll = true
end type

on editchanged;ib_BegNumbers = TRUE
end on

on itemchanged;ib_BegNumbers = TRUE
end on

event constructor;SetTransObject ( SQLCA )
end event

type gb_3 from groupbox within tabpage_general
integer x = 1166
integer y = 720
integer width = 640
integer height = 320
integer taborder = 13
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Admin Password:"
end type

type tv_1 from treeview within tabpage_general
integer x = 14
integer y = 108
integer width = 1883
integer height = 464
integer taborder = 34
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Custom039!","Custom039!","Custom039!","Custom039!","Custom039!","Custom039!","Custom039!"}
long picturemaskcolor = 16776960
long statepicturemaskcolor = 536870912
end type

event constructor;long  ll_lev1, ll_lev2 ,ll_lev3 ,ll_lev4, ll_lev5, ll_lev6, ll_lev7
long  ll_tvi

//ll_lev1 = InsertItemFirst(0,"Screen Information",1)
ll_lev2 = InsertItemLast(0,"GL Account Information",2)
ll_lev3 = InsertItemLast(0,"Sales Order Information", 3)
ll_lev4 = InsertItemLast(0,"Shipping Information", 4)
ll_lev5 = InsertItemLast(0,"Shop Floor Information", 5)
//ll_lev6 = InsertItemLast(0,"Dimensional Data Information", 6)
ll_lev7 = InsertItemLast(0,"Receiving Dock Information",7)

ll_tvi  = tv_1.FindItem(RootTreeItem! , 0)
tv_1.ExpandAll(ll_tvi)

end event

event clicked;treeviewitem 	l_tvinew
Long 			 	ll_tvi,ll_selectionno
String 			ls_currentlabel
ll_tvi = tv_1.FindItem(CurrentTreeItem! , 0)
tv_1.GetItem(ll_tvi, l_tvinew)
ls_currentlabel=''
ls_currentlabel = string(l_tvinew.label)
ll_selectionno = 0
wf_02_resetall()
Choose Case ls_currentlabel
//	Case "Screen Information"
//			ll_selectionno = 1		
	Case "GL Account Information"
		   ll_selectionno = 2				
	Case "Sales Order Information"
		   ll_selectionno = 3				
	Case "Shipping Information"
		   ll_selectionno = 4				
	Case "Shop Floor Information"	
		   ll_selectionno = 5			
//	Case "Dimensional Data Information"	
//		   ll_selectionno = 6				
	Case "Receiving Dock Information"
			ll_selectionno = 7
End Choose		
wf_01_getcolumn(ll_selectionno)

end event

type gb_4 from groupbox within tabpage_general
integer x = 1929
integer y = 80
integer width = 869
integer height = 844
integer taborder = 12
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Beginning Numbers:"
end type

type tabpage_inventory from userobject within tab_1
event ue_get_focus pbm_custom01
event ue_limit_location pbm_custom02
event ue_save pbm_custom03
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "Inventory Control"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_inventory dw_inventory
cb_1 cb_1
dw_inventory_transactions dw_inventory_transactions
st_trans st_trans
ddlb_trans_list ddlb_trans_list
end type

event ue_get_focus;IF dw_inventory.RowCount ( ) = 0 THEN
	dw_inventory.Retrieve ( )
	dw_inventory_transactions.Retrieve ( )
END IF
end event

event ue_limit_location;OpenWithParm ( w_inventory_location_list, LeftA ( ddlb_trans_list.Text, 1 ) )
end event

event ue_save;IF dw_inventory.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_inventory.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to Save Inventory Information!' )
	END IF
END IF
IF dw_inventory_transactions.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_inventory_transactions.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to Save Inventory Transactions Information!' )
	END IF
END IF
end event

on tabpage_inventory.create
this.dw_inventory=create dw_inventory
this.cb_1=create cb_1
this.dw_inventory_transactions=create dw_inventory_transactions
this.st_trans=create st_trans
this.ddlb_trans_list=create ddlb_trans_list
this.Control[]={this.dw_inventory,&
this.cb_1,&
this.dw_inventory_transactions,&
this.st_trans,&
this.ddlb_trans_list}
end on

on tabpage_inventory.destroy
destroy(this.dw_inventory)
destroy(this.cb_1)
destroy(this.dw_inventory_transactions)
destroy(this.st_trans)
destroy(this.ddlb_trans_list)
end on

type dw_inventory from datawindow within tabpage_inventory
event editchanged pbm_dwnchanging
event itemchanged pbm_dwnitemchange
integer y = 12
integer width = 2811
integer height = 684
integer taborder = 12
string dataobject = "d_parameters_inventory_control"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( SQLCA )
end event

type cb_1 from commandbutton within tabpage_inventory
event clicked pbm_bnclicked
boolean visible = false
integer x = 1477
integer y = 700
integer width = 311
integer height = 84
integer taborder = 14
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limit Locs"
end type

event clicked;Parent.TriggerEvent ( "ue_limit_location" )
end event

type dw_inventory_transactions from datawindow within tabpage_inventory
event itemchanged pbm_dwnitemchange
integer x = 5
integer y = 796
integer width = 2811
integer height = 432
integer taborder = 3
string dataobject = "d_gray_background"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( SQLCA )
end event

type st_trans from statictext within tabpage_inventory
integer x = 119
integer y = 704
integer width = 603
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Inventory Transactions:"
boolean focusrectangle = false
end type

type ddlb_trans_list from dropdownlistbox within tabpage_inventory
event selectionchanged pbm_cbnselchange
integer x = 727
integer y = 696
integer width = 672
integer height = 536
integer taborder = 14
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Job Completion","Material Issue","Break Out","Transfer"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;If ddlb_trans_list.Text = "Transfer" Then
	cb_1.Show ( )
	dw_inventory_transactions.DataObject = "d_gray_background"
Else
	If ddlb_trans_list.Text = "Job Completion" Then
		dw_inventory_transactions.DataObject = "d_inventory_parms_jc"
		cb_1.Show ( )
	Elseif ddlb_trans_list.Text = "Material Issue" Then
		dw_inventory_transactions.DataObject = "d_inventory_parms_mi"
		cb_1.Show ( )
	Elseif ddlb_trans_list.Text = "Break Out" Then
		dw_inventory_transactions.DataObject = "d_inventory_parms_bo"
		cb_1.Hide ( )
	End if

	dw_inventory_transactions.SetTransObject ( sqlca )
	If dw_inventory_transactions.Retrieve ( ) < 1 Then

	  INSERT INTO inventory_parameters  
		         ( record_number,   
		           machine_number,   
		           jc_machine,   
		           jc_part,   
		           jc_packaging,   
		           jc_location_to,   
		           jc_operator,   
		           jc_number_of,   
		           jc_qty,   
		           jc_unit,   
		           mi_machine,   
		           mi_operator,   
		           mi_serial,   
		           mi_qty,   
		           mi_unit,   
		           bo_operator,   
		           bo_serial,   
		           bo_number_of,   
		           bo_qty,   
		           bo_unit,   
		           jc_allow_zero_qty,   
		           jc_parts_mode,   
		           limit_locations,   
		           jc_material_lot )  
		  VALUES ( 1,   
		           '0',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'N',   
		           'N',   
		           'N',   
		           'R' )  ;
	
		If SQLCA.SQLCode <> 0 Then
			RollBack ;
		Else
			Commit ;
		End if
	
	End if

End if


end event

type tabpage_query from userobject within tab_1
event ue_get_focus pbm_custom01
event create ( )
event destroy ( )
event ue_save pbm_custom02
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "Query Engine"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_query dw_query
end type

event ue_get_focus;IF dw_query.RowCount ( ) = 0 THEN
	dw_query.Retrieve ( )
END IF
end event

on tabpage_query.create
this.dw_query=create dw_query
this.Control[]={this.dw_query}
end on

on tabpage_query.destroy
destroy(this.dw_query)
end on

event ue_save;IF dw_query.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_query.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title, 'Unable to Save Query Information!' )
	END IF
END IF
end event

type dw_query from datawindow within tabpage_query
event itemchanged pbm_dwnitemchange
integer y = 20
integer width = 2825
integer height = 1264
integer taborder = 11
string dataobject = "d_query_engine_setup"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( SQLCA )
end event

type tabpage_forms from userobject within tab_1
event ue_get_focus pbm_custom01
event ue_save pbm_custom02
event ue_resize pbm_size
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "Printable Forms"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
lv_1 lv_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
end type

event ue_get_focus;BOOLEAN	l_b_first, &
			l_b_forms, &
			l_b_labels
			
u_nvo_report_upgrade	l_u_nvo_check_upgrade

l_u_nvo_check_upgrade = CREATE u_nvo_report_upgrade

l_b_first = l_u_nvo_check_upgrade.uof_get_first ( )
l_b_forms = l_u_nvo_check_upgrade.uof_get_forms ( )
l_b_labels = l_u_nvo_check_upgrade.uof_get_labels ( )

DESTROY u_nvo_report_upgrade

// check if the report list table has label and report entries in it..

IF l_b_first THEN
	INSERT INTO report_list values ( 'Report', 'Report' ) ;	
	INSERT INTO report_list values ( 'Label', 'Label' ) ;

	IF SQLCA.SQLCODE = 0 THEN
		COMMIT;
		l_b_first = FALSE
	ELSE
		ROLLBACK ;
		messagebox ( monsys.msg_Title, 'Unable to insert rows to Report List table!' )
	END IF
	Return
END IF

// if forms and label_library tables are missing then do not popup the wizard..

IF NOT l_b_forms AND NOT l_b_labels AND NOT l_b_first THEN
	lv_1.triggerevent ( 'ue_build' )
	Return
ELSE
	lv_1.triggerevent ( 'ue_build' )
	Open ( w_upgrade_forms_labels )
END IF




end event

event ue_resize;lv_1.height = tabpage_forms.height * 0.70
cb_2.y	= lv_1.height + 100
cb_3.y	= cb_2.y
cb_4.y	= cb_2.y

end event

on tabpage_forms.create
this.lv_1=create lv_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.Control[]={this.lv_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2}
end on

on tabpage_forms.destroy
destroy(this.lv_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
end on

type lv_1 from listview within tabpage_forms
event ue_build pbm_custom01
integer x = 14
integer y = 80
integer width = 2798
integer height = 1076
integer taborder = 35
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
grsorttype sorttype = ascending!
listviewview view = listviewreport!
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 553648127
string smallpicturename[] = {"DataWindow5!","RunWindow!","DataWindow!"}
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event ue_build;datastore l_ds_report

Integer l_i_type, &
        l_i_Row_count, &
		  l_i_count	  

// routine to populate the list view
l_ds_report = CREATE datastore

l_ds_report.DataObject = 'dw_print_reports_parameters'
l_ds_report.SetTransObject(SQLCA)
l_ds_report.reset()
l_i_count = l_ds_report.Retrieve()
lv_1.deleteitems() 

for l_i_row_count = 1 to l_ds_report.rowcount() 
	if l_ds_report.object.#2[l_i_row_count] = 'C' then
		l_i_type = 1
	elseif l_ds_report.object.#2[l_i_row_count] = 'W' then
		l_i_type = 2
	elseif l_ds_report.object.#2[l_i_row_count] = 'D' then
		l_i_type = 3 
	end if
	
	lv_1.AddItem ( isnull( trim(l_ds_report.object.#1[l_i_row_count]), ' ' ) + '~t' + &
			isnull( trim(l_ds_report.object.#2[l_i_row_count]), ' ' ) + '~t' + &
			isnull( trim(l_ds_report.object.#9[l_i_row_count]), ' ' ) + '~t' + &
			isnull( trim(l_ds_report.object.#3[l_i_row_count]), ' ' ) + '~t' + &
			isnull( trim(l_ds_report.object.#4[l_i_row_count]), ' ' )+ '~t' + &
			isnull( trim(l_ds_report.object.#5[l_i_row_count]), ' ' )+ '~t' + &
			isnull( trim(l_ds_report.object.#6[l_i_row_count]), ' ' )+ '~t' + &
			isnull( trim(l_ds_report.object.#7[l_i_row_count]), ' ' )+ '~t' + &
			isnull( string(l_ds_report.object.#8[l_i_row_count]), '0' ), l_i_type ) 
next
destroy l_ds_report

end event

event columnclick;Sort ( Ascending!, column )
end event

event constructor;this.AddColumn ( 'Name', Left!, 681 )
this.AddColumn ( 'Type', Left!, 92 )
this.Addcolumn ( 'Report', Left!, 681 )
this.AddColumn ( 'Code Name', Left!, 558 )
this.AddColumn ( 'Library Name', Left!, 737 )
this.AddColumn ( 'Preview', Left!, 92 )
this.AddColumn ( 'Print Setup', Left!, 92 )
this.Addcolumn ( 'Printer', Left!, 300 )
this.AddColumn ( 'Copies', Right!, 247 )
end event

event doubleclicked;st_generic_structure l_str_generic_structure	

lv_1.getitem( lv_1.SelectedIndex ( ), 1, l_str_generic_structure.value1 )
lv_1.getitem( lv_1.SelectedIndex ( ), 3, l_str_generic_structure.value2 )
l_str_generic_structure.value3	= 'E' //exisiting record

IF index > 0 THEN
	openwithparm ( w_report_properties, l_str_generic_structure )
	triggerevent ( 'ue_build' )
END IF
end event

type st_1 from statictext within tabpage_forms
integer x = 14
integer y = 4
integer width = 517
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "&Installed Reports:"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within tabpage_forms
integer x = 448
integer y = 1176
integer width = 366
integer height = 80
integer taborder = 6
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Remove"
end type

event clicked;String 	l_s_name, &
			l_s_report

Integer  l_i_rtncode

lv_1.getitem( lv_1.SelectedIndex ( ), 1, l_s_name  )
lv_1.getitem( lv_1.SelectedIndex ( ), 3, l_s_report )  

IF lv_1.SelectedIndex ( ) > 0 THEN
	
	l_i_rtncode = MessageBox(monsys.msg_title, 'Are you sure you want to delete ' + TRIM ( l_s_name ) + ' ?', question!, YesNo! , 2)

	IF l_i_rtncode = 1 THEN
	
   	DELETE FROM report_library 
		WHERE name = :l_s_name and
		       report = :l_s_report ;
			 
		IF SQLCA.SQLCODE = 0 THEN

				COMMIT ;					
				lv_1.deleteitem ( lv_1.selectedIndex () )

		ELSE			
			   ROLLBACK ;
				messagebox ( monsys.msg_title, sqlca.sqlerrtext )

		END IF

	END IF
	
END IF
end event

type cb_3 from commandbutton within tabpage_forms
integer x = 9
integer y = 1176
integer width = 366
integer height = 80
integer taborder = 5
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Add"
end type

event clicked;st_generic_structure l_str_generic_structure

l_str_generic_structure.value3 = 'N'

OpenWithParm ( w_report_properties , l_str_generic_structure )
lv_1.triggerevent ( 'ue_build' )
end event

type cb_2 from commandbutton within tabpage_forms
integer x = 887
integer y = 1176
integer width = 366
integer height = 80
integer taborder = 4
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Properties"
end type

event clicked;st_generic_structure l_str_generic_structure	

lv_1.getitem( lv_1.SelectedIndex ( ), 1, l_str_generic_structure.value1 )
lv_1.getitem( lv_1.SelectedIndex ( ), 3, l_str_generic_structure.value2 )
l_str_generic_structure.value3	= 'E' //exisiting record

IF lv_1.SelectedIndex ( ) > 0 THEN	
	Openwithparm ( w_report_properties, l_str_generic_structure )
	lv_1.triggerevent ( 'ue_build' )

END IF
end event

type tabpage_cop from userobject within tab_1
event ue_get_focus pbm_custom01
event ue_save pbm_custom02
integer x = 18
integer y = 100
integer width = 2825
integer height = 1400
long backcolor = 78682240
string text = "Continuous Operations Planning (COP)"
long tabtextcolor = 37234728
long tabbackcolor = 78682240
long picturemaskcolor = 536870912
dw_cop dw_cop
end type

event ue_get_focus;IF dw_cop.RowCount ( ) = 0 THEN
	dw_cop.Retrieve ( )
END IF
end event

event ue_save;IF dw_cop.GetNextModified ( 0, PRIMARY! ) <> 0 THEN
	IF dw_cop.Update(true) = -1 THEN
		MessageBox ( monsys.msg_title , 'Unable to Save COP parameters!' )
	END IF
END IF

end event

on tabpage_cop.create
this.dw_cop=create dw_cop
this.Control[]={this.dw_cop}
end on

on tabpage_cop.destroy
destroy(this.dw_cop)
end on

type dw_cop from datawindow within tabpage_cop
event itemchanged pbm_dwnitemchange
integer x = 5
integer y = 20
integer width = 2802
integer height = 1260
integer taborder = 34
string dataobject = "d_add_parms_cop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject ( SQLCA )
end event

