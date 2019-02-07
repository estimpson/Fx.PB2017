$PBExportHeader$w_sf_big_defect_select.srw
forward
global type w_sf_big_defect_select from Window
end type
type cb_2 from commandbutton within w_sf_big_defect_select
end type
type dw_2 from datawindow within w_sf_big_defect_select
end type
type dw_1 from datawindow within w_sf_big_defect_select
end type
end forward

global type w_sf_big_defect_select from Window
int X=0
int Y=0
int Width=2907
int Height=1892
long BackColor=77897888
boolean Border=false
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_2 cb_2
dw_2 dw_2
dw_1 dw_1
end type
global w_sf_big_defect_select w_sf_big_defect_select

type variables
String	sReason, &
	is_machine, &
	is_workorder, &
	is_part

end variables

event open;n_cst_associative_array	lncst_aa
lncst_aa = message.powerobjectparm

is_machine = lncst_aa.of_getitem("machine")
is_workorder = lncst_aa.of_getitem("workorder")
is_part = lncst_aa.of_getitem("part")

dw_1.SettransObject (SQLCA)
dw_1.Retrieve ( )

dw_2.SettransObject (SQLCA)
dw_2.Retrieve ( )
end event

on w_sf_big_defect_select.create
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.dw_2,&
this.dw_1}
end on

on w_sf_big_defect_select.destroy
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event close;w_part_production.total_scrapped ( )
end event

type cb_2 from commandbutton within w_sf_big_defect_select
int X=37
int Y=1536
int Width=2816
int Height=224
int TabOrder=30
string Text="Cancel"
int TextSize=-18
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_2 from datawindow within w_sf_big_defect_select
int X=1463
int Y=32
int Width=1390
int Height=1472
int TabOrder=20
string DataObject="dw_sf_defects_right"
boolean LiveScroll=true
end type

event clicked;//	Declarations
Date dTodaysDate   
Time tTimeNow
DateTime dDateStamp
String	ls_ErrText
Long nDefect_qty
Long nRowNumber
dTodaysDate = Today ()
tTimeNow    = Now ()
dDateStamp  = DateTime(Today(),Now())
nRowNumber = dw_2.Getclickedrow ( )

If ( nRowNumber = 0 ) Then Return

sReason = dw_2.GetItemstring (nRowNumber, "code")
nDefect_qty = 1

If ( w_sf_big_defect_select.sreason = "" ) then return

INSERT INTO defects  
         ( machine,   
           part,   
           reason,   
           quantity,   
           operator,   
           shift,   
           work_order,   
           data_source,   
           defect_date,   
           defect_time )  
VALUES   ( :is_machine,
           :is_part,
           :w_sf_big_defect_select.sreason,   
           :nDefect_qty,   
           :szoperator,
           null,   
           :is_workorder,
           null,   
           :dDateStamp,   
           :dDateStamp )  ;

If SQLCA.SQLCode <> 0  then
	ls_ErrText = SQLCA.SQLErrText
	RollBack ;
	MessageBox ("SQL error", ls_ErrText,Information!)
	HALT
end if

Commit;
close (parent)
end event

type dw_1 from datawindow within w_sf_big_defect_select
int X=37
int Y=32
int Width=1390
int Height=1472
int TabOrder=10
string DataObject="dw_sf_defects_left"
boolean LiveScroll=true
end type

event clicked;//	Declarations
Date	dTodaysDate   
Time	tTimeNow
DateTime	dDateStamp
String	ls_ErrText
Long	nDefect_qty
Long	nRowNumber
dTodaysDate= Today ()
tTimeNow   = Now ()
dDateStamp = DateTime(today(),Now())
nRowNumber = dw_1.Getclickedrow ( )

If ( nRowNumber = 0 ) Then Return
sReason = dw_1.GetItemstring (nRowNumber, "code")
nDefect_qty = 1

If ( w_sf_big_defect_select.sreason = "" ) then return

INSERT INTO defects  
         ( machine,   
           part,   
           reason,   
           quantity,   
           operator,   
           shift,   
           work_order,   
           data_source,   
           defect_date,   
           defect_time )  
  VALUES ( :is_machine,   
           :is_part,
           :w_sf_big_defect_select.sreason,   
           :nDefect_qty,   
           :szoperator,
           null,   
           :is_workorder,
           null,   
           :dDateStamp,   
           :dDateStamp )  ;

If SQLCA.SQLCode <> 0 then
	ls_ErrText = SQLCA.SQLErrText
	RollBack ;
	MessageBox ("SQL error", ls_ErrText,Information!)
	HALT
end if

Commit;

close (parent)
end event

