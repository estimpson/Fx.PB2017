$PBExportHeader$u_list_of_eligible_po_for_dropship.sru
forward
global type u_list_of_eligible_po_for_dropship from UserObject
end type
type st_2 from statictext within u_list_of_eligible_po_for_dropship
end type
type cb_2 from commandbutton within u_list_of_eligible_po_for_dropship
end type
type cb_1 from commandbutton within u_list_of_eligible_po_for_dropship
end type
type st_1 from statictext within u_list_of_eligible_po_for_dropship
end type
type dw_list_of_po from datawindow within u_list_of_eligible_po_for_dropship
end type
end forward

global type u_list_of_eligible_po_for_dropship from UserObject
int Width=1554
int Height=984
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabBackColor=67108864
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_list_of_po dw_list_of_po
end type
global u_list_of_eligible_po_for_dropship u_list_of_eligible_po_for_dropship

type variables
Window wHostWindow

Long iPO = 0

String szPlant
end variables

forward prototypes
public subroutine uf_setup (ref window wwin)
end prototypes

public subroutine uf_setup (ref window wwin);wHostWindow	= wWin

dw_list_of_po.SetTransObject(sqlca)

end subroutine

on u_list_of_eligible_po_for_dropship.create
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_list_of_po=create dw_list_of_po
this.Control[]={this.st_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dw_list_of_po}
end on

on u_list_of_eligible_po_for_dropship.destroy
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_list_of_po)
end on

type st_2 from statictext within u_list_of_eligible_po_for_dropship
int X=110
int Y=736
int Width=1298
int Height=64
boolean Enabled=false
string Text="Double click to add to highlighted P.O."
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

type cb_2 from commandbutton within u_list_of_eligible_po_for_dropship
int X=1061
int Y=816
int Width=357
int Height=108
int TabOrder=30
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wHostWindow.TriggerEvent("cancel_po_creation")
end on

type cb_1 from commandbutton within u_list_of_eligible_po_for_dropship
int X=128
int Y=816
int Width=357
int Height=108
int TabOrder=20
string Text="Create New"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;iPO	= 0
wHostWindow.TriggerEvent("create_po")
end on

type st_1 from statictext within u_list_of_eligible_po_for_dropship
int X=421
int Y=48
int Width=686
int Height=72
boolean Enabled=false
string Text="Eligible P.O. for selection"
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

type dw_list_of_po from datawindow within u_list_of_eligible_po_for_dropship
int X=91
int Y=128
int Width=1353
int Height=592
int TabOrder=10
string DataObject="dw_active_po_per_vendor"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on doubleclicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	iPO		= this.GetItemNumber(iRow, "po_number")
	szPlant	= this.GetItemString(iRow, "plant")
	wHostWindow.TriggerEvent("create_po")
End If
end on

on clicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	iPO	= 0
	this.SelectRow(0, FALSE)
	this.SelectRow(iRow, TRUE)

End If
end on

