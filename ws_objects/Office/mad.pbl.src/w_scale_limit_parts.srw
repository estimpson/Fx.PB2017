$PBExportHeader$w_scale_limit_parts.srw
forward
global type w_scale_limit_parts from Window
end type
type st_2 from statictext within w_scale_limit_parts
end type
type st_1 from statictext within w_scale_limit_parts
end type
type dw_limit_list from datawindow within w_scale_limit_parts
end type
type dw_part_list from datawindow within w_scale_limit_parts
end type
end forward

global type w_scale_limit_parts from Window
int X=0
int Y=0
int Width=2921
int Height=1920
boolean TitleBar=true
string Title="Limit Parts For Scale"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event ue_open pbm_custom01
st_2 st_2
st_1 st_1
dw_limit_list dw_limit_list
dw_part_list dw_part_list
end type
global w_scale_limit_parts w_scale_limit_parts

type variables
boolean	ib_part_drag,&
	ib_part_drag_off
long	il_drag_row
end variables

forward prototypes
public function boolean wf_check_package_types (string as_part_compared_to, string as_part)
public function boolean wf_check_units (string as_part_compared_to, string as_part)
end prototypes

on ue_open;dw_part_list.Retrieve ( )
dw_limit_list.Retrieve ( )
end on

public function boolean wf_check_package_types (string as_part_compared_to, string as_part);int		li_sqlca_code,&
			li_count1,&
			li_count2
string	ls_code

SELECT count(part_packaging.part)  
  INTO :li_count1
  FROM part_packaging  
 WHERE part_packaging.part = :as_part_compared_to   ;

SELECT count(part_packaging.part)  
  INTO :li_count2
  FROM part_packaging  
 WHERE part_packaging.part = :as_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE comparison CURSOR FOR  
 SELECT part_packaging.code  
   FROM part_packaging  
  WHERE part_packaging.part = :as_part_compared_to  ;

Open comparison ;
Fetch comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_packaging.part)
     INTO :li_count1  
     FROM part_packaging  
    WHERE ( part_packaging.part = :as_part ) AND  
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
else
	return TRUE
end if
end function

public function boolean wf_check_units (string as_part_compared_to, string as_part);int		li_sqlca_code,&
			li_count1,&
			li_count2
string	ls_code

SELECT count(part_unit_conversion.part)  
  INTO :li_count1
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :as_part_compared_to   ;

SELECT count(part_unit_conversion.part)  
  INTO :li_count2
  FROM part_unit_conversion  
 WHERE part_unit_conversion.part = :as_part   ;

if li_count1 <> li_count2 then return FALSE

DECLARE comparison CURSOR FOR  
 SELECT part_unit_conversion.code  
   FROM part_unit_conversion  
  WHERE part_unit_conversion.part = :as_part_compared_to  ;

Open comparison ;
Fetch comparison into :ls_code;
li_sqlca_code = sqlca.sqlcode
Do While sqlca.sqlcode = 0

	Yield ( )

	SELECT count(part_unit_conversion.part)
     INTO :li_count1  
     FROM part_unit_conversion  
    WHERE ( part_unit_conversion.part = :as_part ) AND  
          ( part_unit_conversion.code = :ls_code )   ;

	if li_count1 < 1 then
		sqlca.sqlcode = -1
	end if

	li_sqlca_code = sqlca.sqlcode

	Fetch comparison into :ls_code;

Loop
Close comparison ;

if li_sqlca_code = -1 then
	return FALSE
else
	return TRUE
end if
end function

on activate;if gnv_App.of_GetFrame().MenuName <> "m_scale_limit_parts_menu" then &
	gnv_App.of_GetFrame().ChangeMenu ( m_scale_limit_parts_menu )
end on

on w_scale_limit_parts.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_limit_list=create dw_limit_list
this.dw_part_list=create dw_part_list
this.Control[]={this.st_2,&
this.st_1,&
this.dw_limit_list,&
this.dw_part_list}
end on

on w_scale_limit_parts.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_limit_list)
destroy(this.dw_part_list)
end on

on open;PostEvent ( "ue_open" )
end on

type st_2 from statictext within w_scale_limit_parts
int X=1737
int Y=28
int Width=1065
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Limited List"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_scale_limit_parts
int X=14
int Y=28
int Width=1691
int Height=76
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Available Parts"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_limit_list from datawindow within w_scale_limit_parts
int X=1737
int Y=104
int Width=1065
int Height=1436
int TabOrder=20
string DragIcon="Application!"
string DataObject="d_part_limit_list_external"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on dragdrop;if ib_part_drag then
	if RowCount ( ) > 0 then
		if wf_check_package_types ( GetItemString ( 1, "part" ), dw_part_list.GetItemString ( il_drag_row, "part" ) ) then
			if wf_check_units ( GetItemString ( 1, "part" ), dw_part_list.GetItemString ( il_drag_row, "part" ) ) then
				ib_part_drag = FALSE
				InsertRow ( 1 )
				SetItem ( 1, "part", dw_part_list.GetItemString ( il_drag_row, "part" ) )
				if Update ( ) = -1 then
					Rollback;
					MessageBox ( "Error", "Unable to save part to limited list!", StopSign! )
				else
					Commit;
				end if
			else
				MessageBox ( "Error", "This part has a different unit of measure structure than the other limited parts.", StopSign! )
			end if
		else
			MessageBox ( "Error", "This part has a different package type structure than the other limited parts.", StopSign! )
		end if
	else
		ib_part_drag = FALSE
		InsertRow ( 1 )
		SetItem ( 1, "part", dw_part_list.GetItemString ( il_drag_row, "part" ) )
		if Update ( ) = -1 then
			Rollback;
			MessageBox ( "Error", "Unable to save part to limited list!", StopSign! )
		else
			Commit;
		end if
	end if
end if
end on

on clicked;long		ll_row

ll_row = GetClickedRow ( )

if ll_row < 1 then return

selectrow ( 0, FALSE )
selectrow ( ll_row, TRUE )

il_drag_row = ll_row

ib_part_drag_off = TRUE
Drag ( Begin! )

end on

on constructor;SetTransObject ( sqlca )
end on

type dw_part_list from datawindow within w_scale_limit_parts
event ue_unit_message pbm_custom01
event ue_pt_message pbm_custom02
int X=14
int Y=104
int Width=1691
int Height=1436
int TabOrder=10
string DragIcon="Application!"
string DataObject="d_part_limit_list"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_unit_message;MessageBox ( "Error", "This part has a different unit of measure structure than the other limited parts.", StopSign! )

end on

on ue_pt_message;MessageBox ( "Error", "This part has a different package type structure than the other limited parts.", StopSign! )

end on

on clicked;long		ll_row,&
			ll_search_row
string	ls_part

ll_row = GetClickedRow ( )

if ll_row < 1 then return

selectrow ( 0, FALSE )
selectrow ( ll_row, TRUE )

ls_part = GetItemString ( ll_row, "part" )

if dw_limit_list.RowCount ( ) > 0 then

	ll_search_row = dw_limit_list.Find ( "part='" + ls_part + "'", 1, dw_limit_list.RowCount ( ) )

	if ll_search_row > 0 then
		if dw_limit_list.GetItemString ( ll_search_row, "part" ) <> ls_part then
			il_drag_row = ll_row
			ib_part_drag = TRUE
			Drag ( Begin! )
		end if
	else
		il_drag_row = ll_row
		ib_part_drag = TRUE
		Drag ( Begin! )
	end if

else

	il_drag_row = ll_row
	ib_part_drag = TRUE
	Drag ( Begin! )

end if
end on

on constructor;SetTransObject ( sqlca )
end on

on dragdrop;if ib_part_drag_off then
	ib_part_drag_off = FALSE
	dw_limit_list.DeleteRow ( il_drag_row )
	if dw_limit_list.Update ( ) = -1 then
		Rollback;
		MessageBox ( "Error", "Unable to delete part from limit list!", StopSign! )
	else
		Commit;
	end if
end if
end on

