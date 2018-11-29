$PBExportHeader$w_user_defined_return_data.srw
forward
global type w_user_defined_return_data from Window
end type
type dw_1 from datawindow within w_user_defined_return_data
end type
end forward

global type w_user_defined_return_data from Window
int X=673
int Y=265
int Width=1582
int Height=989
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_user_defined_return_data w_user_defined_return_data

on open;String szWindow

Int iCount


szWindow = Message.StringParm

dw_1.SetTransObject ( sqlca )
If dw_1.Retrieve ( szWindow ) > 0 Then

	For iCount = 1 To dw_1.RowCount ( )

		CHOOSE CASE iCount

		CASE 1
			stGlobalParm.Value1 = dw_1.GetItemString ( iCount, "user_defined_labels_label" )
			stGlobalParm.Value2 = dw_1.GetItemString ( iCount, "datawindow_name" )
		CASE 2
			stGlobalParm.Value3 = dw_1.GetItemString ( iCount, "user_defined_labels_label" )
			stGlobalParm.Value4 = dw_1.GetItemString ( iCount, "datawindow_name" )
		CASE 3
			stGlobalParm.Value5 = dw_1.GetItemString ( iCount, "user_defined_labels_label" )
			stGlobalParm.Value6 = dw_1.GetItemString ( iCount, "datawindow_name" )
		CASE 4
			stGlobalParm.Value7 = dw_1.GetItemString ( iCount, "user_defined_labels_label" )
			stGlobalParm.Value8 = dw_1.GetItemString ( iCount, "datawindow_name" )
		CASE 5
			stGlobalParm.Value9 = dw_1.GetItemString ( iCount, "user_defined_labels_label" )
			stGlobalParm.Value10 = dw_1.GetItemString ( iCount, "datawindow_name" )

		END CHOOSE

	Next

End if

Close ( This )
end on

on w_user_defined_return_data.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_user_defined_return_data.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_user_defined_return_data
int X=481
int Y=369
int Width=494
int Height=361
int TabOrder=1
string DataObject="d_user_defined_window_link"
boolean LiveScroll=true
end type

