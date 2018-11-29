$PBExportHeader$ulb_smart_drag_drop.sru
forward
global type ulb_smart_drag_drop from listbox
end type
end forward

type uos_icons from structure
    string s_tagvalue
    string s_leaveicon
    string s_entericon
    string s_beginicon
end type

global type ulb_smart_drag_drop from listbox
int X=5
int Y=5
int Width=787
int Height=713
int TabOrder=1
boolean VScrollBar=true
boolean MultiSelect=true
boolean ExtendedSelect=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_movewithin pbm_mousemove
end type
global ulb_smart_drag_drop ulb_smart_drag_drop

type variables
uos_icons	iuos_Icons [ ]

Private:
BOOLEAN	ib_LButtonDown, &
		ib_Dragging

STRING	is_InitialIcon
end variables

on ue_lbuttondown;ib_LButtonDown = TRUE
end on

on ue_lbuttonup;ib_LButtonDown = FALSE
Drag ( End! )
end on

on ue_movewithin;INTEGER	i_Count

IF ib_LButtonDown THEN
	IF NOT ib_Dragging THEN
		ib_Dragging = TRUE
		Drag ( Begin! )
		FOR i_Count = 1 TO UpperBound ( iuos_Icons )
			IF Tag = iuos_Icons [ i_Count ].s_TagValue THEN
				DragIcon = iuos_Icons [ i_Count ].s_BeginIcon
			END IF
		NEXT
	END IF
END IF
end on

on losefocus;SetState ( 0, FALSE )
end on

on dragdrop;ib_Dragging = FALSE
ib_LButtonDown = FALSE
end on

on dragleave;DragObject	ldo_DraggedObject
INTEGER	li_Count

ib_Dragging = FALSE
ib_LButtonDown = FALSE

ldo_DraggedObject = DraggedObject ( )

FOR li_Count = 1 to UpperBound ( iuos_Icons )
	IF ldo_DraggedObject.Tag = iuos_Icons [ li_Count ].s_TagValue THEN
		IF NOT IsNull ( iuos_Icons [ li_Count ].s_LeaveIcon ) THEN
			DragIcon = iuos_Icons [ li_Count ].s_LeaveIcon
		ELSE
			DragIcon = is_InitialIcon
		END IF
	END IF
NEXT
TriggerEvent ( 'ue_dragleave' )
end on

on dragenter;DragObject	ldo_DraggedObject
INTEGER	li_Count

ib_Dragging = TRUE
ib_LButtonDown = TRUE
is_InitialIcon = DragIcon

ldo_DraggedObject = DraggedObject ( )

FOR li_Count = 1 to UpperBound ( iuos_Icons )
	IF ldo_DraggedObject.Tag = iuos_Icons [ li_Count ].s_TagValue THEN
		IF NOT IsNull ( iuos_Icons [ li_Count ].s_EnterIcon ) THEN
			DragIcon = iuos_Icons [ li_Count ].s_EnterIcon
		ELSEIF NOT IsNull ( iuos_Icons [ li_Count ].s_BeginIcon ) THEN
			DragIcon = iuos_Icons [ li_Count ].s_BeginIcon
		END IF
	END IF
NEXT
TriggerEvent ( 'ue_dragenter' )
end on

