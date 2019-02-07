$PBExportHeader$u_nvo_tr_admin_setups.sru
$PBExportComments$Embedded SQL for Administrative Setups.
forward
global type u_nvo_tr_admin_setups from nonvisualobject
end type
end forward

global type u_nvo_tr_admin_setups from nonvisualobject
end type
global u_nvo_tr_admin_setups u_nvo_tr_admin_setups

forward prototypes
public function string select_user_definable_module_labels (string module, integer sequence)
end prototypes

public function string select_user_definable_module_labels (string module, integer sequence);STRING	l_s_label

SELECT	user_definable_module_labels.label  
  INTO	:l_s_label  
  FROM	user_definable_module_labels  
 WHERE	( user_definable_module_labels.module = :module ) AND  
 			( user_definable_module_labels.sequence = :sequence )  ;

Return l_s_label
end function

on u_nvo_tr_admin_setups.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_tr_admin_setups.destroy
TriggerEvent( this, "destructor" )
end on

