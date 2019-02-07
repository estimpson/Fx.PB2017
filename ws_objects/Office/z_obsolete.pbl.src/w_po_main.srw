$PBExportHeader$w_po_main.srw
forward
global type w_po_main from Window
end type
type st_title from uo_title_text within w_po_main
end type
end forward

global type w_po_main from Window
int X=5
int Y=0
int Width=2907
int Height=1884
boolean TitleBar=true
string Title="Purchase Order Main"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_title st_title
end type
global w_po_main w_po_main

type variables
Boolean bMenuItemClicked
end variables

event activate;If gnv_App.of_GetFrame().MenuName <> "m_po_main" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_po_main )

gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )
f_build_custom_arrays ( "monitor.pomain" )
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
	w_po_main.Title = w_po_main.Title + " [w_po_main]"
end on

event resize;st_title.TriggerEvent ( 'ue_resize' )
end event

on w_po_main.create
this.st_title=create st_title
this.Control[]={this.st_title}
end on

on w_po_main.destroy
destroy(this.st_title)
end on

type st_title from uo_title_text within w_po_main
int X=0
int Y=0
int Width=3099
string Text="Purchase Order Entry"
long BackColor=78682240
int TextSize=-46
FontCharSet FontCharSet=Ansi!
end type

