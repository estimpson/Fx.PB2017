$PBExportHeader$u_mle_trans_detail.sru
$PBExportComments$(mst)
forward
global type u_mle_trans_detail from UserObject
end type
type st_1 from statictext within u_mle_trans_detail
end type
type em_span from editmask within u_mle_trans_detail
end type
type mle_detail from multilineedit within u_mle_trans_detail
end type
end forward

global type u_mle_trans_detail from UserObject
int Width=1121
int Height=85
boolean Border=true
long BackColor=12632256
event ue_change_span pbm_custom01
st_1 st_1
em_span em_span
mle_detail mle_detail
end type
global u_mle_trans_detail u_mle_trans_detail

on ue_change_span;parent.triggerevent( 'ue_change_span' )
end on

on u_mle_trans_detail.create
this.st_1=create st_1
this.em_span=create em_span
this.mle_detail=create mle_detail
this.Control[]={ this.st_1,&
this.em_span,&
this.mle_detail}
end on

on u_mle_trans_detail.destroy
destroy(this.st_1)
destroy(this.em_span)
destroy(this.mle_detail)
end on

type st_1 from statictext within u_mle_trans_detail
int X=37
int Y=5
int Width=855
int Height=73
boolean Enabled=false
string Text="Hour Span for Job Completion Search:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_span from editmask within u_mle_trans_detail
int X=933
int Width=165
int Height=65
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.00"
boolean Spin=true
double Increment=1
string MinMax="0~~24"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on constructor;this.text	= '0.5'
end on

on modified;parent.triggerevent( 'ue_change_span' )
end on

type mle_detail from multilineedit within u_mle_trans_detail
int X=10
int Y=89
int Width=1134
int Height=225
int TabOrder=20
boolean Visible=false
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

