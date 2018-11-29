$PBExportHeader$w_objects_per_location.srw
forward
global type w_objects_per_location from w_sheet_4t
end type
type dw_1 from datawindow within w_objects_per_location
end type
end forward

global type w_objects_per_location from w_sheet_4t
integer x = 672
integer y = 264
integer width = 2930
integer height = 1544
string title = "Objects In Location - "
boolean controlmenu = true
boolean minbox = true
long backcolor = 12632256
dw_1 dw_1
end type
global w_objects_per_location w_objects_per_location

type variables
st_generic_structure stParm
end variables

event open;//gnv_App.of_GetFrame().ChangeMenu ( m_menu_with_only_exit )

stParm = Message.PowerObjectParm

string l_s_temp

if stparm.value3 > '' then
	l_s_temp = "plant ='"+stParm.value3+"'"	
ELSE
	stparm.value3 = ''
	l_s_temp =  "NOT PLANT > ''"
END IF

Title = Title + stParm.Value2 + " Plant: " + stParm.Value3

dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( stParm.Value1, stParm.Value2  )
dw_1.SetFilter( l_s_temp ) 
dw_1.Filter()


end event

on w_objects_per_location.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_objects_per_location.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_objects_per_location
integer x = 37
integer y = 32
integer width = 2816
integer height = 1376
integer taborder = 1
string dataobject = "d_objects_per_location"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject ( sqlca )
//dw_1.Retrieve( stParm.value1,stParm.value2 )
//dw_1.SetFilter("plant ='"+stParm.value3+"'" ) 
//dw_1.Filter()
end event

