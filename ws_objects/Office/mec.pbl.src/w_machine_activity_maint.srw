$PBExportHeader$w_machine_activity_maint.srw
forward
global type w_machine_activity_maint from Window
end type
type cb_2 from commandbutton within w_machine_activity_maint
end type
type cb_1 from commandbutton within w_machine_activity_maint
end type
type dw_1 from datawindow within w_machine_activity_maint
end type
end forward

global type w_machine_activity_maint from Window
int X=832
int Y=360
int Width=2075
int Height=1184
boolean TitleBar=true
string Title="Activity / Machine Maintenance"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_machine_activity_maint w_machine_activity_maint

type variables
string  i_s_part

boolean i_b_itemchanged

datastore ids_part_machine


end variables

event open;INT						l_i_sequence
st_generic_structure	l_str_parm
STRING					ls_route_process_window

l_str_parm = Message.PowerObjectParm

i_s_part = l_str_parm.value1

IF l_str_parm.value10 = 'Add' THEN
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "part_machine_part", l_str_parm.value1 )
	dw_1.SetItem ( 1, "part_machine_machine", l_str_parm.value2 )
	dw_1.SetItem ( 1, "part_machine_activity", l_str_parm.value3 )

	SELECT 	max( sequence )
	INTO		:l_i_sequence
	FROM		part_machine
	WHERE		part = :l_str_parm.value1 ;
	
// deleted this from the where clause as we need the next sequence to show up.
//	AND		activity = :l_str_parm.value3 ; 
				
	IF ISNULL( l_i_sequence ) OR l_i_Sequence <= 0 THEN 
		l_i_sequence = 1
	ELSE
		l_i_sequence++
	END IF
	
	dw_1.SetItem ( 1, "part_machine_sequence", l_i_sequence )
	
	// determin if selected activity code is for outside process and set initial value.
	SELECT	flow_route_window
	INTO		:ls_route_process_window
	FROM		activity_codes
	WHERE		code = :l_str_parm.value3 ;
	
	dw_1.setitem(1, "activity_codes_flow_route_window", ls_route_process_window)
	dw_1.triggerevent("ue_outside_process")
ELSE
	dw_1.Retrieve ( l_str_parm.value1, l_str_parm.value2, l_str_parm.value3 )
	dw_1.settaborder ( "part_machine_sequence",  70 )
	dw_1.modify ( "part_machine_sequence.background.color='"+ string( f_get_color_value ('window')) + "'" )
	dw_1.modify("part_machine_sequence.update = No")
	// create datastore
	ids_part_machine = create datastore
   ids_part_machine.dataobject = 'd_part_machine'
	ids_part_machine.settransobject(sqlca)
END IF


end event

on w_machine_activity_maint.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_machine_activity_maint.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_machine_activity_maint
int X=1719
int Y=960
int Width=293
int Height=112
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_machine_activity_maint
int X=1381
int Y=960
int Width=293
int Height=112
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;decimal ll_day, &
		  ll_partsperhour

dw_1.accepttext()

dw_1.setredraw(false)

if dw_1.getitemstring(1, 'activity_codes_flow_route_window') = 'w_create_flow_route_outside_version2' then
   ll_day =  dw_1.getitemdecimal(1, 'part_machine_setup_time')
	dw_1.setitem( 1,'part_machine_setup_time',ll_day * 24 )
end if


ll_partsperhour = dw_1.getitemnumber(1,'part_machine_parts_per_hour')

if  isnull(ll_partsperhour) then
	MessageBox(monsys.msg_title, 'Update failed, parts per hour cannot be null', Information!)
	return
end if

IF dw_1.Update ( ) = 1 THEN
	COMMIT ;
		if isvalid(ids_part_machine) then 
    	if ids_part_machine.update() > 0 then 		
 			commit ;
		else
			messagebox ( 'check', sqlca.sqlerrtext )
			rollback ;
		end if 
		destroy ids_part_machine 		
	end if
	dw_1.setredraw(true)
	CloseWithReturn ( Parent, 1 )
ELSE
	Rollback;
	dw_1.setredraw(true)
	MessageBox ( Parent.Title, "Unable to save machine!", StopSign! )
END IF




end event

type dw_1 from datawindow within w_machine_activity_maint
event ue_outside_process pbm_custom40
event ue_stupid_powerbuilder_bug_event ( )
event ue_paint pbm_paint
int X=27
int Y=32
int Width=2025
int Height=776
int TabOrder=10
string DataObject="d_activity_router_alt"
boolean Border=false
boolean LiveScroll=true
end type

event ue_outside_process;//string ls_null
//
//setnull(ls_null)
//
//// if outside process activity the change machine code to vendor code
//// and repopulate drop down.
//IF  getitemstring(1, "activity_codes_flow_route_window") = "w_create_flow_route_outside_version2" THEN
//	Object.part_machine_machine.Edit.datacolumn = "vendor_no"
//	Object.part_machine_machine.DDDW.displaycolumn = "name"
//	getchild('part_machine_machine', ldw_child1)
//	ldw_child1.settransobject(sqlca)
//	ldw_child1.retrieve()
//	setitem(getrow(),'part_machine_machine',ls_null)
//ELSE
//	Object.part_machine_machine.DDDW.Name = "d_machine_list"
//	Object.part_machine_machine.DDDW.datacolumn = "machine_no"
//	Object.part_machine_machine.DDDW.displaycolumn = "name"
//	getchild('part_machine_machine', ldw_child1)
//	ldw_child1.settransobject(sqlca)
//	ldw_child1.retrieve()
//END IF
//
end event

event ue_stupid_powerbuilder_bug_event;IF object.rate_types[1] = 1 THEN
	object.rate_types[1] = 0
	object.rate_types[1] = 1
END IF

end event

event itemchanged;datawindowchild ldw_child1

string 	ls_route_process_window_old,&
			ls_unit

long 	ll_row, &
		ll_currentrow, &
		ll_count, &
		ll_rowseq, &
		ll_prevrow,&
		ll_unit1

int 	li_row, &
		li_prevseq, &
		li_sequence
 
string ls_machine

CHOOSE CASE dwo.Name
	CASE "part_machine_activity"
		// determin if selected activity code is for outside process and set initial value.
		getchild('part_machine_activity', ldw_child1)
		ls_route_process_window_old = ldw_child1.getitemstring(ldw_child1.getrow(), "flow_route_window")
		setitem(row, "activity_codes_flow_route_window", ls_route_process_window_old)
		triggerevent("ue_outside_process")
	CASE "part_machine_parts_per_cycle"
		// if parts_per_cycle changes then update parts_per_hour.
		SetItem(row, "part_machine_parts_per_hour", &
			 f_parts_per_hour(GetItemString(row, "part_machine_cycle_unit"), &
			 						Dec(data), &
									GetItemNumber(row, "part_machine_cycle_time")))
	CASE "part_machine_cycle_unit"
		// if cycle_unit changes then update parts_per_hour.
		SetItem(row, "part_machine_parts_per_hour", &
			 f_parts_per_hour(data, &
			 						GetItemNumber(row, "part_machine_parts_per_cycle"), &
									GetItemNumber(row, "part_machine_cycle_time")))
	CASE "part_machine_cycle_time"
		// if cycle_time changes then update parts_per_hour.
		SetItem(row, "part_machine_parts_per_hour", &
			 f_parts_per_hour(GetItemString(row, "part_machine_cycle_unit"), &
			 						GetItemNumber(row, "part_machine_parts_per_cycle"), &
									Dec(data)))

	CASE "part_machine_sequence" 
		
	   if ids_part_machine.retrieve(i_s_part)	> 0 then	
	  
		  ls_machine = dw_1.getitemstring(1 ,"part_machine_machine")
		  li_sequence = long(data)		  
		  ll_currentrow = ids_part_machine.find("part= '"+i_s_part+"'" + " and machine = '" + ls_machine + "'", 1, 9999)

		  if ll_currentrow > 0 then
		  	li_prevseq = ids_part_machine.getitemnumber(ll_currentrow, "sequence")
		   ids_part_machine.setitem(ll_currentrow, "sequence", li_sequence)
			
			  if li_sequence = 1 then
			
					for ll_count = 1 to ll_currentrow -1 
						 li_sequence ++
						 ids_part_machine.setitem(ll_count, "sequence", li_sequence)
					next
	
           elseif li_sequence > li_prevseq then
				if ll_currentrow = ids_part_machine.rowcount() then	
				ids_part_machine.setitem(ll_currentrow, "sequence", ids_part_machine.rowcount())
			
			  elseif li_sequence >= ids_part_machine.rowcount() then
            	for ll_count = ll_currentrow +1 to ids_part_machine.rowcount()
						 	ids_part_machine.setitem(ll_count, "sequence", li_prevseq)
						   li_prevseq ++
				   next			     
        		    ids_part_machine.setitem(ll_currentrow, "sequence", ids_part_machine.rowcount())	
			  else
				   for ll_count = ll_currentrow + 1 to li_sequence
					ids_part_machine.setitem(ll_count, "sequence", li_prevseq)
					li_prevseq++
				   next
					end if
		     else
					for ll_count = li_sequence to ll_currentrow - 1 
						li_sequence++
						ids_part_machine.setitem(ll_count, "sequence", li_sequence)
					next
				end if
			end if
		end if
	case 'rate_types'  
		
	 if long(data) = 1 then	
	      
		ll_unit1 = long(data)
		setnull(ll_unit1)

		setitem(row,'part_machine_parts_per_cycle', ll_unit1)
		setitem(row,'part_machine_cycle_time',ll_unit1)
	 end if
	 
		ls_unit = data
		setnull(ls_unit)
		
		setitem(row,'part_machine_cycle_unit',ls_unit)
	 

END CHOOSE




end event

event constructor;SetTransObject ( sqlca )
end event

event retrieveend;Post Event ue_stupid_powerbuilder_bug_event ( )
//Post Event ue_paint ( handle ( This ) )
end event

event retrieverow;long ll_hour

if dw_1.getitemstring(1, 'activity_codes_flow_route_window') = 'w_create_flow_route_outside_version2' then
   ll_hour =  dw_1.getitemdecimal(1, 'part_machine_setup_time')
	dw_1.setitem( 1,'part_machine_setup_time',ll_hour / 24 )
end if


end event

