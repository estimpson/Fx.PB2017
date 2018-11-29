$PBExportHeader$w_bom_explode.srw
$PBExportComments$changed the minicop routine for watcom
forward
global type w_bom_explode from Window
end type
type dw_bom_loop from datawindow within w_bom_explode
end type
type dw_1 from datawindow within w_bom_explode
end type
type dw_parts from datawindow within w_bom_explode
end type
type dw_part_ext from datawindow within w_bom_explode
end type
type dw_gt_bom_info from datawindow within w_bom_explode
end type
type dw_bom from datawindow within w_bom_explode
end type
end forward

global type w_bom_explode from Window
int X=0
int Y=0
int Width=2889
int Height=1800
boolean TitleBar=true
string Title="Bom Explode"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event run_mini_cop pbm_custom01
dw_bom_loop dw_bom_loop
dw_1 dw_1
dw_parts dw_parts
dw_part_ext dw_part_ext
dw_gt_bom_info dw_gt_bom_info
dw_bom dw_bom
end type
global w_bom_explode w_bom_explode

type variables
str_super_cop_parms	istr_super_cop_parms

Long    l_bom_level  = 1
Long    l_Current_row

string   is_parent_part
long     il_ccount = 0
String  s_original

datetime ld_date
datetime id_Dropdead_Datetime
Datetime ld_year_begin

dec     in_extended_quantity
Dec    id_qty

string  ls_sunday 
string  ls_monday 
string  ls_tuesday 
string  ls_wednesday 
string  ls_thursday
string  ls_friday 
string  ls_saturday 
string  ls_include_set_up 
Integer ls_work_hours_in_day
end variables

event run_mini_cop;STRING 	ls_regen, &
			l_s_sa_pass, &
 		   ls_part, &
			ls_sql, &
			ls_syntax, &
			ls_errors
			
INTEGER	li_count

DEC		ln_order
LONG		ll_cur_row, ll_level, lcv

TRANSACTION			db_native_trans
POINTER				oldpointer  
LONG 					l_row_id, ll_count, ll_row
DATASTORE			dw_order_rows
string	ls_artificialcum=''

ls_regen = 'Y'
ln_order = istr_super_cop_parms.a_order_no
setnull(l_row_id)

dw_bom.dataobject = 'dw_bom_explode'
dw_order_rows = CREATE DATASTORE

string error_syntaxfromSQL, error_create
	
ls_sql = 	'SELECT row_id FROM order_detail '  &
			+  'WHERE flag <> 0 and order_no = ' + string ( istr_super_cop_parms.a_order_no ) &
			+	' ORDER BY part_number '

ls_syntax = SQLCA.SyntaxFromSQL ( ls_sql , "", ls_errors )

dw_order_rows.Create ( ls_syntax )
dw_order_rows.SetTransObject(SQLCA)
dw_order_rows.Retrieve()	
	
FOR li_count = 1 to dw_order_rows.RowCount ( )

	l_row_id	= dw_order_rows.Object.#1[li_count]
		
	sqlca.autocommit = TRUE

	DECLARE super_cop PROCEDURE FOR msp_super_cop  
   	   :istr_super_cop_parms.a_regen_all,   
      	:istr_super_cop_parms.a_order_no,   
	     	:l_row_id ;


	EXECUTE super_cop;

	IF sqlca.sqlcode < 0 THEN
  	  MessageBox (monsys.msg_title, sqlca.sqlerrtext, Information! )
	END IF

   FETCH super_cop INTO :ls_part,  :ll_level  ;

	DO WHILE sqlca.sqlcode = 0
			
		dw_bom.reset()
			
		DO WHILE sqlca.sqlcode = 0

			ll_cur_row = dw_bom.insertrow(0)
			dw_bom.scrolltorow(ll_cur_row)
         dw_bom.setitem(ll_cur_row - 1, 3, 0)
			dw_bom.setitem(ll_cur_row,1,ls_part)
			dw_bom.setitem(ll_cur_row,2,ll_level)
         dw_bom.setitem(ll_cur_row,3,1)
	   	FETCH super_cop INTO :ls_part,  :ll_level  ;

		LOOP

		   FETCH super_cop INTO :ls_part,  :ll_level  ;

	LOOP

	close super_cop;
	sqlca.autocommit = FALSE
NEXT
	
DESTROY dw_order_rows ;

//added these lines to refresh the blanket order screen.. mb 08/05/98

IF ISVALID ( w_blanket_order ) THEN
	ls_artificialcum = w_blanket_order.dw_1.object.artificial_cum[1]
	w_blanket_order.dw_2.Retrieve ( ln_order, ls_artificialcum ) 
END IF

CLOSE ( w_bom_explode )
end event

on open;istr_super_cop_parms = Message.PowerObjectParm

postevent ('run_mini_cop' )
end on

on w_bom_explode.create
this.dw_bom_loop=create dw_bom_loop
this.dw_1=create dw_1
this.dw_parts=create dw_parts
this.dw_part_ext=create dw_part_ext
this.dw_gt_bom_info=create dw_gt_bom_info
this.dw_bom=create dw_bom
this.Control[]={this.dw_bom_loop,&
this.dw_1,&
this.dw_parts,&
this.dw_part_ext,&
this.dw_gt_bom_info,&
this.dw_bom}
end on

on w_bom_explode.destroy
destroy(this.dw_bom_loop)
destroy(this.dw_1)
destroy(this.dw_parts)
destroy(this.dw_part_ext)
destroy(this.dw_gt_bom_info)
destroy(this.dw_bom)
end on

type dw_bom_loop from datawindow within w_bom_explode
int X=1134
int Y=1124
int Width=315
int Height=304
int TabOrder=40
boolean Visible=false
string DataObject="d_bom_loop"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_1 from datawindow within w_bom_explode
int X=2944
int Y=272
int Width=494
int Height=360
int TabOrder=20
boolean LiveScroll=true
end type

type dw_parts from datawindow within w_bom_explode
int X=448
int Y=1116
int Width=279
int Height=312
int TabOrder=60
boolean Visible=false
string DataObject="d_parts"
boolean LiveScroll=true
end type

on constructor;settransobject(sqlca)
end on

type dw_part_ext from datawindow within w_bom_explode
int X=37
int Y=1120
int Width=402
int Height=288
int TabOrder=50
boolean Visible=false
string DataObject="d_part_ext"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on constructor;settransobject(sqlca)
end on

type dw_gt_bom_info from datawindow within w_bom_explode
int X=731
int Y=1120
int Width=402
int Height=288
int TabOrder=30
boolean Visible=false
string DataObject="d_gt_bom_info"
boolean LiveScroll=true
end type

on constructor;settransobject(sqlca)
end on

type dw_bom from datawindow within w_bom_explode
int X=18
int Y=16
int Width=2816
int Height=1664
int TabOrder=10
string DataObject="dw_bom_explode"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

