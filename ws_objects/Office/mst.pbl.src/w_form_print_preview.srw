$PBExportHeader$w_form_print_preview.srw
$PBExportComments$Generic form print preview window
forward
global type w_form_print_preview from window
end type
type st_form from statictext within w_form_print_preview
end type
end forward

global type w_form_print_preview from window
boolean visible = false
integer width = 1623
integer height = 956
boolean enabled = false
boolean titlebar = true
string title = "Preview "
long backcolor = 12632256
event print pbm_custom01
event zoom pbm_custom02
event pro_cert pbm_custom03
st_form st_form
end type
global w_form_print_preview w_form_print_preview

type variables
st_print_preview_generic stParm
                        
String s_printed_status

Long lCurrentDocument
Long lPosition

Boolean bBatch
Boolean	ib_MissingData
Boolean  bprocess = False
boolean  i_b_quick_shipper
Integer i_row = 1


end variables

event open;st_generic_Structure l_st_parm
window     				l_w_name

stParm = Message.PowerObjectParm

l_st_parm.value1 =  string ( stparm.document_number )
l_st_parm.value11 = stparm.form_type

setnull( l_st_parm.value12 )

IF IsValid ( gnv_App.of_GetFrame() ) THEN
	OpenSheetWithParm ( w_report_view, l_st_parm, gnv_App.of_GetFrame(), 0, Original! )
ELSE
	OpenWithParm ( w_report_view, l_st_parm )
END IF

close ( this )

Return 0

end event

on w_form_print_preview.create
this.st_form=create st_form
this.Control[]={this.st_form}
end on

on w_form_print_preview.destroy
destroy(this.st_form)
end on

type st_form from statictext within w_form_print_preview
integer x = 3072
integer y = 32
integer width = 1134
integer height = 68
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

