$PBExportHeader$w_decide_order.srw
forward
global type w_decide_order from window
end type
end forward

global type w_decide_order from window
boolean visible = false
integer x = 672
integer y = 264
integer width = 1582
integer height = 988
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
end type
global w_decide_order w_decide_order

event open;String 	cType
long		l_l_order

l_l_order = Message.DoubleParm

//If IsNull ( stParm ) or IsValid ( stParm ) = False Then Close ( This )

//l_l_order = Long ( stParm.item_label )

SELECT order_header.order_type  
  INTO :cType  
  FROM order_header  
 WHERE order_header.order_no = :l_l_order  ;

If cType = "B" Then
	OpenSheetWithParm ( w_blanket_order, l_l_order, gnv_App.of_GetFrame(), 0, Original! )
Else 
	OpenSheetWithParm ( w_orders_detail, l_l_order, gnv_App.of_GetFrame(), 0, Original! )
End if

Close ( This )
end event

on w_decide_order.create
end on

on w_decide_order.destroy
end on

