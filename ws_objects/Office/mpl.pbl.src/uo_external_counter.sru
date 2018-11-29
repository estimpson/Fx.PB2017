$PBExportHeader$uo_external_counter.sru
forward
global type uo_external_counter from UserObject
end type
type dw_1 from datawindow within uo_external_counter
end type
type cb_1 from commandbutton within uo_external_counter
end type
end forward

global type uo_external_counter from UserObject
int Width=1262
int Height=593
dw_1 dw_1
cb_1 cb_1
end type
global uo_external_counter uo_external_counter

type variables
Window		iw_Parent
end variables

forward prototypes
public subroutine uf_increase_count (decimal increment, decimal weight)
public subroutine uf_setup (boolean ab_Mode, decimal adec_countto, window aw_Parent)
end prototypes

public subroutine uf_increase_count (decimal increment, decimal weight);
end subroutine

public subroutine uf_setup (boolean ab_Mode, decimal adec_countto, window aw_Parent);IF ab_Mode THEN
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "total_count", 0 )
	dw_1.SetItem ( 1, "count_to", 0 )
	dw_1.SetItem ( 1, "total_weight", 0 )
	dw_1.SetItem ( 1, "total_run_weight", 0 )
	iw_Parent = aw_Parent
ELSE
	iw_Parent.CloseUserObject ( This )
END IF
end subroutine

on uo_external_counter.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={ this.dw_1,&
this.cb_1}
end on

on uo_external_counter.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

type dw_1 from datawindow within uo_external_counter
int X=19
int Y=17
int Width=1226
int Height=561
int TabOrder=20
boolean Enabled=false
string DataObject="d_external_counter"
boolean Border=false
boolean LiveScroll=true
end type

type cb_1 from commandbutton within uo_external_counter
int Width=1262
int Height=593
int TabOrder=10
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

