$PBExportHeader$w_ad_main.srw
forward
global type w_ad_main from Window
end type
type p_pict from uo_title_pict within w_ad_main
end type
type st_text from uo_title_text within w_ad_main
end type
end forward

global type w_ad_main from Window
int X=5
int Y=1
int Width=2908
int Height=1885
boolean TitleBar=true
string Title="Administrative Setups Main"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
p_pict p_pict
st_text st_text
end type
global w_ad_main w_ad_main

type variables
Boolean bMenuItemClicked
end variables

event activate;String l_s_dimension
If gnv_App.of_GetFrame().MenuName <> "m_ad30_main" Then
	gnv_App.of_GetFrame().ChangeMenu ( m_ad30_main )
   Select dda_required
   into :l_s_dimension
   from parameters ;
   If (l_s_dimension<>'Y' or isnull(l_s_dimension)) then  
      m_ad30_main.m_file.m_dimensionalsetup.visible = FALSE
      m_ad30_main.m_file.m_dimensionalsetup.toolbaritemvisible = FALSE
   End if 	
End if 
gnv_App.of_GetFrame().SetMicroHelp ( 'Ready' )
f_build_custom_arrays ( "monitor.admain" )
f_build_custom_menu ( gnv_App.of_GetFrame().MenuID, gnv_App.of_GetFrame() )


end event

event open;//
//  If show program name parameter is 'Y' then append the title with it
//

String szShowProgName

  SELECT parameters.show_program_name  
    INTO :szShowProgName  
    FROM parameters  ;

If szShowProgName = 'Y' Then &
	w_ad_main.Title = w_ad_main.Title + " [w_ad_main]"


end event

event resize;st_text.PostEvent ( 'ue_resize' )
p_pict.PostEvent ( 'ue_resize' )
end event

on w_ad_main.create
this.p_pict=create p_pict
this.st_text=create st_text
this.Control[]={ this.p_pict,&
this.st_text}
end on

on w_ad_main.destroy
destroy(this.p_pict)
destroy(this.st_text)
end on

type p_pict from uo_title_pict within w_ad_main
int X=1
int Y=725
int Width=833
int Height=649
string PictureName="logo2g.bmp"
end type

type st_text from uo_title_text within w_ad_main
int X=1
int Y=1
int Width=3159
int Height=1253
string Text="Administrative Setups"
end type

