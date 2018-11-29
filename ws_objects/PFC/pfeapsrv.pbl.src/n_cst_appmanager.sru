$PBExportHeader$n_cst_appmanager.sru
$PBExportComments$Extension Application Manager service
forward
global type n_cst_appmanager from pfc_n_cst_appmanager
end type
end forward

global type n_cst_appmanager from pfc_n_cst_appmanager
event pfc_postsplash ( )
event type integer pfc_commandline ( ref n_cst_associative_array argument )
end type
global n_cst_appmanager n_cst_appmanager

type variables

public string	is_Root
public n_cst_registry	inv_Reg
public n_cst_cache inv_Cache
public n_cst_associative_array	inv_Global
public n_cst_statemsgrouter	inv_StateMsgRouter
public n_cst_printer Printer

end variables

forward prototypes
public function integer of_setroot ()
public function integer of_resetroot ()
public function string of_getroot ()
public function integer of_processcommandline (string as_commandline)
public function integer of_getarg (ref string as_rcommand, ref string as_argument)
end prototypes

public function integer of_setroot ();
//	Declarations.
w_nonvisible	lw_1
listbox	llb_1
statictext	lst_1

//	Open nonvisible window, create listbox and static text, and get the root directory.
Open ( lw_1 )
lw_1.OpenUserObject ( llb_1 )
lw_1.OpenUserObject ( lst_1 )
llb_1.DirList ( "*.*", 0, lst_1 )
is_Root = lst_1.text
lw_1.CloseUserObject ( llb_1 )
lw_1.CloseUserObject ( lst_1 )
Close ( lw_1 )

//	Return.
return 1

end function

public function integer of_resetroot ();
//	Declarations.
w_nonvisible	lw_1
listbox	llb_1

//	Open nonvisible window, create listbox and static text, and get the root directory.
Open ( lw_1 )
lw_1.OpenUserObject ( llb_1 )
llb_1.DirList ( is_Root + "\*.*", 0 )
lw_1.CloseUserObject ( llb_1 )
Close ( lw_1 )

//	Return.
return 1

end function

public function string of_getroot ();
//	Return.
return is_Root

end function

public function integer of_processcommandline (string as_commandline);
//	Local declarations.

//	Check if there is anything to process.
string	ls_RCommand
ls_RCommand = Trim ( as_CommandLine )
if ls_RCommand = "" then
	return 0
end if

//	Loop through the string.
char	lc_NextChar
integer	li_Length, li_Ptr = 1, li_Args
string	ls_Switch, ls_SwitchValue, ls_Arg[]
n_cst_associative_array	lncst_Args

//	Default help to false.
lncst_Args.of_SetItem ( "Help", false )
li_Length = Len ( ls_RCommand )
do while li_Length > 0
	lc_NextChar = Mid ( ls_RCommand, li_Ptr, 1 )
	//	Look for switches and arguments.
	choose case lc_NextChar
		case "-", "/"
			ls_Switch = Mid ( ls_RCommand, li_Ptr + 1, 1 )
			//	Remove switch from the Remaining Command line.
			ls_RCommand = Trim ( Right ( ls_RCommand, li_Length - 2 ) )
			
			//	Check for a switch value.
			of_GetArg ( ls_RCommand, ls_SwitchValue )
			
			//	Add switch and value to args read.
			if ls_Switch = '?' then
				lncst_Args.of_SetItem ( "Help", true )
			else
				lncst_Args.of_SetItem ( ls_Switch, ls_SwitchValue )
			end if
		case "A" to "Z", "a" to "z", "0" to "9", "'", '"', "\"
			if of_GetArg ( ls_RCommand, ls_Arg [ li_Args + 1 ] ) < 0 then
				lncst_Args.of_SetItem ( "Help", true )
			else
				li_Args++
			end if
		case else
			ls_RCommand = Right ( ls_RCommand, li_Length - 1 )
	end choose
	ls_RCommand = Trim ( ls_RCommand )
	li_Length = Len ( ls_RCommand )
loop

//	Add args.
lncst_Args.of_SetItem ( "Args", ls_Arg )

//	Process arguments read.
event pfc_commandline ( lncst_Args )

//	Return.
return 0

end function

public function integer of_getarg (ref string as_rcommand, ref string as_argument);
integer	li_ArgEnd
//	Determine the type of argument, single/double quoted string, plain value.
choose case Left ( as_RCommand, 1 )
	case "/"
		return FAILURE
	case "'"
		//	Single quoted.
		li_ArgEnd = Pos ( as_RCommand, "'", 2 )
		if li_ArgEnd = 0 then
			return FAILURE
		else
			as_Argument = Left ( as_RCommand, li_ArgEnd - 2 )
			as_RCommand = Right ( as_RCommand, Len ( as_RCommand ) - li_ArgEnd )
		end if
	case '"'
		//	Double quoted.
		li_ArgEnd = Pos ( as_RCommand, "'", 2 )
		if li_ArgEnd = 0 then
			return FAILURE
		else
			as_Argument = Left ( as_RCommand, li_ArgEnd - 2 )
			as_RCommand = Right ( as_RCommand, Len ( as_RCommand ) - li_ArgEnd )
		end if
	case else
		//	Plain.
		li_ArgEnd = Pos ( as_RCommand, ' ', 2 )
		if li_ArgEnd = 0 then
			as_Argument = as_RCommand
			as_RCommand = ""
		else
			as_Argument = Left ( as_RCommand, li_ArgEnd - 1 )
			as_RCommand = Right ( as_RCommand, Len ( as_RCommand ) - li_ArgEnd )
		end if
end choose

//	Return.
return SUCCESS

end function

on n_cst_appmanager.create
call super::create
end on

on n_cst_appmanager.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;
//	Process command line.
of_ProcessCommandLine ( as_CommandLine )

//	Look for connect message.
string	ls_Connect
ls_Connect = IsNull ( message.inv_Parm.of_GetItem ( "SQLCAConnect" ), "" )
if ls_Connect > "" then
	if sqlca.event pfc_Connect ( ls_Connect ) = FAILURE then
		halt close
		return
	end if
end if
of_Splash (1)
return

end event

event constructor;call super::constructor;
//	Store the application root.
of_SetRoot ( )

//	Set general items.
this.of_SetHelpFile ( "" )
this.of_SetLogo ( "Bulb.Fore-Thought.bmp" )
this.of_SetCopyright( "Copyright 2009 Fore-Thought, LLC." )
this.of_SetVersion ( "1.0" )

inv_StateMsgRouter = create n_cst_statemsgrouter

//	Get a reference to the printer.
choose case ienv_object.ostype
	case windows!
		Printer = create n_cst_printer_windows
	case windowsnt!
		Printer = create n_cst_printer_winnt
	case else
		Printer = create n_cst_Printer
end choose

end event

event destructor;call super::destructor;
if IsValid(inv_StateMsgRouter) then destroy inv_StateMsgRouter
if IsValid(Printer) then destroy Printer

end event

