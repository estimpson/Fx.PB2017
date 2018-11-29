$PBExportHeader$w_dim_display.srw
forward
global type w_dim_display from Window
end type
type dw_5 from datawindow within w_dim_display
end type
type dw_4 from datawindow within w_dim_display
end type
type dw_3 from datawindow within w_dim_display
end type
type dw_2 from datawindow within w_dim_display
end type
type dw_1 from datawindow within w_dim_display
end type
end forward

global type w_dim_display from Window
int X=5
int Y=5
int Width=2935
int Height=1693
boolean TitleBar=true
string Title="Dimension setup"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_retrieve ( )
event ue_save ( )
event ue_delete ( )
event ue_exit ( )
dw_5 dw_5
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_dim_display w_dim_display

type variables
Boolean   i_b_dimcode_changed=false, &
                i_b_dimension_changed=false, &
                i_b_formula_changed=false, &
                i_b_unitdim_changed=false

String       i_s_current_dw='dw_1'               
end variables

forward prototypes
public subroutine wf_01_getdata (long arg_row)
end prototypes

event ue_retrieve;dw_1.retrieve()
If dw_1.Rowcount() < 1 then
	Messagebox("System Message","Parts are not setup")
	Close(this)
	Return
End if 
dw_1.setfocus()
end event

event ue_save;IF i_b_dimcode_changed THEN 
	i_b_dimcode_changed = false		
	dw_1.Update()
	IF sqlca.sqlcode = -1 THEN
		Messagebox("System Error","Updation Error ")
		Rollback ;
	ELSE
		Commit ;
	END IF 	
ELSEIF i_b_dimension_changed THEN 
	i_b_dimension_changed = false
	dw_2.Update()
	IF sqlca.sqlcode = -1 THEN
		Messagebox("System Error","Updation Error ")
		Rollback ;
	ELSE
		Commit ;
	END IF 	
ELSEIF i_b_formula_changed THEN 
	i_b_formula_changed = false
	dw_3.Update()
	IF sqlca.sqlcode = -1 THEN
	   Messagebox("System Error","Updation Error ")
		Rollback ;
	ELSE
		Commit ;
	END IF 	
ELSEIF i_b_unitdim_changed THEN 
	i_b_unitdim_changed = false	
	dw_5.Update()
	IF sqlca.sqlcode = -1 THEN
		Messagebox("System Error","Updation Error ")
		Rollback ;
	ELSE
		Commit ;
	END IF 	
END IF 	

end event

event ue_delete;Long l_l_rowno, &
     l_l_dw1currow, &
	  l_l_dw2currow, &
	  l_l_dw5currow
string l_s_dimcode,&
       l_s_columnone
If i_s_current_dw='dw_2' then
	l_l_dw2currow    = dw_2.getrow()
	l_l_dw1currow    = dw_1.getrow()				
	l_s_dimcode      = dw_1.object.dim_code[l_l_dw1currow]	
	l_s_columnone    = dw_2.object.dimension[l_l_dw2currow]
	l_l_rowno = dw_2.deleterow(l_l_dw2currow)
	If l_l_rowno < 1 then 
		messagebox("System Error","Unable to delete row")
		dw_2.Retrieve(l_s_dimcode)		
		Rollback ;
	Else
		l_l_rowno=dw_2.Update()
		If l_l_rowno < 1 then 
			messagebox("System Error","Unable to delete row")
			dw_2.Retrieve(l_s_dimcode)		
			Rollback ;
		Else
			Commit ;
		End if		
	End if 	
Elseif i_s_current_dw='dw_5' then
	l_l_dw5currow    = dw_5.getrow()
	l_l_dw1currow    = dw_1.getrow()				
	l_s_dimcode      = dw_1.object.dim_code[l_l_dw1currow]	
	l_s_columnone    = String(dw_5.object.unit_group[l_l_dw5currow])
	l_l_rowno = dw_5.deleterow(l_l_dw5currow)
	If l_l_rowno < 1 then 
		messagebox("System Error","Unable to delete row")
		dw_5.Retrieve(l_s_dimcode)		
		Rollback ;
	Else
		l_l_rowno=dw_5.Update()
		If l_l_rowno < 1 then 
			messagebox("System Error","Unable to delete row")
			dw_5.Retrieve(l_s_dimcode)		
			Rollback ;
		Else
			Commit ;
		End if		
	End if 	
End if 	

end event

event ue_exit;close(w_dim_display)
end event

public subroutine wf_01_getdata (long arg_row);String l_s_part, &
       l_s_dimcode
Int    l_i_userchoice=2		 
IF (i_b_dimcode_changed or i_b_dimension_changed or &
   i_b_formula_changed or i_b_unitdim_changed) THEN
	l_i_userchoice = Messagebox("System Message","Save Changes (y/n)",Question!,YesNo!,2) 
	IF l_i_userchoice = 1 THEN
		w_dim_display.triggerevent('ue_save')
	END IF 
END IF	
l_s_part    = dw_1.object.part[arg_row]
l_s_dimcode = dw_1.object.dim_code[arg_row]
dw_4.retrieve(l_s_part)
dw_2.retrieve(l_s_dimcode)
dw_3.retrieve(l_s_dimcode)
dw_5.retrieve(l_s_dimcode)
end subroutine

event open;triggerevent ('ue_retrieve')
end event

on w_dim_display.create
this.dw_5=create dw_5
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={ this.dw_5,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on w_dim_display.destroy
destroy(this.dw_5)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event activate;If gnv_App.of_GetFrame().MenuName <> "m_dimension_general" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_dimension_general )

end event

type dw_5 from datawindow within w_dim_display
event ue_key pbm_dwnkey
int X=1377
int Y=1133
int Width=1523
int Height=377
int TabOrder=21
string DataObject="d_unitdim"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;Long l_l_rowno, &
     l_l_dw1currow, &
	  l_l_dw2currow, & 
	  l_l_dw5currow
string l_s_dimcode, &
       l_s_columnone
l_l_dw5currow    = dw_5.getrow()
l_l_dw2currow    = dw_2.getrow()
l_l_dw1currow    = dw_1.getrow()				
l_s_dimcode      = dw_2.object.dim_code[l_l_dw2currow]	
IF Keydown(KeyDownArrow!) then
	IF (dw_5.Rowcount() = 0)  then 
		l_l_rowno     = dw_5.InsertRow(0)
		If l_l_rowno < 1 then
			Messagebox("System Error","Unable to insert row")
			dw_5.Retrieve(l_s_dimcode)
		Else
			dw_5.scrolltorow(l_l_rowno)
			dw_5.setitem(l_l_rowno,'unit_group',l_s_dimcode)
			i_b_unitdim_changed = true
		End if 	
	Else	
		l_s_columnone    = String(dw_5.object.sequence[l_l_dw5currow])		
		IF ((l_l_dw5currow = dw_5.RowCount()) and l_s_columnone > '') then
			l_l_rowno     = dw_5.InsertRow(0)
			If l_l_rowno < 1 then
				Messagebox("System Error","Unable to insert row")
				dw_5.Retrieve(l_s_dimcode)
			Else
				dw_5.scrolltorow(l_l_rowno)
				dw_5.setitem(l_l_rowno,'unit_group',l_s_dimcode)
			End if 	
		End if 	
	End if 	
End if 	
end event

event constructor;settransobject(sqlca)
end event

event itemchanged;this.Accepttext()
i_b_unitdim_changed = true
end event

event getfocus;i_s_current_dw = 'dw_5'
end event

type dw_4 from datawindow within w_dim_display
int X=1377
int Width=1523
int Height=377
int TabOrder=10
string DataObject="d_part_name"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event constructor;settransobject(sqlca)
end event

event getfocus;i_s_current_dw='dw_4'
end event

type dw_3 from datawindow within w_dim_display
event ue_key pbm_dwnkey
int X=1377
int Y=757
int Width=1523
int Height=377
int TabOrder=20
string DataObject="d_dim_formula"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;Long l_l_rowno, &
     l_l_dw1currow, &
	  l_l_dw2currow, &
	  l_l_dw3currow
string l_s_dimcode
l_l_dw3currow    = dw_3.getrow()
l_l_dw2currow    = dw_2.getrow()				
l_l_dw1currow    = dw_1.getrow()				
l_s_dimcode      = dw_2.object.dim_code[l_l_dw2currow]	
IF Keydown(KeyDownArrow!) then
	IF (dw_3.Rowcount() = 0) then 
		l_l_rowno     = dw_3.InsertRow(0)
		If l_l_rowno < 1 then
			Messagebox("System Error","Unable to insert row")
			dw_3.Retrieve(l_s_dimcode)
		Else
			dw_3.scrolltorow(l_l_rowno)
			dw_3.setitem(l_l_rowno,'dim_code',l_s_dimcode)
			i_b_formula_changed = true
		End if 	
	End if 	
End if 	
end event

event constructor;settransobject(sqlca)
end event

event editchanged;i_b_formula_changed = true
end event

event getfocus;i_s_current_dw='dw_3'
end event

type dw_2 from datawindow within w_dim_display
event ue_key pbm_dwnkey
int X=1377
int Y=377
int Width=1523
int Height=381
int TabOrder=40
string DataObject="d_dim_lstng"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;Long l_l_rowno, &
     l_l_dw1currow, &
	  l_l_dw2currow
string l_s_dimcode,&
       l_s_columnone
l_l_dw2currow    = dw_2.getrow()
l_l_dw1currow    = dw_1.getrow()				
l_s_dimcode      = ''
//l_s_dimcode      = dw_1.object.dim_code[l_l_dw1currow]	
IF Keydown(KeyDownArrow!) then
	IF (dw_2.Rowcount() = 0 ) then 
		l_l_rowno     = dw_2.InsertRow(0)
		If l_l_rowno < 1 then
			Messagebox("System Error","Unable to insert row")
			dw_2.Retrieve(l_s_dimcode)
		Else
			dw_2.scrolltorow(l_l_rowno)
       	i_b_dimension_changed = true			
//			dw_2.setitem(l_l_rowno,'dim_code',l_s_dimcode)
		End if 	
   Else
		l_s_columnone      = dw_2.object.dimension[l_l_dw2currow]		
		IF ((l_l_dw2currow = dw_2.RowCount()) and l_s_columnone > '') then
         l_s_dimcode     = dw_2.object.dim_code[l_l_dw2currow]				    
			l_l_rowno       = dw_2.InsertRow(0)
			If l_l_rowno < 1 then
				Messagebox("System Error","Unable to insert row")
				dw_2.Retrieve(l_s_dimcode)
			Else
				dw_2.scrolltorow(l_l_rowno)
				dw_2.setitem(l_l_rowno,'dim_code',l_s_dimcode)
        	   i_b_dimension_changed = true							
			End if 	
		End if 	
	End if 	
End if 	
end event

event constructor;settransobject(sqlca)
end event

event itemchanged;this.Accepttext()
if dw_2.object.varying_dimension[row] < 0 or  &
   dw_2.object.varying_dimension[row] > 1 then
	Messagebox("System Error","Valid varying dimensions are 1/0")
	dw_2.setcolumn(4)
else
	i_b_dimension_changed = true
end if 	
end event

event getfocus;i_s_current_dw = 'dw_2'
end event

type dw_1 from datawindow within w_dim_display
int Width=1377
int Height=1509
int TabOrder=30
string DataObject="d_part_inv"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemfocuschanged;wf_01_getdata(row)
end event

event itemchanged;i_b_dimcode_changed = true
end event

event getfocus;i_s_current_dw = 'dw_1'
end event

event constructor;settransobject(sqlca)
end event

