$PBExportHeader$w_audit_test.srw
forward
global type w_audit_test from Window
end type
type dw_options from datawindow within w_audit_test
end type
type em_1 from editmask within w_audit_test
end type
type dw_at_list from datawindow within w_audit_test
end type
type dw_detail_line_info from datawindow within w_audit_test
end type
type tv_audit_trail from treeview within w_audit_test
end type
end forward

global type w_audit_test from Window
int X=5
int Y=4
int Width=2926
int Height=1436
boolean TitleBar=true
string Title="Audit_trail"
long BackColor=12632256
event ue_refresh ( )
event ue_options ( )
event ue_details ( )
event ue_exit ( )
event ue_clicked_popup ( string a_s_item )
dw_options dw_options
em_1 em_1
dw_at_list dw_at_list
dw_detail_line_info dw_detail_line_info
tv_audit_trail tv_audit_trail
end type
global w_audit_test w_audit_test

type variables
Any          i_a_currentitem, &
                i_a_general_list[], &
                i_a_general_dt[]

Long        il_currenttreeview

Integer     i_l_level=1

Datetime  i_dt_lower, &
                i_dt_higher, &
                i_dt_date_stamp
                
String       i_s_fromloc, &
                i_s_toloc, &
                i_s_defaulttimetype='Seconds', &
                i_s_workorder, &
                i_s_type
end variables

forward prototypes
public function integer wf_01_type (string arg_s_type)
public subroutine wf_02_changed ()
public function boolean wf_04_check (string arg_type)
public subroutine wf_03_buildtree (any arg_currentitem)
public subroutine wf_09_getdate ()
public subroutine wf_05_buildsub (long arg_current)
end prototypes

event ue_refresh;wf_03_buildtree(i_a_currentitem)
tv_audit_trail.show()
tv_audit_trail.setfocus()
If dw_detail_line_info.visible = true then 
	dw_detail_line_info.BringToTop = True	
	em_1.BringToTop = True
End if	

end event

event ue_options;if dw_options.visible = false then
	dw_options.BringToTop = True		
	dw_options.show()
	dw_options.setfocus()
else
	dw_options.hide()
end if 	
end event

event ue_details;If dw_detail_line_info.visible = false then
	dw_detail_line_info.BringToTop = True	
	dw_detail_line_info.Show()
	em_1.BringToTop = True
	em_1.Show()
Else
	dw_detail_line_info.Hide()
	em_1.Hide()
End if 	
end event

event ue_exit;Close(this)
end event

event ue_clicked_popup;String l_s_emstr
Int    l_i_time
l_s_emstr = em_1.text
l_i_time  = Integer(l_s_emstr)
CHOOSE CASE a_s_item
	CASE 'Seconds'
			If a_s_item <> i_s_defaulttimetype then  
				If i_s_defaulttimetype = 'Minutes' then 
					l_i_time = Integer(l_s_emstr) / 60
				Elseif i_s_defaulttimetype = 'Hours' then 	
					l_i_time = Integer(l_s_emstr) / (60 * 60)
				End if 	
				i_s_defaulttimetype = 'Seconds'											
				em_1.text = String(l_i_time)
				i_a_currentitem = i_a_general_list[1]
				i_dt_date_stamp = i_a_general_dt[1]
				w_audit_test.TriggerEvent('ue_refresh')
			End if 	
	CASE 'Minutes'
			If a_s_item <> i_s_defaulttimetype then  
				If i_s_defaulttimetype = 'Seconds' then 
					l_i_time = Integer(l_s_emstr) * 60
				Elseif i_s_defaulttimetype = 'Hours' then 	
					l_i_time = Integer(l_s_emstr) / 60
				End if 	
				i_s_defaulttimetype = 'Minutes'				
				em_1.text = String(l_i_time)								
				i_a_currentitem = i_a_general_list[1]
				i_dt_date_stamp = i_a_general_dt[1]
				w_audit_test.TriggerEvent('ue_refresh')				
			End if 	
	CASE 'Hours'
			If a_s_item <> i_s_defaulttimetype then  
			   If i_s_defaulttimetype = 'Minutes' then 
					l_i_time = Integer(l_s_emstr) * 60
				Elseif i_s_defaulttimetype = 'Seconds' then 	
					l_i_time = Integer(l_s_emstr) * (60 * 60)					
				End if 	
				i_s_defaulttimetype = 'Hours'		
				em_1.text = String(l_i_time)								
				i_a_currentitem = i_a_general_list[1]
				i_dt_date_stamp = i_a_general_dt[1]
				w_audit_test.TriggerEvent('ue_refresh')				
			End if 	
END CHOOSE		
end event

public function integer wf_01_type (string arg_s_type);Int l_i_returntype
CHOOSE CASE arg_s_type
	CASE 'J'
		 	l_i_returntype = 1 
	CASE 'M'
		 	l_i_returntype = 2 
	CASE 'B'
		 	l_i_returntype = 3 
	CASE 'T'
		 	l_i_returntype = 4 
	CASE 'C'
		 	l_i_returntype = 5 
	CASE 'Q'
		 	l_i_returntype = 6 
	CASE 'S'
		 	l_i_returntype = 7 
	CASE 'A'
		 	l_i_returntype = 9 
	CASE 'D'
		 	l_i_returntype = 10 
	CASE 'O'
		 	l_i_returntype = 11 
	CASE 'R'
		 	l_i_returntype = 12 
	CASE 'X'
			l_i_returntype = 12
	CASE ELSE
			l_i_returntype = 8
END CHOOSE
l_i_returntype = 8
RETURN l_i_returntype
end function

public subroutine wf_02_changed ();treeviewitem     	l_tvinew
Long 					l_l_newhandle, &
                  l_l_serial
String 				l_s_label, &
      				l_s_type
Int               l_i_pos
l_l_newhandle = tv_audit_trail.FindItem(CurrentTreeItem!,0)
tv_audit_trail.GetItem(l_l_newhandle , l_tvinew)
l_s_label = l_tvinew.Label 
l_s_type  = RightA(l_s_label,1) 
l_i_pos = PosA(l_s_label,' ')
If l_i_pos > 0 then 
	l_l_serial = Integer(LeftA(l_s_label,( l_i_pos - 1)))
	dw_detail_line_info.Retrieve(l_l_serial,l_s_type)	
	dw_at_list.Retrieve(l_l_serial)
	if sqlca.sqlcode = 0 and dw_at_list.Rowcount() > 0 then 
		dw_detail_line_info.title = "Detailed Info. of "+ l_s_label
		if l_l_newhandle > 1 then 
			il_currenttreeview = l_l_newhandle - 1
//			l_l_serial = dw_detail_line_info.GetItemNumber(1,'serial')
			l_s_type   = dw_detail_line_info.GetItemString(1,'type')
			i_dt_date_stamp  = dw_detail_line_info.GetItemDatetime(1,'date_stamp')
			i_s_fromloc = dw_detail_line_info.GetItemString(1,'from_loc')
			i_s_toloc 	= dw_detail_line_info.GetItemString(1,'to_loc')			
//			dw_detail_line_info.Retrieve(l_l_serial,l_s_type)
		else
//			l_l_serial = dw_detail_line_info.GetItemNumber(1,'serial')
			l_s_type   = dw_detail_line_info.GetItemString(1,'type')
			i_dt_date_stamp  = dw_detail_line_info.GetItemDatetime(1,'date_stamp')
			i_s_fromloc = dw_detail_line_info.GetItemString(1,'from_loc')
			i_s_toloc 	= dw_detail_line_info.GetItemString(1,'to_loc')			
	//		dw_detail_line_info.Retrieve(l_l_serial,l_s_type)
		end if
	end if 
end if 
end subroutine

public function boolean wf_04_check (string arg_type);Boolean l_b_ok
Int     l_i_rowcount, &
        l_i_current
String  ls_type, &
		  l_s_mark
		  
l_i_rowcount = dw_options.Rowcount()

l_b_ok = true

For l_i_current = 1 to l_i_rowcount
	 ls_type = dw_options.object.type[l_i_current]	
	 If arg_type = ls_type then 			
		 If dw_options.object.mark[l_i_current] = 'x' then			
			 l_b_ok = true
			 exit
		 else	 
			 l_b_ok = false			 	 
		 end if 	 
    Else
		 l_b_ok = false
	 End if 	 
Next
Return l_b_ok
end function

public subroutine wf_03_buildtree (any arg_currentitem);Long		ll_handle, &
			ll_roothandle

Int      l_i_ctr, &
			l_i_serial

Datetime l_dt_date_stamp

String 	l_s_type, &
			l_s_fromloc, &  	
         l_s_classtype,&
			l_s_from, &
			l_s_to, &
			l_s_serial, &
			l_s_general, &
			l_s_part, &
       	ERRORS, &
			sql_syntax, &
			presentation_str, &
			dwsyntax_str
			
treeviewitem    l_tvi

Datastore 		 dw_x

presentation_str = "style(type=grid)"

l_s_classtype = ClassName(arg_currentitem)
// Based on the type of variable passed assign it to the respective vars
Choose Case (l_s_classtype)
	Case 'long','integer'
		 l_i_serial 		= arg_currentitem
End Choose		

wf_09_getdate()  // gets the lower & higher dates from the considered dt
// Again based on the var type, build the syntax 
Choose Case (l_s_classtype)
	Case 'long','integer'
			 l_s_serial = string(l_i_serial)	
		 	 l_s_general= string(l_i_serial)
 		 	 l_s_from 	= string(i_dt_lower, "yyyy-mm-dd hh:mm.ss" )
			 l_s_to   	= string(i_dt_higher, "yyyy-mm-dd hh:mm.ss" ) 
	 		 sql_syntax = "SELECT serial, date_stamp, type, from_loc, part " &
				 		   + "FROM audit_trail "  &
		 				   + "WHERE serial="+l_s_serial &
							+        " and (date_stamp >= '" +l_s_from+"'" &
							+        " and date_stamp <= '" +l_s_to+"')"
							
End Choose		

// Build the dw syntax from the above built syntax
dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax,'', ERRORS)
IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution","SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN
END IF
SQLCA.AutoCommit = True
// create a instance of the datastore
dw_x = CREATE datastore
// create a datastore from the dw syntax
dw_x.Create(dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution","Create cause these errors: " + ERRORS)
   SQLCA.AutoCommit = False
	DESTROY dw_x
	RETURN
END IF

// get the root handle 
	ll_handle 	= tv_audit_trail.FindItem(RootTreeItem!, 0)
	tv_audit_trail.CollapseItem(ll_handle) 
	tv_audit_trail.DeleteItem(ll_handle)
// Insert the first element 	
	ll_handle = tv_audit_trail.InsertItemFirst(0, l_s_general,wf_01_type(l_s_type))
	dw_x.settransobject(sqlca)	
	dw_x.Retrieve()

	If dw_x.Rowcount() > 0 then 
		FOR l_i_ctr = 1 to dw_x.Rowcount()
			l_i_serial		= dw_x.object.#1[l_i_ctr]
			l_dt_date_stamp= dw_x.object.#2[l_i_ctr]
			l_s_type       = dw_x.object.#3[l_i_ctr]			
			l_s_part       = dw_x.object.#5[l_i_ctr]			
			If wf_04_check(l_s_type) then 
				tv_audit_trail.InsertItemLast(ll_handle, String(l_i_serial)+'  '+String(l_dt_date_stamp)+' '+l_s_part+' '+l_s_type,wf_01_type(l_s_type))
			End if 	
		NEXT	
	End if	
// expand all the tree item 	
	ll_handle 	= tv_audit_trail.FindItem(RootTreeItem!, 0)	
	tv_audit_trail.ExpandAll(ll_handle)
	tv_audit_trail.SelectItem(ll_handle)	
	wf_02_changed()
	
DESTROY dw_x
SQLCA.AutoCommit = False
end subroutine

public subroutine wf_09_getdate ();Datetime l_dt_lower, &
			l_dt_higher

Time     l_t_temp, &
         l_t_lower, &
			l_t_higher
			
Date     l_d_temp

l_d_temp 	= Date(i_dt_date_stamp)
l_t_temp 	= Time(i_dt_date_stamp)

l_t_lower  	= RelativeTime(l_t_temp,(Integer(em_1.text)* -1))
l_t_higher 	= RelativeTime(l_t_temp,Integer(em_1.text))

i_dt_lower  = Datetime(l_d_temp,l_t_lower)
i_dt_higher = Datetime(l_d_temp,l_t_higher)

end subroutine

public subroutine wf_05_buildsub (long arg_current);Long		ll_handle, &
         ll_nxthandle

Int      l_i_ctr, &
			l_i_serial

Datetime l_dt_date_stamp

String 	l_s_type, &
			l_s_fromloc, &  	
         l_s_classtype,&
			l_s_from, &
			l_s_to, &
			l_s_serial, &
			l_s_general, &
			l_s_part, &
       	ERRORS, &
			sql_syntax, &
			presentation_str, &
			dwsyntax_str
			
treeviewitem    l_tvi

Datastore 		 dw_x

presentation_str = "style(type=grid)"

l_s_classtype = ClassName(i_a_currentitem)

// Based on the type of variable passed assign it to the respective vars

Choose Case (l_s_classtype)
	Case 'long','integer'
		 l_i_serial 		= i_a_currentitem
		 l_s_serial       = String(l_i_serial)
End Choose		

wf_09_getdate()  // gets the lower & higher dates from the considered dt

sql_syntax=''
l_s_general = i_s_fromloc
l_s_from 	= string(i_dt_lower, "yyyy-mm-dd hh:mm.ss" )
l_s_to   	= string(i_dt_higher, "yyyy-mm-dd hh:mm.ss" ) 

IF i_s_type='M' THEN
   sql_syntax = "SELECT serial, date_stamp, type, from_loc, part " &
	      	   + "FROM audit_trail "  &
	            + "WHERE from_loc='"+i_s_fromloc+"'" &
   				+        " and (date_stamp >= '" +l_s_from+"'" &
   				+        " and date_stamp <= '" +l_s_to+"')"		
ELSEIF i_s_type='J' THEN
	sql_syntax = "SELECT serial, date_stamp, type, from_loc, part " &
		 		   + "FROM audit_trail "  &
	 			   + "WHERE workorder='"+i_s_workorder+"'" &
					+        " and (date_stamp >= '" +l_s_from+"'" &
					+        " and date_stamp <= '" +l_s_to+"')"		
END IF

IF sql_syntax > '' THEN
	// Build the dw syntax from the above built syntax
	dwsyntax_str = SQLCA.SyntaxFromSQL(sql_syntax,'', ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution","SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN
	END IF
	SQLCA.AutoCommit = True
	// create a instance of the datastore
	dw_x = CREATE datastore
	// create a datastore from the dw syntax
	dw_x.Create(dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution","Create cause these errors: " + ERRORS)
	   SQLCA.AutoCommit = False
		DESTROY dw_x
		RETURN
	END IF

	dw_x.settransobject(sqlca)	
	dw_x.Retrieve()
	ll_handle = arg_current
	ll_nxthandle = ll_handle 
	If dw_x.Rowcount() > 0 then 
		FOR l_i_ctr = 1 to dw_x.Rowcount()
			l_i_serial		= dw_x.object.#1[l_i_ctr]
			l_dt_date_stamp= dw_x.object.#2[l_i_ctr]
			l_s_type       = dw_x.object.#3[l_i_ctr]			
			l_s_part       = dw_x.object.#5[l_i_ctr]			
			IF Integer(l_s_serial) <> l_i_serial then 
				IF l_i_ctr = 1 then 
					ll_nxthandle = tv_audit_trail.InsertItemFirst(ll_handle, l_s_general,wf_01_type(l_s_type))
				End if 	
				If wf_04_check(l_s_type)  then 
					tv_audit_trail.InsertItemLast(ll_nxthandle, String(l_i_serial)+'  '+String(l_dt_date_stamp)+' '+l_s_part+' '+l_s_type,wf_01_type(l_s_type))
				End if 	
			End if	
		NEXT	
		tv_audit_trail.ExpandAll(ll_handle)
	End if	

	DESTROY dw_x
	SQLCA.AutoCommit = False
END IF 	
end subroutine

on w_audit_test.create
this.dw_options=create dw_options
this.em_1=create em_1
this.dw_at_list=create dw_at_list
this.dw_detail_line_info=create dw_detail_line_info
this.tv_audit_trail=create tv_audit_trail
this.Control[]={this.dw_options,&
this.em_1,&
this.dw_at_list,&
this.dw_detail_line_info,&
this.tv_audit_trail}
end on

on w_audit_test.destroy
destroy(this.dw_options)
destroy(this.em_1)
destroy(this.dw_at_list)
destroy(this.dw_detail_line_info)
destroy(this.tv_audit_trail)
end on

event open;String   l_s_ds, &
         l_s_left, &
			l_s_right, &
			l_s_serial, & 
			l_s_temp
			
Datetime l_dt_dates

Int      l_i_pos

l_s_temp   = Message.stringparm
l_i_pos    = PosA(l_s_temp,' ')
If l_i_pos <= 0 then return
l_s_serial = MidA(l_s_temp,1, (l_i_pos - 1)) 
l_s_ds     = MidA(l_s_temp,(l_i_pos + 1), (LenA(l_s_temp) - l_i_pos))
i_a_currentitem = Integer(l_s_serial)
i_a_general_list[1]= i_a_currentitem
l_i_pos    = PosA(l_s_ds,' ')
If l_i_pos > 0 then 
	l_s_left  = MidA(l_s_ds,1, (l_i_pos - 1))
	l_s_right = MidA(l_s_ds,(l_i_pos + 1), (LenA(l_s_ds) - l_i_pos))
	l_dt_dates = Datetime(Date(l_s_left),time(l_s_right))
	i_dt_date_stamp = l_dt_dates
	i_a_general_dt[1] = i_dt_date_stamp
End if 	
//em_1.Setmask(TimeMask!,'##')
Triggerevent('ue_refresh')	


end event

event activate;if gnv_App.of_GetFrame().MenuName <> "m_audit" then
	gnv_App.of_GetFrame().ChangeMenu ( m_audit )
end if
end event

type dw_options from datawindow within w_audit_test
int X=1435
int Width=850
int Height=1024
int TabOrder=30
boolean Visible=false
string DataObject="d_general"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

event clicked;If dw_options.getitemstring(row,'mark') = ' ' then
	dw_options.setitem(row,'mark','x')
Else
	dw_options.setitem(row,'mark',' ')	
End if 	
end event

type em_1 from editmask within w_audit_test
event ue_changed pbm_enchange
int X=1125
int Width=288
int Height=80
int TabOrder=10
boolean Visible=false
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean Spin=true
string DisplayData="Ä"
double Increment=1
string MinMax="1~~"
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_changed;i_a_currentitem = i_a_general_list[1]
i_dt_date_stamp = i_a_general_dt[1]
Parent.Triggerevent('ue_refresh')
end event

event constructor;this.text = '60'
end event

type dw_at_list from datawindow within w_audit_test
int X=923
int Width=494
int Height=364
int TabOrder=20
boolean Visible=false
string DataObject="d_audit_trial_list"
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

type dw_detail_line_info from datawindow within w_audit_test
int X=1426
int Width=1367
int Height=800
int TabOrder=40
boolean Visible=false
string DataObject="d_expanded_line_info"
boolean TitleBar=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
this.height = parent.height - 30

end event

type tv_audit_trail from treeview within w_audit_test
int X=5
int Width=837
int Height=1196
int TabOrder=50
boolean Visible=false
BorderStyle BorderStyle=StyleRaised!
boolean DisableDragDrop=false
boolean LinesAtRoot=true
string PictureName[]={"alphaJ.bmp",&
"alphaM.bmp",&
"alphaB.bmp",&
"alphaT.bmp",&
"alphaC.bmp",&
"alphaQ.bmp",&
"alphaS.bmp",&
"Custom039!",&
"alphaA.bmp",&
"alphaD.bmp",&
"alphaO.bmp",&
"alphaR.bmp",&
"alphaX.bmp"}
long PictureMaskColor=255
long StatePictureMaskColor=553648127
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;this.height = Parent.height - 30
this.width  = Parent.width  - 30

end event

event selectionchanged;wf_02_changed()
end event

event doubleclicked;//this.Hide()
treeviewitem     	l_tvinew
Long 					l_l_newhandle, &
  	               l_l_serial
String 				l_s_label, &
                  l_s_type
Int               l_i_pos
l_l_newhandle 	= tv_audit_trail.FindItem(CurrentTreeItem!,0)
tv_audit_trail.GetItem(l_l_newhandle , l_tvinew)
l_s_label 		= l_tvinew.Label 
l_i_pos 			= PosA(l_s_label,' ')
l_s_type       = RightA(l_s_label,1)
i_s_type       = l_s_type
If l_i_pos > 0 then 
	i_a_currentitem = Integer(LeftA(l_s_label,( l_i_pos - 1)))
	dw_detail_line_info.Retrieve(i_a_currentitem,l_s_type)
	i_s_fromloc = dw_detail_line_info.object.from_loc[1]
	i_s_workorder=dw_detail_line_info.object.workorder[1]
//	i_l_level ++ 
// i_a_general_list[i_l_level] = i_a_currentitem
	wf_05_buildsub(l_l_newhandle)
End if	
end event

event rightdoubleclicked;treeviewitem     	l_tvinew
Long 					l_l_newhandle, &
						l_l_nxthandle, & 	
  	               l_l_serial
String 				l_s_label
Int               l_i_pos
l_l_newhandle 	= tv_audit_trail.FindItem(CurrentTreeItem!,0)
l_l_nxthandle  = tv_audit_trail.FindItem(ChildTreeItem!,l_l_newhandle)
if l_l_nxthandle > 0 then 
	tv_audit_trail.DeleteItem(l_l_nxthandle)
end if 	
end event

event rightclicked;window				l_w_mdiframe
int					l_i_count
treeviewitem		l_tvi_item
string				l_s_prevsort
m_general       	l_m_popup,&
						l_m_popupitems[]

l_m_popupitems[1] = CREATE m_general // menuname 
l_m_popupitems[1].Item[1].Text = "Seconds"
l_m_popupitems[2] = CREATE m_general
l_m_popupitems[2].Item[1].Text = "Minutes"
l_m_popupitems[3] = CREATE m_general
l_m_popupitems[3].Item[1].Text = "Hours"

l_m_popup = CREATE m_general

l_w_mdiframe = Parent.ParentWindow ( )

For l_i_count = 1 to UpperBound ( l_m_popupitems )
	l_m_popup.m_test.Item[l_i_count] = l_m_popupitems[l_i_count].Item[1]
Next
	
if isvalid ( l_w_mdiframe ) then
	l_m_popup.m_test.PopMenu ( l_w_mdiframe.PointerX(), l_w_mdiframe.PointerY() )
else
	l_m_popup.m_test.PopMenu ( Parent.PointerX(), Parent.PointerY() )
end if

end event

