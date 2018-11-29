$PBExportHeader$w_exequery.srw
forward
global type w_exequery from Window
end type
type cb_3 from commandbutton within w_exequery
end type
type cb_2 from commandbutton within w_exequery
end type
type dw_1 from datawindow within w_exequery
end type
type cb_1 from commandbutton within w_exequery
end type
type mle_1 from multilineedit within w_exequery
end type
type gb_1 from groupbox within w_exequery
end type
end forward

global type w_exequery from Window
int X=14
int Y=32
int Width=3634
int Height=2380
boolean TitleBar=true
string Title="Query Testing"
long BackColor=81324524
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
mle_1 mle_1
gb_1 gb_1
end type
global w_exequery w_exequery

forward prototypes
public function integer wf_rdata (string as_string)
end prototypes

public function integer wf_rdata (string as_string);//	Declaracations
string error_syntaxfromSQL, error_create
string new_sql, new_syntax
integer il_colcount, il_idx

//	Assignment

dw_1.reset()
new_sql = as_string
new_syntax = SQLCA.SyntaxFromSQL(new_sql,'Style(Type=Grid) DataWindow(color=79741120)', error_syntaxfromSQL)

IF LenA(error_syntaxfromSQL) > 0 THEN
	// Display errors
	mle_1.Text = error_syntaxfromSQL
ELSE
	// Generate new DataWindow
	dw_1.Create(new_syntax, error_create)
	IF LenA(error_create) > 0 THEN
		mle_1.Text = error_create
	END IF
END IF

dw_1.SetTransObject(SQLCA)
il_colcount = integer(dw_1.describe('datawindow.column.count'))
for il_idx = 1 to il_colcount
	dw_1.modify('#'+trim(string(il_idx))+".tabsequence=0")
next 

dw_1.Retrieve()
if dw_1.rowcount() > 0 then 
	dw_1.title = "Total Rows : "+string(dw_1.rowcount())
else
	dw_1.title = ''
end if 
return 0 

end function

on w_exequery.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.mle_1=create mle_1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.dw_1,&
this.cb_1,&
this.mle_1,&
this.gb_1}
end on

on w_exequery.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.gb_1)
end on

type cb_3 from commandbutton within w_exequery
int X=3241
int Y=144
int Width=343
int Height=144
int TabOrder=20
string Text="Table List"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_rdata("select name from dbo.sysobjects where type = 'U' order by name")

end event

type cb_2 from commandbutton within w_exequery
int X=3241
int Y=316
int Width=343
int Height=144
int TabOrder=30
string Text="&Clear"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;mle_1.text = ""
wf_rdata("select ''")
end event

type dw_1 from datawindow within w_exequery
int X=23
int Y=680
int Width=3543
int Height=1532
string DataObject="dw_query"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)

end event

type cb_1 from commandbutton within w_exequery
int X=3241
int Y=484
int Width=343
int Height=144
int TabOrder=20
string Text="&Execute"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if mle_1.text > '' then 
	wf_rdata(mle_1.text)
else
	Messagebox("System Message","Please enter a valid query and then press execute button")
	mle_1.setfocus()
end if 	
end event

type mle_1 from multilineedit within w_exequery
int X=32
int Y=144
int Width=3168
int Height=484
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

type gb_1 from groupbox within w_exequery
int X=14
int Y=64
int Width=3214
int Height=600
string Text="Query"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=81324524
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

