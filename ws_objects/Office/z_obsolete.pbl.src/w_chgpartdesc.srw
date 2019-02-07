$PBExportHeader$w_chgpartdesc.srw
forward
global type w_chgpartdesc from Window
end type
type cb_2 from commandbutton within w_chgpartdesc
end type
type cb_1 from commandbutton within w_chgpartdesc
end type
type st_2 from statictext within w_chgpartdesc
end type
type sle_1 from singlelineedit within w_chgpartdesc
end type
type st_1 from statictext within w_chgpartdesc
end type
type ddlb_1 from dropdownlistbox within w_chgpartdesc
end type
end forward

global type w_chgpartdesc from Window
int X=5
int Y=12
int Width=2903
int Height=1872
long BackColor=79741120
WindowState WindowState=maximized!
WindowType WindowType=child!
cb_2 cb_2
cb_1 cb_1
st_2 st_2
sle_1 sle_1
st_1 st_1
ddlb_1 ddlb_1
end type
global w_chgpartdesc w_chgpartdesc

forward prototypes
public subroutine wf_assignparts (ref dropdownlistbox addlb_parts)
end prototypes

public subroutine wf_assignparts (ref dropdownlistbox addlb_parts);int	li_index=0
string	ls_part
declare part_list cursor for
select	part.part
from	part  
order by part.part asc;

Open	part_list;
Fetch	part_list into :ls_part ;
Do While sqlca.sqlcode = 0
	li_index++
	addlb_parts.insertItem ( ls_part, li_index )
	Fetch part_list into :ls_part ;
Loop
Close part_list ;
end subroutine

on w_chgpartdesc.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_1=create sle_1
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_2,&
this.sle_1,&
this.st_1,&
this.ddlb_1}
end on

on w_chgpartdesc.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

event open;wf_assignparts(ddlb_1)

ddlb_1.setfocus()
end event

type cb_2 from commandbutton within w_chgpartdesc
int X=1344
int Y=1056
int Width=338
int Height=108
int TabOrder=40
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( w_chgpartdesc )
end event

type cb_1 from commandbutton within w_chgpartdesc
int X=1746
int Y=1056
int Width=338
int Height=108
int TabOrder=30
string Text="Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string	ls_part, ls_description
ls_part = ddlb_1.text
ls_description = sle_1.text
if LenA(ls_part) > 0 then 
	if LenA(ls_description) > 0 then 
		declare	changedesc procedure for cdisp_changedescription 
			:ls_part,
			:ls_description
		using sqlca;
		
		sqlca.autocommit = true
		execute changedesc;
		
		if sqlca.sqlcode < 0 then
			rollback;			
			messagebox (monsys.msg_title, sqlca.sqlerrtext, information! )
		else	  
			commit;
			ddlb_1.reset()
			wf_assignparts(ddlb_1)
			sle_1.text = ''
			ddlb_1.setfocus()
			messagebox (monsys.msg_title, 'Description change was successful', information! )
		end if 
		close changedesc;
		sqlca.autocommit = false
		
	else
		messagebox (monsys.msg_title, 'Please enter a valid description')
	end if
else
	messagebox (monsys.msg_title, 'Invalid Part')
end if
end event

type st_2 from statictext within w_chgpartdesc
int X=841
int Y=912
int Width=489
int Height=76
boolean Enabled=false
string Text="Enter Description:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_chgpartdesc
int X=1344
int Y=912
int Width=741
int Height=100
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_chgpartdesc
int X=841
int Y=760
int Width=489
int Height=76
boolean Enabled=false
string Text="Select a Part:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_chgpartdesc
int X=1344
int Y=760
int Width=741
int Height=640
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

