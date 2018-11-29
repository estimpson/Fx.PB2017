$PBExportHeader$w_edi_raw_data_processor.srw
$PBExportComments$(med)
forward
global type w_edi_raw_data_processor from Window
end type
type cb_wait from commandbutton within w_edi_raw_data_processor
end type
type dw_message from datawindow within w_edi_raw_data_processor
end type
type st_date_set from statictext within w_edi_raw_data_processor
end type
type st_2 from statictext within w_edi_raw_data_processor
end type
type st_group from statictext within w_edi_raw_data_processor
end type
type st_1 from statictext within w_edi_raw_data_processor
end type
type dw_stack from datawindow within w_edi_raw_data_processor
end type
type dw_edi_log from datawindow within w_edi_raw_data_processor
end type
type dw_mapped_edi_data from datawindow within w_edi_raw_data_processor
end type
type dw_edi_detail from datawindow within w_edi_raw_data_processor
end type
type dw_edi_header from datawindow within w_edi_raw_data_processor
end type
type dw_edi_overlay_structure from datawindow within w_edi_raw_data_processor
end type
type mle_raw_data from multilineedit within w_edi_raw_data_processor
end type
type dw_raw_data from datawindow within w_edi_raw_data_processor
end type
type gb_3 from groupbox within w_edi_raw_data_processor
end type
type gb_2 from groupbox within w_edi_raw_data_processor
end type
type gb_overlay from groupbox within w_edi_raw_data_processor
end type
type gb_message from groupbox within w_edi_raw_data_processor
end type
end forward

type st_overlay_structure from structure
    long itemposition
    long itemlength
    string itemname
    boolean b_trigger
    string filter_value
    boolean is_kanban
end type

global type w_edi_raw_data_processor from Window
int X=0
int Y=0
int Width=2903
int Height=2396
boolean TitleBar=true
string Title="EDI Raw Data Processor"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
event process pbm_custom01
cb_wait cb_wait
dw_message dw_message
st_date_set st_date_set
st_2 st_2
st_group st_group
st_1 st_1
dw_stack dw_stack
dw_edi_log dw_edi_log
dw_mapped_edi_data dw_mapped_edi_data
dw_edi_detail dw_edi_detail
dw_edi_header dw_edi_header
dw_edi_overlay_structure dw_edi_overlay_structure
mle_raw_data mle_raw_data
dw_raw_data dw_raw_data
gb_3 gb_3
gb_2 gb_2
gb_overlay gb_overlay
gb_message gb_message
end type
global w_edi_raw_data_processor w_edi_raw_data_processor

type prototypes
//FUNCTION Boolean QuickRename(string szNothing) LIBRARY "QUICKREN.DLL"
end prototypes

type variables
Boolean 	bHeadLine	//Whether this is a head line
Boolean 	bSet862		//Whether this is a data set 862
Boolean 	bCalcPQ		//Whether recalc based on PQ quantity
Boolean	bActivated	//Whether the screen is activated
Boolean	bCumFlag = FALSE	//Wehther calculate cum instead of net
Boolean 	bDetailSection	//Whether in part section
Boolean	ib_fab_cum	//Whether calculate the FAT cum
Boolean	ib_kanban	//Whether this is kanban item
BOOLEAN	ib_Auto

String	szLine		//Data in current line
String	szOverlay		//Overlay group code
String	szPart		//Item part number
String	szDestination	//Item desitination
String	szSubDestination	//Destination at detail level
String	szRelease	//Item releases
String	szQty		//Item quantity
String	szDockCode	//Item dock code
String	szZoneCode	//Item zone code
String	szDate		//Item date
String	szItemName	//Item name
String	szItemValue	//Item value
String	szModelYear	//Item Model Year
String	szPO		//Item Purchase Order Number
String	szConsignee	//Shippment consignee
String	is_line_feed_code	//line feed code
String	is_fab_date	//Fab Date
String	is_raw_date	//Raw Date
String	is_kanban[]	//Kanban
String	is_begin_kanban	//Begin Kanban Number
String	is_end_kanban	//End kanban Number
String	is_Custom1Header, &
	is_Custom2Header, &
	is_Custom3Header, &
	is_Custom1Detail, &
	is_Custom2Detail, &
	is_Custom3Detail
STRING	is_Path

Decimal	nQty		//Item numeric value
Decimal	nTheCum		//Their cum
Decimal 	nOurCum		//Our cum
Decimal	nInitTheCum	//Initial value for the cum
Decimal	nInitOurCum	//Initial value for our cum
Decimal	ic_fabcum
Decimal	ic_rawcum

Long	iOverlayRow	//Current line # in overlay structure
Long 	iTotalRows	//Total # of rows
Long 	iRow		//Current row #
Long	iLineNo		//Current line #
Long	iRowFound	//Row found 
Long	iItemLine		//Item Line number
Long	iItemPosition	//Item position
Long	iItemLength	//Item length
Long	iLineb_triggerOutPut	//Line # for recalc / output
Long	iPointer		//Current line in raw datawindow
Long	iFileOutput	//File # for output
Long	iFileKanban	//File # for keeping kanban

Integer	iMaxRow	=75	//Max # of rows
Integer	iMaxCol	= 10	//Max # of columns
Integer	ii_Kanban_Count = 0

Date	id_fab_date, &
	id_raw_date

st_overlay_structure stOverlay[75, 10]

str_progress sParm
end variables

forward prototypes
public subroutine wf_output_data ()
public subroutine wf_output_data ()
public subroutine wf_save_to_stack ()
public subroutine wf_recalc_qty ()
public subroutine wf_parsor_raw_data ()
public subroutine wf_create_array ()
public subroutine wf_read_from_stack ()
public function string wf_read_raw_data ()
end prototypes

on process;Long	l_Handle
//FileDelete("edidata.txt")
wf_read_raw_data()
bFinish	= TRUE
IF ib_Auto THEN
	Close(w_edi_raw_data_processor)
END IF

end on

public subroutine wf_output_data ();string &
	ls_destination

Long &
	iLastRow

integer &
	li_ptr

dw_mapped_edi_data.InsertRow(0)
iLastRow	= dw_mapped_edi_data.RowCount()

If RightTrim(szConsignee) > ' ' then
	szDestination	= szConsignee
End If

If szSubDestination > " " then	//If detail line has dest#, use it
	dw_mapped_edi_data.SetItem(iLastRow, "destination", szSubDestination)
Else
	dw_mapped_edi_data.SetItem(iLastRow, "destination", szDestination)
End If

dw_mapped_edi_Data.SetItem(iLastRow, "part", szPart)
dw_mapped_edi_data.SetItem(iLastRow, "date_stamp", Date(MidA(szDate, 3, 2) + "/" + MidA(szDate, 5, 2) + "/" + MidA(szDate, 1, 2) ))
dw_mapped_edi_data.SetItem(iLastRow, "quantity", Dec(szQty))
dw_mapped_edi_data.SetItem(iLastRow, "release_no", szRelease)
dw_mapped_edi_data.SetItem(iLastRow, "dock", szDockCode)
dw_mapped_edi_data.SetItem(iLastRow, "zone_code", szZoneCode)
dw_mapped_edi_data.SetItem(iLastRow, "model_year", szModelYear)
dw_mapped_edi_data.SetItem(iLastRow, "po", szPO)
dw_mapped_edi_data.SetItem(iLastRow, "line_feed_code", is_line_feed_code)
dw_mapped_edi_data.SetItem(iLastRow, "fab_cum", ic_FabCum )
dw_mapped_edi_data.SetItem(iLastRow, "raw_cum", ic_RawCum)
dw_mapped_edi_data.SetItem(iLastRow, "fab_date", Date(MidA(is_fab_date, 3, 2) + "/" + MidA(is_fab_date, 5, 2) + "/" + MidA(is_fab_date, 1, 2) ) )
dw_mapped_edi_data.SetItem(iLastRow, "raw_date", Date(MidA(is_raw_date, 3, 2) + "/" + MidA(is_raw_date, 5, 2) + "/" + MidA(is_raw_date, 1, 2) ) )

ic_FabCum	= f_get_value( ic_FabCum )
ic_RawCum	= f_get_value( ic_RawCum )

is_raw_date	= f_get_string_value( is_raw_date )
is_fab_date	= f_get_string_value( is_fab_date )

FileWrite(iFileOutput, szPart)
FileWrite(iFileOutput, szQty )
FileWrite(iFileOutput, szDate)
FileWrite(iFileOutput, szRelease)

If szSubDestination > " " then
	ls_destination	= szSubDestination
	FileWrite(iFileOutput, szSubDestination)
Else
	ls_destination	= szDestination
	FileWrite(iFileOutput, szDestination)
End If

FileWrite(iFileOutput,	szZoneCode)
FileWrite(iFileOutput, 	szDockCode)
FileWrite(iFileOutput, 	szModelYear)
FileWrite(iFileOutput, 	szPO)
FileWrite(iFileOutput, 	is_line_feed_code)
FileWrite(iFileOutput, 	string(ic_fabcum) )
FileWrite(iFileOutput, 	string(ic_rawcum) )
FileWrite(iFileOutput, 	is_fab_date )
FileWrite(iFileOutput, 	is_raw_date )
FileWrite ( iFileOutput, is_Custom1Header )
FileWrite ( iFileOutput, is_Custom2Header )
FileWrite ( iFileOutput, is_Custom3Header )
FileWrite ( iFileOutput, is_Custom1Detail )
FileWrite ( iFileOutput, is_Custom2Detail )
FileWrite ( iFileOutput, is_Custom3Detail )

If ii_kanban_count > 0 then	//Output file to kanban text
	FileWrite( iFileKanban, szPart )
	FileWrite( iFileKanban, ls_destination )
	FileWrite( iFileKanban, szModelYear )
	FileWrite( iFileKanban, szPO )
	FileWrite( iFileKanban, f_get_string_value( is_begin_kanban ) )
	FileWrite( iFileKanban, f_get_string_value( is_end_kanban ) )

	for li_ptr = 1 to ii_kanban_count 
		FileWrite( iFileKanban, f_get_string_value( is_kanban[ li_ptr ] ) )
		is_kanban[ li_ptr ]	= ''
	next

	ii_kanban_count	= 0		
end if

//====================== old code ============================
//Long iLastRow
//
//dw_mapped_edi_data.InsertRow(0)
//iLastRow	= dw_mapped_edi_data.RowCount()
//
//If RightTrim(szConsignee) > ' ' then
//	szDestination	= szConsignee
//End If
//
//If szSubDestination > " " then	//If detail line has dest#, use it
//	dw_mapped_edi_data.SetItem(iLastRow, "destination", szSubDestination)
//Else
//	dw_mapped_edi_data.SetItem(iLastRow, "destination", szDestination)
//End If
//
//dw_mapped_edi_Data.SetItem(iLastRow, "part", szPart)
//dw_mapped_edi_data.SetItem(iLastRow, "date_stamp", Date(Mid(szDate, 3, 2) + "/" + Mid(szDate, 5, 2) + "/" + Mid(szDate, 1, 2) ))
//dw_mapped_edi_data.SetItem(iLastRow, "quantity", Dec(szQty))
//dw_mapped_edi_data.SetItem(iLastRow, "release_no", szRelease)
//dw_mapped_edi_data.SetItem(iLastRow, "dock", szDockCode)
//dw_mapped_edi_data.SetItem(iLastRow, "zone_code", szZoneCode)
//dw_mapped_edi_data.SetItem(iLastRow, "model_year", szModelYear)
//dw_mapped_edi_data.SetItem(iLastRow, "po", szPO)
//dw_mapped_edi_data.SetItem(iLastRow, "line_feed_code", is_line_feed_code)
//
//FileWrite(iFileOutput, szPart)
//FileWrite(iFileOutput, szQty )
//FileWrite(iFileOutput, szDate)
//FileWrite(iFileOutput, szRelease)
//If szSubDestination > " " then
//	FileWrite(iFileOutput, szSubDestination)
//Else
//	FileWrite(iFileOutput, szDestination)
//End If
//FileWrite(iFileOutput, szZoneCode)
//FileWrite(iFileOutput, szDockCode)
//FileWrite(iFileOutput, szModelYear)
//FileWrite(iFileOutput, szPO)
//FileWrite(iFileOutput, is_line_feed_code)
//
end subroutine

public subroutine wf_save_to_stack ();Long iLastRow

dw_stack.InsertRow(0)
iLastRow	= dw_stack.RowCount()

dw_stack.SetItem(iLastRow, "value1", szDate)
dw_stack.SetItem(iLastRow, "value2", szQty)
end subroutine

public subroutine wf_recalc_qty ();Long iRow
Long iLastRow
Long iTotalRows

Decimal nOffset
Decimal nQty
Decimal nCumQty

iRow			= 1
iTotalRows	= dw_stack.RowCount()

If (Not IsNull(nTheCum) ) AND (Not IsNull(nOurCum)) then

	nOffset		= nOurCum - nTheCum

	Do while (iRow <= iTotalRows) 
		nQty	= Dec(dw_stack.GetItemString(iRow, "value2"))

		If (nOffSet > 0) AND (nQty > nOffSet) then
			nQty	= nQty - nOffset
			dw_stack.SetItem(iRow, "value2", String(nQty))
			nOffset	= 0
		Else
			If (nOffSet >0) AND (nQty <= nOffSet) then
				dw_stack.SetItem(iRow, "value2", '0')
				nOffset	= nOffset - nQty
				nQty		= 0
			Else		//(nOffset < 0)
				nQty		= nQty - nOffSet
				dw_stack.SetItem(iRow, "value2", String(nQty))
				nOffSet	= 0
			End If
		End If
	
		szDate	= dw_stack.getitemstring( irow, 'value1' )
		szQty		= dw_stack.getitemstring( irow, 'value2' )

		wf_output_data()

		iRow ++

	Loop

Else		//Only calculate the cum

	nCumQty	= f_get_value(nTheCum)

	Do while (iRow <= iTotalRows) 

		nCumQty	= Dec(dw_stack.GetItemString(iRow, "value2")) + nCumQty

		szDate	= dw_stack.getitemstring( irow, 'value1' )
		szQty		= string(nCumQty)

		wf_output_data()

		iRow ++
	Loop

End If

dw_stack.Reset()

nTheCum	= nInitTheCum
nOurCum	= nInitOurCum


//------------------- Old Code as date of 07/06/1996 ----------------------

//Long iRow
//Long iLastRow
//Long iTotalRows
//
//Decimal nOffset
//Decimal nQty
//Decimal nCumQty
//
//iRow	= 1
//iTotalRows	= dw_stack.RowCount()
//
//If (Not IsNull(nTheCum) ) AND (Not IsNull(nOurCum)) then
//
//	nOffset		= nOurCum - nTheCum
//
//	Do while (iRow <= iTotalRows) 
//		nQty	= Dec(dw_stack.GetItemString(iRow, "value2"))
//
//		If (nOffSet > 0) AND (nQty > nOffSet) then
//			nQty	= nQty - nOffset
//			dw_stack.SetItem(iRow, "value2", String(nQty))
//			nOffset	= 0
//		Else
//			If (nOffSet >0) AND (nQty <= nOffSet) then
//				dw_stack.SetItem(iRow, "value2", '0')
//				nOffset	= nOffset - nQty
//				nQty		= 0
//			Else		//(nOffset < 0)
//				nQty		= nQty - nOffSet
//				dw_stack.SetItem(iRow, "value2", String(nQty))
//				nOffSet	= 0
//			End If
//		End If
//	
//		dw_mapped_edi_data.InsertRow(0)
//		iLastRow		= dw_mapped_edi_data.RowCount()
//		szDate		= dw_stack.GetItemString(iRow, "value1")
//	
//		If RightTrim(szConsignee) > ' ' then
//			szDestination	= szConsignee
//		End If
//	
//		If szSubDestination > " " then
//			dw_mapped_edi_data.SetItem(iLastRow, "destination", szSubDestination)	
//		Else
//			dw_mapped_edi_data.SetItem(iLastRow, "destination", szDestination)
//		End If
//
//		dw_mapped_edi_Data.SetItem(iLastRow, "part", szPart)
//		dw_mapped_edi_data.SetItem(iLastRow, "date_stamp", Date(Mid(szDate, 3, 2) + "/" + Mid(szDate, 5, 2) + "/" + Mid(szDate, 1, 2) ))
//		dw_mapped_edi_data.SetItem(iLastRow, "quantity", nQty)
//		dw_mapped_edi_data.SetItem(iLastRow, "release_no", szRelease)
//		dw_mapped_edi_data.SetItem(iLastRow, "dock", szDockCode)
//		dw_mapped_edi_data.SetItem(iLastRow, "zone_code", szZoneCode)
//		dw_mapped_edi_data.SetItem(iLastRow, "model_year", szModelYear)
//		dw_mapped_edi_data.SetItem(iLastRow, "po", szPO)
//		dw_mapped_edi_data.SetItem(iLastRow, "line_feed_code", is_Line_Feed_Code)
//
//		FileWrite(iFileOutput, szPart)
//		FileWrite(iFileOutput, String(nQty) )
//		FileWrite(iFileOutput, szDate)
//		FileWrite(iFileOutput, szRelease)
//
//		If szSubDestination > " " then
//			FileWrite(iFileOutput, szSubDestination)
//		Else
//			FileWrite(iFileOutput, szDestination)
//		End If
//
//		FileWrite(iFileOutput, szZoneCode)
//		FileWrite(iFileOutput, szDockCode)
//		FileWrite(iFileOutput, szModelYear)
//		FileWrite(iFileOutput, szPO)
//		FileWrite(iFileOutput, is_Line_Feed_Code)
//
//		iRow ++
//
//	Loop
//
//Else		//Only calculate the cum
//
//	nCumQty	= f_get_value(nTheCum)
//
//	Do while (iRow <= iTotalRows) 
//
//		nCumQty	= Dec(dw_stack.GetItemString(iRow, "value2")) + nCumQty
//
//		dw_stack.SetItem(iRow, "value2", nQty)
//	
//		dw_mapped_edi_data.InsertRow(0)
//		iLastRow		= dw_mapped_edi_data.RowCount()
//		szDate		= dw_stack.GetItemString(iRow, "value1")
//
//		If RightTrim(szConsignee) > ' ' then
//			szDestination	= szConsignee
//		End If
//
//		If szSubDestination > " " then
//			dw_mapped_edi_data.SetItem(iLastRow, "destination", szSubDestination)	
//		Else
//			dw_mapped_edi_data.SetItem(iLastRow, "destination", szDestination)
//		End If	
//
//		dw_mapped_edi_Data.SetItem(iLastRow, "part", szPart)
//		dw_mapped_edi_data.SetItem(iLastRow, "date_stamp", Date(Mid(szDate, 3, 2) + "/" + Mid(szDate, 5, 2) + "/" + Mid(szDate, 1, 2) ))
//		dw_mapped_edi_data.SetItem(iLastRow, "quantity", nCumQty)
//		dw_mapped_edi_data.SetItem(iLastRow, "release_no", szRelease)
//		dw_mapped_edi_data.SetItem(iLastRow, "dock", szDockCode)
//		dw_mapped_edi_data.SetItem(iLastRow, "zone_code", szZoneCode)
//		dw_mapped_edi_data.SetItem(iLastRow, "model_year", szModelYear)
//		dw_mapped_edi_data.SetItem(iLastRow, "po", szPO)
//		dw_mapped_edi_data.SetItem(iLastRow, "line_feed_code", is_Line_Feed_Code)
//
//
//		FileWrite(iFileOutput, szPart)
//		FileWrite(iFileOutput, String(nCumQty) )
//		FileWrite(iFileOutput, szDate)
//		FileWrite(iFileOutput, szRelease)
//
//		If szSubDestination > " " then
//			FileWrite(iFileOutput, szSubDestination)
//		Else
//			FileWrite(iFileOutput, szDestination)
//		End If
//
//		FileWrite(iFileOutput, szZoneCode)
//		FileWrite(iFileOutput, szDockCode)
//		FileWrite(iFileOutput, szModelYear)
//		FileWrite(iFileOutput, szPO)
//		FileWrite(iFileOutput, is_Line_Feed_Code)
//
//
//
//		iRow ++
//	Loop
//
//End If
//
//dw_stack.Reset()
//
//nTheCum	= nInitTheCum
//nOurCum	= nInitOurCum
//
//
end subroutine

public subroutine wf_parsor_raw_data ();//************************************************************************
//* Declaration
//************************************************************************
Boolean 	bb_trigger					//Whether to output
Boolean	bPassFilter				//Whether passed the filter
Boolean  bReadyforSave			//Whether to save
//BOOLEAN	lb_OverlayExists = TRUE

Long		iCol

String	szFilter

//************************************************************************
//* Initialization
//************************************************************************

ii_kanban_count	= 0
iRow 					= 0
bHeadLine			= FALSE
iTotalRows			= dw_raw_data.RowCount()
SetNull(nOurCum)
SetNull(nTheCum)

sParm.title			= "Step 2: Process raw data"
OpenWithParm(w_progress, sParm)
w_progress.cb_cancel.visible	=  FALSE

iFileOutput	= FileOpen( is_Path + "EDIDATA.TXT", LineMode!, Write!, Shared!, Replace! )
iFileKanban	= FileOpen( is_Path + "KANBAN.TXT", 	LineMode!, Write!, Shared!, Replace! )

//************************************************************************
//* Main Routine
//************************************************************************

iTotalRows		= dw_raw_data.RowCount()
bDetailSection	= FALSE

For iRow = 1 to iTotalRows

	szLine	= dw_raw_data.GetItemString(iRow, "value")
	
	If PosA(szLine, "STX12") > 0 then			//Head section
		bHeadLine			= TRUE
		bSet862				= (PosA(szLine, "862") > 0)
		szOverlay			= MidA(szLine,72, 3)
		st_group.text		= szOverlay
		If bSet862 then
			dw_edi_overlay_structure.Retrieve(szOverlay, "862")
			st_date_set.text	= "862"
		Else
			dw_edi_overlay_structure.Retrieve(szOverlay, "830")
			st_date_set.text	= "830"
		End If

		wf_create_array()

		dw_message.InsertRow(1)
		szLine	= String(Today()) + " " + String(Now()) + " Processing overlay " + szOverlay + "  data set " +  st_date_set.text
		dw_message.SetItem(1, 1, szLine)
	
	Else												//Detail section

		bb_trigger			= FALSE
		bPassFilter		= TRUE
//		IF lb_OverlayExists THEN
//			bPassFilter = TRUE
//		ELSE
//			bPassFilter = FALSE
//		END IF
		bReadyforSave	= FALSE

		szLine	= dw_raw_data.GetItemString(iRow, 1)
		iLineNo	= Long(MidA(szLine, 1, 2))

		iCol = 1
		Do while bPassFilter AND (iCol < 10) AND (stOverlay[iLineNo, iCol].ItemName > " ")

			szItemName	= stOverlay[iLineNo, iCol].ItemName
			szItemValue	= MidA(szLine, stOverlay[iLineNo, iCol].ItemPosition, stOverlay[iLineNo, iCol].ItemLength)
			ib_kanban	= stOverlay[ iLineNo, iCol ].is_kanban
			
			If Not bb_trigger then
				bb_trigger		= stOverlay[iLineNo, iCol].b_trigger
			End If

			If szItemName > " " then
	
				Choose Case szItemName

					Case "part"
						szPart		= RightTrim(szItemValue)
						dw_edi_log.InsertRow(1)
						dw_edi_log.SetItem(1, "destination", szDestination)
						dw_edi_log.SetItem(1, "part", szPart)
						dw_edi_log.SetItem(1, "release_no", szRelease)
						If bSet862 then
							dw_edi_log.SetItem(1, "type", "862")
						Else
							dw_edi_log.SetItem(1, "type", "830")						
						End If

						szSubDestination	= ""
						//bDetailSection		= TRUE

					Case "release"
						
						szRelease		= szItemValue
	
						If Not bSet862 then
							szRelease	= "SET830" + szRelease
						End If

					Case "date"
						szDate			= RightTrim(szItemValue)
						bReadyforSave	= TRUE
						bDetailSection	= TRUE
	
					Case "dock"
						szDockCode	= szItemValue

					Case "zone_code"
						szZoneCode	= szItemValue

					Case "line_feed_code"
						is_line_feed_code	= szItemValue

					Case "custom1_header"
						is_Custom1Header = szItemValue

					Case "custom2_header"
						is_Custom2Header = szItemValue

					Case "custom3_header"
						is_Custom3Header = szItemValue

					Case "custom1_detail"
						is_Custom1Detail = szItemValue

					Case "custom2_detail"
						is_Custom2Detail = szItemValue

					Case "custom3_detail"
						is_Custom3Detail = szItemValue

					Case "destination"

						If Not bDetailSection then
							szDestination = szItemValue
						End If

					Case "subdestination"
						szSubDestination	= szItemValue

					Case "quantity"
						szQty			= RightTrim(szItemValue)

					Case "filter"
						szFilter		= szItemValue
						bPassFilter	= (szFilter = 	stOverlay[iLineNo, iCol].filter_value)				
					
					Case "the_cum"
						nTheCum		= Dec(szItemValue)
				
					Case "our_cum"
						nOurCum		= Dec(szItemValue)

					Case "model_year"
						szModelYear	= szItemValue

					Case "po"
						szPO			= szItemValue

					Case "consignee"
						szConsignee	= szItemValue		

					Case 'raw_cum'
						ic_RawCum	= dec( szitemvalue )

					Case 'fab_cum'
						ic_FabCum	= dec( szitemvalue )

					Case 'fab_date'
						is_fab_date	= szitemvalue

					Case 'raw_date'
						is_raw_date	= szitemvalue

					Case 'begin_kanban'
						is_begin_kanban	= szItemValue

					Case 'end_kanban'
						is_end_kanban		= szItemValue
					
					Case Else
						if ib_kanban then
							if szItemName = 'kanban_line' then
								ii_kanban_count ++
								is_kanban[ ii_kanban_count ]	= szItemValue
							end if
						end if

				End Choose
			End If
		
			iCol ++

		Loop

		If bPassFilter then	//Only process those 'good' records

			if ( bCalcPQ AND bReadyForSave ) or ( ib_fab_cum AND bReadyForSave ) then
				wf_save_to_stack()
			end if

			if bb_trigger then
				if bCalcPQ then
					wf_recalc_qty()
				else
					if ib_fab_cum then	
						wf_read_from_stack()
					else
						wf_output_data()
					end if
				end If

				bDetailSection	= FALSE

			end If

		End If

	End If

	w_progress.wf_progress(iRow / iTotalRows, " Part:" + szPart + "  Date:" + RightTrim(szDate) + " Qty:" + szQty)

Next

Close(w_progress)

dw_message.InsertRow(1)
szLine	= String(Today()) + " " + String(Now()) + " Converted dx-xf-ff.mon"
dw_message.SetItem(1, 1, szLine)

If FileDelete( is_Path + "dx-xf-ff.mon") then
	dw_message.InsertRow(1)
	szLine	= String(Today()) + " " + String(Now()) + " Deleted flat file dx-xf-ff.mon"
	dw_message.SetItem(1, 1, szLine)
Else
	dw_message.InsertRow(1)
	szLine	= String(Today()) + " " + String(Now()) + " Failed to delete dx-xf-ff.mon"
	dw_message.SetItem(1, 1, szLine)
End If

FileClose( iFileOutPut )
FileClose( iFileKanban )

//=========================== old code =================================

////************************************************************************
////* Declaration
////************************************************************************
//Boolean 	bb_trigger					//Whether to output
//Boolean	bPassFilter				//Whether passed the filter
//Boolean  bReadyforSave			//Whether to save
//
//Long		iCol
//Long		l_Handle
//
//String	szFilter
//
////************************************************************************
////* Initialization
////************************************************************************
//
//iRow 			= 0
//bHeadLine	= FALSE
//iTotalRows	= dw_raw_data.RowCount()
//SetNull(nOurCum)
//SetNull(nTheCum)
//
//sParm.title	= "Step 2: Process raw data"
//OpenWithParm(w_progress, sParm)
//w_progress.cb_cancel.visible	=  FALSE
//
//iFileOutput	= FileOpen("EDIDATA.TXT", LineMode!, Write!, Shared!, Replace!)
//
//
////************************************************************************
////* Main Routine
////************************************************************************
//
//iTotalRows		= dw_raw_data.RowCount()
//bDetailSection	= FALSE
//
//For iRow = 1 to iTotalRows
//
//	szLine	= dw_raw_data.GetItemString(iRow, "value")
//	
//	If Pos(szLine, "STX12") > 0 then			//Head section
//
//		bHeadLine			= TRUE
//		bSet862				= (Pos(szLine, "862") > 0)
//		szOverlay			= Mid(szLine,72, 3)
//		st_group.text		= szOverlay
//		If bSet862 then
//			dw_edi_overlay_structure.Retrieve(szOverlay, "862")
//			st_date_set.text	= "862"
//		Else
//			dw_edi_overlay_structure.Retrieve(szOverlay, "830")
//			st_date_set.text	= "830"
//		End If
//
//		wf_create_array()
//
//		dw_message.InsertRow(1)
//		szLine	= String(Today()) + " " + String(Now()) + " Processing overlay " + szOverlay + "  data set " +  st_date_set.text
//		dw_message.SetItem(1, 1, szLine)
//	
//	Else												//Detail section
//
//		bb_trigger			= FALSE
//		bPassFilter		= TRUE
//		bReadyforSave	= FALSE
//
//		szLine	= dw_raw_data.GetItemString(iRow, 1)
//		iLineNo	= Long(Mid(szLine, 1, 2))
//
//		iCol = 1
//		Do while bPassFilter AND (iCol < 10) AND (stOverlay[iLineNo, iCol].ItemName > " ")
//
//			szItemName	= stOverlay[iLineNo, iCol].ItemName
//			szItemValue	= Mid(szLine, stOverlay[iLineNo, iCol].ItemPosition, stOverlay[iLineNo, iCol].ItemLength)
//			If Not bb_trigger then
//				bb_trigger		= stOverlay[iLineNo, iCol].b_trigger
//			End If
//
//			If szItemName > " " then
//	
//				Choose Case szItemName
//
//					Case "part"
//						szPart		= RightTrim(szItemValue)
//						dw_edi_log.InsertRow(1)
//						dw_edi_log.SetItem(1, "destination", szDestination)
//						dw_edi_log.SetItem(1, "part", szPart)
//						dw_edi_log.SetItem(1, "release_no", szRelease)
//						If bSet862 then
//							dw_edi_log.SetItem(1, "type", "862")
//						Else
//							dw_edi_log.SetItem(1, "type", "830")						
//						End If
//
//						szSubDestination	= ""
//						//bDetailSection		= TRUE
//
//					Case "release"
//						
//						szRelease		= szItemValue
//	
//						If Not bSet862 then
//							szRelease	= "SET830" + szRelease
//						End If
//
//					Case "date"
//						szDate			= RightTrim(szItemValue)
//						bReadyforSave	= TRUE
//						bDetailSection	= TRUE
//	
//					Case "dock"
//						szDockCode	= Left ( szItemValue, 10 )
//
//					Case "zone_code"
//						szZoneCode	= szItemValue
//
//					Case "line_feed_code"
//						is_line_feed_code	= szItemValue
//
//					Case "destination"
//
//						If Not bDetailSection then
//							szDestination = szItemValue
//						End If
//
//					Case "subdestination"
//						szSubDestination	= szItemValue
//
//					Case "quantity"
//						szQty			= RightTrim(szItemValue)
//
//					Case "filter"
//						szFilter		= szItemValue
//						bPassFilter	= (szFilter = 	stOverlay[iLineNo, iCol].filter_value)				
//					
//					Case "the_cum"
//						nTheCum		= Dec(szItemValue)
//				
//					Case "our_cum"
//						nOurCum		= Dec(szItemValue)
//
//					Case "model_year"
//						szModelYear	= szItemValue
//
//					Case "po"
//						szPO			= szItemValue
//
//					Case "consignee"
//						szConsignee	= szItemValue						
//
//				End Choose
//			End If
//		
//			iCol ++
//
//		Loop
//
//		If bPassFilter then	//Only process those 'good' records
//
//			If bCalcPQ AND bReadyForSave then
//					wf_save_to_stack()
//			End If
//
//			If bb_trigger then
//				If bCalcPQ then
//					wf_recalc_qty()
//				Else
//					wf_output_data()
//				End If
//				bDetailSection	= FALSE
//			End If
//
//		End If
//
//	End If
//
//	w_progress.wf_progress(iRow / iTotalRows, " Part:" + szPart + "  Date:" + RightTrim(szDate) + " Qty:" + szQty)
//
//Next
//
//Close(w_progress)
//
//dw_message.InsertRow(1)
//szLine	= String(Today()) + " " + String(Now()) + " Converted dx-xf-ff.mon"
//dw_message.SetItem(1, 1, szLine)
//
//If FileDelete("dx-xf-ff.mon") then
//	dw_message.InsertRow(1)
//	szLine	= String(Today()) + " " + String(Now()) + " Deleted flat file dx-xf-ff.mon"
//	dw_message.SetItem(1, 1, szLine)
//Else
//	dw_message.InsertRow(1)
//	szLine	= String(Today()) + " " + String(Now()) + " Failed to delete dx-xf-ff.mon"
//	dw_message.SetItem(1, 1, szLine)
//End If
//
//FileClose(iFileOutPut)
end subroutine

public subroutine wf_create_array ();Long 		iRow
Long 		iTotalRows
Long		iLine
Long 		iCol
Long		iItemPosition
Long		iItemLength

String	szItemName
String	szb_trigger
String	szFilterValue

Boolean	bb_trigger, &
			ib_kanban


iTotalRows	= dw_edi_overlay_structure.RowCount()
iTotalRows	= dw_edi_overlay_structure.RowCount()

For iRow = 1 to iMaxRow
	For iCol = 1 to iMaxCol
		stOverlay[iRow, iCol].ItemName	= ''
	Next
Next

szPart			= ""
szDestination	= ""
szDestination	= ""
szRelease		= ""
szDockCode		= ""
szZoneCode		= ""
szPo				= ""
szModelYear		= ""
szConsignee		= ""
szQty				= ""

SetNull(nInitTheCum)
SetNull(nInitOurCum)

For iRow	= 1 to iTotalRows 
	szItemName 	= dw_edi_overlay_structure.GetItemString(iRow, "column_name")
	szb_trigger  	= dw_edi_overlay_structure.GetItemString(iRow, "last_line_in_detail_section")
	iLine			= dw_edi_overlay_structure.GetItemNumber(iRow, "line")

	iCol			= 1
	Do while (iCol <= iMaxCol) AND (stOverlay[iLine, iCol].ItemName > " ") 
		iCol ++
	Loop

	stOverlay[iLine, iCol].ItemName			= lower( szItemName )

	Choose Case szItemName

		Case "The_cum"

			nInitTheCum								= 0
			bCalcPQ									= TRUE

		Case "Our_cum"

			nInitOurCum								= 0

		Case "Filter"		//Filter always goes to first

			stOverlay[iLine, iCol].Filter_Value	= dw_edi_overlay_structure.GetItemString(iRow, "filter_value")

		Case "Fab_cum"
			ib_fab_cum	= TRUE

	End Choose

	stOverlay[iLine, iCol].ItemPosition	= dw_edi_overlay_structure.GetItemNumber(iRow, "position")
	stOverlay[iLine, iCol].ItemLength	= dw_edi_overlay_structure.GetItemNumber(iRow, "length")
	stOverlay[iLine, iCol].b_trigger		= (szb_trigger = 'Y')
	stOverlay[iLine, iCol].is_kanban		= (&
			dw_edi_overlay_structure.GetItemString( iRow, 'kanban' ) = 'Y' )
	
	If szItemName = "Filter" then
		iItemPosition	= stOverlay[iLine, 1].ItemPosition
		iItemLength		= stOverlay[iLine, 1].ItemLength
		bb_trigger			= stOverlay[iLine, 1].b_trigger
		szFilterValue	= stOverlay[iLine, 1].Filter_value
		szItemName		= stOverlay[iLine, 1].ItemName

		stOverlay[iLine, 1].ItemName		= stOverlay[iLine, iCol].ItemName
		stOverlay[iLine, 1].ItemPosition	= stOverlay[iLine, iCol].ItemPosition
		stOverlay[iLine, 1].ItemLength	= stOverlay[iLine, iCol].ItemLength
		stOverlay[iLine, 1].b_trigger		= stOverlay[iLine, iCol].b_trigger
		stOverlay[iLine, 1].Filter_value	= stOverlay[iLine, iCol].Filter_value


		stOverlay[iLine, iCol].ItemName		= szItemName
		stOverlay[iLine, iCol].ItemPosition	= iItemPosition
		stOverlay[iLine, iCol].ItemLength	= iItemLength
		stOverlay[iLine, iCol].b_trigger		= bb_trigger
		stOverlay[iLine, iCol].Filter_value	= szFilterValue

	End If

Next

nTheCum	= nInitTheCum
nOurCum	= nInitOurCum


//======================== old code ===============================
//Long 		iRow
//Long 		iTotalRows
//Long		iLine
//Long 		iCol
//Long		iItemPosition
//Long		iItemLength
//
//String	szItemName
//String	szb_trigger
//String	szFilterValue
//
//Boolean	bb_trigger
//
//
//iTotalRows	= dw_edi_overlay_structure.RowCount()
//iTotalRows	= dw_edi_overlay_structure.RowCount()
//
//For iRow = 1 to iMaxRow
//	For iCol = 1 to iMaxCol
//		stOverlay[iRow, iCol].ItemName	= ''
//	Next
//Next
//
//szPart			= ""
//szDestination	= ""
//szDestination	= ""
//szRelease		= ""
//szDockCode		= ""
//szZoneCode		= ""
//szPo				= ""
//szModelYear		= ""
//szConsignee		= ""
//szQty				= ""
//
//SetNull(nInitTheCum)
//SetNull(nInitOurCum)
//
//For iRow	= 1 to iTotalRows 
//	szItemName 	= dw_edi_overlay_structure.GetItemString(iRow, "column_name")
//	szb_trigger  	= dw_edi_overlay_structure.GetItemString(iRow, "last_line_in_detail_section")
//	iLine			= dw_edi_overlay_structure.GetItemNumber(iRow, "line")
//
//	iCol			= 1
//	Do while (iCol <= iMaxCol) AND (stOverlay[iLine, iCol].ItemName > " ") 
//		iCol ++
//	Loop
//
//	Choose Case szItemName
//
//		Case "Reset"
//
//			stOverlay[iLine, iCol].ItemName	= "reset"
//
//		Case "Part"
//			
//			stOverlay[iLine, iCol].ItemName	= "part"
//
//		Case "Release"
//
//			stOverlay[iLine, iCol].ItemName	= "release"
//
//		Case "Date"
//
//			stOverlay[iLine, iCol].ItemName	= "date"
//
//		Case "Dock_code"
//
//			stOverlay[iLine, iCol].ItemName	= "dock"
//
//		Case "Zone_code"
//	
//			stOverlay[iLine, iCol].ItemName	= "zone_code"
//
//		Case "Line_feed_code"
//			
//			stOverlay[iLine, iCol].ItemName	= "line_feed_code"
//
//		Case "Destination"
//
//			stOverlay[iLine, iCol].ItemName	= "destination"
//
//		Case "SubDestination"
//
//			stOverlay[iLine, iCol].ItemName	= "subdestination"
//
//		Case "The_cum"
//
//			nInitTheCum								= 0
//			stOverlay[iLine, iCol].ItemName	= "the_cum"	
//			bCalcPQ									= TRUE
//
//		Case "Our_cum"
//
//			nInitOurCum								= 0
//			stOverlay[iLine, iCol].ItemName	= "our_cum"
//
//		Case "Quantity"
//
//			stOverlay[iLine, iCol].ItemName	= "quantity"
//
//		Case "Dummy"
//
//			stOverlay[iLine, iCol].ItemName	= "dummy"
//
//		Case "Model_year"
//		
//			stOverlay[iLine, iCol].ItemName	= "model_year"
//
//		Case "PO"
//
//			stOverlay[iLine, iCol].ItemName	= "po"
//
//		Case "Consignee"
//
//			stOverlay[iLine, iCol].ItemName	= "consignee"
//
//		Case "Filter"		//Filter always goes to first
//
//			stOverlay[iLine, iCol].ItemName	= "filter"
//			stOverlay[iLine, iCol].Filter_Value	= dw_edi_overlay_structure.GetItemString(iRow, "filter_value")
//
//	End Choose
//
//	stOverlay[iLine, iCol].ItemPosition	= dw_edi_overlay_structure.GetItemNumber(iRow, "position")
//	stOverlay[iLine, iCol].ItemLength	= dw_edi_overlay_structure.GetItemNumber(iRow, "length")
//	stOverlay[iLine, iCol].b_trigger		= (szb_trigger = 'Y')
//	
//	If szItemName = "Filter" then
//		iItemPosition	= stOverlay[iLine, 1].ItemPosition
//		iItemLength		= stOverlay[iLine, 1].ItemLength
//		bb_trigger			= stOverlay[iLine, 1].b_trigger
//		szFilterValue	= stOverlay[iLine, 1].Filter_value
//		szItemName		= stOverlay[iLine, 1].ItemName
//
//		stOverlay[iLine, 1].ItemName		= stOverlay[iLine, iCol].ItemName
//		stOverlay[iLine, 1].ItemPosition	= stOverlay[iLine, iCol].ItemPosition
//		stOverlay[iLine, 1].ItemLength	= stOverlay[iLine, iCol].ItemLength
//		stOverlay[iLine, 1].b_trigger		= stOverlay[iLine, iCol].b_trigger
//		stOverlay[iLine, 1].Filter_value	= stOverlay[iLine, iCol].Filter_value
//
//
//		stOverlay[iLine, iCol].ItemName		= szItemName
//		stOverlay[iLine, iCol].ItemPosition	= iItemPosition
//		stOverlay[iLine, iCol].ItemLength	= iItemLength
//		stOverlay[iLine, iCol].b_trigger		= bb_trigger
//		stOverlay[iLine, iCol].Filter_value	= szFilterValue
//
//	End If
//
//Next
//
//nTheCum	= nInitTheCum
//nOurCum	= nInitOurCum
//
end subroutine

public subroutine wf_read_from_stack ();integer	li_row, &
			li_count


li_count		= dw_stack.rowcount()

for li_row	= 1 to li_count

	szDate	= dw_stack.getitemstring( li_row, 'value1' )
	szQty		= dw_stack.getitemstring( li_row, 'value2' )

	wf_output_data()

next

dw_stack.reset()
end subroutine

public function string wf_read_raw_data ();Boolean			bDone
Long				fnum, &
					loops, &
					i, &
					iCount, &
					l_Handle, &
					flen, &
					bytes_read, &
					new_pos, &
					iTotalLines, &
					iLastRow, &
					iTotalTimes, &
					iCurrentTime
String 			szLine, &
					ls_INIFileName

Str_progress	sParm

ls_INIFileName = monsys.root + '\monitor.ini'
IF NOT FileExists ( ls_INIFileName ) THEN
	ls_INIFileName = 'c:\windows\monitor.ini'
	IF NOT FileExists ( ls_INIFileName ) THEN
		MessageBox ( 'Error', 'Unable to locate Monitor INI File!' )
		Return ''
	END IF
END IF

is_Path = ProfileString ( ls_INIFileName, 'EDI PARMS', 'EDIDirectory', 'c:' )
is_Path += '\'

SetPointer(HourGlass!)

flen = FileLength( is_Path + "dx-xf-ff.mon")
fnum = FileOpen( is_Path + "dx-xf-ff.mon", streammode!, read!, shared!)

If flen < 0 then
	dw_message.InsertRow(1)
	szLine	= String(Today()) + " " + String(Now()) + " Error reading flat file dx-xf-ff.mon!"
	dw_message.SetItem(1, 1, szLine)
	Return ''
Else
	dw_message.InsertRow(1)
	szLine	= String(Today()) + " " + String(Now()) + " Reading flat file dx-xf-ff.mon..."
	dw_message.SetItem(1, 1, szLine)
End If

If Mod(flen, 80) = 0 then
	iTotalTimes	= flen / 80
Else
	iTotalTimes	= flen / 80 + 1
End If

iCurrentTime = 0

sParm.title	= "Step 1: Reading raw data"
OpenWithParm(w_progress, sParm)
w_progress.cb_cancel.visible	= FALSE

// Determine how many FileRead calls are needed to read the 
// entire file.


IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN

		loops = flen/32765

	ELSE

		loops = (flen/32765) + 1

	END IF

ELSE

	loops = 1

END IF

dw_raw_data.Reset()

new_pos	= 0

FOR i = 1 to loops
	mle_raw_data.text	= ""
	bytes_read = FileRead(fnum, mle_raw_data.text)
	new_pos = new_pos + bytes_read - Mod(bytes_read, 80)
	FileSeek(fnum,new_pos, FromBeginning!)

	If bytes_read > 80 then
		iTotalLines	= bytes_read / 80
	Else
		iTotalLines		= 1
	End If

	For iCount = 1 to iTotalLines
		szLine	= MidA(f_get_string_value ( mle_raw_data.text ), (iCount - 1) * 80 + 1, 80)
		iCurrentTime ++
		w_progress.wf_progress(iCurrentTime / iTotalTimes, szLine)		
		iLastRow = dw_raw_data.InsertRow(0)
		dw_raw_data.SetItem(iLastRow, "value", szLine)
	Next
			
Next

FileClose(fnum)

Close(w_progress)

dw_message.InsertRow(1)
szLine	= String(Today()) + " " + String(Now()) + " Finished reading flat file dx-xf-ff.mon..."
dw_message.SetItem(1, 1, szLine)

wf_parsor_raw_data()
return ''
end function

on open;String szMode
Long	l_Handle

dw_edi_overlay_structure.SetTransObject(sqlca)

szMode	= Message.StringParm

bFinish	= FALSE
If szMode = "AUTO" then
	ib_Auto = TRUE
	PostEvent ( 'process' )
End If
end on

on activate;bActivated	= TRUE
gnv_App.of_GetFrame().ChangeMenu(m_process_edi_raw_data)
end on

on deactivate;bActivated	= FALSE
end on

on w_edi_raw_data_processor.create
this.cb_wait=create cb_wait
this.dw_message=create dw_message
this.st_date_set=create st_date_set
this.st_2=create st_2
this.st_group=create st_group
this.st_1=create st_1
this.dw_stack=create dw_stack
this.dw_edi_log=create dw_edi_log
this.dw_mapped_edi_data=create dw_mapped_edi_data
this.dw_edi_detail=create dw_edi_detail
this.dw_edi_header=create dw_edi_header
this.dw_edi_overlay_structure=create dw_edi_overlay_structure
this.mle_raw_data=create mle_raw_data
this.dw_raw_data=create dw_raw_data
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_overlay=create gb_overlay
this.gb_message=create gb_message
this.Control[]={this.cb_wait,&
this.dw_message,&
this.st_date_set,&
this.st_2,&
this.st_group,&
this.st_1,&
this.dw_stack,&
this.dw_edi_log,&
this.dw_mapped_edi_data,&
this.dw_edi_detail,&
this.dw_edi_header,&
this.dw_edi_overlay_structure,&
this.mle_raw_data,&
this.dw_raw_data,&
this.gb_3,&
this.gb_2,&
this.gb_overlay,&
this.gb_message}
end on

on w_edi_raw_data_processor.destroy
destroy(this.cb_wait)
destroy(this.dw_message)
destroy(this.st_date_set)
destroy(this.st_2)
destroy(this.st_group)
destroy(this.st_1)
destroy(this.dw_stack)
destroy(this.dw_edi_log)
destroy(this.dw_mapped_edi_data)
destroy(this.dw_edi_detail)
destroy(this.dw_edi_header)
destroy(this.dw_edi_overlay_structure)
destroy(this.mle_raw_data)
destroy(this.dw_raw_data)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_overlay)
destroy(this.gb_message)
end on

type cb_wait from commandbutton within w_edi_raw_data_processor
int X=1207
int Y=480
int Width=805
int Height=464
int TabOrder=60
boolean Visible=false
string Text="Please wait..."
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_message from datawindow within w_edi_raw_data_processor
int X=1682
int Y=64
int Width=1079
int Height=640
int TabOrder=50
string DataObject="dw_read_line_char80"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_date_set from statictext within w_edi_raw_data_processor
int X=1445
int Y=736
int Width=146
int Height=64
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_edi_raw_data_processor
int X=1189
int Y=736
int Width=238
int Height=64
boolean Enabled=false
string Text="Date Set:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_group from statictext within w_edi_raw_data_processor
int X=969
int Y=736
int Width=146
int Height=64
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_edi_raw_data_processor
int X=585
int Y=736
int Width=384
int Height=64
boolean Enabled=false
string Text="Overlay Group:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_stack from datawindow within w_edi_raw_data_processor
int X=1682
int Y=64
int Width=1079
int Height=640
int TabOrder=40
boolean Visible=false
string DataObject="dw_external_template"
boolean LiveScroll=true
end type

type dw_edi_log from datawindow within w_edi_raw_data_processor
int X=1682
int Y=800
int Width=1079
int Height=576
int TabOrder=100
string DataObject="d_external_edi_log"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_mapped_edi_data from datawindow within w_edi_raw_data_processor
int X=55
int Y=800
int Width=1536
int Height=576
int TabOrder=90
string DataObject="dw_external_mapped_edi_data"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_edi_detail from datawindow within w_edi_raw_data_processor
int X=1682
int Y=1920
int Width=494
int Height=360
int TabOrder=140
boolean Visible=false
string DataObject="dw_edi_raw_data_detail"
boolean LiveScroll=true
end type

type dw_edi_header from datawindow within w_edi_raw_data_processor
int X=1134
int Y=1920
int Width=494
int Height=360
int TabOrder=130
boolean Visible=false
string DataObject="dw_edi_raw_data_header"
boolean LiveScroll=true
end type

type dw_edi_overlay_structure from datawindow within w_edi_raw_data_processor
int X=567
int Y=1920
int Width=494
int Height=360
int TabOrder=120
boolean Visible=false
string DataObject="dw_edi_overlay_structure"
boolean LiveScroll=true
end type

type mle_raw_data from multilineedit within w_edi_raw_data_processor
int X=73
int Y=1920
int Width=421
int Height=368
int TabOrder=110
boolean Visible=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_raw_data from datawindow within w_edi_raw_data_processor
int X=55
int Y=64
int Width=1536
int Height=640
int TabOrder=30
string DataObject="dw_read_line_char80"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_3 from groupbox within w_edi_raw_data_processor
int X=37
int Y=736
int Width=1573
int Height=656
int TabOrder=70
string Text="Mapped EDI Data"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_edi_raw_data_processor
int X=1646
int Y=736
int Width=1152
int Height=656
int TabOrder=80
string Text="Transaction Log "
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_overlay from groupbox within w_edi_raw_data_processor
int X=37
int Width=1573
int Height=736
int TabOrder=10
string Text="Raw Data"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_message from groupbox within w_edi_raw_data_processor
int X=1646
int Width=1152
int Height=736
int TabOrder=20
string Text="Message Center"
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

