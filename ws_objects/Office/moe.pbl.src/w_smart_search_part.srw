$PBExportHeader$w_smart_search_part.srw
forward
global type w_smart_search_part from Window
end type
type cb_1 from commandbutton within w_smart_search_part
end type
type st_result from statictext within w_smart_search_part
end type
type st_1 from statictext within w_smart_search_part
end type
type dw_1 from datawindow within w_smart_search_part
end type
type sle_search from singlelineedit within w_smart_search_part
end type
end forward

global type w_smart_search_part from Window
int X=1
int Y=1
int Width=2940
int Height=1961
boolean TitleBar=true
string Title="Smart Search"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
st_result st_result
st_1 st_1
dw_1 dw_1
sle_search sle_search
end type
global w_smart_search_part w_smart_search_part

forward prototypes
public function string wf_get_where_clause (string szsearchstring)
end prototypes

public function string wf_get_where_clause (string szsearchstring);Long 		iCount = 1
Long 		iLen

String	szWord
String	cChar
String	szWhereClause

szSearchString	= Trim(szSearchString)
iLen				= LenA(szSearchString)
szWord			= ""
szWhereClause	= ""

Do while iCount <= iLen

	cChar	= MidA(szSearchString, iCount, 1)
	If cChar > ' ' then
		szWord	= szWord + cChar
	Else										//If this is a space
		If szWord > "" then
			If szWhereClause > "" then
				szWhereClause	= szWhereClause + " AND "
			End If

			szWhereClause		= szWhereClause + " NAME LIKE '%" + szWord + "%'"
			szWord	= ""
		End If
	End If

	iCount ++
Loop

If szWord > "" then
	If szWhereClause > "" then
		szWhereClause	= szWhereClause + " AND "
	End If
	szWhereClause		= szWhereClause + " NAME LIKE '%" + szWord + "%'"
End If

Return szWhereClause						
end function

on w_smart_search_part.create
this.cb_1=create cb_1
this.st_result=create st_result
this.st_1=create st_1
this.dw_1=create dw_1
this.sle_search=create sle_search
this.Control[]={ this.cb_1,&
this.st_result,&
this.st_1,&
this.dw_1,&
this.sle_search}
end on

on w_smart_search_part.destroy
destroy(this.cb_1)
destroy(this.st_result)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.sle_search)
end on

type cb_1 from commandbutton within w_smart_search_part
int X=2305
int Y=1277
int Width=247
int Height=109
int TabOrder=30
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type st_result from statictext within w_smart_search_part
int X=2140
int Y=181
int Width=421
int Height=73
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_smart_search_part
int X=330
int Y=113
int Width=677
int Height=57
boolean Enabled=false
string Text="Search Part by Description"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_smart_search_part
int X=334
int Y=333
int Width=2222
int Height=893
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type sle_search from singlelineedit within w_smart_search_part
int X=339
int Y=181
int Width=1093
int Height=89
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;String szErrors, szSQL_Syntax

szSQL_Syntax	= "SELECT PART, NAME FROM PART WHERE " + &
						wf_get_where_clause(this.text)

dw_1.Create(SyntaxFromSQL(SQLCA, szSQL_Syntax, 'form' , szErrors))
dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

st_result.text	= "Found: " + String(dw_1.RowCount())

end on

