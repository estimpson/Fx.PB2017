$PBExportHeader$u_dw_stx_end.sru
$PBExportComments$(mst) To keep the End segment for converting to STX overlay.
forward
global type u_dw_stx_end from datawindow
end type
end forward

global type u_dw_stx_end from datawindow
int Width=1281
int Height=509
int TabOrder=1
boolean LiveScroll=true
end type
global u_dw_stx_end u_dw_stx_end

type variables
string	is_filter_column, &
	is_ini_file, &
	is_line_#, &
	is_current_line

long	il_key
end variables

forward prototypes
public subroutine uf_create_overlay ()
public function boolean uf_generate_end (long al_row)
public subroutine uf_output (string as_line, string as_item, integer ai_pos, integer ai_length)
public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length)
end prototypes

public subroutine uf_create_overlay ();integer	li_ptr, &
			li_count


string	ls_PBLName, &
			ls_data_object, &
			ls_current_item, &
			ls_DWSyntax

ls_PBLName 		= profilestring ( is_ini_file, 'STX End', 'PblName', '' )
ls_data_object		= profilestring( is_ini_file, 'STX End', 'DataObject', '' )

IF ls_PBLName > '' AND ls_data_object > '' THEN
	ls_DWSyntax = LibraryExport ( ls_PBLName, ls_data_object , ExportDataWindow! )
	Create ( ls_DWSyntax )
ELSEif ls_data_object > '' then
	this.dataobject	= ls_data_object
else
	return
end if
this.settransobject(	SQLCA )
this.retrieve( il_key )

li_count	= this.rowcount()
for li_ptr = 1 to li_count
	this.uf_generate_end( li_ptr )
next
end subroutine

public function boolean uf_generate_end (long al_row);//This function will generate the flat overlay header information
string	ls_item='*', &
			ls_line, &
			ls_column

integer	li_pos, &
			li_length, &
			li_ptr = 1

boolean	lb_error = FALSE


do while ls_item > '' 
	ls_item	= profilestring( 	is_ini_file, 'STX End', &
										'Item' + string( li_ptr ), '' )

	if ls_item > '' then
		ls_line	= profilestring( 	is_ini_file, 'STX End', &
											'Line' + string( li_ptr ), '00' )
		if ls_line = '00' then
			parent.triggerevent( 'ue_error_occurred' )
			messagebox( 'Monitor for Windows', 'Line# for ' + ls_item + ' is missing.', information! )
			lb_error	= TRUE
			exit
		else
			li_pos	= profileint( 	is_ini_file, 'STX End', &
											'Pos' + string( li_ptr ), 0 )
		end if

		if li_pos = 0 then
			parent.triggerevent( 'ue_error_occurred' )
			messagebox( 'Monitor for Windows', 'Pos for ' + ls_item + ' is missing.', information! )
			lb_error	= TRUE
			exit
		else
			li_length= profileint( 	is_ini_file, 'STX End', &
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
			if upper( LeftA( this.describe( ls_column + '.coltype' ), 4 ) ) = 'CHAR' then
				ls_item	= this.getitemstring( al_row, ls_column )
			else
				parent.triggerevent( 'ue_error_occurred' )
				messagebox( 'Monitor for Windows', 'Column:' + ls_column + &
								'must have STRING type.', information! )
				lb_error	= TRUE
				exit				
			end if		
		end if

		uf_output( 	ls_item, ls_line, li_pos, li_length )
	end if

	li_ptr ++

loop

return (not lb_error )




end function

public subroutine uf_output (string as_line, string as_item, integer ai_pos, integer ai_length);if is_line_# = '00' then
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

public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length);string	ls_right, &
			ls_left

ls_left				= 	LeftA( is_current_line, ai_pos - 1 )
ls_right				= 	RightA( is_current_line, &
							LenA( is_current_line ) - ( ai_pos + ai_length - 1 ) )

is_current_line	= 	LeftA( ls_left + as_item + ls_right, 80 )
end subroutine

