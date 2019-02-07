HA$PBExportHeader$w_testrunwait.srw
forward
global type w_testrunwait from window
end type
type cb_1 from commandbutton within w_testrunwait
end type
type sle_exepath from singlelineedit within w_testrunwait
end type
type st_3 from statictext within w_testrunwait
end type
type st_2 from statictext within w_testrunwait
end type
type sle_verb from singlelineedit within w_testrunwait
end type
type cbx_terminate from checkbox within w_testrunwait
end type
type rb_minimized from radiobutton within w_testrunwait
end type
type rb_hidden from radiobutton within w_testrunwait
end type
type rb_maximized from radiobutton within w_testrunwait
end type
type rb_normal from radiobutton within w_testrunwait
end type
type cb_shellrun from commandbutton within w_testrunwait
end type
type cb_browse from commandbutton within w_testrunwait
end type
type sle_filename from singlelineedit within w_testrunwait
end type
type st_1 from statictext within w_testrunwait
end type
type cb_close from commandbutton within w_testrunwait
end type
type gb_1 from groupbox within w_testrunwait
end type
end forward

global type w_testrunwait from window
integer x = 101
integer y = 100
integer width = 1838
integer height = 1136
boolean titlebar = true
string title = "Run And Wait with Shell Execute"
boolean controlmenu = true
long backcolor = 79416533
cb_1 cb_1
sle_exepath sle_exepath
st_3 st_3
st_2 st_2
sle_verb sle_verb
cbx_terminate cbx_terminate
rb_minimized rb_minimized
rb_hidden rb_hidden
rb_maximized rb_maximized
rb_normal rb_normal
cb_shellrun cb_shellrun
cb_browse cb_browse
sle_filename sle_filename
st_1 st_1
cb_close cb_close
gb_1 gb_1
end type
global w_testrunwait w_testrunwait

type prototypes

end prototypes

type variables
n_runandwait in_rwait
String is_runtype

end variables

on w_testrunwait.create
this.cb_1=create cb_1
this.sle_exepath=create sle_exepath
this.st_3=create st_3
this.st_2=create st_2
this.sle_verb=create sle_verb
this.cbx_terminate=create cbx_terminate
this.rb_minimized=create rb_minimized
this.rb_hidden=create rb_hidden
this.rb_maximized=create rb_maximized
this.rb_normal=create rb_normal
this.cb_shellrun=create cb_shellrun
this.cb_browse=create cb_browse
this.sle_filename=create sle_filename
this.st_1=create st_1
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.sle_exepath,&
this.st_3,&
this.st_2,&
this.sle_verb,&
this.cbx_terminate,&
this.rb_minimized,&
this.rb_hidden,&
this.rb_maximized,&
this.rb_normal,&
this.cb_shellrun,&
this.cb_browse,&
this.sle_filename,&
this.st_1,&
this.cb_close,&
this.gb_1}
end on

on w_testrunwait.destroy
destroy(this.cb_1)
destroy(this.sle_exepath)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_verb)
destroy(this.cbx_terminate)
destroy(this.rb_minimized)
destroy(this.rb_hidden)
destroy(this.rb_maximized)
destroy(this.rb_normal)
destroy(this.cb_shellrun)
destroy(this.cb_browse)
destroy(this.sle_filename)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_testrunwait
integer x = 1426
integer y = 76
integer width = 334
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;String ls_fname, ls_msg
Long ll_rc

SetPointer(HourGlass!)

If sle_exepath.text = "" Then
	sle_exepath.SetFocus()
	MessageBox(this.text, "Exename is required!")
	Return
Else
	ls_fname = sle_exepath.text
End If

// set wait options
If cbx_terminate.checked Then
	in_rwait.of_set_options(True, 5)
End If

// run the process
CHOOSE CASE is_runtype
	CASE "rb_hidden"
		ll_rc = in_rwait.of_run(ls_fname, Hide!)
	CASE "rb_maximized"
		ll_rc = in_rwait.of_run(ls_fname, Maximized!)
	CASE "rb_minimized"
		ll_rc = in_rwait.of_run(ls_fname, Minimized!)
	CASE ELSE
		ll_rc = in_rwait.of_run(ls_fname, Normal!)
END CHOOSE

// check return code
CHOOSE CASE ll_rc
	CASE in_rwait.WAIT_COMPLETE
		ls_msg = "The process completed normally!"
	CASE in_rwait.WAIT_TIMEOUT
		ls_msg = "The process was terminated after 5 seconds!"
	CASE -1
		ls_msg = "The process was not created!"
	CASE ELSE
		ls_msg = "The process completed with return code: " + String(ll_rc)
END CHOOSE
MessageBox(ls_fname, ls_msg)

end event

type sle_exepath from singlelineedit within w_testrunwait
integer x = 37
integer y = 96
integer width = 1321
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "testcmd.bat"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_testrunwait
integer x = 37
integer y = 32
integer width = 421
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Program to run:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_testrunwait
integer x = 951
integer y = 448
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Shell Verb:"
boolean focusrectangle = false
end type

type sle_verb from singlelineedit within w_testrunwait
integer x = 951
integer y = 512
integer width = 407
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cbx_terminate from checkbox within w_testrunwait
integer x = 37
integer y = 928
integer width = 663
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Terminate after 5 seconds "
boolean lefttext = true
end type

type rb_minimized from radiobutton within w_testrunwait
integer x = 530
integer y = 720
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Minimized"
end type

event clicked;// set current run type
is_runtype = this.ClassName()

end event

type rb_hidden from radiobutton within w_testrunwait
integer x = 530
integer y = 788
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hidden"
end type

event clicked;// set current run type
is_runtype = this.ClassName()

end event

type rb_maximized from radiobutton within w_testrunwait
integer x = 114
integer y = 788
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Maximized"
end type

event clicked;// set current run type
is_runtype = this.ClassName()

end event

type rb_normal from radiobutton within w_testrunwait
integer x = 114
integer y = 720
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Normal"
boolean checked = true
end type

event clicked;// set current run type
is_runtype = this.ClassName()

end event

type cb_shellrun from commandbutton within w_testrunwait
integer x = 1426
integer y = 496
integer width = 334
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Shell Run"
end type

event clicked;String ls_fname, ls_verb, ls_msg
Long ll_rc

SetPointer(HourGlass!)

ls_verb = sle_verb.text

If sle_filename.text = "" Then
	sle_filename.SetFocus()
	MessageBox(this.text, "Filename is required!")
	Return
Else
	ls_fname = sle_filename.text
End If

// set wait options
If cbx_terminate.checked Then
	in_rwait.of_set_options(True, 5)
End If

// run the file
CHOOSE CASE is_runtype
	CASE "rb_hidden"
		ll_rc = in_rwait.of_ShellRun(ls_fname, ls_verb, Hide!)
	CASE "rb_maximized"
		ll_rc = in_rwait.of_ShellRun(ls_fname, ls_verb, Maximized!)
	CASE "rb_minimized"
		ll_rc = in_rwait.of_ShellRun(ls_fname, ls_verb, Minimized!)
	CASE ELSE
		ll_rc = in_rwait.of_ShellRun(ls_fname, ls_verb, Normal!)
END CHOOSE

// check return code
CHOOSE CASE ll_rc
	CASE in_rwait.WAIT_COMPLETE
		ls_msg = "The process completed normally!"
	CASE in_rwait.WAIT_TIMEOUT
		ls_msg = "The process was terminated after 5 seconds!"
	CASE -1
		ls_msg = "The process was not created!"
	CASE ELSE
		ls_msg = "The process completed with return code: " + String(ll_rc)
END CHOOSE
MessageBox(ls_fname, ls_msg)

end event

type cb_browse from commandbutton within w_testrunwait
integer x = 1426
integer y = 304
integer width = 334
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Browse"
end type

event clicked;String ls_pathname, ls_filename
Integer li_rc

li_rc = GetFileOpenName("Select File", &
				ls_pathname, ls_filename)
If li_rc = 1 Then
	sle_filename.text = ls_pathname
End If

end event

type sle_filename from singlelineedit within w_testrunwait
integer x = 37
integer y = 320
integer width = 1321
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_testrunwait
integer x = 37
integer y = 256
integer width = 434
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "File to Shell Run:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_testrunwait
integer x = 1426
integer y = 896
integer width = 334
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type gb_1 from groupbox within w_testrunwait
integer x = 37
integer y = 644
integer width = 882
integer height = 256
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Window Style"
end type

