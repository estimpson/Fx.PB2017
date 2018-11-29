$PBExportHeader$u_create_shift_wizard_machines.sru
forward
global type u_create_shift_wizard_machines from u_three_lb_wizard_ancestor
end type
end forward

global type u_create_shift_wizard_machines from u_three_lb_wizard_ancestor
end type
global u_create_shift_wizard_machines u_create_shift_wizard_machines

type variables
STRING	is_GroupNo
BOOLEAN	ib_LBttnDn, &
		ib_Dragging
end variables

forward prototypes
private function integer uof_paint_data ()
end prototypes

private function integer uof_paint_data ();STRING	ls_LocationGroup

IF ib_Painted THEN
	IF IsValid ( lb_3 ) THEN
		IF lb_3.TotalItems ( ) > 0 THEN
			w_create_new_shift_wizard.wf_enable_next ( TRUE )
		ELSE
			w_create_new_shift_wizard.wf_enable_next ( FALSE )
		END IF
	END IF
ELSE
	ib_Painted = TRUE

	 DECLARE get_groups CURSOR FOR  
	  SELECT DISTINCT group_no
	    FROM location
	   WHERE type = 'MC'
	ORDER BY group_no
	   USING SQLCA  ;

	    OPEN get_groups  ;

	   FETCH get_groups
	    INTO :ls_LocationGroup  ;

	DO WHILE SQLCA.SQLCode = 0
		IF NOT IsNull ( ls_LocationGroup ) THEN
			lb_1.AddItem ( ls_LocationGroup )
		END IF
	
		   FETCH get_groups
		    INTO :ls_LocationGroup  ;

	LOOP

	   CLOSE get_groups  ;

	lb_1.AddItem ( '-------------' )
	lb_1.AddItem ( '<ALL>' )
END IF
Return 0
end function

on u_create_shift_wizard_machines.create
call super::create
end on

on u_create_shift_wizard_machines.destroy
call super::destroy
end on

type st_4 from u_three_lb_wizard_ancestor`st_4 within u_create_shift_wizard_machines
int Y=448
string Text="Schedule:"
end type

type st_3 from u_three_lb_wizard_ancestor`st_3 within u_create_shift_wizard_machines
int Y=448
int Width=539
string Text="Available Machines:"
end type

type st_2 from u_three_lb_wizard_ancestor`st_2 within u_create_shift_wizard_machines
int Y=448
string Text="Groups:"
end type

type st_1 from u_three_lb_wizard_ancestor`st_1 within u_create_shift_wizard_machines
int X=59
int Y=40
int Width=1769
int Height=368
end type

on st_1::constructor;call u_three_lb_wizard_ancestor`st_1::constructor;Text = 'Select machines by selecting the group and dragging machines from the available list to the schedule list.'
end on

type p_2 from u_three_lb_wizard_ancestor`p_2 within u_create_shift_wizard_machines
int X=1147
int Y=612
boolean Enabled=false
end type

type p_1 from u_three_lb_wizard_ancestor`p_1 within u_create_shift_wizard_machines
int Y=752
boolean Enabled=false
end type

type lb_1 from u_three_lb_wizard_ancestor`lb_1 within u_create_shift_wizard_machines
int X=69
int Y=524
string Tag="lb1"
boolean Sorted=false
end type

on lb_1::selectionchanged;call u_three_lb_wizard_ancestor`lb_1::selectionchanged;is_GroupNo = SelectedItem ( )

IF TotalItems ( ) - SelectedIndex ( ) = 1 THEN
	SetNull ( is_GroupNo )
END IF

lb_2.PostEvent ( 'ue_paint' )
end on

type lb_2 from u_three_lb_wizard_ancestor`lb_2 within u_create_shift_wizard_machines
event ue_paint pbm_custom01
int Y=528
string DragIcon="LBDRAG.ICO"
string Tag="lb2"
end type

on lb_2::ue_paint;call u_three_lb_wizard_ancestor`lb_2::ue_paint;STRING	ls_Machine

CHOOSE CASE is_GroupNo
CASE '<ALL>'
	Reset ( )

	  DECLARE get_machines_all CURSOR FOR
	   SELECT code
	     FROM location
	    WHERE type = 'MC'  ;

	     OPEN get_machines_all  ;

	    FETCH get_machines_all
	     INTO :ls_Machine  ;

	DO WHILE SQLCA.SQLCode = 0
		IF NOT IsNull ( ls_Machine ) THEN
			AddItem ( ls_Machine )
		END IF

		   FETCH get_machines_all
		    INTO :ls_Machine  ;

	LOOP

	   CLOSE get_machines_all  ;

CASE ELSE
	IF IsNull ( is_GroupNo ) THEN
		Return
	END IF
	Reset ( )

	  DECLARE get_machines_by_group CURSOR FOR
	   SELECT code
	     FROM location
	    WHERE group_no = :is_GroupNo AND
	          type = 'MC'  ;

	     OPEN get_machines_by_group  ;

	    FETCH get_machines_by_group
	     INTO :ls_Machine  ;

	DO WHILE SQLCA.SQLCode = 0
		IF NOT IsNull ( ls_Machine ) THEN
			AddItem ( ls_Machine )
		END IF

		   FETCH get_machines_by_group
		    INTO :ls_Machine  ;

	LOOP

	   CLOSE get_machines_by_group  ;

END CHOOSE
end on

on lb_2::dragdrop;call u_three_lb_wizard_ancestor`lb_2::dragdrop;INTEGER	li_Count1, &
			li_Match

DragObject	ldo_DraggedObject

ldo_DraggedObject = DraggedObject ( )

IF ldo_DraggedObject.Tag = 'lb3' THEN
	li_Count1 = 1
	DO WHILE li_Count1 <= lb_3.TotalItems ( )
		IF lb_3.State ( li_Count1 ) = 1 THEN
			lb_3.DeleteItem ( li_Count1 )
		ELSE
			li_Count1 ++
		END IF
	LOOP
	IF lb_3.TotalItems ( ) = 0 THEN
		w_create_new_shift_wizard.wf_enable_next ( FALSE )
	END IF
END IF
end on

on lb_2::constructor;call u_three_lb_wizard_ancestor`lb_2::constructor;iuos_Icons [ 1 ].s_TagValue = 'lb2'
iuos_Icons [ 1 ].s_LeaveIcon = 'nothere.ico'
iuos_Icons [ 1 ].s_BeginIcon = 'lbdrag.ico'
iuos_Icons [ 1 ].s_EnterIcon = 'lbdrag.ico'
iuos_Icons [ 2 ].s_TagValue = 'lb3'
iuos_Icons [ 2 ].s_EnterIcon = 'lbdragm.ico'
iuos_Icons [ 2 ].s_LeaveIcon = 'nothere.ico'
end on

type lb_3 from u_three_lb_wizard_ancestor`lb_3 within u_create_shift_wizard_machines
event ue_paint pbm_custom01
int X=1330
int Y=528
string Tag="lb3"
end type

on lb_3::dragdrop;call u_three_lb_wizard_ancestor`lb_3::dragdrop;INTEGER	li_Count1, &
		li_Count2, &
		li_Match

STRING		ls_Machine

DragObject	ldo_DraggedObject
ListBox	llb_ListBox

ldo_DraggedObject = DraggedObject ( )

CHOOSE CASE ldo_DraggedObject.TypeOf ( )
CASE ListBox!
	llb_ListBox = ldo_DraggedObject
	IF llb_ListBox.Tag = 'lb2' THEN
		FOR li_Count1 = 1 TO lb_2.TotalItems ( )
			IF lb_2.State ( li_Count1 ) = 1 THEN
				ls_Machine = lb_2.Text ( li_Count1 )
				li_Count2 = 1
				DO
					li_Count2 = FindItem ( ls_Machine, li_Count2 )
				LOOP UNTIL ( li_Count2 = -1 ) OR ( ls_Machine = Text ( li_Count2 ) )
				IF li_Count2 = -1 THEN
					AddItem ( ls_Machine )
				END IF
			END IF
		NEXT
	END IF
END CHOOSE
IF TotalItems ( ) > 0 THEN
	w_create_new_shift_wizard.wf_enable_next ( TRUE )
END IF
end on

on lb_3::constructor;call u_three_lb_wizard_ancestor`lb_3::constructor;iuos_Icons [ 1 ].s_TagValue = 'lb2'
iuos_Icons [ 1 ].s_EnterIcon = 'lbdragp.ico'
iuos_Icons [ 1 ].s_LeaveIcon = 'nothere.ico'

iuos_Icons [ 2 ].s_TagValue = 'lb3'
iuos_Icons [ 2 ].s_LeaveIcon = 'nothere.ico'
iuos_Icons [ 2 ].s_BeginIcon = 'lbdrag.ico'
iuos_Icons [ 2 ].s_EnterIcon = 'lbdrag.ico'
end on

