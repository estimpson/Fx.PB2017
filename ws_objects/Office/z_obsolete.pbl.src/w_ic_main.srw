$PBExportHeader$w_ic_main.srw
forward
global type w_ic_main from Window
end type
type st_title from uo_title_text within w_ic_main
end type
end forward

global type w_ic_main from Window
int X=5
int Y=1
int Width=2908
int Height=1885
boolean TitleBar=true
string Title="Inventory Inquiries Main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_title st_title
end type
global w_ic_main w_ic_main

type variables
Boolean bMenuItemClicked
end variables

event activate;If gnv_App.of_GetFrame().MenuName <> "m_ic30_main" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_ic30_main )
	
gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )
f_build_custom_arrays ( "monitor.icmain" )
f_build_custom_menu ( gnv_App.of_GetFrame().MenuID, gnv_App.of_GetFrame() )
end event

on open;//
//  If show program name parameter is 'Y' then append the title with it
//

String szShowProgName

  SELECT parameters.show_program_name  
    INTO :szShowProgName  
    FROM parameters  ;

If szShowProgName = 'Y' Then &
	w_ic_main.Title = w_ic_main.Title + " [w_ic_main]"
end on

on w_ic_main.create
this.st_title=create st_title
this.Control[]={ this.st_title}
end on

on w_ic_main.destroy
destroy(this.st_title)
end on

event resize;st_title.TriggerEvent ( 'ue_resize' )
end event

type st_title from uo_title_text within w_ic_main
int X=1
int Y=1
int Width=2684
string Text="Inventory Inquiries"
end type

