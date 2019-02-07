$PBExportHeader$w_bomcheck.srw
forward
global type w_bomcheck from Window
end type
type dw_part_main from datawindow within w_bomcheck
end type
type dw_part_ext from datawindow within w_bomcheck
end type
type dw_parts from datawindow within w_bomcheck
end type
type dw_error from datawindow within w_bomcheck
end type
type dw_bom from datawindow within w_bomcheck
end type
end forward

global type w_bomcheck from Window
int X=0
int Y=0
int Width=3479
int Height=2444
boolean TitleBar=true
long BackColor=77897888
boolean HScrollBar=true
boolean VScrollBar=true
WindowState WindowState=maximized!
event ue_open pbm_custom01
event ue_print pbm_custom02
event ue_save pbm_custom03
event ue_start pbm_custom04
event ue_stop pbm_custom05
dw_part_main dw_part_main
dw_part_ext dw_part_ext
dw_parts dw_parts
dw_error dw_error
dw_bom dw_bom
end type
global w_bomcheck w_bomcheck

type variables
Long  l_bom_level = 1
Long  l_error_level 
Boolean ib_stop = False
Long il_incrementor=1

end variables

forward prototypes
public function boolean wf_1_getparts (string arg_spart)
public function boolean wf_findinerrdw (string as_parent, string as_component)
end prototypes

event ue_open;Int   	li_rows, &
	li_insrow, &
	li, &
	li_checkprocessed, &
	lk, &
	li_rowcnt,&
	li_current, &
	li_last 

String	ls_parent, &
	ls_part

Setpointer( HourGlass! )

ib_stop = False
dw_error.reset ()

dw_part_main.Reset()
dw_part_main.Retrieve()

If sqlca.sqlcode<>0 then
	Messagebox("System Error",'Unable to Retrieve data')
	return
End if 

li_last = dw_part_main.rowcount()
li_current=1
Do while (li_current<=li_last and not ib_stop)

	ls_parent=dw_part_main.getitemstring(li_current,'part')
	Yield() 
	il_incrementor=1
	dw_bom.reset ()
	dw_part_ext.reset()
	dw_parts.reset()  
	dw_bom.Insertrow(1)
	dw_bom.setitem ( 1, 1, ls_parent )
	dw_bom.setitem (1, 3, 1)
	dw_bom.setitem (1, 12, '-1-')
	dw_bom.setitem (1, 2, '1')
	setmicrohelp ( "Exploding Part : " + ls_parent ) 
	wf_1_getparts ( ls_parent )	
	
	li_checkprocessed = 1
	
	Do 
		li_rowcnt = dw_part_ext.rowcount()
		li_checkprocessed = dw_part_ext.find ( "processed='N'", li_checkprocessed, li_rowcnt )
		If li_checkprocessed <= 0 then
			Exit
		End if 
		ls_parent = dw_part_ext.getitemstring ( li_checkprocessed, 'part' )
		wf_1_getparts ( ls_parent )
		dw_part_ext.setitem( li_checkprocessed, 'processed', 'Y' )
		
	Loop While ( true ) 
	li_current ++

LOOP

if ib_stop then
	dw_bom.reset()
end if

setmicrohelp ( "Ready" ) 
	
Setpointer( Arrow! )
end event

event ue_print;If dw_error.rowcount() > 0 then
   setmicrohelp ( 'Printing error list..'  )
	dw_error.print( False )
	setmicrohelp ( 'Ready' )
End If
end event

event ue_save;dw_error.SaveAs ( 'error.txt', Text!, true )
setmicrohelp ( "Ready" ) 
end event

on ue_start;Triggerevent ( 'ue_open' )
end on

on ue_stop;ib_stop = true


end on

public function boolean wf_1_getparts (string arg_spart);Int i_rows, &
	 i_insrow, &
	 i, &
	 j, &
	 k, &
	 i_rowcnt, &
	 i_insrow_new, &
	 i_rowpos

LONG   l_count, &
	    l_found

STRING ls_part, &
       ls_rcv_parent, &
		 ls_tree, &
		 ls_tree1, &
		 ls_arow
		
Boolean b_returnvalue=true

ls_rcv_parent = arg_spart
i_rows = dw_parts.retrieve ( ls_rcv_parent )
k = dw_parts.find(  "part='"+ls_rcv_parent+"'",1,dw_parts.rowcount() )
if k > 0 then
//	if the parent part is found in the components
	if not (wf_findinerrdw(ls_rcv_parent, ls_rcv_parent)) then 
		l_error_level = dw_error.InsertRow(0)
		dw_error.setitem ( l_error_level, 1, ls_rcv_parent )
		dw_error.setitem ( l_error_level, 2, ls_rcv_parent )
	end if 	
	b_returnvalue = false
else
	if i_rows > 0 then 
//		Check if the part is found in the bom 		
		i_rowpos = dw_bom.find("part='"+ls_rcv_parent+"'",1,dw_bom.rowcount())
		if i_rowpos > 0  then 
			l_bom_level = dw_bom.getitemnumber(i_rowpos,'level')
			ls_tree1 = dw_bom.getitemstring(i_rowpos,'tree')		
			l_bom_level ++
		end if 
		i_rowcnt = dw_part_ext.rowcount()
		for i = 1 to i_rows
//			process all the component parts			
 			ls_part = dw_parts.getitemstring ( i, 'part' )
			k = dw_bom.find ( "part='"+ls_part+"'", 1, i_rowcnt )			
			if ( k > 0) then	
//				on finding the part in the bom, get the tree path, verify the position & decided whether
//				it's in a infinite loop or not
				ls_arow = '-'+trim(dw_bom.getitemstring(k, 2 )) +'-'
				l_count = PosA(ls_tree1, ls_arow)
			end if 	
			if l_count > 0 then 
				if not (wf_findinerrdw(ls_rcv_parent, ls_part)) then 				
					l_error_level = dw_error.InsertRow(0)
					dw_error.setitem ( l_error_level, 1, ls_rcv_parent )
					dw_error.setitem ( l_error_level, 2, ls_part )
				end if 	 
				b_returnvalue = false
				exit 
			else	
				i_insrow = dw_part_ext.insertrow(0)
				if i_insrow > 0 then 
					dw_part_ext.setitem(i_insrow,'row_no',dw_part_ext.rowcount())
					dw_part_ext.setitem(i_insrow,'parent_part',ls_rcv_parent)
					dw_part_ext.setitem(i_insrow,'part',ls_part)
					dw_part_ext.setitem(i_insrow,'processed','N')
	 				i_rowpos++				
					i_insrow_new = dw_bom.insertrow(i_rowpos)
					dw_bom.setitem(i_insrow_new, 1, ls_part)
					dw_bom.setitem(i_insrow_new, 3, l_bom_level)
					dw_bom.setitem(i_insrow_new, 6, ls_rcv_parent)
					il_incrementor ++
					ls_tree = trim(ls_tree1) + trim(string(il_incrementor)) +'-'
					dw_bom.setitem(i_insrow_new, 12, ls_tree)
					dw_bom.setitem(i_insrow_new,  2, trim(string(il_incrementor)))					 
				end if 	
			end if 	
		next 
	end if 
end if 
return (b_returnvalue)


end function

public function boolean wf_findinerrdw (string as_parent, string as_component);String ls_searchstr
Long il_row
ls_searchstr = "parent_part='"+as_parent+"' and component='"+as_component+"'"
il_row=dw_error.find(ls_searchstr, 1, dw_error.rowcount())
if il_row > 0 then
	return true
else
	return false
end if 	
end function

on w_bomcheck.create
this.dw_part_main=create dw_part_main
this.dw_part_ext=create dw_part_ext
this.dw_parts=create dw_parts
this.dw_error=create dw_error
this.dw_bom=create dw_bom
this.Control[]={this.dw_part_main,&
this.dw_part_ext,&
this.dw_parts,&
this.dw_error,&
this.dw_bom}
end on

on w_bomcheck.destroy
destroy(this.dw_part_main)
destroy(this.dw_part_ext)
destroy(this.dw_parts)
destroy(this.dw_error)
destroy(this.dw_bom)
end on

type dw_part_main from datawindow within w_bomcheck
int X=2446
int Y=984
int Width=494
int Height=360
int TabOrder=20
boolean Visible=false
string DataObject="d_part_main"
boolean LiveScroll=true
end type

on constructor;settransobject(sqlca)
end on

type dw_part_ext from datawindow within w_bomcheck
int X=73
int Y=872
int Width=1550
int Height=480
int TabOrder=30
boolean Visible=false
string DataObject="d_part_ext"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on constructor;dw_part_ext.settransobject(sqlca)

end on

type dw_parts from datawindow within w_bomcheck
int X=1819
int Y=988
int Width=494
int Height=360
int TabOrder=10
boolean Visible=false
string DataObject="d_parts"
boolean LiveScroll=true
end type

on constructor;dw_parts.settransobject(sqlca)

end on

type dw_error from datawindow within w_bomcheck
int X=1719
int Y=8
int Width=1531
int Height=1424
int TabOrder=50
string DataObject="d_error_list"
boolean TitleBar=true
string Title="Error List"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_bom from datawindow within w_bomcheck
int Y=8
int Width=1705
int Height=1424
int TabOrder=40
string DataObject="d_bom_ext"
boolean TitleBar=true
string Title="BOM Explosion"
boolean HScrollBar=true
boolean VScrollBar=true
boolean Resizable=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

