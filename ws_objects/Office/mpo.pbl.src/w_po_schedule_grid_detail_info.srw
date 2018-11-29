$PBExportHeader$w_po_schedule_grid_detail_info.srw
$PBExportComments$(mpo) Window for displaying PO schedule grid detail information.
forward
global type w_po_schedule_grid_detail_info from Window
end type
type st_8 from statictext within w_po_schedule_grid_detail_info
end type
type st_7 from statictext within w_po_schedule_grid_detail_info
end type
type st_6 from statictext within w_po_schedule_grid_detail_info
end type
type st_5 from statictext within w_po_schedule_grid_detail_info
end type
type dw_3 from datawindow within w_po_schedule_grid_detail_info
end type
type dw_1 from datawindow within w_po_schedule_grid_detail_info
end type
type sle_on_hand from singlelineedit within w_po_schedule_grid_detail_info
end type
type st_4 from statictext within w_po_schedule_grid_detail_info
end type
type sle_po_total from singlelineedit within w_po_schedule_grid_detail_info
end type
type sle_schedule_total from singlelineedit within w_po_schedule_grid_detail_info
end type
type sle_mps_total from singlelineedit within w_po_schedule_grid_detail_info
end type
type st_3 from statictext within w_po_schedule_grid_detail_info
end type
type st_2 from statictext within w_po_schedule_grid_detail_info
end type
type st_1 from statictext within w_po_schedule_grid_detail_info
end type
type dw_mps from datawindow within w_po_schedule_grid_detail_info
end type
type gb_2 from groupbox within w_po_schedule_grid_detail_info
end type
type gb_1 from groupbox within w_po_schedule_grid_detail_info
end type
type dw_2 from datawindow within w_po_schedule_grid_detail_info
end type
end forward

type str_size from structure
	integer		x
	integer		y
	integer		width
	integer		height
	integer		fontsize
end type

global type w_po_schedule_grid_detail_info from Window
int X=5
int Y=4
int Width=3502
int Height=2044
boolean TitleBar=true
string Title="Schedule Grid Detail Information"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
dw_3 dw_3
dw_1 dw_1
sle_on_hand sle_on_hand
st_4 st_4
sle_po_total sle_po_total
sle_schedule_total sle_schedule_total
sle_mps_total sle_mps_total
st_3 st_3
st_2 st_2
st_1 st_1
dw_mps dw_mps
gb_2 gb_2
gb_1 gb_1
dw_2 dw_2
end type
global w_po_schedule_grid_detail_info w_po_schedule_grid_detail_info

type variables
String	is_Part		//Part Number
String	is_Plant		//Plant Number

// variables to resize the objects
Boolean ib_exec

int ii_win_width, ii_win_height, ii_win_frame_w, ii_win_frame_h

private:
str_size  i_size_ctrl [] 

end variables

forward prototypes
public subroutine wf_initialize ()
public function integer wf_resize_it (double size_factor)
public function integer wf_size_it ()
public function decimal wf_get_onhand ()
public function decimal wf_get_quantity_in_po (string as_part, string as_plant)
end prototypes

public subroutine wf_initialize ();/* Declaration */
s_parm_list	lstr_parm

string		ls_type, &
				ls_part

Long			l_i_orderno, &
				l_i_rowid

/* Initialization */
lstr_parm	= message.powerobjectparm
is_Part		= lstr_parm.s_key_value
ls_type		= lstr_parm.s_type
setnull(is_plant)

this.title = this.title + ' - ' + is_part

/* Main Process */
dw_mps.Retrieve(is_part, lstr_parm.s_parm_list[1] ) 
dw_1.Retrieve ( is_part )
dw_2.Retrieve ( is_part )
dw_3.retrieve ( is_part )

sle_on_hand.text			= String ( wf_get_onhand () )
sle_po_total.text			= String ( wf_get_quantity_in_po(is_part, is_plant) )

If dw_mps.RowCount() > 0 then	
	sle_mps_total.text		= String(dw_mps.GetItemNumber(1, "total_quantity"))
	sle_schedule_total.text	= String(dw_mps.GetItemNumber(1, "total_assigned"))
End If




end subroutine

public function integer wf_resize_it (double size_factor);dragobject temp

int l_i_cnt, &
	 l_i_i

ib_exec = false // keep the function from being called recursively
this.hide()

// for each control in the list, resize it and it's textsize (as applicable)
l_i_cnt = upperbound(this.control)
for  l_i_i = l_i_cnt to 1 step -1
	temp = this.control[l_i_i]
	temp.x		 = i_size_ctrl[l_i_i].x * size_factor
	temp.width   = i_size_ctrl[l_i_i].width  * size_factor
	temp.y		 = i_size_ctrl[l_i_i].y * size_factor
	temp.height  = i_size_ctrl[l_i_i].height * size_factor 

	choose case typeof(temp)

		case singlelineedit!
			singlelineedit sle
			sle = temp
			sle.textsize =  i_size_ctrl[l_i_i].fontsize * size_factor 

		case statictext!
			statictext st
			st = temp
			st.textsize =  i_size_ctrl[l_i_i].fontsize * size_factor 
			
		case groupbox!
			groupbox gb
			gb = temp
			gb.textsize =  i_size_ctrl[l_i_i].fontsize * size_factor 

		case datawindow!
			datawindow dw
			dw = temp
			dw.width 	=	i_size_ctrl[l_i_i].width	 * size_factor
			dw.height 	=	i_size_ctrl[l_i_i].height * size_factor

	end choose
next
	
this.Show()
ib_exec = true
return 1

end function

public function integer wf_size_it ();dragobject temp
int cnt,i

ii_win_width  = this.width
ii_win_height = this.height
ii_win_frame_w = this.width - this.WorkSpaceWidth()
ii_win_frame_h = this.height - this.WorkSpaceHeight()

cnt = upperbound(this.control)

for i = cnt to 1 step -1
	temp = this.control[i]
	
	// everything has a x,y,width and height
	i_size_ctrl[i].x = temp.x 
	i_size_ctrl[i].width = temp.width 
	i_size_ctrl[i].y = temp.y
	i_size_ctrl[i].height = temp.height 

	// now go get text size information
	choose case typeof(temp)
		case singlelineedit!
			singlelineedit sle
			sle = temp
			i_size_ctrl[i].fontsize = sle.textsize 

		case statictext!
			statictext st
			st = temp
			i_size_ctrl[i].fontsize  	=	st.textsize 
			
		case groupbox!
			groupbox gb
			gb = temp
			i_size_ctrl[i].fontsize  	=	gb.textsize 
			
		case datawindow!
			datawindow dw
			dw = temp
			i_size_ctrl[i].width		  	=	dw.width 
			i_size_ctrl[i].height  		=	dw.height 

	end choose
next

return 1


	



end function

public function decimal wf_get_onhand ();/* Declaration */
Decimal	lc_OnHand

/* Calculate the on hand quantity */
If is_Plant > '' then
	SELECT sum(std_quantity)  
  	INTO :lc_OnHand
   FROM object  
   WHERE ( part 	= :is_Part ) AND  
         ( plant 	= :is_Plant )   ;
Else
	lc_OnHand = f_get_value(dec(f_get_part_info(is_Part, "ON HAND")))
End If
		
Return Truncate(f_get_value(lc_OnHand), 2)
end function

public function decimal wf_get_quantity_in_po (string as_part, string as_plant);/* Declaration */
Decimal	lc_TotalQty

/* Main Routine */

If IsNull(as_Plant) then
	SELECT 	Sum(standard_qty)  
   INTO 		:lc_TotalQty  
   FROM 		po_detail  
   WHERE 	(part_number = :as_Part);
Else
	SELECT 	Sum(standard_qty)  
   INTO 		:lc_TotalQty  
   FROM 		po_detail  
   WHERE 	( part_number = :as_Part ) AND  
         	( plant = :as_Plant )   ;
End If

Return Truncate(f_get_value(lc_TotalQty), 2)

end function

on w_po_schedule_grid_detail_info.create
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.dw_3=create dw_3
this.dw_1=create dw_1
this.sle_on_hand=create sle_on_hand
this.st_4=create st_4
this.sle_po_total=create sle_po_total
this.sle_schedule_total=create sle_schedule_total
this.sle_mps_total=create sle_mps_total
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_mps=create dw_mps
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_2=create dw_2
this.Control[]={this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.dw_3,&
this.dw_1,&
this.sle_on_hand,&
this.st_4,&
this.sle_po_total,&
this.sle_schedule_total,&
this.sle_mps_total,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_mps,&
this.gb_2,&
this.gb_1,&
this.dw_2}
end on

on w_po_schedule_grid_detail_info.destroy
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.sle_on_hand)
destroy(this.st_4)
destroy(this.sle_po_total)
destroy(this.sle_schedule_total)
destroy(this.sle_mps_total)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_mps)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_2)
end on

event open;Integer l_i_rc

wf_initialize()

l_i_rc = wf_size_it ()
ib_exec = true
end event

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_menu_with_only_exit' THEN & 
	gnv_App.of_GetFrame().Changemenu ( m_menu_with_only_exit )
	

end event

event resize;double lb_ratiow, lb_ratio, lb_ratioh
int 	 l_i_rc

if ib_Exec then
	lb_ratioh	=	this.height / ii_win_height
	lb_ratiow	=	this.width / ii_win_width
	lb_ratio		= 	min ( lb_ratioh, lb_ratiow )
	l_i_rc		= 	wf_resize_it ( lb_ratio )
end if





end event

type st_8 from statictext within w_po_schedule_grid_detail_info
int X=1728
int Y=1032
int Width=910
int Height=68
boolean Enabled=false
string Text="Demand Soft Queue :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_po_schedule_grid_detail_info
int X=69
int Y=1024
int Width=910
int Height=68
boolean Enabled=false
string Text="Purchase Order Detail :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_po_schedule_grid_detail_info
int X=1728
int Y=244
int Width=910
int Height=68
boolean Enabled=false
string Text="Machine Schedule :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_po_schedule_grid_detail_info
int X=69
int Y=248
int Width=910
int Height=68
boolean Enabled=false
string Text="Inventory Onhand :"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_3 from datawindow within w_po_schedule_grid_detail_info
int X=1728
int Y=312
int Width=1673
int Height=712
string DataObject="d_demand_scheduled"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

type dw_1 from datawindow within w_po_schedule_grid_detail_info
int X=69
int Y=1100
int Width=1595
int Height=712
string DataObject="d_list_po_details_for_mrs"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

type sle_on_hand from singlelineedit within w_po_schedule_grid_detail_info
int X=2373
int Y=148
int Width=745
int Height=64
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_po_schedule_grid_detail_info
int X=1787
int Y=148
int Width=507
int Height=64
boolean Enabled=false
string Text="Total On Hand:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_po_total from singlelineedit within w_po_schedule_grid_detail_info
int X=2373
int Y=72
int Width=745
int Height=64
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_schedule_total from singlelineedit within w_po_schedule_grid_detail_info
int X=805
int Y=144
int Width=745
int Height=64
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_mps_total from singlelineedit within w_po_schedule_grid_detail_info
int X=805
int Y=64
int Width=745
int Height=64
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_po_schedule_grid_detail_info
int X=1787
int Y=80
int Width=507
int Height=52
boolean Enabled=false
string Text="Total  P.O. Qty:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_po_schedule_grid_detail_info
int X=160
int Y=144
int Width=558
int Height=64
boolean Enabled=false
string Text="Total Scheduled:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_po_schedule_grid_detail_info
int X=160
int Y=64
int Width=558
int Height=64
boolean Enabled=false
string Text="Total Demand:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_mps from datawindow within w_po_schedule_grid_detail_info
int X=1728
int Y=1100
int Width=1673
int Height=712
string DataObject="dw_display_mps_summary"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

type gb_2 from groupbox within w_po_schedule_grid_detail_info
int X=1728
int Width=1669
int Height=240
string Text="P.O. and Inventory"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_po_schedule_grid_detail_info
int X=69
int Width=1582
int Height=240
string Text="Summary in MPS"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_2 from datawindow within w_po_schedule_grid_detail_info
int X=69
int Y=312
int Width=1595
int Height=712
boolean BringToTop=true
string DataObject="d_list_of_objects_for_mrs"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;this.settransobject ( sqlca )
end event

