$PBExportHeader$u_dw_edi_ancestor.sru
$PBExportComments$(med)
forward
global type u_dw_edi_ancestor from datawindow
end type
end forward

global type u_dw_edi_ancestor from datawindow
int Width=1509
int Height=565
int TabOrder=1
boolean LiveScroll=true
end type
global u_dw_edi_ancestor u_dw_edi_ancestor

type variables
string	is_ini_file, &
	is_current_line = space( 80 ), &
	is_line_# = '00', &
	is_section, &
	is_parent_event = 'ue_dummy', &
	is_filter_column, &
	is_filter_value
	
long	il_key

boolean	ib_error, &
	ib_test = FALSE

u_dw_edi_error_log &
	idw_error_log

window &
	iw_parent


end variables

forward prototypes
public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length)
public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length)
public function boolean uf_create_overlay ()
public function boolean uf_generate_text (long al_row)
public subroutine uf_setup ()
public subroutine uf_validation (string as_column_name, string as_item, string as_ptr, string as_line, integer ai_pos, integer ai_length)
public subroutine uf_share_dw (window aw, datawindow adw)
end prototypes

public subroutine uf_output (string as_item, string as_line, integer ai_pos, integer ai_length);if is_line_# = '00' then
	is_current_line	= as_line + space( 78 )
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

string		ls_PBLName, &
			ls_data_object, &
			ls_detail_column, &
			ls_current_item, &
			ls_DWSyntax

ls_PBLName 		= profilestring ( is_ini_file, is_section, 'PblName', '' )
ls_data_object		= profilestring( is_ini_file, is_section, 'DataObject', '' )
ls_detail_column	= profilestring( is_ini_file, is_section, 'KeyDetailColumn', '' )
ib_error				= FALSE

IF ls_PBLName > '' AND ls_data_object > '' THEN
	ls_DWSyntax = LibraryExport ( ls_PBLName, ls_data_object , ExportDataWindow! )
	Create ( ls_DWSyntax )
ELSEif ls_data_object > '' then
	this.dataobject	= ls_data_object
else
	parent.triggerevent( 'ue_error_occurred' )
	return FALSE
	messagebox( 'Monitor for Windows', "Data object is missing in " + &
					is_ini_file + ".", Information! )
end if
//	Look for group by
this.settransobject(	SQLCA )
this.retrieve( il_key )
this.uf_setup ()

li_count	= this.rowcount()
for li_ptr = 1 to li_count
	if ls_detail_column > '' then
		ls_current_item	=	this.getitemstring( li_ptr, ls_detail_column )
	else
		ls_current_item	= ''
	end if
		if this.uf_generate_text( li_ptr ) then
		parent.triggerevent( is_parent_event, 0, ls_current_item )			
	else
		parent.triggerevent( 'ue_error_occurred' )
		return FALSE
		exit
	end if
next
return TRUE
end function

public function boolean uf_generate_text (long al_row);//This function will generate the flat overlay header information
string	ls_item = '*', &
			ls_line, &
			ls_column, &
			ls_type, &
			ls_datatype, &
			ls_item_id
			

integer	li_pos, &
			li_length, &
			li_ptr = 1, &
			li_sub_ptr = 0

boolean	lb_error = FALSE

ls_item_id	= string( li_ptr )
ls_item		= 	f_get_string_value( &
					profilestring( is_ini_file, is_section, &
					'Item' + ls_item_id, '!!' ) )


do while ls_item <> '!!' 

	ls_line	= profilestring( 	is_ini_file, is_section, &
											'Line' + ls_item_id, '00' )
	if ls_line = '00' then
		parent.triggerevent( 'ue_error_occurred' )
		messagebox( 'Monitor for Windows', 'Line# for ' + ls_item + ' is missing.', information! )
		lb_error	= TRUE
		exit
	else
		li_pos	= profileint( 	is_ini_file, is_section, &
										'Pos' + ls_item_id, 0 )
	end if
	
	if li_pos = 0 then
		parent.triggerevent( 'ue_error_occurred' )
		messagebox( 'Monitor for Windows', 'Pos for ' + ls_item + ' is missing.', information! )
		lb_error	= TRUE
		exit
	else
		li_length= profileint( 	is_ini_file, is_section, &
										'Length' + ls_item_id, 0 )
	end if

	if li_length = 0 then
		parent.triggerevent( 'ue_error_occurred' )
		messagebox( 'Monitor for Windows', 'Length for ' + ls_item + ' is missing.', information! )
		lb_error	= TRUE
		exit
	end if

	if LeftA( ls_item , 1 ) = '*' then
		if not ib_test then		//if this is real mode
			ls_column	= RightA( ls_item, LenA( ls_item  ) - 1 )
			ls_type		= upper( LeftA( this.describe( ls_column + '.type' ), 4 ) )
			IF ls_type = '!' THEN
				parent.TriggerEvent ( 'ue_error_occurred' )
				MessageBox ( 'Monitor for Windows', 'Column:' + ls_column + &
								'not found on datawindow.', information! )
				lb_error = TRUE
				Exit
			END IF
			ls_datatype		= upper( LeftA( this.describe( ls_column + '.coltype' ), 4 ) )
			if ls_datatype = 'CHAR' or ls_datatype = '!' then
				ls_item	= f_get_string_value( &
									this.getitemstring( al_row, ls_column ) )
				this.uf_validation( 	ls_column, ls_item, ls_item_id, &
											ls_line, li_pos, li_length )
			else
				parent.triggerevent( 'ue_error_occurred' )
				messagebox( 'Monitor for Windows', 'Column:' + ls_column + &
								'must have STRING type.', information! )
				lb_error	= TRUE
				exit				
			end if		
		else		//For test mode, just use name
			ls_item	= RightA( ls_item, LenA( ls_item )  - 1 )	
		end if
	end if

	uf_output( 	ls_item, ls_line, li_pos, li_length )

	li_sub_ptr ++
	ls_item_id	= string( li_ptr ) + '.' + string( li_sub_ptr )
	ls_item	= f_get_string_value( &
						profilestring( is_ini_file, is_section, &
						'Item' + ls_item_id  , '!!' ) )

	if ls_item = '!!'	then
		li_ptr ++
		li_sub_ptr 	= 0
		ls_item_id	= string( li_ptr )
		ls_item	= f_get_string_value( &
					profilestring( is_ini_file, is_section, &
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

public subroutine uf_setup ();//This function should be defined at descendant levels if needed.
end subroutine

public subroutine uf_validation (string as_column_name, string as_item, string as_ptr, string as_line, integer ai_pos, integer ai_length);string &
	ls_validation, &
	ls_message, &
	ls_rule

boolean &
	lb_valid = TRUE

if not isvalid( idw_error_log ) then		//idw_error_log is instantiated
	return											//by uf_share_dw() function
end if

ls_validation	= profilestring( 	is_ini_file, &
											is_section, &
											'Validation' + as_ptr  , '' )

if ls_validation > '' then
	ls_rule	= profilestring( is_ini_file, 'Validation Rule', ls_validation, '' )
	Choose Case ls_rule
		Case 'Not empty'
			lb_valid	= (as_item > '' )			
			ls_message	= 'Value should not be empty'
		Case 'Greater than zero'
			if isnumber( as_item ) then
				lb_valid	= (dec( as_item ) > 0 )
			else
				lb_valid	= FALSE
			end if
			ls_message	= 'Value should be greater than zero'
	End Choose
end if

if not lb_valid then
	idw_error_log.uf_add( 	as_column_name, as_item, as_line, ai_pos, &
									ai_length, ls_message )	
end if
end subroutine

public subroutine uf_share_dw (window aw, datawindow adw);if aw.openuserobject( this.idw_error_log, 1, 1 ) > 0 then
	this.iw_parent	= aw							//iw_parent is used in 'destructor'
	this.idw_error_log.visible	= FALSE
	adw.sharedata( this.idw_error_log )
end if
end subroutine

on destructor;if isvalid( this.idw_error_log ) then
	iw_parent.closeuserobject( this.idw_error_log )
end if
end on

