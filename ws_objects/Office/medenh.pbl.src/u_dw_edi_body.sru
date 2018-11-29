$PBExportHeader$u_dw_edi_body.sru
$PBExportComments$(med)
forward
global type u_dw_edi_body from u_dw_edi_ancestor
end type
end forward

global type u_dw_edi_body from u_dw_edi_ancestor
end type
global u_dw_edi_body u_dw_edi_body

forward prototypes
public subroutine uf_setup ()
end prototypes

public subroutine uf_setup ();is_filter_column	= profilestring( is_ini_file, 'STX Body', 'FilterColumn', '' )
if is_filter_column > '' then
	if not isnull( is_filter_value ) then
		this.setfilter( is_filter_column + "= '" + is_filter_value	 + "'" )
		this.filter()
	end if
end if
end subroutine

