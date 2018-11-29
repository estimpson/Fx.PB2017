$PBExportHeader$u_edi_file_generator.sru
$PBExportComments$(med)
forward
global type u_edi_file_generator from u_edi_file_generator_ancestor
end type
type dw_1 from u_dw_edi_header within u_edi_file_generator
end type
type dw_2 from u_dw_edi_body within u_edi_file_generator
end type
type dw_3 from u_dw_edi_end within u_edi_file_generator
end type
end forward

global type u_edi_file_generator from u_edi_file_generator_ancestor
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
end type
global u_edi_file_generator u_edi_file_generator

on u_edi_file_generator.create
int iCurrent
call u_edi_file_generator_ancestor::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
this.Control[iCurrent+2]=dw_2
this.Control[iCurrent+3]=dw_3
end on

on u_edi_file_generator.destroy
call u_edi_file_generator_ancestor::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

type dw_flat_file from u_edi_file_generator_ancestor`dw_flat_file within u_edi_file_generator
int TabOrder=40
end type

type dw_1 from u_dw_edi_header within u_edi_file_generator
int X=348
int Y=929
int Width=915
int Height=129
int TabOrder=30
end type

on constructor;call u_dw_edi_header::constructor;parent.dw_header		= this
this.is_section		= 'STX Header'
this.is_parent_event	= 'ue_create_detail_overlay'
end on

type dw_2 from u_dw_edi_body within u_edi_file_generator
int X=348
int Y=1073
int Width=915
int Height=129
int TabOrder=20
end type

on constructor;call u_dw_edi_body::constructor;parent.dw_body		= this
this.is_section	= 'STX Body'

end on

type dw_3 from u_dw_edi_end within u_edi_file_generator
int X=348
int Y=1233
int Width=915
int Height=129
int TabOrder=10
end type

on constructor;call u_dw_edi_end::constructor;parent.dw_end		= this
this.is_section	= 'STX End'

end on

