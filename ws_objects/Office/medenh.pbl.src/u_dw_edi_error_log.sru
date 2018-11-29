$PBExportHeader$u_dw_edi_error_log.sru
$PBExportComments$(med) datawindow user object to keep error log
forward
global type u_dw_edi_error_log from datawindow
end type
end forward

global type u_dw_edi_error_log from datawindow
int Width=2030
int Height=513
int TabOrder=1
string DataObject="d_dw_error_list_for_edi"
boolean LiveScroll=true
end type
global u_dw_edi_error_log u_dw_edi_error_log

forward prototypes
public subroutine uf_add (string as_column, string as_value, string as_line, integer ai_pos, integer ai_length, string as_message)
end prototypes

public subroutine uf_add (string as_column, string as_value, string as_line, integer ai_pos, integer ai_length, string as_message);integer &
	li_row

this.insertrow( 0 )
li_row	= this.rowcount()

this.setitem( li_row, 'column_name', 	as_column )
this.setitem( li_row, 'col_value', 		as_value )
this.setitem( li_row, 'col_line', 		as_line )
this.setitem( li_row, 'col_pos', 		ai_pos )
this.setitem( li_row, 'col_length', 	ai_length )
this.setitem( li_row, 'message',			as_message )
end subroutine

