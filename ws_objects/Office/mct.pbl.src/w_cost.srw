$PBExportHeader$w_cost.srw
forward
global type w_cost from w_sheet_4t
end type
type st_horizontal3 from statictext within w_cost
end type
type st_horizontal2 from statictext within w_cost
end type
type st_horizontal1 from statictext within w_cost
end type
type st_vertical from statictext within w_cost
end type
type dw_bom_temp from datawindow within w_cost
end type
type dw_partlist from datawindow within w_cost
end type
type dw_bom_parts from datawindow within w_cost
end type
type dw_parttype from datawindow within w_cost
end type
type dw_cost_details_adnl from datawindow within w_cost
end type
type dw_cost_details from datawindow within w_cost
end type
type dw_other_info from datawindow within w_cost
end type
type dw_different_types_costs from datawindow within w_cost
end type
type mle_1 from multilineedit within w_cost
end type
type dw_all_costs from datawindow within w_cost
end type
type dw_select_view from datawindow within w_cost
end type
type dw_cost_graph from datawindow within w_cost
end type
type cb_display from commandbutton within w_cost
end type
type dw_vbom from datawindow within w_cost
end type
type dw_vbomprint from datawindow within w_cost
end type
type dw_move_info from datawindow within w_cost
end type
end forward

global type w_cost from w_sheet_4t
string tag = "Monitor"
string title = "Visual Bill of Material "
string menuname = "m_cost_menu"
event ue_exit pbm_custom01
event ue_cost pbm_custom03
event ue_save pbm_custom04
event ue_rollup pbm_custom05
event ue_changelabor pbm_custom06
event ue_changemachine pbm_custom07
event ue_global pbm_custom08
event ue_build_graphdata pbm_custom09
event ue_print_cost pbm_custom10
event ue_move pbm_custom11
event ue_view pbm_custom12
event ue_clicked_popup ( string arg_text )
event ue_global_move pbm_custom13
st_horizontal3 st_horizontal3
st_horizontal2 st_horizontal2
st_horizontal1 st_horizontal1
st_vertical st_vertical
dw_bom_temp dw_bom_temp
dw_partlist dw_partlist
dw_bom_parts dw_bom_parts
dw_parttype dw_parttype
dw_cost_details_adnl dw_cost_details_adnl
dw_cost_details dw_cost_details
dw_other_info dw_other_info
dw_different_types_costs dw_different_types_costs
mle_1 mle_1
dw_all_costs dw_all_costs
dw_select_view dw_select_view
dw_cost_graph dw_cost_graph
cb_display cb_display
dw_vbom dw_vbom
dw_vbomprint dw_vbomprint
dw_move_info dw_move_info
end type
global w_cost w_cost

type variables
String       i_s_part="", &
                i_s_laborcode="", &
                i_s_machinecode="", &
                i_s_inc_st="" , & 
                i_s_parttype='M', &
                i_s_columnname='cost_cum', &
                i_s_partcode='', &
                i_s_prevpartcode='', &
                i_s_bucket='S', &
                i_s_display_str='Std Cost for ' 

Long       i_l_parts_per_hour=0, &
               i_l_setuptime , &
               i_l_rowno=1, &
               i_l_enablearray[6]={1,1,1,1,1,1}, &
               il_totalrows=0

Decimal  i_d_stdrate=0, &
               i_d_machinerate=0

boolean i_b_withparm=false, &
                  i_b_setuptime=true 

DataWindow	idw_Data[4]

uo_vbom_tv  tv_vbom

// The following are used for the resizing service
boolean		ib_debug=False	//Debug mode
long		il_hiddencolor=0	//Bar hidden color to match the window background
long		il_OldHeight	//Save the height of the window
integer		ii_barthickness=11	//Bar Thickness
integer		ii_windowborder=15	//Window border to be used on all sides
dragobject	idrg_Vertical	//Reference to the vertical control on the left of the window
dragobject	idrg_Horizontal[4]	//Reference to the horizontal controls on the right of the window
statictext		ist_Horizontal[3]	//Reference to the horizontal bars
                 
end variables

forward prototypes
public subroutine wf_01_explode ()
public subroutine wf_02_display_details ()
public subroutine wf_03_build_costs (string arg_s_part)
public subroutine wf_04_other_info (string arg_s_part)
public subroutine wf_05_bld_cst ()
public subroutine wf_getpart ()
public function integer wf_refreshbars ()
public function integer wf_resizebars ()
public function integer wf_resizepanels ()
public subroutine wf_move_utility (string arg_from, string arg_to, string arg_movetype)
public subroutine wf_refreshscreen ()
end prototypes

event ue_exit;close(this)
end event

event ue_save;IF i_s_part <> '' THEN
	String l_s_parttmp
	Int    l_i_rwcur
   IF dw_cost_details.rowcount() > 0 THEN 	
      // updating the datawindow 
   	IF dw_cost_details.UPDATE() <= 0 THEN
   		Messagebox(monsys.msg_title,"Unable to save the data") 
   		ROLLBACK ;
		ELSE
			COMMIT ;
	   END IF  
      IF (i_s_machinecode <> '' and NOT ISNULL(i_s_machinecode)) THEN
   	   l_s_parttmp = dw_cost_details.getitemstring(1,'part')		
		   // updating labor code if they have selected a diff labor code
		   UPDATE part_machine // part_mfg has been changed as a view, so using part_machine
			   SET labor_code = :i_s_laborcode
		    WHERE (part_machine.part  = :l_s_parttmp and
			        part_machine.machine = :i_s_machinecode) ;
		   IF sqlca.sqlcode = -1 THEN
	   		Messagebox(monsys.msg_title,"Unable to save the data") 
			   ROLLBACK ;
		   ELSE
			   COMMIT ;
	   	END IF  
		END IF 	
	END IF 
ELSE
	Beep(5)
	Messagebox(monsys.msg_title,"Invalid Part")
END IF 

end event

event ue_rollup;IF i_s_part <> '' THEN 
	String l_s_part 
   Long   l_l_tvi
   l_s_part=i_s_part  
	SETPOINTER(Hourglass!)
	sqlca.autocommit=TRUE	
	IF g_s_platform = 'Microsoft SQL Server' THEN
		DECLARE mct_computecost PROCEDURE FOR 'msp_calc_costs'
			:l_s_part, :i_s_bucket ;
		Execute mct_computecost ;
		IF sqlca.sqlcode < 0 THEN
			MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
		ELSE
			Beep(5)
			Messagebox(monsys.msg_title,"Cost rollup was successful")
			wf_01_explode()			
			wf_02_display_details()
		END IF
	Else
		DECLARE mct_wccomputecost PROCEDURE FOR 'msp_calc_costs'
			:l_s_part, :i_s_bucket; 
		Execute mct_wccomputecost ;
		IF sqlca.sqlcode < 0 THEN
			MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
		ELSE
			Beep(5)
			Messagebox(monsys.msg_title,"Cost rollup was successful")		
			wf_01_explode()
			wf_02_display_details()
		END IF
	End If	
	sqlca.autocommit=FALSE
	SETPOINTER(Arrow!)
ELSE
	Beep(5)
	Messagebox(monsys.msg_title,"Invalid Part")
END IF
end event

event ue_changelabor;IF i_s_part <> '' THEN
	IF i_s_parttype='M' THEN
		OPEN (w_changelaborrate)
	END IF 
ELSE
	Beep(5)
	Messagebox(monsys.msg_title,"Invalid Part")
END IF 
end event

event ue_changemachine;IF i_s_part <> '' THEN
	IF i_s_parttype='M' THEN 
		OPEN (w_changemcnrate)
	END IF
ELSE
	Beep(5)
	Messagebox(monsys.msg_title,"Invalid Part")
END IF 
end event

event ue_global;Long   l_l_current, &
       l_l_last
String l_s_part, &
       l_s_error_syntaxfromSQL, &
       l_s_error_create, &
       l_s_new_sql, &
		 l_s_new_syntax

Datastore dw_new
l_s_new_sql = 'SELECT part.part '  &
        + 'FROM part '  
l_s_new_syntax = SQLCA.SyntaxFromSQL(l_s_new_sql,  &
	'Style(Type=Form)', l_s_error_syntaxfromSQL)
IF LenA(l_s_error_syntaxfromSQL) > 0 THEN
	// Display errors
	Messagebox(monsys.msg_title,l_s_error_syntaxfromSQL)				
	RETURN
ELSE
	// Generate new DataWindow
	dw_new = CREATE datastore
	dw_new.Create(l_s_new_syntax, l_s_error_create)
	IF LenA(l_s_error_create) > 0 THEN
		Messagebox(monsys.msg_title,l_s_error_create)
		destroy dw_new
		RETURN 
	END IF
END IF
dw_new.SetTransObject(SQLCA)
dw_new.Retrieve()	
l_l_last=dw_new.rowcount()
l_l_current=1
cb_display.show()
l_s_part = "" 
sqlca.autocommit=TRUE
Do while (l_l_current < l_l_last)
	l_s_part=dw_new.object.#1[l_l_current]
	cb_display.text=l_s_part
	IF g_s_platform = 'Microsoft SQL Server' THEN
		DECLARE	mct_computecost PROCEDURE FOR 'msp_calc_costs' 
			:l_s_part, :i_s_bucket ;
		EXECUTE mct_computecost ;
		IF sqlca.sqlcode < 0 THEN
			MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
		END IF
	ELSE
		DECLARE	mct_wccomputecost PROCEDURE FOR 'msp_calc_costs' 
			:l_s_part, :i_s_bucket ;
		EXECUTE mct_wccomputecost ;
		IF sqlca.sqlcode < 0 THEN
			MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
		END IF
	END IF
	l_l_current ++ 
Loop
sqlca.autocommit=FALSE
cb_display.hide()
Destroy dw_new
Messagebox(monsys.msg_title,"Cost rollup of all the parts was successful")							

end event

event ue_build_graphdata;IF dw_cost_graph.visible = FALSE THEN 
	Int 		l_i_response, &
	         l_i_rwno, &
				l_i_newrw
				
	String 	l_s_part, &
				l_s_names[4], &
				l_s_col_nam[4]
				
	Dec 	   l_d_cost
	IF dw_all_costs.rowcount()=0 THEN wf_05_bld_cst()
   l_i_response = Messagebox(monsys.msg_title,"Would you like Individual cost",Question!,YesNoCancel!)	
	dw_cost_graph.reset()
	IF l_i_response = 3 THEN
		RETURN
	ELSEIF l_i_response = 2 THEN 
		dw_cost_graph.title = "Graphical representation of Overall Cost"
		FOR l_i_rwno = 1 TO dw_all_costs.rowcount()
			 l_s_part = dw_all_costs.getitemstring(l_i_rwno,'part')	
			 l_d_cost  = dw_all_costs.getitemdecimal(l_i_rwno,'cost')
			 l_i_newrw = dw_cost_graph.insertrow(0)	 
			 dw_cost_graph.scrolltorow(l_i_newrw)
			 dw_cost_graph.setitem(l_i_newrw,'part',l_s_part)
	 		 dw_cost_graph.setitem(l_i_newrw,'cost',l_d_cost)
		NEXT
	ELSE
		dw_cost_graph.title = "Graphical representation of Cost for "+dw_vbom.getitemstring(i_l_rowno,'part')
		l_s_names = {'Material','Labor','Burden','Other'}
		l_s_col_nam = {'Material_cum','Labor_cum','Burden_cum','Other_cum'}		
		FOR l_i_rwno = 1 TO 4
			 l_s_part = l_s_names[l_i_rwno]
			 l_d_cost  = dw_all_costs.getitemdecimal(i_l_rowno,l_s_col_nam[l_i_rwno])
			 dw_cost_graph.insertrow(l_i_rwno)	 
			 dw_cost_graph.setitem(l_i_rwno,'part',l_s_part)
		 	 dw_cost_graph.setitem(l_i_rwno,'cost',l_d_cost)
		NEXT
	END IF 
// calling the window to select graph type & display based on that	
   openwithparm(w_graph_type,dw_cost_graph)
	dw_cost_graph.visible = TRUE
ELSE
	dw_cost_graph.visible = FALSE
END IF 	

end event

event ue_print_cost;long	ll_node
long	ll_rowno
long	ll_level
String	ls_currentpart
String	ls_part

TreeviewItem	l_t_tv

Long l_l_job, &
     l_l_response
l_l_response = Messagebox(monsys.msg_title,"Print the Cost spreadsheet (Yes) or Treeview (No) ",Question!,YesNoCancel!,1)
IF l_l_response = 1 THEN
	l_l_job = Printopen()
	Printdatawindow(l_l_job,dw_all_costs)
	Printclose(l_l_job)
ELSEIF l_l_response = 2 THEN 	
	dw_vbomprint.reset() 
	ll_node = tv_vbom.FindItem ( RootTreeItem! , 0 )
	ll_rowno = 0
	do 
		tv_vbom.GetItem(ll_node,l_t_tv)
		ls_currentpart = l_t_tv.label
		ll_level = l_t_tv.level
		ll_rowno ++
		dw_vbomprint.insertrow ( 0 )
		dw_vbomprint.setitem ( ll_rowno, 'part', ls_currentpart )
		dw_vbomprint.setitem ( ll_rowno, 'xpos', (ll_level * 40 ) )	
		ll_node = tv_vbom.FindItem (NextVisibleTreeItem!, ll_node )
	loop while ll_node > 0
	dw_vbomprint.print ( ) 
END IF





end event

event ue_move;IF dw_move_info.Rowcount()=0 Then dw_move_info.Insertrow(0)
dw_move_info.setitem(1,'all_current','C')
dw_move_info.setitem(1,'move_from','S')
dw_move_info.setitem(1,'move_to','F')
dw_move_info.show()
dw_move_info.setfocus()
dw_move_info.setcolumn(1)

end event

event ue_view;Long   l_l_tvi

IF dw_select_view.visible = FALSE THEN
	dw_select_view.show()
	dw_select_view.setfocus()
ELSE
	dw_select_view.hide()
	IF dw_select_view.object.std[1]='x' THEN 
		i_l_enablearray[1]=1 
	ELSE	
		i_l_enablearray[1]=0
	END IF 	

	IF dw_select_view.object.quoted[1]='x' THEN 
		i_l_enablearray[2]=1 
	ELSE	
		i_l_enablearray[2]=0
	END IF 	

	IF dw_select_view.object.planned[1]='x' THEN 
		i_l_enablearray[3]=1 
	ELSE	
		i_l_enablearray[3]=0
	END IF 	
	
	IF dw_select_view.object.frozen[1]='x' THEN 
		i_l_enablearray[4]=1 
	ELSE	
		i_l_enablearray[4]=0
	END IF 	

	IF dw_select_view.object.qty[1]='x' THEN 
		i_l_enablearray[5]=1 
	ELSE	
		i_l_enablearray[5]=0
	END IF 	

	IF dw_select_view.object.desc[1]='x' THEN 
		i_l_enablearray[6]=1 
	ELSE	
		i_l_enablearray[6]=0
	END IF 	
		
	wf_01_explode()
	
END IF
end event

event ue_clicked_popup;IF arg_text='Open Details' THEN
	wf_02_display_details()
 	dw_cost_details.show()
   dw_different_types_costs.show()	 
	IF i_s_parttype = 'M' THEN
  	   dw_other_info.show()
	ELSE
		dw_other_info.hide()
   END IF
ELSEIF arg_text='Close Details' THEN
   dw_different_types_costs.hide()
  	dw_cost_details.hide()
  	dw_other_info.hide()
END IF
  
end event

event ue_global_move;Int    l_i_fromwhich
Long   l_l_current, &
       l_l_last
String l_s_part, &
       l_s_error_syntaxfromSQL, &
       l_s_error_create, &
       l_s_new_sql, &
		 l_s_new_syntax
l_i_fromwhich=Messagebox('System Message','Do you wish to Move cost from Standard (Yes)/Planned (No) into Frozen?',Exclamation!,YesNoCancel!)

end event

public subroutine wf_01_explode ();STRING	ls_part='', &
	ls_curnpart, &
	ls_desc=''
DEC	ld_quotedcost, &
	ld_stdcost, &
	ld_plannedcost, & 
	ld_frozencost, &
	ld_bomqty
long	ll_tvparent
long	ll_tvi

if isvalid(tv_vbom) then closeuserobject(tv_vbom)

openuserobject ( tv_vbom )
tv_vbom.width = 1746
tv_vbom.height = this.workspaceheight()
idrg_vertical=tv_vbom

dw_all_costs.reset()

for ll_tvi = 1 to il_totalrows
	
	ll_tvparent = dw_vbom.object.parentseq [ ll_tvi ]
	ls_part 	= dw_vbom.object.part [ ll_tvi ]
	ld_bomqty  = dw_vbom.object.bomqty [ ll_tvi ]
	
	if dw_different_types_costs.Retrieve(ls_part) > 0 then		
		ld_stdcost = dw_different_types_costs.object.cost_cum[1] 
		ld_quotedcost = dw_different_types_costs.object.qtd_cost_cum [1] 
		ld_plannedcost= dw_different_types_costs.object.planned_cost_cum [1] 
		ld_frozencost = dw_different_types_costs.object.frozen_cost_cum [1] 
		IF isnull(ld_stdcost)     THEN ld_stdcost    = 0.00	
		IF isnull(ld_quotedcost)  THEN ld_quotedcost = 0.00
		IF isnull(ld_plannedcost) THEN ld_plannedcost= 0.00
		IF isnull(ld_frozencost)  THEN ld_frozencost = 0.00
	end if 	
	SELECT name
	  INTO :ls_desc
	  FROM part
	 WHERE (part = :ls_part) ;
	// concatenate these different types of cost with the current part, so that it's displayed
	// with the current part in the treeview 
	ls_curnpart=ls_part + " ==> "
	IF i_l_enablearray[5]=1 THEN	
		ls_curnpart = ls_curnpart + '  Qty :  '+String(ld_bomqty) + '  '
	END IF 	
	IF i_l_enablearray[6]=1 THEN	
		ls_curnpart = ls_curnpart + '  Desc. :  '+Trim(ls_desc) + '  '
	END IF 	
	IF i_l_enablearray[1]=1 THEN
		ls_curnpart = ls_curnpart + '  Std  :  '+String(ld_stdcost) + '  ' 
	END IF 	
	IF i_l_enablearray[2]=1 THEN	
		ls_curnpart = ls_curnpart + '  Quoted  :  '+String(ld_quotedcost) + '  '
	END IF 		
	IF i_l_enablearray[3]=1 THEN	
		ls_curnpart = ls_curnpart + '  Planned  :  '+String(ld_plannedcost) + '  '
	END IF 		
	IF i_l_enablearray[4]=1 THEN	
		ls_curnpart = ls_curnpart + '  Frozen  :  '+String(ld_frozencost) + '  '
	END IF 	

	if ll_tvi = 1 then ll_tvparent = 0 
	tv_vbom.InsertItemLast ( ll_tvparent, ls_curnpart , 1)

next	

tv_vbom.expandall(1)

wf_refreshscreen()

//// build cost for the current part for display purposes 
wf_02_display_details()
wf_05_bld_cst()

end subroutine

public subroutine wf_02_display_details ();String l_s_part
wf_getpart()
l_s_part = dw_vbom.object.part [ i_l_rowno ]
i_s_partcode=l_s_part
dw_different_types_costs.retrieve(l_s_part,'')
dw_cost_details.retrieve(l_s_part,i_s_display_str)
wf_04_other_info(l_s_part)

end subroutine

public subroutine wf_03_build_costs (string arg_s_part);Int 	 l_i_nwrow, &
       l_i_fndrow
String l_s_part
l_s_part = arg_s_part
l_i_nwrow = dw_all_costs.insertrow(0)
dw_all_costs.setitem(l_i_nwrow,'part',l_s_part)
l_i_fndrow = dw_cost_details_adnl.retrieve(l_s_part,'')
IF l_i_fndrow > 0 THEN
   dw_all_costs.setitem(l_i_nwrow,'cost_cum',dw_cost_details_adnl.object.cost_cum [ l_i_fndrow ] ) 	
 	dw_all_costs.setitem(l_i_nwrow,'material_cum',dw_cost_details_adnl.object.material_cum [ l_i_fndrow ] ) 	
	dw_all_costs.setitem(l_i_nwrow,'labor_cum',dw_cost_details_adnl.object.labor_cum [ l_i_fndrow ] ) 	
	dw_all_costs.setitem(l_i_nwrow,'burden_cum',dw_cost_details_adnl.object.burden_cum [ l_i_fndrow ] ) 						 
	dw_all_costs.setitem(l_i_nwrow,'other_cum',dw_cost_details_adnl.object.other_cum [ l_i_fndrow ] )
	dw_all_costs.setitem(l_i_nwrow,'cost',dw_cost_details_adnl.object.cost [ l_i_fndrow ] ) 
	dw_all_costs.setitem(l_i_nwrow,'os_cost_cum',dw_cost_details_adnl.object.os_cost_cum [ l_i_fndrow ] ) 
END IF 

end subroutine

public subroutine wf_04_other_info (string arg_s_part);String l_s_part
Int    l_i_typefndrow

i_s_laborcode = ""
i_s_machinecode = ""
i_l_parts_per_hour = 0
i_d_stdrate  = 0
i_d_machinerate = 0 
i_l_setuptime   = 0 
l_s_part = arg_s_part
i_b_setuptime = true
l_i_typefndrow = dw_parttype.retrieve(l_s_part)
i_s_parttype  = 'M'
if l_i_typefndrow > 0 then
	i_s_parttype = dw_parttype.object.class [ l_i_typefndrow ]
end if 
IF i_s_parttype='M' THEN 
	SELECT labor_code, parts_per_hour, setup_time, machine
	  INTO :i_s_laborcode, :i_l_parts_per_hour, :i_l_setuptime, :i_s_machinecode
	  FROM part_machine
	 WHERE (part = :l_s_part and sequence=1);
	IF sqlca.sqlcode = 0 THEN
		SELECT standard_rate 
		  INTO :i_d_stdrate
		  FROM labor
		 WHERE (labor.id = :i_s_laborcode); 
		SELECT standard_rate
		  INTO :i_d_machinerate
		  FROM machine
		 WHERE (machine_no = :i_s_machinecode) ;
	END IF
	dw_other_info.setitem(1,'labor_code',i_s_laborcode)
	dw_other_info.setitem(1,'labor_rate',i_d_stdrate)
	dw_other_info.setitem(1,'machine_code',i_s_machinecode)
	dw_other_info.setitem(1,'machine_rate',i_d_machinerate)
	dw_other_info.setitem(1,'parts_per_hour',i_l_parts_per_hour)
	dw_other_info.setitem(1,'setup_time',i_l_setuptime)
	dw_other_info.setitem(1,'inc_setuptime',i_s_inc_st)
	IF i_l_setuptime=0 or isnull(i_l_setuptime) THEN
		i_b_setuptime = FALSE
	END IF 	
ELSE
	dw_other_info.Reset()
	dw_other_info.insertrow(0)
END IF 	
end subroutine

public subroutine wf_05_bld_cst ();Int l_i_rowretrieved, &
    l_i_rowno
String l_s_part
dw_all_costs.reset()
// Updating the cost datawindow
FOR l_i_rowno = 1 TO il_TotalRows
	 l_s_part = dw_vbom.object.part [ l_i_rowno ]
	 wf_03_build_costs(l_s_part)
NEXT

end subroutine

public subroutine wf_getpart ();Int	l_i_curnitem, &
		l_i_rowposition, &
		l_i_charpos, &
		l_i_len
		
TreeviewItem	l_t_tv

String ls_currentpart

l_i_curnitem = tv_vbom.FindItem(CurrentTreeItem!,0)

tv_vbom.GetItem(l_i_curnitem,l_t_tv)

l_i_len = LenA(l_t_tv.label)
l_i_charpos= PosA(l_t_tv.label,'=')
IF l_i_charpos=0 THEN l_i_charpos=l_i_len + 2

ls_currentpart = LeftA(l_t_tv.label, (l_i_charpos - 2))

l_i_rowposition = dw_vbom.Find("part='"+ls_currentpart+"'",1,dw_vbom.RowCount())

IF l_i_rowposition <= 0 THEN l_i_rowposition=1

i_l_rowno = l_i_rowposition



end subroutine

public function integer wf_refreshbars ();Integer li_cnt

//Force appropriate order
st_vertical.Setposition(ToTop!)

//Make sure the Width is not lost
st_vertical.width=ii_Barthickness

FOR li_cnt=1 TO 3
	 ist_horizontal[li_cnt].Setposition(ToTop!)
	 ist_horizontal[li_cnt].Height=ii_Barthickness
NEXT

Return 1

end function

public function integer wf_resizebars ();//Resize Bars according to Bars themselves, WindowBorder, and BarThickness
Integer	li_HX, li_HW, li_Cnt

st_vertical.Move(st_vertical.X, ii_WindowBorder)
st_vertical.Resize(ii_barthickness, 5 + This.WorkSpaceHeight() - (2 * ii_WindowBorder))

li_HX = st_vertical.X + ii_BarThickness
li_HW = This.WorkSpaceWidth() - li_HX - ii_WindowBorder
For li_Cnt = 1 To 3
	ist_Horizontal[li_Cnt].Move(li_HX, ist_Horizontal[li_Cnt].Y)
	ist_Horizontal[li_Cnt].Resize(li_HW, ii_BarThickness)
Next

wf_RefreshBars()

Return 1

end function

public function integer wf_resizepanels ();//Resize the panels according to the Lines, 
//BarThickness, and WindowBorder.

Integer	li_Cnt, li_X, li_Y, li_HHeight, li_HWidth
Long		ll_Width, ll_Height

ll_Width = this.WorkSpaceWidth()
ll_Height = this.WorkspaceHeight()

If ll_Width < idrg_Vertical.X + 150 Then
	ll_Width = idrg_Vertical.X + 150
End If

If ll_Height < idrg_Vertical.Y + 150 Then
	ll_Height = Idrg_Vertical.Y + 150
End If

// Left vertical object processing
idrg_Vertical.Move (ii_WindowBorder, ii_WindowBorder)
idrg_Vertical.Resize (st_vertical.X - idrg_Vertical.X, ll_Height - idrg_Vertical.Y - ii_WindowBorder)

// Horizontal object processing
For li_Cnt = 1 To 4
	li_X = st_vertical.X + ii_BarThickness
	If li_Cnt = 1 Then
		li_Y = ii_WindowBorder
	Else
		li_Y = ist_Horizontal[li_Cnt - 1].Y + ii_BarThickness
	End If
	
	idrg_Horizontal[li_Cnt].Move (li_X, li_Y)
	
	li_HWidth = ist_Horizontal[1].Width
	If li_Cnt = 1 Then
		li_HHeight = ist_Horizontal[1].Y - ii_WindowBorder
	ElseIf li_Cnt = 4 Then
		li_HHeight = ll_Height - (ist_Horizontal[3].Y + ii_BarThickness) - ii_WindowBorder
	Else		
		li_HHeight = ist_Horizontal[li_Cnt].Y - (ist_Horizontal[li_Cnt - 1].Y + ii_BarThickness)
	End If

	idrg_Horizontal[li_Cnt].Resize (li_HWidth, li_HHeight)
Next

Return 1

end function

public subroutine wf_move_utility (string arg_from, string arg_to, string arg_movetype);Long l_l_totalrows, &
     l_l_currentrow
Dec  l_d_cost, &
     l_d_material, &
	  l_d_labor, &
	  l_d_burden, &
	  l_d_other, &
     l_d_cost_cum, &
     l_d_material_cum, &
	  l_d_labor_cum, &
	  l_d_burden_cum, &
	  l_d_other_cum, &
	  l_d_os_cost, &
	  l_d_os_cost_cum, &
	  l_d_os_frozen_cost, &
	  l_d_os_frozen_cost_cum, &
	  l_d_os_planned_cost, &
	  l_d_os_planned_cost_cum, &
	  l_d_os_qtd_cost, &
	  l_d_os_qtd_cost_cum
	  
String ls_curntpart, &
       l_s_error_syntaxfromSQL, &
       l_s_error_create, &
       l_s_new_sql, &
		 l_s_new_syntax
Datastore dw_new
IF arg_movetype='C' THEN
   l_l_totalrows=dw_all_costs.Rowcount()	  
   IF l_l_totalrows > 0 THEN
      // move from standard cost to quoted cost with the current date			
      FOR l_l_currentrow = 1 to l_l_totalrows
 	 	   ls_curntpart=dw_all_costs.object.part[l_l_currentrow]
			Choose Case arg_from
				Case 'S'
			       SELECT cost,
					 			material,
					 			labor,
								burden,
								other,
								cost_cum,
								material_cum,
								labor_cum,
								burden_cum,
								other_cum, 
								os_cost, 
								os_cost_cum
	   		      INTO  :l_d_cost,
								:l_d_material,
								:l_d_labor,
								:l_d_burden,
								:l_d_other,
								:l_d_cost_cum,
								:l_d_material_cum,
								:l_d_labor_cum,
								:l_d_burden_cum,
								:l_d_other_cum,
								:l_d_os_cost,
								:l_d_os_cost_cum
	      		   FROM part_standard
	   		     WHERE part= :ls_curntpart ; 
				Case 'Q'					
			       SELECT 	qtd_cost,
					 			qtd_material,
								qtd_labor,
								qtd_burden,
								qtd_other,
								qtd_cost_cum,
								qtd_material_cum,
								qtd_labor_cum,
								qtd_burden_cum,
								qtd_other_cum,
								os_qtd_cost,
								os_qtd_cost_cum
	   		      INTO  :l_d_cost,
								:l_d_material,
								:l_d_labor,
								:l_d_burden,
								:l_d_other,
								:l_d_cost_cum,
								:l_d_material_cum,
								:l_d_labor_cum,
								:l_d_burden_cum,
								:l_d_other_cum,
								:l_d_os_qtd_cost,
								:l_d_os_qtd_cost_cum
	      		   FROM part_standard
	   		     WHERE part= :ls_curntpart ; 
				Case 'P'					
			       SELECT 	planned_cost,
					 			planned_material,
								planned_labor,
								planned_burden,
								planned_other,
								planned_cost_cum,
								planned_material_cum,
								planned_labor_cum,
								planned_burden_cum,
								planned_other_cum,
								os_planned_cost,
								os_planned_cost_cum							
	   		      INTO 	:l_d_cost,
								:l_d_material,
								:l_d_labor,
								:l_d_burden,
								:l_d_other,
								:l_d_cost_cum,
								:l_d_material_cum,
								:l_d_labor_cum,
								:l_d_burden_cum,
								:l_d_other_cum,
								:l_d_os_planned_cost,
								:l_d_os_planned_cost_cum
	      		   FROM part_standard
	   		     WHERE part= :ls_curntpart ; 
				Case 'F'					
			       SELECT  frozen_cost,
					 			frozen_material,
								frozen_labor,
								frozen_burden,
								frozen_other,
								frozen_cost_cum,
								frozen_material_cum,
								frozen_labor_cum,
								frozen_burden_cum,
								frozen_other_cum,
								os_frozen_cost,
								os_frozen_cost_cum
   			      INTO  :l_d_cost,
								:l_d_material,
								:l_d_labor,
								:l_d_burden,
								:l_d_other,
								:l_d_cost_cum,
								:l_d_material_cum,
								:l_d_labor_cum,
								:l_d_burden_cum,
								:l_d_other_cum,
								:l_d_os_frozen_cost,
								:l_d_os_frozen_cost_cum
      			   FROM part_standard
   			     WHERE part= :ls_curntpart ; 
			End choose					
			Choose Case arg_to
				Case 'S'
						UPDATE part_standard 
						   SET cost     = :l_d_cost,
							    material = :l_d_material,
								 labor    = :l_d_labor,
								 burden   = :l_d_burden,
								 other    = :l_d_other,
	                      cost_cum = :l_d_cost_cum,
							    material_cum = :l_d_material_cum,
								 labor_cum    = :l_d_labor_cum,
								 burden_cum   = :l_d_burden_cum,
								 other_cum    = :l_d_other_cum,
								 cost_changed_date  = getdate(),
								 os_cost		  =:l_d_os_cost,
								 os_cost_cum  =:l_d_os_cost_cum
						 WHERE part= :ls_curntpart ;		 
				Case 'Q'
						UPDATE part_standard 
						   SET qtd_cost     = :l_d_cost,
							    qtd_material = :l_d_material,
								 qtd_labor    = :l_d_labor,
								 qtd_burden   = :l_d_burden,
								 qtd_other    = :l_d_other,
	                      qtd_cost_cum = :l_d_cost_cum,
							    qtd_material_cum = :l_d_material_cum,
								 qtd_labor_cum    = :l_d_labor_cum,
								 qtd_burden_cum   = :l_d_burden_cum,
								 qtd_other_cum    = :l_d_other_cum,
								 qtd_changed_date  = getdate(),
								 os_qtd_cost		  =:l_d_os_qtd_cost,
								 os_qtd_cost_cum  =:l_d_os_qtd_cost_cum
						 WHERE part= :ls_curntpart ;		 
				Case 'P'					
				     // move from quoted cost to planned cost with the current date
						UPDATE part_standard 
						   SET planned_cost     = :l_d_cost,
							    planned_material = :l_d_material,
								 planned_labor    = :l_d_labor,
								 planned_burden   = :l_d_burden,
								 planned_other    = :l_d_other,
	                      planned_cost_cum = :l_d_cost_cum,
							    planned_material_cum = :l_d_material_cum,
								 planned_labor_cum    = :l_d_labor_cum,
								 planned_burden_cum   = :l_d_burden_cum,
								 planned_other_cum    = :l_d_other_cum,
								 planned_changed_date  = getdate(),
								 os_planned_cost		  =:l_d_os_planned_cost,
								 os_planned_cost_cum  =:l_d_os_planned_cost_cum							 
						 WHERE part= :ls_curntpart ;		 
				Case 'F'	
			  		   // move from quoted cost to frozen cost with the current date
						UPDATE part_standard 
						   SET frozen_cost     = :l_d_cost,
							    frozen_material = :l_d_material,
								 frozen_labor    = :l_d_labor,
								 frozen_burden   = :l_d_burden,
								 frozen_other    = :l_d_other,
	                      frozen_cost_cum = :l_d_cost_cum,
							    frozen_material_cum = :l_d_material_cum,
								 frozen_labor_cum    = :l_d_labor_cum,
								 frozen_burden_cum   = :l_d_burden_cum,
								 frozen_other_cum    = :l_d_other_cum,
								 frozen_changed_date  = getdate(),
								 os_frozen_cost		=:l_d_os_frozen_cost,
								 os_frozen_cost_cum  =:l_d_os_frozen_cost_cum							 
						 WHERE part= :ls_curntpart ;		 					  
			End choose					
			IF sqlca.sqlcode < 0 THEN 
				ROLLBACK ;  
	 		ELSE
				COMMIT ;
			END IF 			
	   NEXT 	

	END IF 
ELSEIF arg_movetype='A' THEN
	Choose Case arg_from
		Case 'S'
	      l_s_new_sql = 'SELECT part, cost, material, labor, burden, other ,' &
	   	  + 'cost_cum, material_cum, labor_cum, burden_cum ,' &
			  + 'other_cum, os_cost, os_cost_cum' &
	  		  + 'FROM part_standard'		
		Case 'Q'
	      l_s_new_sql = 'SELECT part, qtd_cost, qtd_material, qtd_labor, qtd_burden, qtd_other ,' &
	   	  + 'qtd_cost_cum, qtd_material_cum, qtd_labor_cum, qtd_burden_cum ,' &
			  + 'qtd_other_cum, os_qtd_cost, os_qtd_cost_cum' &
	  		  + 'FROM part_standard'		
		Case 'P'
	      l_s_new_sql = 'SELECT part, planned_cost, planned_material, planned_labor, planned_burden, planned_other ,' &
	   	  + 'planned_cost_cum, planned_material_cum, planned_labor_cum, planned_burden_cum ,' &
			  + 'planned_other_cum, os_planned_cost, os_planned_cost_cum' &
	  		  + 'FROM part_standard'		
		Case 'F'	
	      l_s_new_sql = 'SELECT part, frozen_cost, frozen_material, frozen_labor, frozen_burden, frozen_other ,' &
	   	  + 'frozen_cost_cum, frozen_material_cum, frozen_labor_cum, frozen_burden_cum ,' &
			  + 'frozen_other_cum, os_frozen_cost, os_frozen_cost_cum' &
	  		  + 'FROM part_standard'		
	End choose
	l_s_new_syntax = SQLCA.SyntaxFromSQL(l_s_new_sql,  &
		'Style(Type=Form)', l_s_error_syntaxfromSQL)
	IF LenA(l_s_error_syntaxfromSQL) > 0 THEN
		// Display errors
		Messagebox(monsys.msg_title,l_s_error_syntaxfromSQL)				
		RETURN
	ELSE
		// Generate new DataWindow
		dw_new = CREATE datastore
		dw_new.Create(l_s_new_syntax, l_s_error_create)
		IF LenA(l_s_error_create) > 0 THEN
			Messagebox(monsys.msg_title,l_s_error_create)
			Destroy dw_new
			RETURN 
		END IF
		dw_new.SetTransObject(SQLCA)
		dw_new.Retrieve()	
		l_l_totalrows=dw_new.rowcount()
		l_l_currentrow=1
		cb_display.show()
		ls_curntpart = "" 
		Do while (l_l_currentrow <= l_l_totalrows)
		   ls_curntpart=dw_new.object.#1[l_l_currentrow]
			Choose Case arg_from
				Case 'S'
			      l_d_cost=dw_new.object.#2[l_l_currentrow]
					l_d_material=dw_new.object.#3[l_l_currentrow]
					l_d_labor=dw_new.object.#4[l_l_currentrow]
					l_d_burden=dw_new.object.#5[l_l_currentrow]
					l_d_other=dw_new.object.#6[l_l_currentrow]
					l_d_cost_cum=dw_new.object.#7[l_l_currentrow]
					l_d_material_cum=dw_new.object.#8[l_l_currentrow]
					l_d_labor_cum=dw_new.object.#9[l_l_currentrow]
					l_d_burden_cum=dw_new.object.#10[l_l_currentrow]
					l_d_other_cum=dw_new.object.#11[l_l_currentrow]
					l_d_os_cost =dw_new.object.#12[l_l_currentrow]
					l_d_os_cost_cum =dw_new.object.#13[l_l_currentrow]
				Case 'Q'
				Case 'P'
			      l_d_cost=dw_new.object.#2[l_l_currentrow]
					l_d_material=dw_new.object.#3[l_l_currentrow]
					l_d_labor=dw_new.object.#4[l_l_currentrow]
					l_d_burden=dw_new.object.#5[l_l_currentrow]
					l_d_other=dw_new.object.#6[l_l_currentrow]
					l_d_cost_cum=dw_new.object.#7[l_l_currentrow]
					l_d_material_cum=dw_new.object.#8[l_l_currentrow]
					l_d_labor_cum=dw_new.object.#9[l_l_currentrow]
					l_d_burden_cum=dw_new.object.#10[l_l_currentrow]
					l_d_other_cum=dw_new.object.#11[l_l_currentrow]
					l_d_os_planned_cost =dw_new.object.#12[l_l_currentrow]
					l_d_os_planned_cost_cum =dw_new.object.#13[l_l_currentrow]
				Case 'F'	
			End choose				
  		   cb_display.text=ls_curntpart
			Choose Case arg_to
				Case 'S'
						UPDATE part_standard 
						   SET cost     = :l_d_cost,
							    material = :l_d_material,
								 labor    = :l_d_labor,
								 burden   = :l_d_burden,
								 other    = :l_d_other,
	                      cost_cum = :l_d_cost_cum,
							    material_cum = :l_d_material_cum,
								 labor_cum    = :l_d_labor_cum,
								 burden_cum   = :l_d_burden_cum,
								 other_cum    = :l_d_other_cum,
								 cost_changed_date  = getdate(),
								 os_cost		= :l_d_os_cost,
								 os_cost_cum= :l_d_os_cost_cum
						 WHERE part= :ls_curntpart ;		 
				Case 'Q'
						UPDATE part_standard 
						   SET qtd_cost     = :l_d_cost,
							    qtd_material = :l_d_material,
								 qtd_labor    = :l_d_labor,
								 qtd_burden   = :l_d_burden,
								 qtd_other    = :l_d_other,
	                      qtd_cost_cum = :l_d_cost_cum,
							    qtd_material_cum = :l_d_material_cum,
								 qtd_labor_cum    = :l_d_labor_cum,
								 qtd_burden_cum   = :l_d_burden_cum,
								 qtd_other_cum    = :l_d_other_cum,
								 qtd_changed_date  = getdate(),
								 os_qtd_cost		= :l_d_os_qtd_cost,
								 os_qtd_cost_cum= :l_d_os_qtd_cost_cum
						 WHERE part= :ls_curntpart ;		 
				Case 'P'					
				     // move from quoted cost to planned cost with the current date
						UPDATE part_standard 
						   SET planned_cost     = :l_d_cost,
							    planned_material = :l_d_material,
								 planned_labor    = :l_d_labor,
								 planned_burden   = :l_d_burden,
								 planned_other    = :l_d_other,
	                      planned_cost_cum = :l_d_cost_cum,
							    planned_material_cum = :l_d_material_cum,
								 planned_labor_cum    = :l_d_labor_cum,
								 planned_burden_cum   = :l_d_burden_cum,
								 planned_other_cum    = :l_d_other_cum,
								 planned_changed_date  = getdate(),
								 os_planned_cost		= :l_d_os_planned_cost,
								 os_planned_cost_cum= :l_d_os_planned_cost_cum
						 WHERE part= :ls_curntpart ;		 
				Case 'F'	
			  		   // move from quoted cost to frozen cost with the current date
						UPDATE part_standard 
						   SET frozen_cost     = :l_d_cost,
							    frozen_material = :l_d_material,
								 frozen_labor    = :l_d_labor,
								 frozen_burden   = :l_d_burden,
								 frozen_other    = :l_d_other,
	                      frozen_cost_cum = :l_d_cost_cum,
							    frozen_material_cum = :l_d_material_cum,
								 frozen_labor_cum    = :l_d_labor_cum,
								 frozen_burden_cum   = :l_d_burden_cum,
								 frozen_other_cum    = :l_d_other_cum,
								 frozen_changed_date  = getdate(),
								 os_frozen_cost		= :l_d_os_frozen_cost,
								 os_frozen_cost_cum= :l_d_os_frozen_cost_cum
						 WHERE part= :ls_curntpart ;		 					  
			End choose					
		   l_l_currentrow ++ 
		Loop
		COMMIT ;
		cb_display.hide()
		Destroy dw_new
	END IF	
END IF 	
wf_02_display_details()
Return
end subroutine

public subroutine wf_refreshscreen ();int li_cnt

il_oldheight=w_cost.WorkspaceHeight()
idrg_vertical=tv_vbom

FOR li_cnt=1 TO 4
	 idrg_horizontal[li_cnt]=idw_data[li_cnt]
NEXT 
ist_horizontal[1]=st_horizontal1
ist_horizontal[2]=st_horizontal2
ist_horizontal[3]=st_horizontal3
il_hiddencolor=w_cost.BackColor
st_vertical.BackColor=il_hiddencolor
FOR li_cnt=1 TO 3
	 ist_horizontal[li_cnt].BackColor=il_hiddencolor
NEXT	 
wf_resizeBars()
wf_resizePanels() 
end subroutine

on w_cost.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_cost_menu" then this.MenuID = create m_cost_menu
this.st_horizontal3=create st_horizontal3
this.st_horizontal2=create st_horizontal2
this.st_horizontal1=create st_horizontal1
this.st_vertical=create st_vertical
this.dw_bom_temp=create dw_bom_temp
this.dw_partlist=create dw_partlist
this.dw_bom_parts=create dw_bom_parts
this.dw_parttype=create dw_parttype
this.dw_cost_details_adnl=create dw_cost_details_adnl
this.dw_cost_details=create dw_cost_details
this.dw_other_info=create dw_other_info
this.dw_different_types_costs=create dw_different_types_costs
this.mle_1=create mle_1
this.dw_all_costs=create dw_all_costs
this.dw_select_view=create dw_select_view
this.dw_cost_graph=create dw_cost_graph
this.cb_display=create cb_display
this.dw_vbom=create dw_vbom
this.dw_vbomprint=create dw_vbomprint
this.dw_move_info=create dw_move_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_horizontal3
this.Control[iCurrent+2]=this.st_horizontal2
this.Control[iCurrent+3]=this.st_horizontal1
this.Control[iCurrent+4]=this.st_vertical
this.Control[iCurrent+5]=this.dw_bom_temp
this.Control[iCurrent+6]=this.dw_partlist
this.Control[iCurrent+7]=this.dw_bom_parts
this.Control[iCurrent+8]=this.dw_parttype
this.Control[iCurrent+9]=this.dw_cost_details_adnl
this.Control[iCurrent+10]=this.dw_cost_details
this.Control[iCurrent+11]=this.dw_other_info
this.Control[iCurrent+12]=this.dw_different_types_costs
this.Control[iCurrent+13]=this.mle_1
this.Control[iCurrent+14]=this.dw_all_costs
this.Control[iCurrent+15]=this.dw_select_view
this.Control[iCurrent+16]=this.dw_cost_graph
this.Control[iCurrent+17]=this.cb_display
this.Control[iCurrent+18]=this.dw_vbom
this.Control[iCurrent+19]=this.dw_vbomprint
this.Control[iCurrent+20]=this.dw_move_info
end on

on w_cost.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_horizontal3)
destroy(this.st_horizontal2)
destroy(this.st_horizontal1)
destroy(this.st_vertical)
destroy(this.dw_bom_temp)
destroy(this.dw_partlist)
destroy(this.dw_bom_parts)
destroy(this.dw_parttype)
destroy(this.dw_cost_details_adnl)
destroy(this.dw_cost_details)
destroy(this.dw_other_info)
destroy(this.dw_different_types_costs)
destroy(this.mle_1)
destroy(this.dw_all_costs)
destroy(this.dw_select_view)
destroy(this.dw_cost_graph)
destroy(this.cb_display)
destroy(this.dw_vbom)
destroy(this.dw_vbomprint)
destroy(this.dw_move_info)
end on

event open;call super::open;String l_s_part
Long   l_l_tvi
Int    li_cnt       
l_s_part = Message.Stringparm
i_s_partcode=l_s_part

dw_vbom.Retrieve ( i_s_partcode)

il_totalrows = dw_vbom.Rowcount()

dw_select_view.insertrow(0)
dw_select_view.setitem(1,'std','x')
dw_select_view.setitem(1,'quoted',' ') 
dw_select_view.setitem(1,'planned',' ') 
dw_select_view.setitem(1,'frozen',' ')
dw_select_view.setitem(1,'qty',' ') 
dw_select_view.setitem(1,'desc',' ')
i_l_enablearray[]={1,0,0,0,0,0}

idw_data[1]=dw_different_types_costs
idw_data[2]=dw_cost_details
idw_data[3]=dw_other_info
idw_data[4]=dw_all_costs

// Inserting a blank row into other info datawindow
dw_other_info.insertrow(0)

IF l_s_part = '' or ISNULL(l_s_part) THEN 
	 i_b_withparm = false 
	 Messagebox("System Message","Invalid part")
ELSE
    i_b_withparm = true
	 i_s_part = l_s_part
	 wf_01_explode()
END IF 
 
// getting the details about the setuptime from parameters table
i_s_inc_st = "Y"
SELECT include_setuptime 
  INTO :i_s_inc_st
  FROM parameters ;
tv_vbom.setfocus()

end event

event resize;call super::resize;Integer		li_Delta, li_Cnt
// Do not run the first time the window is opened.

If IsValid(idrg_Vertical) Then
	// Move the horizontal bars porportionally
	li_Delta = newheight - il_OldHeight
	il_OldHeight = newheight

	For li_Cnt = 1 To 3
		ist_Horizontal[li_Cnt].Y = ist_Horizontal[li_Cnt].Y + (li_Cnt * (li_Delta / 4))
	Next
	
	//Resize Bars
	wf_ResizeBars()

	//Resize the panels
	wf_ResizePanels()
End If

end event

type st_horizontal3 from statictext within w_cost
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 1787
integer y = 1396
integer width = 741
integer height = 28
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 255
long backcolor = 33554432
long bordercolor = 276856960
boolean focusrectangle = false
end type

event mousemove;IF KeyDown(KeyLeftButton!) THEN
	This.Y=Parent.PointerY()
END IF

end event

event mouseup;IF NOT ib_debug THEN This.Backcolor=il_hiddencolor

wf_resizebars()

wf_resizepanels()

end event

event mousedown;IF NOT ib_debug THEN This.Backcolor=0
end event

type st_horizontal2 from statictext within w_cost
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 1787
integer y = 1076
integer width = 741
integer height = 28
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 255
long backcolor = 33554432
long bordercolor = 276856960
boolean focusrectangle = false
end type

event mousemove;IF KeyDown(KeyLeftButton!) THEN
	This.Y=Parent.PointerY()
END IF

end event

event mouseup;IF NOT ib_debug THEN This.Backcolor=il_hiddencolor

wf_resizebars()

wf_resizepanels()

end event

event mousedown;IF NOT ib_debug THEN This.Backcolor=0
end event

type st_horizontal1 from statictext within w_cost
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 1787
integer y = 552
integer width = 741
integer height = 28
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeNS!"
long textcolor = 255
long backcolor = 0
long bordercolor = 276856960
boolean focusrectangle = false
end type

event mousemove;IF KeyDown(KeyLeftButton!) THEN
	This.Y=Parent.PointerY()
END IF

end event

event mouseup;IF NOT ib_debug THEN THIS.Backcolor=il_hiddencolor

wf_resizebars()

wf_resizepanels()

end event

event mousedown;IF NOT ib_debug THEN This.Backcolor=0
end event

type st_vertical from statictext within w_cost
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
integer x = 1760
integer y = 4
integer width = 27
integer height = 532
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "SizeWE!"
long textcolor = 255
long backcolor = 0
long bordercolor = 276856960
boolean focusrectangle = false
end type

event mousemove;IF KeyDown(KeyLeftButton!) THEN
	This.X=Parent.PointerX()
END IF

end event

event mouseup;IF NOT ib_debug THEN This.Backcolor=il_hiddencolor

wf_resizebars()

wf_resizepanels()

end event

event mousedown;IF NOT ib_debug THEN This.Backcolor=0
end event

type dw_bom_temp from datawindow within w_cost
boolean visible = false
integer x = 2021
integer y = 1692
integer width = 466
integer height = 348
integer taborder = 130
string dataobject = "d_bom_temp"
boolean livescroll = true
end type

type dw_partlist from datawindow within w_cost
boolean visible = false
integer x = 1518
integer y = 1676
integer width = 494
integer height = 364
integer taborder = 120
string dataobject = "d_partlist"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)

end event

type dw_bom_parts from datawindow within w_cost
boolean visible = false
integer x = 507
integer y = 1672
integer width = 494
integer height = 364
integer taborder = 70
string dataobject = "d_bom_part"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_parttype from datawindow within w_cost
boolean visible = false
integer x = 5
integer y = 1672
integer width = 494
integer height = 364
integer taborder = 80
string dataobject = "d_parttype"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_cost_details_adnl from datawindow within w_cost
boolean visible = false
integer x = 1015
integer y = 1676
integer width = 494
integer height = 364
integer taborder = 160
string dataobject = "d_cost_details"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)

end event

type dw_cost_details from datawindow within w_cost
integer x = 1787
integer y = 580
integer width = 1024
integer height = 496
integer taborder = 20
string dataobject = "d_cost_details"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Monitor.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

type dw_other_info from datawindow within w_cost
integer x = 1787
integer y = 1104
integer width = 1024
integer height = 288
integer taborder = 90
string dataobject = "d_other_info_1"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Monitor.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)
end event

event itemchanged;IF dw_other_info.getcolumnname() = 'labor_code' THEN
   dw_other_info.accepttext()
	i_s_laborcode = dw_other_info.getitemstring(1,'labor_code') 
	SELECT standard_rate 
	  INTO :i_d_stdrate
	  FROM labor
	 WHERE (id = :i_s_laborcode) ;
	dw_other_info.setitem(1,'labor_rate',i_d_stdrate) 
ELSEIF dw_other_info.getcolumnname() = 'inc_setuptime' THEN
	IF i_b_setuptime = FALSE THEN
		BEEP(5)
		Messagebox("System Message","Sorry, access denied as setuptime is 0")
		i_s_inc_st = 'N'
		dw_other_info.setitem(1,'inc_setuptime',i_s_inc_st) 		
	END IF 	
END IF 

end event

type dw_different_types_costs from datawindow within w_cost
integer x = 1787
integer y = 4
integer width = 1024
integer height = 548
integer taborder = 50
string dataobject = "d_different_types_costs_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.settransobject(sqlca)
end event

event doubleclicked;String l_s_columnname, &
       l_s_display_str  
l_s_columnname=this.getcolumnname()
i_s_columnname=this.getcolumnname()
l_s_display_str=''
CHOOSE CASE l_s_columnname
	CASE 'cost_cum'
		dw_cost_details.dataobject='d_cost_details'		
		i_s_display_str='Std Cost for '
		i_s_bucket='S'
	CASE 'qtd_cost_cum'
		dw_cost_details.dataobject='d_qtd_cost_details'		
		i_s_display_str='Quoted Cost for '
		i_s_bucket='Q'		
	CASE 'planned_cost_cum'
		dw_cost_details.dataobject='d_planned_cost_details'		
		i_s_display_str='Planned Cost for '		
		i_s_bucket='P'		
	CASE 'frozen_cost_cum'		
		dw_cost_details.dataobject='d_frozen_cost_details'		
		i_s_display_str='Frozen Cost for '		
		i_s_bucket='F'		
END CHOOSE
dw_cost_details.settransobject(sqlca)
dw_cost_details.retrieve(i_s_partcode,i_s_display_str)
mle_1.hide()
end event

event rbuttondown;IF mle_1.visible=FALSE THEN 
	mle_1.show()
   mle_1.text="To move the current/quoted cost into the other type of costs, double click on the 1st line of standard / planned / frozen cost & click on move button" 
ELSE
	mle_1.hide()
END IF	
end event

event clicked;mle_1.hide()
end event

type mle_1 from multilineedit within w_cost
boolean visible = false
integer x = 2011
integer y = 288
integer width = 850
integer height = 272
integer taborder = 100
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_all_costs from datawindow within w_cost
integer x = 1787
integer y = 1424
integer width = 1024
integer height = 548
integer taborder = 10
string dataobject = "d_all_costs"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "Monitor.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;settransobject(sqlca)

end event

type dw_select_view from datawindow within w_cost
boolean visible = false
integer x = 1065
integer y = 452
integer width = 517
integer height = 748
integer taborder = 140
boolean titlebar = true
string title = "Displays with TV"
string dataobject = "d_select_view"
string icon = "Monitor.ico"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event buttonclicked;w_cost.Triggerevent('ue_view')
end event

type dw_cost_graph from datawindow within w_cost
boolean visible = false
integer x = 18
integer width = 1746
integer height = 1324
integer taborder = 150
boolean titlebar = true
string dataobject = "d_cost_graph"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "Monitor.ico"
boolean livescroll = true
end type

event constructor;settransobject(sqlca)


end event

event buttonclicked;This.hide()
end event

type cb_display from commandbutton within w_cost
boolean visible = false
integer x = 978
integer y = 524
integer width = 978
integer height = 88
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
end type

type dw_vbom from datawindow within w_cost
boolean visible = false
integer x = 2021
integer y = 2056
integer width = 462
integer height = 324
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_vbomparts"
boolean vscrollbar = true
end type

event constructor;settransobject(sqlca)
end event

type dw_vbomprint from datawindow within w_cost
boolean visible = false
integer x = 1632
integer y = 2064
integer width = 370
integer height = 288
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_vbomprintparts"
end type

type dw_move_info from datawindow within w_cost
event ue_exec ( )
boolean visible = false
integer x = 795
integer y = 476
integer width = 1303
integer height = 472
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Move cost from one cost bucket to another"
string dataobject = "d_move_info"
boolean controlmenu = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_exec;String l_s_all_curn, & 
       l_s_from, &
		 l_s_to
l_s_all_curn = dw_move_info.Getitemstring(1,'all_current')
l_s_from = dw_move_info.Getitemstring(1,'move_from')
l_s_to   = dw_move_info.Getitemstring(1,'move_to')
dw_move_info.Hide() 
IF l_s_all_curn<>'Z' THEN 
	// call a function with from,to & type of move as the argument & complete the process
	IF l_s_from=l_s_to Then
		Messagebox("Error","Cannot move cost to itself")
	Else	
		wf_move_utility(l_s_from,l_s_to,l_s_all_curn)
	End if 			
End if 	

end event

event constructor;dw_move_info.settransobject(sqlca)
end event

event losefocus;//dw_move_info.Triggerevent('ue_exec')
dw_move_info.Hide() 
end event

event buttonclicked;dw_move_info.Triggerevent('ue_exec')
end event

