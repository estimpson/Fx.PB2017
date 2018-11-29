$PBExportHeader$w_file_list.srw
forward
global type w_file_list from Window
end type
type lb_1 from listbox within w_file_list
end type
type st_2 from statictext within w_file_list
end type
type cb_2 from commandbutton within w_file_list
end type
type cb_1 from commandbutton within w_file_list
end type
type st_1 from statictext within w_file_list
end type
type st_3 from statictext within w_file_list
end type
end forward

global type w_file_list from Window
int X=673
int Y=265
int Width=1070
int Height=981
boolean TitleBar=true
string Title="Choose Logo File"
long BackColor=12632256
WindowType WindowType=popup!
lb_1 lb_1
st_2 st_2
cb_2 cb_2
cb_1 cb_1
st_1 st_1
st_3 st_3
end type
global w_file_list w_file_list

type variables
Boolean bOK, bClose

String szFileName
end variables

on open;//
//  Declare Variables
//

bClose = True


//
//  If show program name parameter is 'Y' then append title with it
//

String szShowProgName

  SELECT parameters.show_program_name  
    INTO :szShowProgName  
    FROM parameters  ;

If szShowProgName = 'Y' Then
	w_file_list.Title = w_file_list.Title + " [w_file_list]"
End if


//
//  populate list box with file list
//

lb_1.DirList ( "*.bmp", 16400, st_1 )
end on

on deactivate;If bClose = True Then Close ( w_file_list )
end on

on w_file_list.create
this.lb_1=create lb_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.st_3=create st_3
this.Control[]={ this.lb_1,&
this.st_2,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.st_3}
end on

on w_file_list.destroy
destroy(this.lb_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_3)
end on

type lb_1 from listbox within w_file_list
int X=37
int Y=289
int Width=659
int Height=545
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;String szFileSpec = "*.BMP"

If lb_1.DirSelect ( szFileName ) Then
	szFileName = szFileName + szFileSpec
	lb_1.DirList ( szFileName, 16400, st_1 )
	bOK = False
Else
	bOK = True	
End if

gb_bitmap = TRUE
end on

type st_2 from statictext within w_file_list
int X=37
int Y=25
int Width=549
int Height=65
boolean Enabled=false
string Text="Current Directory:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_file_list
int X=732
int Y=253
int Width=257
int Height=129
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;bClose    = FALSE
gb_Bitmap = FALSE

Close ( w_file_list )
end on

type cb_1 from commandbutton within w_file_list
int X=732
int Y=93
int Width=257
int Height=129
int TabOrder=20
string Text="&Ok"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If bOK Then szReturnedString = lb_1.SelectedItem ( )

bClose = False

Close ( w_file_list )
end on

type st_1 from statictext within w_file_list
int X=37
int Y=97
int Width=659
int Height=97
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_file_list
int X=37
int Y=217
int Width=293
int Height=65
boolean Enabled=false
string Text="File List:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

