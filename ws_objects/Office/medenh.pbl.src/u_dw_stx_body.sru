$PBExportHeader$u_dw_stx_body.sru
$PBExportComments$(med)
forward
global type u_dw_stx_body from datawindow
end type
end forward

global type u_dw_stx_body from datawindow
int Width=1281
int Height=625
int TabOrder=1
boolean LiveScroll=true
end type
global u_dw_stx_body u_dw_stx_body

type variables
string	is_filter_column, &
	is_ini_file, &
	is_line_# = '00', &
	is_current_line = space(80)

long	il_key
end variables

forward prototypes
public function boolean uf_generate_body (long al_row)
public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length)
public subroutine uf_create_overlay (string as_filter_value)
public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length)
end prototypes

public function boolean uf_generate_body (long al_row);//This function will generate the flat overlay header information
string	ls_item='*', &
			ls_line, &
			ls_column, &
			ls_type

integer	li_pos, &
			li_length, &
			li_ptr = 1

boolean	lb_error = FALSE

do while ls_item <> '!!' 
	ls_item	= f_get_string_value( profilestring( 	is_ini_file, 'STX Body', &
										'Item' + string( li_ptr ), '!!' ) )


	if ls_item <> '!!' then
		ls_line	= profilestring( 	is_ini_file, 'STX Body', &
											'Line' + string( li_ptr ), '00' )
		if ls_line = '00' then
			parent.triggerevent( 'ue_error_occurred' )
			messagebox( 'Monitor for Windows', 'Line# for ' + ls_item + ' is missing.', information! )
			lb_error	= TRUE
			exit
		else
			li_pos	= profileint( 	is_ini_file, 'STX Body', &
											'Pos' + string( li_ptr ), 0 )
		end if

		if li_pos = 0 then
			parent.triggerevent( 'ue_error_occurred' )
			messagebox( 'Monitor for Windows', 'Pos for ' + ls_item + ' is missing.', information! )
			lb_error	= TRUE
			exit
		else
			li_length= profileint( 	is_ini_file, 'STX Body', &
											'Length' + string( li_ptr ), 0 )
		end if

		if li_length = 0 then
			parent.triggerevent( 'ue_error_occurred' )
			messagebox( 'Monitor for Windows', 'Length for ' + ls_item + ' is missing.', information! )
			lb_error	= TRUE
			exit
		end if

		if LeftA( ls_item , 1 ) = '*' then
			ls_column	= RightA( ls_item, LenA( ls_item  ) - 1 )
			ls_type		= upper( LeftA( this.describe( ls_column + '.coltype' ), 4 ) )
			if ls_type = 'CHAR' or ls_type = '!' then
				ls_item	= f_get_string_value( &
									this.getitemstring( al_row, ls_column ) )
			else
				parent.triggerevent( 'ue_error_occurred' )
				messagebox( 'Monitor for Windows', 'Column:' + ls_column + &
								'must have STRING type.', information! )
				lb_error	= TRUE
				exit				
			end if		
		end if

		uf_output( 	f_get_string_value(ls_item), ls_line, li_pos, li_length )
	end if

	li_ptr ++

loop

if is_current_line > '' then
	parent.triggerevent( 'ue_append_line', 0, is_current_line )
	is_current_line	= space(80)
	is_line_#			= '00'
end if

return (not lb_error )
end function

public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length);string	ls_right, &
			ls_left

ls_left				= LeftA( is_current_line, ai_pos - 1 )
ls_right				= RightA( is_current_line, &
							LenA( is_current_line ) - ( ai_pos + ai_length - 1 ) )

is_current_line	= LeftA( ls_left + as_item + ls_right + space(80), 80 )
end subroutine

public subroutine uf_create_overlay (string as_filter_value);integer	li_ptr, &
			li_count

string	ls_PBLName, &
			ls_data_object, &
			ls_current_item, &
			ls_filter_column, &
			ls_DWSyntax

ls_PBLName 		= profilestring ( is_ini_file, 'STX Body', 'PblName', '' )
ls_data_object		= profilestring( is_ini_file, 'STX Body', 'DataObject', '' )
ls_filter_column	= profilestring( is_ini_file, 'STX Body', 'FilterColumn', '' )

IF ls_PBLName > '' AND ls_data_object > '' THEN
	ls_DWSyntax = LibraryExport ( ls_PBLName, ls_data_object , ExportDataWindow! )
	Create ( ls_DWSyntax )
ELSEif ls_data_object > '' then
	this.dataobject	= ls_data_object
else
	parent.triggerevent( 'ue_error_occurred' )
	messagebox( 'Monitor for Windows', "Detail information can't be empty.", Information! )
end if
this.settransobject(	SQLCA )
this.retrieve( il_key )
if ls_filter_column > '' then
	if not isnull( as_filter_value ) then
		this.setfilter( ls_filter_column + "= '" + as_filter_value	 + "'" )
		this.filter()
	end if
end if

li_count	= this.rowcount()
for li_ptr = 1 to li_count
	this.uf_generate_body( li_ptr )
next
end subroutine

public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length);if is_line_# = '00' then
	is_current_line	= LeftA( as_line + space( 80 ), 80 )
	uf_replace_string( is_current_line, as_item, ai_pos, ai_length )
else
	if as_line <> is_line_# then
		parent.triggerevent( 'ue_append_line', 0, is_current_line )
		is_current_line	= as_line + space( 78 )
	end if
	uf_replace_string( is_current_line, as_item, ai_pos, ai_length )
end if

is_line_# = as_line
end subroutine

