$PBExportHeader$w_part_machine_tool_setup.srw
forward
global type w_part_machine_tool_setup from Window
end type
type cb_2 from commandbutton within w_part_machine_tool_setup
end type
type cb_1 from commandbutton within w_part_machine_tool_setup
end type
type dw_1 from datawindow within w_part_machine_tool_setup
end type
end forward

global type w_part_machine_tool_setup from Window
int X=1074
int Y=484
int Width=1257
int Height=504
boolean TitleBar=true
string Title="Part/Machine Tool Information"
long BackColor=79741120
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_part_machine_tool_setup w_part_machine_tool_setup

on w_part_machine_tool_setup.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_part_machine_tool_setup.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;st_generic_structure	l_str_parm

l_str_parm = Message.PowerObjectParm

IF IsNull ( l_str_parm.value10, '' ) = '' THEN //existing
	dw_1.Retrieve ( l_str_parm.value1, l_str_parm.value2, l_str_parm.value3 )
ELSE //new
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "part", l_str_parm.value1 )
	dw_1.SetItem ( 1, "machine", l_str_parm.value2 )
	dw_1.SetItem ( 1, "tool", l_str_parm.value3 )
END IF
end event

type cb_2 from commandbutton within w_part_machine_tool_setup
int X=933
int Y=336
int Width=261
int Height=92
int TabOrder=30
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_part_machine_tool_setup
int X=622
int Y=336
int Width=261
int Height=92
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF dw_1.Update ( ) = 1 THEN
	Commit;
	CloseWithReturn ( Parent, 1 )
ELSE
	Rollback;
	MessageBox ( "Part/Machine Tool Information", "Unable to save part/machine/tool information!", StopSign! )
END IF
	
end event

type dw_1 from datawindow within w_part_machine_tool_setup
int X=27
int Y=32
int Width=1211
int Height=296
int TabOrder=10
string DataObject="d_part_machine_tool_setup"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject ( sqlca )
end event

