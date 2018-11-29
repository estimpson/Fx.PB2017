$PBExportHeader$u_job_info.sru
forward
global type u_job_info from UserObject
end type
type sle_percentage from singlelineedit within u_job_info
end type
type st_percentage from statictext within u_job_info
end type
type st_6 from statictext within u_job_info
end type
type dw_1 from datawindow within u_job_info
end type
type sle_base from singlelineedit within u_job_info
end type
end forward

global type u_job_info from UserObject
int Width=1783
int Height=1444
boolean Border=true
long BackColor=77971394
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event ue_setup ( st_generic_structure a_st_parm )
event ue_save pbm_custom01
sle_percentage sle_percentage
st_percentage st_percentage
st_6 st_6
dw_1 dw_1
sle_base sle_base
end type
global u_job_info u_job_info

forward prototypes
public subroutine uf_display_percentage (integer a_i_percentage)
public function integer uf_get_percentage (string a_s_workorder)
end prototypes

event ue_setup;this.dw_1.retrieve ( a_st_parm.value2 )

uf_display_percentage ( uf_get_percentage (a_st_parm.value2) )
end event

event ue_save;IF this.dw_1.update() = 1 THEN
	COMMIT ;
ELSE
	ROLLBACK ;
END IF
end event

public subroutine uf_display_percentage (integer a_i_percentage);String szDigit

sle_percentage.visible	= FALSE
sle_percentage.width		= 0

sle_percentage.width		= sle_base.width * a_i_Percentage / 100
sle_percentage.visible	= TRUE

st_percentage.text		= String(a_i_Percentage) + " %"
end subroutine

public function integer uf_get_percentage (string a_s_workorder);//************************************************************************
//* Declaration
//************************************************************************
Decimal	nQtyRequired		//Qty required
Decimal	nQtyCompleted		//Qty completed
Decimal	nPercentage			//Current percentage
Decimal	nAverage				//Average percentage

Integer	iCount				//Count number

//************************************************************************
//* Initialization
//************************************************************************

DECLARE 	JobDetailCur CURSOR FOR  
SELECT 	qty_required, qty_completed  
FROM 		workorder_detail 
WHERE  	workorder = :a_s_WorkOrder;

iCount	= 0
nAverage	= 0

//************************************************************************
//* Main Routine
//************************************************************************


Open JobDetailCur;

Fetch JobDetailCur into :nQtyRequired, :nQtyCompleted;

Do while sqlca.sqlcode = 0

	iCount ++
	If nQtyRequired > 0 then
		nAverage	= nAverage + (100 * nQtyCompleted / nQtyRequired)
	End If	

	Fetch JobDetailCur into :nQtyRequired, :nQtyCompleted;
Loop

Close JobDetailCur;

If iCount > 0 then
	Return ( nAverage / iCount )
Else
	Return 0
End If



end function

on u_job_info.create
this.sle_percentage=create sle_percentage
this.st_percentage=create st_percentage
this.st_6=create st_6
this.dw_1=create dw_1
this.sle_base=create sle_base
this.Control[]={this.sle_percentage,&
this.st_percentage,&
this.st_6,&
this.dw_1,&
this.sle_base}
end on

on u_job_info.destroy
destroy(this.sle_percentage)
destroy(this.st_percentage)
destroy(this.st_6)
destroy(this.dw_1)
destroy(this.sle_base)
end on

type sle_percentage from singlelineedit within u_job_info
int X=649
int Y=1116
int Width=78
int Height=60
BorderStyle BorderStyle=StyleRaised!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=8388608
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_percentage from statictext within u_job_info
int X=357
int Y=1112
int Width=247
int Height=60
boolean Enabled=false
string Text="0 %"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within u_job_info
int X=37
int Y=1112
int Width=306
int Height=64
boolean Enabled=false
string Text="Completion"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within u_job_info
int X=9
int Y=8
int Width=1751
int Height=1072
int TabOrder=10
string DataObject="d_job_information"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;settransobject ( sqlca )
end event

type sle_base from singlelineedit within u_job_info
int X=640
int Y=1108
int Width=1120
int Height=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

