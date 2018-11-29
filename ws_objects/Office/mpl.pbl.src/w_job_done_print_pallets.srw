$PBExportHeader$w_job_done_print_pallets.srw
forward
global type w_job_done_print_pallets from Window
end type
type cb_2 from commandbutton within w_job_done_print_pallets
end type
type cb_1 from commandbutton within w_job_done_print_pallets
end type
type dw_pallets from datawindow within w_job_done_print_pallets
end type
end forward

global type w_job_done_print_pallets from Window
int X=833
int Y=357
int Width=1404
int Height=1073
boolean TitleBar=true
string Title="Highlight pallet(s) to print"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_pallets dw_pallets
end type
global w_job_done_print_pallets w_job_done_print_pallets

on open;long		l_l_shipper

l_l_shipper = Message.DoubleParm

dw_pallets.SetTransObject ( sqlca )
dw_pallets.Retrieve ( l_l_shipper, string ( l_l_shipper ) )
end on

on w_job_done_print_pallets.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_pallets=create dw_pallets
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_pallets}
end on

on w_job_done_print_pallets.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_pallets)
end on

type cb_2 from commandbutton within w_job_done_print_pallets
int X=732
int Y=801
int Width=385
int Height=129
int TabOrder=30
string Text="&Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;CloseWithReturn ( Parent, '' )
end on

type cb_1 from commandbutton within w_job_done_print_pallets
int X=183
int Y=801
int Width=385
int Height=129
int TabOrder=20
string Text="&Print"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int		l_i_count
string	l_s_returnstring

For l_i_count = 1 to dw_pallets.RowCount ( )
	if dw_pallets.IsSelected ( l_i_count ) then
		l_s_returnstring += String ( dw_pallets.GetItemNumber ( l_i_count, "serial" ) ) + "~t"
	end if
Next

CloseWithReturn ( Parent, l_s_returnstring )
end on

type dw_pallets from datawindow within w_job_done_print_pallets
int X=19
int Y=17
int Width=1335
int Height=753
int TabOrder=10
string DataObject="d_pallet_list_pl"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;long		l_l_row

l_l_row = GetClickedRow ( )

if l_l_row < 1 then return

if IsSelected ( l_l_row ) then
	SelectRow ( l_l_row, FALSE )
else
	SelectRow ( l_l_row, TRUE )
end if
end on

