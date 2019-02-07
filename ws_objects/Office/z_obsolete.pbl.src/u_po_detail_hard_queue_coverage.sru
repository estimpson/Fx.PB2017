$PBExportHeader$u_po_detail_hard_queue_coverage.sru
$PBExportComments$(mpo)
forward
global type u_po_detail_hard_queue_coverage from UserObject
end type
type dw_po_detail from u_jw_dw_super within u_po_detail_hard_queue_coverage
end type
type dw_hard_queue from u_dw_po_detail_hard_queue_coverage within u_po_detail_hard_queue_coverage
end type
type gb_1 from groupbox within u_po_detail_hard_queue_coverage
end type
end forward

global type u_po_detail_hard_queue_coverage from UserObject
int Width=2866
int Height=648
boolean Border=true
long BackColor=77897888
long PictureMaskColor=25166016
long TabBackColor=67108864
dw_po_detail dw_po_detail
dw_hard_queue dw_hard_queue
gb_1 gb_1
end type
global u_po_detail_hard_queue_coverage u_po_detail_hard_queue_coverage

forward prototypes
public subroutine uf_coverage ()
public subroutine uf_dw_share (datawindow adw, boolean ab_share)
end prototypes

public subroutine uf_coverage ();long		ll_hq_count, &
			ll_hq_row, &
			ll_po_count, &
			ll_po_row

decimal	lc_po_qty, &
			lc_hq_qty

boolean	lb_process	= TRUE

date		ld_date, &
			ld_hq_date

ll_hq_count	= dw_hard_queue.rowcount()
ll_po_count	= this.dw_po_detail.rowcount()
ll_hq_row	= 1
ll_po_row	= 1
lc_po_qty	= 0
lc_hq_qty	= 0

if ll_po_count > 0 then
	lc_po_qty	+= this.dw_po_detail.getitemnumber( ll_po_row, 'standard_qty' )
	ld_date		=	date ( this.dw_po_detail.getitemdatetime( ll_po_row, 'date_due' ) )
end if

if ll_hq_count > 0 then
	ld_hq_date	= date ( dw_hard_queue.getitemdatetime ( ll_hq_row, 'due_date' ) )
	lc_hq_qty	+= ( this.dw_hard_queue.getitemnumber( ll_hq_row, 'quantity_raw' ) - &
						 this.dw_hard_queue.getitemnumber( ll_hq_row, 'qty_covered' ) )
end if

do while ll_po_row <= ll_po_count and ll_hq_row <= ll_hq_count and lb_process

	if ld_date > ld_hq_date then
		lc_hq_qty	= 0
		if ll_hq_row < ll_hq_count then
			ll_hq_row ++
			ld_hq_date	= date ( dw_hard_queue.getitemdatetime ( ll_hq_row, 'due_date' ) )
			lc_hq_qty	+= ( this.dw_hard_queue.getitemnumber( ll_hq_row, 'quantity_raw' ) - &
						 this.dw_hard_queue.getitemnumber( ll_hq_row, 'qty_covered' ) )			
		else
			lb_process	= FALSE
		end if
	else	
		if lc_po_qty >= lc_hq_qty then
			lc_po_qty	-= lc_hq_qty
			dw_hard_queue.setitem( ll_hq_row, 'qty_covered', lc_hq_qty )
			dw_hard_queue.accepttext()
			lc_hq_qty	= 	0
			if ll_hq_row < ll_hq_count then
				ll_hq_row ++
				ld_hq_date	= date ( dw_hard_queue.getitemdatetime ( ll_hq_row, 'due_date' ) )
				lc_hq_qty	+= ( this.dw_hard_queue.getitemnumber( ll_hq_row, 'quantity_raw' ) - &
							 this.dw_hard_queue.getitemnumber( ll_hq_row, 'qty_covered' ) )
			else
				lb_process	= FALSE
			end if
		else
			lc_hq_qty	-= lc_po_qty
			dw_hard_queue.setitem( ll_hq_row, 'qty_covered', lc_po_qty )
			dw_hard_queue.accepttext()
			lc_po_qty	= 0
			if ll_po_row < ll_po_count then
				ll_po_row ++
				lc_po_qty	+= this.dw_po_detail.getitemnumber( ll_po_row, 'standard_qty' )
				ld_date		=	date ( this.dw_po_detail.getitemdatetime ( ll_po_row, 'date_due' ) )
			else
				lb_process	= FALSE
			end if
		end if
	
	end if

loop		




end subroutine

public subroutine uf_dw_share (datawindow adw, boolean ab_share);if ab_share then
	adw.sharedata( this.dw_po_detail )
else
	adw.sharedataoff( )
end if

end subroutine

on u_po_detail_hard_queue_coverage.create
this.dw_po_detail=create dw_po_detail
this.dw_hard_queue=create dw_hard_queue
this.gb_1=create gb_1
this.Control[]={this.dw_po_detail,&
this.dw_hard_queue,&
this.gb_1}
end on

on u_po_detail_hard_queue_coverage.destroy
destroy(this.dw_po_detail)
destroy(this.dw_hard_queue)
destroy(this.gb_1)
end on

type dw_po_detail from u_jw_dw_super within u_po_detail_hard_queue_coverage
int X=0
int Y=704
int Width=1838
int Height=352
int TabOrder=30
boolean Visible=false
string DataObject="dw_smart_po_detail_entry"
end type

type dw_hard_queue from u_dw_po_detail_hard_queue_coverage within u_po_detail_hard_queue_coverage
int X=18
int Y=64
int Width=2798
int Height=528
int TabOrder=20
boolean TitleBar=false
boolean VScrollBar=true
end type

on doubleclicked;call u_dw_po_detail_hard_queue_coverage::doubleclicked;long		ll_row

string	ls_work_order

ll_row	= this.getclickedrow()

if ll_row > 0 then
	ls_work_order		= this.getitemstring( ll_row, 'work_order_work_order' )
	OpenWithParm(w_job_information, ls_work_order)
End If
end on

type gb_1 from groupbox within u_po_detail_hard_queue_coverage
int Width=2834
int Height=616
int TabOrder=10
string Text="Demand from hard queue"
long BackColor=77897888
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

