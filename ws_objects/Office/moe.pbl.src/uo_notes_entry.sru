$PBExportHeader$uo_notes_entry.sru
forward
global type uo_notes_entry from UserObject
end type
type st_title from statictext within uo_notes_entry
end type
type dw_notes from datawindow within uo_notes_entry
end type
type cb_2 from commandbutton within uo_notes_entry
end type
type cb_1 from commandbutton within uo_notes_entry
end type
type cb_notes_back from commandbutton within uo_notes_entry
end type
end forward

global type uo_notes_entry from UserObject
int Width=1299
int Height=641
long BackColor=12632256
st_title st_title
dw_notes dw_notes
cb_2 cb_2
cb_1 cb_1
cb_notes_back cb_notes_back
end type
global uo_notes_entry uo_notes_entry

forward prototypes
public subroutine wf_set_dw (string szdataobject)
public subroutine wf_uo_attribs (string szTitle, boolean bVisible)
end prototypes

public subroutine wf_set_dw (string szdataobject);dw_notes.DataObject = szDataObject
dw_notes.SetTransObject ( sqlca )
dw_notes.Show ( )

end subroutine

public subroutine wf_uo_attribs (string szTitle, boolean bVisible);If bVisible Then
	st_title.Text = szTitle
	This.Show ( ) 
Else
	This.Hide ( )
End if
end subroutine

on uo_notes_entry.create
this.st_title=create st_title
this.dw_notes=create dw_notes
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_notes_back=create cb_notes_back
this.Control[]={ this.st_title,&
this.dw_notes,&
this.cb_2,&
this.cb_1,&
this.cb_notes_back}
end on

on uo_notes_entry.destroy
destroy(this.st_title)
destroy(this.dw_notes)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_notes_back)
end on

type st_title from statictext within uo_notes_entry
int X=19
int Y=17
int Width=1244
int Height=65
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554560
long BackColor=12632256
long BorderColor=128
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_notes from datawindow within uo_notes_entry
int X=55
int Y=81
int Width=1189
int Height=417
int TabOrder=20
boolean Visible=false
boolean Border=false
boolean LiveScroll=true
end type

type cb_2 from commandbutton within uo_notes_entry
int X=714
int Y=513
int Width=275
int Height=113
int TabOrder=40
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_uo_attribs ( "", False )
end on

type cb_1 from commandbutton within uo_notes_entry
int X=257
int Y=513
int Width=275
int Height=113
int TabOrder=30
string Text="&Ok"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If dw_notes.Update ( ) = -1 Then
	RollBack ;
Else
	Commit ;
	//w_orders_detail_test.bHeaderNotes = True
End if

wf_uo_attribs ( "", False )


end on

type cb_notes_back from commandbutton within uo_notes_entry
int Width=1299
int Height=641
int TabOrder=10
boolean Enabled=false
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

