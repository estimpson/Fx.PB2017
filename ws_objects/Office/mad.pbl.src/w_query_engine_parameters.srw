$PBExportHeader$w_query_engine_parameters.srw
$PBExportComments$mad
forward
global type w_query_engine_parameters from Window
end type
type dw_1 from datawindow within w_query_engine_parameters
end type
type gb_1 from groupbox within w_query_engine_parameters
end type
end forward

global type w_query_engine_parameters from Window
int X=9
int Y=32
int Width=2994
int Height=1852
boolean TitleBar=true
string Title="Query Engine Parameters"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event check_item pbm_custom01
event itemsaved pbm_custom02
dw_1 dw_1
gb_1 gb_1
end type
global w_query_engine_parameters w_query_engine_parameters

type variables
boolean bItemchanged = False
end variables

on check_item;Int i_Rtncode

If bitemchanged = True Then

   i_Rtncode = MessageBox ( "Warning", "Would you like to save the changes?", Exclamation!, YesNoCancel!, 3 )

   If i_Rtncode = 1 Then
 
  		m_query_engine_parameters.m_file.m_save.TriggerEvent (Clicked!)
      gnv_App.of_GetFrame().setMicroHelp  ( "Information Saved...." )
      Close ( w_query_engine_parameters )     

	ElseIf i_Rtncode = 2 Then

      Close ( w_query_engine_parameters )     

	Else  

      w_query_engine_parameters.dw_1.SetFocus ( )

	End If

Else

      Close ( w_query_engine_parameters )     

End If                             
end on

on itemsaved;bitemchanged = False
end on

on activate;If gnv_App.of_GetFrame().MenuName <> "m_query_engine_parameters" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_query_engine_parameters )
end on

on w_query_engine_parameters.create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.gb_1}
end on

on w_query_engine_parameters.destroy
destroy(this.dw_1)
destroy(this.gb_1)
end on

on open;dw_1.SetTransObject ( sqlca )
dw_1.Retrieve ( )

end on

type dw_1 from datawindow within w_query_engine_parameters
int X=73
int Y=64
int Width=2779
int Height=1280
int TabOrder=10
string DataObject="d_query_engine_setup"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemchanged;bItemchanged = True
end on

type gb_1 from groupbox within w_query_engine_parameters
int X=37
int Width=2853
int Height=1376
int TabOrder=20
string Text="Query Engine Parameters:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

