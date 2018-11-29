$PBExportHeader$w_upgrade_forms_labels.srw
forward
global type w_upgrade_forms_labels from w_wizard_ancestor
end type
type dw_report from datawindow within w_upgrade_forms_labels
end type
end forward

global type w_upgrade_forms_labels from w_wizard_ancestor
int Height=1264
boolean TitleBar=true
string Title="Upgrade Forms and Labels Wizard"
dw_report dw_report
end type
global w_upgrade_forms_labels w_upgrade_forms_labels

type variables
String        is_forms[]  //store all the form names
String        is_labels[]  //store all the label names
end variables

on w_upgrade_forms_labels.create
int iCurrent
call super::create
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
end on

on w_upgrade_forms_labels.destroy
call super::destroy
destroy(this.dw_report)
end on

event open;call super::open;BOOLEAN	l_b_first, &
			l_b_forms, &
			l_b_labels

u_nvo_report_upgrade	l_u_nvo_check_upgrade

l_u_nvo_check_upgrade = CREATE u_nvo_report_upgrade

l_b_first = l_u_nvo_check_upgrade.uof_get_first ( )
l_b_forms = l_u_nvo_check_upgrade.uof_get_forms ( )
l_b_labels = l_u_nvo_check_upgrade.uof_get_labels ( )

DESTROY u_nvo_report_upgrade

IF l_b_first THEN
	  INSERT INTO "report_list"  
         ( "report" )  
     SELECT "forms"."form_name"  
       FROM "forms"  ;
END IF

ii_NumberOfPages = 4

OpenUserObject ( uo_Page [ 1 ], 'u_upgrade_forms_labels_start', 0, 0 )
OpenUserObject ( uo_Page [ 2 ], 'u_upgrade_forms_labels_forms', 0, 0 )
OpenUserObject ( uo_Page [ 3 ], 'u_upgrade_forms_labels_labels', 0, 0 )
OpenUserObject ( uo_Page [ 4 ], 'u_upgrade_forms_labels_finish', 0, 0 )

PostEvent ( 'ue_open' )
end event

event ue_finish;call super::ue_finish;rollback  ;

// save the info to report_library 

uo_page[2].triggerevent ( 'ue_save' )
uo_page[3].triggerevent ( 'ue_save' )

// print the information

dw_report.retrieve ( )

IF MESSAGEBOX ( monsys.msg_title, "Would you like to print the report list ? " , Question!, YesNo!, 2 ) = 1  THEN
	dw_report.Print ( )
END IF

w_parameters.tab_1.tabpage_forms.lv_1.triggerevent ( 'ue_build' )

Open ( w_finish )
Close ( This )
end event

event cb_3::clicked;call super::clicked;Rollback;
end event

type dw_report from datawindow within w_upgrade_forms_labels
int X=297
int Y=1224
int Width=160
int Height=108
int TabOrder=31
boolean Visible=false
boolean BringToTop=true
string DataObject="d_report"
boolean LiveScroll=true
end type

event constructor;settransobject(SQLCA)
end event

