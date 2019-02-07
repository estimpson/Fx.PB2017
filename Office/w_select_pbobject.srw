HA$PBExportHeader$w_select_pbobject.srw
forward
global type w_select_pbobject from w_response
end type
type st_5 from statictext within w_select_pbobject
end type
type st_4 from statictext within w_select_pbobject
end type
type sle_name from singlelineedit within w_select_pbobject
end type
type cb_2 from commandbutton within w_select_pbobject
end type
type cb_1 from commandbutton within w_select_pbobject
end type
type st_3 from statictext within w_select_pbobject
end type
type st_2 from statictext within w_select_pbobject
end type
type lv_list from listview within w_select_pbobject
end type
type st_1 from statictext within w_select_pbobject
end type
end forward

global type w_select_pbobject from w_response
integer x = 800
integer y = 612
integer width = 1879
integer height = 1092
string title = "Select Object"
long backcolor = 79741120
string icon = "None!"
st_5 st_5
st_4 st_4
sle_name sle_name
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_2 st_2
lv_list lv_list
st_1 st_1
end type
global w_select_pbobject w_select_pbobject

type variables

end variables
on w_select_pbobject.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_4=create st_4
this.sle_name=create sle_name
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.lv_list=create lv_list
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.sle_name
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.lv_list
this.Control[iCurrent+9]=this.st_1
end on

on w_select_pbobject.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_name)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.lv_list)
destroy(this.st_1)
end on

event open;
DataStore pbObjectList

pbObjectList = CREATE DataStore
pbObjectList.DataObject = 'd_report_list'

// changed the values being passed to a structure
string libraryPath
libraryPath = message.inv_Parm.of_GetItem("LibraryPath", "")
string objectType
objectType = message.inv_Parm.of_GetItem("ObjectType", "")

if	FileExists (libraryPath) then

	   st_4.text = libraryPath

		// change pbd to pbl in the variable to get the object names from the same.
		string objectList
		choose case lower(objectType)
			case "dat"
				objectList = LibraryDirectoryEx (libraryPath, DirDatawindow!)
			case else
				objectList = LibraryDirectoryEx (libraryPath, Dirwindow!)
		end choose
		
		pbObjectList.ImportString (objectList)
		pbObjectList.SetSort ( 'name desc' )
		pbObjectList.Sort ( )
		
		string objectProps[]
		do while pbObjectList.RowCount() > 0

			//objectProps = pbObjectList.Object.Data.Primary[1]
			objectProps[1] = pbObjectList.GetItemString ( 1, 1 )
			objectProps[2] = pbObjectList.GetItemString ( 1, 2 )
			objectProps[3] = pbObjectList.GetItemString ( 1, 3 )
			lv_list.AddItem(objectProps[1] + '~t' + objectProps[2] + '~t' + IsNull(objectProps[3], ' ' ), 1)
			pbObjectList.DeleteRow(0)
		loop
else
	MsgBox('The file ' + libraryPath + ' does not exist!')
	CloseWithReturn(this, NO_ACTION)
end if

end event

type st_5 from statictext within w_select_pbobject
integer x = 439
integer y = 848
integer width = 1029
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "Objects"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_select_pbobject
integer x = 279
integer y = 32
integer width = 1554
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_select_pbobject
integer x = 439
integer y = 732
integer width = 1029
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_select_pbobject
integer x = 1522
integer y = 736
integer width = 302
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ok"
boolean default = true
end type

event clicked;
message.inv_Parm.of_SetItem("PBObject", sle_name.text)
CloseWithReturn(parent, CONTINUE_ACTION)

end event

type cb_1 from commandbutton within w_select_pbobject
integer x = 1522
integer y = 852
integer width = 302
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;
CloseWithReturn(parent, NO_ACTION)

end event

type st_3 from statictext within w_select_pbobject
integer x = 32
integer y = 848
integer width = 393
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean enabled = false
string text = "Object of &type:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_select_pbobject
integer x = 37
integer y = 740
integer width = 379
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean enabled = false
string text = "Object &name:"
boolean focusrectangle = false
end type

type lv_list from listview within w_select_pbobject
integer x = 23
integer y = 156
integer width = 1815
integer height = 552
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
boolean autoarrange = true
boolean hideselection = false
boolean fullrowselect = true
listviewview view = listviewreport!
string largepicturename[] = {"DataWindow1!"}
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 553648127
string smallpicturename[] = {"DataWindow!","Window!"}
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event constructor;AddColumn ( 'Name', Left!, 681 )
AddColumn ( 'Date', Left!, 554 )
AddColumn ( 'Comments', Left!, 1000 )
end event

event clicked;string l_s_Value

lv_list.getitem(index, 1, l_s_value)

sle_name.text = l_s_value


end event

event doubleclicked;string l_s_Value

lv_list.getitem ( index, 1, l_s_value )

sle_name.text = l_s_value 

cb_2.triggerevent ( clicked! )
end event

type st_1 from statictext within w_select_pbobject
integer x = 46
integer y = 48
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean enabled = false
string text = "Look in:"
boolean focusrectangle = false
end type

