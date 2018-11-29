$PBExportHeader$w_alternative_parts_setup.srw
$PBExportComments$mad
forward
global type w_alternative_parts_setup from Window
end type
type dw_alt_list from datawindow within w_alternative_parts_setup
end type
type st_3 from statictext within w_alternative_parts_setup
end type
type st_2 from statictext within w_alternative_parts_setup
end type
type dw_part_list from datawindow within w_alternative_parts_setup
end type
type st_1 from statictext within w_alternative_parts_setup
end type
type ddlb_top_part from dropdownlistbox within w_alternative_parts_setup
end type
end forward

global type w_alternative_parts_setup from Window
int X=0
int Y=0
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_open pbm_custom01
dw_alt_list dw_alt_list
st_3 st_3
st_2 st_2
dw_part_list dw_part_list
st_1 st_1
ddlb_top_part ddlb_top_part
end type
global w_alternative_parts_setup w_alternative_parts_setup

type variables
boolean		ib_to_alt,&
		ib_from_alt
end variables

forward prototypes
public subroutine wf_build_part_list (ref dropdownlistbox asddlb_list)
public function boolean wf_check_if_valid (string as_main_part, string as_alt_part)
end prototypes

on ue_open;wf_build_part_list ( ddlb_top_part )
end on

public subroutine wf_build_part_list (ref dropdownlistbox asddlb_list);string	ls_part

DECLARE part_list CURSOR FOR  
 SELECT part.part  
   FROM part  ;

Open part_list;
Fetch part_list into :ls_part;
Do While sqlca.sqlcode = 0
	asddlb_list.AddItem ( ls_part )
	Fetch part_list into :ls_part;
Loop
Close part_list;

end subroutine

public function boolean wf_check_if_valid (string as_main_part, string as_alt_part);int		li_sqlca_code,&
			li_count1,&
			li_count2
string	ls_code


// Check package types
SELECT count(part_packaging.part)  
  INTO :li_count1
  FROM part_packaging  
 WHERE part_packaging.part = :as_main_part   ;

SELECT count(part_packaging.part)  
  INTO :li_count2
  FROM part_packaging  
 WHERE part_packaging.part = :as_alt_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE comparison CURSOR FOR  
 SELECT part_packaging.code  
   FROM part_packaging  
  WHERE part_packaging.part = :as_main_part  ;

Open comparison ;
Fetch comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_packaging.part)
     INTO :li_count1  
     FROM part_packaging  
    WHERE ( part_packaging.part = :as_alt_part ) AND  
          ( part_packaging.code = :ls_code )   ;

	if li_count1 < 1 then
		sqlca.sqlcode = -1
	end if

	li_sqlca_code = sqlca.sqlcode

	Fetch comparison into :ls_code;

Loop
Close comparison ;

if li_sqlca_code = -1 then
	return FALSE
end if

SELECT count(part_unit_conversion.part)  
  INTO :li_count1
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :as_main_part   ;

SELECT count(part_unit_conversion.part)  
  INTO :li_count2
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :as_alt_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE unit_comparison CURSOR FOR  
 SELECT part_unit_conversion.code  
   FROM part_unit_conversion  
  WHERE part_unit_conversion.part = :as_main_part  ;

Open unit_comparison ;
Fetch unit_comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_unit_conversion.part)
     INTO :li_count1  
     FROM part_unit_conversion  
    WHERE ( part_unit_conversion.part = :as_alt_part ) AND  
          ( part_unit_conversion.code = :ls_code )   ;

	if li_count1 < 1 then
		sqlca.sqlcode = -1
	end if

	li_sqlca_code = sqlca.sqlcode

	Fetch unit_comparison into :ls_code;

Loop
Close unit_comparison ;

if li_sqlca_code = -1 then
	return FALSE
else
	return TRUE
end if

end function

on activate;if gnv_App.of_GetFrame().MenuName <> "m_scale_limit_parts_menu" then &
	gnv_App.of_GetFrame().ChangeMenu ( m_scale_limit_parts_menu )
end on

on w_alternative_parts_setup.create
this.dw_alt_list=create dw_alt_list
this.st_3=create st_3
this.st_2=create st_2
this.dw_part_list=create dw_part_list
this.st_1=create st_1
this.ddlb_top_part=create ddlb_top_part
this.Control[]={this.dw_alt_list,&
this.st_3,&
this.st_2,&
this.dw_part_list,&
this.st_1,&
this.ddlb_top_part}
end on

on w_alternative_parts_setup.destroy
destroy(this.dw_alt_list)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_part_list)
destroy(this.st_1)
destroy(this.ddlb_top_part)
end on

on open;PostEvent ( "ue_open" )
end on

type dw_alt_list from datawindow within w_alternative_parts_setup
event ue_add_item pbm_custom01
int X=1993
int Y=208
int Width=841
int Height=1200
int TabOrder=30
string DragIcon="monitor.ico"
string DataObject="d_part_list_alternative"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_add_item;if ib_to_alt then
	if wf_check_if_valid ( ddlb_top_part.Text, dw_part_list.GetItemString ( dw_part_list.GetRow ( ), "part" ) ) then
		ib_to_alt = FALSE
		InsertRow ( 0 )
		SetItem ( RowCount ( ), "alt_part", dw_part_list.GetItemString ( dw_part_list.GetRow ( ), "part" ) )
		SetItem ( RowCount ( ), "main_part", ddlb_top_part.Text )
		AcceptText ( )
		if Update ( ) = 1 then
			commit;
		else
			rollback;
			DeleteRow ( RowCount ( ) )
			MessageBox ( "Database Error", "Unable to save alternate part!", StopSign! )
		end if
	else
		MessageBox ( "Error", "This part has a different properties than the main part.", StopSign! )
	end if
else
	ib_to_alt = FALSE
	ib_from_alt = FALSE
end if
end on

on dragdrop;PostEvent ( "ue_add_item" )
end on

on clicked;long		ll_row

ll_row = GetClickedRow ( )

if ll_row < 1 then return

ib_from_alt = TRUE

Drag ( Begin! )
end on

on constructor;SetTransObject ( sqlca )
end on

type st_3 from statictext within w_alternative_parts_setup
int X=1993
int Y=128
int Width=841
int Height=80
boolean Enabled=false
boolean Border=true
string Text="Alternate Parts"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_alternative_parts_setup
int X=37
int Y=128
int Width=1938
int Height=80
boolean Enabled=false
boolean Border=true
string Text="Possible Parts"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_part_list from datawindow within w_alternative_parts_setup
int X=37
int Y=208
int Width=1938
int Height=1200
int TabOrder=20
string DragIcon="monitor.ico"
string DataObject="d_part_limit_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on dragdrop;if ib_from_alt then
	ib_from_alt = FALSE
	dw_alt_list.DeleteRow ( dw_alt_list.GetRow ( ) )
	if dw_alt_list.Update ( ) = 1 then
		commit;
	else
		rollback;
		dw_alt_list.Retrieve ( ddlb_top_part.Text )
		MessageBox ( "Database Error", "Unable to delete alternate part!", StopSign! )
	end if
else
	ib_from_alt = FALSE
	ib_to_alt = FALSE
end if
end on

on clicked;long		ll_row

ll_row = GetClickedRow ( )

if ll_row < 1 then return

ib_to_alt = TRUE

SetRow ( ll_row )
Drag ( Begin! )
end on

on constructor;SetTransObject ( sqlca )
end on

type st_1 from statictext within w_alternative_parts_setup
int X=37
int Y=32
int Width=311
int Height=72
boolean Enabled=false
string Text="Main Part:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_top_part from dropdownlistbox within w_alternative_parts_setup
int X=366
int Y=16
int Width=1042
int Height=1040
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;dw_part_list.Retrieve (  )
dw_alt_list.Retrieve ( Text )

end on

