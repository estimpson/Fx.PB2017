$PBExportHeader$w_serial_interface.srw
forward
global type w_serial_interface from w_winwedge_link
end type
type dw_pallets from datawindow within w_serial_interface
end type
end forward

global type w_serial_interface from w_winwedge_link
int Width=2245
int Height=1245
WindowType WindowType=response!
boolean TitleBar=true
string Title="Serial Interface"
boolean ControlMenu=true
dw_pallets dw_pallets
end type
global w_serial_interface w_serial_interface

type variables
STRING			i_s_state
DEC			i_n_amount
TIME			i_t_inactivity_start
str_serial_interface_in	i_str_in_parm
str_serial_interface_out	i_str_out_parm
INT			i_i_alt_parts
BOOLEAN		i_b_steady
end variables

forward prototypes
public function integer wf_set_state (string a_s_state)
end prototypes

public function integer wf_set_state (string a_s_state);// Declare local variables
DEC		l_n_amount

// Reset outbound parm structure
//IF a_s_state <> "Close" THEN
//	i_str_out_parm.weight			= 0
//	i_str_out_parm.quantity	 		= 0
//	i_str_out_parm.new_part			= ''
//	i_str_out_parm.auto_complete	= FALSE
//	i_str_out_parm.return_code		= 0
	i_str_out_parm.serial_type		= i_str_in_parm.serial_type
//	i_str_out_parm.total_count		= 0
//END IF		

// Reset Timer
Timer ( 0, This )

Yield ( )

// Perform state actions
i_s_state = a_s_state

CHOOSE CASE a_s_state
	CASE "Scale"
		OpenUserObject ( u_scale )
		i_t_inactivity_start = Now ( )
		Timer ( 1, This )
		u_scale.BringToTop = TRUE
		i_str_out_parm.weight = u_scale.uf_init ( This, i_str_in_parm.show_buttons, i_str_in_parm.threshold_upper, &
			i_str_in_parm.threshold_lower, FALSE, i_str_in_parm.round_to_whole_number, &
			i_str_in_parm.serial_type )
		Timer ( 0, This )
		CloseUserObject ( u_scale )
		CHOOSE CASE  i_str_out_parm.weight
			CASE -8888
				i_str_out_parm.return_code = -1
			CASE ELSE
				i_str_out_parm.auto_complete = TRUE
				i_str_out_parm.return_code = 1
		END CHOOSE
		wf_set_state ( "Close" )
	CASE "Inactive"
		OpenUserObject ( u_inactivity_prompt )
		u_inactivity_prompt.BringToTop = TRUE
		CHOOSE CASE u_inactivity_prompt.uf_init ( i_str_in_parm.inactivity_time, This )
			CASE 0	// Abnormal Exit
				i_str_out_parm.return_code		= -1
				CloseUserObject ( u_inactivity_prompt )
				wf_set_state ( "Close" )
			CASE 1	// Yes
				i_str_out_parm.return_code		= -1
				CloseUserObject ( u_inactivity_prompt )
				wf_set_state ( "Close" )
			CASE 2	// No
				CloseUserObject ( u_inactivity_prompt )
				wf_set_state ( "Scale" )
		END CHOOSE
	CASE "Labels"
		OpenUserObject ( u_alf_labels )
		u_alf_labels.BringToTop = TRUE
		u_alf_labels.uf_init ( This, i_str_in_parm.part, i_str_in_parm.package_type, i_str_in_parm.quantity )
		CloseUserObject ( u_alf_labels )
		wf_set_state ( "Scale" )
	CASE "Parts"
		OpenUserObject ( u_alt_part_choice )
		u_alt_part_choice.BringToTop = TRUE
		i_str_out_parm.new_part = u_alt_part_choice.uf_init ( This, i_str_in_parm.dw_pallet_array, i_str_in_parm.original_part )
		CloseUserObject ( u_alt_part_choice )
		CHOOSE CASE i_str_out_parm.new_part
			CASE "cancel_button"
				i_str_out_parm.return_code		= -1
				wf_set_state ( "Close" )
			CASE ELSE
				wf_set_state ( "Labels" )
		END CHOOSE 
	CASE "Close"
		CloseWithReturn ( This, i_str_out_parm )
END CHOOSE

RETURN 1
end function

event open;call super::open;// Get parameters
i_str_in_parm = Message.PowerObjectParm

// Start WinWedge program
wf_start_ww ( i_str_in_parm.machine )

PostEvent ( "ue_open" )
end event

on w_serial_interface.create
int iCurrent
call w_winwedge_link::create
this.dw_pallets=create dw_pallets
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_pallets
end on

on w_serial_interface.destroy
call w_winwedge_link::destroy
destroy(this.dw_pallets)
end on

event timer;call super::timer;Yield ( )

IF i_n_amount <= i_str_in_parm.inactivity_amount THEN
	IF SecondsAfter ( i_t_inactivity_start, Now ( ) ) >= i_str_in_parm.inactivity_time THEN
		wf_set_state ( "Inactive" )
	END IF
ELSE
	i_t_inactivity_start = Now ( )
END IF
end event

event ue_open;call super::ue_open;// Declare local variables
DEC		l_n_threshold_upper,&
			l_n_threshold_lower
STRING	l_s_threshold_upper_type,&
			l_s_threshold_lower_type,&
			l_s_dummy
INT		l_i_count

// Get part/packaging scale parameters
SELECT	part_packaging.round_to_whole_number,   
			part_packaging.inactivity_time,   
			part_packaging.inactivity_amount,   
			part_packaging.threshold_upper,   
			part_packaging.threshold_upper_type,   
			part_packaging.threshold_lower,   
			part_packaging.threshold_lower_type,   
			part_packaging.serial_type,   
			part_packaging.manual_tare,   
			part_packaging.quantity,   
			part_packaging.label_format  
INTO		:i_str_in_parm.round_to_whole_number,   
			:i_str_in_parm.inactivity_time,   
			:i_str_in_parm.inactivity_amount,   
			:l_n_threshold_upper,   
			:l_s_threshold_upper_type,   
			:l_n_threshold_lower,   
			:l_s_threshold_lower_type,   
			:i_str_in_parm.serial_type,   
			:i_str_in_parm.manual_tare,   
			:i_str_in_parm.quantity,   
			:i_str_in_parm.label_format  
FROM		part_packaging  
WHERE		( part_packaging.part = :i_str_in_parm.original_part ) AND  
         ( part_packaging.code = :i_str_in_parm.package_type )   ;

// Calculate threshold if present
IF l_n_threshold_upper > 0 THEN
	CHOOSE CASE l_s_threshold_upper_type
		CASE "P"
			i_str_in_parm.threshold_upper = i_str_in_parm.quantity + ( i_str_in_parm.quantity * l_n_threshold_upper )
		CASE ELSE
			i_str_in_parm.threshold_upper = l_n_threshold_upper
	END CHOOSE
END IF
IF l_n_threshold_lower > 0 THEN
	CHOOSE CASE l_s_threshold_lower_type
		CASE "P"
			i_str_in_parm.threshold_lower = i_str_in_parm.quantity - ( i_str_in_parm.quantity * l_n_threshold_lower )
		CASE ELSE
			i_str_in_parm.threshold_lower = l_n_threshold_lower
	END CHOOSE
END IF

// Get steady character from machine_serial_comm
SELECT	steady_char,
			serial_prompt
INTO		:i_str_in_parm.steady_char,
			:l_s_dummy
FROM		machine_serial_comm
WHERE		machine = :i_str_in_parm.machine ;

i_str_in_parm.show_buttons = ( f_get_string_value ( l_s_dummy ) = 'Y' )

// Set initial state depending on serial type
CHOOSE CASE i_str_in_parm.serial_type
	CASE "Piece Weight", "Piece Count"
		i_s_state = "Scale"
	CASE "Auto Label First"
		SELECT	count(*)
		INTO		:i_i_alt_parts
		FROM		alternative_parts
		WHERE		main_part = :i_str_in_parm.original_part ;
		
		if i_i_alt_parts > 0 then
			dw_pallets.SetTransObject ( sqlca )
			For l_i_count = 1 to UpperBound ( i_str_in_parm.part_array )
				dw_pallets.InsertRow ( 0 )
				dw_pallets.SetItem ( dw_pallets.RowCount ( ), "part", i_str_in_parm.part_array[l_i_count] )
				dw_pallets.SetItem ( dw_pallets.RowCount ( ), "pallet_number", i_str_in_parm.pallet_array[l_i_count] )
			Next
			dw_pallets.InsertRow ( 0 )
			i_s_state = "Parts"
		else
			i_s_state = "Labels"
		end if
END CHOOSE

// Set the state
wf_set_state ( i_s_state )
end event

event hotlinkalarm;call super::hotlinkalarm;CHOOSE CASE i_s_data_field
	CASE i_s_amount_field
		i_n_amount = Dec ( i_s_data )
	CASE i_s_steady_field
		i_b_steady = ( i_str_in_parm.steady_char = i_s_data )
END CHOOSE

IF IsValid ( u_scale ) THEN
	u_scale.uf_set_values ( i_n_amount, i_b_steady )
END IF
end event

type dw_pallets from datawindow within w_serial_interface
int X=677
int Y=129
int Width=494
int Height=361
int TabOrder=1
boolean Visible=false
boolean BringToTop=true
string DataObject="d_pallet_array"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

