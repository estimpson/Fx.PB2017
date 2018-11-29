$PBExportHeader$w_pg_vbom.srw
forward
global type w_pg_vbom from Window
end type
type cb_close from commandbutton within w_pg_vbom
end type
type cbx_expandall from checkbox within w_pg_vbom
end type
type cb_print from commandbutton within w_pg_vbom
end type
type dw_vbomprint from datawindow within w_pg_vbom
end type
type dw_vbom from datawindow within w_pg_vbom
end type
end forward

global type w_pg_vbom from Window
int X=5
int Y=4
int Width=3666
int Height=2460
boolean TitleBar=true
string Title="Production Grid Visual Bill of Material"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
cb_close cb_close
cbx_expandall cbx_expandall
cb_print cb_print
dw_vbomprint dw_vbomprint
dw_vbom dw_vbom
end type
global w_pg_vbom w_pg_vbom

type variables
integer	il_totalrows
string	i_s_partcode
uo_pg_vbom_tv  tv_vbom
string	is_title
end variables

forward prototypes
public subroutine wf_explode_components (string as_part)
end prototypes

public subroutine wf_explode_components (string as_part);STRING	ls_part='', &
	ls_curnpart
long	ll_tvparent
long	ll_tvi
Int	l_i_charpos, &
	l_i_len
long	ll_node
long	ll_rowno
long	ll_level
String	ls_currentpart
string	ls_unit
decimal	ld_onhand
decimal	ld_bomqty

TreeviewItem	l_t_tv

if isvalid(tv_vbom) then closeuserobject(tv_vbom)

openuserobject ( tv_vbom )
tv_vbom.setredraw(false) 
tv_vbom.y = 100
tv_vbom.width = this.workspacewidth()
tv_vbom.height = this.workspaceheight() - 100

for ll_tvi = 1 to il_totalrows
	ll_tvparent = dw_vbom.object.parentseq [ ll_tvi ]
	ls_part 	= dw_vbom.object.part [ ll_tvi ]
	ld_bomqty 	= dw_vbom.object.bomqty [ ll_tvi ]
	select	pol.on_hand,
		pi.standard_unit
	into	:ld_onhand,
		:ls_unit
	from	part_online pol
		join part_inventory pi on pi.part = pol.part
	where	pol.part = :ls_part;	
	ls_curnpart=ls_part +' Bom Qty: '+string(ld_bomqty,'####0.00')+', Onhand: '+string(ld_onhand,'#,##,##0.00')+', Unit: '+ls_unit
	if ll_tvi = 1 then ll_tvparent = 0 
	tv_vbom.InsertItemLast ( ll_tvparent, ls_curnpart , 1)
next	
if cbx_expandall.checked then
	tv_vbom.expandall(1)
end if 	
tv_vbom.setredraw(true) 

//dw_vbomprint.reset() 
//ll_node = tv_vbom.FindItem ( RootTreeItem! , 0 )
//ll_rowno = 0
//do 
//	tv_vbom.GetItem(ll_node,l_t_tv)
//	ls_currentpart = l_t_tv.label
//	ll_level = l_t_tv.level
////	l_i_len = Len(l_t_tv.label)
////	l_i_charpos= pos(l_t_tv.label,'=')
////	IF l_i_charpos=0 THEN l_i_charpos=l_i_len + 2
////	ls_part = Left(l_t_tv.label, (l_i_charpos - 2))
////	
//
////	select	pol.on_hand,
////		pi.standard_unit
////	into	:ld_onhand,
////		:ls_unit
////	from	part_online pol
////		join part_inventory pi on pi.part = pol.part
////	where	pol.part = :ls_part;	
//
//	ll_rowno ++
//	dw_vbomprint.insertrow ( 0 )
//	dw_vbomprint.setitem ( ll_rowno, 'part', ls_currentpart )
//	
////	dw_vbomprint.setitem ( ll_rowno, 'onhand', ld_onhand )
////	dw_vbomprint.setitem ( ll_rowno, 'um', ls_unit)
//	
//	dw_vbomprint.setitem ( ll_rowno, 'xpos', (ll_level * 156 ) )	
//	ll_node = tv_vbom.FindItem (NextVisibleTreeItem!, ll_node )
//loop while ll_node > 0
//
end subroutine

on w_pg_vbom.create
this.cb_close=create cb_close
this.cbx_expandall=create cbx_expandall
this.cb_print=create cb_print
this.dw_vbomprint=create dw_vbomprint
this.dw_vbom=create dw_vbom
this.Control[]={this.cb_close,&
this.cbx_expandall,&
this.cb_print,&
this.dw_vbomprint,&
this.dw_vbom}
end on

on w_pg_vbom.destroy
destroy(this.cb_close)
destroy(this.cbx_expandall)
destroy(this.cb_print)
destroy(this.dw_vbomprint)
destroy(this.dw_vbom)
end on

event open;String	l_s_part, &
	ls_partclass
Long   l_l_tvi
Int    li_cnt       
l_s_part = Message.Stringparm
i_s_partcode=l_s_part

select	class
into	:ls_partclass
from	part
where	part = :i_s_partcode;

if ls_partclass = 'P' then
	title = 'Purchasing Grid Visual Bill of Material'	
	is_title = 'Purchasing Grid Visual Bill of Material'		
else	
	title = 'Production Grid Visual Bill of Material'
	is_title = 'Production Grid Visual Bill of Material'	
end if	

//sqlca.autocommit = true
dw_vbom.Retrieve ( i_s_partcode)
//sqlca.autocommit = false

il_totalrows = dw_vbom.Rowcount()
if il_totalrows > 0 then
	wf_explode_components ( i_s_partcode ) 
end if 	
end event

event close;if isvalid(tv_vbom) then closeuserobject(tv_vbom)
end event

type cb_close from commandbutton within w_pg_vbom
int X=357
int Y=12
int Width=302
int Height=80
int TabOrder=10
string Text="Close"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if isvalid(tv_vbom) then 
	closeuserobject(tv_vbom)
	close(w_pg_vbom)
end if 	
end event

type cbx_expandall from checkbox within w_pg_vbom
int X=699
int Y=12
int Width=370
int Height=80
string Text="Expand All"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean RightToLeft=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;wf_explode_components ( i_s_partcode ) 
end event

type cb_print from commandbutton within w_pg_vbom
int X=14
int Y=12
int Width=302
int Height=80
int TabOrder=20
string Text="Print"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_node
long	ll_rowno
long	ll_level
String	ls_currentpart

TreeviewItem	l_t_tv

dw_vbomprint.reset() 
ll_node = tv_vbom.FindItem ( RootTreeItem! , 0 )
ll_rowno = 0
do 
	tv_vbom.GetItem(ll_node,l_t_tv)
	ls_currentpart = l_t_tv.label
	if ls_currentpart > '' then 
		ll_level = l_t_tv.level
		ll_rowno ++
		dw_vbomprint.Modify ( "vbomtitle.text='"+is_title+"'" )		
		dw_vbomprint.insertrow ( 0 )
		dw_vbomprint.setitem ( ll_rowno, 'part', ls_currentpart )
		dw_vbomprint.setitem ( ll_rowno, 'xpos', (ll_level * 156 ) )	
	end if 	
	ll_node = tv_vbom.FindItem (NextVisibleTreeItem!, ll_node )
loop while ll_node > 0

if dw_vbomprint.rowcount () > 0 then 
	dw_vbomprint.print()
end if 	
end event

type dw_vbomprint from datawindow within w_pg_vbom
int X=2523
int Y=1628
int Width=224
int Height=188
int TabOrder=30
boolean Visible=false
string DataObject="d_pg_vbomprintparts"
end type

type dw_vbom from datawindow within w_pg_vbom
int X=2277
int Y=1632
int Width=210
int Height=188
int TabOrder=40
boolean Visible=false
string DataObject="d_vbomparts"
end type

event constructor;settransobject(sqlca)
end event

