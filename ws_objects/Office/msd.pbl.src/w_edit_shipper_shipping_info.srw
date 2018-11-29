$PBExportHeader$w_edit_shipper_shipping_info.srw
$PBExportComments$edit shipping information in the header section
forward
global type w_edit_shipper_shipping_info from window
end type
type cb_3 from commandbutton within w_edit_shipper_shipping_info
end type
type dw_container from datawindow within w_edit_shipper_shipping_info
end type
type sle_message10 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message9 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message8 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message7 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message6 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message5 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message4 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message3 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message2 from singlelineedit within w_edit_shipper_shipping_info
end type
type sle_message1 from singlelineedit within w_edit_shipper_shipping_info
end type
type cb_2 from commandbutton within w_edit_shipper_shipping_info
end type
type cb_1 from commandbutton within w_edit_shipper_shipping_info
end type
type dw_shipper_header from datawindow within w_edit_shipper_shipping_info
end type
type gb_2 from groupbox within w_edit_shipper_shipping_info
end type
type gb_1 from groupbox within w_edit_shipper_shipping_info
end type
end forward

global type w_edit_shipper_shipping_info from window
integer x = 219
integer y = 116
integer width = 2478
integer height = 1684
boolean titlebar = true
string title = "Shipper Header Information"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 78682240
cb_3 cb_3
dw_container dw_container
sle_message10 sle_message10
sle_message9 sle_message9
sle_message8 sle_message8
sle_message7 sle_message7
sle_message6 sle_message6
sle_message5 sle_message5
sle_message4 sle_message4
sle_message3 sle_message3
sle_message2 sle_message2
sle_message1 sle_message1
cb_2 cb_2
cb_1 cb_1
dw_shipper_header dw_shipper_header
gb_2 gb_2
gb_1 gb_1
end type
global w_edit_shipper_shipping_info w_edit_shipper_shipping_info

type variables
Long iShipper

Boolean bitemchanged = False

end variables

forward prototypes
public subroutine f_calc_box_info ()
public function string f_get_container_message ()
end prototypes

public subroutine f_calc_box_info ();Integer 	iCount
String	szContainerMessage

If dw_shipper_header.GetItemNumber(1, "staged_pallets") > 0 then
	szContainerMessage = LeftA("PLT:" + String(dw_shipper_header.GetItemNumber(1, "staged_pallets")) + Space(10), 10)
Else
	szContainerMessage	= ""
End If

For iCount	= 1 to dw_container.RowCount()
	szContainerMessage	= szContainerMessage + LeftA(Trim(f_get_string_value(dw_container.GetItemString(iCount, "container_type"))) + ":" + &
								String(dw_container.GetItemNumber(iCount, "quantity")) + SPACE(10), 10)
Next

If dw_shipper_header.RowCount() > 0 then
	sle_message1.text		= MidA(szContainerMessage, 1,  10)
	sle_message2.text		= MidA(szContainerMessage, 11, 10)
	sle_message3.text		= MidA(szContainerMessage, 21, 10)
	sle_message4.text		= MidA(szContainerMessage, 31, 10)
	sle_message5.text		= MidA(szContainerMessage, 41, 10)
	sle_message6.text		= MidA(szContainerMessage, 51, 10)
	sle_message7.text		= MidA(szContainerMessage, 61, 10)
	sle_message8.text		= MidA(szContainerMessage, 71, 10)
	sle_message9.text		= MidA(szContainerMessage, 81, 10)
	sle_message10.text	= MidA(szContainerMessage, 91, 10)
End If

end subroutine

public function string f_get_container_message ();String s_Message

s_Message	= 	LeftA(f_get_string_value(sle_message1.text) + space(10), 10) + &
					LeftA(f_get_string_value(sle_message2.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message3.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message4.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message5.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message6.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message7.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message8.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message9.text) + space(10), 10) + &	
					LeftA(f_get_string_value(sle_message10.text) + space(10), 10)

Return s_Message ;
end function

on open;Integer	iCount

String	szContainerMessage

dw_shipper_header.SetTransObject(sqlca)
dw_container.SetTransObject(sqlca)

iShipper	= Message.DoubleParm

dw_shipper_header.Retrieve(iShipper)
dw_container.Retrieve(iShipper)

If dw_shipper_header.GetItemNumber(1, "staged_pallets") > 0 then
	szContainerMessage = LeftA("PLT:" + String(dw_shipper_header.GetItemNumber(1, "staged_pallets")) + Space(10), 10)
Else
	szContainerMessage	= ""
End If

If LenA(Trim(szContainerMessage)) <= 0 then
	For iCount	= 1 to dw_container.RowCount()
		szContainerMessage	= szContainerMessage + LeftA(Trim(f_get_string_value(dw_container.GetItemString(iCount, "container_type"))) + ":" + &
									String(dw_container.GetItemNumber(iCount, "quantity")) + SPACE(10), 10)
	Next
Else
	szContainerMessage	= f_get_string_value(dw_shipper_header.GetItemString(1, "container_message"))
End If

If dw_shipper_header.RowCount() > 0 then
	sle_message1.text		= MidA(szContainerMessage, 1,  10)
	sle_message2.text		= MidA(szContainerMessage, 11, 10)
	sle_message3.text		= MidA(szContainerMessage, 21, 10)
	sle_message4.text		= MidA(szContainerMessage, 31, 10)
	sle_message5.text		= MidA(szContainerMessage, 41, 10)
	sle_message6.text		= MidA(szContainerMessage, 51, 10)
	sle_message7.text		= MidA(szContainerMessage, 61, 10)
	sle_message8.text		= MidA(szContainerMessage, 71, 10)
	sle_message9.text		= MidA(szContainerMessage, 81, 10)
	sle_message10.text	= MidA(szContainerMessage, 91, 10)
End If




//f_calc_box_info()
end on

on w_edit_shipper_shipping_info.create
this.cb_3=create cb_3
this.dw_container=create dw_container
this.sle_message10=create sle_message10
this.sle_message9=create sle_message9
this.sle_message8=create sle_message8
this.sle_message7=create sle_message7
this.sle_message6=create sle_message6
this.sle_message5=create sle_message5
this.sle_message4=create sle_message4
this.sle_message3=create sle_message3
this.sle_message2=create sle_message2
this.sle_message1=create sle_message1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_shipper_header=create dw_shipper_header
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.dw_container,&
this.sle_message10,&
this.sle_message9,&
this.sle_message8,&
this.sle_message7,&
this.sle_message6,&
this.sle_message5,&
this.sle_message4,&
this.sle_message3,&
this.sle_message2,&
this.sle_message1,&
this.cb_2,&
this.cb_1,&
this.dw_shipper_header,&
this.gb_2,&
this.gb_1}
end on

on w_edit_shipper_shipping_info.destroy
destroy(this.cb_3)
destroy(this.dw_container)
destroy(this.sle_message10)
destroy(this.sle_message9)
destroy(this.sle_message8)
destroy(this.sle_message7)
destroy(this.sle_message6)
destroy(this.sle_message5)
destroy(this.sle_message4)
destroy(this.sle_message3)
destroy(this.sle_message2)
destroy(this.sle_message1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_shipper_header)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_3 from commandbutton within w_edit_shipper_shipping_info
integer x = 1705
integer y = 1328
integer width = 247
integer height = 108
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Calc"
end type

on clicked;f_calc_box_info()


end on

type dw_container from datawindow within w_edit_shipper_shipping_info
boolean visible = false
integer x = 1975
integer y = 1168
integer width = 325
integer height = 360
integer taborder = 30
string dataobject = "dw_list_of_container_types"
boolean livescroll = true
end type

type sle_message10 from singlelineedit within w_edit_shipper_shipping_info
integer x = 1047
integer y = 1336
integer width = 603
integer height = 88
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message9 from singlelineedit within w_edit_shipper_shipping_info
integer x = 1047
integer y = 1232
integer width = 603
integer height = 88
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message8 from singlelineedit within w_edit_shipper_shipping_info
integer x = 1047
integer y = 1128
integer width = 603
integer height = 88
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message7 from singlelineedit within w_edit_shipper_shipping_info
integer x = 1047
integer y = 1024
integer width = 603
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message6 from singlelineedit within w_edit_shipper_shipping_info
integer x = 1047
integer y = 920
integer width = 603
integer height = 88
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message5 from singlelineedit within w_edit_shipper_shipping_info
integer x = 338
integer y = 1336
integer width = 603
integer height = 88
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message4 from singlelineedit within w_edit_shipper_shipping_info
integer x = 338
integer y = 1232
integer width = 603
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message3 from singlelineedit within w_edit_shipper_shipping_info
integer x = 338
integer y = 1128
integer width = 603
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message2 from singlelineedit within w_edit_shipper_shipping_info
integer x = 338
integer y = 1024
integer width = 603
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type sle_message1 from singlelineedit within w_edit_shipper_shipping_info
integer x = 338
integer y = 920
integer width = 603
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
end type

type cb_2 from commandbutton within w_edit_shipper_shipping_info
integer x = 2062
integer y = 988
integer width = 247
integer height = 108
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_edit_shipper_shipping_info
integer x = 2062
integer y = 848
integer width = 247
integer height = 108
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;String szMessage 

szMessage = f_get_container_message() 

If dw_shipper_header.AcceptText() = -1 Then Return

//	Check for required AETC code.
n_shipping_expedite_trans expediteTrans
boolean isExpedite
int isExpediteValue
isExpediteValue = dw_shipper_header.object.IsExpedite[1] 
if	isExpediteValue = 1 then
	isExpedite = true
else
	string trans_mode
	trans_mode = dw_shipper_header.object.trans_mode[1]
	expediteTrans = create n_shipping_expedite_trans
	expediteTrans.IsExpediteTransMode(trans_mode, isExpedite)
	destroy expediteTrans
end if

if	isExpedite then
	//	Determine if trans mode is expedite and set the flag.
	expediteTrans = create n_shipping_expedite_trans
	
	boolean isAETCRequired
	string destination
	destination = dw_shipper_header.object.destination[1]
	
	if	expediteTrans.IsAETCRequired(destination, isAETCRequired) = expediteTrans.SUCCESS then
		if	isAETCRequired then
			string aetcNumber
			dw_shipper_header.AcceptText()
			aetcNumber = dw_shipper_header.object.aetc_number[1]
			if	IsNull(aetcNumber, "") = "" then
				destroy expediteTrans
				MsgBox ("AETC Number is required for this destination.")
				return
			end if
		end if
	end if
	destroy expediteTrans
end if

dw_shipper_header.SetItem(1, "container_message", Trim(szMessage))

If dw_shipper_header.Update() > 0 then
	Commit;
	w_list_of_active_shippers.nGrossWeight	= dw_shipper_header.GetItemNumber(1, "gross_weight")
	w_list_of_active_shippers.dw_shipping_dock.Retrieve()
	gnv_App.of_GetFrame().SetMicroHelp("Header Information saved successfully..")
	Close(parent)
Else
	Rollback;
	Close(parent)
End If


end event

type dw_shipper_header from datawindow within w_edit_shipper_shipping_info
integer x = 64
integer y = 124
integer width = 1888
integer height = 608
integer taborder = 10
string dataobject = "dw_shipper_shipping_info"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String s_columnName
String s_original_col
String s_Bol

Int    i_Rtncode

s_columnName = dw_shipper_header.GetColumnName() 

Select bill_of_lading_number
Into   :s_bol
From   shipper
Where  id = :iShipper ;

s_original_col = dw_shipper_header.GetItemString(1, "ship_via", Primary!, True )

If s_bol <> '' Then
	If s_columnName = "ship_via" Then
	 If IsNull(s_original_col) = False and s_original_col <> '' Then
		If s_original_col <> dw_Shipper_header.GetText() Then
		  i_Rtncode = MessageBox( "Warning", "This shipper is attached to bol# "+s_bol+".~r" +&
									  "Are you sure about changing the scac code for this?", Exclamation!, YesNo!, 1 ) 
	  		If i_Rtncode = 2 Then
				dw_shipper_header.SetItem ( 1, "ship_via", s_original_col )
	     	End If
		End If
	 End If
	End If
End If  

n_shipping_expedite_trans expediteTrans

choose case dwo.Name
	case 'trans_mode'
	
		//	Determine if trans mode is expedite and set the flag.
		expediteTrans = create n_shipping_expedite_trans
		
		boolean isExpedite
		if	expediteTrans.IsExpediteTransMode(data, isExpedite) = expediteTrans.SUCCESS then
			if	isExpedite then
				object.IsExpedite[row] = 1
			end if
		end if
		destroy expediteTrans
	
	case "isexpedite"
		//	Expedite flag can be set without choosing a designated transmode.
		if	data = "0" then
			string nullString; setNull(nullString)
			object.ExpediteCode[row] = nullString
		end if

end choose

end event

type gb_2 from groupbox within w_edit_shipper_shipping_info
integer x = 37
integer y = 816
integer width = 1975
integer height = 720
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Container Information"
end type

type gb_1 from groupbox within w_edit_shipper_shipping_info
integer x = 37
integer y = 32
integer width = 1975
integer height = 768
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Shipper Header Information"
end type

