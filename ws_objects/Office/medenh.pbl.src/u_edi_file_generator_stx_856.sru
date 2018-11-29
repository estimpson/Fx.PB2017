$PBExportHeader$u_edi_file_generator_stx_856.sru
$PBExportComments$(med)
forward
global type u_edi_file_generator_stx_856 from u_edi_file_generator_ancestor
end type
type dw_2 from u_dw_edi_body within u_edi_file_generator_stx_856
end type
type dw_3 from u_dw_edi_end within u_edi_file_generator_stx_856
end type
type dw_header_stx from u_dw_edi_header_stx_856 within u_edi_file_generator_stx_856
end type
end forward

global type u_edi_file_generator_stx_856 from u_edi_file_generator_ancestor
int Height=868
dw_2 dw_2
dw_3 dw_3
dw_header_stx dw_header_stx
end type
global u_edi_file_generator_stx_856 u_edi_file_generator_stx_856

type variables

end variables

forward prototypes
public subroutine uf_correct_error (string as_item, string as_line, integer ai_pos, integer ai_length)
public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length)
end prototypes

public subroutine uf_correct_error (string as_item, string as_line, integer ai_pos, integer ai_length);string &
	ls_line

boolean &
	lb_found	= FALSE

integer &
	li_ptr, &
	li_count

li_count	= dw_flat_file.rowcount()
li_ptr	= 1

do while (not lb_found ) and ( li_ptr <= li_count )
	ls_line	= dw_flat_file.getitemstring( li_ptr, 1 )
	if LeftA( ls_line, 2 ) =  as_line and MidA(ls_line, ai_pos,1) = ' ' then
		lb_found	= TRUE
	else
		li_ptr ++
	end if
loop

if lb_found	then
	uf_replace_string(  ls_line, as_item, ai_pos, ai_length )
	dw_flat_file.setitem( li_ptr, 1, ls_line )	

end if
end subroutine

public subroutine uf_replace_string (ref string as_line, string as_item, integer ai_pos, integer ai_length);string	ls_right, &
			ls_left

ls_left	= 	LeftA( 	as_line, ai_pos - 1 )
ls_right	= 	RightA( 	as_line, &
							LenA( as_line ) - ( ai_pos + ai_length - 1 ) )

as_line	= LeftA( ls_left + LeftA(as_item + space( ai_length ), ai_length )  + ls_right + space(80), 80 )
end subroutine

on u_edi_file_generator_stx_856.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_header_stx=create dw_header_stx
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.dw_header_stx
end on

on u_edi_file_generator_stx_856.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_header_stx)
end on

type dw_flat_file from u_edi_file_generator_ancestor`dw_flat_file within u_edi_file_generator_stx_856
int TabOrder=40
end type

type dw_2 from u_dw_edi_body within u_edi_file_generator_stx_856
int X=347
int Y=1072
int Width=914
int Height=128
int TabOrder=30
end type

on constructor;call u_dw_edi_body::constructor;parent.dw_body		= this
this.is_section	= 'STX Body'

end on

type dw_3 from u_dw_edi_end within u_edi_file_generator_stx_856
int X=347
int Y=1232
int Width=914
int Height=128
int TabOrder=20
end type

on constructor;call u_dw_edi_end::constructor;parent.dw_end		= this
this.is_section	= 'STX End'

end on

type dw_header_stx from u_dw_edi_header_stx_856 within u_edi_file_generator_stx_856
int X=347
int Y=912
int Width=914
int Height=128
int TabOrder=10
string DataObject="d_dw_shipper_header_for_stx"
end type

on constructor;call u_dw_edi_header_stx_856::constructor;parent.dw_header		= this
this.is_section		= 'STX Header'
this.is_parent_event	= 'ue_create_detail_overlay'
end on

