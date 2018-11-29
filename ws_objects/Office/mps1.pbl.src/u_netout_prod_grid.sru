$PBExportHeader$u_netout_prod_grid.sru
$PBExportComments$(mps1) User object used to display net out graph for production grid.
forward
global type u_netout_prod_grid from u_netout
end type
type uo_legend from u_prod_grid_legend within u_netout_prod_grid
end type
end forward

global type u_netout_prod_grid from u_netout
int Height=1556
event ue_initialize pbm_custom03
uo_legend uo_legend
end type
global u_netout_prod_grid u_netout_prod_grid

forward prototypes
public subroutine uf_initialize ()
public function decimal uf_production_qty (string as_part, date ad_date1, date ad_date2)
public subroutine uf_calculate_netout (string as_part, decimal ac_demand[], string as_date_list[], string as_type)
end prototypes

on ue_initialize;call u_netout::ue_initialize;this.uf_initialize()
end on

public subroutine uf_initialize ();/*
Description	:	To initialize the netout object.
Author		:	Jim Wu
Start Date	:	05/05/96
Modification:	
*/

/* Declaratiion */
string	ls_part

long		ll_row

/* Initialization */


/* Main Process */

dw_netout.reset()
dw_netout_graph.reset()
dw_netout_graph.setredraw(FALSE)
dw_netout.setredraw(FALSE)

for ll_row = 1 to 4
	dw_netout.insertrow(1)
next 

//ls_part	= dw_crosstab.getitemstring( dw_crosstab.il_current_row, 1)
//ll_row	= dw_crosstab.il_current_row

//uf_calculate_netout( ls_part, ll_row )

dw_netout_graph.setredraw(TRUE)
dw_netout.setredraw(TRUE)
end subroutine

public function decimal uf_production_qty (string as_part, date ad_date1, date ad_date2);/*
Description	:	To calculate the quantity from production.
Author		:	Jim Wu
Start Date	:	03/12/96
Modification:
*/


/* Declaration */
decimal	lc_production
datetime ldt_date1, ldt_date2
/* Initialization */

ldt_date1 = datetime(date(string ( ad_date1, 'yyyy-mm-dd')), time('00:00:00'))
ldt_date2 = datetime(date(string ( ad_date2, 'yyyy-mm-dd')), time('23:59:59'))

/* Main Process */

SELECT sum ( workorder_detail.balance )  
  INTO :lc_production  
  FROM workorder_detail,   
       work_order  
 WHERE ( workorder_detail.workorder = work_order.work_order ) and  
       ( workorder_detail.part = :as_part ) AND  
       ( work_order.end_date 		>= :ldt_date1 ) AND
		 ( work_order.end_date	<= :ldt_date2 )   ;

return f_get_value( lc_production ) 

end function

public subroutine uf_calculate_netout (string as_part, decimal ac_demand[], string as_date_list[], string as_type);/*
Description	:	To calculate the netout.
Author		:	Jim Wu
Start Date	:	05/05/96
Modification:
*/

/* Declaration */
decimal	lc_onhand, &
	lc_production, &
	lc_balance, &
	lc_demand

date	ld_date

integer	li_ptr, &
	li_cnt, &
	li_last_row

string	ls_type_list[]
/* Initialization */

ls_type_list[1]	= 'demand'
ls_type_list[2]	= 'onhand'
ls_type_list[3]	= 'production'
ls_type_list[4]	= 'balance'

for li_cnt = 1 to 4
	this.dw_netout.setitem( li_cnt, 1, ls_type_list[li_cnt] )
next

/* Main Process */
for li_ptr = 1 to 7

	lc_onhand	= lc_balance
	ld_date		= date( as_date_list[ li_ptr ] )

	this.dw_netout.modify( "value" + string(li_ptr) + "_t.text = '" + as_date_list[ li_ptr ] + "'" )

	if li_ptr = 1 then
		lc_onhand		= 	f_get_value( dec( f_get_part_info( as_part, 'ON HAND' ) ) )
	end if

	lc_demand	=  f_get_value( ac_demand[li_ptr] )

	if isnull(LeftA(as_type,1),'W') = 'W' then 
		lc_production	= uf_production_qty( as_part, ld_date, relativedate( ld_date, 6 ))
	else
		lc_production	= uf_production_qty( as_part, ld_date, ld_date ) //relativedate( ld_date, 7 ))		
	end if 		
		
	lc_balance	= lc_production + lc_onhand - lc_demand

	for li_cnt	= 1 to 4
	
		this.dw_netout_graph.insertrow( 1 )
		li_last_row	= 1	//uo_netout.dw_netout_graph.rowcount()

		this.dw_netout_graph.setitem( li_last_row, 1, &
													ls_type_list[li_cnt] )
		this.dw_netout_graph.setitem( li_last_row, 2, &
													ld_date )
		Choose Case li_cnt
			Case 1		//Use Green Color
				this.dw_netout_graph.setitem( 1, 3, lc_onhand )	
				this.dw_netout.setitem( li_cnt, li_ptr + 1, lc_demand)
				
			Case 2		//Use Blue
				this.dw_netout_graph.setitem( 1, 3, lc_balance )
				this.dw_netout.setitem( li_cnt, li_ptr + 1, lc_onhand)	

			Case 3		//Use Yellow Color
				this.dw_netout_graph.setitem( 1, 3, lc_production )
				this.dw_netout.setitem( li_cnt, li_ptr + 1, lc_production)
			Case 4		//Use Red Color
				this.dw_netout_graph.setitem( 1, 3, lc_demand )
				this.dw_netout.setitem( li_cnt, li_ptr + 1, lc_balance)	
				
		End Choose

	next 	

next			

end subroutine

on u_netout_prod_grid.create
int iCurrent
call super::create
this.uo_legend=create uo_legend
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_legend
end on

on u_netout_prod_grid.destroy
call super::destroy
destroy(this.uo_legend)
end on

on constructor;call u_netout::constructor;this.triggerevent( 'ue_initialize' )
end on

type st_1 from u_netout`st_1 within u_netout_prod_grid
int X=1061
int Y=1312
int Height=64
boolean Visible=false
end type

type dw_netout_graph from u_netout`dw_netout_graph within u_netout_prod_grid
int X=0
int Y=400
int Width=2761
int Height=1136
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

type dw_netout from u_netout`dw_netout within u_netout_prod_grid
int X=0
int Y=0
int Width=2761
int Height=368
end type

type ln_1 from u_netout`ln_1 within u_netout_prod_grid
int BeginY=384
int EndY=384
end type

type ln_2 from u_netout`ln_2 within u_netout_prod_grid
int BeginY=380
int EndY=380
end type

type uo_legend from u_prod_grid_legend within u_netout_prod_grid
int X=1705
int Y=432
int TabOrder=30
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_legend.destroy
call u_prod_grid_legend::destroy
end on

