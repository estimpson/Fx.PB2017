$PBExportHeader$w_manual_wo_create.srw
forward
global type w_manual_wo_create from Window
end type
type cb_create from commandbutton within w_manual_wo_create
end type
type cb_exit from commandbutton within w_manual_wo_create
end type
type dw_parts_info from datawindow within w_manual_wo_create
end type
type dw_parts_select from datawindow within w_manual_wo_create
end type
type dw_demand_qty from datawindow within w_manual_wo_create
end type
end forward

global type w_manual_wo_create from Window
int X=727
int Y=436
int Width=2053
int Height=1224
boolean TitleBar=true
string Title="Manual Work Order Creation"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
event ue_exit ( )
event ue_create ( )
cb_create cb_create
cb_exit cb_exit
dw_parts_info dw_parts_info
dw_parts_select dw_parts_select
dw_demand_qty dw_demand_qty
end type
global w_manual_wo_create w_manual_wo_create

forward prototypes
public function decimal wf_calc_runtime ()
end prototypes

event ue_exit;Close(this)
end event

event ue_create;////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//	Modifications	GPH	7/27/00	changed the the approach from dw to using sqlsa 
////////////////////////////////////////////////////////////////////////////////////////////////////////////

if dw_parts_select.rowcount() > 0 then
	string   ls_part
	string   ls_process_id
	string   ls_machine_no
	string   ls_cycle_unit
	string   ls_message
	datetime ldt_due_date	
	datetime ldt_start_date
	datetime ldt_end_date	
	decimal  ld_qty	
	decimal  ld_setup_time
	decimal  ld_runtime
	decimal  ld_parts_per_hour
	decimal  ld_parts_per_cycle
	long     li_cycle_time	
	long     ll_result
	datastore	lds_workorder	
	string	ls_ExecuteStatement
	string	ls_workorder
	
	declare manualcreate dynamic procedure for SQLSA;

	setnull(ls_workorder)
	
	dw_parts_select.accepttext()		
	dw_parts_info.AcceptText()
	ls_part = dw_parts_select.object.part[1]
	ld_qty  = dw_parts_select.object.qty[1]
	if ls_part > '' and ld_qty > 0 then
		dw_parts_info.setredraw ( false )		
		ldt_due_date  = datetime(today(), time('00/00/00'))
		ldt_start_date= dw_parts_info.object.start_date[1]
		ldt_end_date  = dw_parts_info.object.end_date[1]		
		ls_process_id = dw_parts_info.object.process_id[1]
		ls_machine_no = dw_parts_info.object.machine_no[1]
		ld_setup_time = dw_parts_info.object.setup_time[1]
		ld_runtime    = dw_parts_info.object.runtime[1] 
		li_cycle_time = dw_parts_info.object.cycle_time[1]
		ls_cycle_unit = dw_parts_info.object.cycle_unit[1]
		ld_parts_per_hour = dw_parts_info.object.parts_per_hour[1]
		ld_parts_per_cycle = dw_parts_info.object.parts_per_cycle[1]
	
		sqlca.autocommit = true
		lds_workorder = create datastore
		lds_workorder.DataObject = "d_msp_wo_creation"	
		lds_workorder.SetTransObject ( sqlca )
		lds_workorder.Retrieve (ls_part, ld_qty, ldt_due_date, ls_process_id, ls_machine_no, & 
					ld_setup_time, ld_runtime, li_cycle_time, ls_cycle_unit, &
										ld_parts_per_hour, ld_parts_per_cycle, ldt_start_date, &
										ldt_end_date, 0, '')
		sqlca.autocommit = false

/*
		ls_ExecuteStatement = &
			"begin "+&
			"	declare @returnvalue integer "+&
			" "+&
			" 	execute msp_wo_creation " + &
			"		?, "+&
			"		?, "+&			
			"		?, "+&
			"		?, "+&
			"		?, "+&			
			"		?, "+&			
			"		?, "+&
			"		?, "+&			
			"		?, "+&
			"		?, "+&
			"		?, "+&
			"		?, "+&
			"		?, "+&			
			"		@returnvalue OUTPUT "+&
			" "+&
			"	select @returnvalue "+&
			"end "
			
		prepare SQLSA from :ls_ExecuteStatement ;	
		
		execute dynamic manualcreate using :ls_part, :ld_qty, :ldt_due_date, :ls_process_id, &
				:ls_machine_no, :ld_setup_time, :ld_runtime, :li_cycle_time, :ls_cycle_unit, &
				:ld_parts_per_hour, :ld_parts_per_cycle, :ldt_start_date, &
				:ldt_end_date ;
		
		fetch	manualcreate
		into	:ll_result;
		
		close	manualcreate ;
*/

		if lds_workorder.rowcount() > 0 then 
		   Choose Case lds_workorder.object.result[1] 
				Case -1
					rollback;
					ls_message = 'Work order header failed'
				Case -2
					rollback;
					ls_message = 'Work order detail failed'
				Case -3
					rollback;
					ls_message = 'Unable to update next workorder number'
				Case else
					commit;
					ls_message = 'Work order '+lds_workorder.object.work_order[1]+' created successfully'
		   End Choose
		else	
			ls_message = 'Unable to create the work order'			
		end if 	
/*
		Choose Case ll_result
			Case -1
				rollback;								
				ls_message = 'Work order header failed'
			Case -2
				rollback;				
				ls_message = 'Work order detail failed'
			Case -3
				rollback;				
				ls_message = 'Unable to update next workorder number'
			Case else
				commit ;	
				ls_message = 'Work order created successfully'
		End Choose
*/
		dw_parts_info.setredraw ( true )
		
		Messagebox("System Message",ls_message)					
//		destroy lds_workorder
		dw_demand_qty.reset()
		dw_parts_info.reset()
		dw_parts_select.reset()
		dw_parts_select.insertrow(0)
	end if 
end if 
end event

public function decimal wf_calc_runtime ();dec ld_pph
string ls_include_st	 
dw_parts_info.Accepttext()
ld_pph = dw_parts_info.object.parts_per_hour[1]
ls_include_st = dw_parts_info.object.include_st[1]
if ld_pph = 0 then ld_pph = 1
if ls_include_st = 'Y' then
	Return (dw_parts_select.object.qty[1] * (1 / ld_pph)) + dw_parts_info.object.setup_time[1]
else	
	Return (dw_parts_select.object.qty[1] * (1 / ld_pph))
end if
end function

on w_manual_wo_create.create
this.cb_create=create cb_create
this.cb_exit=create cb_exit
this.dw_parts_info=create dw_parts_info
this.dw_parts_select=create dw_parts_select
this.dw_demand_qty=create dw_demand_qty
this.Control[]={this.cb_create,&
this.cb_exit,&
this.dw_parts_info,&
this.dw_parts_select,&
this.dw_demand_qty}
end on

on w_manual_wo_create.destroy
destroy(this.cb_create)
destroy(this.cb_exit)
destroy(this.dw_parts_info)
destroy(this.dw_parts_select)
destroy(this.dw_demand_qty)
end on

event activate;//Changemenu ( m_manual_wo_menu )
end event

type cb_create from commandbutton within w_manual_wo_create
int X=1349
int Y=1000
int Width=297
int Height=88
int TabOrder=30
string Text="Create"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_parts_select.accepttext()
w_manual_wo_create.Triggerevent('ue_create')
end event

type cb_exit from commandbutton within w_manual_wo_create
int X=1682
int Y=1000
int Width=297
int Height=88
int TabOrder=10
string Text="Exit"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_manual_wo_create.Triggerevent('ue_exit')
end event

type dw_parts_info from datawindow within w_manual_wo_create
int X=50
int Y=228
int Width=1266
int Height=860
int TabOrder=20
string DataObject="d_msp_get_part_info"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

event itemchanged;CHOOSE CASE dwo.Name
	CASE "parts_per_cycle"
		SetItem(row, "parts_per_hour", &
			 f_parts_per_hour(GetItemString(row, "cycle_unit"), &
			 						Dec(data), &
									GetItemNumber(row, "cycle_time")))
		SetItem(row, "runtime", wf_calc_runtime())
	CASE "cycle_time"
		SetItem(row, "parts_per_hour", &
			 f_parts_per_hour(GetItemString(row, "cycle_unit"), &
			 						GetItemNumber(row, "parts_per_cycle"), &
									Dec(data)))
		SetItem(row, "runtime", wf_calc_runtime())									
	CASE "cycle_unit"
		SetItem(row, "parts_per_hour", &
			 f_parts_per_hour(data, &
			 						GetItemNumber(row, "parts_per_cycle"), &
									GetItemNumber(row, "cycle_time")))
		SetItem(row, "runtime", wf_calc_runtime())
	CASE "parts_per_hour"									
		SetItem(row, "runtime", wf_calc_runtime())
	CASE "setup_time"									
		SetItem(row, "runtime", wf_calc_runtime())
END CHOOSE

end event

type dw_parts_select from datawindow within w_manual_wo_create
int X=27
int Y=36
int Width=1975
int Height=1080
int TabOrder=40
string DataObject="d_parts_select"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
if dw_parts_select.rowcount() = 0 then this.insertrow(0)
end event

event itemchanged;any la_data
la_data = data
if dwo.name = 'part' then 
//	sqlca.autocommit = true
	dw_demand_qty.retrieve(la_data)
//	sqlca.autocommit = false
end if 	

end event

event losefocus;string ls_part
decimal ld_qty
ls_part = getitemstring(1,'part')
ld_qty  = getitemdecimal(1,'qty')
//sqlca.autocommit = true
dw_parts_info.retrieve(ls_part, ld_qty)
//sqlca.autocommit = false
dw_parts_info.setfocus()

end event

type dw_demand_qty from datawindow within w_manual_wo_create
int X=1157
int Y=64
int Width=832
int Height=316
boolean BringToTop=true
string DataObject="d_msp_get_demand_quantity"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

event doubleclicked;w_manual_wo_create.Triggerevent('ue_details')
end event

