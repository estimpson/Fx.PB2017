$PBExportHeader$n_cst_dwsrv_sort.sru
$PBExportComments$Extension DataWindow Sort service
forward
global type n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
end type
end forward

global type n_cst_dwsrv_sort from pfc_n_cst_dwsrv_sort
event type integer pfc_doubleclicked ( integer ai_xpos,  integer ai_ypos,  long al_row,  ref dwobject adwo_obj )
end type
global n_cst_dwsrv_sort n_cst_dwsrv_sort

type variables

constant string AltHeaderSuffix = "_t1"
protected boolean	ColumnHeaderSortExt = false

string	SortColumns [3]
string	SortOrders [3]

string	DWONameSortIndicator [3]
string	DWOSyntaxSortIndicator [3]

end variables

forward prototypes
public function integer setcolumnheaderext (boolean switch)
public function integer readsort ()
public function integer of_setsort (string as_format)
public function integer GetColumnSort (string columnName, ref string sortOrder)
end prototypes

event type integer pfc_doubleclicked(integer ai_xpos, integer ai_ypos, long al_row, ref dwobject adwo_obj);
string	clickedName
string columnName
integer returnValue
integer suffixLen
integer headerLen
integer altSuffixLen
string	sortString

//	Validate the dwo reference.
if IsNull ( adwo_Obj ) or not IsValid ( adwo_Obj ) then
	return FAILURE
end if

//	Check if the service is set to sort on column headers.
if not ColumnHeaderSortExt then return NO_ACTION

//	Only valid on header column.
if adwo_Obj.Name = 'datawindow' then return NO_ACTION
if adwo_Obj.Band <> "header" then return NO_ACTION

//	Get column header information.
clickedName = adwo_Obj.Name
headerLen = Len ( clickedName )
suffixLen = Len ( is_defaultheadersuffix )
altSuffixLen = Len ( AltHeaderSuffix )

//	Extract the columname from the header label 
//	(by taking out the header suffix).
if Right ( clickedName, suffixLen ) <> is_defaultheadersuffix then
	if Right ( clickedName, altSuffixLen ) <> AltHeaderSuffix then 
		//	Cannot determine the column name from the header.	
		return FAILURE
	else
		columnName = Left (clickedName, headerLen - altSuffixLen )
	end if
else
	columnName = Left (clickedName, headerLen - suffixLen )
end if

//	Validate the column name.
if IsNull ( columnName ) or Len ( Trim ( columnName ) ) = 0 then
	return FAILURE
end if

//	Build the sort string.
if SortColumns [1] = columnName then
	//	Clicked primary again, reverse sort order.
	if SortOrders [1] = " A" then
		SortOrders [1] = " D"
	else
		SortOrders [1] = " A"
	end if
else
	//	Clicked a different column.
	if SortColumns [2] <> columnName then
		//	Didn't click an existing, move 2 to 3 and 1 to 2.
		SortColumns [3] = SortColumns [2]
		SortOrders [3] = SortOrders [2]

		SortColumns [2] = SortColumns [1]
		SortOrders [2] = SortOrders [1]
	else
		//	Clicked an existing, move 1 to 2.
		SortColumns [2] = SortColumns [1]
		SortOrders [2] = SortOrders [1]
	end if
	
	//	Set 1.
	SortColumns [1] = columnName
	SortOrders [1] = " A"
end if

if of_GetUseDisplay ( ) and of_UsesDisplayValue ( columnName ) then
	sortString = "LookUpDisplay(" + SortColumns [1] + ") " + SortOrders [1]
	if SortColumns [2] > "" then
		sortString += ", LookUpDisplay(" + SortColumns [2] + ") " + SortOrders [2]
		if SortColumns [3] > "" then
			sortString += ", LookUpDisplay(" + SortColumns [3] + ") " + SortOrders [3]
		end if
	end if
else
	sortString = SortColumns [1] + SortOrders [1]
	if SortColumns [2] > "" then
		sortString += ", " + SortColumns [2] + SortOrders [2]
		if SortColumns [3] > "" then
			sortString += ", " + SortColumns [3] + SortOrders [3]
		end if
	end if
end if

//	Perform the SetSort operation (check the rc).
returnValue = of_SetSort ( sortString ) 
if returnValue < 0 then return returnValue

//	Perform the actual Sort operation (check the rc).
returnValue = of_Sort()
if returnValue < 0 then return returnValue


return 1

end event

public function integer setcolumnheaderext (boolean switch);
// Check arguments.
if IsNull (switch) then return FAILURE

ColumnHeaderSortExt = switch

return SUCCESS

end function

public function integer readsort ();
n_cst_sortattrib		lnv_SortAttrib

//	Read the new sort.
if of_BuildSortAttrib ( lnv_SortAttrib ) <> SUCCESS then return FAILURE

integer	sortColumnCount
integer	counter

string	destroySyntax
string	createSyntax

sortColumnCount = UpperBound ( lnv_SortAttrib.is_OrigColumns )

for counter = 1 to 3
	if DWONameSortIndicator [counter] > "" then
		
		//	Destroy the old indicator.
		destroySyntax += " destroy " + DWONameSortIndicator [counter] + " "
	end if
	
	if counter <= sortColumnCount then
		SortColumns [counter] = lnv_SortAttrib.is_OrigColumns [counter]
		SortOrders [counter] = " " + lnv_SortAttrib.is_OrigOrder [counter]
		
		//	Build the new one.
		DWONameSortIndicator [counter] = SortColumns [counter] + AltHeaderSuffix
		DWOSyntaxSortIndicator [counter] = ' create text(band=header alignment="1" text='
		if SortOrders [counter] = " A" then DWOSyntaxSortIndicator [counter] += '"òþ"' else DWOSyntaxSortIndicator [counter] += '"ñþ"'
		DWOSyntaxSortIndicator [counter] += ' border="0" color="0" x="' + idw_Requestor.Describe ( SortColumns [counter] + ".X" ) + '" y="8" height="48" width="' + idw_Requestor.Describe ( SortColumns [counter] + ".Width" ) + '"  name=' + SortColumns [counter] + '_t1  font.face="Wingdings" font.height="-8" font.weight="'
		if counter = 1 then DWOSyntaxSortIndicator [counter] += '700' else DWOSyntaxSortIndicator [1] += '400'
		DWOSyntaxSortIndicator [counter] += '"  font.family="0" font.pitch="2" font.charset="2" '
		if counter = 3 then DWOSyntaxSortIndicator [counter] += 'font.italic="1" '
		DWOSyntaxSortIndicator [counter] += 'background.mode="1" background.color="553648127" ) '
		createSyntax += DWOSyntaxSortIndicator [counter]
	else
		SortColumns [counter] = ""
		SortOrders [counter] = ""
		DWONameSortIndicator [counter] = ""
		DWOSyntaxSortIndicator [counter] = ""
	end if
next

//	Display the sorted columns.
idw_Requestor.SetRedraw ( false )
idw_Requestor.Modify ( destroySyntax )
idw_Requestor.Modify ( createSyntax )
idw_Requestor.SetRedraw ( true )

//	Return.
return SUCCESS


end function

public function integer of_setsort (string as_format);
//	Call ancestor of_SetSort ()
integer	returnValue
returnValue = super::of_SetSort (as_Format)

//	If Extended Column Sort is enabled read new sort.
if ColumnHeaderSortExt and returnValue = SUCCESS then
	returnValue = ReadSort ()
end if

//	Return.
return returnValue

end function

public function integer GetColumnSort (string columnName, ref string sortOrder);

choose case columnName
	case SortColumns[1]
		sortOrder = trim(SortOrders[1])
	case SortColumns[2]
		sortOrder = trim(SortOrders[2])
	case SortColumns[3]
		sortOrder = trim(SortOrders[3])
	case else
		sortOrder = "N"
end choose

return SUCCESS
end function

event type integer pfc_setcolumnsort (string columnName, string sortOrder);
//	Build the sort string.
choose case columnName
	case SortColumns[1]
		if	sortOrder = "N" then
			SortColumns[1] = SortColumns[2]
			SortColumns[2] = SortColumns[3]
			SortColumns[3] = ""
			SortOrders[1] = SortOrders[2]
			SortOrders[2] = SortOrders[3]
		else
			SortOrders[1] = " " + sortOrder
		end if
	case SortColumns[2]
		if	sortOrder = "N" then
			SortColumns[2] = SortColumns[3]
			SortColumns[3] = ""
			SortOrders[2] = SortOrders[3]
		else
			SortOrders[2] = " " + sortOrder
		end if
	case SortColumns[3]
		if	sortOrder = "N" then
			SortColumns[3] = ""
		else
			SortOrders[3] = " " + sortOrder
		end if
	case else
		if	sortOrder <> "N" then
			SortColumns[3] = SortColumns[2]
			SortColumns[2] = SortColumns[1]
			SortOrders[3] = SortOrders[2]
			SortOrders[2] = SortOrders[1]

			SortColumns[1] = columnName
			SortOrders[1] = " " + sortOrder
		end if
end choose

string sortString
if of_GetUseDisplay ( ) and of_UsesDisplayValue ( columnName ) then
	sortString = "LookUpDisplay(" + SortColumns[1] + ") " + SortOrders[1]
	if SortColumns[2] > "" then
		sortString += ", LookUpDisplay(" + SortColumns[2] + ") " + SortOrders[2]
		if SortColumns[3] > "" then
			sortString += ", LookUpDisplay(" + SortColumns[3] + ") " + SortOrders[3]
		end if
	end if
else
	sortString = SortColumns[1] + SortOrders[1]
	if SortColumns[2] > "" then
		sortString += ", " + SortColumns[2] + SortOrders[2]
		if SortColumns[3] > "" then
			sortString += ", " + SortColumns[3] + SortOrders[3]
		end if
	end if
end if

//	Perform the SetSort operation (check the rc).
int returnValue
returnValue = of_SetSort ( sortString ) 
if returnValue < 0 then return returnValue

//	Perform the actual Sort operation (check the rc).
returnValue = of_Sort()
if returnValue < 0 then return returnValue

return SUCCESS
end event

on n_cst_dwsrv_sort.create
call super::create
end on

on n_cst_dwsrv_sort.destroy
call super::destroy
end on

