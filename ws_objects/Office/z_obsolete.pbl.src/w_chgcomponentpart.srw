$PBExportHeader$w_chgcomponentpart.srw
forward
global type w_chgcomponentpart from Window
end type
type ddlb_2 from dropdownlistbox within w_chgcomponentpart
end type
type cb_2 from commandbutton within w_chgcomponentpart
end type
type cb_1 from commandbutton within w_chgcomponentpart
end type
type st_2 from statictext within w_chgcomponentpart
end type
type st_1 from statictext within w_chgcomponentpart
end type
type ddlb_1 from dropdownlistbox within w_chgcomponentpart
end type
end forward

global type w_chgcomponentpart from Window
int X=5
int Y=12
int Width=2903
int Height=1872
long BackColor=79741120
WindowState WindowState=maximized!
WindowType WindowType=child!
ddlb_2 ddlb_2
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
ddlb_1 ddlb_1
end type
global w_chgcomponentpart w_chgcomponentpart

forward prototypes
public subroutine wf_assignparts (ref dropdownlistbox addlb_parts, string as_part)
end prototypes

public subroutine wf_assignparts (ref dropdownlistbox addlb_parts, string as_part);int	li_index=0
string	ls_part, ls_oldpart, ls_class, ls_type
if LenA (as_part) > 0 then 
	addlb_parts.reset()
	select	part.class,
		part.type
	into	:ls_class,
		:ls_type
	from	part
	where	part = :as_part;
	
	declare part_list cursor for
	select	part.part
	from	part
	where	part <> :as_part and class = :ls_class and type = :ls_type
	order by part.part asc;
	Open	part_list;
	Fetch	part_list into :ls_part;
	Do While sqlca.sqlcode = 0
		li_index++
		addlb_parts.insertItem ( ls_part, li_index )	
		Fetch	part_list into :ls_part;
	Loop
	Close part_list ;
else	
	declare part_listall cursor for
	select	part.part
	from	part  
	order by part.part asc;
	Open	part_listall;
	Fetch	part_listall into :ls_part;
	Do While sqlca.sqlcode = 0
		li_index++
		addlb_parts.insertItem ( ls_part, li_index )	
		Fetch	part_listall into :ls_part;
	Loop
	Close part_listall;
end if 

/*
	Open	part_list;
	Fetch	part_list into :ls_part, :ls_class, :ls_type ;
	Do While sqlca.sqlcode = 0
		if len ( ls_oldpart) > 0 then 
			if ls_part <> ls_oldpart and ls_class = ls_oldclass and ls_type = ls_oldtype then 
				li_index++
				addlb_parts.insertItem ( ls_part, li_index )	
			end if
		else
			li_index++
			addlb_parts.insertItem ( ls_part, li_index )	
		end if 		
		Fetch	part_list into :ls_part, :ls_class, :ls_type ;
	Loop
	Close part_list ;
*/
end subroutine

on w_chgcomponentpart.create
this.ddlb_2=create ddlb_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.Control[]={this.ddlb_2,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.ddlb_1}
end on

on w_chgcomponentpart.destroy
destroy(this.ddlb_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_1)
end on

event open;wf_assignparts ( ddlb_1, '' ) 
ddlb_1.setfocus()
end event

type ddlb_2 from dropdownlistbox within w_chgcomponentpart
int X=1344
int Y=908
int Width=741
int Height=640
int TabOrder=20
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

type cb_2 from commandbutton within w_chgcomponentpart
int X=1344
int Y=1056
int Width=338
int Height=108
int TabOrder=30
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close ( w_chgcomponentpart )
end event

type cb_1 from commandbutton within w_chgcomponentpart
int X=1746
int Y=1056
int Width=338
int Height=108
int TabOrder=20
string Text="Ok"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long	ll_check
string	ls_oldpart, ls_newpart
ls_oldpart = ddlb_1.text
ls_newpart = ddlb_2.text
if LenA(ls_oldpart) > 0 then 
	if LenA(ls_newpart) > 0 then 
		declare	changecpart procedure for cdisp_chgcomponentpart
			:ls_oldpart,
			:ls_newpart
		using sqlca;
		
		sqlca.autocommit = true
		execute changecpart;

		if sqlca.sqlcode < 0 then
			rollback;
			messagebox (monsys.msg_title, sqlca.sqlerrtext, information! )
		else	  
			commit;			
			ddlb_2.reset()
			ddlb_1.reset()
			wf_assignparts ( ddlb_1, '' ) 
			ddlb_1.setfocus()
			messagebox (monsys.msg_title, 'Component part was changed successfully', information! )
		end if 
		close changecpart;
		sqlca.autocommit = false
	else
		messagebox (monsys.msg_title, 'Please enter a valid new part')
	end if
else
	messagebox (monsys.msg_title, 'Please enter a valid old part')
end if

end event

type st_2 from statictext within w_chgcomponentpart
int X=896
int Y=912
int Width=439
int Height=76
boolean Enabled=false
string Text="Select new Part:"
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

type st_1 from statictext within w_chgcomponentpart
int X=896
int Y=760
int Width=439
int Height=76
boolean Enabled=false
string Text="Select Old Part:"
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

type ddlb_1 from dropdownlistbox within w_chgcomponentpart
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

event selectionchanged;wf_assignparts ( ddlb_2, text ) 
end event

