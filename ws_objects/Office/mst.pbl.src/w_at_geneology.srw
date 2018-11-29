$PBExportHeader$w_at_geneology.srw
forward
global type w_at_geneology from w_sheet_4t
end type
type dw_bom_parts from datawindow within w_at_geneology
end type
type dw_vbom from datawindow within w_at_geneology
end type
type dw_at_details from datawindow within w_at_geneology
end type
type tv_1 from treeview within w_at_geneology
end type
type tv_vbom from treeview within w_at_geneology
end type
type dw_at_wo_details from datawindow within w_at_geneology
end type
type dw_at_serial_list from datawindow within w_at_geneology
end type
end forward

global type w_at_geneology from w_sheet_4t
integer height = 1560
string title = "Audit Trail Geneology Tree"
string menuname = "m_audit"
event ue_exit ( )
dw_bom_parts dw_bom_parts
dw_vbom dw_vbom
dw_at_details dw_at_details
tv_1 tv_1
tv_vbom tv_vbom
dw_at_wo_details dw_at_wo_details
dw_at_serial_list dw_at_serial_list
end type
global w_at_geneology w_at_geneology

type variables
Long          il_idxnumary[13], &
                    il_idxnum, &
                    il_serial

Datastore id_datastore1

String         is_createsyntax='', &
                    is_insertsyntax='', &
                    is_err='', &
                    i_s_label='', &
                    i_s_part=''
Dec           i_d_quantity


end variables

forward prototypes
public subroutine wf_assign_picture_index ()
public function long wf_get_picture_index (string arg_serial_type)
public subroutine wf_build_retrieve_dw (string arg_syntax)
public subroutine wf_get_bom (string arg_part)
public subroutine wf_build_tv (long arg_serial, long arg_handle, string arg_type)
public function long wf_check_expanded (string arg_type, long arg_serial)
end prototypes

event ue_exit;is_createsyntax = 'DROP TABLE at_expanded_list'

// Included the autocommit statements to prevent extent locks on sql server db - mb 09/03/99
if g_s_platform = 'Microsoft SQL Server' then &
	sqlca.autocommit = true 

Execute Immediate :is_createsyntax ;

if g_s_platform = 'Microsoft SQL Server' then  &
	sqlca.autocommit = false

close(this)
end event

public subroutine wf_assign_picture_index ();Long ll_idxnum
ll_idxnum=tv_1.addpicture('jc.bmp')
il_idxnumary[1]=ll_idxnum
ll_idxnum=tv_1.addpicture('mi.bmp')
il_idxnumary[2]=ll_idxnum	
ll_idxnum=tv_1.addpicture('bo.bmp')
il_idxnumary[3]=ll_idxnum	
ll_idxnum=tv_1.addpicture('co.bmp')
il_idxnumary[4]=ll_idxnum		
ll_idxnum=tv_1.addpicture('tr.bmp')
il_idxnumary[5]=ll_idxnum		
ll_idxnum=tv_1.addpicture('qt.bmp')
il_idxnumary[6]=ll_idxnum		
ll_idxnum=tv_1.addpicture('rc.bmp')
il_idxnumary[7]=ll_idxnum			
ll_idxnum=tv_1.addpicture('sh.bmp')
il_idxnumary[8]=ll_idxnum	
ll_idxnum=tv_1.addpicture('so.bmp')
il_idxnumary[9]=ll_idxnum			
ll_idxnum=tv_1.addpicture('ad.bmp')
il_idxnumary[10]=ll_idxnum			
ll_idxnum=tv_1.addpicture('pt.bmp')
il_idxnumary[11]=ll_idxnum			
ll_idxnum=tv_1.addpicture('ct.bmp')
il_idxnumary[12]=ll_idxnum			
ll_idxnum=tv_1.addpicture('dt.bmp')
il_idxnumary[13]=ll_idxnum			
end subroutine

public function long wf_get_picture_index (string arg_serial_type);Long ll_idxnum

CHOOSE CASE arg_serial_type
 		CASE 'J'
				ll_idxnum=il_idxnumary[1]
		CASE 'M'
				ll_idxnum=il_idxnumary[2]					
		CASE 'B'
				ll_idxnum=il_idxnumary[3]					
		CASE 'C'
				ll_idxnum=il_idxnumary[4]					
		CASE 'T'
				ll_idxnum=il_idxnumary[5]					
		CASE 'Q'
				ll_idxnum=il_idxnumary[6]					
		CASE 'R'
				ll_idxnum=il_idxnumary[7]		
		CASE 'S'
				ll_idxnum=il_idxnumary[9]		
		CASE 'A'
				ll_idxnum=il_idxnumary[10]		
		CASE 'P'
				ll_idxnum=il_idxnumary[11]		
		CASE 'X'
				ll_idxnum=il_idxnumary[12]		
		CASE 'D'
				ll_idxnum=il_idxnumary[13]		
		CASE ELSE		
				ll_idxnum=1						
END CHOOSE
return ll_idxnum

end function

public subroutine wf_build_retrieve_dw (string arg_syntax);id_datastore1   = CREATE DataStore
is_createsyntax = arg_syntax
is_insertsyntax = SQLCA.SyntaxFromSQL(is_createsyntax, "", is_err)
id_datastore1.Create(is_insertsyntax, is_err)
id_datastore1.settransobject(sqlca)
id_datastore1.retrieve()
commit;
end subroutine

public subroutine wf_get_bom (string arg_part);Int  l_i_totalitems, &
     l_i_nodeitem, &
	  l_i_prev=0
	  
String l_s_part, &
		 l_s_curnpart

Long l_l_tvcurn, &
     l_i_rowno, &
	  l_i_newrowno, &
	  l_i_rowretrieved, &
	  l_i_rowcurn
Dec  l_d_qty

TreeviewItem l_t_tv		 
		 
dw_vbom.reset()
tv_vbom.deleteitem(0)

l_i_newrowno = dw_vbom.insertrow(0)
dw_vbom.setitem(l_i_newrowno,'part'  ,arg_part)
dw_vbom.setitem(l_i_newrowno,'expanded','N')
l_s_part = arg_part  //l_s_curnpart
l_l_tvcurn	= tv_vbom.InsertItemFirst(l_i_prev,l_s_part+' '+String(i_d_quantity,'####00'),1)
l_i_rowcurn=1
DO 
	l_i_rowcurn = dw_vbom.find("expanded='N'",l_i_rowcurn,dw_vbom.rowcount())
	IF l_i_rowcurn = 0 THEN
		EXIT
	END IF	
	l_s_curnpart=l_s_part
 	l_s_part = dw_vbom.getitemstring(l_i_rowcurn,'part')	
	l_i_totalitems = dw_vbom.Rowcount()  
	FOR l_i_nodeitem = 1 TO l_i_totalitems
	    tv_vbom.GetItem(l_i_nodeitem,l_t_tv)
		 IF l_t_tv.label = l_s_part THEN 
  	 		 l_l_tvcurn   = l_i_nodeitem
	 		 EXIT
   	 END IF  	
	NEXT	 
	l_i_rowretrieved = dw_bom_parts.retrieve(l_s_part)	 
	IF l_i_rowretrieved > 0 THEN
  	   l_i_newrowno = l_i_rowcurn
		l_i_prev = l_l_tvcurn  // to get the curn handle from the ins row
		FOR l_i_rowno = 1 to l_i_rowretrieved
			 l_s_part = dw_bom_parts.getitemstring(l_i_rowno,'part')
			 l_d_qty  = dw_bom_parts.getitemdecimal(l_i_rowno,'quantity')			 
			 l_i_newrowno ++ 
			 dw_vbom.insertrow(l_i_newrowno)
			 dw_vbom.scrolltorow(l_i_newrowno)
			 dw_vbom.setitem(l_i_newrowno,'part'  ,l_s_part)
			 dw_vbom.setitem(l_i_newrowno,'expanded','N')
			 l_l_tvcurn = tv_vbom.InsertItemLast(l_i_prev,l_s_part+' '+String((l_d_qty * i_d_quantity),'####00'),1)			 			 
		NEXT
	END IF 
   dw_vbom.setitem(l_i_rowcurn,'expanded','Y')
	l_l_tvcurn = tv_vbom.FindItem(RootTreeItem!,0)
	tv_vbom.Expandall(l_l_tvcurn)
LOOP WHILE (TRUE)
end subroutine

public subroutine wf_build_tv (long arg_serial, long arg_handle, string arg_type);String ls_serial, & 
       ls_part, &
		 ls_serial_type, &
		 ls_curn_type 
Int    li_check_value, &
       li_start_pos, &
		 li_end_pos
Long   ll_serial, &
       ll_curnserial, & 
		 ll_parenttv, &
		 ll_idxnum
Dec    ld_qty
Datetime ldt_dt
ls_serial=String(arg_serial)
ls_curn_type = LeftA(arg_type,1) 
IF AscA(ls_curn_type) >= 65 AND AscA(ls_curn_type) <= 92 THEN
   CHOOSE CASE ls_curn_type
	CASE 'B'
	  li_check_value=wf_check_expanded(ls_curn_type,il_serial)	
	  IF (li_check_value=0) THEN	
		  wf_build_retrieve_dw("SELECT serial,date_stamp,type,quantity,from_loc,to_loc,part " + &
		                      " FROM audit_trail " + &
									" WHERE from_loc = '"+ls_serial+"'" )
        IF id_datastore1.rowcount() > 0 THEN
           FOR ll_curnserial=1 to id_datastore1.rowcount()
               ls_serial_type=id_datastore1.getitemstring(ll_curnserial,3) 
               ls_part=id_datastore1.getitemstring(ll_curnserial,7) 			 										
  					ls_serial=String(id_datastore1.getitemnumber(ll_curnserial,1))
               ldt_dt   =id_datastore1.getitemdatetime(ll_curnserial,2)
               ll_idxnum=wf_get_picture_index(ls_serial_type) 
               ld_qty   =id_datastore1.getitemdecimal(ll_curnserial,4) 
					i_d_quantity=ld_qty
//               tv_1.insertitemFirst(arg_handle,'Serial:'+ls_serial+ ', Part:'+ls_part,ll_idxnum)
        	      tv_1.insertitemFirst(arg_handle,ls_serial+ ' ' + String(ld_qty,'######00')+' '+string(ldt_dt),ll_idxnum)		 			 
           NEXT 
		  END IF 
        Destroy id_datastore1
        tv_1.expandall(arg_handle)
	  END IF  		  
	CASE 'C'
	  li_check_value=wf_check_expanded(ls_curn_type,il_serial)	
	  IF (li_check_value = 0) THEN			
		  wf_build_retrieve_dw("SELECT serial,date_stamp,type,quantity,from_loc,to_loc,part " + &
		                      " FROM audit_trail " + &
									" WHERE to_loc= '"+ls_serial+"'" )
        IF id_datastore1.rowcount() > 0 THEN
           FOR ll_curnserial=1 to id_datastore1.rowcount()
               ls_serial_type=id_datastore1.getitemstring(ll_curnserial,3) 
               ls_part=id_datastore1.getitemstring(ll_curnserial,7) 		
  					ls_serial=String(id_datastore1.getitemnumber(ll_curnserial,1))
               ldt_dt   =id_datastore1.getitemdatetime(ll_curnserial,2)
               ll_idxnum=wf_get_picture_index(ls_serial_type) 
               ld_qty   =id_datastore1.getitemdecimal(ll_curnserial,4) 
//               tv_1.insertitemFirst(arg_handle,'Serial:'+ls_serial+ ', Part:'+ls_part,ll_idxnum)		 					
        	      tv_1.insertitemFirst(arg_handle,ls_serial+ ' ' + String(ld_qty,'######00.000000')+' '+string(ldt_dt),ll_idxnum)		 			 					
           NEXT 
		  END IF 
        Destroy id_datastore1
        tv_1.expandall(arg_handle)		  
	  END IF   
//   CASE	  'S'
//	  li_start_pos=pos(i_s_label,':')
//	  li_end_pos  =pos(i_s_label,',')
//	  ls_serial=Mid(i_s_label,(li_start_pos + 1),((li_end_pos - 1) - li_start_pos))
//     li_check_value=wf_check_expanded(left(ls_serial,1),Long(ls_serial))
//     IF (li_check_value=0) THEN
//        wf_build_retrieve_dw("SELECT serial,date_stamp,type,quantity,from_loc,to_loc,part " + &
//	                           " FROM audit_trail " + &
//   		   					  " WHERE serial = "+ls_serial+" and from_loc <> '"+ls_serial+"' and to_loc <> '"+ls_serial+"'")
//        IF id_datastore1.rowcount() > 0 THEN
//           FOR ll_curnserial=1 to id_datastore1.rowcount()
//               ls_serial_type=id_datastore1.getitemstring(ll_curnserial,'type') 
//               ls_serial=string(id_datastore1.getitemnumber(ll_curnserial,'serial'))
//               ldt_dt   =id_datastore1.getitemdatetime(ll_curnserial,'date_stamp')
//               ll_idxnum=wf_get_picture_index(ls_serial_type) 
//               ld_qty   =id_datastore1.getitemdecimal(ll_curnserial,'quantity') 
//         	   tv_1.insertitemFirst(arg_handle,ls_serial+ ' ' + String(ld_qty,'######00.000000')+' '+string(ldt_dt),ll_idxnum)		 			 
//           NEXT 
//        END IF 		
//        Destroy id_datastore1		
//        tv_1.expandall(arg_handle)		
//     END IF 
   END CHOOSE		  
ELSE
	li_check_value=wf_check_expanded(ls_curn_type,Long(arg_type))
   IF (li_check_value=0) THEN
      wf_build_retrieve_dw("SELECT serial,date_stamp,type,quantity,from_loc,to_loc,part " + &
	                         " FROM audit_trail " + &
   								" WHERE serial = "+arg_type+" and from_loc <> '"+arg_type+"' and to_loc <> '"+arg_type+"'")
      IF id_datastore1.rowcount() > 0 THEN
         FOR ll_curnserial=1 to id_datastore1.rowcount()
             ls_serial_type=id_datastore1.getitemstring(ll_curnserial,3) 
             ls_serial=string(id_datastore1.getitemnumber(ll_curnserial,1))
             ldt_dt   =id_datastore1.getitemdatetime(ll_curnserial,2)
             ll_idxnum=wf_get_picture_index(ls_serial_type) 
             ld_qty   =id_datastore1.getitemdecimal(ll_curnserial,4) 
        	    tv_1.insertitemFirst(arg_handle,ls_serial+ ' ' + String(ld_qty,'######00.000000')+' '+string(ldt_dt),ll_idxnum)		 			 
         NEXT 
      END IF 		
      Destroy id_datastore1		
      tv_1.expandall(arg_handle)		
   END IF 
END IF 	
end subroutine

public function long wf_check_expanded (string arg_type, long arg_serial);Int li_rtnval=1
Long li_count

SELECT count(*) 
  INTO :li_count
  FROM sysobjects
 WHERE name='at_expanded_list' ;
IF li_count > 0 THEN 
   SELECT count(*) 
     INTO :li_count
     FROM at_expanded_list
    WHERE (type   = :arg_type+' ' and
           serial = :arg_serial) ;
   			  
   IF li_count=0 THEN
      INSERT INTO at_expanded_list (type,serial) VALUES (:arg_type,:arg_serial) ;
		COMMIT ;
      li_rtnval=0
   ELSE
      li_rtnval=1
   END IF
ELSE
	li_rtnval=0
END IF 
RETURN li_rtnval


end function

on w_at_geneology.create
int iCurrent
call super::create
if this.MenuName = "m_audit" then this.MenuID = create m_audit
this.dw_bom_parts=create dw_bom_parts
this.dw_vbom=create dw_vbom
this.dw_at_details=create dw_at_details
this.tv_1=create tv_1
this.tv_vbom=create tv_vbom
this.dw_at_wo_details=create dw_at_wo_details
this.dw_at_serial_list=create dw_at_serial_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_bom_parts
this.Control[iCurrent+2]=this.dw_vbom
this.Control[iCurrent+3]=this.dw_at_details
this.Control[iCurrent+4]=this.tv_1
this.Control[iCurrent+5]=this.tv_vbom
this.Control[iCurrent+6]=this.dw_at_wo_details
this.Control[iCurrent+7]=this.dw_at_serial_list
end on

on w_at_geneology.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_bom_parts)
destroy(this.dw_vbom)
destroy(this.dw_at_details)
destroy(this.tv_1)
destroy(this.tv_vbom)
destroy(this.dw_at_wo_details)
destroy(this.dw_at_serial_list)
end on

event open;call super::open;String ls_serial, & 
       ls_part, &
		 ls_serial_type
Long   ll_serial, &
       ll_curnserial, & 
		 ll_parenttv, &
		 ll_idxnum
Dec    ld_qty
Datetime ldt_dt

is_createsyntax = 'CREATE TABLE at_expanded_list (type char(2), serial int)'

// Included the autocommit statements to prevent extent locks on sql server db - mb 09/03/99
if g_s_platform = 'Microsoft SQL Server' then &
	sqlca.autocommit = true 

Execute Immediate :is_createsyntax ;

// Included the autocommit statements to prevent extent locks on sql server db - mb 09/03/99
if g_s_platform = 'Microsoft SQL Server' then  &
	sqlca.autocommit = false

ls_serial = Message.StringParm
il_serial = Long(ls_serial)

tv_1.deleteitem(0)

wf_build_retrieve_dw("SELECT serial,date_stamp,type,quantity,from_loc,to_loc,part " + &
                       " FROM audit_trail " + &
	 						 " WHERE serial= "+string(il_serial)+" ORDER BY date_stamp desc")
							  
IF id_datastore1.rowcount() > 0 THEN 
	
   ll_serial=id_datastore1.getitemnumber(1,'serial')
	ls_part  =id_datastore1.getitemstring(1,'part')
	i_s_part = ls_part
   ls_serial=String(ll_serial)
	ll_idxnum=tv_1.addpicture('sr.bmp')
	ll_parenttv = tv_1.insertitemFirst(0,'Serial:'+ls_serial+', Part:'+ls_part,ll_idxnum)
	
   wf_assign_picture_index()
	
	FOR ll_curnserial=1 to id_datastore1.rowcount()
		
       ls_serial_type=id_datastore1.getitemstring(ll_curnserial,'type') 
   	 ldt_dt   =id_datastore1.getitemdatetime(ll_curnserial,'date_stamp')
       ll_idxnum=wf_get_picture_index(ls_serial_type) 
       ld_qty   =id_datastore1.getitemdecimal(ll_curnserial,'quantity') 
		 i_d_quantity=ld_qty
    	 tv_1.insertitemFirst(ll_parenttv,ls_serial_type + ' ' + String(ld_qty,'######00')+' '+string(ldt_dt),ll_idxnum)		 
		  
	NEXT 
	
	tv_1.expandall(ll_parenttv)
	
END IF 

DESTROY id_datastore1

end event

type dw_bom_parts from datawindow within w_at_geneology
boolean visible = false
integer x = 498
integer y = 1680
integer width = 393
integer height = 288
integer taborder = 50
string dataobject = "d_at_bom_part_for_display"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_vbom from datawindow within w_at_geneology
boolean visible = false
integer x = 41
integer y = 1680
integer width = 393
integer height = 288
integer taborder = 40
string dataobject = "d_at_vbom"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_at_details from datawindow within w_at_geneology
integer x = 1751
integer y = 28
integer width = 1143
integer height = 516
integer taborder = 10
string dataobject = "d_expanded_line_info"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type tv_1 from treeview within w_at_geneology
integer x = 18
integer y = 28
integer width = 1723
integer height = 1628
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 78682240
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Custom039!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

event rightclicked;treeviewitem     	l_tvinew
Long 					l_l_newhandle, &
                  l_l_serial
String 				l_s_label, &
                  l_s_type
window				l_w_mdiframe
int					l_i_count
treeviewitem		l_tvi_item
string				l_s_prevsort
m_general       	l_m_popup,&
						l_m_popupitems[]

l_l_newhandle 	= tv_1.FindItem(CurrentTreeItem!,0)
tv_1.GetItem(l_l_newhandle , l_tvinew)
i_s_label 		= l_tvinew.Label 
l_s_type       = LeftA(i_s_label,1)
l_s_label      =''

CHOOSE CASE l_s_type
	CASE 'J'	 
		 l_s_label = "JC - Job Completion" 
	CASE 'M'	 
		 l_s_label = "MI - Material Issue" 		 
	CASE 'B'	 
		 l_s_label = "BO - Break Out" 		 
	CASE 'T'	 
		 l_s_label = "TR - TRansfer" 		 		 
	CASE 'C'	 
		 l_s_label = "CO - COmbine" 		 		 
	CASE 'Q'	 
		 l_s_label = "QT - QualiTy" 		 		 
	CASE 'R'	 
		 l_s_label = "RC - ReCeive" 	
	CASE 'A'	 
		 l_s_label = "AD - ADd" 	
	CASE 'P'	 
		 l_s_label = "PT - PalleT" 	
	CASE 'X'	 
		 l_s_label = "CT - CorrecT" 	
	CASE 'D'	 
		 l_s_label = "DT - DeleTe" 	
END CHOOSE		

IF l_s_label > '' THEN
   l_m_popupitems[1] = CREATE m_general // menuname 
   l_m_popupitems[1].Item[1].Text = l_s_label
 
   l_m_popup = CREATE m_general
   l_w_mdiframe = Parent.ParentWindow ( )
   For l_i_count = 1 to UpperBound ( l_m_popupitems )
    	 l_m_popup.m_test.Item[l_i_count] = l_m_popupitems[l_i_count].Item[1]
   Next
	
   IF isvalid ( l_w_mdiframe ) THEN
   	l_m_popup.m_test.PopMenu ( l_w_mdiframe.PointerX(), l_w_mdiframe.PointerY() )
   ELSE
   	l_m_popup.m_test.PopMenu ( Parent.PointerX(), Parent.PointerY() )
   END IF
END IF 	

end event

event clicked;treeviewitem     	l_tvinew
Long 					l_l_newhandle, &
                  l_l_serial
String 				l_s_label, &
                  l_s_type, &
						l_s_datetime, &
						l_s_date, & 
						l_s_time, &
                  l_s_workorder						

Long              l_i_start, & 
                  l_i_end, & 
						l_i_temp, &
						l_i_len

Dec               l_d_onhand

Date              l_d_date

Time              l_t_time

Datetime          l_dt_dt

						
l_l_newhandle 	= tv_1.FindItem(CurrentTreeItem!,0)
tv_1.GetItem(l_l_newhandle , l_tvinew)
i_s_label 		= l_tvinew.Label 
l_s_type       = LeftA(i_s_label,2)

wf_build_tv(il_serial,l_l_newhandle,l_s_type)
IF l_s_type = 'M ' THEN 
	l_i_len      = LenA(i_s_label)
	l_i_end      = PosA(i_s_label," ",3)
	l_s_datetime = RightA( i_s_label,(l_i_len - l_i_end))
	l_i_len      = LenA(l_s_datetime)
	l_i_end      = PosA(l_s_datetime,' ')
	l_s_date     = LeftA(l_s_datetime,(l_i_end - 1))
	l_s_time     = RightA(l_s_datetime,(l_i_end + 1))
	l_d_date     = date(l_s_date)
	l_t_time     = time(l_s_time)
	l_dt_dt      = Datetime(l_d_date,l_t_time)
   dw_at_serial_list.show()
   dw_at_wo_details.show()	 
	tv_vbom.hide()
ELSE
   dw_at_details.retrieve(0,LeftA(l_s_type,1))	
   dw_at_serial_list.retrieve('ZZZZZZZ')		// passing something which is not present in the table
   dw_at_serial_list.hide()
   dw_at_wo_details.hide()
	tv_vbom.show()	
   wf_get_bom(i_s_part)	// change this to the selected part
END IF 	
dw_at_details.retrieve(il_serial,LeftA(l_s_type,1))
SELECT workorder
  INTO :l_s_workorder
  FROM audit_trail 
 WHERE serial= :il_serial ;
 
IF NOT ISNULL(l_s_workorder) and l_s_workorder <> '' THEN
   SELECT max(on_hand)
     INTO :l_d_onhand
     FROM audit_trail 
    WHERE workorder= :l_s_workorder ;
   dw_at_serial_list.retrieve(l_s_workorder)	
   dw_at_wo_details.retrieve(l_s_workorder,l_d_onhand)	
END IF 	

end event

type tv_vbom from treeview within w_at_geneology
integer x = 1751
integer y = 556
integer width = 1143
integer height = 1100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 78682240
borderstyle borderstyle = stylelowered!
string picturename[] = {"Custom039!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
end type

type dw_at_wo_details from datawindow within w_at_geneology
integer x = 1751
integer y = 548
integer width = 1143
integer height = 540
integer taborder = 20
string dataobject = "d_at_wo_details"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_at_serial_list from datawindow within w_at_geneology
integer x = 1751
integer y = 1092
integer width = 1143
integer height = 560
integer taborder = 50
string dataobject = "d_at_serial_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)


end event

