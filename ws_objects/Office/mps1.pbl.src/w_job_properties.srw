$PBExportHeader$w_job_properties.srw
forward
global type w_job_properties from Window
end type
type cb_exit from commandbutton within w_job_properties
end type
type cb_save from commandbutton within w_job_properties
end type
type cb_calcproj from commandbutton within w_job_properties
end type
type dw_workorder_header_info from datawindow within w_job_properties
end type
type dw_billofmaterial from datawindow within w_job_properties
end type
type dw_workorder_detail from datawindow within w_job_properties
end type
type tab_properties from tab within w_job_properties
end type
type tabpage_info from userobject within tab_properties
end type
type st_2 from statictext within tabpage_info
end type
type st_1 from statictext within tabpage_info
end type
type sle_1 from singlelineedit within tabpage_info
end type
type gb_1 from groupbox within tabpage_info
end type
type dw_info from datawindow within tabpage_info
end type
type tabpage_in from userobject within tab_properties
end type
type dw_projected from datawindow within tabpage_in
end type
type dw_available from datawindow within tabpage_in
end type
type tabpage_out from userobject within tab_properties
end type
type dw_wo_detail from datawindow within tabpage_out
end type
type tabpage_process from userobject within tab_properties
end type
type dw_process_others from datawindow within tabpage_process
end type
type dw_process from datawindow within tabpage_process
end type
type tabpage_status from userobject within tab_properties
end type
type dw_msp_jobstatusall from datawindow within tabpage_status
end type
type sle_laborhrs from singlelineedit within tabpage_status
end type
type sle_downtime from singlelineedit within tabpage_status
end type
type sle_defects from singlelineedit within tabpage_status
end type
type sle_mi from singlelineedit within tabpage_status
end type
type st_laborhrs from statictext within tabpage_status
end type
type st_downtime from statictext within tabpage_status
end type
type st_defect from statictext within tabpage_status
end type
type st_mi from statictext within tabpage_status
end type
type sle_jc from singlelineedit within tabpage_status
end type
type sle_act from singlelineedit within tabpage_status
end type
type st_jc from statictext within tabpage_status
end type
type sle_pre from singlelineedit within tabpage_status
end type
type sle_std from singlelineedit within tabpage_status
end type
type st_act from statictext within tabpage_status
end type
type st_pre from statictext within tabpage_status
end type
type st_std from statictext within tabpage_status
end type
type dw_msp_job_status from datawindow within tabpage_status
end type
type gb_7 from groupbox within tabpage_status
end type
type gb_6 from groupbox within tabpage_status
end type
type gb_5 from groupbox within tabpage_status
end type
type gb_4 from groupbox within tabpage_status
end type
type gb_3 from groupbox within tabpage_status
end type
type gb_2 from groupbox within tabpage_status
end type
type tabpage_yield from userobject within tab_properties
end type
type dw_msp_calculateyield from datawindow within tabpage_yield
end type
type tabpage_mps from userobject within tab_properties
end type
type dw_mps_per_wo from datawindow within tabpage_mps
end type
type tabpage_jobcost from userobject within tab_properties
end type
type dw_laborcost from datawindow within tabpage_jobcost
end type
type dw_downtimecost from datawindow within tabpage_jobcost
end type
type dw_scrapcost from datawindow within tabpage_jobcost
end type
type dw_actualcost from datawindow within tabpage_jobcost
end type
type dw_cost_sheet from datawindow within tabpage_jobcost
end type
type tabpage_tenfifty from userobject within tab_properties
end type
type cb_2 from commandbutton within tabpage_tenfifty
end type
type sle_2 from singlelineedit within tabpage_tenfifty
end type
type st_3 from statictext within tabpage_tenfifty
end type
type dw_machinelist from datawindow within tabpage_tenfifty
end type
type dw_gauge from datawindow within tabpage_tenfifty
end type
type dw_runtime from datawindow within tabpage_tenfifty
end type
type dw_out from datawindow within tabpage_tenfifty
end type
type dw_in from datawindow within tabpage_tenfifty
end type
type cb_1 from commandbutton within w_job_properties
end type
type tabpage_info from userobject within tab_properties
st_2 st_2
st_1 st_1
sle_1 sle_1
gb_1 gb_1
dw_info dw_info
end type
type tabpage_in from userobject within tab_properties
dw_projected dw_projected
dw_available dw_available
end type
type tabpage_out from userobject within tab_properties
dw_wo_detail dw_wo_detail
end type
type tabpage_process from userobject within tab_properties
dw_process_others dw_process_others
dw_process dw_process
end type
type tabpage_status from userobject within tab_properties
dw_msp_jobstatusall dw_msp_jobstatusall
sle_laborhrs sle_laborhrs
sle_downtime sle_downtime
sle_defects sle_defects
sle_mi sle_mi
st_laborhrs st_laborhrs
st_downtime st_downtime
st_defect st_defect
st_mi st_mi
sle_jc sle_jc
sle_act sle_act
st_jc st_jc
sle_pre sle_pre
sle_std sle_std
st_act st_act
st_pre st_pre
st_std st_std
dw_msp_job_status dw_msp_job_status
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
end type
type tabpage_yield from userobject within tab_properties
dw_msp_calculateyield dw_msp_calculateyield
end type
type tabpage_mps from userobject within tab_properties
dw_mps_per_wo dw_mps_per_wo
end type
type tabpage_jobcost from userobject within tab_properties
dw_laborcost dw_laborcost
dw_downtimecost dw_downtimecost
dw_scrapcost dw_scrapcost
dw_actualcost dw_actualcost
dw_cost_sheet dw_cost_sheet
end type
type tabpage_tenfifty from userobject within tab_properties
cb_2 cb_2
sle_2 sle_2
st_3 st_3
dw_machinelist dw_machinelist
dw_gauge dw_gauge
dw_runtime dw_runtime
dw_out dw_out
dw_in dw_in
end type
type tab_properties from tab within w_job_properties
tabpage_info tabpage_info
tabpage_in tabpage_in
tabpage_out tabpage_out
tabpage_process tabpage_process
tabpage_status tabpage_status
tabpage_yield tabpage_yield
tabpage_mps tabpage_mps
tabpage_jobcost tabpage_jobcost
tabpage_tenfifty tabpage_tenfifty
end type
end forward

global type w_job_properties from Window
int X=206
int Y=100
int Width=3328
int Height=2108
boolean TitleBar=true
string Title="Job Properties"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_exit ( )
event ue_save ( )
event ue_calcproj ( )
cb_exit cb_exit
cb_save cb_save
cb_calcproj cb_calcproj
dw_workorder_header_info dw_workorder_header_info
dw_billofmaterial dw_billofmaterial
dw_workorder_detail dw_workorder_detail
tab_properties tab_properties
cb_1 cb_1
end type
global w_job_properties w_job_properties

type variables
integer	ii_newindex

String  is_won

//uo_sle iuo_sle[]


end variables

forward prototypes
public subroutine wf_buildindata ()
public subroutine wf_buildprocessdata ()
public subroutine wf_buildstatusdata ()
public function decimal wf_calcruntime (decimal ad_balance, decimal ad_ppp)
public subroutine wf_calculateyield ()
end prototypes

event ue_exit;Close(This)
end event

event ue_save;string	ls_Tool
choose case ii_newindex 
	case 1
		if tab_properties.tabpage_info.dw_info.update() > 0 then
			commit;
		else
			rollback ;
		end if		
	case 4
		tab_properties.tabpage_process.dw_process_others.AcceptText()	
		ls_Tool = tab_properties.tabpage_process.dw_process_others.object.tool [ 1 ]	
		update	work_order
		set	tool = :ls_Tool
		where	work_order = :is_won;
		if sqlca.SQLNRows > 0 then
			commit;
		else
			rollback;
		end if 	
		
		if tab_properties.tabpage_process.dw_process.update() > 0 then
			commit;
		else
			rollback ;
		end if
end choose		
end event

event ue_calcproj;Messagebox('Message','To be included')
end event

public subroutine wf_buildindata ();Long	ll_totalrows
Long	ll_currentrow
Long	ll_comptotalrows
Long	ll_compcurrentrow
Long	ll_count
String	ls_part
String	ls_component
String	ls_description
String	ls_type
String	ls_bomtype
String	ls_um
Dec	ln_qty
Dec	ln_compqty
Dec	ln_onhand
Dec	ln_required

ll_totalrows = dw_workorder_detail.Retrieve ( is_won )
if ll_totalrows > 0 then
	tab_properties.tabpage_in.dw_available.reset()
	tab_properties.tabpage_in.dw_projected.reset()
	
	for ll_currentrow = 1 to ll_totalrows
			ls_part = dw_workorder_detail.object.part [ ll_currentrow ] 
			ls_description = dw_workorder_detail.object.name [ ll_currentrow ] 
			ln_qty  = dw_workorder_detail.object.balance [ ll_currentrow ] 
			ls_um	= dw_workorder_detail.object.standard_unit [ ll_currentrow ] 
			
			tab_properties.tabpage_in.dw_projected.insertrow(1)
			tab_properties.tabpage_in.dw_projected.setitem ( 1 , 'part', ls_part )
			tab_properties.tabpage_in.dw_projected.setitem ( 1 , 'description', ls_description )
			tab_properties.tabpage_in.dw_projected.setitem ( 1 , 'um' , isnull(ls_um,'EA') ) 

			ll_comptotalrows = dw_billofmaterial.retrieve ( ls_part ) 
			
			if ll_comptotalrows > 0 then 
				for ll_compcurrentrow = 1 to ll_comptotalrows				
						ls_component 	= dw_billofmaterial.object.part [ ll_compcurrentrow ] 
						ls_description	= dw_billofmaterial.object.part_name [ ll_compcurrentrow ] 						
	  					ls_type	 	= dw_billofmaterial.object.part_class [ ll_compcurrentrow ] 						
						ls_bomtype 	= dw_billofmaterial.object.type [ ll_compcurrentrow ] 						
						ln_compqty   	= dw_billofmaterial.object.quantity [ ll_compcurrentrow ] 
						ln_onhand 	= dw_billofmaterial.object.part_online_on_hand [ ll_compcurrentrow ] 
						
						ll_count = tab_properties.tabpage_in.dw_available.Find ( "part='"+ls_component+"'",1,99999)
						if ll_count > 0 then 
							ln_required = tab_properties.tabpage_in.dw_available.object.qtyrequired [ ll_count ]
							ln_required += ln_qty * ln_compqty
						else
							ln_required = ln_qty * ln_compqty
							ll_count = 1
						end if 							
						tab_properties.tabpage_in.dw_available.insertrow ( 1 )
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'part', ls_component )
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'description', ls_description )
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'onhandqty' , ln_onhand ) 
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'type' , ls_type )
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'bomqty' , ln_compqty )
						
						if ls_bomtype='T' then ln_required=ln_compqty  // incase of a tool
						
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'qtyrequired' , ln_required ) 							
						tab_properties.tabpage_in.dw_available.setitem ( 1 , 'balance' , (ln_onhand - ln_required ) ) 
				next	
			end if 	
	next			
		
end if
end subroutine

public subroutine wf_buildprocessdata ();Long ll_row
tab_properties.tabpage_process.dw_process.retrieve ( is_won )
ll_row = dw_workorder_header_info.retrieve ( is_won )

if ll_row > 0 then 
	tab_properties.tabpage_process.dw_process_others.Insertrow(1)
	tab_properties.tabpage_process.dw_process_others.setitem (1,'processid',dw_workorder_header_info.object.process_id[ll_row])
	tab_properties.tabpage_process.dw_process_others.setitem (1,'tool',dw_workorder_header_info.object.tool[ll_row])
	tab_properties.tabpage_process.dw_process_others.setitem (1,'processed_runtime',dw_workorder_header_info.object.runtime[ll_row])
	tab_properties.tabpage_process.dw_process_others.setitem (1,'predicted_runtime',dw_workorder_header_info.object.runtime[ll_row])	
	tab_properties.tabpage_process.dw_process_others.setitem (1,'cycleunit',dw_workorder_header_info.object.cycle_unit[ll_row])	
	tab_properties.tabpage_process.dw_process_others.setitem (1,'cycletime',dw_workorder_header_info.object.cycle_time[ll_row])		
end if 	

end subroutine

public subroutine wf_buildstatusdata ();Dec	ln_std, &
	ln_pre, &
	ln_act, &
	ln_jc, &
	ln_defects, &
	ln_downtime, &
	ln_laborhrs, &
	ln_mi, & 
	ln_ajc, &
	ln_ami
	
//sqlca.autocommit = true
tab_properties.tabpage_status.dw_msp_jobstatusall.retrieve ( is_won )
//sqlca.autocommit = false

ln_std = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.stdruntime[1],2)
ln_pre = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.preruntime[1],2)
ln_act = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.actruntime[1],2)
ln_jc  = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.jcqty[1],2)
ln_mi  = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.miqty[1],2)
ln_downtime = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.downtime[1],2)
ln_defects  = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.defects[1],2)
ln_laborhrs = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.laborhours[1],2)
ln_ajc  = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.ajcqty[1],2)
ln_ami  = round(tab_properties.tabpage_status.dw_msp_jobstatusall.object.amiqty[1],2)

tab_properties.tabpage_status.st_std.text = 'Standard  '+String(ln_std) +' hrs'
tab_properties.tabpage_status.st_pre.text = 'Predicted '+String(ln_pre) +' hrs'
tab_properties.tabpage_status.st_act.text = 'Actual    '+String(ln_act) +' hrs'
tab_properties.tabpage_status.st_jc. text = 'Completion '+String(ln_jc) +' %'
tab_properties.tabpage_status.st_mi. text = 'Issues '+String(ln_mi) +' %'
tab_properties.tabpage_status.st_defect.text = 'Qty. '+String(ln_defects)
tab_properties.tabpage_status.st_downtime.text = 'Downtime '+String(ln_downtime)
tab_properties.tabpage_status.st_laborhrs.text = 'Time Log '+String(ln_laborhrs)+' hrs'

if (ln_std * 951 ) / 100 < 951 then 
	tab_properties.tabpage_status.sle_std.width = (ln_std * 951 ) / 100
else
	tab_properties.tabpage_status.sle_std.width = 951
end if 	
if (ln_pre * 951 ) / 100 < 951 then 
	tab_properties.tabpage_status.sle_pre.width = (ln_pre * 951 ) / 100
else
	tab_properties.tabpage_status.sle_pre.width = 951
end if 
if (ln_act * 951 ) / 100 < 951 then 
	tab_properties.tabpage_status.sle_act.width = (ln_act * 951 ) / 100
else
	tab_properties.tabpage_status.sle_act.width = 951
end if 
if (ln_jc * 951) / 100 < 951 then 
	tab_properties.tabpage_status.sle_jc.width =  (ln_jc * 951) / 100
	tab_properties.tabpage_status.sle_jc.text =  string ( ln_ajc ) 
else
	tab_properties.tabpage_status.sle_jc.width =  951
	tab_properties.tabpage_status.sle_jc.text =  string ( ln_ajc ) 	
end if 	
if (ln_mi * 951) / 100 < 951 then 
	tab_properties.tabpage_status.sle_mi.width =  (ln_mi * 951) / 100
	tab_properties.tabpage_status.sle_mi.text =  string ( ln_ami ) 
else
	tab_properties.tabpage_status.sle_mi.width =  951
	tab_properties.tabpage_status.sle_mi.text =  string ( ln_ami ) 	
end if 
if (ln_defects * 951) / 100 < 951 then 
	tab_properties.tabpage_status.sle_defects.width = (ln_defects * 951) / 100
else
	tab_properties.tabpage_status.sle_defects.width = 951
end if 
if (ln_downtime * 951) / 100 < 951 then
	tab_properties.tabpage_status.sle_downtime.width = (ln_downtime * 951) / 100
else
	tab_properties.tabpage_status.sle_downtime.width = 951
end if 
if (ln_laborhrs * 951) / 100 < 951 then 
	tab_properties.tabpage_status.sle_laborhrs.width = (ln_laborhrs * 951) / 100
else
	tab_properties.tabpage_status.sle_laborhrs.width = 951
end if 	

end subroutine

public function decimal wf_calcruntime (decimal ad_balance, decimal ad_ppp);Return ( ad_balance / isnull ( ad_ppp , 1 ) ) 
end function

public subroutine wf_calculateyield ();string	ls_part 
decimal	ld_rqty

if dw_workorder_detail.retrieve ( is_won ) > 0 then 
	ls_part	= dw_workorder_detail.object.part [ 1 ]
	ld_rqty = dw_workorder_detail.object.qty_required [ 1 ]

//	sqlca.autocommit = true
	tab_properties.tabpage_yield.dw_msp_calculateyield.retrieve ( ls_part, ld_rqty, is_won ) 
//	sqlca.autocommit = false	
end if 
end subroutine

on w_job_properties.create
this.cb_exit=create cb_exit
this.cb_save=create cb_save
this.cb_calcproj=create cb_calcproj
this.dw_workorder_header_info=create dw_workorder_header_info
this.dw_billofmaterial=create dw_billofmaterial
this.dw_workorder_detail=create dw_workorder_detail
this.tab_properties=create tab_properties
this.cb_1=create cb_1
this.Control[]={this.cb_exit,&
this.cb_save,&
this.cb_calcproj,&
this.dw_workorder_header_info,&
this.dw_billofmaterial,&
this.dw_workorder_detail,&
this.tab_properties,&
this.cb_1}
end on

on w_job_properties.destroy
destroy(this.cb_exit)
destroy(this.cb_save)
destroy(this.cb_calcproj)
destroy(this.dw_workorder_header_info)
destroy(this.dw_billofmaterial)
destroy(this.dw_workorder_detail)
destroy(this.tab_properties)
destroy(this.cb_1)
end on

event open;this.Bringtotop = True
is_won = Message.StringParm

end event

type cb_exit from commandbutton within w_job_properties
int X=2775
int Y=1888
int Width=334
int Height=96
int TabOrder=50
string Text="Exit"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_job_properties.Triggerevent ('ue_exit')
end event

type cb_save from commandbutton within w_job_properties
int X=2409
int Y=1888
int Width=334
int Height=96
int TabOrder=40
string Text="Save"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_job_properties.Triggerevent ('ue_save')
end event

type cb_calcproj from commandbutton within w_job_properties
int X=1792
int Y=1888
int Width=590
int Height=96
int TabOrder=80
string Text="Production Potential"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;datastore lds_ppqty
string	ls_part

Messagebox ( 'System Message','Production Potential is based on the current Inventory available',Information!)

ls_part	= tab_properties.tabpage_in.dw_projected.object.part [ 1 ]
lds_ppqty = Create Datastore
lds_ppqty.dataobject = 'd_msp_productionpotential'
lds_ppqty.settransobject ( sqlca )
//sqlca.autocommit = true
if lds_ppqty.retrieve ( ls_part ) > 0 then 
	tab_properties.tabpage_in.dw_projected.setitem ( 1 , 'calc_weight' , lds_ppqty.object.pptime [ 1 ] )
	tab_properties.tabpage_in.dw_projected.setitem ( 1 , 'projected_qty' ,lds_ppqty.object.onhand [ 1 ] )
end if	
//sqlca.autocommit = false
destroy lds_ppqty

end event

type dw_workorder_header_info from datawindow within w_job_properties
int X=928
int Y=1884
int Width=384
int Height=300
int TabOrder=70
boolean Visible=false
string DataObject="dw_workorder_header_info"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;Settransobject(sqlca)
end event

type dw_billofmaterial from datawindow within w_job_properties
int X=507
int Y=1888
int Width=384
int Height=300
int TabOrder=60
boolean Visible=false
string DataObject="d_billofmaterial"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;Settransobject(sqlca)
end event

type dw_workorder_detail from datawindow within w_job_properties
int X=32
int Y=1888
int Width=384
int Height=300
int TabOrder=30
boolean Visible=false
string DataObject="d_workorder_detail"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;Settransobject(sqlca)
end event

type tab_properties from tab within w_job_properties
int X=14
int Y=12
int Width=3282
int Height=1816
int TabOrder=10
boolean RaggedRight=true
Alignment Alignment=Center!
int SelectedTab=1
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_info tabpage_info
tabpage_in tabpage_in
tabpage_out tabpage_out
tabpage_process tabpage_process
tabpage_status tabpage_status
tabpage_yield tabpage_yield
tabpage_mps tabpage_mps
tabpage_jobcost tabpage_jobcost
tabpage_tenfifty tabpage_tenfifty
end type

on tab_properties.create
this.tabpage_info=create tabpage_info
this.tabpage_in=create tabpage_in
this.tabpage_out=create tabpage_out
this.tabpage_process=create tabpage_process
this.tabpage_status=create tabpage_status
this.tabpage_yield=create tabpage_yield
this.tabpage_mps=create tabpage_mps
this.tabpage_jobcost=create tabpage_jobcost
this.tabpage_tenfifty=create tabpage_tenfifty
this.Control[]={this.tabpage_info,&
this.tabpage_in,&
this.tabpage_out,&
this.tabpage_process,&
this.tabpage_status,&
this.tabpage_yield,&
this.tabpage_mps,&
this.tabpage_jobcost,&
this.tabpage_tenfifty}
end on

on tab_properties.destroy
destroy(this.tabpage_info)
destroy(this.tabpage_in)
destroy(this.tabpage_out)
destroy(this.tabpage_process)
destroy(this.tabpage_status)
destroy(this.tabpage_yield)
destroy(this.tabpage_mps)
destroy(this.tabpage_jobcost)
destroy(this.tabpage_tenfifty)
end on

event selectionchanged;string	ls_machine
string	ls_part

ii_newindex = newindex
Choose case newindex
	case 1		
			cb_calcproj.Enabled = False		
			cb_save.Enabled = True
			tabpage_info.dw_info.retrieve ( is_won )
			tabpage_info.st_1.text = 'Completion:    ' + string ( int (tabpage_info.dw_info.object.percentage [ 1 ] ) ) +'%' 
			tabpage_info.sle_1.width = (tabpage_info.gb_1.width * int (tabpage_info.dw_info.object.percentage [ 1 ] ) ) / 100
	case 2	
			cb_calcproj.Enabled = True
			cb_save.Enabled = False
			wf_buildindata()   
	case 3			
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
			tabpage_out.dw_wo_detail.retrieve ( is_won )		
	case 4
			cb_calcproj.Enabled = False
			cb_save.Enabled = True
			wf_buildprocessdata()
	case 5
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
			wf_buildstatusdata()
	case 6
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
			wf_calculateyield ( ) 	
	case 7
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
//			sqlca.autocommit = true
			tabpage_mps.dw_mps_per_wo.retrieve ( is_won )					
//			sqlca.autocommit = false
	case 8
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
			tabpage_jobcost.dw_laborcost.retrieve ( is_won )						
			tabpage_jobcost.dw_downtimecost.retrieve ( is_won )			
			tabpage_jobcost.dw_actualcost.retrieve ( is_won )
			tabpage_jobcost.dw_scrapcost.retrieve ( is_won )			
//			sqlca.autocommit = true
			tabpage_jobcost.dw_cost_sheet.retrieve ( is_won )					
//			sqlca.autocommit = false
	case 9		
			cb_calcproj.Enabled = False
			cb_save.Enabled = False
			
			select	machine_no
			into	:ls_machine
			from	work_order
			where	work_order = :is_won ;

			tabpage_tenfifty.dw_machinelist.reset()
			tabpage_tenfifty.dw_machinelist.insertrow ( 0 )
			tabpage_tenfifty.dw_machinelist.setitem ( 1, 'machine', ls_machine )

			tabpage_tenfifty.dw_gauge.Retrieve ( ls_machine )
			tabpage_tenfifty.dw_runtime.Retrieve ( ls_machine )
			
			SetNull ( ls_part )
//			sqlca.autocommit = true
			tabpage_tenfifty.dw_in.Retrieve ( ls_machine, ls_part, ls_part )
			tabpage_tenfifty.dw_out.Retrieve ( ls_machine, ls_part )
//			sqlca.autocommit = true			
End Choose			

end event

type tabpage_info from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Info     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
st_2 st_2
st_1 st_1
sle_1 sle_1
gb_1 gb_1
dw_info dw_info
end type

on tabpage_info.create
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.gb_1=create gb_1
this.dw_info=create dw_info
this.Control[]={this.st_2,&
this.st_1,&
this.sle_1,&
this.gb_1,&
this.dw_info}
end on

on tabpage_info.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.gb_1)
destroy(this.dw_info)
end on

type st_2 from statictext within tabpage_info
int X=1481
int Y=1108
int Width=105
int Height=64
boolean Enabled=false
string Text="100"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within tabpage_info
int X=32
int Y=1112
int Width=398
int Height=64
boolean Enabled=false
string Text="Completion :      0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within tabpage_info
int X=453
int Y=1116
int Width=9
int Height=52
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=255
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within tabpage_info
int X=439
int Y=1068
int Width=1038
int Height=116
int TabOrder=30
string Text="%"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_info from datawindow within tabpage_info
int X=14
int Y=28
int Width=3209
int Height=1576
int TabOrder=20
string DataObject="d_job_information"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
end type

event constructor;Settransobject(sqlca)

end event

event retrieveend;Dec	ln_required, &
		ln_completed, &
		ln_percentage

//ln_required = dw_info.object.qty_required[1]		
//ln_completed = dw_info.object.qty_completed[1]		
//ln_percentage = ( ln_completed * 100 ) / ln_required
//sle_1.backcolor = RGB(0, 0, 255)
//sle_1.width = ln_percentage * 10
//

end event

type tabpage_in from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     In     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_projected dw_projected
dw_available dw_available
end type

on tabpage_in.create
this.dw_projected=create dw_projected
this.dw_available=create dw_available
this.Control[]={this.dw_projected,&
this.dw_available}
end on

on tabpage_in.destroy
destroy(this.dw_projected)
destroy(this.dw_available)
end on

type dw_projected from datawindow within tabpage_in
int X=9
int Y=872
int Width=3218
int Height=784
int TabOrder=20
string DataObject="d_external_projected_quantity_for_job"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

type dw_available from datawindow within tabpage_in
int X=9
int Y=40
int Width=3218
int Height=784
int TabOrder=30
string DataObject="dw_external_qty_available"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

type tabpage_out from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Out     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_wo_detail dw_wo_detail
end type

on tabpage_out.create
this.dw_wo_detail=create dw_wo_detail
this.Control[]={this.dw_wo_detail}
end on

on tabpage_out.destroy
destroy(this.dw_wo_detail)
end on

type dw_wo_detail from datawindow within tabpage_out
int X=18
int Y=28
int Width=3218
int Height=1636
int TabOrder=20
string DataObject="d_workorder_detail"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event constructor;Settransobject(sqlca)
end event

type tabpage_process from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Process     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_process_others dw_process_others
dw_process dw_process
end type

on tabpage_process.create
this.dw_process_others=create dw_process_others
this.dw_process=create dw_process
this.Control[]={this.dw_process_others,&
this.dw_process}
end on

on tabpage_process.destroy
destroy(this.dw_process_others)
destroy(this.dw_process)
end on

type dw_process_others from datawindow within tabpage_process
int X=14
int Y=52
int Width=3214
int Height=800
int TabOrder=40
string DataObject="d_process_others"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;DataWindowChild ldwc_process

this.GetChild ( 'processid',  ldwc_process )

ldwc_process.settransobject(sqlca)
ldwc_process.retrieve()
end event

type dw_process from datawindow within tabpage_process
int X=14
int Y=880
int Width=3214
int Height=800
int TabOrder=30
string DataObject="d_process_detail_info"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;Settransobject(sqlca)
end event

event itemchanged;dec	ld_Balance
dec	ld_RunTime
dec	ld_PPP
dec	ld_ppc
string	ls_cycleunit

AcceptText()

ld_Balance	= object.workorder_detail_qty_required [ row ] - object.workorder_detail_qty_completed [ row ]
ld_PPP		= object.workorder_detail_parts_per_hour [ row ]
Choose Case dwo.name 
	Case "workorder_detail_parts_per_hour"
			ld_RunTime = wf_calcruntime ( ld_Balance, ld_PPP )
			dw_process_others.setitem ( 1, 'processed_runtime', ld_RunTime )
			dw_process_others.setitem ( 1, 'predicted_runtime', ld_RunTime )			
			setitem ( row , 'workorder_detail_run_time' , ld_RunTime ) 
			
	Case "workorder_detail_parts_per_cycle"
			ld_PPC		= object.workorder_detail_parts_per_cycle [ row ]
			ls_cycleunit	= object.work_order_cycle_unit [ row ]
			if isnull(ls_cycleunit) then ls_cycleunit = 'Hour'
			this.SetItem(row, "workorder_detail_parts_per_hour", &
							 f_parts_per_hour( ls_CycleUnit, ld_PPP, ld_PPC ) )
			ld_RunTime = wf_calcruntime ( ld_Balance, ld_PPP ) 							 
			dw_process_others.setitem ( 1, 'processed_runtime', ld_RunTime )
			dw_process_others.setitem ( 1, 'predicted_runtime', ld_RunTime )						
			setitem ( row , 'workorder_detail_run_time' , ld_RunTime ) 
			
	Case "workorder_detail_qty_required"
			if  ld_Balance <= 0 then
				Messagebox('System Message',"Required qty cannot be less than or equal to completed qty")
			else
				setitem ( row, 'workorder_detail_balance', ld_Balance ) 	
				ld_RunTime = wf_calcruntime ( ld_Balance, ld_PPP ) 
				dw_process_others.setitem ( 1, 'processed_runtime', ld_RunTime )
				dw_process_others.setitem ( 1, 'predicted_runtime', ld_RunTime )				
				setitem ( row , 'workorder_detail_run_time' , ld_RunTime )  				
			end if 	
End Choose		


end event

type tabpage_status from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Status     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_msp_jobstatusall dw_msp_jobstatusall
sle_laborhrs sle_laborhrs
sle_downtime sle_downtime
sle_defects sle_defects
sle_mi sle_mi
st_laborhrs st_laborhrs
st_downtime st_downtime
st_defect st_defect
st_mi st_mi
sle_jc sle_jc
sle_act sle_act
st_jc st_jc
sle_pre sle_pre
sle_std sle_std
st_act st_act
st_pre st_pre
st_std st_std
dw_msp_job_status dw_msp_job_status
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
end type

on tabpage_status.create
this.dw_msp_jobstatusall=create dw_msp_jobstatusall
this.sle_laborhrs=create sle_laborhrs
this.sle_downtime=create sle_downtime
this.sle_defects=create sle_defects
this.sle_mi=create sle_mi
this.st_laborhrs=create st_laborhrs
this.st_downtime=create st_downtime
this.st_defect=create st_defect
this.st_mi=create st_mi
this.sle_jc=create sle_jc
this.sle_act=create sle_act
this.st_jc=create st_jc
this.sle_pre=create sle_pre
this.sle_std=create sle_std
this.st_act=create st_act
this.st_pre=create st_pre
this.st_std=create st_std
this.dw_msp_job_status=create dw_msp_job_status
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.dw_msp_jobstatusall,&
this.sle_laborhrs,&
this.sle_downtime,&
this.sle_defects,&
this.sle_mi,&
this.st_laborhrs,&
this.st_downtime,&
this.st_defect,&
this.st_mi,&
this.sle_jc,&
this.sle_act,&
this.st_jc,&
this.sle_pre,&
this.sle_std,&
this.st_act,&
this.st_pre,&
this.st_std,&
this.dw_msp_job_status,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2}
end on

on tabpage_status.destroy
destroy(this.dw_msp_jobstatusall)
destroy(this.sle_laborhrs)
destroy(this.sle_downtime)
destroy(this.sle_defects)
destroy(this.sle_mi)
destroy(this.st_laborhrs)
destroy(this.st_downtime)
destroy(this.st_defect)
destroy(this.st_mi)
destroy(this.sle_jc)
destroy(this.sle_act)
destroy(this.st_jc)
destroy(this.sle_pre)
destroy(this.sle_std)
destroy(this.st_act)
destroy(this.st_pre)
destroy(this.st_std)
destroy(this.dw_msp_job_status)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
end on

type dw_msp_jobstatusall from datawindow within tabpage_status
int X=1550
int Y=60
int Width=1673
int Height=1320
int TabOrder=80
string DataObject="d_msp_jobstatusall"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject ( sqlca ) 
end event

type sle_laborhrs from singlelineedit within tabpage_status
int X=530
int Y=1256
int Width=9
int Height=64
int TabOrder=40
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=12639424
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_downtime from singlelineedit within tabpage_status
int X=530
int Y=1056
int Width=9
int Height=64
int TabOrder=40
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=128
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_defects from singlelineedit within tabpage_status
int X=530
int Y=864
int Width=9
int Height=64
int TabOrder=100
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_mi from singlelineedit within tabpage_status
int X=530
int Y=660
int Width=9
int Height=64
int TabOrder=90
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_laborhrs from statictext within tabpage_status
int X=59
int Y=1260
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_downtime from statictext within tabpage_status
int X=59
int Y=1064
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_defect from statictext within tabpage_status
int X=59
int Y=860
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_mi from statictext within tabpage_status
int X=59
int Y=668
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_jc from singlelineedit within tabpage_status
int X=530
int Y=460
int Width=9
int Height=64
int TabOrder=80
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=65535
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_act from singlelineedit within tabpage_status
int X=530
int Y=260
int Width=9
int Height=64
int TabOrder=70
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16711935
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_jc from statictext within tabpage_status
int X=59
int Y=460
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pre from singlelineedit within tabpage_status
int X=530
int Y=172
int Width=9
int Height=64
int TabOrder=60
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=8421376
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_std from singlelineedit within tabpage_status
int X=530
int Y=88
int Width=9
int Height=64
int TabOrder=50
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_act from statictext within tabpage_status
int X=59
int Y=252
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_pre from statictext within tabpage_status
int X=59
int Y=172
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_std from statictext within tabpage_status
int X=59
int Y=88
int Width=448
int Height=64
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_msp_job_status from datawindow within tabpage_status
int X=27
int Y=1428
int Width=1312
int Height=236
int TabOrder=50
boolean Visible=false
string DataObject="d_msp_job_status"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;Settransobject(sqlca)
end event

type gb_7 from groupbox within tabpage_status
int X=18
int Y=1188
int Width=1504
int Height=180
int TabOrder=30
string Text="Operator"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_6 from groupbox within tabpage_status
int X=18
int Y=988
int Width=1504
int Height=180
int TabOrder=40
string Text="Downtime"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within tabpage_status
int X=18
int Y=792
int Width=1504
int Height=180
int TabOrder=50
string Text="Defects"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within tabpage_status
int X=18
int Y=592
int Width=1504
int Height=180
int TabOrder=40
string Text="Material Issue"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within tabpage_status
int X=18
int Y=384
int Width=1504
int Height=180
int TabOrder=30
string Text="Job Completion"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within tabpage_status
int X=18
int Y=28
int Width=1504
int Height=328
int TabOrder=50
string Text="Runtime"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tabpage_yield from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Yield     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_msp_calculateyield dw_msp_calculateyield
end type

on tabpage_yield.create
this.dw_msp_calculateyield=create dw_msp_calculateyield
this.Control[]={this.dw_msp_calculateyield}
end on

on tabpage_yield.destroy
destroy(this.dw_msp_calculateyield)
end on

type dw_msp_calculateyield from datawindow within tabpage_yield
int X=41
int Y=48
int Width=3186
int Height=1604
int TabOrder=80
string DataObject="d_msp_calculateyield"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event constructor;settransobject(sqlca)

end event

type tabpage_mps from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Mps     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_mps_per_wo dw_mps_per_wo
end type

on tabpage_mps.create
this.dw_mps_per_wo=create dw_mps_per_wo
this.Control[]={this.dw_mps_per_wo}
end on

on tabpage_mps.destroy
destroy(this.dw_mps_per_wo)
end on

type dw_mps_per_wo from datawindow within tabpage_mps
int X=23
int Y=28
int Width=3218
int Height=1636
int TabOrder=40
string DataObject="d_mps_per_workorder"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;Settransobject(sqlca)
end event

type tabpage_jobcost from userobject within tab_properties
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=77897888
string Text="     Job Cost     "
long TabBackColor=77897888
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_laborcost dw_laborcost
dw_downtimecost dw_downtimecost
dw_scrapcost dw_scrapcost
dw_actualcost dw_actualcost
dw_cost_sheet dw_cost_sheet
end type

on tabpage_jobcost.create
this.dw_laborcost=create dw_laborcost
this.dw_downtimecost=create dw_downtimecost
this.dw_scrapcost=create dw_scrapcost
this.dw_actualcost=create dw_actualcost
this.dw_cost_sheet=create dw_cost_sheet
this.Control[]={this.dw_laborcost,&
this.dw_downtimecost,&
this.dw_scrapcost,&
this.dw_actualcost,&
this.dw_cost_sheet}
end on

on tabpage_jobcost.destroy
destroy(this.dw_laborcost)
destroy(this.dw_downtimecost)
destroy(this.dw_scrapcost)
destroy(this.dw_actualcost)
destroy(this.dw_cost_sheet)
end on

type dw_laborcost from datawindow within tabpage_jobcost
int Y=1116
int Width=1545
int Height=508
int TabOrder=40
string DataObject="d_laborcost"
boolean TitleBar=true
string Title="Transactions pertaining to Labor"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;settransobject(sqlca)
end event

type dw_downtimecost from datawindow within tabpage_jobcost
int Y=612
int Width=1545
int Height=508
int TabOrder=50
string DataObject="d_downtimecost"
boolean TitleBar=true
string Title="Transactions pertaining to DownTime"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;settransobject ( sqlca ) 
end event

type dw_scrapcost from datawindow within tabpage_jobcost
int X=1541
int Y=52
int Width=1687
int Height=780
int TabOrder=60
string DataObject="d_scrapcost"
boolean TitleBar=true
string Title="Transactions pertaining to Scrap"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;settransobject ( sqlca ) 
end event

type dw_actualcost from datawindow within tabpage_jobcost
int Y=52
int Width=1545
int Height=560
int TabOrder=60
string DataObject="d_actualcost"
boolean TitleBar=true
string Title="Transactions pertaining to Actual Cost"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;settransobject(sqlca)
end event

type dw_cost_sheet from datawindow within tabpage_jobcost
int X=1541
int Y=832
int Width=1687
int Height=792
int TabOrder=40
string DataObject="d_msp_jcs"
boolean TitleBar=true
string Title="Cost at a Glance"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;Settransobject(sqlca)
end event

type tabpage_tenfifty from userobject within tab_properties
event create ( )
event destroy ( )
int X=18
int Y=112
int Width=3246
int Height=1688
long BackColor=79741120
string Text="1050"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
cb_2 cb_2
sle_2 sle_2
st_3 st_3
dw_machinelist dw_machinelist
dw_gauge dw_gauge
dw_runtime dw_runtime
dw_out dw_out
dw_in dw_in
end type

on tabpage_tenfifty.create
this.cb_2=create cb_2
this.sle_2=create sle_2
this.st_3=create st_3
this.dw_machinelist=create dw_machinelist
this.dw_gauge=create dw_gauge
this.dw_runtime=create dw_runtime
this.dw_out=create dw_out
this.dw_in=create dw_in
this.Control[]={this.cb_2,&
this.sle_2,&
this.st_3,&
this.dw_machinelist,&
this.dw_gauge,&
this.dw_runtime,&
this.dw_out,&
this.dw_in}
end on

on tabpage_tenfifty.destroy
destroy(this.cb_2)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.dw_machinelist)
destroy(this.dw_gauge)
destroy(this.dw_runtime)
destroy(this.dw_out)
destroy(this.dw_in)
end on

type cb_2 from commandbutton within tabpage_tenfifty
int X=5
int Y=1588
int Width=494
int Height=92
int TabOrder=60
string Text="Exit"
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within tabpage_tenfifty
int X=677
int Y=1080
int Width=165
int Height=76
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="5"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_tenfifty
int X=14
int Y=1080
int Width=654
int Height=76
boolean Enabled=false
string Text="Refresh Time (in seconds)"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_machinelist from datawindow within tabpage_tenfifty
int X=14
int Y=16
int Width=827
int Height=1052
int TabOrder=60
string DataObject="d_machinelist1"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_gauge from datawindow within tabpage_tenfifty
int X=5
int Y=1164
int Width=494
int Height=416
int TabOrder=60
string DataObject="d_gauge"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_runtime from datawindow within tabpage_tenfifty
int X=521
int Y=1164
int Width=2702
int Height=512
int TabOrder=50
string DataObject="d_runtime_downtime_mssql"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_out from datawindow within tabpage_tenfifty
int X=859
int Y=636
int Width=2363
int Height=508
int TabOrder=100
string DataObject="d_1050_compl"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_in from datawindow within tabpage_tenfifty
int X=859
int Y=16
int Width=2363
int Height=604
int TabOrder=70
string DataObject="d_1050_iss"
BorderStyle BorderStyle=StyleLowered!
end type

event constructor;settransobject(sqlca)
end event

type cb_1 from commandbutton within w_job_properties
int X=2245
int Y=1296
int Width=192
int Height=84
int TabOrder=20
string Text="Exit"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.Triggerevent('ue_exit')
end event

