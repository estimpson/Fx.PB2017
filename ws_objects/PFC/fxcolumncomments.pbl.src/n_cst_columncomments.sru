$PBExportHeader$n_cst_columncomments.sru
forward
global type n_cst_columncomments from n_base
end type
end forward

global type n_cst_columncomments from n_base
event ue_dwlbuttonup ( string dwotype,  string dwoname,  long row )
event ue_itemfocuschanged ( string dwotype,  string dwoname,  long row )
end type
global n_cst_columncomments n_cst_columncomments

type variables

private:

//	Constants:
constant int HOTSPOT_WIDTH = 32 // Default hotspot width
constant int HOTSPOT_HEIGHT = 32 // Default hotspot height
constant int	HOTSPOT_X_OFFSET = 0 // pixels to shift horizontally from default position +/-
constant int	HOTSPOT_Y_OFFSET = 4 // pixels to shift vertically from default position +/-

//	Model data:
boolean _hideCommentHotSpots = false // Removes all hotspots when true.
boolean _showAllHotSpots = false // Makes all hotspots visible when true, otherwise only columns with columns show hotspots.
int _colCount
string _colNames[] // All column names found on the datawindow.
string _tableNameDotColumnNames [] // All table.column names found on the datawindow.
public privatewrite decimal _unitXFactor // Scale pixels to dw units along X axis.
public privatewrite decimal _unitYFactor // Scale pixels to dw units along Y axis.
long _currentRow // The row of the current displayed hotspot.
int _currentColID // The column ID of the current displayed hotspot
string _schemaName // The schema name of the current table or view.
string _currentDataRowGUID // The data row GUID of the current displayed hotspot
string _currentColumnName // The column name of the current displayed hotspot
string _currentTableNameDotColumnName // The database name associated with the current column.

//	Views:
u_columncomment _columnCommentView

//	Requestor:
datawindow _requestor
window _requestorWindow

//	Data context.
n_columncomments_trans _columnCommentsTrans

end variables

forward prototypes
public function integer show ()
public function integer setrequestor (datawindow requestordw, window requestorwindow)
private function integer getcolumns ()
public function string createhotspot (integer colnum, string hotspotname)
public function integer newcomment (string comment)
public function integer deletecomment (long commentrowid)
public function integer editcomment (long commentrowid, string comment)
public function integer showallhotspots (boolean flag)
public function integer positionhotspots ()
public function integer showcomment (string dwotype, string dwoname, long row)
public function integer showcomment ()
public function integer columnhasnocomments ()
public function integer columnhascomments (boolean flag)
end prototypes

event ue_dwlbuttonup(string dwotype, string dwoname, long row);
if	dwoType <> 'ellipse' or left(string(dwoName), len("b_hotspot")) <> "b_hotspot" then
	PositionHotspots()
	return
end if

_currentColID = Integer(mid(dwoName, len("b_hotspot") + 1))
_currentDataRowGUID = _requestor.object.DataRowGUID[row]
_schemaName = _requestor.Object.SchemaName[row]

_currentColumnName = _colNames[_currentColID]
_currentTableNameDotColumnName = _tableNameDotColumnNames[_currentColID]

_columnCommentView.SetDataRowGUIDAndColumn(_currentDataRowGUID, _currentColumnName)
_columnCommentView.ShowComment(_currentColID)

end event

event ue_itemfocuschanged(string dwotype, string dwoname, long row);
if	dwoType <> 'ellipse' or left(string(dwoName), len("b_hotspot")) <> "b_hotspot" then
	PositionHotSpots()
	return
end if

int colID
colID = Integer(mid(dwoName, len("b_hotspot") + 1))

MessageBox(_requestor.object.DataRowGUID[row], _colNames[colID])

end event

public function integer show ();
if	not IsValid(_requestor) or not IsValid(_requestorWindow) then
	return FAILURE
end if

if	GetColumns() = NO_ACTION then
	return NO_ACTION
end if

//	If _columnCommentView isn't valid, create it.
if	not IsValid(_columnCommentView) then
	_requestorWindow.OpenUserObject(_columnCommentView, "u_columncomment")
	_columnCommentView.SetRequestor(_requestor, _requestorWindow, this)
end if

//	Show or hide hotspots.
string modString
int colNum
for	colNum = 1 to _colCount
	if	_hideCommentHotSpots then
		modString += " " + "destroy b_hotspot" + string(colNum)
	else
		modstring += " " + CreateHotSpot(colNum, "b_hotspot" + string(colNum))
	end if
next

//	Perform mod.
if	len(modstring) > 0 then
	if	_requestor.Modify(modString) = "" then
		PositionHotspots()
		return SUCCESS
	end if
	return FAILURE
end if

return NO_ACTION

end function

public function integer setrequestor (datawindow requestordw, window requestorwindow);
//	Ensure references are valid.
if	not IsValid(requestorDW) or not IsValid(requestorWindow) then return FAILURE

//	Store a pointer.
_requestor = requestorDW
_requestorWindow = requestorWindow

//	Calculate unit x factor and unit y factor.
string dwUnits
dwUnits = _requestor.Describe("DataWindow.Units")

choose case dwUnits
	case "0"
		_unitXFactor = 1
		_unitYFactor = 1
	case "1"
		_unitXFactor = (UnitsToPixels(1000, XUnitsToPixels!) / 1000.00)
		_unitYFactor = (UnitsToPixels(1000, YUnitsToPixels!) / 1000.00)
	case "2"
		_unitXFactor = 2.264368
		_unitYFactor = 2.592105
	case "3"
		_unitXFactor = 2.264368 * 2.54
		_unitYFactor = 2.592105 * 2.54
end choose

return SUCCESS

		
		
end function

private function integer getcolumns ();
string emptyArray[]
_colNames = emptyArray
_colCount = 0

if	not IsValid(_requestor) or not IsValid(_requestorWindow) then return FAILURE

//	Validate all required columns for enabling column comments.
if	_requestor.Describe("RowComments.ID") = "!" or _requestor.Describe("DataRowGUID.ID") = "!" or _requestor.Describe("SchemaName.ID") = "!" then
	return NO_ACTION
end if

string objects
objects = _requestor.Describe("Datawindow.Objects")

long start = 1, nextTab, length
do while start < len(objects)
	//	Process by splitting on tabs.
	nextTab = pos(objects, '~t', start)
	if	nextTab = 0 then
		nextTab = len(objects) + 1
	end if
	length = nextTab - start
	
	string objectName
	objectName = mid(objects, start, length)
	
	string band
	band = _requestor.Describe(objectName + ".Band")
	
	//	Only look for columns in the detail band.
	if	Upper(band) = "DETAIL" then
		string colIDString
		colIDString = _requestor.Describe(objectName + ".ID")
		if	colIDString <> "?" and colIDString <> "!" then
			int colID
			colID = Integer(colIDString)
			_colNames[colID] = objectName
			_tableNameDotColumnNames[colID] = _requestor.Describe(objectName + ".dbName")
		end if
	end if
	start = nextTab + 1
loop

_colCount = UpperBound(_colNames)
if	_colCount > 0 then
	return SUCCESS
end if

return NO_ACTION

end function

public function string createhotspot (integer colnum, string hotspotname);
int hsY
hsY = HOTSPOT_Y_OFFSET * _unitYFactor

string modString
//modString = "create button(band=detail text='' filename='CC_COMMENT.png' suppresseventprocessing=yes enabled=yes action='0' border='0' color='33554432'"
//modString += " " + "x='0'"
//modString += " " + "y='" + String(hsY) + "'"
//modString += " " + "height='" + String(HOTSPOT_HEIGHT) + "' width='" + String(HOTSPOT_WIDTH) + "'"
//modString += " " + "vtextalign='0' htextalign='0' "
//modString += " " + "name=" + hotSpotName
//modString += " " + "visible='0'"
//modString += " " + "font.face='Tahoma' font.height='-10' font.weight='400'  font.family='2' font.pitch='2' font.charset='0'"
//modString += " " + "pointer='HyperLink!'"
//modString += " " + "background.mode='2' background.color='67108864' )"

modString = "create ellipse(band=detail"
modString += " " + "x='0'"
modString += " " + "y='" + String(hsY) + "'"
modString += " " + "height='" + String(HOTSPOT_HEIGHT) + "' width='" + String(HOTSPOT_WIDTH) + "'"
modString += " " + "name=" + hotSpotName
modString += " " + "visible='0'"
modString += " " + "brush.hatch='6' brush.color='134217857' pen.style='0' pen.width='5' pen.color='1073741824'"
modString += " " + "pointer='HyperLink!'"
modString += " " + "background.mode='2' background.color='134217857' )"

return ModString


end function

public function integer newcomment (string comment);
if	not IsValid(_columnCommentsTrans) then return FAILURE

if	_columnCommentsTrans.NewComment(_schemaName, _currentTableNameDotColumnName, _currentDataRowGUID, comment) = SUCCESS then
	_columnCommentsTrans.CommitTrans()
	return ColumnHasComments(true)
else
	_columnCommentsTrans.RollbackTrans()
end if

return NO_ACTION

end function

public function integer deletecomment (long commentrowid);
if	not IsValid(_columnCommentsTrans) then return FAILURE

if	_columnCommentsTrans.DeleteComment(commentRowID) = SUCCESS then
	_columnCommentsTrans.CommitTrans()
	//	Determination of if column has any comments remaining in refresh on comment control.
	return SUCCESS
else
	_columnCommentsTrans.RollbackTrans()
end if

return NO_ACTION

end function

public function integer editcomment (long commentrowid, string comment);
if	not IsValid(_columnCommentsTrans) then return FAILURE

if	_columnCommentsTrans.EditComment(commentRowID, comment) = SUCCESS then
	_columnCommentsTrans.CommitTrans()
	return SUCCESS
else
	_columnCommentsTrans.RollbackTrans()
end if

return NO_ACTION

end function

public function integer showallhotspots (boolean flag);
_showAllHotSpots = flag

return PositionHotSpots()


end function

public function integer positionhotspots ();
//	Column comments should not be visible when hot spots are being repositioned.
if	IsValid(_columnCommentView) then
	if	_columnCommentView.visible then
		_columnCommentView.visible = false
	end if
end if

//	Build mod string to reposition hotspots.
string modString
int colNum
for	colNum = 1 to _colCount
	string colName 
	colName = _colNames[colNum]
	
	int colX
	colX = integer(_requestor.Describe(colName + ".x"))
	colX += HOTSPOT_X_OFFSET * _unitXFactor
	
	int colWidth
	colWidth = integer(_requestor.Describe(colName + ".width"))
	if	colWidth = 0 then
		//	Hide hotspot.
		modString += " " + "b_hotspot" + string(colNum) + ".visible='0'"
	else
		if	_showAllHotSpots then
			//	All hotpsots are visible.
			modString += " " + "b_hotspot" + string(colNum) + ".visible=~"1~""
		else
			//	Set visibility based on the formula for the column.
			modString += " " + "b_hotspot" + string(colNum) + ".visible=~"1~tif(mid(RowComments," + string(colNum) + ",1)=~~~"1~~~", 1, 0)~""
		end if			
		modString += " " + "b_hotspot" + string(colNum) + ".brush.color=~"134217857~tif(mid(RowComments," + string(colNum) + ",1)=~~~"1~~~", 134217857, 268435456)~""
	end if
	
	long hsX
	int hsWidth
	if	colWidth >= HOTSPOT_WIDTH * _unitXfactor then
		hsX = colX + colWidth - HOTSPOT_WIDTH * _unitXFactor
		hsWidth = HOTSPOT_WIDTH * _unitXFactor
	else
		hsX = colX
		hsWidth = colWidth
	end if
	
	//	Reposition and resize if needed.
	if	long(_requestor.Describe("b_hotspot" + string(colNum) + ".x")) <> hsX then
		modString += " " + "b_hotspot" + string(colNum) + ".x='" + String(hsX) + "'"
	end if
	if	integer(_requestor.Describe("b_hotspot" + string(colNum) + ".width")) <> hsWidth then
		modString += " " + "b_hotspot" + string(colNum) + ".width='" + String(colWidth) + "'"
	end if
	
next

//	Perform mod.
if	len(modstring) > 0 then
	if	_requestor.Modify(modString) = "" then
		return SUCCESS
	end if
	return FAILURE
end if

return NO_ACTION

end function

public function integer showcomment (string dwotype, string dwoname, long row);
if	dwoType <> 'ellipse' or left(string(dwoName), len("b_hotspot")) <> "b_hotspot" or row <= 0 then return NO_ACTION

_currentRow = row
_currentColID = Integer(mid(dwoName, len("b_hotspot") + 1))
_currentDataRowGUID = _requestor.object.DataRowGUID[_currentRow]
_schemaName = _requestor.Object.SchemaName[_currentRow]

_currentColumnName = _colNames[_currentColID]
_currentTableNameDotColumnName = _tableNameDotColumnNames[_currentColID]

_columnCommentView.SetDataRowGUIDAndColumn(_currentDataRowGUID, _currentColumnName)
return _columnCommentView.ShowComment(_currentColID)

end function

public function integer showcomment ();
int colID
colID = _requestor.GetColumn()
long row
row = _requestor.GetRow()

if	colID <= 0 or row <= 0 then return FAILURE

_currentRow = row
_currentColID = colID
_currentDataRowGUID = _requestor.object.DataRowGUID[_currentRow]
_schemaName = _requestor.Object.SchemaName[_currentRow]

_currentColumnName = _colNames[_currentColID]
_currentTableNameDotColumnName = _tableNameDotColumnNames[_currentColID]

_columnCommentView.SetDataRowGUIDAndColumn(_currentDataRowGUID, _currentColumnName)
return _columnCommentView.ShowComment(_currentColID)

end function

public function integer columnhasnocomments ();
return ColumnHasComments(false)


end function

public function integer columnhascomments (boolean flag);
if	_currentRow <= 0 or _currentColID <= 0 then return FAILURE

//	Set the change column.
if	_requestor.Describe("RowComments.ID") = "!" then return NO_ACTION

string	rowComments
rowComments = _requestor.Object.RowComments[_currentRow]
if	IsNull(rowComments, "") = "" then
	rowComments = Fill('0', _currentColID)
elseif	Len(rowComments) < _currentColID then
	rowComments = rowComments + Fill('0', _currentColID - Len(rowComments))
end if

if	flag then
	rowComments = mid(rowComments, 1, _currentColID - 1) + "1" + mid(rowComments, _currentColID + 1)
else
	rowComments = mid(rowComments, 1, _currentColID - 1) + "0" + mid(rowComments, _currentColID + 1)
end if

_requestor.Object.RowComments[_currentRow] = rowComments
return SUCCESS

end function

on n_cst_columncomments.create
call super::create
end on

on n_cst_columncomments.destroy
call super::destroy
end on

event constructor;call super::constructor;
_columnCommentsTrans = create n_columncomments_trans

end event

event destructor;call super::destructor;
destroy _columnCommentsTrans

end event

