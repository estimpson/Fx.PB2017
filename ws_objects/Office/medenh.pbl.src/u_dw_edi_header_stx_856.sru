$PBExportHeader$u_dw_edi_header_stx_856.sru
$PBExportComments$(med)
forward
global type u_dw_edi_header_stx_856 from u_dw_edi_header
end type
end forward

global type u_dw_edi_header_stx_856 from u_dw_edi_header
end type
global u_dw_edi_header_stx_856 u_dw_edi_header_stx_856

type variables
string &
	is_purpose_code = '00', &
	is_partial_complete = ''
end variables

forward prototypes
public subroutine uf_setup ()
end prototypes

public subroutine uf_setup ();super::uf_setup()
//if this.rowcount() > 0 then
//	this.setitem( 1, 'purpose_code', is_purpose_code )
//	this.setitem( 1, 'partial_complete', is_partial_complete )
//end if
end subroutine

