$PBExportHeader$w_super_cop.srw
forward
global type w_super_cop from Window
end type
type cbx_process from checkbox within w_super_cop
end type
type st_sindicator from statictext within w_super_cop
end type
type st_pindicator from statictext within w_super_cop
end type
type st_speed from statictext within w_super_cop
end type
type st_percent from statictext within w_super_cop
end type
type em_countdown from editmask within w_super_cop
end type
type em_interval from editmask within w_super_cop
end type
type em_sys_time from editmask within w_super_cop
end type
type dw_bom from datawindow within w_super_cop
end type
type st_3 from statictext within w_super_cop
end type
type st_2 from statictext within w_super_cop
end type
type st_1 from statictext within w_super_cop
end type
type gb_1 from groupbox within w_super_cop
end type
end forward

type str_size from structure
	integer		x
	integer		y
	integer		width
	integer		height
	integer		fontsize
end type

global type w_super_cop from Window
int X=0
int Y=0
int Width=2953
int Height=1624
boolean TitleBar=true
string Title="Super  Cop"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
string Icon="MONITOR.ICO"
event super_cop pbm_custom01
event stop pbm_custom02
event reset pbm_custom03
event run pbm_custom04
event type integer ue_resize ( integer newwidth,  integer newheight )
event start_now pbm_custom05
cbx_process cbx_process
st_sindicator st_sindicator
st_pindicator st_pindicator
st_speed st_speed
st_percent st_percent
em_countdown em_countdown
em_interval em_interval
em_sys_time em_sys_time
dw_bom dw_bom
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_super_cop w_super_cop

type variables
TIME	it_StartTime, &
	it_IntervalTime

BOOLEAN	ib_Processed, &
		ib_Running

string     is_platform

str_super_cop_parms istr_super_cop_parms

Long         il_rows
Long         il_count = 1

// variables to resize the objects
Boolean ib_exec

int ii_win_width, ii_win_height, ii_win_frame_w, ii_win_frame_h
private:
str_size size_ctrl [] 


end variables

forward prototypes
public function long wf_get_orders ()
public subroutine wf_display_percent (integer al_level)
public function integer wf_get_window_metrics (string a_s_metric_name)
public function integer wf_size_it ()
public function integer wf_resize_it (double size_factor)
end prototypes

event super_cop;/* 01-14-2000 KAZ Modified autocommit property, removed platform conditional.  This fixes
                  lockups occuring with SQLAnywhere when creating manual work orders.     */

string					ls_part
long						ll_cur_row, ll_level, lcv, ll_count, ll_rows
Transaction 			db_native_trans
pointer 					oldpointer  // Declares a pointer variable
	
If cbx_process.checked Then
	istr_super_cop_parms.a_regen_all = 'Y'
Else
	istr_super_cop_parms.a_regen_all = 'N'
End if

setnull(istr_super_cop_parms.a_order_no)
setnull(istr_super_cop_parms.a_row_id)

oldpointer = SetPointer(HourGlass!)

il_rows  = wf_get_orders ( )
il_count = 1

timer ( 0 )   //this line needs to be there

DECLARE super_cop_wc PROCEDURE FOR msp_super_cop  
  	   :istr_super_cop_parms.a_regen_all,   
     	:istr_super_cop_parms.a_order_no,   
     	:istr_super_cop_parms.a_row_id
USING sqlca;

//IF g_s_platform = "Microsoft SQL Server" THEN sqlca.autocommit = TRUE - 01-14-2000 KAZ
sqlca.autocommit = TRUE  // 01-14-2000 KAZ

execute super_cop_wc;

IF sqlca.sqlcode < 0 THEN
	  MessageBox ("System Message", sqlca.sqlerrtext, Information! )
END IF

FETCH super_cop_wc  INTO :ls_part,  :ll_level  ;

wf_display_percent(ll_level)

DO WHILE sqlca.sqlcode = 0
	dw_bom.reset()
	DO WHILE sqlca.sqlcode = 0
		dw_bom.setredraw(false)
		ll_cur_row = dw_bom.insertrow(0)
      dw_bom.setitem(ll_cur_row - 1, 3, 0)
		dw_bom.setitem(ll_cur_row,1,ls_part)
		dw_bom.setitem(ll_cur_row,2,ll_level)
      dw_bom.setitem(ll_cur_row,3,1)        
      dw_bom.setredraw(true)
		FETCH super_cop_wc INTO :ls_part,  :ll_level  ;

		wf_display_percent(0)

	LOOP

   FETCH super_cop_wc INTO :ls_part,  :ll_level  ;

	wf_display_percent(ll_level)

LOOP

close super_cop_wc;

//IF g_s_platform = "Microsoft SQL Server" THEN 	sqlca.autocommit = FALSE - 01-14-2000 KAZ
sqlca.autocommit = FALSE  // 01-14-2000 KAZ

dw_bom.reset()
em_countdown.text = em_interval.text
st_pindicator.text = ''
st_sindicator.text = ''
timer (1)

SetPointer ( oldpointer )
end event

on stop;em_countdown.text = string('00:00:00')
ib_Running = FALSE
end on

on reset;If messagebox( 'System Message', 'This will reset the COP explosion flags for all order detail records~r and will delete all of the master production schedule records!~r Do you wish to proceed?', Question!, YesNo!, 2  ) = 1 then

	If messagebox( 'System Message', 'This process will take a few minutes. Make sure that~r the production schedule or shop floor is not being used!', Information!, OkCancel!, 2 ) = 1 Then

		UPDATE order_detail
		SET flag = 1;

	   Delete from master_prod_Sched where field5 <> 'Quote' or field5 is null ; 

		If SQLCA.SQLCode = 0 then
			COMMIT;
			messagebox( 'System Message', 'All the flags have been reset!', Information! )
		Else
			ROLLBACK;
			messagebox( 'System Message', 'Failed to reset all flags!', Information! )
		End if

	End if

End if


end on

on run;it_StartTime = Now ( )
it_IntervalTime = time(em_interval.text)
em_countdown.text = em_interval.text
ib_Processed = False
ib_Running = TRUE


 
end on

event start_now;it_StartTime = Now ( )
it_IntervalTime = time(em_interval.text)
ib_Processed = False
ib_Running = TRUE
em_countdown.selecttext ( 1, LenA ( em_countdown.text ) )
em_countdown.replacetext ( '00:00:00' )
w_super_cop.title = 'Monitor Super Cop/ Time Interval: '+string(it_intervaltime)+' /CountDown Time: ' +em_countdown.text
w_super_cop.TriggerEvent('super_cop') 
end event

public function long wf_get_orders ();integer li_days
long	  ll_count

SELECT days_to_process
INTO   :li_days
FROM   parameters ;

IF g_s_platform <> 'Microsoft SQL Server' THEN

	IF cbx_process.checked THEN
		SELECT count(*)
		INTO   :ll_count
		FROM 	 order_detail
		WHERE  std_qty > 0 AND days(now(*),due_date)<=:li_days ;
	ELSE
		SELECT count(*)
		INTO   :ll_count
		FROM 	 order_detail
		WHERE  std_qty > 0 AND days(now(*),due_date)<=:li_days AND flag = 1 ;
	END IF
ELSE
	IF cbx_process.checked THEN
		SELECT count(*)
		INTO   :ll_count
		FROM 	 order_detail
		WHERE  std_qty > 0  AND datediff(dd,getdate(),due_date) <= :li_days ;
	ELSE
		SELECT count(*)
		INTO   :ll_count
		FROM 	 order_detail
		WHERE  std_qty > 0  AND datediff(dd,getdate(),due_date) <= :li_days AND flag = 1;
	END IF
END IF

IF SQLCA.SQLCODE <> 0 THEN
  ll_count = 0
END IF

st_sindicator.text = string(ll_count)

RETURN ll_count
end function

public subroutine wf_display_percent (integer al_level);long ll_rate

If st_sindicator.text = '0' THEN RETURN

IF al_level = 1  THEN
  	 il_count  = il_Count + 1 
END IF

IF il_rows <> il_count  AND il_rows > 0 THEN
  	ll_rate = truncate ( 100 * il_count / il_rows, 0 )
   IF ll_rate >= 100 THEN
  	   ll_rate = 100
   END IF
	st_pindicator.text = string ( ll_rate) + '%'
ELSEIF il_rows = 0 THEN
  	st_pindicator.text = '0%'
END IF


end subroutine

public function integer wf_get_window_metrics (string a_s_metric_name);STRING	l_s_metric

RegistryGet ( "HKEY_CURRENT_USER\Control Panel\desktop\WindowMetrics", a_s_metric_name, l_s_metric )
Return ( Integer ( l_s_metric ) / (-15) )
end function

public function integer wf_size_it ();dragobject temp
int cnt,i
ii_win_width  = this.width
ii_win_height = this.height
ii_win_frame_w = this.width - this.WorkSpaceWidth()
ii_win_frame_h = this.height - this.WorkSpaceHeight()

cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	
	// everything has a x,y,width and height
	size_ctrl[i].x = temp.x 
	size_ctrl[i].width = temp.width 
	size_ctrl[i].y = temp.y
	size_ctrl[i].height = temp.height 

	// now go get text size information
	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			size_ctrl[i].fontsize = cb.textsize 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			size_ctrl[i].fontsize = sle.textsize 

		case statictext!
			statictext st
			st = temp
			size_ctrl[i].fontsize  	=	st.textsize 
			
		case editmask!
			editmask em
			em = temp
			size_ctrl[i].fontsize = em.textsize 

		case checkbox!
			checkbox cbx
			cbx = temp
			size_ctrl[i].fontsize  	=	cbx.textsize 


		case groupbox!
			groupbox gb
			gb = temp
			size_ctrl[i].fontsize  	=	gb.textsize 


	end choose
next

return 1


	



end function

public function integer wf_resize_it (double size_factor);dragobject temp
int cnt,i

ib_exec = false // keep the function from being called recursively
this.hide()

// resize the window
this.width = ((  ii_win_width - ii_win_frame_w) * size_factor) + ii_win_frame_w
this.height = ((  ii_win_height - ii_win_frame_h) * size_factor) + ii_win_frame_h

// for each control in the list, resize it and it's textsize (as applicable)
cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	temp.x		 = size_ctrl[i].x * size_factor
	temp.width   = size_ctrl[i].width  * size_factor
	temp.y		 = size_ctrl[i].y * size_factor
	temp.height  = size_ctrl[i].height * size_factor 

	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			cb.textsize =  size_ctrl[i].fontsize * size_factor 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			sle.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case editmask!
			editmask em
			em = temp
			em.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case statictext!
			statictext st
			st = temp
			st.textsize =  size_ctrl[i].fontsize * size_factor 
			
		case checkbox!
			checkbox cbx
			cbx = temp
			cbx.textsize =  size_ctrl[i].fontsize * size_factor 

		case groupbox!
			groupbox gb
			gb = temp
			gb.textsize =  size_ctrl[i].fontsize * size_factor 


		case radiobutton!
			radiobutton rb
			rb = temp
			rb.textsize =  size_ctrl[i].fontsize * size_factor 

	end choose
next
	
this.Show()
ib_exec = true
return 1


end function

on timer;TIME	lt_Now

INTEGER	li_HrsAfter, &
			li_MinAfter, &
			li_SecAfter

LONG		ll_TotSecAfter

lt_Now = Now ( )

em_sys_time.text = string(lt_Now)

IF ib_Running THEN
	ll_TotSecAfter = Hour ( time(em_interval.text) ) * 3600 + &
					  Minute ( time(em_interval.text) ) * 60 + &
					  Second ( time(em_interval.text) ) - SecondsAfter ( it_StartTime, lt_now )
	li_HrsAfter = ll_TotSecAfter / 3600
	ll_TotSecAfter = Mod ( ll_TotSecAfter, 3600 )
	li_MinAfter = ll_TotSecAfter / 60
	li_SecAfter = Mod ( ll_TotSecAfter, 60 )
	em_countdown.text = string(Time ( li_HrsAfter, li_MinAfter, li_SecAfter ))

END IF

w_super_cop.title = 'Monitor Super Cop/ Time Interval: '+string(it_intervaltime)+' /CountDown Time: ' +em_countdown.text

IF ib_Running THEN
	IF em_countdown.text = '00:00:00' THEN
		ib_Processed = TRUE
		SetMicroHelp ( 'Processing releases' )
		triggerevent ( 'super_cop' )
		SetMicroHelp ( 'Ready' )
		TriggerEvent ( 'stop' )
		PostEvent ( 'run' )
	ELSE
		SetMicroHelp ( 'Ready' )
	END IF
END IF




end on

event open;int rc

is_platform = sqlca.sqlreturndata

em_interval.text = string('00:00:10')

rc = wf_size_it ()
ib_exec = true

Timer ( 1 )

//POSTEVENT ('ue_open' )
end event

on w_super_cop.create
this.cbx_process=create cbx_process
this.st_sindicator=create st_sindicator
this.st_pindicator=create st_pindicator
this.st_speed=create st_speed
this.st_percent=create st_percent
this.em_countdown=create em_countdown
this.em_interval=create em_interval
this.em_sys_time=create em_sys_time
this.dw_bom=create dw_bom
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cbx_process,&
this.st_sindicator,&
this.st_pindicator,&
this.st_speed,&
this.st_percent,&
this.em_countdown,&
this.em_interval,&
this.em_sys_time,&
this.dw_bom,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_super_cop.destroy
destroy(this.cbx_process)
destroy(this.st_sindicator)
destroy(this.st_pindicator)
destroy(this.st_speed)
destroy(this.st_percent)
destroy(this.em_countdown)
destroy(this.em_interval)
destroy(this.em_sys_time)
destroy(this.dw_bom)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event resize;double ratiow, ratio, ratioh
int rc

dw_bom.width = newwidth * 0.74
dw_bom.height	= newheight * 0.90

if ib_Exec then
	ratioh	=	this.height / ii_win_height
	ratiow	=	this.width / ii_win_width
	ratio		= min ( ratioh, ratiow )
	rc			= wf_resize_it ( ratio )
end if


end event

event activate;IF gnv_App.of_GetFrame().MenuName <> "m_super_cop" THEN &
	gnv_App.of_GetFrame().ChangeMenu ( m_super_cop )
end event

type cbx_process from checkbox within w_super_cop
int X=27
int Y=848
int Width=649
int Height=76
string Text="Process All Orders :"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_sindicator from statictext within w_super_cop
int X=407
int Y=1148
int Width=247
int Height=72
boolean Enabled=false
boolean Border=true
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_pindicator from statictext within w_super_cop
int X=407
int Y=1036
int Width=247
int Height=72
boolean Enabled=false
boolean Border=true
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_speed from statictext within w_super_cop
int X=59
int Y=1148
int Width=247
int Height=72
boolean Enabled=false
string Text="Orders:"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_percent from statictext within w_super_cop
int X=59
int Y=1036
int Width=329
int Height=72
boolean Enabled=false
string Text="Processed:"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_countdown from editmask within w_super_cop
int X=14
int Y=656
int Width=677
int Height=160
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData="<$$HEX1$$f400$$ENDHEX$$w_part_detail"
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_interval from editmask within w_super_cop
int X=14
int Y=380
int Width=677
int Height=160
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;if time(this.text) < time('00:00:10') then
  w_super_cop.setmicrohelp ("Time interval cannot be lesser than 10 seconds")
  this.text = '00:00:10'
  setfocus()
end if


end on

type em_sys_time from editmask within w_super_cop
int X=14
int Y=100
int Width=677
int Height=160
BorderStyle BorderStyle=StyleLowered!
string Mask="hh:mm:ss"
MaskDataType MaskDataType=TimeMask!
string DisplayData=""
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on constructor;em_sys_time.text = string(now())
end on

type dw_bom from datawindow within w_super_cop
event ue_move pbm_nchittest
int X=704
int Y=20
int Width=2194
int Height=1344
int TabOrder=10
string DataObject="dw_bom_explode"
boolean TitleBar=true
string Title="BOM Explode"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
string Icon="MONITOR.ICO"
end type

event ue_move;RETURN 1
end event

type st_3 from statictext within w_super_cop
int X=27
int Y=16
int Width=489
int Height=64
boolean Enabled=false
string Text="System Time:"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_super_cop
int X=27
int Y=556
int Width=553
int Height=72
boolean Enabled=false
string Text="Time until next:"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_super_cop
int X=27
int Y=280
int Width=366
int Height=80
boolean Enabled=false
string Text="Interval:"
boolean FocusRectangle=false
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_super_cop
int X=27
int Y=932
int Width=667
int Height=352
int TabOrder=30
string Text="Status Report: "
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

