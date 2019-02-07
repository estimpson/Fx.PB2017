$PBExportHeader$w_defect.srw
forward
global type w_defect from Window
end type
type dw_1 from datawindow within w_defect
end type
type cb_2 from commandbutton within w_defect
end type
type cb_1 from commandbutton within w_defect
end type
end forward

global type w_defect from Window
int X=352
int Y=688
int Width=2258
int Height=496
boolean TitleBar=true
string Title="Defect Code"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_defect w_defect

type variables
st_generic_structure	ist_Parm
end variables

on open;ist_Parm = Message.PowerObjectParm

dw_1.InsertRow ( 0 )
dw_1.SetItem ( 1, 'machine', ist_Parm.Value1 )
dw_1.SetItem ( 1, 'part', ist_Parm.Value2 )
dw_1.SetItem ( 1, 'quantity', Dec ( ist_Parm.Value3 ) )
dw_1.SetItem ( 1, 'Operator', ist_Parm.Value4 )
dw_1.SetItem ( 1, 'work_order', ist_Parm.Value5 )

dw_1.SetFocus ( )
end on

on w_defect.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_defect.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_defect
int X=5
int Y=48
int Width=3621
int Height=212
int TabOrder=10
string DataObject="d_defect"
boolean Border=false
boolean LiveScroll=true
end type

on constructor;dw_1.SetTransObject ( SQLCA )
end on

type cb_2 from commandbutton within w_defect
int X=1047
int Y=284
int Width=279
int Height=108
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close ( parent )
end on

type cb_1 from commandbutton within w_defect
int X=754
int Y=284
int Width=279
int Height=108
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.SetItem ( 1, 'defect_date', Today ( ) )
dw_1.SetItem ( 1, 'defect_time', Now ( )  )
w_machine_inventory.is_Defect = dw_1.GetItemString ( 1, "reason" )
IF dw_1.Update ( TRUE ) = -1 THEN
	MessageBox ( 'Error', 'Unable to save defect!' )
END IF
Close ( Parent )
end on

