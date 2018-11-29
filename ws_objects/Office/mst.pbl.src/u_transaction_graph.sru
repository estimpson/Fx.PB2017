$PBExportHeader$u_transaction_graph.sru
forward
global type u_transaction_graph from UserObject
end type
type mle_trans_info from multilineedit within u_transaction_graph
end type
type p_indicator from picture within u_transaction_graph
end type
type st_3 from statictext within u_transaction_graph
end type
type st_outsideproc from statictext within u_transaction_graph
end type
type st_2 from statictext within u_transaction_graph
end type
type st_correct from statictext within u_transaction_graph
end type
type st_1 from statictext within u_transaction_graph
end type
type st_weight from statictext within u_transaction_graph
end type
type st_20 from statictext within u_transaction_graph
end type
type st_retvendor from statictext within u_transaction_graph
end type
type st_18 from statictext within u_transaction_graph
end type
type st_17 from statictext within u_transaction_graph
end type
type st_16 from statictext within u_transaction_graph
end type
type st_15 from statictext within u_transaction_graph
end type
type st_14 from statictext within u_transaction_graph
end type
type st_13 from statictext within u_transaction_graph
end type
type st_12 from statictext within u_transaction_graph
end type
type st_11 from statictext within u_transaction_graph
end type
type st_10 from statictext within u_transaction_graph
end type
type st_delete from statictext within u_transaction_graph
end type
type st_shipping from statictext within u_transaction_graph
end type
type st_receiving from statictext within u_transaction_graph
end type
type st_combine from statictext within u_transaction_graph
end type
type st_qc from statictext within u_transaction_graph
end type
type st_breakout from statictext within u_transaction_graph
end type
type st_matissue from statictext within u_transaction_graph
end type
type st_jobcomp from statictext within u_transaction_graph
end type
type st_transfer from statictext within u_transaction_graph
end type
type gb_1 from groupbox within u_transaction_graph
end type
end forward

global type u_transaction_graph from UserObject
int Width=828
int Height=773
long BackColor=12632256
mle_trans_info mle_trans_info
p_indicator p_indicator
st_3 st_3
st_outsideproc st_outsideproc
st_2 st_2
st_correct st_correct
st_1 st_1
st_weight st_weight
st_20 st_20
st_retvendor st_retvendor
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_delete st_delete
st_shipping st_shipping
st_receiving st_receiving
st_combine st_combine
st_qc st_qc
st_breakout st_breakout
st_matissue st_matissue
st_jobcomp st_jobcomp
st_transfer st_transfer
gb_1 gb_1
end type
global u_transaction_graph u_transaction_graph

forward prototypes
public subroutine uf_show_legend (string l_s_transtype)
public function long uf_legend_color (string l_s_TransType)
end prototypes

public subroutine uf_show_legend (string l_s_transtype);p_indicator.Visible	= TRUE

Choose Case l_s_TransType
	CASE 'J'
		p_indicator.Y = st_jobcomp.Y
	CASE 'T'
		p_indicator.Y = st_transfer.Y
	CASE 'Q'
		p_indicator.Y = st_qc.Y
	CASE 'B'
		p_indicator.Y = st_breakout.Y
	CASE 'C'
		p_indicator.Y = st_combine.Y
	CASE 'M'
		p_indicator.Y = st_matissue.Y
	CASE 'R'
		p_indicator.Y = st_receiving.Y
	CASE 'S'
		p_indicator.Y = st_shipping.Y
	Case 'D'
		p_indicator.Y = st_delete.Y
	Case 'O'
		p_indicator.Y = st_outsideproc.Y
	Case 'V'
		p_indicator.Y = st_RetVendor.Y
	Case 'W'
		p_indicator.Y = st_Weight.Y
	Case 'X'
		p_indicator.Y = st_Correct.Y
	Case Else
		p_indicator.Visible	= FALSE
End Choose



end subroutine

public function long uf_legend_color (string l_s_TransType);Long	l_l_Color

Choose Case l_s_TransType
	CASE 'J'
		l_l_Color = st_jobcomp.BackColor
	CASE 'T'
		l_l_Color = st_transfer.BackColor
	CASE 'Q'
		l_l_Color = st_qc.BackColor
	CASE 'B'
		l_l_Color = st_breakout.BackColor
	CASE 'C'
		l_l_Color = st_combine.BackColor
	CASE 'M'
		l_l_Color = st_matissue.BackColor
	CASE 'R'
		l_l_Color = st_receiving.BackColor
	CASE 'S'
		l_l_Color = st_shipping.BackColor
	Case 'D'
		l_l_Color = st_delete.BackColor
	Case 'O'
		l_l_Color = st_outsideproc.BackColor
	Case 'V'
		l_l_Color = st_RetVendor.BackColor
	Case 'W'
		l_l_Color = st_Weight.BackColor
	Case 'X'
		l_l_Color = st_Correct.BackColor
	Case Else
		l_l_Color = 0
End Choose

Return l_l_Color



end function

on u_transaction_graph.create
this.mle_trans_info=create mle_trans_info
this.p_indicator=create p_indicator
this.st_3=create st_3
this.st_outsideproc=create st_outsideproc
this.st_2=create st_2
this.st_correct=create st_correct
this.st_1=create st_1
this.st_weight=create st_weight
this.st_20=create st_20
this.st_retvendor=create st_retvendor
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_delete=create st_delete
this.st_shipping=create st_shipping
this.st_receiving=create st_receiving
this.st_combine=create st_combine
this.st_qc=create st_qc
this.st_breakout=create st_breakout
this.st_matissue=create st_matissue
this.st_jobcomp=create st_jobcomp
this.st_transfer=create st_transfer
this.gb_1=create gb_1
this.Control[]={ this.mle_trans_info,&
this.p_indicator,&
this.st_3,&
this.st_outsideproc,&
this.st_2,&
this.st_correct,&
this.st_1,&
this.st_weight,&
this.st_20,&
this.st_retvendor,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_delete,&
this.st_shipping,&
this.st_receiving,&
this.st_combine,&
this.st_qc,&
this.st_breakout,&
this.st_matissue,&
this.st_jobcomp,&
this.st_transfer,&
this.gb_1}
end on

on u_transaction_graph.destroy
destroy(this.mle_trans_info)
destroy(this.p_indicator)
destroy(this.st_3)
destroy(this.st_outsideproc)
destroy(this.st_2)
destroy(this.st_correct)
destroy(this.st_1)
destroy(this.st_weight)
destroy(this.st_20)
destroy(this.st_retvendor)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_delete)
destroy(this.st_shipping)
destroy(this.st_receiving)
destroy(this.st_combine)
destroy(this.st_qc)
destroy(this.st_breakout)
destroy(this.st_matissue)
destroy(this.st_jobcomp)
destroy(this.st_transfer)
destroy(this.gb_1)
end on

type mle_trans_info from multilineedit within u_transaction_graph
int X=74
int Y=97
int Width=348
int Height=577
int TabOrder=10
boolean Border=false
boolean AutoVScroll=true
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_indicator from picture within u_transaction_graph
int X=458
int Y=705
int Width=55
int Height=49
boolean Visible=false
string PictureName="logo2.bmp"
boolean FocusRectangle=false
end type

type st_3 from statictext within u_transaction_graph
int X=531
int Y=657
int Width=257
int Height=49
boolean Enabled=false
string Text="Outside Proc"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_outsideproc from statictext within u_transaction_graph
int X=458
int Y=657
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=8421504
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_transaction_graph
int X=531
int Y=609
int Width=238
int Height=49
boolean Enabled=false
string Text="Correct"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_correct from statictext within u_transaction_graph
int X=458
int Y=609
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=8421376
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_transaction_graph
int X=531
int Y=561
int Width=238
int Height=49
boolean Enabled=false
string Text="Weight"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_weight from statictext within u_transaction_graph
int X=458
int Y=561
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=8388608
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_20 from statictext within u_transaction_graph
int X=531
int Y=513
int Width=238
int Height=49
boolean Enabled=false
string Text="Ret Vendor"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_retvendor from statictext within u_transaction_graph
int X=458
int Y=513
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=32896
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_18 from statictext within u_transaction_graph
int X=531
int Y=465
int Width=238
int Height=49
boolean Enabled=false
string Text="Delete"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_17 from statictext within u_transaction_graph
int X=531
int Y=417
int Width=238
int Height=49
boolean Enabled=false
string Text="Shipping"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_16 from statictext within u_transaction_graph
int X=531
int Y=369
int Width=238
int Height=49
boolean Enabled=false
string Text="Receiving"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_15 from statictext within u_transaction_graph
int X=531
int Y=321
int Width=238
int Height=49
boolean Enabled=false
string Text="Combine"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within u_transaction_graph
int X=531
int Y=273
int Width=238
int Height=49
boolean Enabled=false
string Text="Q.C."
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within u_transaction_graph
int X=531
int Y=225
int Width=238
int Height=49
boolean Enabled=false
string Text="Break Out"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within u_transaction_graph
int X=531
int Y=177
int Width=238
int Height=49
boolean Enabled=false
string Text="Mat Issue"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within u_transaction_graph
int X=531
int Y=129
int Width=238
int Height=49
boolean Enabled=false
string Text="Job Comp"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within u_transaction_graph
int X=531
int Y=81
int Width=238
int Height=49
boolean Enabled=false
string Text="Transfer"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_delete from statictext within u_transaction_graph
int X=458
int Y=465
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=32768
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_shipping from statictext within u_transaction_graph
int X=458
int Y=417
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=8388736
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_receiving from statictext within u_transaction_graph
int X=458
int Y=369
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=128
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_combine from statictext within u_transaction_graph
int X=458
int Y=321
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_qc from statictext within u_transaction_graph
int X=458
int Y=273
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=65535
long BackColor=65535
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_breakout from statictext within u_transaction_graph
int X=458
int Y=225
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=65280
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_matissue from statictext within u_transaction_graph
int X=458
int Y=177
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711935
long BackColor=16711935
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_jobcomp from statictext within u_transaction_graph
int X=458
int Y=129
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_transfer from statictext within u_transaction_graph
int X=458
int Y=81
int Width=55
int Height=49
boolean Enabled=false
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16711680
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within u_transaction_graph
int X=19
int Y=49
int Width=421
int Height=657
int TabOrder=20
long TextColor=16711680
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

