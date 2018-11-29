$PBExportHeader$u_dw_stx_header.sru
$PBExportComments$(med)
forward
global type u_dw_stx_header from datawindow
end type
end forward

global type u_dw_stx_header from datawindow
int Width=1509
int Height=565
int TabOrder=1
boolean LiveScroll=true
end type
global u_dw_stx_header u_dw_stx_header

type variables
string	is_ini_file, &
	is_current_line = space( 80 ), &
	is_line_# = '00'
	
long	il_key

boolean	ib_error


end variables

forward prototypes
public function boolean uf_generate_header (long al_row)
public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length)
public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length)
public function boolean uf_create_overlay ()
end prototypes

public function boolean uf_generate_header (long al_row);//This function will generate the flat overlay header information
string	ls_item = '*', &
			ls_line, &
			ls_column, &
			ls_type, &
			ls_item_id

integer	li_pos, &
			li_length, &
			li_ptr = 1, &
			li_sub_ptr = 0

boolean	lb_error = FALSE

ls_item_id	= string( li_ptr )
ls_item		= 	f_get_string_value( &
					profilestring( is_ini_file, 'STX Header', &
					'Item' + ls_item_id, '!!' ) )


do while ls_item <> '!!' 

	ls_line	= profilestring( 	is_ini_file, 'STX Header', &
											'Line' + ls_item_id, '00' )
	if ls_line = '00' then
		parent.triggerevent( 'ue_error_occurred' )
		messagebox( 'Monitor for Windows', 'Line# for ' + ls_item + ' is missing.', information! )
		lb_error	= TRUE
		exit
	else
		li_pos	= profileint( 	is_ini_file, 'STX Header', &
									'Pos' + ls_item_id, 0 )
	end if
	
	if li_pos = 0 then
		parent.triggerevent( 'ue_error_occurred' )
		messagebox( 'Monitor for Windows', 'Pos for ' + ls_item + ' is missing.', information! )
		lb_error	= TRUE
		exit
	else
		li_length= profileint( 	is_ini_file, 'STX Header', &
										'Length' + ls_item_id, 0 )
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

	uf_output( 	ls_item, ls_line, li_pos, li_length )

	li_sub_ptr ++
	ls_item_id	= string( li_ptr ) + '.' + string( li_sub_ptr )
	ls_item	= f_get_string_value( &
						profilestring( is_ini_file, 'STX Header', &
						'Item' + ls_item_id  , '!!' ) )

	if ls_item = '!!'	then
		li_ptr ++
		li_sub_ptr 	= 0
		ls_item_id	= string( li_ptr )
		ls_item	= f_get_string_value( &
					profilestring( is_ini_file, 'STX Header', &
					'Item' + ls_item_id  , '!!' ) )
	end if

loop

if is_current_line > '' then
	parent.triggerevent( 'ue_append_line', 0, is_current_line )
	is_current_line	= ''
	is_line_#			= '00'
end if

return (not lb_error )




end function

public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length);if is_line_# = '00' then
	uf_replace_string( is_current_line, as_item, ai_pos, ai_length )
else
	if as_line <> is_line_# then
		if is_line_# <> '00' then
			parent.triggerevent( 'ue_append_line', 0, is_current_line )
		end if
		is_current_line	= as_line + space( 78 )
	end if
	uf_replace_string( is_current_line, as_item, ai_pos, ai_length )
end if

is_line_# = as_line


end subroutine

public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length);string	ls_right, &
			ls_left

ls_left				= LeftA( is_current_line, ai_pos - 1 )
ls_right				= RightA( is_current_line, &
							LenA( is_current_line ) - ( ai_pos + ai_length - 1 ) )

is_current_line	= LeftA( ls_left + LeftA(as_item, ai_length )  + ls_right + space(80), 80 )
end subroutine

public function boolean uf_create_overlay ();integer	li_ptr, &
			li_count

string	ls_data_object, &
			ls_detail_column, &
			ls_current_item

ls_data_object		= profilestring( is_ini_file, 'STX Header', 'DataObject', '' )
ls_detail_column	= profilestring( is_ini_file, 'STX Header', 'KeyDetailColumn', '' )
ib_error				= FALSE

if ls_data_object > '' then
	this.dataobject	= ls_data_object
	this.settransobject(	SQLCA )
	this.retrieve( il_key )

	li_count	= this.rowcount()
	for li_ptr = 1 to li_count
		if ls_detail_column > '' then
			ls_current_item	=	this.getitemstring( li_ptr, ls_detail_column )
		else
			ls_current_item	= ''
		end if

		if this.uf_generate_header( li_ptr ) then
			parent.triggerevent( 'ue_create_detail_overlay', 0, ls_current_item )			
		else
			parent.triggerevent( 'ue_error_occurred' )
			return FALSE
			exit
		end if
	next
	return TRUE
else
	parent.triggerevent( 'ue_error_occurred' )
	return FALSE
	messagebox( 'Monitor for Windows', "Header information can't be empty.", Information! )
end if


end function

