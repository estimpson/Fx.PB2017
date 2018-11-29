$PBExportHeader$w_ic_outside_part_list.srw
$PBExportComments$List of all parts for outside process
forward
global type w_ic_outside_part_list from w_sheet_4t
end type
type dw_parts from datawindow within w_ic_outside_part_list
end type
type p_1 from picture within w_ic_outside_part_list
end type
end forward

global type w_ic_outside_part_list from w_sheet_4t
string title = "Outside Process"
string menuname = "m_ic_outside_part"
event ue_assign ( decimal an_accumshipped,  decimal an_accumreceived )
dw_parts dw_parts
p_1 p_1
end type
global w_ic_outside_part_list w_ic_outside_part_list

type variables
String szPart                  //To keep the part number
String szVendor              //To keep the vendor code
STRING	is_ShippedPart

Decimal nCumShipped     //Accum Shipped
Decimal nCumReceived   //Accum Received

Long  iCurrentRow          //Current row number
end variables

forward prototypes
public subroutine wf_update_cum (decimal ncumshipped, integer iflag)
end prototypes

event ue_assign;// this event assignes values cum shipped and receeied for selected rows

long ll_row

ll_row = dw_parts.getselectedrow(0)

dw_parts.Retrieve ( )
if ll_row >  0 then
	dw_parts.ScrollToRow ( ll_row )
	dw_parts.SelectRow ( ll_row, TRUE )
//	dw_parts.object.accum_shipped [ ll_row ] = an_accumshipped
//	dw_parts.object.part_vendor_accum_received [ ll_row ] = an_accumreceived
end if	
	


end event

public subroutine wf_update_cum (decimal ncumshipped, integer iflag);If iCurrentRow > 0 then
	If iFlag = 1 then

  UPDATE	part_vendor
     SET	accum_shipped = :nCumShipped
	WHERE	part = :is_ShippedPart and vendor = :szVendor  ;
  COMMIT  ;

		dw_parts.SetItem(iCurrentRow, "Accum_Shipped", nCumShipped)

	Else

  UPDATE part_vendor
     SET	accum_received = :nCumShipped
   WHERE	part = :szPart and vendor = :szVendor  ;
  COMMIT  ;

		dw_parts.SetItem(iCurrentRow, "Part_Vendor_Accum_Received", nCumShipped)

	End If
End If
end subroutine

on open;dw_parts.SetTransObject(sqlca)
dw_parts.Retrieve()
end on

on w_ic_outside_part_list.create
int iCurrent
call super::create
if this.MenuName = "m_ic_outside_part" then this.MenuID = create m_ic_outside_part
this.dw_parts=create dw_parts
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parts
this.Control[iCurrent+2]=this.p_1
end on

on w_ic_outside_part_list.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parts)
destroy(this.p_1)
end on

type dw_parts from datawindow within w_ic_outside_part_list
integer x = 18
integer y = 28
integer width = 3442
integer height = 1568
integer taborder = 1
boolean titlebar = true
string title = "List of parts returning from outside process                 = Unprocessed"
string dataobject = "dw_parts_for_outside_process"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;// modified event to pass values using associative array

n_cst_associative_array l_ncst

If row > 0 then
	selectrow(0, false)
	selectrow(row, true)
	l_ncst.of_setitem('parent_part',dw_parts.object.parent_part[ row ])
	l_ncst.of_setitem('part',dw_parts.object.part [ row ])
	l_ncst.of_setitem('vendor',dw_parts.object.vendor[ row ])
	
	OpenSheetWithParm(w_ic_outside_reconcile,l_ncst, gnv_App.of_GetFrame(), 3, Original!)
	
End If

end event

type p_1 from picture within w_ic_outside_part_list
integer x = 1573
integer y = 32
integer width = 82
integer height = 80
boolean bringtotop = true
string picturename = "LOGO2.BMP"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

