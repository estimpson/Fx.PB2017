$PBExportHeader$w_runtime_issue_entry.srw
forward
global type w_runtime_issue_entry from Window
end type
type dw_internal_issue from datawindow within w_runtime_issue_entry
end type
type ddlb_name from dropdownlistbox within w_runtime_issue_entry
end type
type ddlb_module from dropdownlistbox within w_runtime_issue_entry
end type
type st_3 from statictext within w_runtime_issue_entry
end type
type cb_exit from commandbutton within w_runtime_issue_entry
end type
type cb_save from commandbutton within w_runtime_issue_entry
end type
type st_2 from statictext within w_runtime_issue_entry
end type
type mle_description from multilineedit within w_runtime_issue_entry
end type
type dw_issue from datawindow within w_runtime_issue_entry
end type
type sle_name from singlelineedit within w_runtime_issue_entry
end type
type st_1 from statictext within w_runtime_issue_entry
end type
end forward

global type w_runtime_issue_entry from Window
int X=649
int Y=428
int Width=1618
int Height=1196
boolean TitleBar=true
string Title="Monitor Quick Issue Update"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
dw_internal_issue dw_internal_issue
ddlb_name ddlb_name
ddlb_module ddlb_module
st_3 st_3
cb_exit cb_exit
cb_save cb_save
st_2 st_2
mle_description mle_description
dw_issue dw_issue
sle_name sle_name
st_1 st_1
end type
global w_runtime_issue_entry w_runtime_issue_entry

type variables
Boolean		ib_Internal
Transaction	itrans_Issues
end variables

forward prototypes
public function string wf_get_product_code (string szText)
end prototypes

public function string wf_get_product_code (string szText);CHOOSE CASE szText

	CASE "Shipping"
		Return "MSD30"

	Case "Production Scheduling"
		Return "MPS30"

	Case "Order Entry"
		Return "MOE30"

	Case "Receiving DocK"
		Return "MRD30"

	Case "Purchasing"
		Return "MPO30"

	Case "Inventory Control (Touch Screen)"
		Return "MIT30"

	Case "Inventory Control (Non Touch Screen)"
		Return "MIC30"

END CHOOSE

end function

event open;String	szLine, &
			s_Name, &
			s_Module
Long		iNextIssue
Int		i_InternalReference



If SQLCA.SQLCode = 0 And f_get_value ( i_InternalReference ) = 91 Then 
	ib_Internal = True
	ddlb_module.Reset ( )
	ddlb_name.Reset ( )
	itrans_Issues = CREATE Transaction
	itrans_Issues.DBMS		= "ODBC"
	itrans_Issues.DBParm	= "Connectstring='DSN=ISSUES'"
	connect using itrans_Issues ;
	If itrans_Issues.SQLCode <> 0 Then
		MessageBox ( "Error", "Unable to connect to issues database!  Please consult with your system administrator.", StopSign! )
		Return
	End if

	 DECLARE modules CURSOR FOR  
	  SELECT product_code.description  
	    FROM product_code  
	   WHERE product_code.product_line = 'SOFTWARE'   
	ORDER BY product_code.description ASC  
		USING itrans_Issues ;

	Open modules ;
	Do
		Fetch modules Into :s_Module ;
		If itrans_Issues.SQLCode = 0 Then
			ddlb_module.AddItem ( s_Module )
		End if
	Loop While itrans_Issues.SQLCode = 0
	Close modules ;

	 DECLARE employees CURSOR FOR  
	  SELECT origin.origin  
	    FROM origin  
	   WHERE origin.internal = 'Y'   
	ORDER BY origin.origin ASC  
		USING itrans_Issues ;

	Open employees ;
	Do
		Fetch employees Into :s_Name ;
		If itrans_Issues.SQLCode = 0 Then
			ddlb_name.AddItem ( s_Name )
		End if
	Loop While itrans_Issues.SQLCode = 0
	Close employees ;

Else

	dw_issue.SetTransObject(sqlca)

	szLine	= error.text + " at line " + String(error.line) + &
				  " in window " + error.windowmenu + " for object " + &
				  error.object + " in event " + error.ObjectEvent

	mle_description.text	= szLine


	  SELECT issues.issue_number  
	    INTO :iNextIssue  
	    FROM issues  
	   WHERE issues.issue = :szLine   ;

	If SQLCA.SQLCode = 0 then
		MessageBox("Warning", "Identical issue is already existing in the issue system.", StopSign!)
		Close(this)
	End If


	 DECLARE employee_list CURSOR FOR  
	  SELECT employee.name  
	    FROM employee  
	ORDER BY employee.name ASC  ;

	Open employee_list ;
	Do
		Fetch employee_list Into :s_Name ;
		If SQLCA.SQLCode = 0 Then
			ddlb_name.AddItem ( s_Name )
		End if
	Loop While SQLCA.SQLCode = 0
	Close employee_list ;
	
End if
end event

on w_runtime_issue_entry.create
this.dw_internal_issue=create dw_internal_issue
this.ddlb_name=create ddlb_name
this.ddlb_module=create ddlb_module
this.st_3=create st_3
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.st_2=create st_2
this.mle_description=create mle_description
this.dw_issue=create dw_issue
this.sle_name=create sle_name
this.st_1=create st_1
this.Control[]={this.dw_internal_issue,&
this.ddlb_name,&
this.ddlb_module,&
this.st_3,&
this.cb_exit,&
this.cb_save,&
this.st_2,&
this.mle_description,&
this.dw_issue,&
this.sle_name,&
this.st_1}
end on

on w_runtime_issue_entry.destroy
destroy(this.dw_internal_issue)
destroy(this.ddlb_name)
destroy(this.ddlb_module)
destroy(this.st_3)
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.st_2)
destroy(this.mle_description)
destroy(this.dw_issue)
destroy(this.sle_name)
destroy(this.st_1)
end on

type dw_internal_issue from datawindow within w_runtime_issue_entry
int X=567
int Y=880
int Width=494
int Height=360
int TabOrder=60
boolean Visible=false
string DataObject="d_internal_issue_entry"
boolean LiveScroll=true
end type

type ddlb_name from dropdownlistbox within w_runtime_issue_entry
int X=603
int Y=96
int Width=841
int Height=624
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_module from dropdownlistbox within w_runtime_issue_entry
int X=603
int Y=208
int Width=841
int Height=608
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Shipping",&
"Production Scheduling",&
"Order Entry",&
"Receiving Dock",&
"Purchasing",&
"Inventory Control (Touch Screen)",&
"Inventory Control (Non Touch Screen)",&
"Shop Floor"}
end type

type st_3 from statictext within w_runtime_issue_entry
int X=165
int Y=208
int Width=366
int Height=64
boolean Enabled=false
string Text="Module Name"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_exit from commandbutton within w_runtime_issue_entry
int X=1189
int Y=848
int Width=247
int Height=108
int TabOrder=80
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(w_runtime_issue_entry)
end on

type cb_save from commandbutton within w_runtime_issue_entry
int X=914
int Y=848
int Width=247
int Height=108
int TabOrder=70
string Text="Save"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/* 01-27-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'iNextIssue' (next Issue number).  */

Long iNextIssue

If Not ib_Internal Then

//	bFinish	= FALSE																									-  CHG 01-27-2000 KAZ
//	OpenWithParm(w_get_parm_value, "next_issue")																-  CHG 01-27-2000 KAZ
//
//	Do while Not bFinish 																							-  CHG 01-27-2000 KAZ
//	Loop																													-  CHG 01-27-2000 KAZ
//
//	iNextIssue	= Message.DoubleParm																				-  CHG 01-27-2000 KAZ
//
//	If iNextIssue > 0 then																							-  CHG 01-27-2000 KAZ

	if sqlca.of_getnextparmvalue ( "next_issue", iNextIssue ) then    // Get current value 	-  ADD 01-27-2000 KAZ

		dw_issue.Reset()
		dw_issue.InsertRow(1)

		dw_issue.SetItem(1, "issue_number", iNextIssue)
		dw_issue.SetItem(1, "status", 'O')
		dw_issue.SetItem(1, "start_date", Today())
		dw_issue.SetItem(1, "start_time", Now())
		dw_issue.SetItem(1, "issue", mle_description.text)
		dw_issue.SetItem(1, "sub_category", 'BUG')
		dw_issue.SetItem(1, "category", "Software-Windows")
		dw_issue.SetItem(1, "who_type", 'Contact')
		dw_issue.SetItem(1, "who", ddlb_name.text)
		dw_issue.SetItem(1, "product_line", "SOFTWARE")
		dw_issue.SetItem(1, "assigned", "*** Not Assigned ***")
		dw_issue.SetItem(1, "product_code", wf_get_product_code(ddlb_module.text))
	
		If dw_issue.Update() > 0 then
			Commit;
			MessageBox("System Message", "The issue " + String(iNextIssue) + " has been created.", Information!)
			close(w_runtime_issue_entry)
		Else
			Rollback;
		End If
	
	Else
		Rollback;																										// ADD 01-27-2000 KAZ
		MessageBox("Error", "Failed to get the next issue number.", StopSign!)
	End If
	
Else

	dw_internal_issue.SetTransObject ( itrans_Issues )

	dw_internal_issue.InsertRow(1)

	dw_internal_issue.SetItem(1, "issue_number", iNextIssue)
	dw_internal_issue.SetItem(1, "status", 'O')
	dw_internal_issue.SetItem(1, "start_date", DateTime ( Today ( ), Now ( ) ) )
	dw_internal_issue.SetItem(1, "issue", mle_description.text)
	dw_internal_issue.SetItem(1, "sub_category", 'BUG')
	dw_internal_issue.SetItem(1, "category", "Software-Windows")
	dw_internal_issue.SetItem(1, "origin_type", 'Employee')
	dw_internal_issue.SetItem(1, "origin", ddlb_name.text)
	dw_internal_issue.SetItem(1, "product_line", "SOFTWARE")
	dw_internal_issue.SetItem(1, "assigned_to", "")
	dw_internal_issue.SetItem(1, "product_code", "" )

	If dw_internal_issue.Update() > 0 then
		Commit;
		MessageBox("System Message", "The issue " + String(iNextIssue) + " has been created.", Information!)
		close(w_runtime_issue_entry)
	Else
		Rollback;
	End If

End if
end event

type st_2 from statictext within w_runtime_issue_entry
int X=165
int Y=304
int Width=311
int Height=72
boolean Enabled=false
string Text="Description"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_description from multilineedit within w_runtime_issue_entry
int X=165
int Y=384
int Width=1280
int Height=432
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_issue from datawindow within w_runtime_issue_entry
int X=37
int Y=880
int Width=494
int Height=360
int TabOrder=50
boolean Visible=false
string DataObject="d_issue_entry"
boolean LiveScroll=true
end type

type sle_name from singlelineedit within w_runtime_issue_entry
int X=603
int Y=96
int Width=841
int Height=80
int TabOrder=10
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_runtime_issue_entry
int X=165
int Y=112
int Width=293
int Height=64
boolean Enabled=false
string Text="Your Name"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

