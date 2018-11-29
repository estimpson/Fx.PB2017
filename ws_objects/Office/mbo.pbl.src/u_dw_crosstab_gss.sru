$PBExportHeader$u_dw_crosstab_gss.sru
$PBExportComments$The crosstab datawindow of the Global Shipping Scheduler which allows multi-selection, dragging and dropping.
forward
global type u_dw_crosstab_gss from datawindow
end type
end forward

shared variables

end variables

global type u_dw_crosstab_gss from datawindow
int Width=2286
int Height=1104
int TabOrder=1
string DataObject="dw_crosstab_for_global_shipping_version2"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event key pbm_dwnkey
event mousemove pbm_dwnmousemove
event ue_object_change ( long newrow,  long newcolumn )
event ue_range_change ( string range )
end type
global u_dw_crosstab_gss u_dw_crosstab_gss

type variables
BOOLEAN	i_b_control, &
		i_b_lbutton


LONG	i_l_cur_row, &
	i_l_cur_col

STRING	i_s_range
end variables

event key;//UINT	l_ui_column_count

//IF i_b_control = KeyDown ( KeyControl! ) THEN
//	Return
//ELSE
//	i_b_control = KeyDown ( KeyControl! )
//END IF
//IF i_b_control THEN
//	Drag ( end! )
//	object.part.TabSequence = 10
//	FOR l_ui_column_count = 2 TO 9
//		SetTabOrder ( l_ui_column_count, 0 )
//	NEXT
//	object.part.TabSequence = 0
//END IF
end event

event mousemove;LONG	l_l_column

IF Upper ( dwo.Type ) = "COLUMN" THEN
	l_l_column = Integer ( dwo.id )
ELSE
	l_l_column = 0
END IF

IF i_l_cur_row <> row OR i_l_cur_col <> l_l_column THEN
	i_l_cur_row = row
	i_l_cur_col = l_l_column
	POST EVENT ue_object_change ( i_l_cur_row, i_l_cur_col )
END IF
IF i_s_range <> object.datawindow.selected THEN
	i_s_range = object.datawindow.selected
	POST EVENT ue_range_change ( i_s_range )
END IF
end event

event clicked;i_b_lbutton = TRUE
//IF KeyDown ( KeyControl! ) AND NOT i_b_control THEN
//	TRIGGER EVENT key ( KeyControl!, 0 )
//END IF
//i_b_control = KeyDown ( KeyControl! )
//IF NOT i_b_control THEN
	IF Upper ( dwo.type ) = "COLUMN" THEN
		TRIGGER EVENT ue_range_change ( String ( row ) + "/" + String ( row ) + "/" + dwo.Name )
		IF LONG ( dwo.id ) > 1 THEN
			Drag ( begin! )
		END IF
	ELSE
		TRIGGER EVENT ue_range_change ( "" )
	END IF
//END IF
end event

event other;UINT	l_ui_column_count

CHOOSE CASE message.number
	CASE 514
		i_b_lbutton = FALSE
	CASE 257
		i_b_control = KeyDown ( KeyControl! )
		IF NOT i_b_control THEN
			FOR l_ui_column_count = 2 TO 9
				SetTabOrder ( l_ui_column_count, l_ui_column_count * 10 )
			NEXT
			IF i_b_lbutton THEN
				Drag ( begin! )
			END IF
		END IF
END CHOOSE
end event

event losefocus;object.datawindow.selected = ""
end event

