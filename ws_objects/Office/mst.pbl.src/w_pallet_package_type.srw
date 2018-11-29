$PBExportHeader$w_pallet_package_type.srw
forward
global type w_pallet_package_type from Window
end type
type lb_1 from listbox within w_pallet_package_type
end type
type cb_2 from commandbutton within w_pallet_package_type
end type
type cb_1 from commandbutton within w_pallet_package_type
end type
end forward

global type w_pallet_package_type from Window
int X=833
int Y=357
int Width=933
int Height=997
boolean TitleBar=true
string Title="Choose Package Type"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
lb_1 lb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_pallet_package_type w_pallet_package_type

forward prototypes
public subroutine wf_build_list ()
end prototypes

public subroutine wf_build_list ();string	l_s_code

 DECLARE package_types CURSOR FOR  
  SELECT package_materials.code  
    FROM package_materials  
   WHERE package_materials.type = 'P'   
ORDER BY package_materials.code ASC  ;

Open package_types;
Fetch package_types into :l_s_code ;
Do While sqlca.sqlcode = 0
	lb_1.AddItem ( l_s_code )
	Fetch package_types into :l_s_code ;
Loop
Close package_types;
end subroutine

on open;wf_build_list ( )

if lb_1.TotalItems ( ) < 1 then &
	CloseWithReturn ( This, "0" )
end on

on w_pallet_package_type.create
this.lb_1=create lb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.lb_1,&
this.cb_2,&
this.cb_1}
end on

on w_pallet_package_type.destroy
destroy(this.lb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type lb_1 from listbox within w_pallet_package_type
int X=37
int Y=33
int Width=823
int Height=657
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-14
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_pallet_package_type
int X=476
int Y=705
int Width=385
int Height=145
int TabOrder=30
string Text="&Cancel"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, "-1" )
end on

type cb_1 from commandbutton within w_pallet_package_type
int X=37
int Y=705
int Width=385
int Height=145
int TabOrder=20
string Text="&Ok"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;string	l_s_item

l_s_item = lb_1.SelectedItem ( )

if l_s_item = "" then
	MessageBox ( "Error", "You must choose a package type to continue!", StopSign! )
	return
end if

CloseWithReturn ( Parent, l_s_item )
end on

