$PBExportHeader$w_open_job_dialogue.srw
$PBExportComments$(PFD)
forward
global type w_open_job_dialogue from w_response
end type
type lv_job_names from listview within w_open_job_dialogue
end type
type lv_type from listview within w_open_job_dialogue
end type
type cb_cancel from commandbutton within w_open_job_dialogue
end type
type cb_ok from commandbutton within w_open_job_dialogue
end type
type gb_1 from groupbox within w_open_job_dialogue
end type
end forward

global type w_open_job_dialogue from w_response
int X=1056
int Y=484
int Width=1394
int Height=1448
boolean TitleBar=true
string Title="new job"
long BackColor=78682240
lv_job_names lv_job_names
lv_type lv_type
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_open_job_dialogue w_open_job_dialogue

type variables
private:

constant integer	personal = 1
constant integer	client = 2
constant integer	server = 3

protected:
n_cst_powerobjectparm	in_cst_parm
end variables

on w_open_job_dialogue.create
int iCurrent
call super::create
this.lv_job_names=create lv_job_names
this.lv_type=create lv_type
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_job_names
this.Control[iCurrent+2]=this.lv_type
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.gb_1
end on

on w_open_job_dialogue.destroy
call super::destroy
destroy(this.lv_job_names)
destroy(this.lv_type)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event open;call super::open;
//	declarations
n_cst_dialogue	ln_cst_dialogue

//	center window
//	[done by w_response]

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
	title = IsNull ( in_cst_parm.of_getitem ( "Title" ), "None" )
end if

end event

type lv_job_names from listview within w_open_job_dialogue
int X=18
int Y=400
int Width=1330
int Height=932
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
ListViewView View=ListViewReport!
string LargePictureName[]={"window!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
string SmallPictureName[]={"window!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="ms sans serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;
//	Add columns to listview.
addcolumn ( "Name", left!, 400 )
addcolumn ( "Description", left!, 1000 )

end event

event itemchanged;
//	declarations
listviewitem	ltvi_selected

//	getitem
if getitem ( index, ltvi_selected ) <> 1 then
	return
end if

//	enable ok button.
cb_ok.enabled = true

//	record selection.
in_cst_parm.of_setitem ( "Name", ltvi_selected.label )
in_cst_parm.of_setitem ( "Description", ltvi_selected.data )
end event

event doubleclicked;
//	trigger ok button click.
if cb_ok.enabled then
	cb_ok.trigger event clicked ( )
end if
end event

type lv_type from listview within w_open_job_dialogue
event ue_constructor ( )
int X=46
int Y=88
int Width=997
int Height=228
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

//	Fix list view item locations.
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
//	declarations.
integer	li_jobcounter
integer	li_jobs
string	ls_job [ ]
string	ls_jobname
string	ls_jobdescription

listviewitem	llvi_job

n_cst_registry	incst_Registry

//	initialize.
llvi_job.pictureindex = 1

//	record selected type
in_cst_parm.of_setitem ( "Type", index )

//	build listbox.
lv_job_names.deleteitems ( )

choose case in_cst_parm.of_getitem ( "Type" )
	case personal
		registrykeys ( incst_Registry.CurrentUserJob, ls_job )
		li_jobs = upperbound ( ls_job )
		for li_jobcounter = 1 to li_jobs
			registryget ( incst_Registry.CurrentUserJob + "\" + string ( li_jobcounter ), "", regstring!, ls_jobname )
			registryget ( incst_Registry.CurrentUserJob + "\" + string ( li_jobcounter ), "description", regstring!, ls_jobdescription )
			llvi_job.label = ls_jobname + "~t" + ls_jobdescription
			llvi_job.data = ls_jobdescription
			lv_job_names.additem ( llvi_job )
		next
	case client
		registrykeys ( incst_Registry.LocalMachineJob, ls_job )
		li_jobs = upperbound ( ls_job )
		for li_jobcounter = 1 to li_jobs
			registryget ( incst_Registry.LocalMachineJob + "\" + string ( li_jobcounter ), "", regstring!, ls_jobname )
			registryget ( incst_Registry.LocalMachineJob + "\" + string ( li_jobcounter ), "description", regstring!, ls_jobdescription )
			llvi_job.label = ls_jobname + "~t" + ls_jobdescription
			llvi_job.data = ls_jobdescription
			lv_job_names.additem ( llvi_job )
		next
	case server
end choose

//	disable ok button until job is selected.
cb_ok.enabled = false

end event

event constructor;
//	Fix item positions.
post event ue_constructor ( )
end event

type cb_cancel from commandbutton within w_open_job_dialogue
int X=1102
int Y=144
int Width=247
int Height=84
int TabOrder=50
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
//	declarations.
n_cst_dialogue	ln_cst_dialogue

//	close with return.
closewithreturn ( parent, ln_cst_dialogue.cancelled )
end event

type cb_ok from commandbutton within w_open_job_dialogue
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
//	declarations.
n_cst_dialogue	ln_cst_dialogue

//	close with return.
closewithreturn ( parent, ln_cst_dialogue.valid )
end event

type gb_1 from groupbox within w_open_job_dialogue
int X=18
int Y=20
int Width=1051
int Height=344
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

