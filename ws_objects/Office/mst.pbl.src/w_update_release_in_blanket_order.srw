﻿$PBExportHeader$w_update_release_in_blanket_order.srw
$PBExportComments$Update release in blanket order
forward
global type w_update_release_in_blanket_order from Window
end type
type dw_order_detail from datawindow within w_update_release_in_blanket_order
end type
end forward

global type w_update_release_in_blanket_order from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean Visible=false
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_order_detail dw_order_detail
end type
global w_update_release_in_blanket_order w_update_release_in_blanket_order

type variables
Long iDelArray[500]
Long iDelCount

Long iShipper
Long iOrder
end variables

forward prototypes
public subroutine wf_update_releases (decimal nourcum)
end prototypes

public subroutine wf_update_releases (decimal nourcum);//************************************************************************
//* Declaration
//************************************************************************
Long iTotalRow
Long iRow
Long iReleaseRow
Long iRowId

Boolean 	bDelete
Boolean 	bConvert

Decimal 	nTheCum
Decimal 	nNetQty
Decimal 	nStdQty
Decimal 	nRatio
Decimal	nOrigQty

String  szPart
String  szShippingUnit

//************************************************************************
//* Initialization
//************************************************************************

For iRow = 1 to iDelCount
	iDelArray[iRow] = 0
Next 

iDelCount 	= 0

szPart			= f_get_order_info(iOrder, 'BLANKET PART')
szShippingUnit	= f_get_order_info(iOrder, "SHIPPING UNIT")

bConvert	= (Not IsNull(szShippingUnit)) AND &
			  (f_get_string_value(szShippingUnit) <> f_get_part_info(szPart, "STANDARD UNIT"))

If bConvert then
	nRatio	= f_convert_units(szShippingUnit, "", szPart, 1)
Else
	nRatio	= 1
End If

//************************************************************************
//* Main Routine
//************************************************************************

iTotalRow = dw_order_detail.RowCount()

dw_order_detail.SelectRow(0, FALSE)
dw_order_detail.SetSort("1a")
dw_order_detail.Sort()

For iRow = 1 to dw_order_detail.RowCount()

	nOrigQty	= dw_order_detail.GetItemNumber(iRow, "quantity")

	If iRow = 1 then
		nOurCum 	= f_get_value(nOurCum)
	Else
		nOurCum	= nTheCum
	End If

	nTheCum = f_get_value(dw_order_detail.GetItemNumber(iRow, "the_cum"))
	nNetQty = nTheCum - nOurCum

	If nNetQty <= 0 then				//Send to DelArray
		nTheCum							= nOurCum
		iDelArray[iDelCount + 1]	= iRow
		iDelCount						= iDelCount + 1
	Else

		nStdQty		= nNetQty * nRatio
		dw_order_detail.SetItem(iRow, "std_qty", nStdQty)

	End If

	If nNetQty <> nOrigQty then
		iRowId			= dw_order_detail.GetItemNumber(iRow, "row_id")
		Delete From master_prod_sched  
		Where ( origin = :iOrder ) AND
		  		( source = :iRowId );
		dw_order_detail.SetItem(iRow, "flag", 1)
	End If

	dw_order_detail.SetItem(iRow, "quantity", nNetQty)
	dw_order_detail.SetItem(iRow, "our_cum",	 nOurCum)
	dw_order_detail.SetItem(iRow, "the_cum",  nTheCum)
	
Next 

For iRow = iDelCount to 1 Step -1
	iReleaseRow	= iDelArray[iRow]
	iRowId		= dw_order_detail.GetItemNumber(iReleaseRow, "row_id")

	Delete From master_prod_sched  
	Where ( origin = :iOrder ) And
	  		( source = :iRowId )   ;

	dw_order_detail.DeleteRow(iReleaseRow)
Next	

For iRow	= 1 to dw_order_detail.RowCount()
	dw_order_detail.SetItem(iRow, "sequence", iRow)
Next

If bNoCommit then
	If dw_order_detail.Update() > 0 then
		bSuccess	= TRUE
	Else
		bSuccess	= FALSE
	End If
Else
	If dw_order_detail.Update() > 0 then
		Commit;
	Else
		RollBack;
	End If
End If

bFinish		= TRUE
bNoCommit	= FALSE




end subroutine

on open;Decimal	nOurCum

dw_order_detail.SetTransObject(sqlca)

iOrder	= Message.DoubleParm

Select order_header.our_cum  
Into   :nOurCum  
From   order_header  
Where  order_header.order_no = :iOrder   ;

dw_order_detail.Retrieve(iOrder)

wf_update_releases(nOurCum)

Close(this)
end on

on w_update_release_in_blanket_order.create
this.dw_order_detail=create dw_order_detail
this.Control[]={ this.dw_order_detail}
end on

on w_update_release_in_blanket_order.destroy
destroy(this.dw_order_detail)
end on

type dw_order_detail from datawindow within w_update_release_in_blanket_order
int X=220
int Y=129
int Width=1125
int Height=577
int TabOrder=1
boolean Visible=false
string DataObject="dw_list_of_releases_sd"
boolean LiveScroll=true
end type
