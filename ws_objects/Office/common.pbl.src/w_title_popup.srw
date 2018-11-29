$PBExportHeader$w_title_popup.srw
forward
global type w_title_popup from Window
end type
type dw_title from datawindow within w_title_popup
end type
end forward

global type w_title_popup from Window
int X=1024
int Y=564
int Width=1536
int Height=996
long BackColor=16777215
WindowType WindowType=popup!
dw_title dw_title
end type
global w_title_popup w_title_popup

type variables
INTEGER	i_i_count = 0
end variables

forward prototypes
public subroutine wf_rotate ()
end prototypes

public subroutine wf_rotate ();long	ll_count
FOR ll_count = 1 to 10
		dw_title.SETREDRAW ( FALSE )
		dw_title.Modify ( "DataWindow.Timer_Interval = 250" )
		dw_title.SETREDRAW ( TRUE )
NEXT

end subroutine

event open;f_center_window ( This )

visible = FALSE

dw_title.InsertRow ( 1 )
If monsys.oemtitle <> "" Then
	dw_title.SetItem ( 1, "line1", monsys.oemtitle )
Else
	dw_title.SetItem ( 1, "line1", monsys.title )
End if
dw_title.SetItem ( 1, "line2", monsys.version )

CHOOSE CASE sysenviron.OSType
	CASE WindowsNT!
		dw_title.SetItem ( 1, "line3", "For Windows NT" )
	CASE ELSE
		dw_title.SetItem ( 1, "line3", "For Windows 95/98" )
END CHOOSE
dw_title.SetItem ( 1, "line4", monsys.company )
dw_title.SetItem ( 1, "line5", "Copyright (c) 2000 Dave Medinis" )
dw_title.SetItem ( 1, "line6", "Serial Number: " + monsys.serial )
visible = TRUE


end event

on w_title_popup.create
this.dw_title=create dw_title
this.Control[]={this.dw_title}
end on

on w_title_popup.destroy
destroy(this.dw_title)
end on

event deactivate;IF IsValid ( ParentWindow ( ) ) THEN
	Close ( This )
END IF
end event

type dw_title from datawindow within w_title_popup
int Width=1531
int Height=988
int TabOrder=20
boolean Enabled=false
string DataObject="d_title"
boolean Border=false
end type

