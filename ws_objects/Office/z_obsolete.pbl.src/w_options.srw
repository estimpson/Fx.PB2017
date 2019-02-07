$PBExportHeader$w_options.srw
forward
global type w_options from Window
end type
type rb_1 from radiobutton within w_options
end type
type cb_2 from commandbutton within w_options
end type
type cb_1 from commandbutton within w_options
end type
type rb_2 from radiobutton within w_options
end type
end forward

global type w_options from Window
int X=905
int Y=672
int Width=1189
int Height=640
boolean TitleBar=true
string Title="Options"
long BackColor=77897888
WindowType WindowType=response!
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
rb_2 rb_2
end type
global w_options w_options

type variables
Int iSelection
end variables

event open;String ls_machine
String cChangeStdPack
String cUndoJC
String cUndoDefects

ls_machine = Message.StringParm

SELECT machine_policy.change_std_pack,   
       machine_policy.job_completion_delete,   
       machine_policy.defects_delete  
  INTO :cChangeStdPack,   
       :cUndoJC,   
       :cUndoDefects  
  FROM machine_policy  
 WHERE machine_policy.machine = :ls_machine   ;

If cChangeStdPack <> 'Y' Then rb_2.Enabled = True

iSelection = 1
end event

on w_options.create
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_2=create rb_2
this.Control[]={this.rb_1,&
this.cb_2,&
this.cb_1,&
this.rb_2}
end on

on w_options.destroy
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_2)
end on

type rb_1 from radiobutton within w_options
int X=55
int Y=160
int Width=1061
int Height=64
string Text="Reset Standard Pack Quantity"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iSelection = 2
end on

type cb_2 from commandbutton within w_options
int X=421
int Y=320
int Width=329
int Height=160
int TabOrder=20
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, 0 )
end on

type cb_1 from commandbutton within w_options
int X=55
int Y=320
int Width=329
int Height=160
int TabOrder=10
string Text="&Ok"
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, iSelection )
end on

type rb_2 from radiobutton within w_options
int X=55
int Y=80
int Width=1102
int Height=64
string Text="Change Standard Pack Quantity"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iSelection = 1
end on

