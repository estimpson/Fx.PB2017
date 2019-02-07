$PBExportHeader$w_ps_main.srw
forward
global type w_ps_main from Window
end type
type st_title from uo_title_text within w_ps_main
end type
end forward

global type w_ps_main from Window
int X=5
int Y=1
int Width=2908
int Height=1885
boolean TitleBar=true
string Title="Production Scheduling Main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_title st_title
end type
global w_ps_main w_ps_main

event activate;gnv_App.of_GetFrame().ChangeMenu ( mn_mpsw30 )

gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )
f_build_custom_arrays ( "monitor.psmain" )
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
	w_ps_main.Title = w_ps_main.Title + " [w_ps_main]"
end on

event resize;st_title.TriggerEvent ( 'ue_resize' )
end event

on w_ps_main.create
this.st_title=create st_title
this.Control[]={ this.st_title}
end on

on w_ps_main.destroy
destroy(this.st_title)
end on

type st_title from uo_title_text within w_ps_main
int X=5
int Y=1
int Width=3278
string Text="Production Scheduling"
end type

