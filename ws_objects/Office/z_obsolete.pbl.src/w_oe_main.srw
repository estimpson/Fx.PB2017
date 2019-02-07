$PBExportHeader$w_oe_main.srw
forward
global type w_oe_main from Window
end type
type st_title from uo_title_text within w_oe_main
end type
end forward

global type w_oe_main from Window
int X=5
int Y=1
int Width=2908
int Height=1885
boolean TitleBar=true
string Title="Order Entry Main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_title st_title
end type
global w_oe_main w_oe_main

type variables
Boolean bMenuItemClicked
end variables

event activate;If gnv_App.of_GetFrame().MenuName <> "mn_mw30_main" Then &
	gnv_App.of_GetFrame().ChangeMenu ( mn_mw30_main )

gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )
f_build_custom_arrays ( "monitor.oemain" )
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
	w_oe_main.Title = w_oe_main.Title + " [w_oe_main]"
end on

event resize;st_title.TriggerEvent ( 'ue_resize' )
end event

on w_oe_main.create
this.st_title=create st_title
this.Control[]={ this.st_title}
end on

on w_oe_main.destroy
destroy(this.st_title)
end on

type st_title from uo_title_text within w_oe_main
int X=1
int Y=1
int Width=1692
string Text="Order Entry"
end type

