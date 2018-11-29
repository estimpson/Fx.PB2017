$PBExportHeader$w_list_of_active_shippers.srw
$PBExportComments$List of active shippers
forward
global type w_list_of_active_shippers from window
end type
type cbx_detail from checkbox within w_list_of_active_shippers
end type
type sle_percentage from statictext within w_list_of_active_shippers
end type
type p_8 from picture within w_list_of_active_shippers
end type
type st_8 from statictext within w_list_of_active_shippers
end type
type st_timer from statictext within w_list_of_active_shippers
end type
type sle_percentage1 from singlelineedit within w_list_of_active_shippers
end type
type sle_base from singlelineedit within w_list_of_active_shippers
end type
type st_7 from statictext within w_list_of_active_shippers
end type
type p_7 from picture within w_list_of_active_shippers
end type
type st_asn from statictext within w_list_of_active_shippers
end type
type st_6 from statictext within w_list_of_active_shippers
end type
type p_6 from picture within w_list_of_active_shippers
end type
type st_5 from statictext within w_list_of_active_shippers
end type
type p_5 from picture within w_list_of_active_shippers
end type
type cb_note_exit from commandbutton within w_list_of_active_shippers
end type
type mle_note from multilineedit within w_list_of_active_shippers
end type
type cb_note from commandbutton within w_list_of_active_shippers
end type
type st_4 from statictext within w_list_of_active_shippers
end type
type p_4 from picture within w_list_of_active_shippers
end type
type dw_1 from datawindow within w_list_of_active_shippers
end type
type st_3 from statictext within w_list_of_active_shippers
end type
type st_2 from statictext within w_list_of_active_shippers
end type
type st_1 from statictext within w_list_of_active_shippers
end type
type p_3 from picture within w_list_of_active_shippers
end type
type p_2 from picture within w_list_of_active_shippers
end type
type p_1 from picture within w_list_of_active_shippers
end type
type sle_bol from singlelineedit within w_list_of_active_shippers
end type
type dw_shipping_dock from datawindow within w_list_of_active_shippers
end type
end forward

global type w_list_of_active_shippers from window
integer width = 2953
integer height = 1932
boolean titlebar = true
string title = "List of Active Shippers"
string menuname = "m_list_of_shippers"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 78682240
event sort_column pbm_custom01
event set_sort_order pbm_custom02
event generate_asn pbm_custom04
event reset_gross_weight pbm_custom05
event bill_of_lading pbm_custom06
event show_note pbm_custom07
event sort_button pbm_custom08
event batch_picklists pbm_custom09
event ue_quick_shipper pbm_custom10
event ue_return_to_vendor pbm_custom11
event ue_outside_process pbm_custom12
event ue_set_auto_retrieve pbm_custom13
event ue_search ( )
cbx_detail cbx_detail
sle_percentage sle_percentage
p_8 p_8
st_8 st_8
st_timer st_timer
sle_percentage1 sle_percentage1
sle_base sle_base
st_7 st_7
p_7 p_7
st_asn st_asn
st_6 st_6
p_6 p_6
st_5 st_5
p_5 p_5
cb_note_exit cb_note_exit
mle_note mle_note
cb_note cb_note
st_4 st_4
p_4 p_4
dw_1 dw_1
st_3 st_3
st_2 st_2
st_1 st_1
p_3 p_3
p_2 p_2
p_1 p_1
sle_bol sle_bol
dw_shipping_dock dw_shipping_dock
end type
global w_list_of_active_shippers w_list_of_active_shippers

type variables
Long    iColumn              //Current column
Long    iSelectedRow      //The row selected
Long    iShipper              //Current shipper number
Long    iBoxes                //Total boxes
Long    iCount = 0          //Total count number

String   cSortOrder = "a" //Sort order
String   szFilter               //The condition for "filter"
String   szColName          //The column name
String   szDestination       //Destination
String szBOLDest
String szReturnedString

Boolean bStaged
Boolean bPrinted
Boolean bASN
Boolean bBOL
Boolean bAutoCompare = TRUE  //Dynamically compare the discrepency
boolean	ib_norefresh

Decimal nGrossWeight    //Gross weight
end variables

forward prototypes
public subroutine wf_set_print_status (string szstatus)
public function boolean wf_check_stage (long ishipper)
public subroutine wf_delete_current_row ()
public subroutine wf_generate_asn ()
public subroutine wf_setup_pro_number (string szpronumber)
public subroutine wf_refresh ()
public subroutine wf_show_note (boolean bFlag)
public function boolean wf_check_print (long ishipper)
public function decimal wf_get_gross_weight (long ishipper)
public subroutine wf_reset_col_color ()
public subroutine wf_picklist_print_status ()
public function boolean wf_update_gross_weight (decimal nweight, string csign)
public function boolean wf_set_status (string szstatus)
public subroutine wf_search_shipper (string szcondition)
end prototypes

on sort_column;If szColName > " " then
	wf_reset_col_color()
	dw_shipping_dock.Modify("#" + String(iColumn) + ".Color = 16711680")
	dw_shipping_dock.SetSort(szColName + " " + cSortOrder)
	dw_shipping_dock.Sort()
	this.SetMicroHelp("Current sort on:" + szColName)
End If
end on

on set_sort_order;If cSortOrder = "a" then
	cSortOrder = "d"
Else
	cSortOrder = "a"
End If
end on

event generate_asn;bASN	= TRUE

end event

event reset_gross_weight;//UPDATE "shipper"  
//   SET "gross_weight" = 0,
//		 "net_weight" = 0,
//		 "tare_weight" = 0
//WHERE id = :iShipper   ;
//
//If SQLCA.SQLCode = -1 then
//	Rollback;
//Else
//	Commit;
//End If
//
//dw_shipping_dock.SetItem(iSelectedRow, "gross_weight", 0)
end event

event bill_of_lading;If iSelectedRow > 0 then
	If IsNull ( dw_shipping_dock.GetItemNumber(iSelectedRow, "bill_of_lading_number"), 0 ) > 0 then
		OpenSheetWithParm(w_bill_of_lading, iShipper, w_shipping_mdi_screen, 3, Original!)
	Else
		If MessageBox("Warning", "There is no Bill of Lading assigned to the current~rshipper. Would you like to create one now?", Question!, OkCancel!) = 1 then
			OpenSheetWithParm(w_bill_of_lading, iShipper, w_shipping_mdi_screen, 3, Original!)
		End If
	End If
Else
	MessageBox("Warning", "Please select a shipper first.", StopSign!)
End If
end event

event show_note;If iSelectedRow > 0 then
	mle_note.text	= " "
	mle_note.text	= dw_shipping_dock.GetItemString(iSelectedRow, "notes")
	wf_show_note(TRUE)
Else
	MessageBox("System Message", "Please select row first", StopSign!)
End If
end event

event sort_button;str_sort stSortParm

stSortParm.dw = dw_shipping_dock
stSortParm.title = "Sort Shippers"

OpenWithParm ( w_sort, stSortParm )
dw_shipping_dock.GroupCalc ( )

end event

event batch_picklists;Open(w_batch_printing_picklists)
end event

event ue_quick_shipper;szReturnedString = ''

OpenSheetWithParm(w_quick_shipper, "Quick Shipper", w_shipping_mdi_screen, 3, Original!)
end event

event ue_return_to_vendor;OpenSheetWithParm(w_quick_shipper, "Return to Vendor", w_shipping_mdi_screen, 3, Original!)
end event

event ue_outside_process;OpenSheetWithParm(w_quick_shipper, "Outside Process", w_shipping_mdi_screen, 3, Original!)
end event

on ue_set_auto_retrieve;bAutoCompare				= Not bAutoCompare
st_timer.visible			= bAutoCompare
sle_base.visible			= bAutoCompare
sle_percentage.visible	= bAutoCompare

end on

event ue_search;ib_norefresh = TRUE

OPEN ( w_search_shipping_dock )

szFilter = Message.StringParm

IF szFilter > '' THEN

	wf_search_shipper ( szFilter )

END IF

ib_norefresh = FALSE
end event

public subroutine wf_set_print_status (string szstatus);UPDATE shipper  
   SET printed = :szStatus  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

dw_shipping_dock.SetItem(iSelectedRow, "printed", szStatus)
end subroutine

public function boolean wf_check_stage (long ishipper);String szStatus

SELECT shipper.status  
INTO 	:szStatus  
FROM 	shipper  
WHERE shipper.id = :iShipper   ;

Return (szStatus = "S")

end function

public subroutine wf_delete_current_row ();If iSelectedRow > 0 then
	dw_shipping_dock.DeleteRow(iSelectedRow)
End If
end subroutine

public subroutine wf_generate_asn ();
OpenSheetWithParm (w_asn_file_generator, iShipper, gnv_App.of_GetFrame(), 3, Original!)

end subroutine

public subroutine wf_setup_pro_number (string szpronumber);UPDATE shipper  
   SET pro_number = :szPronumber  
WHERE id = :iShipper   ;


If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

dw_shipping_dock.SetItem(iSelectedRow, "pro_number", szProNumber)
end subroutine

public subroutine wf_refresh ();dw_shipping_dock.Retrieve()
dw_shipping_dock.SelectRow(0, FALSE)
dw_shipping_dock.SelectRow(iSelectedRow, TRUE)
dw_shipping_dock.ScrollToRow(iSelectedRow)
end subroutine

public subroutine wf_show_note (boolean bFlag);cb_note.visible		= bFlag
cb_note_exit.visible	= bFlag
mle_note.visible		= bFlag
end subroutine

public function boolean wf_check_print (long ishipper);String szStatus

SELECT 	shipper.printed  
INTO 		:szStatus  
FROM 		shipper  
WHERE 	shipper.id = :iShipper   ;

Return (szStatus = "Y")

end function

public function decimal wf_get_gross_weight (long ishipper);Decimal nGrossWeight

SELECT shipper.gross_weight  
  INTO :nGrossWeight  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

Return f_get_value(nGrossWeight)


end function

public subroutine wf_reset_col_color ();Integer iCount

For iCount = 1 to 5
	dw_shipping_dock.Modify("#"+ String(iCount) + ".color=0")
Next
end subroutine

public subroutine wf_picklist_print_status ();UPDATE shipper  
   SET picklist_printed = 'Y' 
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	Rollback;
Else
	Commit;
End If

dw_shipping_dock.SetItem(iSelectedRow, "shipper_picklist_printed", "Y")
end subroutine

public function boolean wf_update_gross_weight (decimal nweight, string csign);Decimal nGrossWeight
Decimal nNetWeight
Decimal nTareWeight

Boolean bNoCommit	= FALSE

If RightA(cSign, 1) = '*' then
	bNoCommit	= TRUE
Else
	bNoCommit	= FALSE
End If

cSign	= LeftA(cSign, 1)

SELECT shipper.net_weight,   
       shipper.tare_weight  
  INTO :nNetWeight,   
       :nTareWeight  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

If cSign	= "+" then
	nNetWeight	= f_get_value(nNetWeight) + nWeight
Else
	nNetWeight	= f_get_value(nNetWeight) - nWeight
End If

nGrossWeight	= nNetWeight + f_get_value(nTareWeight)

UPDATE shipper  
   SET net_weight 	= :nNetWeight,   
       gross_weight 	= :nGrossWeight  
 WHERE id = :iShipper   ;

If SQLCA.SQLCode = -1 then
	If Not bNoCommit then
		Rollback;
	End If
	Return FALSE
Else
	If Not bNoCommit then
		Commit;
	End If
	dw_shipping_dock.SetItem(iSelectedRow, "gross_weight", nGrossWeight)
	Return TRUE
End If


end function

public function boolean wf_set_status (string szstatus);/* 01-31-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iInvoice' (next Invoice number).  */

Long iInvoice

SetNull(iInvoice)
gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6a" )
If szStatus = "C" then		//Close the shipper

//	bFinish	= FALSE																														-  CHG 01-31-2000 KAZ
//	OpenWithParm(w_get_parm_value, "next_invoice")																				-  CHG 01-31-2000 KAZ
//	Do while (Not bFinish)	//Waiting for the invoice #																		-  CHG 01-31-2000 KAZ
//	Loop																																		-  CHG 01-31-2000 KAZ
//	iInvoice	= Message.DoubleParm																										-  CHG 01-31-2000 KAZ

	if not sqlca.of_getnextparmvalue ( "next_invoice", iInvoice ) then    // Failed to get current value 	 	-  ADD 01-31-2000 KAZ
		Rollback;																															// ADD 01-31-2000 KAZ
		MessageBox(monsys.msg_title, "Failed to get a new Invoice number, Please try again", Exclamation! )	// ADD 01-31-2000 KAZ
		Return False																														// ADD 01-31-2000 KAZ
	end if																																	// ADD 01-31-2000 KAZ

End If

gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6b" )
bStaged	= (szStatus = "S")

If Not bStaged then
	bPrinted	= FALSE
End If

dw_shipping_dock.SetItem(iSelectedRow, "status", szStatus)
dw_shipping_dock.SetItem(iSelectedRow, "Staged_objs", iBoxes)

gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6c" )
If (szStatus	= "C") or (szStatus = "E") then
	dw_shipping_dock.Retrieve()
End If

UPDATE shipper  
   SET status 				= :szStatus,   
       staged_objs 		= :iBoxes,   
		 invoice_number 	= :iInvoice
 WHERE id = :iShipper   ;


gnv_App.of_GetFrame().SetMicroHelp ( "Step: 6d" )
If SQLCA.SQLCode <> 0 then
	Rollback;
	Return FALSE
Else
	Commit;
	Return TRUE
End If

end function

public subroutine wf_search_shipper (string szcondition);iSelectedRow 	= dw_shipping_dock.Find(szCondition, 1, 99999)

If iSelectedRow > 0 then
	dw_shipping_dock.SelectRow(0, FALSE)
	dw_shipping_dock.SelectRow(iSelectedRow, TRUE)
	dw_shipping_dock.ScrollToRow(iSelectedRow)
	iShipper = dw_shipping_dock.GetItemNumber ( iSelectedRow, "id" )
Else
	MessageBox("Warning", "Cannot find any shipper matching search criteria.", StopSign!)
	iShipper = 0
	iSelectedRow = 0
End If

szFilter = ''
end subroutine

event open;//************************************************************************
//* Initialization
//************************************************************************

dw_shipping_dock.Retrieve()
dw_shipping_dock.SetSort("3a, 2a, 1a")
dw_shipping_dock.Sort()
dw_shipping_dock.GroupCalc ( )

Timer(1)

gf_get_info ( 'w_list_of_active_shippers', 0 )
end event

event timer;Long iTotalShippers

If bASN then
	bASN					= FALSE
	cb_note.visible	= TRUE
	st_asn.visible		= TRUE
	wf_generate_asn()
	st_asn.visible		= FALSE
	cb_note.visible	= FALSE

Else

	If bAutoCompare then			//If automatically check 
		If iCount >= 60 then

			SELECT count( shipper.id)
			 INTO :iTotalShippers
		    FROM shipper, destination   
		   WHERE ( shipper.destination = destination.destination ) AND (( shipper.status = 'O' ) OR  
		         ( shipper.status = 'S' ) ) ; 

			//If iTotalShippers <> dw_shipping_dock.RowCount() then
				dw_shipping_dock.Retrieve()
				dw_shipping_dock.Sort ( )
				dw_shipping_dock.GroupCalc ( )
				iSelectedRow	= dw_shipping_dock.Find("id = " + String(iShipper), 1, 99999)
				If iSelectedRow > 0 then
					dw_shipping_dock.SelectRow(0, FALSE)
					dw_shipping_dock.SelectRow(iSelectedRow, TRUE)
				End If
			//End If

			iCount = 0

			sle_percentage.visible	= FALSE
			sle_percentage.width		= 0
			sle_percentage.visible	= TRUE
		Else
			if NOT sle_percentage.visible then
				sle_percentage.visible	= TRUE
			end if
			sle_percentage.width		= ( ( sle_base.width - 10 ) * iCount ) / 60
			iCount ++
		End If	
	Else
		st_timer.visible				= FALSE
		sle_percentage.visible		= FALSE
		sle_base.visible				= FALSE
	End If

End If

st_timer.text	= String(60 - iCount)








end event

event activate;If gnv_App.of_GetFrame().MenuName <> "m_list_of_shippers" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_list_of_shippers )

//f_build_custom_arrays ( "shipping.main" )
//f_build_custom_menu ( w_shipping_mdi_screen.MenuID, w_shipping_mdi_screen )

if NOT ib_norefresh then
	iCount = 61
	Timer ( 1, This )
end if
end event

on w_list_of_active_shippers.create
if this.MenuName = "m_list_of_shippers" then this.MenuID = create m_list_of_shippers
this.cbx_detail=create cbx_detail
this.sle_percentage=create sle_percentage
this.p_8=create p_8
this.st_8=create st_8
this.st_timer=create st_timer
this.sle_percentage1=create sle_percentage1
this.sle_base=create sle_base
this.st_7=create st_7
this.p_7=create p_7
this.st_asn=create st_asn
this.st_6=create st_6
this.p_6=create p_6
this.st_5=create st_5
this.p_5=create p_5
this.cb_note_exit=create cb_note_exit
this.mle_note=create mle_note
this.cb_note=create cb_note
this.st_4=create st_4
this.p_4=create p_4
this.dw_1=create dw_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.sle_bol=create sle_bol
this.dw_shipping_dock=create dw_shipping_dock
this.Control[]={this.cbx_detail,&
this.sle_percentage,&
this.p_8,&
this.st_8,&
this.st_timer,&
this.sle_percentage1,&
this.sle_base,&
this.st_7,&
this.p_7,&
this.st_asn,&
this.st_6,&
this.p_6,&
this.st_5,&
this.p_5,&
this.cb_note_exit,&
this.mle_note,&
this.cb_note,&
this.st_4,&
this.p_4,&
this.dw_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.p_3,&
this.p_2,&
this.p_1,&
this.sle_bol,&
this.dw_shipping_dock}
end on

on w_list_of_active_shippers.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_detail)
destroy(this.sle_percentage)
destroy(this.p_8)
destroy(this.st_8)
destroy(this.st_timer)
destroy(this.sle_percentage1)
destroy(this.sle_base)
destroy(this.st_7)
destroy(this.p_7)
destroy(this.st_asn)
destroy(this.st_6)
destroy(this.p_6)
destroy(this.st_5)
destroy(this.p_5)
destroy(this.cb_note_exit)
destroy(this.mle_note)
destroy(this.cb_note)
destroy(this.st_4)
destroy(this.p_4)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.sle_bol)
destroy(this.dw_shipping_dock)
end on

event resize;dw_shipping_dock.Width = width - dw_shipping_dock.x - 75
dw_shipping_dock.height = height - dw_shipping_dock.y - 115
end event

type cbx_detail from checkbox within w_list_of_active_shippers
integer x = 315
integer width = 375
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show Detail"
end type

event clicked;IF checked THEN dw_shipping_dock.dataobject = "dw_shipping_dock_detail"
IF NOT checked THEN dw_shipping_dock.dataobject = "dw_shipping_dock"
dw_shipping_dock.SetTransObject ( SQLCA )
icount = 60
parent.TRIGGER EVENT timer ( )

end event

type sle_percentage from statictext within w_list_of_active_shippers
integer x = 23
integer y = 8
integer width = 91
integer height = 36
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
boolean focusrectangle = false
end type

type p_8 from picture within w_list_of_active_shippers
integer x = 2505
integer y = 8
integer width = 73
integer height = 64
string picturename = "clock.bmp"
boolean focusrectangle = false
end type

type st_8 from statictext within w_list_of_active_shippers
integer x = 2578
integer y = 16
integer width = 325
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Sched Time (Sc)"
boolean focusrectangle = false
end type

type st_timer from statictext within w_list_of_active_shippers
integer x = 14
integer y = 56
integer width = 59
integer height = 40
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
boolean focusrectangle = false
end type

type sle_percentage1 from singlelineedit within w_list_of_active_shippers
boolean visible = false
integer x = 14
integer width = 87
integer height = 36
integer taborder = 20
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_base from singlelineedit within w_list_of_active_shippers
integer x = 14
integer width = 233
integer height = 52
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_list_of_active_shippers
integer x = 1829
integer y = 16
integer width = 201
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Pick List (Prt)"
boolean focusrectangle = false
end type

type p_7 from picture within w_list_of_active_shippers
integer x = 1755
integer y = 8
integer width = 73
integer height = 64
string picturename = "pick.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_asn from statictext within w_list_of_active_shippers
boolean visible = false
integer x = 983
integer y = 608
integer width = 946
integer height = 96
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Generating ASN, please wait..."
boolean focusrectangle = false
end type

type st_6 from statictext within w_list_of_active_shippers
integer x = 855
integer y = 16
integer width = 219
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Ret Vend (Tp)"
boolean focusrectangle = false
end type

type p_6 from picture within w_list_of_active_shippers
integer x = 782
integer y = 8
integer width = 73
integer height = 64
string picturename = "rtnvend.bmp"
boolean focusrectangle = false
end type

type st_5 from statictext within w_list_of_active_shippers
integer x = 1147
integer y = 16
integer width = 174
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Outside (Tp)"
boolean focusrectangle = false
end type

type p_5 from picture within w_list_of_active_shippers
integer x = 1074
integer y = 8
integer width = 73
integer height = 64
string picturename = "outside.bmp"
boolean focusrectangle = false
end type

type cb_note_exit from commandbutton within w_list_of_active_shippers
boolean visible = false
integer x = 1682
integer y = 892
integer width = 242
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exit"
end type

on clicked;wf_show_note(FALSE)
end on

type mle_note from multilineedit within w_list_of_active_shippers
boolean visible = false
integer x = 992
integer y = 372
integer width = 937
integer height = 484
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16776960
boolean enabled = false
end type

type cb_note from commandbutton within w_list_of_active_shippers
boolean visible = false
integer x = 901
integer y = 308
integer width = 1111
integer height = 724
integer taborder = 40
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

type st_4 from statictext within w_list_of_active_shippers
integer x = 1394
integer y = 16
integer width = 119
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Note (Nt)"
boolean focusrectangle = false
end type

type p_4 from picture within w_list_of_active_shippers
integer x = 1321
integer y = 8
integer width = 73
integer height = 64
string picturename = "noteyes.bmp"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_list_of_active_shippers
boolean visible = false
integer x = 9
integer y = 1936
integer width = 1509
integer height = 376
integer taborder = 70
string dataobject = "dw_shipping_dock"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_list_of_active_shippers
integer x = 2395
integer y = 16
integer width = 91
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "BOL"
boolean focusrectangle = false
end type

type st_2 from statictext within w_list_of_active_shippers
integer x = 2103
integer y = 16
integer width = 224
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Pack List (Prt)"
boolean focusrectangle = false
end type

type st_1 from statictext within w_list_of_active_shippers
integer x = 1586
integer y = 16
integer width = 174
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
boolean enabled = false
string text = "Staged (St)"
boolean focusrectangle = false
end type

type p_3 from picture within w_list_of_active_shippers
integer x = 2322
integer y = 8
integer width = 73
integer height = 68
string picturename = "truck.bmp"
boolean focusrectangle = false
end type

type p_2 from picture within w_list_of_active_shippers
integer x = 2030
integer y = 8
integer width = 73
integer height = 64
string picturename = "printer.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_list_of_active_shippers
integer x = 1513
integer y = 8
integer width = 73
integer height = 64
string picturename = "logo2.bmp"
boolean focusrectangle = false
end type

type sle_bol from singlelineedit within w_list_of_active_shippers
boolean visible = false
integer x = 23
integer width = 2816
integer height = 64
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "BOL Mode: Double click to set/reset Bill of Lading Flag. Use right button to set/reset BOL mode"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_shipping_dock from datawindow within w_list_of_active_shippers
integer x = 18
integer y = 96
integer width = 2816
integer height = 1296
integer taborder = 30
string dataobject = "dw_shipping_dock"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//************************************************************************
//* Declaration
//************************************************************************

Long iRow		//The clicked row
Boolean bSelect
INT	li_count

//************************************************************************
//* Main Routine
//************************************************************************

IF cb_note.visible THEN	RETURN	

iRow	= dw_shipping_dock.GetClickedRow()

If iRow	> 0 then

	iSelectedRow	= iRow
	iShipper			= dw_shipping_dock.GetItemNumber(iRow, "id")
	bStaged			= (dw_shipping_dock.GetItemString(iRow, "status") = "S")

	If Not bStaged then
		bPrinted		= FALSE
	Else
		bPrinted		= wf_check_print(iShipper)
	End If

	If Not bPrinted then
		wf_set_print_status("N")
	End If		

	bASN									= FALSE
	Timer(1)
	szDestination						= this.GetItemString(iSelectedRow, "destination")
	nGrossWeight						= wf_get_gross_weight(iShipper)

	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)
	
	SetPointer ( HourGlass! )
	select	count(*)
	into		:li_count
	from		shipper_detail
	where		shipper = :iShipper ;
	
	IF li_count > 0 THEN
		if GetItemString ( iSelectedRow, "type" ) = "Q" then
			szReturnedString = String ( iShipper )
			Timer ( 0, Parent )
			OpenSheetWithParm (w_quick_shipper, "Quick Shipper", gnv_App.of_GetFrame(), 3, Original!)
		else
			Timer ( 0, Parent )
			OpenSheetWithParm(w_shipping_dock, iShipper, gnv_App.of_GetFrame(), 3, Original!)
			w_shipping_dock.szDestination	= this.GetItemString(iSelectedRow, "destination")
			w_shipping_dock.szCustomer		= this.GetItemString(iSelectedRow, "customer")
		END IF
	ELSE
		If MessageBox(monsys.msg_title, "Shipper has no detail items.  Do you want delete it", Question!, YesNo!) = 1 then
			If wf_set_status("E") Then											//Close the shipper
				Commit ;
			Else
				RollBack ;
			End if			
		End If
	END IF
End If
end event

event clicked;//************************************************************************
//* Declaration
//************************************************************************

Long 	iRow

//************************************************************************
//* Main Routine
//************************************************************************

If cb_note.visible	then
	Return
End If

iRow				= dw_shipping_dock.GetClickedRow()
iColumn			= dw_shipping_dock.GetClickedColumn()

iSelectedRow	= 0

dw_shipping_dock.SelectRow ( 0,  False )

If iRow > 0 then
	iSelectedRow	= iRow
	dw_shipping_dock.SelectRow(iRow, Not this.IsSelected(iRow))
	iShipper			= dw_shipping_dock.GetItemNumber(iRow, "id")
End If

szColName			= ""
szColName			= this.GetObjectAtPointer()
szColName			= LeftA(szColName, PosA(szColName, "~t") - 1 )


end event

event constructor;settransobject ( sqlca )
end event

