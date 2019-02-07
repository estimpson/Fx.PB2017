$PBExportHeader$w_smart_price_matrix.srw
forward
global type w_smart_price_matrix from Window
end type
type sle_vendor from singlelineedit within w_smart_price_matrix
end type
type dw_parts from u_monitor_data_entry_dw within w_smart_price_matrix
end type
type dw_price_matrix from u_monitor_data_entry_dw within w_smart_price_matrix
end type
type dw_part_plant from u_monitor_data_entry_dw within w_smart_price_matrix
end type
type st_title from statictext within w_smart_price_matrix
end type
type sle_1 from singlelineedit within w_smart_price_matrix
end type
type st_4 from statictext within w_smart_price_matrix
end type
type gb_2 from groupbox within w_smart_price_matrix
end type
type gb_6 from groupbox within w_smart_price_matrix
end type
type gb_1 from groupbox within w_smart_price_matrix
end type
type dw_vendors from u_monitor_data_entry_dw within w_smart_price_matrix
end type
type dw_vendor_parts from u_monitor_data_entry_dw within w_smart_price_matrix
end type
type st_message from statictext within w_smart_price_matrix
end type
type gb_3 from groupbox within w_smart_price_matrix
end type
type gb_4 from groupbox within w_smart_price_matrix
end type
end forward

global type w_smart_price_matrix from Window
int X=0
int Y=0
int Width=2903
int Height=1548
boolean TitleBar=true
string Title="Vendor Profile"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
event add_price pbm_custom01
event delete_price pbm_custom02
event add_onhand pbm_custom04
event delete_onhand pbm_custom05
event exit_program pbm_custom07
event ue_save pbm_custom10
sle_vendor sle_vendor
dw_parts dw_parts
dw_price_matrix dw_price_matrix
dw_part_plant dw_part_plant
st_title st_title
sle_1 sle_1
st_4 st_4
gb_2 gb_2
gb_6 gb_6
gb_1 gb_1
dw_vendors dw_vendors
dw_vendor_parts dw_vendor_parts
st_message st_message
gb_3 gb_3
gb_4 gb_4
end type
global w_smart_price_matrix w_smart_price_matrix

type variables
Boolean ib_Part                 //Whether dragging part
Boolean ib_VendorPart       //Whether dragging vendor/part
Boolean ib_refresh_smart_po
Boolean ib_part_plant
Boolean ib_price_matrix

String    i_s_part                //To keep the current part
String    i_s_vendor            //To keep the current vendor
String    szPlant               //To keep the current plant
String    is_window        

Long     iVendorPartRow  //To keep the vendor / part row
Long     iPriceMatrixRow  //To keep the price matrix row

SingleLineEdit sLabel[]
CheckBox cbCalc[]

DataWindowChild dwUM  //Child window for unit of measure
end variables

forward prototypes
public subroutine wf_vendor_part_dragdrop ()
public function boolean wf_releases_exist ()
public subroutine wf_refresh_smart_po ()
public function boolean wf_ok_to_delete (long al_row, string as_table, datawindow adw)
public subroutine wf_get_units (string as_part, long al_row, boolean ab_unitchange)
end prototypes

on add_price;dw_price_matrix.TriggerEvent("ue_insert")
end on

on delete_price;dw_price_matrix.TriggerEvent("ue_delete")	
end on

on add_onhand;dw_part_plant.TriggerEvent("ue_insert")


end on

on delete_onhand;/* 
Modification: 	02/15/96	Jim Wu
					Trigger the object's delete event. Moved the code into
					the object to make it more object oriented.
*/

dw_part_plant.TriggerEvent("ue_delete")
end on

event exit_program;IF ib_vendorpart OR ib_part_plant OR ib_price_matrix then
	If MessageBox(monsys.msg_title, "The Vendor Profile has been changed, do you want to save it before exit?", Question!, YesNo!) = 1 then
		TriggerEvent ( "ue_save" )
		IF ib_refresh_smart_po THEN 
			ib_refresh_smart_po = FALSE
			wf_refresh_smart_po()
		END IF
		SetMicroHelp ( "Vendor Profile Saved!" )
	END IF
ELSE
	IF ib_refresh_smart_po THEN 
		ib_refresh_smart_po = FALSE
		wf_refresh_smart_po()
	END IF
END IF

Close(w_smart_price_matrix)
end event

event ue_save;IF ib_vendorpart THEN
	
	dw_vendor_parts.accepttext()
	dw_vendor_parts.TriggerEvent( 'ue_save' )
	
ELSEIF ib_part_plant THEN

	dw_part_plant.accepttext()
	IF dw_part_plant.RowCount ( ) > 0 THEN
		IF szPlant = '' or IsNull(szPlant) THEN
			Messagebox(monsys.msg_title, "You must select a plant first!", StopSign!)
			Return
		ELSE
			dw_part_plant.TriggerEvent("ue_save")
		END IF
	END IF
	
ELSEIF ib_price_matrix THEN
	
	dw_price_matrix.accepttext()
	dw_price_matrix.TriggerEvent("ue_save")
	
END IF
end event

public subroutine wf_vendor_part_dragdrop ();String szCurrentPart

If ISNULL(i_s_vendor) or i_s_vendor = '' Then

  MessageBox(monsys.msg_title, "You must select a Vendor first!", StopSign! )
  dw_vendors.SetFocus()
  Return

End If

If ib_Part then	//if dragging the part datawindow

	SetNull(szCurrentPart)

	SELECT part_vendor.part  
    INTO :szCurrentPart  
    FROM  part_vendor  
   WHERE ( part_vendor.vendor 	= :i_s_vendor ) AND  
         ( part_vendor.part 		= :i_s_part )   ;

	If IsNull(szCurrentPart) then	//Not currently in list
		dw_vendor_parts.InsertRow(1)
		dw_vendor_parts.SetItem(1, "part", i_s_part)
		dw_vendor_parts.SetItem(1, "vendor", i_s_vendor)
		dw_vendor_parts.SetItem(1, "receiving_um", f_get_part_info(i_s_part, "STANDARD UNIT"))

		If dw_vendor_parts.Update() > 0 then
			Commit;
			ib_refresh_smart_po = TRUE
//			wf_refresh_smart_po()
		Else
			Rollback;
		End If

	Else									//Already existing
		MessageBox(monsys.msg_title, "The part is already in the list", Information!)
	End If

End If

ib_Part			= FALSE
ib_VendorPart	= FALSE

end subroutine

public function boolean wf_releases_exist ();Long iTotalReleases

SELECT count (po_detail.po_number )  
INTO :iTotalReleases  
FROM po_detail  
WHERE ( po_detail.part_number = :i_s_part ) AND  
      ( po_detail.vendor_code = :i_s_vendor )   ;

If iTotalReleases > 0 then
	Return  TRUE
Else
	Return  FALSE				
End If

end function

public subroutine wf_refresh_smart_po ();IF ISVALID ( w_smart_po ) THEN
	IF w_smart_po.bVendorMode then
		IF Not IsNull(w_smart_po.szVendor) then
			w_smart_po.dw_vendor_parts.Retrieve(i_s_Vendor)
			IF w_smart_po.iPO > 0 then
				w_smart_po.wf_build_crosstab()
			End IF
		End IF
	Else
		IF Not IsNull(w_smart_po.szpart) then
			w_smart_po.dw_part_vendors.Retrieve(i_s_part)
			w_smart_po.wf_build_crosstab_in_part_mode()
		End If
	End IF		
END IF


end subroutine

public function boolean wf_ok_to_delete (long al_row, string as_table, datawindow adw);/*
Description	:To check whether we can delete the current row in table.
Author		:Jim Wu
Start Date	:02/15/96
Modification:
*/


/* Declaration */
String	ls_part, &
			ls_plant, &
			ls_vendor

Long		ll_po, &
			ll_total

Boolean	lb_Ok

/* Initialization */
	lb_Ok	= TRUE

/* Main Process */

Choose Case as_table

	Case "MIN ON HAND"

		ll_po			= 0
		ls_part		= adw.GetItemString(al_row, "part")
		ls_plant		= adw.GetItemString(al_row, "plant")

		SELECT 	po_detail.po_number  
    	INTO 		:ll_po  
    	FROM 		po_detail,   
         		po_header  
   	WHERE 	( po_detail.po_number 		= po_header.po_number ) and  
         		( po_detail.part_number		= :ls_part ) AND  
         		( po_detail.plant				= :ls_plant ) AND  
         		( po_header.status			= 'A' )    ;

		lb_ok	= (ll_po = 0)

	Case "PO RELEASE"

		ll_total	= 0
		
		SELECT count (*)  
		INTO :ll_total
		FROM po_detail  
		WHERE ( po_detail.part_number = :i_s_part ) AND  
		      ( po_detail.vendor_code = :i_s_vendor )  AND 
            ( po_detail.deleted is null or deleted = 'N' ) ;

		lb_ok	= ( ll_total = 0 )
					
	Case Else

		lb_ok	= FALSE

End Choose

Return lb_ok
end function

public subroutine wf_get_units (string as_part, long al_row, boolean ab_unitchange);STRING	l_s_unit, &
			ls_originalunit
			
DATAWINDOWCHILD l_dwc

dw_vendor_parts.getchild ( "receiving_um", l_dwc )
l_dwc.settransobject ( sqlca )
l_dwc.reset()
	
SELECT part_inventory.standard_unit  
  INTO :ls_originalunit  
  FROM part_inventory  
 WHERE part_inventory.part = :as_part   ;

IF ab_unitchange THEN

	DECLARE unit_list CURSOR FOR  
	 SELECT unit_conversion.unit2  
   	FROM part_unit_conversion,   
	        unit_conversion  
	  WHERE ( part_unit_conversion.code = unit_conversion.code ) and  
   	     ( ( part_unit_conversion.part = :as_part ) AND  
	   	  ( unit_conversion.unit1 = :ls_originalunit ) )   
	ORDER BY unit_conversion.unit2 ASC  ;

	OPEN	unit_list ;
				
	DO

		FETCH unit_list INTO :l_s_unit ;

		IF SQLCA.SQLCode = 0 THEN
			l_dwc.insertrow ( 1 )
			l_dwc.setitem ( 1, 1, l_s_unit  )
		END IF

	LOOP WHILE SQLCA.SQLCode = 0

	CLOSE unit_list ;

	IF l_s_unit  = "" OR ISNULL ( l_s_unit ) THEN
		IF ls_originalunit = "" OR ISNULL ( ls_originalunit ) THEN ls_originalunit = 'EA'
			l_s_unit	 = ls_originalunit
			l_dwc.insertrow ( 1 )
			l_dwc.setitem ( 1, 1, l_s_unit  )
		ELSE
			l_dwc.insertrow ( 1 )
			l_dwc.setitem ( 1, 1, ls_originalunit  )
	END IF

ELSE

	l_s_unit = dw_vendor_parts.object.receiving_um.primary [al_row]
	
END IF
	
dw_vendor_parts.object.receiving_um[al_row] = l_s_unit


end subroutine

event open;i_s_vendor		= message.stringparm

dw_vendors.TriggerEvent("ue_initialize")







	


end event

event activate;IF gnv_App.of_GetFrame().Menuname <> 'm_part_vendor_profile' THEN &
	gnv_App.of_GetFrame().ChangeMenu(m_part_vendor_profile)
end event

on w_smart_price_matrix.create
this.sle_vendor=create sle_vendor
this.dw_parts=create dw_parts
this.dw_price_matrix=create dw_price_matrix
this.dw_part_plant=create dw_part_plant
this.st_title=create st_title
this.sle_1=create sle_1
this.st_4=create st_4
this.gb_2=create gb_2
this.gb_6=create gb_6
this.gb_1=create gb_1
this.dw_vendors=create dw_vendors
this.dw_vendor_parts=create dw_vendor_parts
this.st_message=create st_message
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.sle_vendor,&
this.dw_parts,&
this.dw_price_matrix,&
this.dw_part_plant,&
this.st_title,&
this.sle_1,&
this.st_4,&
this.gb_2,&
this.gb_6,&
this.gb_1,&
this.dw_vendors,&
this.dw_vendor_parts,&
this.st_message,&
this.gb_3,&
this.gb_4}
end on

on w_smart_price_matrix.destroy
destroy(this.sle_vendor)
destroy(this.dw_parts)
destroy(this.dw_price_matrix)
destroy(this.dw_part_plant)
destroy(this.st_title)
destroy(this.sle_1)
destroy(this.st_4)
destroy(this.gb_2)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.dw_vendors)
destroy(this.dw_vendor_parts)
destroy(this.st_message)
destroy(this.gb_3)
destroy(this.gb_4)
end on

type sle_vendor from singlelineedit within w_smart_price_matrix
event keyup pbm_keyup
int X=256
int Y=4
int Width=325
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event keyup;long	ll_row

ll_row = dw_vendors.Find ( "code >= '" + text + "'", 1, dw_vendors.RowCount ( ) )
if ll_row > 0 then
	dw_vendors.ScrollToRow ( ll_row )
	dw_vendors.SelectRow ( 0, FALSE )
	dw_vendors.SelectRow ( ll_row, TRUE )
end if
end event

type dw_parts from u_monitor_data_entry_dw within w_smart_price_matrix
int X=50
int Y=880
int Width=1925
int Height=532
int TabOrder=40
string DragIcon="BOX.ICO"
string DataObject="d_dddw_parts"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dragdrop;If ib_VendorPart then
	
	If wf_ok_to_delete( 0, 'PO RELEASE', this ) then
		
		If MessageBox(monsys.msg_title, "This will delete all price matrix information " + &
						  "for part:" + i_s_part + ", Continue to process?", Question!, YesNo!) = 1 then

			if dw_price_matrix.uf_delete(0)	then		//delete all rows
				if dw_vendor_parts.uf_delete(iVendorPartRow) then
					iVendorPartRow	= 0
					ib_refresh_smart_po = TRUE
					MessageBox(monsys.msg_title, "The information has been deleted!", Information!)
				End If
			end if
		end if

	else

		MessageBox(monsys.msg_title, "You have to empty releases for (" + i_s_vendor + " / " + i_s_part + " ) first!", Stopsign!)

	end if

End If

ib_VendorPart	= FALSE
ib_Part			= FALSE
			

end event

event clicked;call super::clicked;ib_Part	= FALSE
i_s_part	= this.uf_clicked_value('part') 

If Not IsNull( i_s_part ) then
	ib_Part	= TRUE
	this.Drag(begin!)
	st_title.text	= "Minimum Qty Setup for Part " + i_s_part
	dw_part_plant.Retrieve(i_s_part)
End If
end event

event constructor;SetTransObject(SQLCA)
Retrieve()
setfilter ( "class = 'P' OR class = 'N'" )
filter()
TriggerEvent("ue_initialize")

end event

type dw_price_matrix from u_monitor_data_entry_dw within w_smart_price_matrix
int X=2039
int Y=80
int Width=805
int Height=648
int TabOrder=60
string DataObject="dw_smart_vendor_part_price_matrix"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_delete;If this.getrow() > 0 then
	If MessageBox(monsys.msg_title, "Are you sure you want to delete?", Question!, YesNo!) = 1 then
		If uf_delete(this.GetRow()) then
			MessageBox( monsys.msg_title, "Information has been deleted." , Information! )
		End If
	End If
Else
	MessageBox(monsys.msg_title, "Select a row to delete!", StopSign!)
End If

end event

event ue_save;call super::ue_save;dw_price_matrix.SetSort("1a")
dw_price_matrix.Sort()
ib_price_matrix	= FALSE
ib_refresh_smart_po = TRUE


end event

event ue_insert;If iVendorPartRow > 0 then
	If this.uf_insert() then
		SetItem(1, "part", i_s_part)	
		SetItem(1, "vendor", i_s_vendor)
		setitem (1, 6, 0 ) // this will put a default value of 0 into price column. trigger will recalc the price.
	End If
Else
	MessageBox(monsys.msg_title, "Please click part number first", StopSign!)
End If
end event

event itemchanged;ib_price_matrix	= TRUE
end event

event editchanged;ib_price_matrix	= TRUE
end event

type dw_part_plant from u_monitor_data_entry_dw within w_smart_price_matrix
int X=2039
int Y=880
int Width=805
int Height=532
int TabOrder=70
string DataObject="dw_part_plant_min_qty"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event ue_delete;/*
Description	:	To delete the current row.
Author		:	Jim Wu
Start Date	:	02/15/96
Modification:	
*/


/* Declaratiion */
Long	ll_row

/* Initialization */
ll_row	= this.getrow()

/* Main Process */
If ll_row > 0 then
	If wf_ok_to_delete(ll_row, "MIN ON HAND", this) then
		If MessageBox(monsys.msg_title, "Are you sure you want to delete?", Question!, YesNo!) = 1 then
			If uf_delete(ll_row) then
				MessageBox(monsys.msg_title, "Information has been deleted.", Information!)
			End If
		End If
	Else
		MessageBox(monsys.msg_title, "Cannot delete minimun on hand for active Purchase Orders.", &
		StopSign!)
	End If
Else
	MessageBox(monsys.msg_title, "Select a row to delete!", StopSign!)
End If
end event

event ue_save;call super::ue_save;dw_part_plant.accepttext()
ib_part_plant	= FALSE
ib_refresh_smart_po = TRUE


end event

event itemchanged;ib_part_plant	= TRUE

If dwo.name = "plant" Then

		szPlant = data

Else
		szPlant = this.GetItemString( 1, "plant")
      If szPlant = '' or IsNull(szPlant) then
			Messagebox(monsys.msg_title, "You must select a plant first!", StopSign!)
			Return
		End If

End If
end event

event ue_insert;datawindowchild l_dwc

getchild ( "plant", l_dwc )

IF i_s_part = '' OR ISNULL(i_s_part) THEN
	MESSAGEBOX(monsys.msg_title, "You must specify a part number first!", StopSign!)
	Return
Else
	If this.uf_insert() then
		this.SetItem(1, "part", i_s_part)
		if l_dwc.Rowcount() = 1 then 
			szPlant = l_dwc.getitemstring ( 1, "destination" ) 
			this.setitem ( 1, "plant", szPlant )
			this.setcolumn ( 2 )
		end if
	End If
End If



end event

event editchanged;ib_part_plant	= TRUE
end event

type st_title from statictext within w_smart_price_matrix
int X=2048
int Y=784
int Width=786
int Height=88
boolean Enabled=false
string Text="Min OnHand Setup for Part "
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_smart_price_matrix
int X=622
int Y=784
int Width=677
int Height=80
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event rbuttondown;MessageBox(monsys.msg_title, "Enter part number here to add to part profile for current vendor", Information!)

end event

event modified;String 	l_s_class

i_s_part	= Upper(this.text)

If f_valid_part_number(this.text) then
	
	l_s_class	= f_get_part_info(i_s_part, "CLASS")
	
	If (l_s_class = 'P') or (l_s_class = 'N') then
		ib_Part		= TRUE
		wf_vendor_part_dragdrop()
		this.text	= ""
		st_title.text	= "Minimum Quantity Setup for Part " + i_s_part
		dw_part_plant.Retrieve(i_s_part)
	Else
		MessageBox(monsys.msg_title, "You can not create profile for manufactured part!", StopSign!)
	End If
	
Else
	
	f_beep(3)
	MessageBox(monsys.msg_title, "Invalid part number", StopSign!)
	sle_1.text =""
	sle_1.setfocus()
	
End If
end event

type st_4 from statictext within w_smart_price_matrix
int X=55
int Y=784
int Width=402
int Height=72
boolean Enabled=false
string Text="Quick Part Add"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_smart_price_matrix
int X=2011
int Y=20
int Width=859
int Height=732
string Text="Price Matrix"
BorderStyle BorderStyle=StyleLowered!
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within w_smart_price_matrix
int X=2011
int Y=736
int Width=859
int Height=704
BorderStyle BorderStyle=StyleLowered!
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_smart_price_matrix
int X=18
int Y=736
int Width=1993
int Height=704
BorderStyle BorderStyle=StyleLowered!
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_vendors from u_monitor_data_entry_dw within w_smart_price_matrix
int X=46
int Y=80
int Width=517
int Height=648
int TabOrder=20
string DataObject="d_dddw_vendors_with_flag"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;call super::clicked;IF row > 0 THEN
	i_s_vendor	= object.code[row]
	dw_vendor_parts.Retrieve(i_s_vendor)
	dw_price_matrix.Reset()
	dw_part_plant.Reset()
END IF
	
end event

event ue_initialize;call super::ue_initialize;Long	l_l_row

l_l_row	= dw_vendors.Find("code = '" + i_s_vendor + "'", 1, 99999)

If l_l_row > 0 then
	dw_vendors.SelectRow(l_l_row, TRUE)
	dw_vendors.ScrollToRow(l_l_row)
	dw_vendor_parts.Retrieve(i_s_vendor)
End If
end event

on constructor;call u_monitor_data_entry_dw::constructor;dw_vendors.Retrieve()
end on

type dw_vendor_parts from u_monitor_data_entry_dw within w_smart_price_matrix
int X=608
int Y=80
int Width=1371
int Height=648
int TabOrder=50
string DragIcon="BOX.ICO"
string DataObject="dw_smart_vendor_part"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

on dragdrop;call u_monitor_data_entry_dw::dragdrop;wf_vendor_part_dragdrop()
end on

event clicked;/* 03-07-2000 KAZ Modified to allow unit of measurement changes even if there are
						PO detail records for that part.  Issue # 13194 */

Boolean  lB_unit_change

IF row > 0 THEN	
	
	iVendorPartRow	= row
	i_s_part			= object.part[row]
	dw_part_plant.retrieve( i_s_part )
	dw_price_matrix.retrieve( i_s_vendor, i_s_part )
	st_message.visible	= FALSE

	IF NOT isnull(i_s_part) THEN
		
//		IF NOT wf_releases_exist() THEN				// CHG 03-07-2000 KAZ
			lb_unit_change = true
			st_message.visible	= FALSE
//		ELSE													// CHG 03-07-2000 KAZ
//			lb_unit_change = false						// CHG 03-07-2000 KAZ
//			st_message.visible	= TRUE				// CHG 03-07-2000 KAZ
//		END IF												// CHG 03-07-2000 KAZ
		
		wf_get_units ( i_s_part, row, lb_unit_change )

		This.drag(begin!)
		ib_VendorPart	= TRUE
		
	ELSE
		ib_VendorPart	= FALSE
	END IF
	
END IF


end event

event ue_initialize;call super::ue_initialize;/* 03-07-2000 KAZ Modified to populate unit of measurement drop down data window child
						with the available unit of measurements for that part.  Issue # 13194 */

Long iRtnCode

	this.SetTransObject (sqlca)								// ADD 03-07-2000 KAZ
	this.GetChild ("receiving_um", dwUM)					// ADD 03-07-2000 KAZ
	dwUM.SetTransObject (sqlca)								// ADD 03/07-2000 KAZ
	dwUM.retrieve ( i_s_part )									// ADD 03-07-2000 KAZ


iRtncode	= this.GetChild("receiving_um", dwUM)
end event

event itemchanged;ib_vendorpart = TRUE
end event

event ue_save;call super::ue_save;ib_vendorpart = FALSE
end event

event editchanged;ib_vendorpart = TRUE
end event

type st_message from statictext within w_smart_price_matrix
int X=338
int Y=16
int Width=1554
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="You can not change UM with existing releases in PO detail!"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_smart_price_matrix
int X=581
int Y=20
int Width=1426
int Height=732
string Text="Parts for Vendor"
BorderStyle BorderStyle=StyleLowered!
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_smart_price_matrix
int X=18
int Y=20
int Width=567
int Height=728
string Text="Vendors"
BorderStyle BorderStyle=StyleLowered!
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

