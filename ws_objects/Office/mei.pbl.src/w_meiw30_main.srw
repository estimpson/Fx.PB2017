$PBExportHeader$w_meiw30_main.srw
forward
global type w_meiw30_main from Window
end type
type p_4 from picture within w_meiw30_main
end type
type p_22 from picture within w_meiw30_main
end type
type p_21 from picture within w_meiw30_main
end type
type p_19 from picture within w_meiw30_main
end type
type p_18 from picture within w_meiw30_main
end type
type p_17 from picture within w_meiw30_main
end type
type p_16 from picture within w_meiw30_main
end type
type p_15 from picture within w_meiw30_main
end type
type p_14 from picture within w_meiw30_main
end type
type p_13 from picture within w_meiw30_main
end type
type p_10 from picture within w_meiw30_main
end type
type p_9 from picture within w_meiw30_main
end type
type p_7 from picture within w_meiw30_main
end type
type p_6 from picture within w_meiw30_main
end type
type p_3 from picture within w_meiw30_main
end type
type p_2 from picture within w_meiw30_main
end type
type p_1 from picture within w_meiw30_main
end type
type cb_19 from commandbutton within w_meiw30_main
end type
type cb_18 from commandbutton within w_meiw30_main
end type
type cb_17 from commandbutton within w_meiw30_main
end type
type cb_16 from commandbutton within w_meiw30_main
end type
type cb_10 from commandbutton within w_meiw30_main
end type
type cb_15 from commandbutton within w_meiw30_main
end type
type cb_14 from commandbutton within w_meiw30_main
end type
type cb_13 from commandbutton within w_meiw30_main
end type
type cb_12 from commandbutton within w_meiw30_main
end type
type cb_9 from commandbutton within w_meiw30_main
end type
type cb_8 from commandbutton within w_meiw30_main
end type
type cb_7 from commandbutton within w_meiw30_main
end type
type cb_6 from commandbutton within w_meiw30_main
end type
type cb_5 from commandbutton within w_meiw30_main
end type
type cb_4 from commandbutton within w_meiw30_main
end type
type cb_3 from commandbutton within w_meiw30_main
end type
type cb_2 from commandbutton within w_meiw30_main
end type
type p_5 from picture within w_meiw30_main
end type
type cb_1 from commandbutton within w_meiw30_main
end type
type gb_1 from groupbox within w_meiw30_main
end type
type gb_5 from groupbox within w_meiw30_main
end type
type gb_4 from groupbox within w_meiw30_main
end type
type gb_3 from groupbox within w_meiw30_main
end type
type gb_2 from groupbox within w_meiw30_main
end type
end forward

type str_size from structure
	integer		x
	integer		y
	integer		width
	integer		height
	integer		fontsize
end type

global type w_meiw30_main from Window
int X=28
int Y=21
int Width=2817
int Height=1869
boolean TitleBar=true
string Title="Company Information System"
string MenuName="m_menu_frame"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_capacity ( )
event ue_open pbm_custom01
p_4 p_4
p_22 p_22
p_21 p_21
p_19 p_19
p_18 p_18
p_17 p_17
p_16 p_16
p_15 p_15
p_14 p_14
p_13 p_13
p_10 p_10
p_9 p_9
p_7 p_7
p_6 p_6
p_3 p_3
p_2 p_2
p_1 p_1
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_10 cb_10
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
cb_12 cb_12
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
p_5 p_5
cb_1 cb_1
gb_1 gb_1
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
end type
global w_meiw30_main w_meiw30_main

type variables
int ii_win_width, ii_win_height, ii_win_frame_w, ii_win_frame_h
str_size size_ctrl [] 

//Boolean variable to stop recursion
boolean ib_exec = false
end variables

forward prototypes
public function integer wf_size_it ()
public function integer wf_resize_it (double size_factor)
end prototypes

event ue_capacity;Open(w_mps_1)
end event

event ue_open;// To display the rotating logo 

LONG  l_l_count, &
		l_l_temp, &
		l_l_inner

IF ISVALID ( w_title_popup ) THEN
	w_title_popup.BRINGTOTOP = TRUE
	FOR l_l_count = 1 to 10
			w_title_popup.dw_title.SETREDRAW ( FALSE )
			w_title_popup.dw_title.Modify ( "DataWindow.Timer_Interval = 250" )
			w_title_popup.dw_title.SETREDRAW ( TRUE )
	NEXT
	CLOSE ( w_title_popup )
END IF


end event

public function integer wf_size_it ();////////////////////////////////////////////////////////////////////////////////////////////////////
// function: wf_size_it
////////////////////////////////////////////////////////////////////////////////////////////////////

// save the original sizes of the window and all of the objects on the window
// NOTE !!!! this process does not work on objects that are not descended
// from the dragobject class.

dragobject temp
int cnt,i
ii_win_width  = this.width
ii_win_height = this.height
ii_win_frame_w = this.width - this.WorkSpaceWidth()
ii_win_frame_h = this.height - this.WorkSpaceHeight()

cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	
	// everything has a x,y,width and height
	size_ctrl[i].x = temp.x 
	size_ctrl[i].width = temp.width 
	size_ctrl[i].y = temp.y
	size_ctrl[i].height = temp.height 

	// now go get text size information
	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			size_ctrl[i].fontsize = cb.textsize 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			size_ctrl[i].fontsize = sle.textsize 

		case editmask!
			editmask em
			em = temp
			size_ctrl[i].fontsize  	=	em.textsize 

		case statictext!
			statictext st
			st = temp
			size_ctrl[i].fontsize  	=	st.textsize 
	
		case picturebutton!
			picturebutton pb
			pb = temp
			size_ctrl[i].fontsize = pb.textsize 

		case checkbox!
			checkbox cbx
			cbx = temp
			size_ctrl[i].fontsize  	=	cbx.textsize 

		case dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			size_ctrl[i].fontsize  	=	ddlb.textsize 

		case groupbox!
			groupbox gb
			gb = temp
			size_ctrl[i].fontsize  	=	gb.textsize 

		case listbox!
			listbox lb
			lb = temp
			size_ctrl[i].fontsize  	=	lb.textsize 

		case multilineedit!
			multilineedit mle
			mle = temp
			size_ctrl[i].fontsize  	=	mle.textsize 
		case radiobutton!
			radiobutton rb
			rb = temp
			size_ctrl[i].fontsize  	=	rb.textsize 
	end choose
next

return 1

end function

public function integer wf_resize_it (double size_factor);////////////////////////////////////////////////////////////////////////////////////////////////////
// function: wf_resize_it
////////////////////////////////////////////////////////////////////////////////////////////////////


// loop through off of the objects captured in the wf_size_it function and resize them
// Note !! radio buttons and checkboxes do not size properly as they are of fixed size.

dragobject temp
int cnt,i

ib_exec = false // keep the function from being called recursively
this.hide()

// resize the window
this.width = ((  ii_win_width - ii_win_frame_w) * size_factor) + ii_win_frame_w

this.height = ((  ii_win_height - ii_win_frame_h) * size_factor) + ii_win_frame_h

// for each control in the list, resize it and it's textsize (as applicable)
cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	temp.x		 = size_ctrl[i].x * size_factor
	temp.width   = size_ctrl[i].width  * size_factor
	temp.y		 = size_ctrl[i].y * size_factor
	temp.height  = size_ctrl[i].height * size_factor 
	

	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			cb.textsize =  size_ctrl[i].fontsize * size_factor 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			sle.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case editmask!
			editmask em
			em = temp
			em.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case statictext!
			statictext st
			st = temp
			st.textsize =  size_ctrl[i].fontsize * size_factor 

		case datawindow! // datawindows get zoomed
			datawindow dw
			dw = temp
			dw.Object.DataWindow.zoom = string(int(size_factor*100))

		case picturebutton!
			picturebutton pb
			pb = temp
			pb.textsize =  size_ctrl[i].fontsize * size_factor 

		case checkbox!
			checkbox cbx
			cbx = temp
			cbx.textsize =  size_ctrl[i].fontsize * size_factor 

		case dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			ddlb.textsize =  size_ctrl[i].fontsize * size_factor 

		case groupbox!
			groupbox gb
			gb = temp
			gb.textsize =  size_ctrl[i].fontsize * size_factor 

		case listbox!
			listbox lb
			lb = temp
			lb.textsize  =  size_ctrl[i].fontsize * size_factor 

		case multilineedit!
			multilineedit mle
			mle = temp
			mle.textsize =  size_ctrl[i].fontsize * size_factor 

		case radiobutton!
			radiobutton rb
			rb = temp
			rb.textsize =  size_ctrl[i].fontsize * size_factor 

	end choose
next

	
this.Show()
ib_exec = true
return 1
end function

event open;int	rc

This.Title = "Executive Information System  --  "

TRIGGEREVENT ( 'ue_open' )

// save off the size data
rc = wf_size_it()
ib_exec = true




end event

on w_meiw30_main.create
if this.MenuName = "m_menu_frame" then this.MenuID = create m_menu_frame
this.p_4=create p_4
this.p_22=create p_22
this.p_21=create p_21
this.p_19=create p_19
this.p_18=create p_18
this.p_17=create p_17
this.p_16=create p_16
this.p_15=create p_15
this.p_14=create p_14
this.p_13=create p_13
this.p_10=create p_10
this.p_9=create p_9
this.p_7=create p_7
this.p_6=create p_6
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.cb_19=create cb_19
this.cb_18=create cb_18
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_10=create cb_10
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.p_5=create p_5
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={ this.p_4,&
this.p_22,&
this.p_21,&
this.p_19,&
this.p_18,&
this.p_17,&
this.p_16,&
this.p_15,&
this.p_14,&
this.p_13,&
this.p_10,&
this.p_9,&
this.p_7,&
this.p_6,&
this.p_3,&
this.p_2,&
this.p_1,&
this.cb_19,&
this.cb_18,&
this.cb_17,&
this.cb_16,&
this.cb_10,&
this.cb_15,&
this.cb_14,&
this.cb_13,&
this.cb_12,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.p_5,&
this.cb_1,&
this.gb_1,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2}
end on

on w_meiw30_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_4)
destroy(this.p_22)
destroy(this.p_21)
destroy(this.p_19)
destroy(this.p_18)
destroy(this.p_17)
destroy(this.p_16)
destroy(this.p_15)
destroy(this.p_14)
destroy(this.p_13)
destroy(this.p_10)
destroy(this.p_9)
destroy(this.p_7)
destroy(this.p_6)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cb_19)
destroy(this.cb_18)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_10)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.p_5)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event resize;////////////////////////////////////////////////////////////////////////////////////////////////////
// resize script for w_scale
////////////////////////////////////////////////////////////////////////////////////////////////////

double ratiow, ratio, ratioh
int rc

// recalculate the new ratios and then use the minimum
if ib_exec then  // Check to see if wf_resize_it is already running.
	ratioh = this.height /ii_win_height
	ratiow = this.width / ii_win_width
	ratio = min (ratioh, ratiow)
	rc = wf_resize_it(ratio)
end if


end event

type p_4 from picture within w_meiw30_main
int X=1724
int Y=1169
int Width=151
int Height=125
string PictureName="pspaste.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_cash_flow)
end event

type p_22 from picture within w_meiw30_main
int X=1948
int Y=929
int Width=151
int Height=129
string PictureName="tutnew.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_defects)
end event

type p_21 from picture within w_meiw30_main
int X=1002
int Y=925
int Width=151
int Height=141
string PictureName="psclear.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_machine)
end event

type p_19 from picture within w_meiw30_main
int X=860
int Y=1273
int Width=170
int Height=149
string PictureName="pick.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;open (w_ei_product_cost)
end event

type p_18 from picture within w_meiw30_main
int X=1719
int Y=1337
int Width=147
int Height=117
string PictureName="noteno.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_summary)
end event

type p_17 from picture within w_meiw30_main
int X=124
int Y=1285
int Width=170
int Height=129
string PictureName="outside.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_inventory)
end event

type p_16 from picture within w_meiw30_main
int X=1948
int Y=721
int Width=129
int Height=141
string PictureName="flathead.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_production_main)
end event

type p_15 from picture within w_meiw30_main
int X=133
int Y=925
int Width=161
int Height=141
string PictureName="hammer.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_labor)
end event

type p_14 from picture within w_meiw30_main
int X=133
int Y=729
int Width=179
int Height=125
string PictureName="demowot.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_inventory_yield)
end event

type p_13 from picture within w_meiw30_main
int X=1011
int Y=725
int Width=156
int Height=117
string PictureName="cut1.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_part)
end event

type p_10 from picture within w_meiw30_main
int X=1111
int Y=373
int Width=161
int Height=125
string PictureName="flash.bmp"
boolean FocusRectangle=false
end type

event clicked;w_meiw30_main.triggerevent('ue_capacity')
end event

type p_9 from picture within w_meiw30_main
int X=471
int Y=1461
int Width=215
int Height=141
string PictureName="beach.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_activity_main)
end event

type p_7 from picture within w_meiw30_main
int X=1111
int Y=177
int Width=119
int Height=113
string PictureName="unit.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_mps_2)
end event

type p_6 from picture within w_meiw30_main
int X=2094
int Y=161
int Width=156
int Height=137
string PictureName="noteyesw.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_sales)
end event

type p_3 from picture within w_meiw30_main
int X=129
int Y=365
int Width=156
int Height=137
string PictureName="mail.bmp"
boolean Border=true
boolean FocusRectangle=false
end type

event clicked;open (w_ei_receipts)
end event

type p_2 from picture within w_meiw30_main
int X=142
int Y=169
int Width=147
int Height=105
string PictureName="dollar.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_purchasing)
end event

type p_1 from picture within w_meiw30_main
int X=2103
int Y=373
int Width=129
int Height=113
string PictureName="truck.bmp"
boolean FocusRectangle=false
end type

event clicked;open (w_ei_shipments)
end event

type cb_19 from commandbutton within w_meiw30_main
int X=1710
int Y=1329
int Width=942
int Height=137
int TabOrder=120
string Text="  &Summary"
int TextSize=-20
int Weight=700
string FaceName="Book Antiqua"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_summary)
end on

type cb_18 from commandbutton within w_meiw30_main
int X=1710
int Y=1157
int Width=942
int Height=145
int TabOrder=110
string Text="    &Cash Flow"
int TextSize=-20
int Weight=700
string FaceName="Book Antiqua"
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_cash_flow)
end on

type cb_17 from commandbutton within w_meiw30_main
int X=860
int Y=1269
int Width=572
int Height=153
int TabOrder=230
string Text="      &Job Cost"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_product_cost)
end on

type cb_16 from commandbutton within w_meiw30_main
int X=1939
int Y=713
int Width=572
int Height=153
int TabOrder=90
string Text="      &Production"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_production_main)
end on

type cb_10 from commandbutton within w_meiw30_main
int X=119
int Y=713
int Width=572
int Height=153
int TabOrder=80
string Text="    &Yield"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_inventory_yield)
end on

type cb_15 from commandbutton within w_meiw30_main
int X=124
int Y=917
int Width=572
int Height=153
int TabOrder=70
string Text="     &Labor"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_labor)
end on

type cb_14 from commandbutton within w_meiw30_main
int X=1002
int Y=713
int Width=572
int Height=153
int TabOrder=60
string Text="      &Product"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_part)
end on

type cb_13 from commandbutton within w_meiw30_main
int X=1102
int Y=157
int Width=572
int Height=153
int TabOrder=100
string Text="     &Schedule"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_mps_2)
end on

type cb_12 from commandbutton within w_meiw30_main
int X=119
int Y=153
int Width=572
int Height=153
int TabOrder=180
string Text="      &Purchase"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_purchasing)
end on

type cb_9 from commandbutton within w_meiw30_main
int X=119
int Y=357
int Width=572
int Height=153
int TabOrder=130
string Text="      &Receipts"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_receipts)
end on

type cb_8 from commandbutton within w_meiw30_main
int X=2085
int Y=357
int Width=572
int Height=153
int TabOrder=190
string Text="       &Shipments"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_shipments)
end on

type cb_7 from commandbutton within w_meiw30_main
int X=1939
int Y=917
int Width=572
int Height=153
int TabOrder=170
string Text="     &Defects"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_defects)
end on

type cb_6 from commandbutton within w_meiw30_main
int X=997
int Y=917
int Width=572
int Height=153
int TabOrder=50
string Text="      &Downtime"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_machine)
end on

type cb_5 from commandbutton within w_meiw30_main
int X=471
int Y=1457
int Width=705
int Height=153
int TabOrder=30
string Text="      &ABC "
int TextSize=-16
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_activity_main)


end on

type cb_4 from commandbutton within w_meiw30_main
int X=119
int Y=1273
int Width=572
int Height=153
int TabOrder=200
string Text="         &Inventory"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_inventory)
end on

type cb_3 from commandbutton within w_meiw30_main
int X=1102
int Y=357
int Width=572
int Height=153
int TabOrder=40
string Text="      &Capacity"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_meiw30_main.triggerevent('ue_capacity')
end event

type cb_2 from commandbutton within w_meiw30_main
int X=2085
int Y=153
int Width=572
int Height=153
int TabOrder=20
string Text="       &Forecast"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;open (w_ei_sales)
end on

type p_5 from picture within w_meiw30_main
int X=1719
int Y=1497
int Width=183
int Height=145
string PictureName="exitdoor.bmp"
boolean FocusRectangle=false
end type

event clicked;close (parent)
end event

type cb_1 from commandbutton within w_meiw30_main
int X=1706
int Y=1489
int Width=942
int Height=161
int TabOrder=220
string Text="   &Exit"
int TextSize=-22
int Weight=700
string FaceName="Arial Black"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type gb_1 from groupbox within w_meiw30_main
int X=33
int Y=25
int Width=769
int Height=541
int TabOrder=10
string Text="Purchasing  "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Bookman Old Style"
boolean Underline=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_meiw30_main
int X=33
int Y=1157
int Width=1601
int Height=493
int TabOrder=210
string Text="Administration"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Bookman Old Style"
boolean Underline=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_meiw30_main
int X=28
int Y=577
int Width=2716
int Height=545
int TabOrder=140
string Text="Shop Floor Production"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Bookman Old Style"
boolean Underline=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_meiw30_main
int X=837
int Y=25
int Width=1098
int Height=541
int TabOrder=150
string Text="Production Schedule"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Bookman Old Style"
boolean Underline=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_meiw30_main
int X=1971
int Y=25
int Width=773
int Height=541
int TabOrder=160
string Text="Sales "
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-16
int Weight=700
string FaceName="Bookman Old Style"
boolean Underline=true
FontFamily FontFamily=Roman!
FontPitch FontPitch=Variable!
end type

