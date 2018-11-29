$PBExportHeader$w_report_properties.srw
forward
global type w_report_properties from window
end type
type sle_external_label from singlelineedit within w_report_properties
end type
type sle_object from singlelineedit within w_report_properties
end type
type sle_library from singlelineedit within w_report_properties
end type
type st_3 from statictext within w_report_properties
end type
type st_2 from statictext within w_report_properties
end type
type st_1 from statictext within w_report_properties
end type
type cbx_compiled from checkbox within w_report_properties
end type
type rb_bartender from radiobutton within w_report_properties
end type
type rb_window from radiobutton within w_report_properties
end type
type rb_datawindow from radiobutton within w_report_properties
end type
type cb_add_report from commandbutton within w_report_properties
end type
type cb_external_label from commandbutton within w_report_properties
end type
type cb_library from commandbutton within w_report_properties
end type
type cb_object from commandbutton within w_report_properties
end type
type cb_ok from commandbutton within w_report_properties
end type
type cb_cancel from commandbutton within w_report_properties
end type
type dw_report_properties_top from datawindow within w_report_properties
end type
type dw_report_properties_bottom from datawindow within w_report_properties
end type
end forward

global type w_report_properties from window
integer x = 832
integer y = 360
integer width = 2085
integer height = 1948
boolean titlebar = true
string title = "Report Setup"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
sle_external_label sle_external_label
sle_object sle_object
sle_library sle_library
st_3 st_3
st_2 st_2
st_1 st_1
cbx_compiled cbx_compiled
rb_bartender rb_bartender
rb_window rb_window
rb_datawindow rb_datawindow
cb_add_report cb_add_report
cb_external_label cb_external_label
cb_library cb_library
cb_object cb_object
cb_ok cb_ok
cb_cancel cb_cancel
dw_report_properties_top dw_report_properties_top
dw_report_properties_bottom dw_report_properties_bottom
end type
global w_report_properties w_report_properties

type variables
Private:

string	is_LastLibrary
string	is_LastDatasource
string	is_LastXLabel
end variables

forward prototypes
public subroutine wf_pop_report ()
end prototypes

public subroutine wf_pop_report ();//STRING 	l_s_report, &
//			l_s_temp
//
//l_s_temp = dw_general.Object.report_library_report.values + '/'
//
//DECLARE mad_report_list CURSOR FOR 
//SELECT  report_list.report     
//FROM report_list ;
//
//OPEN  mad_report_list;
//
//FETCH mad_report_list INTO :l_s_report ;
//
//DO 
//	
//	IF POS ( l_s_temp , l_s_report ) = 0 THEN
//   	l_s_temp = l_s_temp + l_s_report+ '~t' + l_s_report + '/'
//	END IF
//	
//	FETCH mad_report_list INTO :l_s_report ;
//	
//LOOP WHILE (SQLCA.SQLCODE = 0 )
//
//CLOSE mad_report_list ;
//
//l_s_report = "report_library_report.values='" + l_s_temp + "'" 
//
//l_s_report = dw_general.modify ( l_s_report )
//
//
//
//	
//
end subroutine

event open;string	ls_Name
string	ls_Report
string	ls_Check
string	ls_Type

st_generic_structure lstr_generic_structure		

lstr_generic_structure = message.powerobjectparm
ls_Check =  lstr_generic_structure.value3

//	Share data between top and bottom.
if dw_report_properties_top.ShareData ( dw_report_properties_bottom ) = -1 then
	MessageBox ( monsys.msg_title, "Share data failed with bottom." )
end if

//	If in edit mode...
if ls_Check = 'E' then
	ls_Name = lstr_generic_structure.value1 	
	ls_Report = lstr_generic_structure.value2
	//	Retrieve report properties.
	if dw_report_properties_top.Retrieve ( ls_Name, ls_Report ) > 0 then
		ls_Type = dw_report_properties_top.object.report_library_type [ 1 ]
		//	Set type and class radiobuttons.
		choose case ls_Type
			case 'C'
				rb_datawindow.Checked = true
				cbx_compiled.Checked = true
				rb_datawindow.trigger event clicked ( )
			case 'D'
				rb_datawindow.Checked = true
				cbx_compiled.Checked = false
				rb_datawindow.trigger event clicked ( )
			case 'W'
				rb_window.Checked = true
				rb_window.trigger event clicked ( )
			case 'B'
				rb_bartender.Checked = true
				rb_bartender.trigger event clicked ( )
		end choose
   end if
else
	dw_report_properties_top.Retrieve ( "", "" )
end if
end event

on w_report_properties.create
this.sle_external_label=create sle_external_label
this.sle_object=create sle_object
this.sle_library=create sle_library
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cbx_compiled=create cbx_compiled
this.rb_bartender=create rb_bartender
this.rb_window=create rb_window
this.rb_datawindow=create rb_datawindow
this.cb_add_report=create cb_add_report
this.cb_external_label=create cb_external_label
this.cb_library=create cb_library
this.cb_object=create cb_object
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_report_properties_top=create dw_report_properties_top
this.dw_report_properties_bottom=create dw_report_properties_bottom
this.Control[]={this.sle_external_label,&
this.sle_object,&
this.sle_library,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cbx_compiled,&
this.rb_bartender,&
this.rb_window,&
this.rb_datawindow,&
this.cb_add_report,&
this.cb_external_label,&
this.cb_library,&
this.cb_object,&
this.cb_ok,&
this.cb_cancel,&
this.dw_report_properties_top,&
this.dw_report_properties_bottom}
end on

on w_report_properties.destroy
destroy(this.sle_external_label)
destroy(this.sle_object)
destroy(this.sle_library)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cbx_compiled)
destroy(this.rb_bartender)
destroy(this.rb_window)
destroy(this.rb_datawindow)
destroy(this.cb_add_report)
destroy(this.cb_external_label)
destroy(this.cb_library)
destroy(this.cb_object)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_report_properties_top)
destroy(this.dw_report_properties_bottom)
end on

type sle_external_label from singlelineedit within w_report_properties
integer x = 407
integer y = 1312
integer width = 1010
integer height = 68
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

type sle_object from singlelineedit within w_report_properties
integer x = 407
integer y = 1224
integer width = 1010
integer height = 68
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

event modified;//	Set value in updateable datawindow.
dw_report_properties_top.object.report_library_object_name [ 1 ] = text
end event

type sle_library from singlelineedit within w_report_properties
integer x = 407
integer y = 1136
integer width = 1010
integer height = 68
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

event modified;//	Set value in updateable datawindow.
dw_report_properties_top.object.report_library_library_name [ 1 ] = text
end event

type st_3 from statictext within w_report_properties
integer x = 82
integer y = 1224
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Object Name:"
long bordercolor = 3680296
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_properties
integer x = 82
integer y = 1136
integer width = 306
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Library Name:"
long bordercolor = 3680296
boolean focusrectangle = false
end type

type st_1 from statictext within w_report_properties
integer x = 82
integer y = 1312
integer width = 302
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "External Label Format:"
long bordercolor = 3680296
boolean focusrectangle = false
end type

type cbx_compiled from checkbox within w_report_properties
integer x = 530
integer y = 784
integer width = 398
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 78682240
string text = "Compiled"
boolean checked = true
boolean lefttext = true
end type

event clicked;string	ls_Type

//	Disable & Clear / Enable & Restore 'library name' controls.
if checked then
	sle_library.enabled = false
	cb_library.enabled = false
	cb_object.enabled = false
	is_LastLibrary = sle_library.Text
	sle_library.Text = ""
else
	sle_library.enabled = true
	cb_library.enabled = true
	cb_object.enabled = true
	sle_library.Text = is_LastLibrary
end if

//	Set report type approriately.
if rb_datawindow.checked then
	if checked then
		ls_Type = 'C'
	else
		ls_Type = 'D'
	end if
elseif rb_window.checked then
	ls_Type = 'W'
else
	ls_Type = 'B'
end if
dw_report_properties_top.object.report_library_type [ 1 ] = ls_Type
end event

type rb_bartender from radiobutton within w_report_properties
integer x = 82
integer y = 928
integer width = 375
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 79741120
string text = "Bartender"
boolean lefttext = true
end type

event clicked;//	Enable datasource controls.
sle_external_label.enabled = true
cb_external_label.enabled = true
sle_external_label.text = is_LastXLabel

//	Default window name.
if sle_object.text = "" then
	sle_object.text = "w_bartender"
	sle_object.enabled = false
	sle_object.trigger event modified ( )
end if

//  Check and disable compiled control.
cbx_compiled.Checked = true
cbx_compiled.Enabled = false
cbx_compiled.trigger event clicked ( )
end event

type rb_window from radiobutton within w_report_properties
integer x = 82
integer y = 856
integer width = 375
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 79741120
string text = "Window"
boolean lefttext = true
end type

event clicked;//	Disable external datasource controls.
sle_external_label.enabled = false
is_LastXLabel = sle_external_label.text
sle_external_label.text = ""
cb_external_label.enabled = false

//  Check and disable compiled control.
cbx_compiled.checked = true
cbx_compiled.Enabled = false
cbx_compiled.trigger event clicked ( )
end event

type rb_datawindow from radiobutton within w_report_properties
integer x = 82
integer y = 784
integer width = 375
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 37234728
long backcolor = 79741120
string text = "DataWindow"
boolean checked = true
boolean lefttext = true
end type

event clicked;//	Disable external datasource controls.
sle_external_label.enabled = false
is_LastXLabel = sle_external_label.text
sle_external_label.text = ""
cb_external_label.enabled = false

//  Enable compiled control and click it.
cbx_compiled.Enabled = true
cbx_compiled.trigger event clicked ( )
end event

type cb_add_report from commandbutton within w_report_properties
integer x = 1381
integer y = 152
integer width = 320
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Report List..."
end type

event clicked;Open ( w_report_list )
dw_report_properties_top.trigger event constructor ( )
end event

type cb_external_label from commandbutton within w_report_properties
integer x = 1454
integer y = 1320
integer width = 247
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Browse..."
end type

event clicked;string	ls_DocName
string	ls_Named

integer	li_Value

li_Value = GetFileOpenName ( "Select Fusion Label Format", ls_DocName, ls_Named, "QDF", "Label Matrix Format (*.QDF),*.QDF" )
sle_external_label.Text = ls_DocName
sle_external_label.trigger event modified ( )
end event

type cb_library from commandbutton within w_report_properties
integer x = 1454
integer y = 1124
integer width = 247
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Browse..."
end type

event clicked;string	ls_DocName
string	ls_Named

integer	li_Value

li_Value = GetFileOpenName ( "Select PowerBuilder Library", ls_DocName, ls_Named, "PBL", "PowerBuilder Library file (*.PBL),*.PBL" )
sle_library.Text = ls_DocName
sle_library.trigger event modified ( )
end event

type cb_object from commandbutton within w_report_properties
integer x = 1454
integer y = 1220
integer width = 247
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Browse..."
end type

event clicked;string	ls_Object
string	ls_Value
		 
st_generic_structure lst_Parm

lst_Parm.value1 = sle_library.Text
lst_Parm.value2 = 'dat'
openwithparm ( w_select_object, lst_Parm )
ls_Value = message.stringparm
sle_Object.Text = ls_Value
sle_Object.trigger event modified ( )
end event

type cb_ok from commandbutton within w_report_properties
integer x = 1774
integer y = 28
integer width = 247
integer height = 84
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;//	Declarations
string	ls_Name
string	ls_Report
string	ls_ObjectName
string	ls_LibraryName
string	ls_DataSource
string	ls_ExternalFormat
string	ls_Type

//	Accept text entries
ls_ExternalFormat = sle_external_label.Text
dw_report_properties_bottom.AcceptText ( )
dw_report_properties_top.AcceptText ( )

//	Get data for validation checks.
if dw_report_properties_top.RowCount ( ) > 0 then
	ls_Name = dw_report_properties_top.object.report_library_name [ 1 ]
	ls_Report = dw_report_properties_top.object.report_library_report [ 1 ]
	ls_ObjectName = dw_report_properties_top.object.report_library_object_name [ 1 ]
	ls_LibraryName = dw_report_properties_top.object.report_library_library_name [ 1 ]
	ls_Type = dw_report_properties_top.object.report_library_type [ 1 ]
end if

//	In order for validation checks to work properly,
//	default data must not have nulls for checked fields.
//	Validate data.
if ls_Name = '' then
	MessageBox ( monsys.msg_title, "Report name cannot be left blank!", StopSign! )
	dw_report_properties_top.SetFocus ( )
	dw_report_properties_top.SetColumn ( "report_library_name" )
	return
end if

if ls_Name = '' then
	MessageBox ( monsys.msg_title, "Report name cannot be left blank!", StopSign! )
	dw_report_properties_top.SetFocus ( )
	dw_report_properties_top.SetColumn ( "report_library_name" )
	return
end if

if ls_ObjectName = '' then
	MessageBox ( monsys.msg_title, "Object name cannot be left blank!", StopSign! )
	sle_object.SetFocus ( )
	return
end if

if ls_LibraryName = '' and ls_Type = 'D' then
	MessageBox ( monsys.msg_title, "Library name cannot be left blank!", StopSign! )
	sle_library.enabled = true
	cb_library.enabled = true
	sle_library.SetFocus ( )
	return
end if

if ls_ExternalFormat = '' and ls_Type = 'B' then
	MessageBox ( monsys.msg_title, "External Format cannot be left blank!", StopSign! )
	sle_external_label.enabled = true
	cb_external_label.enabled = true
	sle_external_label.SetFocus ( )
	return
end if

//	Update data and commit.
if dw_report_properties_top.Update ( true, false ) = 1 then
	SQLCA.uf_commit ( )
else
	SQLCA.uf_rollback ( )
end if

CloseWithReturn ( parent, 1 )
end event

type cb_cancel from commandbutton within w_report_properties
integer x = 1774
integer y = 120
integer width = 247
integer height = 84
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( parent, -1 )
end event

type dw_report_properties_top from datawindow within w_report_properties
integer x = 23
integer width = 1733
integer height = 712
integer taborder = 10
string dataobject = "d_report_properties_top"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild	ldwc_report

SetTransObject ( SQLCA )

if GetChild ( "report_library_report", ldwc_report ) = 1 then
	ldwc_report.SetTransObject ( SQLCA )
	ldwc_report.Retrieve ( )
end if
end event

event itemchanged;//	Declarations
string	ls_ReportName
string	ls_Report

integer	li_CurrentColumn

DataStore	lds_ReportLibrary

//	Initializations
lds_ReportLibrary = create DataStore
lds_ReportLibrary.DataObject = "d_report_properties"
lds_ReportLibrary.SetTransObject ( SQLCA )

//  If report name or type modified then try retrieve information for new 
choose case dwo.Name
	case 'report_library_name'
		//	Get the report name and report.
		ls_ReportName = data
		ls_Report = object.report_library_report [ 1 ]
		
		//	Retrieve data to see if report definition already exists.
		if lds_ReportLibrary.Retrieve ( ls_ReportName, ls_Report ) > 0 then
			//	Prompt to change data or to set focus on report_library_name
			if MessageBox ( monsys.msg_title, "Report definition already exists for " + ls_ReportName + ".  Retrieving existing definition.", Question!, OkCancel! ) = 1 then
				li_CurrentColumn = GetColumn ( )
				Retrieve ( ls_ReportName, ls_Report )
				SetColumn ( li_CurrentColumn )
			else
				destroy lds_ReportLibrary
				return 1
			end if
		end if
	case 'report_library_report'
		//	Get the report name and report.
		ls_ReportName = object.report_library_name [ 1 ]
		ls_Report = data
		
		//	Retrieve data to see if report definition already exists.
		if lds_ReportLibrary.Retrieve ( ls_ReportName, ls_Report ) > 0 then
			//	Prompt to change data or to set focus on report_library_name
			if MessageBox ( monsys.msg_title, "Report definition already exists for " + ls_Report + ".  Retrieving existing definition.", Question!, OkCancel! ) = 1 then
				li_CurrentColumn = GetColumn ( )
				Retrieve ( ls_ReportName, ls_Report )
				SetColumn ( li_CurrentColumn )
			else
				destroy lds_ReportLibrary
				object.report_library_report [ 1 ] = ""
				return 1
			end if
		end if
end choose

destroy lds_ReportLibrary
end event

event itemerror;//	Suppress error messages.
Return 1
end event

event retrieveend;//	Declarations
string	ls_ReportName
string	ls_Report

if rowcount > 0 then
	ls_ReportName = object.report_library_name [ 1 ]
	ls_Report = object.report_library_report [ 1 ]
	
	is_LastLibrary = object.report_library_library_name [ 1 ]
	sle_library.text = is_LastLibrary
	sle_object.text = object.report_library_object_name [ 1 ]
else
	InsertRow ( 1 )
	object.report_library_library_name [ 1 ] = ""
	object.report_library_preview [ 1 ] = "N"
	object.report_library_print_setup [ 1 ] = "N"
	object.report_library_copies [ 1 ] = 1
end if
end event

type dw_report_properties_bottom from datawindow within w_report_properties
integer x = 23
integer width = 1733
integer height = 1820
integer taborder = 150
string dataobject = "d_report_properties_bottom"
boolean border = false
boolean livescroll = true
end type

event constructor;SetTransObject ( SQLCA )
end event

