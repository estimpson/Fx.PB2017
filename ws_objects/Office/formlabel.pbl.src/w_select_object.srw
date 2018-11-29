$PBExportHeader$w_select_object.srw
forward
global type w_select_object from Window
end type
type st_5 from statictext within w_select_object
end type
type p_2 from picture within w_select_object
end type
type p_1 from picture within w_select_object
end type
type st_4 from statictext within w_select_object
end type
type sle_name from singlelineedit within w_select_object
end type
type cb_2 from commandbutton within w_select_object
end type
type cb_1 from commandbutton within w_select_object
end type
type st_3 from statictext within w_select_object
end type
type st_2 from statictext within w_select_object
end type
type lv_list from listview within w_select_object
end type
type st_1 from statictext within w_select_object
end type
end forward

global type w_select_object from Window
int X=800
int Y=612
int Width=1879
int Height=1092
boolean TitleBar=true
string Title="Select Object"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="None!"
st_5 st_5
p_2 p_2
p_1 p_1
st_4 st_4
sle_name sle_name
cb_2 cb_2
cb_1 cb_1
st_3 st_3
st_2 st_2
lv_list lv_list
st_1 st_1
end type
global w_select_object w_select_object

type variables
string   i_s_path
end variables

on w_select_object.create
this.st_5=create st_5
this.p_2=create p_2
this.p_1=create p_1
this.st_4=create st_4
this.sle_name=create sle_name
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.lv_list=create lv_list
this.st_1=create st_1
this.Control[]={this.st_5,&
this.p_2,&
this.p_1,&
this.st_4,&
this.sle_name,&
this.cb_2,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.lv_list,&
this.st_1}
end on

on w_select_object.destroy
destroy(this.st_5)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_4)
destroy(this.sle_name)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.lv_list)
destroy(this.st_1)
end on

event open;STRING	l_s_datawindows, &
			l_s_extension, &
			l_s_temp[], &
			l_s_value
			
st_generic_Structure  l_st_parm

DataStore	l_ds_reports

l_ds_reports = CREATE DataStore

l_ds_reports.DataObject = 'd_report_list'
//i_s_path = Message.StringParm

// changed the values being passed to a structure 
l_st_parm = message.powerobjectparm
i_s_path = l_st_parm.value1

l_s_extension = RightA ( i_s_path, 3 )

IF FileExists ( i_s_path ) THEN

	   st_4.text = i_s_path

		// change pbd to pbl in the variable to get the object names from the same.
		IF l_s_extension = 'pbd' THEN 
			i_s_path = ReplaceA ( i_s_path , PosA ( i_s_path, '.pbd' , 1 ) , 4, '.pbl' )
		END IF

		IF l_st_parm.value2 = 'dat' THEN
			l_s_datawindows = LibraryDirectory ( i_s_path, DirDatawindow! )
		ELSE
			l_s_datawindows = LibraryDirectory ( i_s_path, Dirwindow! )
		END IF
		
		l_ds_reports.ImportString ( l_s_datawindows )
		l_ds_reports.SetSort ( 'name desc' )
		l_ds_reports.Sort ( )
		
		DO WHILE l_ds_reports.RowCount ( ) > 0

			l_s_temp[1] = l_ds_reports.GetItemString ( 1, 1 )
			l_s_temp[2] = l_ds_reports.GetItemString ( 1, 2 )
			l_s_temp[3] = l_ds_reports.GetItemString ( 1, 3 )
			lv_list.AddItem ( l_s_temp[1] + '~t' + l_s_temp[2] + '~t' + ISNULL( l_s_temp[3], ' ' ), 1 )
			l_ds_reports.DeleteRow ( 0 )

		LOOP

ELSE

	Messagebox ( monsys.msg_Title, 'The file ' + i_s_path + ' does not exist!' )
	close ( this )

END IF


end event

type st_5 from statictext within w_select_object
int X=389
int Y=848
int Width=1079
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Objects"
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_2 from picture within w_select_object
int X=1669
int Y=28
int Width=133
int Height=100
string PictureName="reportv.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event clicked;p_1.BorderStyle = StyleRaised!
p_2.BorderStyle = StyleLowered!
lv_list.view = ListViewReport!
end event

type p_1 from picture within w_select_object
int X=1499
int Y=28
int Width=133
int Height=100
string PictureName="listv.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;p_1.BorderStyle = StyleLowered!
p_2.BorderStyle = StyleRaised!
lv_list.view = ListViewSmallIcon!
end event

type st_4 from statictext within w_select_object
int X=251
int Y=32
int Width=1207
int Height=84
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_name from singlelineedit within w_select_object
int X=389
int Y=736
int Width=1079
int Height=84
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_select_object
int X=1522
int Y=736
int Width=302
int Height=92
int TabOrder=40
string Text="Ok"
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;closewithreturn ( parent, sle_name.text)
end event

type cb_1 from commandbutton within w_select_object
int X=1522
int Y=852
int Width=302
int Height=92
int TabOrder=10
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;close ( parent )
end event

type st_3 from statictext within w_select_object
int X=32
int Y=848
int Width=393
int Height=76
boolean Enabled=false
string Text="Object of &type:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_select_object
int X=37
int Y=740
int Width=379
int Height=76
boolean Enabled=false
string Text="Object &name:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lv_list from listview within w_select_object
int X=23
int Y=156
int Width=1815
int Height=552
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoArrange=true
ListViewView View=ListViewReport!
string LargePictureName[]={"DataWindow1!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
string SmallPictureName[]={"DataWindow!",&
"Window!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=553648127
long StatePictureMaskColor=553648127
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type st_1 from statictext within w_select_object
int X=46
int Y=48
int Width=247
int Height=76
boolean Enabled=false
string Text="Look &in"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

