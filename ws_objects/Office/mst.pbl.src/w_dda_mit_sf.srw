$PBExportHeader$w_dda_mit_sf.srw
forward
global type w_dda_mit_sf from Window
end type
type st_balance from statictext within w_dda_mit_sf
end type
type em_balance_unit from editmask within w_dda_mit_sf
end type
type st_exist from statictext within w_dda_mit_sf
end type
type em_current_unit from editmask within w_dda_mit_sf
end type
type em_exist_unit from editmask within w_dda_mit_sf
end type
type cb_blank from commandbutton within w_dda_mit_sf
end type
type cb_enter from commandbutton within w_dda_mit_sf
end type
type cb_clear from commandbutton within w_dda_mit_sf
end type
type cb_dumy1 from commandbutton within w_dda_mit_sf
end type
type cb_inche from commandbutton within w_dda_mit_sf
end type
type cb_feet from commandbutton within w_dda_mit_sf
end type
type cb_dumy from commandbutton within w_dda_mit_sf
end type
type cb_dot from commandbutton within w_dda_mit_sf
end type
type cb_0 from commandbutton within w_dda_mit_sf
end type
type cb_9 from commandbutton within w_dda_mit_sf
end type
type cb_8 from commandbutton within w_dda_mit_sf
end type
type cb_7 from commandbutton within w_dda_mit_sf
end type
type cb_6 from commandbutton within w_dda_mit_sf
end type
type cb_5 from commandbutton within w_dda_mit_sf
end type
type cb_4 from commandbutton within w_dda_mit_sf
end type
type cb_3 from commandbutton within w_dda_mit_sf
end type
type cb_2 from commandbutton within w_dda_mit_sf
end type
type cb_1 from commandbutton within w_dda_mit_sf
end type
type em_3 from editmask within w_dda_mit_sf
end type
type em_2 from editmask within w_dda_mit_sf
end type
type st_1 from statictext within w_dda_mit_sf
end type
type dw_remaining from datawindow within w_dda_mit_sf
end type
type dw_existing from datawindow within w_dda_mit_sf
end type
type em_1 from editmask within w_dda_mit_sf
end type
type cb_close from commandbutton within w_dda_mit_sf
end type
type cb_compute from commandbutton within w_dda_mit_sf
end type
type cb_cancel from commandbutton within w_dda_mit_sf
end type
type cb_save from commandbutton within w_dda_mit_sf
end type
type dw_dda_qty from datawindow within w_dda_mit_sf
end type
type dw_dda from datawindow within w_dda_mit_sf
end type
end forward

global type w_dda_mit_sf from Window
int X=5
int Y=160
int Width=2935
int Height=1740
long BackColor=77897888
WindowType WindowType=response!
string Icon="MONITOR.ICO"
st_balance st_balance
em_balance_unit em_balance_unit
st_exist st_exist
em_current_unit em_current_unit
em_exist_unit em_exist_unit
cb_blank cb_blank
cb_enter cb_enter
cb_clear cb_clear
cb_dumy1 cb_dumy1
cb_inche cb_inche
cb_feet cb_feet
cb_dumy cb_dumy
cb_dot cb_dot
cb_0 cb_0
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
em_3 em_3
em_2 em_2
st_1 st_1
dw_remaining dw_remaining
dw_existing dw_existing
em_1 em_1
cb_close cb_close
cb_compute cb_compute
cb_cancel cb_cancel
cb_save cb_save
dw_dda_qty dw_dda_qty
dw_dda dw_dda
end type
global w_dda_mit_sf w_dda_mit_sf

type variables
string                              sz_part, &
                                      sz_qtystring, &
                                      sz_module, &
                                      sz_formula_type, &
                                      sz_originalstr, &
                                      sz_remainstr, &
                                      sz_nonconstantdim='', &
                                      sz_originalunit, &
                                      sz_org_str[], &
                                      sz_is_field, &
                                      sz_dimcode

dec                                ld_result1, &
                                      ld_result2, &
                                      ld_qty, &
                                      ld_std_qty[], &
                                      ld_org_value[], &
                                      ld_originalqty, &
                                      ld_remainqty

st_dda_parmlist_mit_sf   st_parmlist

boolean                          b_dimcode_atched = true, &
                                       b_tabkeypressed = false

long                                ll_dimension_code

end variables

forward prototypes
public subroutine wf_1_get_dimcode (string arg_s_part)
public subroutine wf_2_breakupqty ()
public subroutine wf_3_keypressed (string arg_character)
public subroutine wf_4_tabkey ()
public function decimal wf_2_calculate ()
end prototypes

public subroutine wf_1_get_dimcode (string arg_s_part);String sz_dimn, &
		 sz_temp, &
		 sz_temp1
		 
Int    li_rws, &
		 li_ctr, &
		 li_totalrow,&
		 li_newrow, &
		 li_existnewrow, &
		 li_remainnewrow, &
		 li_pos=0, &
		 li_start=1, &
		 li_pos1=0, &
		 li_start1=1
		 
Dec    ld_dim_std_qty, &
		 ld_storedno[]
		 
Int    li_default_vary_dim

SELECT dim_code 
  INTO :sz_dimcode
  FROM part_inventory 
 WHERE part = :arg_s_part ;

IF sqlca.sqlcode = 0 then  // On finding the row
   IF isnull(sz_dimcode) = false then  // if dim code is not null
		li_rws = dw_dda.retrieve(sz_dimcode)
		IF li_rws > 0 then      // if no. of rows is greater 
			li_totalrow = dw_dda.rowcount()
			li_start = 1
			li_start1= 1
			FOR li_ctr = 1 to li_rws
				 // this if for the entered string 
				 li_pos = PosA(sz_qtystring,',',li_start)
				 IF li_pos > 0 then
					 sz_temp = MidA(sz_qtystring,li_start,(li_pos - 1))
				 	 ld_storedno[li_ctr] = Dec(sz_temp)
				    li_start = li_pos + 1 
				 ELSE
					 if li_start > 1 then 
						 sz_temp = MidA(sz_qtystring,li_start,(LenA(sz_qtystring) - li_start))
						 ld_storedno[li_ctr] = Dec(sz_temp)
					 else
						 ld_storedno[li_ctr] = 0.0						
					 end if 	
				 END IF 
				 // for the original string from the object table
				 li_pos1 = PosA(sz_originalstr,',',li_start1)
				 IF li_pos1 > 0 then
					 sz_temp1 = MidA(sz_originalstr,li_start1,(li_pos1 - 1))
				 	 ld_org_value[li_ctr] = Dec(sz_temp1)
//				 	 sz_org_str[li_ctr]   = f_bk_cb_unit(sz_temp1,'4',sz_module)
				 	 sz_org_str[li_ctr]   = f_bk_cb_unit(sz_temp1,'4',sz_dimcode)
				    li_start1 = li_pos1 + 1 
				 ELSE	 
					 if li_start1 > 2 then 
						 sz_temp1 = MidA(sz_originalstr,li_start1, (LenA(sz_originalstr) - li_start1))
					 	 ld_org_value[li_ctr] = Dec(sz_temp1)
//					 	 sz_org_str[li_ctr]   = f_bk_cb_unit(sz_temp1,'4',sz_module)
					 	 sz_org_str[li_ctr]   = f_bk_cb_unit(sz_temp1,'4',sz_dimcode)						  
					 else
						 ld_org_value[li_ctr] = 0.0
					 	 sz_org_str[li_ctr]   = ""
					 end if 						
				 End if 
				 sz_dimn 		      = dw_dda.getitemstring(li_ctr,'dimension')
		 		 ld_dim_std_qty      = dw_dda.getitemdecimal(li_ctr,'dim_qty')
				 li_default_vary_dim = dw_dda.getitemnumber(li_ctr,'varying_dimension') 
				 ld_std_qty[li_ctr]  = ld_dim_std_qty
				 li_newrow = dw_dda_qty.insertrow(0)
				 if li_newrow > 0  then 
					 dw_dda_qty.scrolltorow(li_newrow)	
					 dw_dda_qty.setitem(li_newrow,'dimension',sz_dimn)
					 if li_default_vary_dim = 0 then
						 if (ld_qty > 0 and not isnull(ld_qty))then
							 ld_dim_std_qty = ld_qty
						 end if 	 
//						 dw_dda_qty.setitem(li_newrow,'Qty',round(ld_org_value[li_ctr],2))
//	 					 dw_dda_qty.setitem(li_newrow,'qty_str',String(round(ld_org_value[li_ctr],2)))
						 dw_dda_qty.setitem(li_newrow,'Qty',round(ld_dim_std_qty,2))
	 					 dw_dda_qty.setitem(li_newrow,'qty_str',String(round(ld_dim_std_qty,2)))
						 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_dim_std_qty),'4',sz_dimcode))
 					 else
						 if upperbound(ld_storedno) > 0 then 
							 dw_dda_qty.setitem(li_newrow,'Qty',ld_storedno[li_ctr])
							 dw_dda_qty.setitem(li_newrow,'Qty_str',string(ld_storedno[li_ctr]))
//							 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_storedno[li_ctr]),'4',sz_module))
							 dw_dda_qty.setitem(li_newrow,'dim_text',f_bk_cb_unit(string(ld_storedno[li_ctr]),'4',sz_dimcode))							 
 						 else
							 dw_dda_qty.setitem(li_newrow,'Qty',0)
							 dw_dda_qty.setitem(li_newrow,'qty_str',"")
							 dw_dda_qty.setitem(li_newrow,'dim_text',"")						 
						 end if 							
 					 end if 	 
					 dw_dda_qty.setitem(li_newrow,'dim_std_Qty',ld_dim_std_qty)
					 dw_dda_qty.setitem(li_newrow,'units',sz_module)
					 dw_dda_qty.setitem(li_newrow,'keep_it_std',Trim(String(li_default_vary_dim)))			 
				 end if 

				 li_existnewrow = dw_existing.insertrow(0)
				 if li_existnewrow > 0  then 
					 dw_existing.scrolltorow(li_existnewrow)	
					 dw_existing.setitem(li_existnewrow,'dimension',sz_dimn)
					 dw_existing.setitem(li_existnewrow,'Quantity',ld_org_value[li_ctr])
					 dw_existing.setitem(li_existnewrow,'units',sz_originalunit)
					 dw_existing.setitem(li_existnewrow,'dim_qty_str',sz_org_str[li_ctr])
					 dw_existing.setitem(li_existnewrow,'keep_it_std',Trim(String(li_default_vary_dim)))			 
					 em_2.text = String(ld_originalqty)
				 end if 

				 li_remainnewrow = dw_remaining.insertrow(0)
				 if li_remainnewrow > 0  then 
					 dw_remaining.scrolltorow(li_remainnewrow)	
					 dw_remaining.setitem(li_existnewrow,'dimension',sz_dimn)					 
					 dw_remaining.setitem(li_remainnewrow,'Quantity',0)
					 dw_remaining.setitem(li_remainnewrow,'units',sz_module)
				 end if 
			next 
		end if
//		dw_dda_qty.visible = true
//		dw_dda_qty.scrolltorow(1)
//		dw_dda_qty.setfocus()
	else
		b_dimcode_atched = false
	end if 
end if
end subroutine

public subroutine wf_2_breakupqty ();// pre-requisite is declare a decimal array of 2 d_org_value & a
// string array of 2 s_org_str in the calling program. should be a instance
// variable 

String ls_orgdimstr, &
       ls_str1, &
		 ls_str2
		 
Int    li_pos,&
       li_pos1, &
		 li_remain

ls_orgdimstr = trim(sz_originalstr)

li_pos = PosA(ls_orgdimstr,',',1)

if li_pos > 0 then
	ls_str1 = LeftA(ls_orgdimstr, (li_pos - 1))
	li_remain = LenA(ls_orgdimstr) - li_pos 
	
	ls_str2 = RightA(ls_orgdimstr, li_remain)
	
	ld_org_value[1]= dec(ls_str1)
	ld_org_value[2]= dec(ls_str2)
	
//	sz_org_str[1] = f_bk_cb_unit(ls_str1,'4',sz_module)
//	sz_org_str[2] = f_bk_cb_unit(ls_str2,'4',sz_module)
	
	sz_org_str[1] = f_bk_cb_unit(ls_str1,'4',sz_dimcode)
	sz_org_str[2] = f_bk_cb_unit(ls_str2,'4',sz_dimcode)	
	
ELSE
	ld_org_value ={0,0}
   sz_org_str ={'',''}	
end if	

end subroutine

public subroutine wf_3_keypressed (string arg_character);String szPreviousText, &
       szpreviousvalue, &
		 szcurcolumn, &
		 sztemp
		 
Long   ll_rowno

Int    li_len

ll_rowno = dw_dda_qty.getrow()
szcurcolumn = dw_dda_qty.getcolumnname()
Choose Case sz_is_field
		Case "qty_str"
			  szpreviousvalue= dw_dda_qty.getitemstring(ll_rowno,'qty_str')			
			  if isnull(szpreviousvalue) then szpreviousvalue=""			  
			  if arg_character <> 'B' then
 	           szpreviousvalue += arg_character
 			  else
				  sztemp = szpreviousvalue
				  szpreviousvalue =""
  			     li_len = LenA(sztemp)
				  if li_len > 1 then 
					  szpreviousvalue = LeftA(sztemp,(li_len - 1))
				  else 	  
  	  			     szpreviousvalue =""
  				  end if 		
			  end if	  
           dw_dda_qty.setitem(ll_rowno,'qty_str',szpreviousvalue)			  
		Case "dim_text"
			  szprevioustext = dw_dda_qty.getitemstring(ll_rowno,'dim_text')
			  if isnull(szprevioustext) then szprevioustext=""			
			  if arg_character <> 'B' then 
	           szprevioustext += arg_character
 			  else
				  sztemp = szprevioustext
				  szprevioustext =""
  			     li_len = LenA(sztemp)
				  if li_len > 1 then 
					  szprevioustext = LeftA(sztemp,(li_len - 1))
				  else 	  
					  szprevioustext = ""
 				  end if 	  
			  end if	  
    	     dw_dda_qty.setitem(ll_rowno,'dim_text',szprevioustext)             			  			  
End Choose
dw_dda_qty.setfocus()
dw_dda_qty.setcolumn(szcurcolumn)

end subroutine

public subroutine wf_4_tabkey ();Int	 li_dotpos, &
	    li_rowpos
		 
String ls_returnstr,& 
       ls_constant
		 
Dec 	 ld_temp

Long 	 ll_find

ls_returnstr = ""
dw_dda_qty.Accepttext()
li_rowpos = dw_dda_qty.getrow()
ll_find = dw_existing.find("keep_it_std='1'",1,dw_existing.rowcount())
if ll_find > 0 then
	ls_constant = dw_existing.getitemstring(li_rowpos,'keep_it_std')
	ld_temp    = dw_existing.getitemdecimal(li_rowpos,'quantity')
   if ls_constant = '1' then
		ll_dimension_code = Integer(ls_constant)
		dw_dda_qty.accepttext()
	   if dw_dda_qty.getcolumnname() = 'qty_str' then
			ls_returnstr = 	dw_dda_qty.getitemstring(li_rowpos,'qty_str')
		else
			ls_returnstr = 	dw_dda_qty.getitemstring(li_rowpos,'dim_text')
		end if 
		if ls_returnstr <> ""  then 
			li_dotpos = PosA(ls_returnstr,'.')
			if li_dotpos = 0 then 
				dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
//				ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
				ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)
				ld_temp = round(dec(ls_returnstr),2)
				dw_dda_qty.setitem(li_rowpos,'qty',ld_temp)
				dw_dda_qty.setitem(li_rowpos,'qty_str',string(ld_temp))			
			else
				dw_dda_qty.setitem(li_rowpos,'qty',dec(ls_returnstr))
				dw_dda_qty.setitem(li_rowpos,'qty_str',ls_returnstr)			
//				ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
				ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)
				dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
			end if 
			li_rowpos++			
			dw_dda_qty.scrolltorow(li_rowpos)		
			cb_enter.setfocus()
		end if 
   end if 
End if 	
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
		 ld_currentvalue = Dec(dw_dda_qty.object.qty_str[li_currentrow])
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

event open;string s_dda

st_parmlist = Message.Powerobjectparm

sz_part      = st_parmlist.s_arg_part
sz_module    = st_parmlist.s_arg_module
sz_qtystring = st_parmlist.s_rtn_qtystr
ld_qty       = st_parmlist.s_rtn_qty

sz_originalunit= st_parmlist.s_parent_unit
ld_originalqty = Dec(st_parmlist.s_parent_qty)
sz_originalstr = st_parmlist.s_parent_dimqtystr
ll_dimension_code= st_parmlist.s_nonconstantdim

if IsNull(sz_qtystring) then sz_qtystring=""
if IsNull(ld_qty) 		then ld_qty=0
ld_result1    = ld_qty

em_exist_unit.text   = sz_module
em_current_unit.text = sz_module
em_balance_unit.text = sz_module		
	
wf_1_get_dimcode(sz_part)

if b_dimcode_atched  then 
 	w_dda_mit_sf.visible = true
	cb_compute.visible = true
	cb_cancel.visible  = true
	cb_close.visible   = true
else	
	w_dda_mit_sf.visible = False
	cb_compute.visible = False
	cb_cancel.visible  = False
	cb_close.visible   = False
	Closewithreturn(w_dda_mit_sf,st_parmlist)
end if 	


end event

on close;cb_close.triggerevent(Clicked!)
end on

on w_dda_mit_sf.create
this.st_balance=create st_balance
this.em_balance_unit=create em_balance_unit
this.st_exist=create st_exist
this.em_current_unit=create em_current_unit
this.em_exist_unit=create em_exist_unit
this.cb_blank=create cb_blank
this.cb_enter=create cb_enter
this.cb_clear=create cb_clear
this.cb_dumy1=create cb_dumy1
this.cb_inche=create cb_inche
this.cb_feet=create cb_feet
this.cb_dumy=create cb_dumy
this.cb_dot=create cb_dot
this.cb_0=create cb_0
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_3=create em_3
this.em_2=create em_2
this.st_1=create st_1
this.dw_remaining=create dw_remaining
this.dw_existing=create dw_existing
this.em_1=create em_1
this.cb_close=create cb_close
this.cb_compute=create cb_compute
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.dw_dda_qty=create dw_dda_qty
this.dw_dda=create dw_dda
this.Control[]={this.st_balance,&
this.em_balance_unit,&
this.st_exist,&
this.em_current_unit,&
this.em_exist_unit,&
this.cb_blank,&
this.cb_enter,&
this.cb_clear,&
this.cb_dumy1,&
this.cb_inche,&
this.cb_feet,&
this.cb_dumy,&
this.cb_dot,&
this.cb_0,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.em_3,&
this.em_2,&
this.st_1,&
this.dw_remaining,&
this.dw_existing,&
this.em_1,&
this.cb_close,&
this.cb_compute,&
this.cb_cancel,&
this.cb_save,&
this.dw_dda_qty,&
this.dw_dda}
end on

on w_dda_mit_sf.destroy
destroy(this.st_balance)
destroy(this.em_balance_unit)
destroy(this.st_exist)
destroy(this.em_current_unit)
destroy(this.em_exist_unit)
destroy(this.cb_blank)
destroy(this.cb_enter)
destroy(this.cb_clear)
destroy(this.cb_dumy1)
destroy(this.cb_inche)
destroy(this.cb_feet)
destroy(this.cb_dumy)
destroy(this.cb_dot)
destroy(this.cb_0)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_3)
destroy(this.em_2)
destroy(this.st_1)
destroy(this.dw_remaining)
destroy(this.dw_existing)
destroy(this.em_1)
destroy(this.cb_close)
destroy(this.cb_compute)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.dw_dda_qty)
destroy(this.dw_dda)
end on

type st_balance from statictext within w_dda_mit_sf
int X=786
int Y=1612
int Width=713
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Remaining quantity"
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

type em_balance_unit from editmask within w_dda_mit_sf
int X=654
int Y=1612
int Width=114
int Height=100
int TabOrder=41
BorderStyle BorderStyle=StyleRaised!
string Mask="#####"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_exist from statictext within w_dda_mit_sf
int X=786
int Y=472
int Width=718
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Existing quantity"
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

type em_current_unit from editmask within w_dda_mit_sf
int X=654
int Y=1028
int Width=114
int Height=100
int TabOrder=50
BorderStyle BorderStyle=StyleRaised!
string Mask="#####"
MaskDataType MaskDataType=StringMask!
string DisplayData=""
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_exist_unit from editmask within w_dda_mit_sf
int X=654
int Y=472
int Width=114
int Height=100
int TabOrder=220
BorderStyle BorderStyle=StyleRaised!
string Mask="#####"
MaskDataType MaskDataType=StringMask!
string DisplayData="Ä"
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_blank from commandbutton within w_dda_mit_sf
event clicked pbm_bnclicked
int X=2560
int Y=1104
int Width=192
int Height=108
int TabOrder=40
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_enter from commandbutton within w_dda_mit_sf
int X=2359
int Y=1104
int Width=192
int Height=108
int TabOrder=60
string Text="Enter"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if b_tabkeypressed = false then
	wf_4_tabkey()
end if 	
cb_compute.Triggerevent(Clicked!)	
end event

type cb_clear from commandbutton within w_dda_mit_sf
int X=2158
int Y=1104
int Width=192
int Height=108
int TabOrder=70
string Text="Clear"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_columnname
Long   ll_currentrow

ls_columnname = dw_dda_qty.getcolumnname()
ll_currentrow = dw_dda_qty.getrow()
dw_dda_qty.setitem(ll_currentrow,'qty_str','')
dw_dda_qty.setitem(ll_currentrow,'dim_text','')
dw_dda_qty.setfocus()
dw_dda_qty.scrolltorow(ll_currentrow)
dw_dda_qty.setcolumn(ls_columnname)
end event

type cb_dumy1 from commandbutton within w_dda_mit_sf
int X=2560
int Y=984
int Width=192
int Height=108
int TabOrder=30
string Text="Back"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('B')
end event

type cb_inche from commandbutton within w_dda_mit_sf
int X=2359
int Y=984
int Width=192
int Height=108
int TabOrder=80
string Text="~""
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('"')
end event

type cb_feet from commandbutton within w_dda_mit_sf
int X=2158
int Y=984
int Width=192
int Height=108
int TabOrder=90
string Text="'"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed("'")
end event

type cb_dumy from commandbutton within w_dda_mit_sf
int X=2560
int Y=864
int Width=192
int Height=108
int TabOrder=100
string Text="Space"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed(' ')
end event

type cb_dot from commandbutton within w_dda_mit_sf
int X=2359
int Y=864
int Width=192
int Height=108
int TabOrder=110
string Text="."
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('.')
end event

type cb_0 from commandbutton within w_dda_mit_sf
int X=2158
int Y=864
int Width=192
int Height=108
int TabOrder=120
string Text="0"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('0')
end event

type cb_9 from commandbutton within w_dda_mit_sf
int X=2560
int Y=744
int Width=192
int Height=108
int TabOrder=130
string Text="9"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('9')
end event

type cb_8 from commandbutton within w_dda_mit_sf
int X=2359
int Y=744
int Width=192
int Height=108
int TabOrder=20
string Text="8"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('8')
end event

type cb_7 from commandbutton within w_dda_mit_sf
int X=2158
int Y=744
int Width=192
int Height=108
int TabOrder=140
string Text="7"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('7')
end event

type cb_6 from commandbutton within w_dda_mit_sf
int X=2560
int Y=620
int Width=192
int Height=108
int TabOrder=150
string Text="6"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('6')
end event

type cb_5 from commandbutton within w_dda_mit_sf
int X=2359
int Y=620
int Width=192
int Height=108
int TabOrder=160
string Text="5"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('5')
end event

type cb_4 from commandbutton within w_dda_mit_sf
int X=2158
int Y=620
int Width=192
int Height=108
int TabOrder=200
string Text="4"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('4')
end event

type cb_3 from commandbutton within w_dda_mit_sf
int X=2560
int Y=496
int Width=192
int Height=108
int TabOrder=210
string Text="3"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('3')
end event

type cb_2 from commandbutton within w_dda_mit_sf
int X=2359
int Y=496
int Width=192
int Height=108
int TabOrder=230
string Text="2"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('2')
end event

type cb_1 from commandbutton within w_dda_mit_sf
int X=2158
int Y=496
int Width=192
int Height=108
int TabOrder=240
string Text="1"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_3_keypressed('1')
end event

type em_3 from editmask within w_dda_mit_sf
int X=274
int Y=1612
int Width=366
int Height=100
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

type em_2 from editmask within w_dda_mit_sf
int X=274
int Y=472
int Width=366
int Height=100
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

type st_1 from statictext within w_dda_mit_sf
int X=786
int Y=1028
int Width=713
int Height=100
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Issue/Break out quantity"
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

type dw_remaining from datawindow within w_dda_mit_sf
int X=18
int Y=1144
int Width=2135
int Height=464
string DataObject="d_dda_qty_mit_rem"
boolean TitleBar=true
string Title="BALANCE/REMAINING QUANTITY"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_existing from datawindow within w_dda_mit_sf
int X=18
int Y=12
int Width=2135
int Height=460
string DataObject="d_dda_qty_mit"
boolean TitleBar=true
string Title="EXISTING DIMENSINON QUANTITY"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type em_1 from editmask within w_dda_mit_sf
int X=274
int Y=1028
int Width=366
int Height=100
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

type cb_close from commandbutton within w_dda_mit_sf
int X=2162
int Y=276
int Width=590
int Height=116
int TabOrder=250
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

st_parmlist.s_parent_qty       = string(ld_remainqty)
st_parmlist.s_parent_dimqtystr = sz_remainstr
if isnull(ll_dimension_code) then ll_dimension_code=1
st_parmlist.s_nonconstantdim   = ll_dimension_code

closewithreturn(w_dda_mit_sf,st_parmlist)

end event

type cb_compute from commandbutton within w_dda_mit_sf
event ue_save pbm_custom01
int X=2162
int Y=12
int Width=590
int Height=116
int TabOrder=170
string Text="Compute"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Dec ld_storedno[],&
    ld_rmnqty, &
	 ld_temp1

Long ll_find,&
     ll_rowcount,&
     ll_ctr,&
     ll_rowno

String ls_xfactorstr, &
       ls_constant, &
		 lszcurcolumn

cb_save.Triggerevent(clicked!)

ld_result1 = wf_2_calculate()
em_1.text = ""
em_1.text = String(ld_result1)	

ld_rmnqty = dec(ld_originalqty) - ld_result1
if ld_rmnqty > 0 then 
	// considering the constant & arriving at the remaining values
	ll_rowcount = dw_existing.rowcount()
   sz_remainstr="" 
   if ll_rowcount > 0 then
		ll_ctr = 0
		DO 
			ll_ctr ++
			ld_storedno[ll_ctr] = Dec(dw_dda_qty.object.qty_str[ll_ctr])
		   ls_constant   = dw_existing.object.keep_it_std[ll_ctr]
			ld_temp1      = dw_existing.object.quantity[ll_ctr]
			if ls_constant = '1' then
				ld_temp1 -= ld_storedno[ll_ctr]	
				ll_dimension_code = ll_ctr
			end if 
			sz_remainstr += trim(string(round(ld_temp1,2)))+','										
//			ls_xfactorstr = f_bk_cb_unit(string(ld_temp1),'4',sz_module)
			ls_xfactorstr = f_bk_cb_unit(string(ld_temp1),'4',sz_dimcode)
			dw_remaining.setitem(ll_ctr,'quantity',ld_temp1)
			dw_remaining.setitem(ll_ctr,'dim_qty_str',ls_xfactorstr)			
		Loop while ll_ctr < ll_rowcount	
		sz_remainstr = LeftA(sz_remainstr,LenA(sz_remainstr)-1)
	end if 
	em_3.text = ""
	em_3.text = String(ld_rmnqty)	
end if 	
dw_dda_qty.setfocus()
dw_dda_qty.scrolltorow(ll_rowno)
//dw_dda_qty.setcolumn(lszcurcolumn)
end event

type cb_cancel from commandbutton within w_dda_mit_sf
int X=2162
int Y=144
int Width=590
int Height=116
int TabOrder=180
string Text="Exit"
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sz_qtystring = st_parmlist.s_rtn_qtystr
ld_result1    = st_parmlist.s_rtn_qty    
ld_remainqty = Dec(st_parmlist.s_parent_qty)
sz_remainstr = st_parmlist.s_parent_dimqtystr
ll_dimension_code= st_parmlist.s_nonconstantdim

closewithreturn(w_dda_mit_sf,st_parmlist)



end event

type cb_save from commandbutton within w_dda_mit_sf
int X=768
int Y=384
int Width=293
int Height=112
int TabOrder=260
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

type dw_dda_qty from datawindow within w_dda_mit_sf
event ue_key pbm_dwnkey
int X=18
int Y=588
int Width=2135
int Height=440
int TabOrder=10
string DataObject="d_dyna_qty_mitsf"
boolean TitleBar=true
string Title="ISSUE QUANTITY"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;Int 	 li_dotpos, &
		 li_rowpos
		 
String ls_returnstr='', &
		 ls_constant
		 
Dec 	 ld_temp
Long   ll_find

dw_dda_qty.Accepttext()
li_rowpos = dw_dda_qty.getrow()
ll_find = dw_existing.find("keep_it_std='1'",1,dw_existing.rowcount())
if ll_find = 0 then
	Beep(5)
	Messagebox("System Message","Please select the constant dimension ")
	Return
else	
	ls_constant = dw_existing.object.keep_it_std[li_rowpos]
	ld_temp     = dw_existing.object.quantity[li_rowpos]
	IF ls_constant <> '1' then
		Beep(5)
		Messagebox("System Message","Sorry, entry not allowed as this dimension is a constant")
		dw_dda_qty.setitem(li_rowpos,'qty',round(ld_temp,2))
		dw_dda_qty.setitem(li_rowpos,'qty_str',string(round(ld_temp,2)))			
//		ls_returnstr = f_bk_cb_unit(string(ld_temp),'4',sz_module)
		ls_returnstr = f_bk_cb_unit(string(ld_temp),'4',sz_dimcode)		
		dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
	   Return
	Else
		IF keydown(KeyTab!) then 
			ll_dimension_code = Integer(ls_constant)
			dw_dda_qty.accepttext()
		   if dw_dda_qty.getcolumnname() = 'qty_str' then
				ls_returnstr =	dw_dda_qty.object.qty_str[li_rowpos]
			else
				ls_returnstr =	dw_dda_qty.object.dim_text[li_rowpos]
			end if 
			if ls_returnstr <> ""  then 
				li_dotpos = PosA(ls_returnstr,'.')
				if li_dotpos = 0 then 
					dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
//					ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
					ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)					
					ld_temp = round(dec(ls_returnstr),2)
					dw_dda_qty.setitem(li_rowpos,'qty',ld_temp)
					dw_dda_qty.setitem(li_rowpos,'qty_str',string(ld_temp))			
				else
					dw_dda_qty.setitem(li_rowpos,'qty',dec(ls_returnstr))
					dw_dda_qty.setitem(li_rowpos,'qty_str',ls_returnstr)			
//					ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_module)
					ls_returnstr = f_bk_cb_unit(ls_returnstr,'4',sz_dimcode)
					dw_dda_qty.setitem(li_rowpos,'dim_text',ls_returnstr)
				end if 
				dw_dda_qty.scrolltorow(li_rowpos)		
				cb_enter.setfocus()
				b_tabkeypressed = true
			end if 
		end if 
	End if 	
End if 	

end event

event losefocus;This.AcceptText()

end event

on constructor;dw_dda_qty.settransobject(sqlca)
end on

event getfocus;if dw_dda_qty.getcolumnname() = 'qty_str' then 
   sz_is_field = 'qty_str'
else
	sz_is_field = 'dim_text'
end if 	
end event

type dw_dda from datawindow within w_dda_mit_sf
int X=37
int Y=448
int Width=494
int Height=360
int TabOrder=190
boolean Visible=false
string DataObject="d_dda"
boolean LiveScroll=true
end type

on constructor;dw_dda.settransobject(sqlca)
end on

