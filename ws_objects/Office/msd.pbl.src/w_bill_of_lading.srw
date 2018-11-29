$PBExportHeader$w_bill_of_lading.srw
$PBExportComments$Process bill of lading
forward
global type w_bill_of_lading from window
end type
type dw_pool_codes from datawindow within w_bill_of_lading
end type
type st_right_arrow from statictext within w_bill_of_lading
end type
type st_left_arrow from statictext within w_bill_of_lading
end type
type st_5 from statictext within w_bill_of_lading
end type
type st_4 from statictext within w_bill_of_lading
end type
type p_4 from picture within w_bill_of_lading
end type
type dw_bol_form from datawindow within w_bill_of_lading
end type
type st_3 from statictext within w_bill_of_lading
end type
type st_2 from statictext within w_bill_of_lading
end type
type st_1 from statictext within w_bill_of_lading
end type
type p_3 from picture within w_bill_of_lading
end type
type p_2 from picture within w_bill_of_lading
end type
type p_1 from picture within w_bill_of_lading
end type
type dw_shipper_pool from datawindow within w_bill_of_lading
end type
type dw_shippers_with_no_bol from datawindow within w_bill_of_lading
end type
type dw_shippers_bol from datawindow within w_bill_of_lading
end type
type dw_bol_list from datawindow within w_bill_of_lading
end type
type gb_4 from groupbox within w_bill_of_lading
end type
type gb_3 from groupbox within w_bill_of_lading
end type
type gb_1 from groupbox within w_bill_of_lading
end type
type lb_1 from listbox within w_bill_of_lading
end type
type dw_bol_header from datawindow within w_bill_of_lading
end type
type gb_2 from groupbox within w_bill_of_lading
end type
end forward

global type w_bill_of_lading from window
integer width = 2930
integer height = 2108
boolean titlebar = true
string title = "Bill of Lading Control Center"
string menuname = "m_bill_of_lading"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 78160032
event exit_bol pbm_custom01
event save_bol pbm_custom02
event print_bol pbm_custom03
event ue_print_update pbm_custom04
event ue_unapproved_message ( )
dw_pool_codes dw_pool_codes
st_right_arrow st_right_arrow
st_left_arrow st_left_arrow
st_5 st_5
st_4 st_4
p_4 p_4
dw_bol_form dw_bol_form
st_3 st_3
st_2 st_2
st_1 st_1
p_3 p_3
p_2 p_2
p_1 p_1
dw_shipper_pool dw_shipper_pool
dw_shippers_with_no_bol dw_shippers_with_no_bol
dw_shippers_bol dw_shippers_bol
dw_bol_list dw_bol_list
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
lb_1 lb_1
dw_bol_header dw_bol_header
gb_2 gb_2
end type
global w_bill_of_lading w_bill_of_lading

type variables
Long iShipper                     //Current shipper number
Long iBOL                          //Current bill of lading #
Long iNewBOL                    //New bill of lading #
Long iShipperRow               //Current shipper row#
Long iShipperBOLRow         //Current shipper bol # 
Long iBOLRow                    //Current BOL row
String szPoolDestination       //Pool Destination
String szDestination             //Destination
String szTransMode             //Transportation Mode
String szScac                      //Scac code
String i_s_dest
String i_s_cust
string	is_status
datawindowchild i_dwc_childdw
Boolean bDragShipper
Boolean bDragShipperBOL
Boolean bbolchanged = False
Decimal nGrossWeight
Integer  iTotalBoxes
Integer  iTotalPallets
Integer  i_i_totalshippers_onbol
datetime	idt_datestamp
string	is_destarray[], is_desttemp[]
end variables

forward prototypes
public subroutine wf_generate_bol ()
public subroutine wf_calc_box_and_weight ()
public function integer wf_check_if_valid (long al_bol, long al_shipper)
public subroutine wf_link_shippers (string as_pooldestination)
public function boolean wf_need_pool (long al_shipper)
public function boolean wf_new_bol (long al_shipper)
public subroutine wf_set_bol (long al_shipper, long al_bol)
public subroutine wf_get_scac_transmode (long al_shipper)
public subroutine wf_create_bol_header (long al_bol, string as_destination)
public subroutine wf_set_print_flag (string as_flag)
public subroutine wf_getdestlist ()
end prototypes

on exit_bol;w_list_of_active_shippers.wf_refresh()

If w_shipping_mdi_screen.MenuName <> "m_list_of_shippers" Then &
	w_shipping_mdi_screen.ChangeMenu ( m_list_of_shippers )

close(w_bill_of_lading)
end on

event save_bol;Long iRow
Long l_shipper_row
If dw_bol_header.RowCount() > 0 then
	If dw_bol_header.Update() > 0 then
		Commit;
		dw_bol_list.Retrieve()
		For iRow = 1 to dw_shippers_bol.RowCount()
			dw_shippers_bol.SetItem(iRow, "trans_mode", &
			dw_bol_header.GetItemString(1, "trans_mode"))
		Next
	Else
		Rollback;
	End If
End If				
If dw_shippers_bol.Update() > 0 then
	Commit;
	dw_shippers_with_no_bol.Retrieve()
Else
	Rollback;
End If

end event

event print_bol;Long l_l_Shipper
Long l_l_Row
Long l_l_Job
Boolean l_b_Ok
Boolean l_b_Staged
Boolean l_b_Printed
String  szFormName
String  szDataWindowName
st_print_preview_generic l_st_Parm
l_st_Parm.document_number = iBOL
l_st_Parm.form_type	= 'Bill of Lading'
l_l_Row		= 1
l_b_Ok		= TRUE
l_b_Staged	= TRUE
l_b_Printed	= TRUE

Do While l_b_Ok AND (l_l_Row  <= dw_shippers_bol.RowCount())
	If dw_shippers_bol.GetItemString(l_l_Row, "status") <> "S" then
		l_b_Ok		= FALSE
		l_b_Staged	= FALSE			
	Else
		If dw_shippers_bol.GetItemString(l_l_Row, "printed") <> "Y" then
			l_b_Ok	= FALSE
			l_b_Printed	= FALSE
		End If
	End If
	l_l_Shipper	= dw_shippers_bol.GetItemNumber(l_l_Row, "id")
	l_l_Row ++
Loop
If Not l_b_Ok then
	If Not l_b_Printed then
		MessageBox(monsys.msg_title, "Shipper # " + String(l_l_Shipper) + " has not " + &
					  "been printed.", StopSign!)
	Else
 		MessageBox(monsys.msg_title, "Shipper # " + String(l_l_Shipper) + " has not " + &
					  "been staged.", StopSign!)	
	End If
Else
	wf_calc_box_and_weight()			//Calc total pallets, boxes and weight
//	OpenWithParm(w_preview_bol, iBOL)
	OpenSheetWithParm ( w_form_print_preview, l_st_Parm, gnv_App.of_GetFrame(), 3, Original! )
End If

end event

event ue_print_update;wf_set_print_flag ( 'Y' )
MessageBox(monsys.msg_title, "Bill of lading has been printed.")  
end event

event ue_unapproved_message;MessageBox ( "Bill of Lading", "This destination's status is " + is_status + ".  You will be able to do everything except physically ship out the order.", Information! )

end event

public subroutine wf_generate_bol ();Long	 iRow
String szCurrentDest

Timer(0)												
wf_set_bol(iShipper, iBOL)					//Assign the BOL# to shipper number
If wf_need_pool(iShipper) then
	szCurrentDest	= szPoolDestination
	wf_link_shippers(szPoolDestination)	//Link all related shippers
Else
	szCurrentDest	= szDestination	
	wf_set_bol(iShipper, iNewBOL)
End If

iBOL		= iNewBOL
wf_create_bol_header(iNEWBOL, szCurrentDest)		//Create BOL header info
dw_shippers_bol.Retrieve(iNewBOL)			//Retrieve all shippers for BOL#
dw_bol_list.Retrieve()

iRow		= dw_bol_list.Find("bol_number = " + String(iBOL) , 1 , 9999999)
If iRow	> 0 then
	iBOLRow = iRow
	dw_bol_list.ScrollToRow(iRow)
	dw_bol_list.SelectRow(0, FALSE)
	dw_bol_list.SelectRow(iRow, TRUE)
	dw_bol_header.Retrieve(iNewBOL)
	dw_shippers_bol.Retrieve(iNewBOL)
	// inc by gph on 6/19/98 at 3.03 pm, the below 2 lines 
	i_i_totalshippers_onbol=dw_shippers_bol.rowcount()	
	i_s_dest = dw_bol_list.Getitemstring(irow,"destination")
else
	i_s_dest = szCurrentDest
End If
iBOL	= iNewBOL

		
end subroutine

public subroutine wf_calc_box_and_weight ();  SELECT sum(shipper.gross_weight ),   
         sum(shipper.staged_objs )  
    INTO :nGrossWeight,   
         :iTotalBoxes  
    FROM shipper  
   WHERE shipper.bill_of_lading_number = :iBol   ;

  SELECT count(object.serial )  
    INTO :iTotalPallets  
    FROM shipper,   
         object  
   WHERE ( shipper.id = object.shipper ) and  
         ( ( shipper.bill_of_lading_number = :iBol ) )   ;

  UPDATE bill_of_lading  
     SET gross_weight 		= :nGrossWeight,   
         total_boxes 		= :iTotalBoxes,   
         lading_quantity 	= :iTotalPallets  
   WHERE bol_number = :iBOL   ;


If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If


end subroutine

public function integer wf_check_if_valid (long al_bol, long al_shipper);string	ls_bol_dest,&
			ls_bol_pool,&
			ls_ship_dest,&
			ls_ship_pool,&
			ls_dontneed
int		li_return = 1

//sqlca.of_get_bol_dest_pool_and_type ( al_bol, ls_bol_dest, ls_bol_pool, ls_dontneed )
//sqlca.of_get_ship_dest_pool_and_type ( al_shipper, ls_ship_dest, ls_ship_pool, ls_dontneed )

// if same destination, ok
if ls_bol_dest = ls_ship_dest then
	li_return = 0
// if shipper.destination's pool code matches the bol.destination, ok
elseif ls_bol_dest = ls_ship_pool then
	li_return = 0
end if
// otherwise, denied

return li_return
end function

public subroutine wf_link_shippers (string as_pooldestination);Long iRow
Long ll_shipper
datetime ldt_datestamp
string	ls_type
string	ls_scac

dw_shipper_pool.Retrieve(as_pooldestination)

For iRow = 1 to dw_shipper_pool.RowCount()
	ll_shipper = dw_shipper_pool.GetItemNumber(iRow, "shipper_id")
	ldt_datestamp = dw_shipper_pool.object.shipper_date_stamp[irow]
	ls_type = dw_shipper_pool.object.shipper_type[irow]
	ls_scac = dw_shipper_pool.object.shipper_ship_via[irow]	
	If wf_new_bol(ll_shipper) and date(ldt_datestamp) = date(idt_datestamp) and &
		isnull(ls_type,'') <> 'R'  and ls_scac = szscac then
		wf_set_bol(ll_shipper, iNewBOL)
	End If
Next

end subroutine

public function boolean wf_need_pool (long al_shipper);String szPoolFlag				//Whether it needs Pool not not
Boolean bPool					//Flag
SELECT	destination  
INTO	:szDestination  
FROM	shipper  
WHERE	shipper.id = :al_Shipper;
If (szDestination > " ") then
	bPool	= TRUE
Else
	bPool	= FALSE
End If
If bPool then
	SELECT	edi_setups.pool_flag,   
		edi_setups.pool_code  
	INTO	:szPoolFlag,   
		:szPoolDestination
	FROM	edi_setups  
	WHERE	edi_setups.destination = :szDestination;
	If szPoolFlag	= "Y" then
		bPool	= TRUE
	Else
		bPool	= FALSE
	End If
End If
Return bPool

end function

public function boolean wf_new_bol (long al_shipper);SELECT	shipper.bill_of_lading_number  
INTO	:iBOL  
FROM	shipper  
WHERE	shipper.id = :al_Shipper;
If IsNull ( iBOL, 0 ) > 0 then
	Return FALSE
Else
	Return TRUE
End If

end function

public subroutine wf_set_bol (long al_shipper, long al_bol);UPDATE	shipper  
SET	bill_of_lading_number = :al_bOL  
WHERE	id = :al_Shipper;
If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If
end subroutine

public subroutine wf_get_scac_transmode (long al_shipper);SELECT	shipper.ship_via,   
	shipper.trans_mode,
	date_stamp
INTO	:szScac,   
	:szTransMode,
	:idt_datestamp
FROM	shipper  
WHERE	shipper.id = :al_Shipper;

end subroutine

public subroutine wf_create_bol_header (long al_bol, string as_destination);dw_bol_header.Reset()
dw_bol_header.InsertRow(1)
dw_bol_header.SetItem(1, "bol_number", al_Bol)
dw_bol_header.SetItem(1, "destination", as_Destination)
dw_bol_header.SetItem(1, "status", "O")
dw_bol_header.SetItem(1, "scac_transfer", szScac)
dw_bol_header.SetItem(1, "scac_pickup", szScac)
dw_bol_header.SetItem(1, "trans_mode", szTransMode)
If dw_bol_header.Update() > 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_set_print_flag (string as_flag);dw_bol_list.SetItem(iBOLRow, "printed", as_Flag)
If dw_bol_list.Update() > 0 then
	Commit;
Else
	Rollback;
End If
end subroutine

public subroutine wf_getdestlist ();int	li_idx=0
string	ls_dest
string	ls_cust
is_destarray = is_desttemp
DECLARE destlist CURSOR FOR
SELECT	distinct s.destination,
	d.customer
from	shipper s
	join destination d on d.destination = s.destination
where	s.bill_of_lading_number = :ibol;
open	destlist;
fetch	destlist into :ls_dest, :ls_cust;
do while sqlca.sqlcode = 0
	li_idx ++
//	is_destarray[li_idx] = ls_dest
	is_destarray[li_idx] = ls_cust	
	fetch	destlist into :ls_dest, :ls_cust;
loop
close	destlist;
if upperbound(is_destarray) = 0 then is_destarray[1] = i_s_cust

end subroutine

event open;//	Declarations
Long	iRow
String	l_s_cust
string	ls_type

//	Initialize dw
dw_bol_header.SetTransObject(sqlca)
dw_bol_list.SetTransObject(sqlca)
dw_shippers_bol.SetTransObject(sqlca)
dw_shipper_pool.SetTransObject(sqlca)
dw_shippers_with_no_bol.SetTransObject(sqlca)
dw_bol_form.SetTransObject(sqlca)

//	Get shipper from argument
iShipper = Message.DoubleParm

//	Get shipper details
wf_get_scac_transmode(iShipper)

//	Retrieve list of bols
dw_bol_list.Retrieve()

//	Modify dw properties
dw_shippers_with_no_bol.Modify("id.color='0~if(long(bill_of_lading_number) > 0, 255, 0)'")

//	Retrieve shippers with no bol
dw_shippers_with_no_bol.Retrieve()

//	Create a new bol if no. of shippers on bol is 0
i_i_totalshippers_onbol=0
If wf_new_BOL(iShipper) then		//Check and assign current # to iBOL
	iBOL	= 0
	bFinish	= FALSE
	if NOT sqlca.of_getnextparmvalue ( "bol_number", iNewBOL ) then
		rollback;
		return
	end if
	wf_generate_bol()
	wf_getdestlist()
	i_dwc_childdw.retrieve(is_destarray)	
Else
	//	if shipper exists on bol, retrieve the relevant info.
	iRow	= dw_bol_list.Find("bol_number = " + String(iBOL) , 1 , 9999999)	
	If iRow	> 0 then
		iBOLRow	= iRow
		iBOL	= dw_bol_list.GetItemNumber(iRow, "bol_number")
		dw_bol_list.ScrollToRow(iRow)
		dw_bol_list.SelectRow(0, FALSE)
		dw_bol_list.SelectRow(iRow, TRUE)
		dw_bol_header.Retrieve(iBOL)
		dw_shippers_bol.Retrieve(iBOL)
		
		// below 2 lines inc by gph on 6/19/98 at 3.05 pm
		i_i_totalshippers_onbol=dw_shippers_bol.rowcount()		
		i_s_dest = dw_bol_list.Getitemstring(irow,"destination")	
		SELECT	customer,
			status_type,
			cs_status
		INTO	:i_s_cust,
			:ls_type,
			:is_status
		FROM	destination,
			customer_service_status
		WHERE	destination = :i_s_dest and
			destination.cs_status = customer_service_status.status_name;
//		i_dwc_childdw.retrieve(i_s_dest,l_s_cust)	
		wf_getdestlist()
		i_dwc_childdw.retrieve(is_destarray)
		if ls_type <> 'A' then
			Post Event ue_unapproved_message ( )
		end if
	End If
End If
Timer(.5)

end event

on timer;If bDragShipper or bDragShipperBOL then
	If bDragShipperBOL then
		st_right_arrow.visible	= Not st_right_arrow.visible
		st_left_arrow.visible	= TRUE
	Else
		st_left_arrow.visible	= Not st_left_arrow.visible
		st_right_arrow.visible	= TRUE
	End If
Else
	st_right_arrow.visible	= FALSE
	st_left_arrow.visible	= FALSE
End If
end on

event activate;IF w_shipping_mdi_screen.Menuname <> 'm_bill_of_lading' THEN &
	w_shipping_mdi_screen.ChangeMenu(m_bill_of_lading)
end event

on w_bill_of_lading.create
if this.MenuName = "m_bill_of_lading" then this.MenuID = create m_bill_of_lading
this.dw_pool_codes=create dw_pool_codes
this.st_right_arrow=create st_right_arrow
this.st_left_arrow=create st_left_arrow
this.st_5=create st_5
this.st_4=create st_4
this.p_4=create p_4
this.dw_bol_form=create dw_bol_form
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.dw_shipper_pool=create dw_shipper_pool
this.dw_shippers_with_no_bol=create dw_shippers_with_no_bol
this.dw_shippers_bol=create dw_shippers_bol
this.dw_bol_list=create dw_bol_list
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.lb_1=create lb_1
this.dw_bol_header=create dw_bol_header
this.gb_2=create gb_2
this.Control[]={this.dw_pool_codes,&
this.st_right_arrow,&
this.st_left_arrow,&
this.st_5,&
this.st_4,&
this.p_4,&
this.dw_bol_form,&
this.st_3,&
this.st_2,&
this.st_1,&
this.p_3,&
this.p_2,&
this.p_1,&
this.dw_shipper_pool,&
this.dw_shippers_with_no_bol,&
this.dw_shippers_bol,&
this.dw_bol_list,&
this.gb_4,&
this.gb_3,&
this.gb_1,&
this.lb_1,&
this.dw_bol_header,&
this.gb_2}
end on

on w_bill_of_lading.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_pool_codes)
destroy(this.st_right_arrow)
destroy(this.st_left_arrow)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.p_4)
destroy(this.dw_bol_form)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.dw_shipper_pool)
destroy(this.dw_shippers_with_no_bol)
destroy(this.dw_shippers_bol)
destroy(this.dw_bol_list)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.lb_1)
destroy(this.dw_bol_header)
destroy(this.gb_2)
end on

type dw_pool_codes from datawindow within w_bill_of_lading
boolean visible = false
integer x = 2094
integer y = 1452
integer width = 393
integer height = 288
integer taborder = 90
string dataobject = "d_pool_codes_only"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_right_arrow from statictext within w_bill_of_lading
boolean visible = false
integer x = 1499
integer y = 736
integer width = 55
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_left_arrow from statictext within w_bill_of_lading
boolean visible = false
integer x = 1445
integer y = 736
integer width = 55
integer height = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_bill_of_lading
integer x = 1527
integer y = 816
integer width = 133
integer height = 48
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Drop"
boolean focusrectangle = false
end type

type st_4 from statictext within w_bill_of_lading
integer x = 1435
integer y = 816
integer width = 91
integer height = 48
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "Drag"
boolean focusrectangle = false
end type

type p_4 from picture within w_bill_of_lading
integer x = 1445
integer y = 736
integer width = 101
integer height = 92
boolean originalsize = true
string picturename = "dragdrop.bmp"
boolean focusrectangle = false
end type

type dw_bol_form from datawindow within w_bill_of_lading
boolean visible = false
integer x = 786
integer y = 1500
integer width = 494
integer height = 236
integer taborder = 110
string dataobject = "d_sd_bol_std"
boolean livescroll = true
end type

type st_3 from statictext within w_bill_of_lading
integer x = 2725
integer y = 800
integer width = 91
integer height = 56
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "BOL"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bill_of_lading
integer x = 2469
integer y = 800
integer width = 160
integer height = 48
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Printed"
boolean focusrectangle = false
end type

type st_1 from statictext within w_bill_of_lading
integer x = 2194
integer y = 800
integer width = 160
integer height = 48
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Staged"
boolean focusrectangle = false
end type

type p_3 from picture within w_bill_of_lading
integer x = 2642
integer y = 796
integer width = 78
integer height = 72
string picturename = "truck.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_bill_of_lading
integer x = 2386
integer y = 796
integer width = 78
integer height = 72
string picturename = "printer.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_bill_of_lading
integer x = 2112
integer y = 796
integer width = 73
integer height = 64
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type dw_shipper_pool from datawindow within w_bill_of_lading
boolean visible = false
integer x = 41
integer y = 1500
integer width = 741
integer height = 240
integer taborder = 100
boolean dragauto = true
string dataobject = "dw_shipper_per_pool_code"
boolean livescroll = true
end type

type dw_shippers_with_no_bol from datawindow within w_bill_of_lading
integer x = 1458
integer y = 868
integer width = 1371
integer height = 536
integer taborder = 70
string dragicon = "DRAG1PG.ICO"
string dataobject = "dw_shippers_with_no_bol"
boolean vscrollbar = true
string icon = "MONITOR.ICO"
end type

event clicked;w_shipping_mdi_screen.SetMicroHelp("List of all active shippers")
bDragShipper	= FALSE
iShipperRow		= 0
If row > 0 then
	iShipperRow	= row
	bDragShipper	= TRUE
	this.Drag(Begin!)
End If
end event

event dragdrop;long lBOL
SetNull(lBOL)
If iBOLRow = 0 then
	MessageBox(monsys.msg_title, "Please select bill of lading first")
	Return		
End If
If bDragShipperBOL then			//Dragging from shippers with BOL
	bDragShipperBOL	= FALSE
	If dw_bol_list.GetItemString(iBOLRow, "printed") = "Y" then
		MessageBox(monsys.msg_title, "The Bill of Lading has already been printed." + &
						"~rRemember to print it again", StopSign!)
	End If
	dw_shippers_bol.SetItem(iShipperBOLRow, "bill_of_lading_number", lBOL)
	If dw_shippers_bol.Update() > 0 then
		Commit;
		dw_shippers_with_no_bol.Retrieve()
		dw_shippers_bol.Retrieve(iBOL)
		If dw_shippers_bol.RowCount() = 0 then
			MessageBox(monsys.msg_title, "System will automatically delete this empty BOL", StopSign!)
			dw_bol_list.DeleteRow(iBOLRow)
			If dw_bol_list.Update() > 0 then
				Commit;	
				dw_bol_header.reset()
				wf_set_print_flag("N")
				If dw_bol_list.rowcount() = 0 then close(w_bill_of_lading)
				iBOL = 0
			Else
				Rollback;
			End If
		End If
	Else
		Rollback;
	End If
End If 
bDragShipperBOL	= FALSE
bDragShipper		= FALSE
st_left_arrow.visible	= FALSE
st_right_arrow.visible	= FALSE

end event

type dw_shippers_bol from datawindow within w_bill_of_lading
event ue_dropped ( )
integer x = 1458
integer y = 64
integer width = 1371
integer height = 668
integer taborder = 30
string dragicon = "DRAG1PG.ICO"
string dataobject = "dw_shippers_per_bol"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "MONITOR.ICO"
boolean hsplitscroll = true
end type

event ue_dropped;If iBOLRow < 1 then
	MessageBox(monsys.msg_title, "Please select bill of lading first")
Else
	If bDragShipper then			//Dragging from shippers
		bDragShipper	= FALSE
	
		If dw_bol_list.GetItemString(iBOLRow, "printed") = "Y" then
			MessageBox(monsys.msg_title, "The Bill of Lading has already been printed." + &
							"~rRemember to print it again", StopSign!)
		End If
	
		If dw_shippers_with_no_bol.GetItemNumber(iShipperRow, "bill_of_lading_number") > 0 then
			MessageBox(monsys.msg_title, "This shipper has been assigned a BOL# already", StopSign!)
		Else
			if wf_check_if_valid ( iBol, dw_shippers_with_no_bol.GetItemNumber ( iShipperRow, "id" ) ) = 0 then
				dw_shippers_with_no_bol.SetItem(iShipperRow, "bill_of_lading_number", iBOL)
				If dw_shippers_with_no_bol.Update() > 0 then
					Commit;
					dw_shippers_with_no_bol.Retrieve()
					dw_shippers_bol.Retrieve(iBOL)
					wf_set_print_flag("N")
				Else
					Rollback;
				End If
			else
				MessageBox(monsys.msg_title, "This shipper cannot be attached to currency BOL.", StopSign!)
			end if
		End If
	End If 
	
	bDragShipperBOL	= FALSE
	bDragShipper		= FALSE
	
	st_left_arrow.visible	= FALSE
	st_right_arrow.visible	= FALSE
End if
end event

event dragdrop;Post Event ue_dropped ( )
end event

event clicked;Long iRow
iRow	= this.GetClickedRow()
bDragShipperBOL	= FALSE
iShipperBOLRow = 0
If iRow > 0 then
	iShipperBOLRow	= iRow
	bDragShipperBOL= TRUE
	this.Drag(Begin!)
End If
end event

type dw_bol_list from datawindow within w_bill_of_lading
integer x = 37
integer y = 64
integer width = 1371
integer height = 668
integer taborder = 20
string dataobject = "dw_list_of_bill_of_lading"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;String 	l_s_cust
integer 	rtncode
iBOLRow	= 0
If row > 0 then
	iBOLRow	= row	
	dw_shippers_bol.Retrieve(this.GetItemNumber(row, "bol_number"))
	dw_bol_header.Retrieve(this.GetItemNumber(row, "bol_number"))
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
	iBOL	= this.GetItemNumber(row, "bol_number")
	// inc by gph on 6/19/98 at 3.04 pm, the below 2 lines 
	i_i_totalshippers_onbol=dw_shippers_bol.rowcount()
	i_s_dest = this.Getitemstring(row,"destination")
//	IF i_i_totalshippers_onbol=1 THEN
//		dw_bol_header.modify("destination.dddw.name='d_pool_codes'")
//	ELSE
//		dw_bol_header.modify("destination.dddw.name='d_pool_codes_only'")	
//	END IF 			
	rtncode = dw_bol_header.GetChild('destination', i_dwc_childdw)
	IF rtncode = -1 THEN 
		MessageBox(string(sqlca.sqlcode),sqlca.sqlerrtext)
	ELSE	
		wf_getdestlist()
		i_dwc_childdw.SetTransObject(SQLCA)
//		if i_dwc_childdw.retrieve(i_s_dest) < 1 then &
		if i_dwc_childdw.retrieve(is_destarray) < 1 then &		
			i_dwc_childdw.Insertrow(0)
	END IF 	 
End If

end event

type gb_4 from groupbox within w_bill_of_lading
integer x = 1426
integer y = 752
integer width = 1426
integer height = 672
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78160032
string text = "      Active Shippers"
end type

type gb_3 from groupbox within w_bill_of_lading
integer x = 1426
integer width = 1426
integer height = 752
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78160032
string text = "Shippers on Current Bill of Lading"
end type

type gb_1 from groupbox within w_bill_of_lading
integer x = 18
integer width = 1408
integer height = 752
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78160032
string text = "List of Bill of Ladings"
end type

type lb_1 from listbox within w_bill_of_lading
boolean visible = false
integer x = 357
integer y = 1016
integer width = 1001
integer height = 380
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
end type

event selectionchanged;//IF dw_bol_header.rowcount() > 0 THEN 
//   dw_bol_header.setitem(1,'destination',lb_1.selecteditem())
//	This.Hide()
//	dw_bol_header.setcolumn('scac_transfer')
//END IF 	
end event

type dw_bol_header from datawindow within w_bill_of_lading
integer x = 37
integer y = 864
integer width = 1371
integer height = 536
integer taborder = 60
string dataobject = "dw_bol_header"
end type

event constructor;integer rtncode
rtncode = dw_bol_header.GetChild('destination', i_dwc_childdw)
IF rtncode = -1 THEN MessageBox(string(sqlca.sqlcode),sqlca.sqlerrtext)
// Set the transaction object for the child
i_dwc_childdw.SetTransObject(SQLCA)
i_dwc_childdw.insertrow(0)

end event

type gb_2 from groupbox within w_bill_of_lading
integer x = 18
integer y = 752
integer width = 1408
integer height = 672
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 78160032
string text = "Bill of Lading Header Information"
end type

