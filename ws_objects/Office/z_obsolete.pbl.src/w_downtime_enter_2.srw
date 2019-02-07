$PBExportHeader$w_downtime_enter_2.srw
forward
global type w_downtime_enter_2 from Window
end type
type cb_2 from commandbutton within w_downtime_enter_2
end type
type dw_downtime_at_list from datawindow within w_downtime_enter_2
end type
type sle_elapsed from statictext within w_downtime_enter_2
end type
type cb_1 from commandbutton within w_downtime_enter_2
end type
type st_start_time from statictext within w_downtime_enter_2
end type
type dw_clock from datawindow within w_downtime_enter_2
end type
type st_4 from statictext within w_downtime_enter_2
end type
type st_3 from statictext within w_downtime_enter_2
end type
type st_2 from statictext within w_downtime_enter_2
end type
type dw_defects from datawindow within w_downtime_enter_2
end type
type cb_cancel from commandbutton within w_downtime_enter_2
end type
type st_1 from statictext within w_downtime_enter_2
end type
type cb_machine_start from commandbutton within w_downtime_enter_2
end type
type sle_elapsed_old from singlelineedit within w_downtime_enter_2
end type
end forward

global type w_downtime_enter_2 from Window
int X=105
int Y=252
int Width=3026
int Height=1916
long BackColor=77897888
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=popup!
cb_2 cb_2
dw_downtime_at_list dw_downtime_at_list
sle_elapsed sle_elapsed
cb_1 cb_1
st_start_time st_start_time
dw_clock dw_clock
st_4 st_4
st_3 st_3
st_2 st_2
dw_defects dw_defects
cb_cancel cb_cancel
st_1 st_1
cb_machine_start cb_machine_start
sle_elapsed_old sle_elapsed_old
end type
global w_downtime_enter_2 w_downtime_enter_2

type variables
Private:
Time tStartTime
Date dStartDate
Long nSeconds = 0
String sReason, sreason_name
string	is_downtimedelete='N'
string	is_machine
string	is_part
string	is_workorder
end variables

forward prototypes
public subroutine getelapsedtime (ref int nhours, ref int nmins, ref int nsecs)
end prototypes

public subroutine getelapsedtime (ref int nhours, ref int nmins, ref int nsecs);/////////////////////////////////////////////////////////////////////
//
// Return the elapsed hours from tTimeOne to tTimeTwo
//

nSecs =  nSeconds

nHours = Int ( ( nSecs / 60 ) / 60 )
nSecs  -= ( nHours * 60 ) * 60 
nMins  = ( nSecs / 60 ) 
nSecs  -= ( nMins * 60 )


end subroutine

on timer;/////////////////////////////////////////////////////////////////////
//
// Update the elapsed time field in one minute
// timer messages.
// 

Int nHours
Int nMins
Int nSecs
String szTemp

nSeconds ++

GetElapsedTime ( nHours, nMins, nSecs )

szTemp = String ( nHours, "00" ) + ":" + String ( nMins, "00" ) + ":"&
	+ String ( nSecs, "00" )

sle_Elapsed.Text = szTemp


end on

event open;//	Declaration
n_cst_associative_array lncst_aa
string	ls_newsql = ''
string	ls_groupcode

//	Update the the Machine down time start
tStartTime = Now ( )
dStartDate = Today ( )
lncst_aa = message.powerobjectparm
is_machine = lncst_aa.of_getitem("machine")
is_part = lncst_aa.of_getitem("part")
is_workorder = lncst_aa.of_getitem("workorder")

st_Start_Time.Text=" "+ String ( dStartDate ) +" "+String ( tStartTime, "h:mm:ss AM/PM" )

select	group_no
into	:ls_groupcode
from	location
where	code = :is_machine;

if isnull(ls_groupcode,'') > '' then 
	dw_defects.dataobject = 'dw_downtime_list'
	dw_defects.settransobject ( sqlca )
	dw_defects.retrieve (is_machine)

else
	dw_defects.dataobject = 'dw_downtime_list_without'
	dw_defects.settransobject ( sqlca )
	dw_defects.retrieve ()
end if
//dw_defects.setsqlselect (ls_newsql)
//dw_defects.settransobject ( sqlca )
//dw_defects.retrieve (is_machine)

//messagebox ( string(sqlca.sqlcode), sqlca.sqlerrtext)

select	downtime_delete
into	:is_downtimedelete
from	machine_policy
where	machine = :is_Machine ;

dw_downtime_at_list.Retrieve(is_machine)
//	Start up a timer to update the Elapsed time static
Timer ( 1, This )
sle_Elapsed.Text = "00:00"



end event

on w_downtime_enter_2.create
this.cb_2=create cb_2
this.dw_downtime_at_list=create dw_downtime_at_list
this.sle_elapsed=create sle_elapsed
this.cb_1=create cb_1
this.st_start_time=create st_start_time
this.dw_clock=create dw_clock
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_defects=create dw_defects
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.cb_machine_start=create cb_machine_start
this.sle_elapsed_old=create sle_elapsed_old
this.Control[]={this.cb_2,&
this.dw_downtime_at_list,&
this.sle_elapsed,&
this.cb_1,&
this.st_start_time,&
this.dw_clock,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_defects,&
this.cb_cancel,&
this.st_1,&
this.cb_machine_start,&
this.sle_elapsed_old}
end on

on w_downtime_enter_2.destroy
destroy(this.cb_2)
destroy(this.dw_downtime_at_list)
destroy(this.sle_elapsed)
destroy(this.cb_1)
destroy(this.st_start_time)
destroy(this.dw_clock)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_defects)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.cb_machine_start)
destroy(this.sle_elapsed_old)
end on

type cb_2 from commandbutton within w_downtime_enter_2
int X=1906
int Y=672
int Width=914
int Height=160
int TabOrder=70
boolean Visible=false
string Text="Undo"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string  ls_downtime_delete
select	downtime_delete
into	:ls_downtime_delete
from	machine_policy
where	machine = :is_Machine ;

if ls_downtime_delete = 'N' then 
	Messagebox ( "System Message", "Downtime deletion is disabled, Contact your System Administrator")
	Return 
end if 	

If dw_downtime_at_list.visible=false Then 
	dw_downtime_at_list.Show()	
Else
	dw_downtime_at_list.Hide()		
End if 

end event

type dw_downtime_at_list from datawindow within w_downtime_enter_2
int X=1605
int Y=896
int Width=1819
int Height=896
int TabOrder=80
string DataObject="d_downtime_audit_trail_list"
boolean TitleBar=true
string Title="Downtime Audit Trail"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event constructor;This.Settransobject(sqlca)


end event

event clicked;Datetime l_d_dt
String   l_s_machine
Int      l_i_option
if row > 0 then 
	if is_downtimedelete = 'N' then 
		Messagebox ( "System Message", "Downtime deletion is disabled, Contact your System Administrator")
		row = 0 
		Return 
	end if 	
	l_d_dt      = This.getitemdatetime(row,'trans_date')
	l_s_machine = This.getitemstring(row,'machine')
	l_i_option  = Messagebox("Message","Are you sure you want to undo the entry ",Question!,YesNo!,2)
	IF l_i_option = 1 Then 
		This.deleterow(row)
		If sqlca.sqlcode = -1 Then
			Messagebox(String(sqlca.sqlcode),"Unable to carry out undo function")
		End if
		This.Update()
		If sqlca.sqlcode = -1 Then
			Messagebox(string(sqlca.sqlcode),sqlca.sqlerrtext+" Unable to carry out undo function")
			Rollback ;
		Else			
			Commit;
		End if
	End if 
end if 	
row=0

end event

type sle_elapsed from statictext within w_downtime_enter_2
int X=818
int Y=480
int Width=768
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_downtime_enter_2
int X=1906
int Y=288
int Width=914
int Height=160
int TabOrder=50
string Text="Manual Entry"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If  sreason <> "" THEN
	n_cst_associative_array lncst_aa
	lncst_aa = message.powerobjectparm
	lncst_aa.of_setitem("machine", is_machine)
	lncst_aa.of_setitem("part", is_part)
	lncst_aa.of_setitem("reason", sreason)
	lncst_aa.of_setitem("workorder", is_workorder)		

	OpenWithParm (w_manual_down_enter, lncst_aa)
ELSE
	messagebox("REASON FOR DOWNTIME ?", " Please choose a reason for the downtime")
End IF

end event

type st_start_time from statictext within w_downtime_enter_2
int X=818
int Y=96
int Width=1042
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-20
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_clock from datawindow within w_downtime_enter_2
int X=818
int Y=288
int Width=1042
int Height=160
int TabOrder=10
string DataObject="d_clock"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

type st_4 from statictext within w_downtime_enter_2
int X=55
int Y=480
int Width=731
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Elapsed Time"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_downtime_enter_2
int X=55
int Y=288
int Width=731
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Current Time"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_downtime_enter_2
int X=55
int Y=96
int Width=731
int Height=160
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Downtime Start"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_defects from datawindow within w_downtime_enter_2
int X=55
int Y=896
int Width=1527
int Height=896
int TabOrder=30
string DataObject="dw_downtime_list"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on clicked;/////////////////////////////////////////////////////////////////////
//
//  Get Reason Code

Long nRowNumber


nRowNumber = dw_defects.getclickedrow ( )

////////////////////////////////////////////////////////////////////
//
//   if clicked outside dw then don't process request
//  

If ( nRowNumber = 0 ) Then Return

Selectrow (dw_defects,0,false)
SelectRow (dw_defects,nRowNumber,true)

sreason =  dw_defects.getItemString ( nRowNumber, "dt_code")

SELECT	code_description
INTO		:sreason_name
FROM		downtime_codes
WHERE		dt_code = :sreason;


end on

type cb_cancel from commandbutton within w_downtime_enter_2
int X=1906
int Y=480
int Width=914
int Height=160
int TabOrder=60
string Text="Cancel"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
close (w_downtime_enter_2)
end on

type st_1 from statictext within w_downtime_enter_2
int X=55
int Y=768
int Width=1243
int Height=128
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Choose Reason"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77897888
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_machine_start from commandbutton within w_downtime_enter_2
int X=1906
int Y=96
int Width=914
int Height=160
int TabOrder=40
string Text="Re-Start Machine"
int TextSize=-16
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//	Declarations
Decimal nDecimalHours, &
        ld_mins, &
		  ld_secs
Int nHours
Int nMins
Int nSecs
Int nTtime
DateTime dtStopTime
DateTime dtStopDate
String sOperator
String sManual
String ls_ErrText

if isnull(sreason,'') <= '' then
	messagebox("REASON FOR DOWNTIME ?", " Please choose a reason for the downtime")
	return
end if 

dtStopTime = datetime(Today(),Now ( ))
dtStopDate = datetime(Today(),Now ( ))
nTtime = Integer(sle_elapsed.text)

GetElapsedTime ( nHours, nMins, nSecs )
ld_mins= nMins
ld_secs= nsecs

// convert seconds & minutes to hours (ie decimal hours)
nDecimalHours = (nHours + (ld_Mins / 60) + (ld_secs/3600) ) 
sManual   = "MANUAL"
INSERT INTO downtime  
         ( trans_date,   
           machine,   
           reason_code,   
           reason_name,   
           down_time,   
           notes,   
           employee,   
           shift,   
           job,   
           part,   
           qty,   
           type,   
           production_pointer,   
           data_source,  
	   trans_time )
  VALUES ( :dtStopDate,   
           :is_machine,   
           :sreason,   
           :sreason_name,   
           :nDecimalHours,
           null,   
           :szOperator,   
           null,   
           :is_workorder,   
           :is_part,   
           :nTtime, 
           null,   
           null,   
           :smanual,
	   :dtStopTime )  ;

If SQLCA.SQLCode <> 0 then
	ls_ErrText = SQLCA.SQLErrText
	Rollback;
	MessageBox ("SQL error", ls_ErrText,Information!)
	HALT
Else
	Commit;
end if

close (parent)
end event

type sle_elapsed_old from singlelineedit within w_downtime_enter_2
int X=818
int Y=672
int Width=768
int Height=160
int TabOrder=20
boolean Visible=false
BorderStyle BorderStyle=StyleRaised!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=255
long BackColor=12632256
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

