$PBExportHeader$u_nvo_report_upgrade.sru
forward
global type u_nvo_report_upgrade from nonvisualobject
end type
end forward

shared variables
BOOLEAN	s_b_labels, &
		s_b_forms, &
		s_b_first
end variables

global type u_nvo_report_upgrade from nonvisualobject
end type
global u_nvo_report_upgrade u_nvo_report_upgrade

forward prototypes
public function boolean uof_get_labels ()
public function boolean uof_get_forms ()
public function boolean uof_get_first ()
end prototypes

public function boolean uof_get_labels ();STRING	l_s_dummy

  SELECT sysobjects.name  
    INTO :l_s_dummy  
    FROM sysobjects  
   WHERE ( sysobjects.type = 'U' ) AND  
         ( sysobjects.name = 'label_library' )   ;

Return l_s_dummy > ''

end function

public function boolean uof_get_forms ();STRING	l_s_dummy

  SELECT sysobjects.name  
    INTO :l_s_dummy  
    FROM sysobjects  
   WHERE ( sysobjects.type = 'U' ) AND  
         ( sysobjects.name = 'forms' )   ;

Return l_s_dummy > ''



end function

public function boolean uof_get_first ();INTEGER	l_i_report_list_rowcount

  SELECT Count ( report )  
    INTO :l_i_report_list_rowcount  
    FROM report_list  ;

Return l_i_report_list_rowcount = 0
end function

on u_nvo_report_upgrade.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_nvo_report_upgrade.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

