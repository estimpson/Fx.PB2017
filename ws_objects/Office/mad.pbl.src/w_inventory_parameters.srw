$PBExportHeader$w_inventory_parameters.srw
$PBExportComments$mad
forward
global type w_inventory_parameters from Window
end type
type st_1 from statictext within w_inventory_parameters
end type
type cb_1 from commandbutton within w_inventory_parameters
end type
type dw_2 from datawindow within w_inventory_parameters
end type
type ddlb_trans_list from dropdownlistbox within w_inventory_parameters
end type
type dw_1 from datawindow within w_inventory_parameters
end type
end forward

global type w_inventory_parameters from Window
int X=673
int Y=265
int Width=3004
int Height=1545
boolean TitleBar=true
string Title="More Inventory Parameters"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event save_item pbm_custom01
event loc_limit pbm_custom02
event check_item pbm_custom03
event ue_exit pbm_custom04
st_1 st_1
cb_1 cb_1
dw_2 dw_2
ddlb_trans_list ddlb_trans_list
dw_1 dw_1
end type
global w_inventory_parameters w_inventory_parameters

type variables
boolean 	bitemchanged = False, &
	ib_bad_save = False, &
	ib_cancel = False
end variables

on save_item;If dw_1.DataObject <> "d_gray_background" Then
	If dw_1.Update ( ) = -1 Then
		ib_bad_save = true
		RollBack ;
      w_inventory_parameters.SetMicroHelp ( "Unable to save Information....")
		Return
	Else
		If dw_2.Update ( ) = -1 Then
			ib_bad_save = true
			RollBack ;
      	w_inventory_parameters.SetMicroHelp ( "Unable to save Information....")
			Return
		Else
			ib_bad_save = false
			Commit ;
		End if
	End if
Else
	If dw_2.Update ( ) = -1 Then
		ib_bad_save = True
		RollBack ;
      w_inventory_parameters.SetMicroHelp ( "Unable to save Information....")
		Return
	Else
		ib_bad_save = false
		Commit ;
	End if
End if

bitemchanged = False
end on

on loc_limit;OpenSheetWithParm ( w_inventory_location_list, LeftA ( ddlb_trans_list.Text, 1 ), gnv_App.of_GetFrame(), 3, Original! )
end on

on check_item;Int i_Rtncode

If Not bitemchanged Then
	
	Return

ElseIf bitemchanged Then

	i_Rtncode = MessageBox ( "Warning", "Do you like to save the changes?", Exclamation!, YesNoCancel!, 3 )

	If i_Rtncode = 1 Then

		w_inventory_parameters.TriggerEvent ( "save_item" )

	ElseIf i_Rtncode = 2 Then
		ib_bad_save = False
		bitemchanged = False
		Return

	End If

   If i_Rtncode = 3 Then

		If gnv_App.of_GetFrame().MenuName <> "m_inventory_parameters" Then &
			gnv_App.of_GetFrame().ChangeMenu ( m_inventory_parameters )
 
      w_inventory_parameters.dw_1.SetFocus ( )
		ib_cancel = true

	End If

End If
end on

on ue_exit;Window wActiveSheet

wActiveSheet = gnv_App.of_GetFrame().GetActiveSheet ( )

If IsValid ( wActiveSheet ) AND wActiveSheet = w_inventory_parameters Then

   w_inventory_parameters.Triggerevent ( "check_item" )
	If ib_bad_save Then 
		Return
	Else
		If not ib_cancel Then
			Close ( w_inventory_parameters )
		Else
			ib_cancel = false
			return
		End If
	End If
Else

	Close ( w_inventory_parameters )

End if

end on

on activate;If gnv_App.of_GetFrame().MenuName <> "m_inventory_parameters" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_inventory_parameters )
end on

on open;ddlb_trans_list.BringToTop = True

dw_2.SetTransObject ( sqlca )
dw_2.Retrieve ( )
end on

on w_inventory_parameters.create
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.ddlb_trans_list=create ddlb_trans_list
this.dw_1=create dw_1
this.Control[]={ this.st_1,&
this.cb_1,&
this.dw_2,&
this.ddlb_trans_list,&
this.dw_1}
end on

on w_inventory_parameters.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.ddlb_trans_list)
destroy(this.dw_1)
end on

type st_1 from statictext within w_inventory_parameters
int X=110
int Y=817
int Width=604
int Height=73
boolean Enabled=false
string Text="Inventory Transactions:"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_inventory_parameters
int X=1555
int Y=809
int Width=311
int Height=97
int TabOrder=20
boolean Visible=false
string Text="Limit Locs"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.TriggerEvent ( "loc_limit" )
end on

type dw_2 from datawindow within w_inventory_parameters
int X=19
int Y=17
int Width=2871
int Height=769
int TabOrder=30
string DataObject="d_parameters_inventory_control"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on itemchanged;bitemchanged = True
end on

on editchanged;bitemchanged = true
end on

type ddlb_trans_list from dropdownlistbox within w_inventory_parameters
int X=769
int Y=809
int Width=714
int Height=737
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Job Completion",&
"Material Issue",&
"Break Out",&
"Transfer"}
end type

on selectionchanged;bitemchanged = True

If ddlb_trans_list.Text = "Transfer" Then
	cb_1.Show ( )
	dw_1.DataObject = "d_gray_background"
Else
	If ddlb_trans_list.Text = "Job Completion" Then
		dw_1.DataObject = "d_inventory_parms_jc"
		cb_1.Show ( )
	Elseif ddlb_trans_list.Text = "Material Issue" Then
		dw_1.DataObject = "d_inventory_parms_mi"
		cb_1.Show ( )
	Elseif ddlb_trans_list.Text = "Break Out" Then
		dw_1.DataObject = "d_inventory_parms_bo"
		cb_1.Hide ( )
	End if

	dw_1.SetTransObject ( sqlca )
	If dw_1.Retrieve ( ) < 1 Then

	  INSERT INTO inventory_parameters  
		         ( record_number,   
		           machine_number,   
		           jc_machine,   
		           jc_part,   
		           jc_packaging,   
		           jc_location_to,   
		           jc_operator,   
		           jc_number_of,   
		           jc_qty,   
		           jc_unit,   
		           mi_machine,   
		           mi_operator,   
		           mi_serial,   
		           mi_qty,   
		           mi_unit,   
		           bo_operator,   
		           bo_serial,   
		           bo_number_of,   
		           bo_qty,   
		           bo_unit,   
		           jc_allow_zero_qty,   
		           jc_parts_mode,   
		           limit_locations,   
		           jc_material_lot )  
		  VALUES ( 1,   
		           '0',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'R',   
		           'N',   
		           'N',   
		           'N',   
		           'R' )  ;
	
		If SQLCA.SQLCode <> 0 Then
			RollBack ;
		Else
			Commit ;
		End if
	
	End if

End if


end on

type dw_1 from datawindow within w_inventory_parameters
int X=19
int Y=801
int Width=2871
int Height=625
int TabOrder=40
string DataObject="d_gray_background"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

on itemchanged;bitemchanged = True
end on

