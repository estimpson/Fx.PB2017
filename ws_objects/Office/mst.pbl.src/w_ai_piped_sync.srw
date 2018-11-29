$PBExportHeader$w_ai_piped_sync.srw
forward
global type w_ai_piped_sync from w_ai_ancestor
end type
type dw_error from datawindow within w_ai_piped_sync
end type
type cb_1 from commandbutton within w_ai_piped_sync
end type
type cb_2 from commandbutton within w_ai_piped_sync
end type
type cb_3 from commandbutton within w_ai_piped_sync
end type
type st_1 from statictext within w_ai_piped_sync
end type
type dw_progress from uo_progress_bar within w_ai_piped_sync
end type
type cb_4 from commandbutton within w_ai_piped_sync
end type
type st_5 from statictext within w_ai_piped_sync
end type
type st_3 from statictext within w_ai_piped_sync
end type
type st_2 from statictext within w_ai_piped_sync
end type
type st_4 from statictext within w_ai_piped_sync
end type
end forward

global type w_ai_piped_sync from w_ai_ancestor
int Width=1970
int Height=920
WindowType WindowType=response!
boolean TitleBar=true
string Title="Customer Sync"
long BackColor=12632256
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_open pbm_custom01
dw_error dw_error
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
st_1 st_1
dw_progress dw_progress
cb_4 cb_4
st_5 st_5
st_3 st_3
st_2 st_2
st_4 st_4
end type
global w_ai_piped_sync w_ai_piped_sync

type variables
BOOLEAN	ib_MeToYou

end variables

forward prototypes
public function integer wf_execute_transaction (string as_transactiontype)
private function integer wf_execute_pipeline ()
public function integer wf_build_pipeline (string as_name)
private function integer wf_execute_stored_procedure (string as_name, string as_parameters)
end prototypes

on ue_open;call w_ai_ancestor::ue_open;ipl_PipeLine = CREATE uo_pipeline
This.PostEvent ( 'ue_open2' )
end on

public function integer wf_execute_transaction (string as_transactiontype);STRING	s_Name, &
		s_Type, &
		s_Parameters

INTEGER	i_Sequence, &
		i_Total, &
		i_Count

 DECLARE	transactions CURSOR FOR
  SELECT	interface_utilities.name,
		interface_utilities.type,
		interface_utilities.sequence,
		interface_utilities.parameters
    FROM	interface_utilities
   WHERE	interface_utilities.transaction_type = :as_TransactionType   ;

    OPEN	transactions  ;

  SELECT	count(*)
    INTO	:i_Total
    FROM	interface_utilities
   WHERE	interface_utilities.transaction_type = :as_TransactionType  ;

st_4.Text = String ( i_Total )
cb_4.Visible = TRUE
st_2.Visible = TRUE
st_3.Visible = TRUE
st_4.Visible = TRUE
st_5.Visible = TRUE

FOR i_Count = 1 TO i_Total
	st_2.Text = String ( i_Count )

	   FETCH	transactions INTO :s_Name, :s_Type, :i_Sequence, :s_Parameters ;

	CHOOSE CASE s_Type
	CASE	'P'
		wf_build_pipeline ( s_Name )
		wf_execute_pipeline ( )
	CASE	'S'
		wf_execute_stored_procedure ( s_Name, s_Parameters )
	END CHOOSE
NEXT
cb_4.Visible = FALSE
st_2.Visible = FALSE
st_3.Visible = FALSE
st_4.Visible = FALSE
st_5.Visible = FALSE

   CLOSE	transactions ;

Return 0
end function

private function integer wf_execute_pipeline ();STRING	s_CursorSyntax, &
			s_SelectSyntax, &
			s_DbProfileName
LONG		l_BeginningByte, &
			l_EndingByte, &
			l_Count
INTEGER	i_Return
BOOLEAN	b_MeToYou

This.Enabled = FALSE
cb_2.Enabled = FALSE
l_BeginningByte = PosA ( ipl_PipeLine.Syntax, 'source_connect=' ) + 15
l_EndingByte = PosA ( ipl_PipeLine.Syntax, ',', l_BeginningByte )
s_DbProfileName = MidA ( ipl_Pipeline.Syntax, l_BeginningByte, l_EndingByte - l_BeginningByte )
IF Upper ( s_DbProfileName ) = Upper ( is_AIDbProfile ) THEN
	b_MeToYou = FALSE
ELSE
	b_MeToYou = TRUE
END IF

l_BeginningByte = PosA ( ipl_PipeLine.Syntax, 'RETRIEVE(statement="' )
l_BeginningByte = PosA ( ipl_PipeLine.Syntax, 'FROM', l_BeginningByte )
l_EndingByte = PosA ( ipl_PipeLine.Syntax, 'DESTINATION(name="' ) - 4

s_SelectSyntax = MidA ( ipl_PipeLine.Syntax, l_BeginningByte, l_EndingByte - l_BeginningByte )
s_SelectSyntax = 'SELECT count(*) ' + s_SelectSyntax

DECLARE count DYNAMIC CURSOR FOR SQLSA ;
IF b_MeToYou THEN
	PREPARE SQLSA FROM :s_SelectSyntax ;
ELSE
	PREPARE SQLSA FROM :s_SelectSyntax USING gitr_accounting_interface ;
END IF
OPEN DYNAMIC count ;
FETCH count INTO :l_Count ;
CLOSE count ;

//monitor.greal_TimerTotal = l_Count
//monitor.greal_TimerCurrent = 0
Timer ( .1 )

IF b_MeToYou THEN
	i_Return = ipl_PipeLine.Start ( SQLCA, gitr_accounting_interface, dw_error )
ELSE
	i_Return = ipl_PipeLine.Start ( gitr_accounting_interface, SQLCA, dw_error )
END IF
This.Enabled = TRUE
cb_2.Enabled = TRUE
Timer ( 0 )
dw_progress.Reset ( )

// i_Return values:
//  -1	Pipe open failed
//	  -2	Too many columns
//	  -3	Table already exists
//	  -4	Table does not exist
//	  -5	Missing connection
//	  -6	Wrong arguments
//	  -7	Column mismatch
//	  -8	Fatal SQL error in source
//	  -9	Fatal SQL error in destination
//	-10	Maximum number of errors exceeded
//	-12	Bad table syntax
//	-13	Key required but not supplied
//
//-15	Pipe already in progress
//	-16	Error in source database
//	-17	Error in destination database
//	-18	Destination database is read-only

return 0
end function

public function integer wf_build_pipeline (string as_name);STRING	s_PipeSyntax, &
			s_PBLName

  SELECT accounting_pbl_name
    INTO	:s_PBLName
    FROM	parameters  ;

s_PipeSyntax = LibraryExport ( s_PBLName, as_Name , ExportPipeline! )
ipl_PipeLine.Syntax = s_PipeSyntax

Return 0
end function

private function integer wf_execute_stored_procedure (string as_name, string as_parameters);STRING	s_ProcedureCallSyntax

s_ProcedureCallSyntax = 'EXECUTE ' + as_Name + ' ' + as_Parameters

SQLCA.autocommit = True
EXECUTE IMMEDIATE :s_ProcedureCallSyntax  ;
SQLCA.autocommit = False

Return 0
end function

on timer;call w_ai_ancestor::timer;dw_progress.uof_begin ( )
end on

on w_ai_piped_sync.create
int iCurrent
call super::create
this.dw_error=create dw_error
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_1=create st_1
this.dw_progress=create dw_progress
this.cb_4=create cb_4
this.st_5=create st_5
this.st_3=create st_3
this.st_2=create st_2
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_error
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.dw_progress
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_4
end on

on w_ai_piped_sync.destroy
call super::destroy
destroy(this.dw_error)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.dw_progress)
destroy(this.cb_4)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_4)
end on

type dw_error from datawindow within w_ai_piped_sync
int X=151
int Y=108
int Width=1632
int Height=528
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_ai_piped_sync
int X=18
int Y=708
int Width=288
int Height=108
int TabOrder=50
string Text="Execute"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_ai_piped_sync
int X=1696
int Y=708
int Width=247
int Height=108
int TabOrder=40
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type cb_3 from commandbutton within w_ai_piped_sync
int X=562
int Y=708
int Width=247
int Height=108
int TabOrder=60
boolean Visible=false
string Text="Clear"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ipl_PipeLine.Syntax = ''
MessageBox ( '------', 'Cleared' )
end on

type st_1 from statictext within w_ai_piped_sync
int X=18
int Y=8
int Width=1929
int Height=88
boolean Enabled=false
string Text="Accounting Interface Utility -- [transaction name]"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_progress from uo_progress_bar within w_ai_piped_sync
int X=585
int Y=704
int Width=800
int TabOrder=10
end type

type cb_4 from commandbutton within w_ai_piped_sync
int X=320
int Y=708
int Width=256
int Height=108
int TabOrder=20
boolean Visible=false
string Text="Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_ai_piped_sync
int X=1403
int Y=720
int Width=265
int Height=88
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_ai_piped_sync
int X=1504
int Y=732
int Width=64
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="of"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_ai_piped_sync
int X=1413
int Y=732
int Width=96
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_ai_piped_sync
int X=1568
int Y=732
int Width=96
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

