$PBExportHeader$u_base_dw.sru
forward
global type u_base_dw from datawindow
end type
end forward

global type u_base_dw from datawindow
int Width=494
int Height=361
int TabOrder=1
boolean LiveScroll=true
end type
global u_base_dw u_base_dw

type variables
Protected:
Window	i_w_parent, &
	i_w_mdi_frame

BOOLEAN	i_b_parent, &
		i_b_mdi_frame

GraphicObject	i_go_parent [ ]
end variables

event constructor;INTEGER	l_i_count = 1

i_go_parent [ l_i_count ] = GetParent ( )
Do While TypeOf ( i_go_parent [ l_i_count ] ) <> Window!
	l_i_count ++
	i_go_parent [ l_i_count ] = i_go_parent [ l_i_count - 1 ].GetParent ( )
Loop
i_w_parent = i_go_parent [ l_i_count ]
IF IsValid ( i_w_parent ) THEN
	i_b_parent = TRUE
	i_w_mdi_frame = i_w_parent.ParentWindow ( )
	IF IsValid ( i_w_mdi_frame ) THEN
		i_b_mdi_frame = TRUE
	END IF
END IF
end event

