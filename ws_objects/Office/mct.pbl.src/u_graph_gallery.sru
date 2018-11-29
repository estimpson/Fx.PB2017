$PBExportHeader$u_graph_gallery.sru
$PBExportComments$Gallery of graph types
forward
global type u_graph_gallery from UserObject
end type
type p_gallery from picture within u_graph_gallery
end type
type st_1 from statictext within u_graph_gallery
end type
type cb_ok from commandbutton within u_graph_gallery
end type
type cb_cancel from commandbutton within u_graph_gallery
end type
type mle_1 from multilineedit within u_graph_gallery
end type
end forward

global type u_graph_gallery from UserObject
int Width=2219
int Height=1101
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event gallery_ok pbm_custom01
event gallery_cancel pbm_custom02
p_gallery p_gallery
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
mle_1 mle_1
end type
global u_graph_gallery u_graph_gallery

type variables
Integer	ii_Row = 0, ii_Col = 0
String	is_GraphType

end variables

forward prototypes
public function integer uf_query_gallery (ref integer ai_row, ref integer ai_col, ref string as_type)
end prototypes

public function integer uf_query_gallery (ref integer ai_row, ref integer ai_col, ref string as_type);// integer Function UF_QUERY_GALLERY (int a_row, int a_col)

//	Returns current values of ui_row and ui_col 
// in ai_Row and ai_Col, respectively

// Returns +1 if current row and column are valid, 0 if not valid

ai_Row = ii_Row
ai_Col = ii_Col

If ii_Row = 2 And ii_Col = 6 Then
	Return 0		
ElseIf ii_Row < 1 Or ii_Col < 1 Then
	Return 0
Else
	as_Type = is_GraphType
	Return 1
End If

end function

event constructor;p_gallery.width = mle_1.width - 20
p_gallery.height = mle_1.height - 20

end event

on u_graph_gallery.create
this.p_gallery=create p_gallery
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.mle_1=create mle_1
this.Control[]={ this.p_gallery,&
this.st_1,&
this.cb_ok,&
this.cb_cancel,&
this.mle_1}
end on

on u_graph_gallery.destroy
destroy(this.p_gallery)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.mle_1)
end on

type p_gallery from picture within u_graph_gallery
int X=25
int Y=39
int Width=1793
int Height=993
string PictureName="grgallry.bmp"
end type

event clicked;// Clicked script for P_GALLERY

Constant Integer		iCOLWIDTH = 287, iROWHEIGHT = 308
Integer	li_X, li_Y, li_TextX, li_TextY
String	ls_Title, &
			ls_Titles1[6] = {"Area", "Bar", "Column", "Line", "Pie", "Scatter"}, &
			ls_Titles3[6] = {"Bar", "Column", "Bar", "Column", "Bar", "Column"}, &
			ls_GraphType[6,3] = { &
				"areagraph","bargraph","colgraph","linegraph","piegraph","scattergraph",&
				"area3d","bar3dgraph","col3dgraph","line3d","pie3d","error",&
				"barstackgraph","colstackgraph","bar3dobjgraph","col3dobjgraph",&
				"barstack3dobjgraph","colstack3dobjgraph"}						

li_X = This.PointerX()
li_Y = This.PointerY()
If li_X < 25 or li_X > 1747 or li_Y < 30 or li_Y > 954 Then
	st_1.Hide()
	Beep(1)
	Return
End If

ii_Col = ((li_X - 25) / iCOLWIDTH) + 1
ii_Row = ((li_Y - 30) / iROWHEIGHT) + 1

If ii_Row = 3 Then
	ls_Title = ls_Titles3[ii_Col]
Else
	ls_Title = ls_Titles1[ii_Col]
End If

li_TextY = (ii_Row * iROWHEIGHT) + ((ii_Row - 1) * 10)

st_1.Text = ls_Title
li_TextX = This.x + ((ii_Col - 1) * iCOLWIDTH) + 75
li_TextY = li_TextY - This.y

st_1.Hide ()
If ii_Row = 2 And ii_Col = 6 Then
	Beep (1)			// Only 5 entries in Row 2 (no 3D Scatter)
Else
	st_1.Move (li_TextX, li_TextY)
	st_1.Show ()
End If

is_GraphType = ls_GraphType[ii_Col, ii_Row]

end event

on doubleclicked;TriggerEvent (cb_ok, clicked!)
end on

type st_1 from statictext within u_graph_gallery
int X=1860
int Y=861
int Width=203
int Height=68
boolean Visible=false
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
long TextColor=16777215
long BackColor=8388608
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within u_graph_gallery
int X=1913
int Y=81
int Width=260
int Height=109
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for CB_OK

Parent.TriggerEvent ("gallery_ok")
end on

type cb_cancel from commandbutton within u_graph_gallery
int X=1913
int Y=215
int Width=260
int Height=109
int TabOrder=10
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for CB_CANCEL

Parent.TriggerEvent ("gallery_cancel")
end on

type mle_1 from multilineedit within u_graph_gallery
int X=11
int Y=33
int Width=1814
int Height=1009
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

