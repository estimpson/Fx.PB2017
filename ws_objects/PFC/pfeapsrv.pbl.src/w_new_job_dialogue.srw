$PBExportHeader$w_new_job_dialogue.srw
forward
global type w_new_job_dialogue from w_response
end type
type lv_type from listview within w_new_job_dialogue
end type
type cb_cancel from commandbutton within w_new_job_dialogue
end type
type cb_ok from commandbutton within w_new_job_dialogue
end type
type gb_1 from groupbox within w_new_job_dialogue
end type
end forward

global type w_new_job_dialogue from w_response
int X=1056
int Y=484
int Width=1385
int Height=496
boolean TitleBar=true
string Title="New Job"
long BackColor=76585128
lv_type lv_type
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_new_job_dialogue w_new_job_dialogue

type variables
private:

constant integer	personal = 1
constant integer	client = 2
constant integer	server = 3

n_cst_powerobjectparm	in_cst_parm

end variables

on w_new_job_dialogue.create
int iCurrent
call super::create
this.lv_type=create lv_type
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_type
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.gb_1
end on

on w_new_job_dialogue.destroy
call super::destroy
destroy(this.lv_type)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event open;call super::open;
//	declarations
n_cst_dialogue	ln_cst_dialogue

//	check powerobjectparm exists.
if not isvalid ( message.powerobjectparm ) then
	closewithreturn ( this, ln_cst_dialogue.parmerror )
	return
end if

//	check powerobjectparm is correct type.
if message.powerobjectparm.typeof ( ) <> nonvisualobject! then
	closewithreturn ( this, ln_cst_dialogue.parmerror )
	return
end if
in_cst_parm = message.powerobjectparm

//	set title if passed.
if not isnull ( in_cst_parm ) then
	title = in_cst_parm.of_getitem ( "Title" )
end if
end event

event timer;
integer			random
listviewitem	llvi_test

lv_type.getitem ( 1, llvi_test )
random = rand ( 10 )
llvi_test.itemx += 2 * ( random - 5 )
if llvi_test.itemx < 0 then llvi_test.itemx = 0
random = rand ( 10 )
llvi_test.itemy += 2 * ( random - 5 )
if llvi_test.itemy < 0 then llvi_test.itemx = 0
lv_type.setitem ( 1, llvi_test )
end event

type lv_type from listview within w_new_job_dialogue
event ue_constructor ( )
int X=46
int Y=88
int Width=997
int Height=260
int TabOrder=30
boolean Border=false
boolean FixedLocations=true
boolean Scrolling=false
string Item[]={"Personal",&
"Client",&
"Server"}
int ItemPictureIndex[]={1,&
2,&
3}
string LargePictureName[]={"picture!",&
"structure!",&
"structure5!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
string SmallPictureName[]={"picture!",&
"sturctue!",&
"structure5!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="ms sans serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_constructor;
listviewitem	llvi_item [ 3 ]

//	fix list view item locations.
getitem ( 1, llvi_item [ 1 ] )
getitem ( 2, llvi_item [ 2 ] )
getitem ( 3, llvi_item [ 3 ] )

llvi_item [ 2 ].itemx = 300 + llvi_item [ 1 ].itemx
llvi_item [ 2 ].itemy = llvi_item [ 1 ].itemy

llvi_item [ 3 ].itemx = 600 + llvi_item [ 1 ].itemx
llvi_item [ 3 ].itemy = llvi_item [ 1 ].itemy

setitem ( 2, llvi_item [ 2 ] )
setitem ( 3, llvi_item [ 3 ] )

end event

event itemchanged;
//	Enable ok button.
cb_ok.enabled = true

//	Record selected type.
in_cst_parm.of_SetItem ( "Type", index )

end event

event doubleclicked;
//	Trigger ok button click.
if cb_ok.enabled then
	cb_ok.trigger event clicked ( )
end if

end event

event constructor;
//	fix item positions.
post event ue_constructor ( )
end event

type cb_cancel from commandbutton within w_new_job_dialogue
int X=1102
int Y=144
int Width=247
int Height=84
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="ms sans serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Declarations.
n_cst_dialogue	lnv_Dialogue

//	Close with return.
CloseWithReturn ( parent, lnv_Dialogue.CANCELLED )

end event

type cb_ok from commandbutton within w_new_job_dialogue
int X=1102
int Y=44
int Width=247
int Height=84
int TabOrder=20
boolean Enabled=false
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="ms sans serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
//	Declarations.
n_cst_dialogue	lnv_Dialogue

//	Close with return.
CloseWithReturn ( parent, lnv_Dialogue.VALID )

end event

type gb_1 from groupbox within w_new_job_dialogue
int X=18
int Y=20
int Width=1051
int Height=340
int TabOrder=10
string Text="Type"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="ms sans serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

