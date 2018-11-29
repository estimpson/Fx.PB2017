$PBExportHeader$w_edit_kanban.srw
forward
global type w_edit_kanban from w_sheet_4t
end type
type dw_1 from u_d_kanban within w_edit_kanban
end type
end forward

global type w_edit_kanban from w_sheet_4t
integer x = 832
integer y = 356
integer width = 2885
integer height = 1372
string title = "KANBAN Processing Screen"
string menuname = "m_edit_kanban"
long backcolor = 12632256
event ue_save pbm_custom01
event ue_refresh pbm_custom02
event ue_delete pbm_custom03
event ue_shiftdelete pbm_custom04
event ue_undelete pbm_custom05
event ue_shiftundelete pbm_custom06
dw_1 dw_1
end type
global w_edit_kanban w_edit_kanban

type variables
INTEGER	il_OrderNo

BOOLEAN	ib_Modified
end variables

forward prototypes
private function integer wf_generate_kanban ()
end prototypes

on ue_save;SetPointer ( Hourglass! )
IF dw_1.Update ( ) = -1 THEN
	SetPointer ( Arrow! )
	MessageBox ( 'Warning', 'Unable to save changes!' )
ELSE
	SetPointer ( Arrow! )
	ib_Modified = FALSE
END IF

end on

on ue_refresh;dw_1.Retrieve ( il_OrderNo )
end on

on ue_delete;LONG	ll_Response, &
		ll_Count

ll_Response = dw_1.GetSelectedRow ( 0 )
IF ll_Response = 0 THEN Return

ll_Response = MessageBox ( 'Warning', 'Sure to mark selected KANBAN numbers as deleted?', Question!, YesNo!, 2 )
IF ll_Response = 1 THEN
	ll_Count = dw_1.GetSelectedRow ( 0 )
	DO WHILE ll_Count <= dw_1.RowCount ( ) AND ll_Count > 0
		IF dw_1.GetItemString ( ll_Count, 'kanban_status' ) = 'A' THEN
			dw_1.SetItem ( ll_Count, 'kanban_status', 'D' )
		END IF
		ll_Count = dw_1.GetSelectedRow ( ll_Count )
	LOOP
	dw_1.SelectRow ( 0, FALSE )
END IF
end on

on ue_shiftdelete;LONG	ll_Response, &
		ll_Count

ll_Response = dw_1.GetSelectedRow ( 0 )
IF ll_Response = 0 THEN Return

ll_Count = dw_1.GetSelectedRow ( 0 )
DO WHILE ll_Count <= dw_1.RowCount ( ) AND ll_Count > 0
	IF dw_1.GetItemString ( ll_Count, 'kanban_status' ) = 'A' THEN
		dw_1.SetItem ( ll_Count, 'kanban_status', 'D' )
	END IF
	ll_Count = dw_1.GetSelectedRow ( ll_Count )
LOOP
dw_1.SelectRow ( 0, FALSE )
end on

on ue_undelete;LONG	ll_Response, &
		ll_Count

ll_Response = dw_1.GetSelectedRow ( 0 )
IF ll_Response = 0 THEN Return

ll_Response = MessageBox ( 'Warning', 'Sure to unmark selected KANBAN numbers as deleted?', Question!, YesNo!, 2 )
IF ll_Response = 1 THEN
	ll_Count = dw_1.GetSelectedRow ( 0 )
	DO WHILE ll_Count <= dw_1.RowCount ( ) AND ll_Count > 0
		IF dw_1.GetItemString ( ll_Count, 'kanban_status' ) = 'D' THEN
			dw_1.SetItem ( ll_Count, 'kanban_status', 'A' )
		END IF
		ll_Count = dw_1.GetSelectedRow ( ll_Count )
	LOOP
	dw_1.SelectRow ( 0, FALSE )
END IF
end on

on ue_shiftundelete;LONG	ll_Response, &
		ll_Count

ll_Response = dw_1.GetSelectedRow ( 0 )
IF ll_Response = 0 THEN Return

ll_Count = dw_1.GetSelectedRow ( 0 )
DO WHILE ll_Count <= dw_1.RowCount ( ) AND ll_Count > 0
	IF dw_1.GetItemString ( ll_Count, 'kanban_status' ) = 'D' THEN
		dw_1.SetItem ( ll_Count, 'kanban_status', 'A' )
	END IF
	ll_Count = dw_1.GetSelectedRow ( ll_Count )
LOOP
dw_1.SelectRow ( 0, FALSE )
end on

private function integer wf_generate_kanban ();LONG	ll_Begin, &
		ll_End, &
		ll_Counter

INTEGER	li_NumberLength, &
			li_NumberSegmentLength

STRING	ls_KANBANNumberRoot, &
		ls_TempKANBANNumber, &
		ls_BeginKANBANNumber, &
		ls_EndKANBANNumber, &
		l11, &
		l12, &
		l13, &
		l14, &
		l15, &
		l16, &
		l17, &
		ls_Zeros = '00000000'

DECIMAL {6}	ldec_StdQty
// Check if KANBAN data already exists for this order.

   SELECT	kanban_number
     INTO	:ls_TempKANBANNumber
     FROM	kanban
    WHERE	order_no = :il_OrderNo  ;

IF SQLCA.SQLCode <> 100 THEN
	Return 1
END IF

// Get Beginning and Ending KANBAN numbers for this order

   SELECT	begin_kanban_number,
			end_kanban_number
     INTO	:ls_BeginKANBANNumber,
			:ls_EndKANBANNumber
     FROM	order_header
    WHERE	order_no = :il_OrderNo  ;

IF IsNull ( ls_BeginKANBANNumber ) OR IsNull ( ls_EndKANBANNumber ) THEN
	Return 0
END IF

// Determine begin and end numeric portions of KANBAN numbers
li_NumberLength = LenA ( ls_BeginKANBANNumber )

IF li_NumberLength < 1 THEN
	Return -1
END IF
IF NOT IsNumber ( RightA ( ls_BeginKANBANNumber, 1 ) ) THEN
	Return -3
END IF

ll_Counter = 2
li_NumberSegmentLength = 1
DO WHILE ( IsNumber ( RightA ( ls_BeginKANBANNumber, ll_Counter ) ) AND ll_Counter <= li_NumberLength )
	ll_Counter ++
	li_NumbersegmentLength ++
LOOP
ls_KANBANNumberRoot = LeftA ( ls_BeginKANBANNumber, li_NumberLength - li_NumberSegmentLength )
IF ls_KANBANNumberRoot <> LeftA ( ls_EndKANBANNumber, li_NumberLength - li_NumberSegmentLength ) THEN
	Return -2
END IF
ll_Begin = Long ( RightA ( ls_BeginKANBANNumber, li_NumberSegmentLength ) )
ll_End = Long ( RightA ( ls_EndKANBANNumber, li_NumberSegmentLength ) )

// Generate KANBAN data for KANBAN numbers in range

   SELECT	line11,
			line12,
			line13,
			line14,
			line15,
			line16,
			line17,
			standard_pack
     INTO	:l11,
			:l12,
			:l13,
			:l14,
			:l15,
			:l16,
			:l17,
			:ldec_StdQty
     FROM	order_header
    WHERE	order_no = :il_OrderNo  ;


FOR ll_Counter = ll_Begin TO ll_End
	
	ls_TempKANBANNumber = ls_KANBANNumberRoot + &
		LeftA ( ls_Zeros, li_NumberSegmentLength - LenA ( String ( ll_Counter ) ) ) + &
		String ( ll_Counter )

	   INSERT INTO kanban
				(	order_no,
					kanban_number,
					line11,
					line12,
					line13,
					line14,
					line15,
					line16,
					line17,
					status,
					standard_quantity )
	   VALUES	(	:il_OrderNo,
					:ls_TempKANBANNumber,
					:l11,
					:l12,
					:l13,
					:l14,
					:l15,
					:l16,
					:l17,
					'A',
					:ldec_StdQty )  ;

NEXT

commit  ;

Return 1
end function

on open;il_OrderNo = w_blanket_order.iOrder

IF wf_generate_kanban ( ) = 0 THEN
	MessageBox ( 'Warning', 'No KANBAN data exists for this order...exiting!' )
	PostEvent ( 'close' )
	Return
END IF

dw_1.SetTransObject ( SQLCA )
dw_1.Retrieve ( w_blanket_order.iOrder )
end on

on close;INTEGER	li_Response

IF ib_Modified THEN
	li_Response = MessageBox ( '???', 'Save changes?', StopSign!, YesNo!  )
	IF li_Response = 1 THEN
		TriggerEvent ( 'ue_save' )
	END IF
END IF
Close ( This )
end on

on w_edit_kanban.create
int iCurrent
call super::create
if this.MenuName = "m_edit_kanban" then this.MenuID = create m_edit_kanban
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_edit_kanban.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from u_d_kanban within w_edit_kanban
integer y = 12
integer width = 2848
integer height = 1264
boolean vscrollbar = true
boolean border = false
end type

on doubleclicked;call u_d_kanban::doubleclicked;STRING	ls_DWObject
LONG	ll_Row

ls_DWObject = GetObjectAtPointer ( )

IF LeftA ( ls_DWObject, PosA ( ls_DWObject, '~t', 1 ) - 1 ) = 'check_box' THEN
	ll_Row = Integer ( RightA ( ls_DWObject, LenA ( ls_DWObject ) - PosA ( ls_DWObject, '~t', 1 ) ) )
	SelectRow ( ll_Row, NOT IsSelected ( ll_Row ) )
END IF
end on

