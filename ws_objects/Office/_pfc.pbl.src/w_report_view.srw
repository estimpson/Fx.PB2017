$PBExportHeader$w_report_view.srw
forward
global type w_report_view from w_resize_base
end type
type uo_1 from u_zoom within w_report_view
end type
type ln_1 from line within w_report_view
end type
type ln_2 from line within w_report_view
end type
type dw_report from u_dw_design within w_report_view
end type
type st_title from statictext within w_report_view
end type
end forward

type st_objects from structure
	string		name
	string		border
	string		tabsequence
	string		color
	string		back_color
	string		protect
	string		objtype
end type

global type w_report_view from w_resize_base
int Height=1284
boolean Visible=false
boolean TitleBar=true
string Title="Report Viewer"
long BackColor=79741120
event ue_exit pbm_custom03
event ue_save pbm_custom04
event ue_print pbm_custom05
event ue_save_as pbm_custom06
event ue_print_preview_on pbm_custom07
event ue_print_setup pbm_custom09
event ue_design_off pbm_custom10
event ue_design_on pbm_custom11
event ue_insert pbm_custom12
event ue_delete pbm_custom13
event ue_update pbm_custom14
event ue_import pbm_custom15
event ue_retrieve pbm_custom16
event ue_filter pbm_custom17
event ue_sort pbm_custom18
event ue_first pbm_custom19
event ue_prior pbm_custom20
event ue_next pbm_custom21
event ue_last pbm_custom22
event ue_print_preview_off pbm_custom23
event ue_zoom pbm_custom24
event ue_preview_zoom ( integer zoom )
event ue_printpreview pbm_custom25
uo_1 uo_1
ln_1 ln_1
ln_2 ln_2
dw_report dw_report
st_title st_title
end type
global w_report_view w_report_view

type variables
BOOLEAN	i_b_visible = TRUE, &
		i_b_design, &
                                i_b_printed

STRING		i_s_type, &
		i_s_preview, &
		i_s_print_setup, &
		i_s_object_name, &
		i_s_library_name

u_nvo_library_list	i_uo_library_list

st_generic_structure	i_st_parm
st_objects		i_st_object_list [ ]

Long                         i_l_rows_per_page
end variables

forward prototypes
public function integer wf_build_compiled_datawindow (string a_s_data_object, st_generic_structure a_st_parm)
public subroutine wf_set_options (string a_s_preview, string a_s_setup, integer a_i_copies)
public function integer wf_build_dynamic_datawindow (string a_s_data_object, string a_s_library, st_generic_structure a_st_parm)
public subroutine wf_main ()
end prototypes

event ue_exit;call super::ue_exit;Close ( this )
end event

event ue_save;call super::ue_save;STRING	l_s_syntax, &
			l_s_errors

IF i_s_type = 'D' THEN
	l_s_syntax = dw_report.Describe ( "Datawindow.Syntax" )
	LibraryImport ( i_s_library_name, i_s_object_name, ImportDataWindow!, l_s_syntax, l_s_errors, "Monitor for Windows 95" )
ELSE
	gnv_App.of_GetFrame().setmicrohelp ( "Saving Datawindow..." )
END IF
end event

event ue_print;String  l_s_return

IF i_s_print_setup = 'Y' THEN

	OpenWithParm ( w_print_setup, dw_report )
	l_s_return = message.stringparm
	
	IF l_s_return = '1' THEN
		i_b_printed = TRUE
	ELSE
		i_b_printed = FALSE
	END IF

ELSE
	
	IF dw_report.Print ( TRUE )  = 1 THEN
		i_b_printed = TRUE
	END IF

END IF
end event

event ue_print_preview_on;i_s_preview = 'Yes' 
dw_report.AcceptText ( )
dw_report.Object.DataWindow.Print.Preview = 'Yes'
uo_1.sle_zoom.text = 'ORIG'
uo_1.sle_zoom.enabled = TRUE
uo_1.cb_plus.enabled = TRUE
uo_1.cb_minus.enabled = TRUE
uo_1.sle_zoom.PostEvent ( Clicked! )

i_l_rows_per_page = Long( dw_report.object.datawindow.lastrowonpage ) 



end event

event ue_print_setup;STRING l_s_return

OpenWithParm ( w_print_Setup, dw_report )

l_s_return = message.stringparm
	
IF l_s_return = '1' THEN
	i_b_printed = TRUE
ELSE
	i_b_printed = FALSE
END IF
end event

event ue_design_off;STRING	l_s_object, &
			l_s_retrieve [ ]

LONG	l_l_count

i_b_design = FALSE
dw_report.visible = FALSE
DO WHILE l_l_count < UpperBound ( i_st_object_list )
	l_l_count ++
	l_s_object = i_st_object_list [ l_l_count ].name
	dw_report.Modify ( l_s_object + ".tabsequence=" + &
		i_st_object_list [ l_l_count ].tabsequence )
	dw_report.Modify ( l_s_object + ".border=" + &
		i_st_object_list [ l_l_count ].border )
	dw_report.Modify ( l_s_object + ".color=" + &
		i_st_object_list [ l_l_count ].color )
	dw_report.Modify ( l_s_object + ".background.color=" + &
		i_st_object_list [ l_l_count ].back_color )
	dw_report.Modify ( l_s_object + ".protect=" + &
		i_st_object_list [ l_l_count ].protect )
	dw_report.Modify ( l_s_object + ".Pointer=''" )
	dw_report.Modify ( l_s_object + ".Moveable=0" )
	dw_report.Modify ( l_s_object + ".Resizeable=0" )
LOOP

dw_report.Modify ( "DataWindow.ShowDefinition=No DataWindow.Pointer=''" )
dw_report.visible = TRUE
end event

event ue_design_on;call super::ue_design_on;STRING	l_s_syntax, &
			l_s_objects, &
			l_s_object, &
			l_s_import_string
			
LONG		l_l_pointer, &
			l_l_count
			
Integer	l_i_count = 10

DataStore	dw_object_list

i_b_design = TRUE
dw_object_list = CREATE DataStore
dw_object_list.DataObject = "d_object_list"
l_s_objects = dw_report.Describe ( "DataWindow.Objects" )
l_s_syntax = dw_report.Describe ( "DataWindow.Syntax" )

DO WHILE LenA ( l_s_objects ) > 0
	Yield ( )	//Remove me after testing
	l_s_object = LeftA ( l_s_objects, PosA ( l_s_objects, '~t' ) - 1 )
	IF l_s_object <> "" THEN
		l_s_objects = RightA ( l_s_objects, LenA ( l_s_objects ) - LenA ( l_s_object ) - 1 )
	ELSE
		l_s_object = l_s_objects
		l_s_objects = ""
	END IF
	l_s_import_string += l_s_object + "~r~n"
LOOP
dw_object_list.ImportString ( l_s_import_string )
dw_object_list.GroupCalc ( )

dw_object_list.SetFilter ( "counter = 1" )
dw_object_list.Filter ( )
IF dw_object_list.FilteredCount ( ) > 0 THEN
	Return
END IF

dw_object_list.SetSort ( "" )
dw_object_list.SetFilter ( "" )

dw_report.visible = FALSE

DO WHILE dw_object_list.RowCount ( ) > 0
	l_s_object = Trim ( dw_object_list.GetItemString ( 1, 1 ) )
	l_l_count ++
	i_st_object_list [ l_l_count ].name = l_s_object
	i_st_object_list [ l_l_count ].tabsequence = &
		dw_report.Describe ( l_s_object + ".tabsequence" )
	i_st_object_list [ l_l_count ].border = &
		dw_report.Describe ( l_s_object + ".border" )
	i_st_object_list [ l_l_count ].color = &
		dw_report.Describe ( l_s_object + ".color" )
	i_st_object_list [ l_l_count ].back_color = &
		dw_report.Describe ( l_s_object + ".background.color" )
	i_st_object_list [ l_l_count ].protect = &
		dw_report.Describe ( l_s_object + ".protect" )
	i_st_object_list [ l_l_count ].objtype = &
		dw_report.Describe ( l_s_object + ".type" )
	IF Trim ( i_st_object_list [ l_l_count ].objtype ) = "bitmap" OR &
		Trim ( i_st_object_list [ l_l_count ].objtype ) = "column" THEN
		dw_report.Modify ( l_s_object + ".tabsequence=" + string(l_i_count) )
		dw_report.Modify ( l_s_object + ".Moveable=1" )
		dw_report.Modify ( l_s_object + ".Resizeable=1" )
		dw_report.Modify ( l_s_object + ".Border=2" )
		dw_report.Modify ( l_s_object + ".Pointer='arrow!'" )
		dw_report.Modify ( l_s_object + ".color=0" )
		dw_report.Modify ( l_s_object + ".background.color=-1" )
		dw_report.Modify ( l_s_object + ".Protect=1" )
	END IF
   l_i_count = l_i_count + 10
	dw_object_list.DeleteRow ( 1 )

LOOP

dw_report.Modify ( "DataWindow.ShowDefinition=Yes DataWindow.Pointer='cross!'" )
dw_report.Reset ( )
dw_report.InsertRow ( 0 )
dw_report.visible = TRUE


end event

event ue_insert;call super::ue_insert;Long 		l_l_count, &
	  		l_l_col_count, &
			l_l_row

IF i_s_preview = 'No' THEN

	l_l_count = INTEGER ( dw_report.object.datawindow.Column.Count )			

	FOR l_l_col_count = 1 TO l_l_count
		dw_report.settaborder ( l_l_Col_count,  l_l_col_count + 10 )
	NEXT

	l_l_row = dw_report.InsertRow ( 0 )
	dw_report.ScrolltoRow ( l_l_Row )

END IF
end event

event ue_delete;call super::ue_delete;IF i_s_preview = 'No' THEN
	
	dw_report.DeleteRow ( dw_report.GetRow ( ) )
	
END IF
end event

event ue_update;call super::ue_update;dw_report.Update ( )
end event

event ue_import;call super::ue_import;STRING	l_s_dummy

SetNull ( l_s_dummy )
dw_report.ImportFile ( l_s_dummy )
end event

event ue_retrieve;call super::ue_retrieve;dw_report.Retrieve ( )
end event

event ue_filter;call super::ue_filter;STRING	s_Dummy

SetNull ( s_Dummy )
dw_report.SetFilter ( s_Dummy )
dw_report.Filter ( )
end event

event ue_sort;call super::ue_sort;STRING	s_Dummy

IF dw_report.RowCount ( ) > 1 THEN
	SetNull ( s_Dummy )
	dw_report.SetSort ( s_Dummy )
	dw_report.Sort  ( )
END IF

end event

event ue_first;call super::ue_first;dw_report.ScrollToRow ( 1 )
dw_report.Modify ( "DataWindow.Print.Page.Range = '1'" ) 








end event

event ue_prior;call super::ue_prior;Long	l_l_page

dw_report.ScrollPriorPage ( )

If Mod ( Long ( dw_report.Object.DataWindow.LastRowOnPage ) , i_l_rows_per_page  ) = 0 then
	l_l_Page		=  Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page
Else
	l_l_Page		= Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page  + 1
End if

dw_report.Modify("DataWindow.Print.Page.Range='"+string ( l_l_page )+"'")


end event

event ue_next;call super::ue_next;Long	l_l_page

dw_report.ScrollNextPage ( )

If Mod ( Long ( dw_report.Object.DataWindow.LastRowOnPage ) , i_l_rows_per_page  ) = 0 then
	l_l_Page		=  Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page
Else
	l_l_Page		= Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page  + 1
End if

dw_report.Modify("DataWindow.Print.Page.Range='"+string ( l_l_page )+"'")



end event

event ue_last;call super::ue_last;Long	l_l_page

dw_report.ScrollToRow ( dw_report.RowCount ( ) )

If Mod ( Long ( dw_report.Object.DataWindow.LastRowOnPage ) , i_l_rows_per_page  ) = 0 then
	l_l_Page		= Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page
Else
	l_l_Page		= Long ( dw_report.Object.DataWindow.LastRowOnPage ) / i_l_rows_per_page  + 1
End if

dw_report.Modify("DataWindow.Print.Page.Range='"+string ( l_l_page )+"'")


end event

event ue_print_preview_off;i_s_preview = 'No' 
dw_report.Object.DataWindow.Print.Preview = 'No'
uo_1.sle_zoom.enabled = FALSE
uo_1.cb_plus.enabled = FALSE
uo_1.cb_minus.enabled = FALSE

i_l_rows_per_page = Long( dw_report.object.datawindow.lastrowonpage ) 
end event

event ue_zoom;call super::ue_zoom;INTEGER	l_i_zoom

l_i_zoom = Integer ( dw_report.Object.DataWindow.Zoom )

OpenWithParm ( w_zoom, l_i_zoom )
l_i_zoom = Message.DoubleParm

dw_report.Object.DataWindow.Zoom = String ( l_i_zoom )
end event

event ue_preview_zoom;call super::ue_preview_zoom;INTEGER	l_i_zoom

IF NOT IsNull ( zoom ) THEN
	l_i_zoom = zoom
ELSE
	l_i_zoom = Integer ( dw_report.Object.DataWindow.Print.Preview.Zoom )
	OpenWithParm ( w_zoom, l_i_zoom )
	l_i_zoom = Message.DoubleParm
	uo_1.sle_zoom.Text = String ( l_i_zoom )
END IF

dw_report.Object.DataWindow.Print.Preview.Zoom = String ( l_i_zoom )
end event

event ue_printpreview;m_report_view.mf_design_off ( )
m_report_view.mf_preview_on ( )
end event

public function integer wf_build_compiled_datawindow (string a_s_data_object, st_generic_structure a_st_parm);dw_report.DataObject = Righttrim( a_s_data_object )
dw_report.SetTransObject ( SQLCA )

//Check to see if a valid DataWindow object was assigned to dw_report and retrieve it:
IF dw_report.Describe ( "DataWindow.bands" ) > '' THEN
	Return dw_report.Retrieve (	a_st_parm.value1, &
					a_st_parm.value2, &
					a_st_parm.value3, &
					a_st_parm.value4, &
					a_st_parm.value5, &
					a_st_parm.value6, &
					a_st_parm.value7, &
					a_st_parm.value8, &
					a_st_parm.value9, &
					a_st_parm.value10 )
ELSE
	Return -1
END IF
end function

public subroutine wf_set_options (string a_s_preview, string a_s_setup, integer a_i_copies);dw_report.Object.Datawindow.Print.Copies = a_i_copies

IF i_s_preview = 'N' OR ISNULL ( i_s_preview ) THEN
	IF i_s_print_setup = 'Y' THEN
		PrintSetup ( )
	END IF
	// Added these lines to set the printed boolean so that the print update is triggered in the sheet. 
   IF dw_report.print() = 1 THEN
		i_b_printed = TRUE
	ELSE
		i_b_printed = FALSE
	END IF
	PostEvent ( "ue_exit" )
	Return
END IF

this.visible = true
postevent ( "ue_printpreview" )



end subroutine

public function integer wf_build_dynamic_datawindow (string a_s_data_object, string a_s_library, st_generic_structure a_st_parm);STRING	l_s_syntax, &
	l_s_path

a_s_library = TRIM ( a_s_library )
a_s_data_object = TRIM ( a_s_data_object )

IF NOT FileExists ( a_s_library ) THEN
	l_s_path = 'c:\windows\'
	IF NOT FileExists ( l_s_path + a_s_library ) THEN
		Return -2
	END IF
END IF

i_s_library_name = a_s_library
l_s_syntax = LibraryExport ( i_s_library_name, a_s_data_object, ExportDataWindow! )
dw_report.Create ( l_s_syntax )
dw_report.SetTransObject ( SQLCA )

//Check to see if a valid DataWindow object was assigned to dw_report and retrieve it:
IF dw_report.Describe ( "DataWindow.bands" ) > '' THEN
	Return dw_report.Retrieve (	a_st_parm.value1, &
					a_st_parm.value2, &
					a_st_parm.value3, &
					a_st_parm.value4, &
					a_st_parm.value5, &
					a_st_parm.value6, &
					a_st_parm.value7, &
					a_st_parm.value8, &
					a_st_parm.value9, &
					a_st_parm.value10 )
ELSE
	Return -1
END IF
end function

public subroutine wf_main ();LONG	l_l_copies
STRING	l_s_window_name, &
	l_s_form_name, &
	l_s_datawindow_name, &
	l_s_preview
WINDOW	l_w_dummy

IF i_st_parm.value11 = "Label" THEN
	select	type,
		object_name,
		library_name,
		preview,
		print_setup,
		IsNull ( copies, 1 )
	into	:i_s_type,
		:i_s_object_name,
		:i_s_library_name,
		:l_s_preview,
		:i_s_print_setup,
		:l_l_copies
	from	report_library
	where	report = :i_st_parm.value11  AND 
		name   = :i_st_parm.value12 ;

	i_s_preview = l_s_preview				
		
	CHOOSE CASE i_s_type
		CASE 'D'
			CHOOSE CASE wf_build_dynamic_datawindow ( i_s_object_name, i_s_library_name, i_st_parm )
				CASE -2
					MessageBox ( monsys.msg_title, i_s_library_name + &
					" is not a valid library name." )
					PostEvent ( "ue_exit" )
				CASE -1
					MessageBox ( monsys.msg_title, i_s_object_name + &
					" is not a valid DataWindow object for " + i_s_library_name + &
					".  Contact your systems manager for assistance." )
					PostEvent ( "ue_exit" )
				CASE 0
					MessageBox ( monsys.msg_title, "Missing data in form.  " + &
					"Check required data for completeness." )
					PostEvent ( "ue_exit" )
				CASE ELSE
					SELECT	description
					INTO	:st_title.text
					FROM	report_list
					WHERE	report = :i_st_parm.value11  ;
					wf_set_options ( l_s_preview, i_s_print_setup, l_l_copies )
			END CHOOSE
		CASE 'C'
			CHOOSE CASE wf_build_compiled_datawindow ( i_s_object_name, i_st_parm )
				CASE -1
					MessageBox ( monsys.msg_title, i_s_object_name + &
					" is not a valid DataWindow object for " + i_s_library_name + &
					".  Contact your systems manager for assistance." )
					PostEvent ( "ue_exit" )
				CASE 0
					MessageBox ( monsys.msg_title, "Missing data in form.  " + &
					"Check required data for completeness." )
					PostEvent ( "ue_exit" )
				CASE ELSE
					SELECT	description
					INTO	:st_title.text
					FROM	report_list
					WHERE	report = :i_st_parm.value11  ;
					wf_set_options ( l_s_preview, i_s_print_setup, l_l_copies )
			END CHOOSE
		CASE 'W', 'F'
			IF i_st_parm.value11 = "Label" THEN i_st_parm.value11 = String ( l_l_copies )
//			if isvalid(l_w_dummy) then 
			if isnull(i_s_object_name,'') > '' then
				IF l_s_preview = 'Y' THEN 
					this.visible = TRUE
					OpenWithParm ( l_w_dummy, i_st_parm, i_s_object_name )
				ELSE
					this.visible = FALSE
					OpenWithParm ( l_w_dummy, i_st_parm, i_s_object_name )
					PostEvent ( "ue_exit" )					
				END IF
			else
				MessageBox ( monsys.msg_title, "Missing "+i_s_object_name+ " in the label library")
				PostEvent ( "ue_exit" )
			end if 	
	END CHOOSE
ELSEIF i_st_parm.value11 > '' THEN
	select	type,
		object_name,
		library_name,
		preview,
		print_setup,
		IsNull ( copies, 1 )
	into	:i_s_type,
		:i_s_object_name,
		:i_s_library_name,
		:l_s_preview,
		:i_s_print_setup,
		:l_l_copies
	from	report_library
	where	report = :i_st_parm.value11 ;
		
	i_s_preview = l_s_preview				
		
	CHOOSE CASE i_s_type
		CASE 'D'
			CHOOSE CASE wf_build_dynamic_datawindow ( i_s_object_name, i_s_library_name, i_st_parm )
				CASE -2
					MessageBox ( monsys.msg_title, i_s_library_name + &
					" is not a valid library name." )
					PostEvent ( "ue_exit" )
				CASE -1
					MessageBox ( monsys.msg_title, i_s_object_name + &
					"is not a valid DataWindow object for " + i_s_library_name + &
					".  Contact your systems manager for assistance." )
					PostEvent ( "ue_exit" )
				CASE 0
					MessageBox ( monsys.msg_title, "Missing data in form.  " + &
					"Check required data for completeness." )
					PostEvent ( "ue_exit" )
				CASE ELSE
					SELECT	description
					INTO	:st_title.text
					FROM	report_list
					WHERE	report = :i_st_parm.value11  ;
					wf_set_options ( l_s_preview, i_s_print_setup, l_l_copies )
			END CHOOSE
		CASE 'C'
			CHOOSE CASE wf_build_compiled_datawindow ( i_s_object_name, i_st_parm )
				CASE -1
					MessageBox ( monsys.msg_title, i_s_object_name + &
					" is not a valid DataWindow object for " + i_s_library_name + &
					".  Contact your systems manager for assistance." )
					PostEvent ( "ue_exit" )
				CASE 0
					MessageBox ( monsys.msg_title, "Missing data in form.  " + &
					"Check required data for completeness." )
					PostEvent ( "ue_exit" )
				CASE ELSE
					SELECT	description
					INTO	:st_title.text
					FROM	report_list
					WHERE	report = :i_st_parm.value11  ;
					wf_set_options ( l_s_preview, i_s_print_setup, l_l_copies )
			END CHOOSE
		CASE 'W'
			IF i_st_parm.value11 = "Label" THEN i_st_parm.value11 = String ( l_l_copies )
//			if isvalid(l_w_dummy) then 
			if isnull(i_s_object_name,'') > '' then				
				IF l_s_preview = 'Y' THEN 
					this.visible = TRUE
					OpenWithParm ( l_w_dummy, i_st_parm, i_s_object_name )
				ELSE
					this.visible = FALSE
					OpenWithParm ( l_w_dummy, i_st_parm, i_s_object_name )
					PostEvent ( "ue_exit" )					
				END IF
			else
				MessageBox ( monsys.msg_title, "Missing "+i_s_object_name+ " in the label library")
				PostEvent ( "ue_exit" )
			end if 	
	END CHOOSE
END IF
end subroutine

on w_report_view.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.dw_report=create dw_report
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.ln_1
this.Control[iCurrent+3]=this.ln_2
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.st_title
end on

on w_report_view.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.dw_report)
destroy(this.st_title)
end on

event open;call super::open;//Get parm
i_st_parm = Message.PowerObjectParm

//register all the objects
i_st_wo_item [ 1 ].object = dw_report
i_st_wo_item [ 1 ].anchor_x1 = dw_report.x
i_st_wo_item [ 1 ].anchor_y1 = dw_report.y
i_st_wo_item [ 1 ].anchor_x2 = 100    
i_st_wo_item [ 1 ].anchor_y2 = 260    

i_st_wo_item [ 2 ].object = uo_1
i_st_wo_item [ 2 ].anchor_x1 = uo_1.x
i_st_wo_item [ 2 ].anchor_y2 = 230 - uo_1.height
i_st_wo_item [ 2 ].anchor_height = uo_1.height
i_st_wo_item [ 2 ].anchor_width = uo_1.width

i_st_wo_item [ 3 ].object = st_title
i_st_wo_item [ 3 ].anchor_x1 = st_title.x
i_st_wo_item [ 3 ].anchor_y1 = st_title.y
i_st_wo_item [ 3 ].anchor_height = 77
i_st_wo_item [ 3 ].anchor_x2 = 100

i_st_wo_item [ 4 ].object = ln_1
i_st_wo_item [ 4 ].anchor_x2 = 0
i_st_wo_item [ 4 ].anchor_y2 = 250 
i_st_wo_item [ 4 ].anchor_height = 0
i_st_wo_item [ 4 ].var_width = 1

i_st_wo_item [ 5 ].object = ln_2
i_st_wo_item [ 5 ].anchor_x2 = 0
i_st_wo_item [ 5 ].anchor_y2 = 240 
i_st_wo_item [ 5 ].anchor_height = 0
i_st_wo_item [ 5 ].var_width = 1

wf_main ( )


end event

event activate;IF IsValid ( gnv_App.of_GetFrame() ) THEN
	IF gnv_App.of_GetFrame().MenuName <> "m_report_view" THEN &
		gnv_App.of_GetFrame().ChangeMenu ( m_report_view )
ELSEIF IsValid ( gnv_App.of_GetFrame() ) THEN
	IF gnv_App.of_GetFrame().MenuName <> "m_report_view" THEN &
		gnv_App.of_GetFrame().ChangeMenu ( m_report_view )
END IF


end event

event close;window l_w_window

// check if it is a compiled datawindow that was printed and update the flag

IF i_b_printed AND ( i_s_type = 'C' OR  i_s_type = 'D' ) THEN
   close ( this )
   l_w_window = getnextsheet(this)
	if IsValid ( l_w_window ) then
		l_w_window.Triggerevent ( 'ue_print_update', 0, i_st_parm.value11 )
	end if
END IF
end event

type uo_1 from u_zoom within w_report_view
int X=27
int Y=1024
int TabOrder=10
string Tag="zoom control"
end type

on uo_1.destroy
call u_zoom::destroy
end on

type ln_1 from line within w_report_view
boolean Enabled=false
int BeginY=992
int EndX=389
int EndY=992
int LineThickness=4
long LineColor=276856960
end type

type ln_2 from line within w_report_view
boolean Enabled=false
int BeginY=996
int EndX=329
int EndY=996
int LineThickness=4
long LineColor=16777215
end type

type dw_report from u_dw_design within w_report_view
int X=32
int Y=92
int Width=1893
int Height=848
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

type st_title from statictext within w_report_view
int X=32
int Y=8
int Width=1893
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Title"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

