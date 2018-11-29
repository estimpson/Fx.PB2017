$PBExportHeader$w_production_policy.srw
$PBExportComments$Setup screen for production policy
forward
global type w_production_policy from w_sheet_4t
end type
type dw_1 from datawindow within w_production_policy
end type
end forward

global type w_production_policy from w_sheet_4t
integer y = 320
integer width = 2926
integer height = 1652
boolean titlebar = true
string title = "Production Policy"
string menuname = "m_production_policy"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 77897888
event save_change pbm_custom01
dw_1 dw_1
end type
global w_production_policy w_production_policy

type variables
DataWindowChild dwcScaleModel

Boolean bitemchanged = False
end variables

forward prototypes
public subroutine wf_modify_sequence_scale (boolean bmode)
end prototypes

event save_change;STRING	s_Status, &
			s_Machine,&
			l_s_prompt,&
			l_s_interface,&
			l_s_ww_loc,&
			l_s_wwc_loc,&
			l_s_steady_char
INT		l_i_port,&
			l_i_count,&
			l_i_amount_field,&
			l_i_steady_field
dw_1.AcceptText ( )
If dw_1.Update() > 0 then
	s_Machine	= dw_1.GetItemString ( 1, "machine" )
	s_Status 	= dw_1.GetItemString ( 1, "machine_status" )
	UPDATE machine  
	   SET status = :s_Status  
	 WHERE (machine_no = :s_Machine);
   If SQLCA.SQLCode = -1 Then
		RollBack ;
		MessageBox ( "Error", "Unable to save machine policy!", StopSign! )
	Else
		l_s_interface 		= dw_1.object.serial_interface[1]
		l_i_port      		= dw_1.object.serial_port[1]
		l_s_prompt    		= dw_1.object.serial_prompt[1]
		l_s_ww_loc			= dw_1.object.winwedge_location[1]
		l_s_wwc_loc			= dw_1.object.wwconfig_location[1]
		l_i_amount_field	= dw_1.object.amount_field[1]
		l_i_steady_field 	= dw_1.object.steady_field[1]
		l_s_steady_char	= dw_1.object.steady_char[1]
		SELECT	count(*)
		INTO		:l_i_count
		FROM		machine_serial_comm
		WHERE		(machine = :s_machine) ;
		IF f_get_value ( l_i_count ) < 1 THEN
			IF (NOT ISNULL(l_i_port) and NOT ISNULL(l_s_prompt)) THEN
				INSERT INTO	machine_serial_comm 
							(	machine,
								serial_interface,
								serial_port,
								serial_prompt,
								winwedge_location,
								wwconfig_location,
								amount_field,
								steady_field,
								steady_char )
				VALUES	(	:s_machine,
								:l_s_interface,
								:l_i_port,
								:l_s_prompt,
								:l_s_ww_loc,
								:l_s_wwc_loc,
								:l_i_amount_field,
								:l_i_steady_field,
								:l_s_steady_char ) ;
				IF SQLCA.SQLCode = 0 THEN
					Commit ;
				ELSE
					Rollback;
					MessageBox ( "Error", "Unable to save machine policy!", StopSign! )
				END IF
			ELSE
				COMMIT ;				
			END IF 	
		ELSE
			UPDATE	machine_serial_comm
			SET		serial_interface 	= :l_s_interface,
						serial_port			= :l_i_port,
						serial_prompt		= :l_s_prompt,
						winwedge_location	= :l_s_ww_loc,
						wwconfig_location	= :l_s_wwc_loc,
						amount_field		= :l_i_amount_field,
						steady_field		= :l_i_steady_field,
						steady_char			= :l_s_steady_char
			WHERE		(machine	= :s_machine) ;
			IF (SQLCA.SQLCode = 0) THEN
				Commit ;
			ELSE
				Rollback;
				MessageBox ( "Error", "Unable to save machine policy!", StopSign! )
			END IF
		END IF
	End if
Else
	RollBack;
	MessageBox ( "Error", "Unable to save machine policy!", StopSign! )
End If
bitemchanged = False
end event

public subroutine wf_modify_sequence_scale (boolean bmode);If bMode Then
	dw_1.Modify ( "prompt_user.TabSequence=200" )
	dw_1.Modify ( "scale_type.TabSequence=210" )
	dw_1.Modify ( "com_port.TabSequence=220" )
Else
	dw_1.Modify ( "com_port.TabSequence=0" )
	dw_1.Modify ( "prompt_user.TabSequence=0" )
	dw_1.Modify ( "scale_type.TabSequence=0" )
End if
end subroutine

event open;String	s_FirstMachine
SELECT min(machine.machine_no)  
  INTO :s_FirstMachine  
  FROM machine  ;
If (SQLCA.SQLCode = 0) Then
	dw_1.Retrieve ( s_FirstMachine )
	IF dw_1.RowCount ( ) = 0 THEN	dw_1.InsertRow ( 1 )
Else
	dw_1.InsertRow ( 1 )
End if
end event

on w_production_policy.create
if this.MenuName = "m_production_policy" then this.MenuID = create m_production_policy
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_production_policy.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

on closequery;Int iRtnCode

If bitemchanged Then

	iRtnCode = Messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			This.TriggerEvent( 'save_change' )

          If bitemchanged = True AND iRtnCode = 1 Then
				  Message.Returnvalue = 1   
          End If

	  Case 2 

         close ( this )
  
     Case 3

		  Message.Returnvalue = 1       

     End Choose

Else

      close ( this )
     
End If
	




end on

type dw_1 from datawindow within w_production_policy
integer x = 18
integer y = 32
integer width = 2834
integer height = 1376
string dataobject = "dw_machine_policy"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	s_Machine, &
			s_ColumnName, &
			s_Dummy
s_ColumnName = GetColumnName ( )
bitemchanged = True
CHOOSE CASE s_ColumnName
	CASE "machine"
		s_Machine = GetText ( )
		SELECT machine
		  INTO :s_Dummy
		  FROM machine_policy
		 WHERE (machine = :s_Machine);
		IF (SQLCA.SQLCode = 0) THEN dw_1.Retrieve ( s_Machine )
END CHOOSE
end event

event clicked;STRING	l_s_object,&
			l_s_path,&
			l_s_file
INT		l_i_return,&
			l_i_pos

l_s_object = GetObjectAtPointer ( )

l_i_pos = PosA ( l_s_object, "~t" )

IF l_i_pos > 0 THEN
	l_s_object = LeftA ( l_s_object, l_i_pos - 1 )
	IF l_s_object = "p_ww_loc" THEN 
		IF GetFileOpenName ( "Select WinWedge Location",  &
				+ l_s_path, l_s_file, "EXE", "WinWedge Program (WinWedge.EXE),WinWedge.EXE") = 1 THEN
			SetItem ( 1, "winwedge_location", l_s_path )
		END IF
	ELSEIF l_s_object = "p_wwc_loc" THEN		
		IF GetFileOpenName ( "Select WinWedge Config Location",  &
				+ l_s_path, l_s_file, "CFG", "WinWedge Config File (*.CFG),*.CFG") = 1 THEN
			SetItem ( 1, "wwconfig_location", l_s_path )
		END IF
	END IF
END IF
end event

event constructor;dw_1.Settransobject (sqlca)
end event

