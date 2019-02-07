$PBExportHeader$w_machine.srw
forward
global type w_machine from Window
end type
type cb_note from commandbutton within w_machine
end type
type cb_2 from commandbutton within w_machine
end type
type cb_1 from commandbutton within w_machine
end type
type dw_6 from datawindow within w_machine
end type
type cb_8 from commandbutton within w_machine
end type
type cb_7 from commandbutton within w_machine
end type
type cb_6 from commandbutton within w_machine
end type
type cb_5 from commandbutton within w_machine
end type
type cb_4 from commandbutton within w_machine
end type
type dw_1 from datawindow within w_machine
end type
type dw_3 from datawindow within w_machine
end type
type dw_2 from datawindow within w_machine
end type
end forward

global type w_machine from Window
int X=14
int Y=28
int Width=3351
int Height=2012
boolean TitleBar=true
long BackColor=77897888
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
event ue_refresh pbm_custom01
cb_note cb_note
cb_2 cb_2
cb_1 cb_1
dw_6 dw_6
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
global w_machine w_machine

type variables
String 		szProcessId
String 		szPart
String 		szWorkOrder
String 		szMachine
String		is_startstoplogin='Y'

end variables

forward prototypes
public subroutine wf_retrieve_workorder_dw ()
end prototypes

on ue_refresh;dw_2.Retrieve ( szMachine )
end on

public subroutine wf_retrieve_workorder_dw (); DECLARE workorder_detail CURSOR FOR  
  SELECT workorder_detail.part,   
         workorder_detail.qty_required,   
         workorder_detail.qty_completed,   
         workorder_detail.scrapped,
			part.name  
    FROM workorder_detail,part  
   WHERE ( part.part = workorder_detail.part ) AND 
			workorder_detail.workorder = :szWorkOrder
ORDER BY workorder_detail.part ASC  ;

 DECLARE last_defect CURSOR FOR  
  SELECT defects.reason,   
         defects.defect_time,   
         defects.defect_date  
    FROM defects  
   WHERE ( defects.machine = :szMachine ) AND  
         ( defects.part = :szPart )   
ORDER BY defects.defect_date DESC,   
         defects.defect_time DESC  ;

String 	szLastDefect,&
			l_s_name
Long 		lRow
Dec 		dQtyRequired
Dec		dQtyCompleted
Dec		dScrap
Dec		dBalance
Date 		dLastDefectDate
Time 		tLastDefectTime
DateTime	dtLastDefectDate
DateTime	dtLastDefectTime

dw_3.Reset ( )

Open workorder_detail ;
	
Fetch workorder_detail Into :szPart, :dQtyRequired, :dQtyCompleted, :dScrap, :l_s_name ;

Do While SQLCA.SQLCode = 0 
		
	dQtyRequired = f_get_value ( dQtyRequired )
	dQtyCompleted = f_get_value ( dQtyCompleted )
	dBalance = dQtyRequired - dQtyCompleted
	dScrap = f_get_value ( dScrap )

	If SQLCA.SQLCode = 0 Then

		Open last_defect ;
	
		Fetch last_defect Into :szLastDefect, :dtLastDefectTime, :dtLastDefectDate ;
			
		tLastDefectTime = Time(dtLastDefectTime)
		dLastDefectDate = Date(dtLastDefectDate)

		Close last_defect ;

		lRow = dw_3.RowCount ( ) + 1
		dw_3.InsertRow ( 0 )
//		dw_3.ScrollToRow ( lRow )

		dw_3.SetItem ( lRow, "part", szPart )
		dw_3.SetItem ( lRow, "qty_required", dQtyRequired )
		dw_3.SetItem ( lRow, "qty_completed", dQtyCompleted )
		dw_3.SetItem ( lRow, "balance", dBalance )
		dw_3.SetItem ( lRow, "scrapped", dScrap )
		dw_3.SetItem ( lRow, "last_defect", szLastDefect )
		dw_3.SetItem ( lRow, "last_defect_time", tLastDefectTime )
		dw_3.SetItem ( lRow, "part_name", l_s_name )
		
	End if

	Fetch workorder_detail Into :szPart, :dQtyRequired, :dQtyCompleted, :dScrap, :l_s_name ;

Loop 

Close workorder_detail ;

end subroutine

on activate;if NOT ( Message.StringParm > '' ) THEN &
	Message.StringParm = szMachine
TriggerEvent ( 'open' )

end on

event open;/*
	get the machine no. selected from the previous window
	activate the datawindow objects 
*/
// AMF 07-06-98 Set a application instance variable to the machine number that has
//              been selected.

Long nRowNumber
Long lRow

szMachine = Message.StringParm
szworkorder = ''

// AMF 07-06-98 Set the machine number
dw_1.settransobject ( sqlca )
dw_1.retrieve (szMachine)

dw_2.settransobject ( sqlca )

If dw_2.retrieve (szMachine) > 0 Then 

	/////////////////////////////////////////////////////////////////////
	//
	// getthe process id from the workorder
	//
	

	nRowNumber  = dw_2.GetRow ( )


	szWorkOrder = f_get_string_value ( dw_2.GetItemString (nRowNumber, "work_order") )
	
	// display the parts selected from process id

//	wf_retrieve_workorder_dw ( )

End if

wf_retrieve_workorder_dw ( )
end event

on w_machine.create
this.cb_note=create cb_note
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_6=create dw_6
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.cb_note,&
this.cb_2,&
this.cb_1,&
this.dw_6,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.dw_3,&
this.dw_2}
end on

on w_machine.destroy
destroy(this.cb_note)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_6)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

type cb_note from commandbutton within w_machine
int X=805
int Y=768
int Width=768
int Height=128
int TabOrder=80
string Text="Note"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if dw_2.rowcount ( ) > 0 then
	OpenUserObjectWithParm ( uo_workorder_note, szWorkOrder, 300, 200 )
	uo_workorder_note.uf_assign_parent ( parent )
	uo_workorder_note.BringToTop = TRUE
end if

end on

type cb_2 from commandbutton within w_machine
int X=1719
int Y=720
int Width=1097
int Height=192
int TabOrder=70
string Text="Display Downtime"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array lncst_aa
lncst_aa.of_setitem("machine",szmachine)
openwithparm (w_shop_down_gr, lncst_aa)
end event

type cb_1 from commandbutton within w_machine
int X=1719
int Y=464
int Width=1097
int Height=192
int TabOrder=60
string Text="Enter Downtime"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array lncst_aa
szoperator = ''
Open ( w_touch_keypad )
If (szOperator <> "" and len(szoperator) > 0) Then
	If dw_3.RowCount() > 0 then
		szRemQty = dw_3.GetItemDecimal(1,"balance")
	End If
	lncst_aa.of_setitem("machine",szmachine)
	lncst_aa.of_setitem("part",szpart)
	lncst_aa.of_setitem("workorder",szworkorder)
	lncst_aa.of_setitem("qty",szRemqty)	
	openwithparm ( w_downtime_enter_2, lncst_aa)
End if 	
end event

type dw_6 from datawindow within w_machine
int X=1719
int Y=288
int Width=1097
int Height=128
int TabOrder=20
string DataObject="d_clock"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

type cb_8 from commandbutton within w_machine
int X=622
int Y=1600
int Width=475
int Height=192
string Text="Labor"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//	Code to open w_labor_maintenance screen based on the setup in the machine policy screen
//	If start/stop login is enable or set to yes further processing is allowed if not no
//	The program doesn't proceed further, if the quantity required is 0
//
//	Development:	start/stop login Check included 	3/23/00 by gph
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

If dw_3.rowcount()=0 Then Return

String l_s_activity, &
       l_s_location
st_laborhrs stlbrhrs

select	start_stop_login
into	:is_startstoplogin
from	machine_policy
where	machine = :szmachine ;

If is_startstoplogin <> 'Y' Then 
	messagebox ("System Message", "Labor entry Disabled. Change the same under Machine Policy or contact your system administrator")
	Return
End if 	

Select code,group_location
  into :l_s_activity, :l_s_location
  from activity_router
 where parent_part= :szpart ;

stlbrhrs.workorder = szworkorder
stlbrhrs.part      = szpart
stlbrhrs.activity  = l_s_activity
stlbrhrs.location  = szmachine

openwithparm(w_labor_maintenance,stlbrhrs)
end event

type cb_7 from commandbutton within w_machine
int X=37
int Y=1600
int Width=475
int Height=192
int TabOrder=110
string Text="Process"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;n_cst_associative_array lncst_aalist
string	ls_processcontrol
string	ls_machine

select	process_control
into	:ls_processcontrol
from	machine_policy
where	machine = :szmachine;

If ls_processcontrol <> 'Y' Then 
	messagebox ("System Message", "Process Control Disabled. Contact your system administrator")
	Return
End if 	

lncst_aalist.of_setitem("machine",szmachine)
lncst_aalist.of_setitem("part",szpart)
lncst_aalist.of_setitem("workorder",szworkorder)

openwithparm (w_process_new, lncst_aalist)

end event

type cb_6 from commandbutton within w_machine
int X=2341
int Y=1600
int Width=475
int Height=192
int TabOrder=100
string Text="Exit"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_5 from commandbutton within w_machine
int X=1774
int Y=1600
int Width=475
int Height=192
int TabOrder=90
string Text="Inventory"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If dw_3.rowcount()=0 Then Return

szOperator = ''
Open ( w_touch_keypad )

do while IsValid ( w_touch_keypad )
loop

If szOperator = "" Then Return

OpenWithParm (w_machine_inventory, szMachine)

end event

type cb_4 from commandbutton within w_machine
int X=1207
int Y=1600
int Width=475
int Height=192
int TabOrder=50
string Text="Schedule"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If dw_3.rowcount()=0 Then Return
String szScheduleMode
szScheduleMode	= f_machine_schedule_mode(szMachine)
If IsNull(szScheduleMode) then
	MessageBox("Warning", "No machine policy specified for schedule mode", StopSign!)
	Return
End If
Choose Case szScheduleMode
	Case "H"		//Hard Queue
		OpenWithParm ( w_sf_schedule_status, szMachine )
End Choose



end event

type dw_1 from datawindow within w_machine
int X=37
int Y=16
int Width=2889
int Height=240
int TabOrder=10
string DataObject="dw_machine_header"
boolean Border=false
boolean LiveScroll=true
end type

type dw_3 from datawindow within w_machine
int Y=928
int Width=2871
int Height=640
int TabOrder=40
string DataObject="d_workorder_detail_external"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;long	ll_Row
st_Generic_Structure	stGenParm

szOperator = ''
Open ( w_touch_keypad )

do while IsValid ( w_touch_keypad )
loop
If szOperator = "" Then Return

ll_Row = dw_3.Getclickedrow ( )
If ( ll_Row = 0 ) Then Return
szPart = dw_3.GetItemstring ( ll_Row, "part" )
stGenParm.Value1 = szOperator
stGenParm.Value2 = szPart
stGenParm.Value3 = szMachine
stGenParm.Value4 = szWorkOrder
OpenWithParm ( w_part_production, stGenParm )
end on

type dw_2 from datawindow within w_machine
int X=37
int Y=288
int Width=1646
int Height=624
int TabOrder=30
string DataObject="dw_workorder_sf"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

on retrieveend;cb_note.enabled = ( RowCount ( ) > 0 )

end on

