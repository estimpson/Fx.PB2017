$PBExportHeader$u_edi_file_generator_ancestor.sru
$PBExportComments$(med)
forward
global type u_edi_file_generator_ancestor from UserObject
end type
type dw_flat_file from datawindow within u_edi_file_generator_ancestor
end type
end forward

global type u_edi_file_generator_ancestor from UserObject
int Width=1600
int Height=872
boolean Border=true
long BackColor=12632256
long PictureMaskColor=25166016
long TabBackColor=67108864
event ue_append_line pbm_custom01
event ue_create_detail_overlay pbm_custom02
event ue_error_occurred pbm_custom03
dw_flat_file dw_flat_file
end type
global u_edi_file_generator_ancestor u_edi_file_generator_ancestor

type variables
string	is_output_file = 'c:\windows\edidata.txt', &
	is_ini_file

integer	ii_file_no	

long	il_key, &
	il_last_line = 1

boolean	ib_error = FALSE, &
	ib_dump = TRUE

u_dw_edi_ancestor &
	dw_header, &
	dw_body, &
	dw_end

window	iw_Parent
end variables

forward prototypes
public subroutine uf_open_file (string as_ini_file, long al_key)
public subroutine uf_dump_data (string as_ini_file)
public subroutine uf_init (window aw_Parent)
end prototypes

event ue_append_line;string	ls_line, &
		ls_check_line

LONG	ll_this_line, &
		ll_check_line, &
		ll_row

ls_line	=  string( message.longparm, 'address' )
ll_this_line = Integer ( LeftA ( ls_line, 2 ) )
IF ll_this_line > 0 AND ll_this_line < il_last_line THEN
	// check for redundand line
	ll_row = dw_flat_file.RowCount ( ) - 1
	DO WHILE ll_row > 0
		ls_check_line = dw_flat_file.GetItemString ( ll_row, 1 )
		ll_check_line = Integer ( LeftA ( ls_check_line, 2 ) )
		IF ll_check_line = ll_this_line THEN
			IF ls_check_line = ls_line THEN
				Return
			ELSE
				Exit
			END IF
		END IF
		ll_row --
	LOOP
END IF
il_last_line = ll_this_line
dw_flat_file.insertrow( 0 )
dw_flat_file.setitem( dw_flat_file.rowcount(), 1, ls_line )
filewrite( ii_file_no, ls_line )
end event

on ue_create_detail_overlay;dw_body.is_filter_value	= string( message.longparm, 'address' )
dw_body.uf_create_overlay( )
end on

on ue_error_occurred;this.ib_error	= TRUE
end on

public subroutine uf_open_file (string as_ini_file, long al_key);boolean	lb_process = TRUE

dw_flat_file.reset()
dw_header.idw_error_log.reset()
is_output_file=profilestring( as_ini_file, 'General', 'Output', 'c:\windows\edipoflt.txt' )
if ib_dump then
	if profilestring( as_ini_file, 'General', 'FileMode', 'Line' ) = 'Line' then
		ii_file_no = FileOpen( is_output_file, LineMode!, Write!, LockWrite!, Append!)
	else
		ii_file_no = FileOpen( is_output_file, StreamMode!, Write!, LockWrite!, Append!)
	end if

	if ii_file_no < 0 then
		ib_error	= TRUE
		messagebox( 'Monitor for Windows', 'Failed to open EDI output file.', &
						information! )
		lb_process	= FALSE	
	end if
end if
if lb_process then
	this.is_ini_file= as_ini_file
	this.il_key	= al_key
	dw_header.is_ini_file	= this.is_ini_file
	dw_body.is_ini_file		= this.is_ini_file
	dw_end.is_ini_file		= this.is_ini_file
	dw_header.il_key			= this.il_key
	dw_body.il_key				= this.il_key
	dw_end.il_key				= this.il_key
	if dw_header.uf_create_overlay() then
		dw_end.uf_create_overlay()
	end if
	if ib_dump then
		fileclose( ii_file_no )
	end if
end if

end subroutine

public subroutine uf_dump_data (string as_ini_file);long &
		ll_row, &
		ll_count

string &
		ls_line

if profilestring( as_ini_file, 'General', 'FileMode', 'Line' ) = 'Line' then
	ii_file_no = FileOpen( is_output_file, LineMode!, Write!, LockWrite!, Append!)
else
	ii_file_no = FileOpen( is_output_file, StreamMode!, Write!, LockWrite!, Append!)
end if

if ii_file_no < 0 then
	messagebox( 'Monitor for Windows', 'Failed to open EDI output file.', &
					information! )
else
	ll_count	= dw_flat_file.rowcount()
	for ll_row = 1 to ll_count
		ls_line	= LeftA( &
				dw_flat_file.getitemstring( ll_row, 1 ) + space(80), 80 )
		filewrite( ii_file_no, ls_line )			
	next	
end if
end subroutine

public subroutine uf_init (window aw_Parent);iw_Parent = aw_Parent
dw_header.iw_Parent = iw_Parent
dw_body.iw_Parent = iw_Parent
dw_end.iw_Parent = iw_Parent
end subroutine

on u_edi_file_generator_ancestor.create
this.dw_flat_file=create dw_flat_file
this.Control[]={this.dw_flat_file}
end on

on u_edi_file_generator_ancestor.destroy
destroy(this.dw_flat_file)
end on

type dw_flat_file from datawindow within u_edi_file_generator_ancestor
int Width=1591
int Height=864
int TabOrder=10
string DataObject="dw_external_asn_output"
boolean VScrollBar=true
boolean LiveScroll=true
end type

