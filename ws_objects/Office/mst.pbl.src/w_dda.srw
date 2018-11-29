$PBExportHeader$w_dda.srw
forward
global type w_dda from Window
end type
type st_1 from statictext within w_dda
end type
type em_1 from editmask within w_dda
end type
type cb_close from commandbutton within w_dda
end type
type cb_compute from commandbutton within w_dda
end type
type cb_cancel from commandbutton within w_dda
end type
type cb_save from commandbutton within w_dda
end type
type dw_dda_qty from datawindow within w_dda
end type
type dw_dda from datawindow within w_dda
end type
end forward

global type w_dda from Window
int X=315
int Y=620
int Width=2341
int Height=760
boolean TitleBar=true
string Title="Dimensional Data"
long BackColor=77897888
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="MONITOR.ICO"
st_1 st_1
em_1 em_1
cb_close cb_close
cb_compute cb_compute
cb_cancel cb_cancel
cb_save cb_save
dw_dda_qty dw_dda_qty
dw_dda dw_dda
end type
global w_dda w_dda

type variables
string                   sz_part, &
                           sz_qtystring, &
                           sz_module, &
                           sz_formula_type, &
                           sz_originalstr, &
                           sz_dimcode

dec                     ld_result1, &
                           ld_qty, &
                           ld_std_qty[],&
                           ld_originalqty

st_dda_parmlist   st_parmlist

boolean               b_dimcode_atched = true

Integer                 ll_nonconstantdim

end variables

forward prototypes
public subroutine wf_1_get_dimcode (string arg_s_part)
public function decimal wf_2_calculate ()
end prototypes

public subroutine wf_1_get_dimcode (string arg_s_part);String sz_dimn, &
       sz_temp   
Int    li_rws, &
       li_ctr, &
		 li_totalrow, &
		 li_newrow, &
		 li_pos, &
		 li_start=1, &
       li_vary_dimension		 
Dec    ld_dim_std_qty, &
       ld_storedno[]
SELECT dim_code 
  INTO :sz_dimcode
  FROM part_inventory 
 WHERE part = :arg_s_part ;
if sqlca.sqlcode = 0 then
   if isnull(sz_dimcode) = false then 
		li_rws = dw_dda.retrieve(sz_dimcode)
		if li_rws > 0 then
			li_totalrow = dw_dda.rowcount()
			li_start = 1
			for li_ctr = 1 to li_rws
				 li_pos = PosA(sz_qtystring,',',li_start)
				 If li_pos > 0 then
					 sz_temp = MidA(sz_qtystring,li_start, (li_pos - 1))
				 	 ld_storedno[li_ctr] = Dec(sz_temp)
				    li_start = li_pos + 1 
				 Else	 
					 If li_start > 1 then 
						 sz_temp = MidA(sz_qtystring,li_start,(li_start - 1))
				 	    ld_storedno[li_ctr] = Dec(sz_temp)
					 else
					 	 ld_storedno[li_ctr] = 0.0
					 End if 	  
				 End if 
		 		 sz_dimn 		     = dw_dda.object.dimension[li_ctr]
				 li_vary_dimension  = dw_dda.object.varying_dimension[li_ctr] 
		 		 ld_dim_std_qty     = dw_dda.object.dim_qty[li_ctr]					  
				 ld_std_qty[li_ctr] = ld_dim_std_qty
				 li_newrow = dw_dda_qty.insertrow(0)
				 if li_newrow > 0  then 
					 dw_dda_qty.scrolltorow(li_newrow)	
					 dw_dda_qty.setitem(li_newrow,'dimension',sz_dimn)
					 if li_vary_dimension = 0 then 
  				       if (ld_qty > 0 or not isnull(ld_qty)) then 
					 		 ld_dim_std_qty     = ld_qty
		 				 end if 	  
						 dw_dda_qty.setitem(li_newrow,'Qty',ld_dim_std_qty)
//						 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_dim_std_qty),'4',sz_module))
						 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_dim_std_qty),'4',sz_dimcode))	
					 else	 
						 ll_nonconstantdim = li_vary_dimension
						 if upperbound(ld_storedno) > 0 then 
							 dw_dda_qty.setitem(li_newrow,'Qty',ld_storedno[li_ctr])
//							 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_storedno[li_ctr]),'4',sz_module))
							 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_storedno[li_ctr]),'4',sz_dimcode))
						else
							 dw_dda_qty.setitem(li_newrow,'Qty',0)
							 dw_dda_qty.setitem(li_newrow,'dim_text',"")						 
						end if 							
	  				 end if 						
					 dw_dda_qty.setitem(li_newrow,'dim_std_Qty',ld_dim_std_qty)
					 dw_dda_qty.setitem(li_newrow,'units',sz_module)
				 end if 
			next 
		end if
		dw_dda_qty.visible = true
		dw_dda_qty.scrolltorow(1)
		dw_dda_qty.setfocus()
	else
		b_dimcode_atched = false
	end if 
end if
end subroutine

public function decimal wf_2_calculate ();Int li_totalrows, &
    li_currentrow    
	
Dec ld_currentvalue, &
    ld_result=0
	 
String ls_createsyntax, &
       ls_insertsyntax, & 
		 ls_newsyntax, &
		 ls_dropsyntax, & 
		 ls_formula, &
       ls_column, &
		 err
	
Datastore ld_datastore1	

li_totalrows=dw_dda_qty.Rowcount()

If li_totalrows > 0 then 
	
	// building the syntax to create a table to store the result
	// 1 from here
	
	ls_createsyntax='CREATE TABLE dimresult (result Numeric(10,2))'
	
	SQLCA.autocommit = True
	Execute Immediate :ls_createsyntax ;
	SQLCA.autocommit = False
	
	// till here (1) 
	
	// Building the syntax to create the table from the user defined
	// columns
	// 2 from here
	
	ls_createsyntax='CREATE TABLE dimtemp ('
	For li_currentrow = 1 to li_totalrows
		 ls_column = dw_dda_qty.object.dimension[li_currentrow]
		 ls_createsyntax += ls_column + ' Numeric(6,2) Null'
		 If li_currentrow < li_totalrows then 
			 ls_createsyntax += ', '
		 else	 
			ls_createsyntax += ' )'
		 end if 	
	Next 
	
	SQLCA.autocommit = True
	Execute Immediate :ls_createsyntax ;
	SQLCA.autocommit = False
	
	// till here (2) 
	
	// building the syntax to insert the values entered by the user
	// 3 from here
	
	ls_insertsyntax = 'INSERT INTO dimtemp ('
	For li_currentrow = 1 to li_totalrows
		 ls_column = dw_dda_qty.object.dimension[li_currentrow]
		 ls_insertsyntax += ls_column 
		 If li_currentrow < li_totalrows then 
			 ls_insertsyntax += ', '
 		 else
			 ls_insertsyntax += ') '			
		 end if 	
	Next 
	
	ls_insertsyntax += " VALUES ( "
	
	For li_currentrow = 1 to li_totalrows
		 ld_currentvalue = dw_dda_qty.object.qty[li_currentrow]
		 ls_insertsyntax += String(round(ld_currentvalue,2))
		 If li_currentrow < li_totalrows then 
			 ls_insertsyntax += ', '
		 else	 
			 ls_insertsyntax += ')'
		 end if 	
	Next 
	
	SQLCA.autocommit = True
	Execute Immediate :ls_insertsyntax ;
	SQLCA.autocommit = False
	
	// till here 3
	
	// retrieving the user defined formula from the table
	// 4 from here
	
	SELECT relationship
	  INTO :ls_formula
	  FROM dim_relation
	 WHERE (dim_code = :sz_dimcode);
   // till here 4
	
	// Building the syntax to insert rows into the result table
	// 5 from here 
	
   ls_newsyntax = "INSERT INTO dimresult ( result ) " &
				 	 + "SELECT "+ls_formula+" FROM dimtemp" 
					  
	SQLCA.autocommit = True					  
	Execute Immediate :ls_newsyntax ;	
	SQLCA.autocommit = False
	
	// till here 5

	// Creating a datastore to extract the value from the result table
	// 6 from here
	ld_datastore1 = CREATE DataStore
	ls_createsyntax = "SELECT result FROM dimresult" 
	ls_insertsyntax = SQLCA.SyntaxFromSQL(ls_createsyntax, "", err)
	ld_datastore1.Create( ls_insertsyntax, err)
	ld_datastore1.settransobject(sqlca)
	ld_datastore1.retrieve()
	ld_result = ld_datastore1.object.#1[1]
	Destroy ld_datastore1
	// Till here 6
	
	// Deleting the temprory tables from the database
	// 7 from here 
	ls_dropsyntax = "DROP TABLE dimtemp ;"
	SQLCA.autocommit = True
	Execute Immediate :ls_dropsyntax ;
	SQLCA.autocommit = False
	ls_dropsyntax = "DROP TABLE dimresult ;"
	SQLCA.autocommit = True
	Execute Immediate :ls_dropsyntax ;
	SQLCA.autocommit = False
	// till here 7 
	
End if 
RETURN ld_result
end function

event open;st_parmlist  = Message.Powerobjectparm
sz_part      = st_parmlist.s_arg_part
sz_module    = st_parmlist.s_arg_module
sz_qtystring = st_parmlist.s_rtn_qtystr
ld_qty       = st_parmlist.s_rtn_qty
ll_nonconstantdim = st_parmlist.s_varying_dim

if IsNull(sz_qtystring) then sz_qtystring=""
if IsNull(ld_qty) 		then ld_qty=0
ld_result1    = ld_qty
wf_1_get_dimcode(sz_part)

If ld_qty > 0 then em_1.text = String(ld_qty)

if b_dimcode_atched then 
 	w_dda.visible 		 = true
	cb_compute.visible = true
	cb_cancel.visible  = true
	cb_close.visible   = true
Else
 	w_dda.visible 		 = false
	cb_compute.visible = false
	cb_cancel.visible  = false
	cb_close.visible   = false
   Closewithreturn(w_dda,st_parmlist)
End if
end event

on close;cb_close.triggerevent(Clicked!)
end on

on w_dda.create
this.st_1=create st_1
this.em_1=create em_1
this.cb_close=create cb_close
this.cb_compute=create cb_compute
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_dda_qty=create dw_dda_qty
this.dw_dda=create dw_dda
this.Control[]={this.st_1,&
this.em_1,&
this.cb_close,&
this.cb_compute,&
this.cb_cancel,&
this.cb_save,&
this.dw_dda_qty,&
this.dw_dda}
end on

on w_dda.destroy
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_close)
destroy(this.cb_compute)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_dda_qty)
destroy(this.dw_dda)
end on

type st_1 from statictext within w_dda
int X=782
int Y=548
int Width=997
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Quantity based on the above data"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_dda
int X=256
int Y=548
int Width=366
int Height=100
int TabOrder=40
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_dda
int X=2007
int Y=288
int Width=293
int Height=96
int TabOrder=70
string Text="Enter"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;st_parmlist.s_rtn_qtystr    = sz_qtystring
st_parmlist.s_rtn_qty       = ld_result1
if isnull(ll_nonconstantdim) then ll_nonconstantdim = 1
st_parmlist.s_varying_dim   = ll_nonconstantdim
closewithreturn(w_dda,st_parmlist)

end event

type cb_compute from commandbutton within w_dda
event ue_save pbm_custom01
int X=2007
int Y=20
int Width=293
int Height=96
int TabOrder=20
string Text="Compute"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;cb_save.Triggerevent(clicked!)

ld_result1 = wf_2_calculate()
em_1.text = ""
em_1.text = String(ld_result1)	

end event

type cb_cancel from commandbutton within w_dda
int X=2007
int Y=156
int Width=293
int Height=96
int TabOrder=50
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sz_qtystring = st_parmlist.s_rtn_qtystr
ld_result1   = st_parmlist.s_rtn_qty
closewithreturn(w_dda,st_parmlist)



end event

type cb_save from commandbutton within w_dda
int X=768
int Y=384
int Width=293
int Height=112
int TabOrder=60
boolean Visible=false
string Text="&Save"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int i_currow,i_totrow,i_len,i_pos
dec d_qty 

// Storing the data as a string 
i_totrow = dw_dda_qty.rowcount()
if i_totrow > 0 then 
	sz_qtystring = ""
	for i_currow = 1 to i_totrow 
		 d_qty = dw_dda_qty.getitemdecimal(i_currow,'qty')
		 if d_qty <> 0 then 
			 sz_qtystring = trim(sz_qtystring) + trim(string(d_qty)) + ','	 
		 end if 
	next	
	i_len = LenA(trim(sz_qtystring))
 	if RightA(trim(sz_qtystring),1) = ',' then
		sz_qtystring = LeftA(sz_qtystring,(i_len - 1))
	end if 
end if 

end on

type dw_dda_qty from datawindow within w_dda
event ue_key pbm_dwnkey
int X=18
int Width=1961
int Height=512
int TabOrder=10
string DataObject="d_dyna_qty"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event ue_key;IF keydown(KeyTab!) then 
	Int li_dotpos, &
	    li_rowpos
	String ls_returnstr
	ls_returnstr = ""
	li_rowpos = dw_dda_qty.getrow()
	dw_dda_qty.accepttext()
   if dw_dda_qty.getcolumnname() = 'qty' then
		ls_returnstr = string(dw_dda_qty.object.qty[li_rowpos])
	else
		ls_returnstr = string(dw_dda_qty.object.dim_text[li_rowpos])
	end if 
	if ls_returnstr <> ""  then 
		li_dotpos = PosA(ls_returnstr,'.')
		if li_dotpos = 0 then 
			dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
//			ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
			ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)			
			dw_dda_qty.setitem(li_rowpos,'qty',dec(ls_returnstr))
		else
			dw_dda_qty.setitem(li_rowpos,'qty',dec(ls_returnstr))
//			ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
			ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)			
			dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
		end if 
//		li_rowpos++			
		dw_dda_qty.scrolltorow(li_rowpos)		
	end if 
end if 
end event

on losefocus;This.AcceptText()
end on

on constructor;dw_dda_qty.settransobject(sqlca)
end on

type dw_dda from datawindow within w_dda
int X=37
int Y=448
int Width=494
int Height=360
int TabOrder=30
boolean Visible=false
string DataObject="d_dda"
boolean LiveScroll=true
end type

on constructor;dw_dda.settransobject(sqlca)
end on

