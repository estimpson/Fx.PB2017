$PBExportHeader$w_shortage_list.srw
$PBExportComments$mpo.pbl
forward
global type w_shortage_list from Window
end type
type dw_where_used from datawindow within w_shortage_list
end type
type sle_prompt from singlelineedit within w_shortage_list
end type
type st_prompt from statictext within w_shortage_list
end type
type cb_prompt from commandbutton within w_shortage_list
end type
type dw_po_demand from datawindow within w_shortage_list
end type
type dw_external_jobs_for_raw_material from datawindow within w_shortage_list
end type
type rb_2 from radiobutton within w_shortage_list
end type
type rb_1 from radiobutton within w_shortage_list
end type
type dw_demand_and_supply from datawindow within w_shortage_list
end type
type dw_work_order_detail from datawindow within w_shortage_list
end type
type dw_shortage from datawindow within w_shortage_list
end type
end forward

global type w_shortage_list from Window
int X=0
int Y=0
int Width=2930
int Height=1728
boolean TitleBar=true
string Title="Raw Material Shortage List"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event kanban pbm_custom01
event filter_item pbm_custom02
dw_where_used dw_where_used
sle_prompt sle_prompt
st_prompt st_prompt
cb_prompt cb_prompt
dw_po_demand dw_po_demand
dw_external_jobs_for_raw_material dw_external_jobs_for_raw_material
rb_2 rb_2
rb_1 rb_1
dw_demand_and_supply dw_demand_and_supply
dw_work_order_detail dw_work_order_detail
dw_shortage dw_shortage
end type
global w_shortage_list w_shortage_list

type variables
Date 	dLastDate

Boolean 	bViewAll = FALSE

Decimal	nQtyOnOrder
Decimal	nQtyOnHand
Decimal 	nQtyRequired

String	szComponent
end variables

forward prototypes
public subroutine wf_get_purchased_part ()
public function decimal wf_get_qty_on_order (string szpart)
public subroutine wf_show_prompt (boolean bFlag)
public subroutine wf_create_shortage ()
public subroutine wf_show_related_jobs (string szpart)
public function decimal wf_get_unit_qty (string szparent, string szcomponent)
end prototypes

on filter_item;bViewAll	= Not bViewAll

If bViewAll then
	dw_shortage.SetFilter("qty_required > 0")
	dw_shortage.Filter()
Else
	dw_shortage.SetFilter("balance < 0")
	dw_shortage.Filter()
End If	
	

end on

public subroutine wf_get_purchased_part ();Str_progress stParm

String szPart
String szName

Long	 iTotalRows
Long	 iCount

Decimal nOnHand
Decimal nQtyRequired
Decimal nOnOrder

Select Count(number) into :iTotalRows from Part Where Class = 'P';

Declare PartCur Cursor for Select Number, Name From Part Where Class = 'P' Using sqlca;

Open PartCur;

Fetch PartCur into :szPart, :szName;

stParm.title	= "Searching purchased part"
OpenWithParm(w_progress, stParm)
w_progress.cb_cancel.visible	= FALSE
iCount			= 1
SetNull(nOnOrder)

Do while sqlca.sqlcode = 0
	w_progress.wf_progress(iCount / iTotalRows, "Process " + szPart)
	iCount ++

	dw_demand_and_supply.Retrieve(szPart, dLastDate)
	If dw_demand_and_supply.RowCount() > 0 then
		dw_shortage.InsertRow(1)
		dw_shortage.SetItem(1, "part", szPart)
		dw_shortage.SetItem(1, "name", szName)

		nQtyRequired	= dw_demand_and_supply.GetItemNumber(1, "total_raw_qty")
		dw_shortage.SetItem(1, "qty_required", nQtyRequired)

		If rb_2.checked then
			nOnOrder	= wf_get_qty_on_order(szPart)
			dw_shortage.SetItem(1, "qty_onorder", nOnOrder)
		End If

		nOnHand	= Dec(f_get_part_info(szPart, "ON HAND"))
		dw_shortage.SetItem(1, "qty_onhand", nOnHand)
		dw_shortage.SetItem(1, "balance", f_get_value(nOnHand) + f_get_value(nOnOrder) - f_get_value(nQtyRequired))

	End If

	Fetch PartCur into :szPart, :szName;
Loop

Close PartCur;

Close(w_progress)

end subroutine

public function decimal wf_get_qty_on_order (string szpart);Long iRow
Long iTotalRows

Decimal nQty
Decimal nTotalQty	= 0

String szUM

dw_po_demand.Retrieve(szPart, dLastDate)

iTotalRows	= dw_po_demand.RowCount()

For iRow = 1 to iTotalRows
	nQty			= dw_po_demand.GetItemNumber(iRow, "balance")
	szUM			= dw_po_demand.GetItemString(iRow, "unit_of_measure")
	nTotalQty	= nTotalQty + f_convert_units(szUM, "", szPart, nQty)
Next

Return nTotalQty
end function

public subroutine wf_show_prompt (boolean bFlag);cb_prompt.visible		= bFlag
st_prompt.visible		= bFlag
sle_prompt.visible	= bFlag
end subroutine

public subroutine wf_create_shortage ();dw_shortage.Reset()
dw_where_used.Reset()
dw_external_jobs_for_raw_material.Reset()
wf_get_purchased_part()

dw_shortage.SetFilter("balance < 0")
dw_shortage.Filter()
	

end subroutine

public subroutine wf_show_related_jobs (string szpart);Long iRow
Long iTotalRows

DataWindow dw1

Decimal		nQtyLeft
Decimal		nQty
Decimal		nQtyComponent
Decimal		nQtyUnit

dw_demand_and_supply.Retrieve(szPart, dLastDate)

iTotalRows	= dw_demand_and_supply.RowCount()

dw1	= dw_external_jobs_for_raw_material

dw1.Reset()



For iRow = 1 to iTotalRows
	dw1.InsertRow(1)
	dw1.SetItem(1, "part", dw_demand_and_supply.GetItemString(iRow, "bill_of_material_parent_part"))
	dw1.SetItem(1, "job", Long(dw_demand_and_supply.GetItemString(iRow, "workorder_detail_workorder")))

	nQty	= dw_demand_and_supply.GetItemNumber(iRow, "workorder_detail_qty_required") &
					- f_get_value(dw_demand_and_supply.GetItemNumber(iRow, "workorder_detail_qty_completed"))

	dw1.SetItem(1, "qty", nQty)
	dw1.SetItem(1, "date_stamp", dw_demand_and_supply.GetItemDate(iRow, "work_order_start_date"))

Next

dw1.SetSort("3a")
dw1.Sort()

nQtyLeft	= f_get_value(nQtyOnHand) + f_get_value(nQtyOnOrder)

For iRow = 1 to iTotalRows

	szPart	= dw1.GetItemString(iRow, "part")
	nQty		= dw1.GetItemNumber(iRow, "qty")

	nQtyUnit			= wf_get_unit_qty(szPart, szComponent)
	nQtyComponent	= nQty * nQtyUnit
		
	If nQtyLeft > 0 then
		If nQtyComponent > nQtyLeft then
			dw1.SetItem(iRow, "qty_covered", nQtyLeft / nQtyUnit)
			nQtyLeft	= 0
		Else
			dw1.SetItem(iRow, "qty_covered", nQtyComponent / nQtyUnit)
			nQtyLeft	= nQtyLeft - nQtyComponent
		End If	
	End If
Next		
end subroutine

public function decimal wf_get_unit_qty (string szparent, string szcomponent);Decimal nUnitQty

  SELECT bill_of_material.quantity  
    INTO :nUnitQty  
    FROM bill_of_material  
   WHERE ( bill_of_material.parent_part = :szParent ) AND  
         ( bill_of_material.part = :szComponent );

Return nUnitQty
end function

event open;dw_work_order_detail.SetTransObject(sqlca)
dw_demand_and_supply.SetTransObject(sqlca)
dw_po_demand.SetTransObject(sqlca)
dw_where_used.SetTransObject(sqlca)

dw_shortage.Modify("part.color	= '0~tif(balance < 0, 255, 0)'")
dw_shortage.Modify("name.color	= '0~tif(balance < 0, 255, 0)'")
dw_shortage.Modify("qty_required.color	= '0~tif(balance < 0, 255, 0)'")
dw_shortage.Modify("qty_onhand.color	= '0~tif(balance < 0, 255, 0)'")
dw_shortage.Modify("qty_onorder.color	= '0~tif(balance < 0, 255, 0)'")
dw_shortage.Modify("balance.color	= '0~tif(balance < 0, 255, 0)'")

wf_show_prompt(TRUE)
sle_prompt.SetFocus()
end event

on activate;gnv_App.of_GetFrame().ChangeMenu ( m_kanban_process)
end on

on w_shortage_list.create
this.dw_where_used=create dw_where_used
this.sle_prompt=create sle_prompt
this.st_prompt=create st_prompt
this.cb_prompt=create cb_prompt
this.dw_po_demand=create dw_po_demand
this.dw_external_jobs_for_raw_material=create dw_external_jobs_for_raw_material
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_demand_and_supply=create dw_demand_and_supply
this.dw_work_order_detail=create dw_work_order_detail
this.dw_shortage=create dw_shortage
this.Control[]={this.dw_where_used,&
this.sle_prompt,&
this.st_prompt,&
this.cb_prompt,&
this.dw_po_demand,&
this.dw_external_jobs_for_raw_material,&
this.rb_2,&
this.rb_1,&
this.dw_demand_and_supply,&
this.dw_work_order_detail,&
this.dw_shortage}
end on

on w_shortage_list.destroy
destroy(this.dw_where_used)
destroy(this.sle_prompt)
destroy(this.st_prompt)
destroy(this.cb_prompt)
destroy(this.dw_po_demand)
destroy(this.dw_external_jobs_for_raw_material)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_demand_and_supply)
destroy(this.dw_work_order_detail)
destroy(this.dw_shortage)
end on

type dw_where_used from datawindow within w_shortage_list
int X=1792
int Y=944
int Width=1079
int Height=480
int TabOrder=50
string DataObject="dw_where_used_list_for_component"
boolean TitleBar=true
string Title="Where Used List for "
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type sle_prompt from singlelineedit within w_shortage_list
int X=1243
int Y=608
int Width=512
int Height=80
int TabOrder=40
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;wf_show_prompt(FALSE)
dLastDate	= RelativeDate(Today(), Integer(this.text))
wf_create_shortage()
end on

type st_prompt from statictext within w_shortage_list
int X=1061
int Y=496
int Width=841
int Height=64
boolean Visible=false
boolean Enabled=false
string Text="How many days for shortage list"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=78682240
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_prompt from commandbutton within w_shortage_list
int X=969
int Y=352
int Width=1006
int Height=480
int TabOrder=30
boolean Visible=false
boolean Enabled=false
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_po_demand from datawindow within w_shortage_list
int X=1134
int Y=1744
int Width=494
int Height=360
int TabOrder=80
boolean Visible=false
string DataObject="dw_po_detail_demand_before_date_per_part"
boolean LiveScroll=true
end type

type dw_external_jobs_for_raw_material from datawindow within w_shortage_list
int X=1792
int Y=144
int Width=1079
int Height=784
int TabOrder=20
string DataObject="dw_external_jobs_for_raw_material"
boolean TitleBar=true
string Title="Jobs Using Material"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type rb_2 from radiobutton within w_shortage_list
int X=1024
int Y=48
int Width=1271
int Height=64
string Text="Calculate based on On Hand and On Order Qty"
BorderStyle BorderStyle=StyleLowered!
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If this.checked then
	rb_1.checked	= FALSE
	If sle_prompt.text > " " then
		wf_create_shortage()
	End If
End If
end on

type rb_1 from radiobutton within w_shortage_list
int X=18
int Y=48
int Width=805
int Height=64
string Text="Calculate based on On Hand Qty"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If this.checked then
	rb_2.checked	= FALSE
	If sle_prompt.text > " " then
		wf_create_shortage()
	End If
End If
end on

type dw_demand_and_supply from datawindow within w_shortage_list
int X=585
int Y=1744
int Width=494
int Height=360
int TabOrder=70
boolean Visible=false
string DataObject="dw_demand_and_supply"
boolean LiveScroll=true
end type

type dw_work_order_detail from datawindow within w_shortage_list
int X=37
int Y=1744
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="dw_work_detail_mpo"
boolean LiveScroll=true
end type

type dw_shortage from datawindow within w_shortage_list
int X=18
int Y=144
int Width=1755
int Height=1280
int TabOrder=10
string DataObject="dw_external_shortage"
boolean TitleBar=true
string Title="Raw Shortage/Surplus List"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	nQtyRequired			= this.GetItemNumber(iRow, "qty_required")
	nQtyOnOrder				= this.GetItemNumber(iRow, "qty_onorder")
	nQtyOnHand				= this.GetItemNumber(iRow, "qty_onhand")
	szComponent				= this.GetItemString(iRow, "part")
	dw_external_jobs_for_raw_material.title = "Jobs using " + this.GetItemString(iRow, "part")
	wf_show_related_jobs(this.GetItemString(iRow, "part"))
	dw_where_used.title	= "Where used for " + this.GetItemString(iRow, "part")
	dw_where_used.Retrieve(this.GetItemString(iRow, "part"))

End If
end on

