$PBExportHeader$w_roll_up_part_cost.srw
forward
global type w_roll_up_part_cost from Window
end type
type cb_print from commandbutton within w_roll_up_part_cost
end type
type cb_exit from commandbutton within w_roll_up_part_cost
end type
type sle_speed from singlelineedit within w_roll_up_part_cost
end type
type st_message from statictext within w_roll_up_part_cost
end type
type cb_cancel from commandbutton within w_roll_up_part_cost
end type
type dw_infinite from datawindow within w_roll_up_part_cost
end type
type cb_1 from commandbutton within w_roll_up_part_cost
end type
type st_percentage from statictext within w_roll_up_part_cost
end type
type dw_part_list from datawindow within w_roll_up_part_cost
end type
type gb_speed from groupbox within w_roll_up_part_cost
end type
type gb_2 from groupbox within w_roll_up_part_cost
end type
type gb_1 from groupbox within w_roll_up_part_cost
end type
type uo_bom_check from uo_check_bom_loop within w_roll_up_part_cost
end type
end forward

global type w_roll_up_part_cost from Window
int X=0
int Y=0
int Width=2926
int Height=1764
boolean TitleBar=true
string Title="Roll up Part Costs"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
cb_print cb_print
cb_exit cb_exit
sle_speed sle_speed
st_message st_message
cb_cancel cb_cancel
dw_infinite dw_infinite
cb_1 cb_1
st_percentage st_percentage
dw_part_list dw_part_list
gb_speed gb_speed
gb_2 gb_2
gb_1 gb_1
uo_bom_check uo_bom_check
end type
global w_roll_up_part_cost w_roll_up_part_cost

type variables
Private:

Boolean bCancel
end variables

forward prototypes
public function boolean wf_need_to_roll_up (string l_s_part)
public function boolean wf_infinite_loop (string l_s_part)
public subroutine wf_reset_screen ()
public subroutine wf_new_rollup_sp (string arg_spart)
end prototypes

public function boolean wf_need_to_roll_up (string l_s_part);Integer l_i_Flag

SELECT part_standard.flag  
  INTO :l_i_Flag  
  FROM part_standard  
 WHERE part_standard.part = :l_s_Part   ;

If l_i_Flag <> 1 then
	Return TRUE
Else
	Return FALSE
End If
end function

public function boolean wf_infinite_loop (string l_s_part);Boolean bLoop

bLoop	= TRUE
bLoop = uo_bom_check.wf_check_loop_in_bom(l_s_Part) 

If bLoop then
	dw_infinite.InsertRow(1)
	dw_infinite.SetItem(1, 1, l_s_Part)
	dw_infinite.SetItem(1, 2, uo_bom_check.mle_bom.text)
End If

Return bLoop
end function

public subroutine wf_reset_screen ();cb_exit.visible	= TRUE
cb_cancel.visible	= TRUE
cb_1.visible		= TRUE
gb_2.visible		= TRUE
dw_infinite.visible = TRUE
gb_speed.visible	= TRUE

cb_exit.BringToTop	= TRUE
cb_cancel.BringToTop	= TRUE
cb_1.BringToTop		= TRUE
gb_2.BringToTop		= TRUE
dw_infinite.BringTotop	= TRUE
st_message.BringToTop	= TRUE
gb_speed.BringToTop	= TRUE
sle_speed.BringToTop	= TRUE

cb_cancel.Enabled		= TRUE
cb_exit.Enabled		= FALSE
end subroutine

public subroutine wf_new_rollup_sp (string arg_spart);string ls_costbucket

ls_costbucket = 'S'

IF arg_spart <> '' THEN
	SetPointer(HourGlass!)
	If g_s_platform = 'Microsoft SQL Server' Then
		SQLCA.autocommit = True
		DECLARE mct_computecost PROCEDURE FOR msp_calc_costs  
	         :arg_spart, :ls_costbucket
		USING SQLCA;
	   Execute mct_computecost;
		SQLCA.autocommit = FALSE
		IF SQLCA.sqlcode < 0 THEN
 	  	   MessageBox (monsys.msg_title, SQLCA.sqlerrtext, Information! )
		END IF
	Else
		DECLARE mct_wccomputecost PROCEDURE FOR msp_calc_costs  
	         :arg_spart, :ls_costbucket 
		USING sqlca;
	   Execute mct_wccomputecost ;
		IF sqlca.sqlcode < 0 THEN
   	   MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
		END IF
	End If
	SetPointer(Arrow!)
End If
end subroutine

on open;dw_part_list.SetTransObject(SQLCA)
dw_part_list.Retrieve()
end on

on w_roll_up_part_cost.create
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.sle_speed=create sle_speed
this.st_message=create st_message
this.cb_cancel=create cb_cancel
this.dw_infinite=create dw_infinite
this.cb_1=create cb_1
this.st_percentage=create st_percentage
this.dw_part_list=create dw_part_list
this.gb_speed=create gb_speed
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_bom_check=create uo_bom_check
this.Control[]={this.cb_print,&
this.cb_exit,&
this.sle_speed,&
this.st_message,&
this.cb_cancel,&
this.dw_infinite,&
this.cb_1,&
this.st_percentage,&
this.dw_part_list,&
this.gb_speed,&
this.gb_2,&
this.gb_1,&
this.uo_bom_check}
end on

on w_roll_up_part_cost.destroy
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.sle_speed)
destroy(this.st_message)
destroy(this.cb_cancel)
destroy(this.dw_infinite)
destroy(this.cb_1)
destroy(this.st_percentage)
destroy(this.dw_part_list)
destroy(this.gb_speed)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_bom_check)
end on

type cb_print from commandbutton within w_roll_up_part_cost
int X=2171
int Y=1424
int Width=229
int Height=96
int TabOrder=100
string Text="Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_infinite.print()
end event

type cb_exit from commandbutton within w_roll_up_part_cost
int X=2450
int Y=1424
int Width=229
int Height=96
int TabOrder=100
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//w_visual_bom_for_cost_roll_up.i_bclosewin = TRUE
//Close(w_visual_bom_for_cost_roll_up)
Close(parent)
end on

type sle_speed from singlelineedit within w_roll_up_part_cost
int X=1664
int Y=608
int Width=37
int Height=32
int TabOrder=30
boolean AutoHScroll=false
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_message from statictext within w_roll_up_part_cost
int X=1701
int Y=368
int Width=878
int Height=64
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_roll_up_part_cost
int X=1897
int Y=1424
int Width=229
int Height=96
int TabOrder=90
boolean Enabled=false
string Text="Cancel"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;bCancel	= TRUE
end on

type dw_infinite from datawindow within w_roll_up_part_cost
int X=1682
int Y=784
int Width=914
int Height=592
int TabOrder=70
string DataObject="dw_external_template"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_roll_up_part_cost
int X=1623
int Y=1424
int Width=229
int Height=96
int TabOrder=80
string Text="Roll Up"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long 		l_i_Row
String	l_s_Part

UPDATE part_standard  
   SET flag = 0  ;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	Rollback;
End If

dw_infinite.reset()

bCancel	= FALSE

wf_reset_screen()

For l_i_Row = 1 to dw_part_list.RowCount()

	Yield()
	
	sle_speed.x	= gb_speed.x + 20

	If bCancel then
		If MessageBox("Warning", "Are you sure to stop the calculation?", &
							StopSign!, YesNo!) = 1 then
			Exit
		Else
			bCancel	= FALSE
			wf_reset_screen()
		End If
	End If

	l_s_Part	= dw_part_list.GetItemString(l_i_Row, 1)
	gb_1.text	= "Processing " + l_s_Part

	If wf_need_to_roll_up(l_s_Part) then
		st_message.text	= "Checking infinite loop..."

		If Not wf_infinite_loop(l_s_Part) then

// inc by gph the new stored procedure
			Yield()
			wf_new_rollup_sp(l_s_part)

			Yield()
			sle_speed.x	= gb_speed.x + (gb_speed.width / 5)
			st_message.text	= "Drawing the visual BOM..."

			sle_speed.x	= gb_speed.x + (gb_speed.width * 2 / 5)

			Yield()
			sle_speed.x = gb_speed.x + (gb_speed.width * 3 / 5)

			Yield()
			st_message.text	= "Rolling up costs..."
			sle_speed.x = gb_speed.x + (gb_speed.width * 4 /  5)

			Yield()
			st_message.text	= "Saving costs..."
			st_message.text	= ''
			sle_speed.x = gb_speed.x + (gb_speed.width) - sle_speed.width - 10

		End If
	End If

	st_percentage.text	= String(Truncate(100 * l_i_Row / dw_part_list.RowCount(), 0)) + &
								  " %"
Next

cb_exit.Enabled	= TRUE
cb_cancel.Enabled	= FALSE


end event

type st_percentage from statictext within w_roll_up_part_cost
int X=1737
int Y=240
int Width=768
int Height=128
boolean Enabled=false
string Text="0 %"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_part_list from datawindow within w_roll_up_part_cost
int X=128
int Y=192
int Width=1408
int Height=1328
int TabOrder=10
string DataObject="d_part_standard_list"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type gb_speed from groupbox within w_roll_up_part_cost
int X=1646
int Y=528
int Width=987
int Height=160
int TabOrder=20
string Text="Speed"
long BackColor=78682240
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_roll_up_part_cost
int X=1646
int Y=704
int Width=987
int Height=688
int TabOrder=60
string Text="List of Parts with Infinite Loop"
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_roll_up_part_cost
int X=1646
int Y=160
int Width=987
int Height=352
int TabOrder=40
string Text="Status"
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_bom_check from uo_check_bom_loop within w_roll_up_part_cost
int X=457
int Y=540
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
end type

on uo_bom_check.destroy
call uo_check_bom_loop::destroy
end on

