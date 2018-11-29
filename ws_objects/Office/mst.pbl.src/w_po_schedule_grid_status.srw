$PBExportHeader$w_po_schedule_grid_status.srw
forward
global type w_po_schedule_grid_status from Window
end type
type dw_popup from datawindow within w_po_schedule_grid_status
end type
end forward

global type w_po_schedule_grid_status from Window
int X=5
int Y=4
int Width=3113
int Height=2356
boolean TitleBar=true
string Title="MPS Detail Information"
long BackColor=77897888
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_print ( )
event ue_close ( )
dw_popup dw_popup
end type
global w_po_schedule_grid_status w_po_schedule_grid_status

type variables

end variables

forward prototypes
public subroutine wf_initialize ()
end prototypes

event ue_print;dw_popup.object.datawindow.print.Orientation = 1 // set to landscape..
dw_popup.print()

end event

event ue_close;CLOSE ( w_po_schedule_grid_status )
end event

public subroutine wf_initialize ();
end subroutine

on w_po_schedule_grid_status.create
this.dw_popup=create dw_popup
this.Control[]={this.dw_popup}
end on

on w_po_schedule_grid_status.destroy
destroy(this.dw_popup)
end on

event open;s_parm_list		lst_parm
date			 	l_d_datetime

lst_parm 		 = Message.PowerObjectParm
l_d_datetime	 = lst_parm.d_parm_list[1]

dw_popup.retrieve ( lst_parm.s_key_value, datetime( l_d_datetime, time('00:00') ) , lst_parm.s_parm_list[1] ) 
dw_popup.Object.DataWindow.Zoom  = 75

IF lst_parm.s_parm_list[1] = 'M' THEN 

	dw_popup.Modify("title.Text='Production Status Report    '")

ELSE

	dw_popup.Modify("title.Text='Purchase Status Report     '")

END IF

end event

event activate;IF gnv_App.of_GetFrame().MenuName <> 'm_generate_report' THEN &        
	gnv_App.of_GetFrame().Changemenu ( m_generate_report )



end event

event resize;dw_popup.width = width * 0.95
dw_popup.height = height * 0.95



end event

type dw_popup from datawindow within w_po_schedule_grid_status
int X=5
int Y=4
int Width=3058
int Height=1784
int TabOrder=10
string DataObject="d_purchase_order_screen_new"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
this.width = parent.width * 0.95
this.height = parent.height * 0.95
end event

event retrieveend;this.Modify("DataWindow.Print.Preview = Yes")
end event

