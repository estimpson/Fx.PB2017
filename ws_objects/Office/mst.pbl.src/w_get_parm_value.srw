$PBExportHeader$w_get_parm_value.srw
$PBExportComments$Get the next availabe parameter value
forward
global type w_get_parm_value from Window
end type
type dw_1 from datawindow within w_get_parm_value
end type
type dw_parameters from datawindow within w_get_parm_value
end type
end forward

global type w_get_parm_value from Window
int X=672
int Y=264
int Width=2217
int Height=1784
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
dw_1 dw_1
dw_parameters dw_parameters
end type
global w_get_parm_value w_get_parm_value

type variables
Integer iColumn         //The column # in parm dw
Integer iSQLCount     //The total verification dw
Integer iCount           //The counting number

Long    iRetValue       //The return number

String   szSQLSyntaxArray[10]  //To keep the SQL Syntax

Boolean bGoodValue  //Whether we have a good number
end variables

forward prototypes
public function boolean wf_valid_colname (string szcolname)
public function boolean wf_check_dw (long ivalue)
public subroutine wf_build_sql_syntax (string szcolname)
public subroutine wf_update_parameters (string szcolname, long ivalue)
end prototypes

public function boolean wf_valid_colname (string szcolname);Integer iCount
Boolean bFound
String  szName

dw_parameters.SetRow(1)
iCount	= 1
bFound	= FALSE

Do while (Not bFound) AND (iCount <= 10)
	dw_parameters.SetColumn(iCount)
	szName	= dw_parameters.GetColumnName()
	If szName = szColName then
		bFound	= TRUE
		iColumn	= iCount
	Else
		iCount ++
	End If
Loop	

Return bFound	
end function

public function boolean wf_check_dw (long ivalue);Boolean bGoodValue
Integer iCount
String  szSyntax
String  szErrors



bGoodValue	= TRUE
iCount		= 1

Do While (iCount <= iSQLCount) AND bGoodValue

	szSyntax			= szSQLSyntaxArray[iCount] + String(iValue)
	dw_1.Create(SyntaxFromSQL(SQLCA, szSyntax, "", szErrors))
	dw_1.SetTransObject(sqlca)
	dw_1.Retrieve()
	bGoodValue 	= (dw_1.RowCount() = 0)
	iCount		= iCount + 1

Loop	
	 
Return bGoodValue
end function

public subroutine wf_build_sql_syntax (string szcolname);Choose Case szColName

	Case 	"next_serial"
		szSQLSyntaxArray[1]	= "SELECT SERIAL FROM OBJECT      &
										WHERE SERIAL = " 
		szSQLSyntaxArray[2]	= "SELECT SERIAL FROM AUDIT_TRAIL &
										WHERE SERIAL = " 		
		iSQLCount				= 2

	Case  "shipper"
		szSQLSyntaxArray[1]	= "SELECT ID FROM SHIPPER WHERE ID = "
		iSQLCount				= 1

	Case	"sales_order"
		szSQLSyntaxArray[1]	= "SELECT ORDER_NO FROM ORDER_HEADER  &
										WHERE ORDER_NO = "
		iSQLCount				= 1	

	Case "purchase_order"
		szSQLSyntaxArray[1]	= "SELECT PO_NUMBER FROM PO_HEADER &
										WHERE PO_NUMBER = "
		iSQLCount				= 1	

	Case "next_invoice"
		szSQLSyntaxArray[1]	= "SELECT INVOICE_NUMBER FROM SHIPPER &
										WHERE INVOICE_NUMBER = "
		iSQLCount				= 1	

	Case "bol_number"
		szSQLSyntaxArray[1]	= "SELECT BOL_NUMBER FROM BILL_OF_LADING &
										WHERE BOL_NUMBER = "
		iSQLCount				= 1

	Case "next_db_change"
		szSQLSyntaxArray[1]	= "SELECT CHANGE_NUMBER FROM DATABASE_CHANGES &
										WHERE CHANGE_NUMBER = "
		iSQLCount				= 1

End Choose

end subroutine

public subroutine wf_update_parameters (string szcolname, long ivalue);Choose Case szColName 

	Case "next_serial"
		Update parameters  
		Set next_serial = :iRetValue + 1  ;

	Case "purchase_order"
		Update parameters  
		Set purchase_order = :iRetValue + 1  ;

	Case "shipper"	
		Update parameters  
		Set shipper = :iRetValue + 1  ;

	Case "sales_order"	
		Update parameters  
		Set sales_order = :iRetValue + 1  ;

	Case "next_issue"	
		Update parameters  
		Set next_issue  = :iRetValue + 1  ;

	Case "next_invoice"
		Update parameters  
		Set next_invoice = :iRetValue + 1  ;

	Case "bol_number"
		Update parameters
		Set bol_number	= :iRetValue + 1 	;

	Case "next_db_change"
		Update parameters
		Set next_db_change = :iRetValue + 1 ;

End Choose

If SQLCA.SQLCode	= 0 then
	Commit;
	bGoodValue = wf_check_dw(iRetValue)	
Else		
	RollBack;		
	iRetValue	= 0
	iCount		= iCount + 1
	bGoodValue	= (iCount >= 10)
End If



end subroutine

on open;//************************************************************************
//* Declaration
//************************************************************************
String	szColName			//The column name used in calculation

//************************************************************************
//* Initialization
//************************************************************************
dw_parameters.SetTransObject(sqlca)
dw_parameters.Retrieve()
bGoodValue	= FALSE
szColName	= Message.StringParm
iCount		= 1

//************************************************************************
//* Main Routine
//************************************************************************

//Check whether this is the valid name
If wf_valid_colname(szColName) then										

	wf_build_sql_syntax(szColName)

	Do While (Not bGoodValue) AND (iCount <= 10)
		dw_parameters.Retrieve()
		iRetValue	= f_get_value ( dw_parameters.GetItemNumber(1, iColumn) )
		wf_update_parameters(szColName, iRetValue)																				//wf_valid_colname()
	Loop

End If

bFinish	= TRUE
CloseWithReturn(this, iRetValue)


end on

on w_get_parm_value.create
this.dw_1=create dw_1
this.dw_parameters=create dw_parameters
this.Control[]={this.dw_1,&
this.dw_parameters}
end on

on w_get_parm_value.destroy
destroy(this.dw_1)
destroy(this.dw_parameters)
end on

type dw_1 from datawindow within w_get_parm_value
int X=814
int Y=908
int Width=494
int Height=360
int TabOrder=20
boolean LiveScroll=true
end type

type dw_parameters from datawindow within w_get_parm_value
int X=256
int Y=32
int Width=1719
int Height=800
int TabOrder=10
string DataObject="d_list_parameters"
boolean LiveScroll=true
end type

