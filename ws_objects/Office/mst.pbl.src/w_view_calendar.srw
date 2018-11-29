$PBExportHeader$w_view_calendar.srw
$PBExportComments$calendar screen
forward
global type w_view_calendar from Window
end type
type cb_2 from commandbutton within w_view_calendar
end type
type cb_1 from commandbutton within w_view_calendar
end type
type p_prev from picture within w_view_calendar
end type
type p_next from picture within w_view_calendar
end type
type dw_cal from datawindow within w_view_calendar
end type
type sle_date from singlelineedit within w_view_calendar
end type
end forward

global type w_view_calendar from Window
int X=1025
int Y=405
int Width=860
int Height=1117
boolean TitleBar=true
string Title="Select View Date"
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
p_prev p_prev
p_next p_next
dw_cal dw_cal
sle_date sle_date
end type
global w_view_calendar w_view_calendar

type variables
Int i_old_column, nDay, nMonth, nYear
String StrDateFormat
String szreturnedstring
Date iDateSelected

end variables

forward prototypes
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer start_day_num, integer days_in_month)
public function integer get_month_number (string month)
public function string get_month_string (integer month)
public subroutine init_cal (date start_date)
public subroutine set_date_format (string date_format)
end prototypes

public subroutine draw_month (integer year, integer month);Int nFirstDayNum, nCell, nDaysInMonth
Date dFirstDay
String strYear, strMonth, strModify, strReturn

//Set Pointer to an Hourglass and turn off redrawing of Calendar
SetPointer(Hourglass!)
SetRedraw(dw_cal,FALSE)

//Set Instance variables to arguments
nMonth = month
nYear = year

//Work out how many days in the month
nDaysInMonth = f_days_in_month(Date(nYear, nMonth, 1))
If nDay > nDaysInMonth Then nDay = nDaysInMonth

//Find the date of the first day in the month
dFirstDay = Date(nYear,nMonth,1)

//Find what day of the week this is
nFirstDayNum = DayNumber(dFirstDay)

//Set the first cell
nCell = nFirstDayNum + nDay - 1

//If there was an old column turn off the highlight
If i_old_column <> 0 then
//	strModify = "#" + string(i_old_Column) + ".font.weight=~"400~""
	strModify = "#" + string(i_old_Column) + ".border=0"
	strReturn = Modify(dw_cal,strModify)
	If strReturn <> "" then MessageBox("Modify",strReturn)
End If

//Set the Title
strMonth = get_month_string(nMonth) + " " + string(nYear)
Modify(dw_cal,"st_month.text=~"" + strMonth + "~"")

//Enter the day numbers into the datawindow
enter_day_numbers(nFirstDayNum,nDaysInMonth)

//????
SetItem(dw_cal,1,nCell,String(nDay))

//Highlight the current date
//strModify = "#" + string(nCell) + ".font.weight=~"700~""
strModify = "#" + string(nCell) + ".border=5"
strReturn = Modify(dw_cal,strModify)
If strReturn <> "" then MessageBox("Modify",strReturn)

//Set the old column for next time
i_old_column = nCell

//Reset the pointer and Redraw
SetPointer(Arrow!)
SetRedraw(dw_cal,TRUE)

end subroutine

public subroutine enter_day_numbers (integer start_day_num, integer days_in_month);Int nCount, nDayCount
string	strmodify, strReturn

//Blank the columns before the first day of the month
For nCount = 1 to start_day_num
	SetItem(dw_cal,1,nCount,"")
Next

//Set the columns for the days to the String of their Day number
For nCount = 1 to days_in_month
	//Use nDayCount to find which column needs to be set
	nDayCount = start_day_num + nCount - 1
	SetItem(dw_cal,1,nDayCount,String(nCount))
Next

//Move to next column
nDayCount = nDayCount + 1

//Blank remainder of columns
For nCount = nDayCount to 42
	SetItem(dw_cal,1,nCount,"")
Next


//If there was an old column turn off the highlight
If i_old_column <> 0 then
//	strModify = "#" + string(i_old_Column) + ".font.weight=~"400~""
	strModify = "#" + string(i_old_Column) + ".border=0"
	strReturn = Modify(dw_cal,strModify)
	If strReturn <> "" then MessageBox("Modify",strReturn)
End If


i_old_column = 0


end subroutine

public function integer get_month_number (string month);Int month_number

CHOOSE CASE month
	CASE "Jan"
		month_number = 1
	CASE "Feb"
		month_number = 2
	CASE "Mar"
		month_number = 3
	CASE "Apr"
		month_number = 4
	CASE "May"
		month_number = 5
	CASE "Jun"
		month_number = 6
	CASE "Jul"
		month_number = 7
	CASE "Aug"
		month_number = 8
	CASE "Sep"
		month_number = 9
	CASE "Oct"
		month_number = 10
	CASE "Nov"
		month_number = 11
	CASE "Dec"
		month_number = 12
END CHOOSE

return month_number
end function

public function string get_month_string (integer month);String strMonth

CHOOSE CASE month
	CASE 1
		strMonth = "January"
	CASE 2
		strMonth = "February"
	CASE 3
		strMonth = "March"
	CASE 4
		strMonth = "April"
	CASE 5
		strMonth = "May"
	CASE 6
		strMonth = "June"
	CASE 7
		strMonth = "July"
	CASE 8
		strMonth = "August"
	CASE 9
		strMonth = "September"
	CASE 10
		strMonth = "October"
	CASE 11
		strMonth = "November"
	CASE 12
		strMonth = "December"
END CHOOSE

return strMonth
end function

public subroutine init_cal (date start_date);Int nFirstDayNum, nCell, nDaysInMonth
String strYear, strMonth, strModify, strReturn
Date dFirstDay


//Insert a row into the script datawindow
InsertRow(dw_cal,0)

//Set the variables for Day, Month and Year from the date passed to
//the function
nMonth = Month(start_date)
nYear = Year(start_date)
nDay = Day(start_date)

//Find how many days in the relevant month
nDaysInMonth = f_days_in_month(start_date)

//Find the date of the first day of this month
dFirstDay = Date(nYear,nMonth,1)

//What day of the week is the first day of the month
nFirstDayNum = DayNumber(dFirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
nCell = nFirstDayNum + nDay - 1

//Set the Title of the calendar with the Month and Year
strMonth = get_month_string(nMonth) + " " + string(nYear)
Modify(dw_cal,"st_month.text=~"" + strMonth + "~"")

//Enter the numbers of the days
enter_day_numbers(nFirstDayNum,nDaysInMonth)

//????
SetItem(dw_cal,1,nCell,String(Day(start_date)))

//Display the first day in bold (or 3D)
//strModify = "#" + string(nCell) + ".font.weight=~"700~""
strModify = "#" + string(nCell) + ".border=5"
strReturn = Modify(dw_cal,strModify)
If strReturn <> "" then MessageBox("Modify",strReturn)

//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
i_old_column = nCell

end subroutine

public subroutine set_date_format (string date_format);strDateFormat = date_format
end subroutine

on deactivate;bFinish	= TRUE
Close(this)

end on

on open;Date lDate

sle_date.text	= Message.StringParm

reset(dw_cal)

// If there is already a date in the edit box then make this the
// current date in the calendar, otherwise use today

lDate = date(sle_date.text)
init_cal(lDate)

szReturnedString	= " "



	
end on

on w_view_calendar.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_prev=create p_prev
this.p_next=create p_next
this.dw_cal=create dw_cal
this.sle_date=create sle_date
this.Control[]={ this.cb_2,&
this.cb_1,&
this.p_prev,&
this.p_next,&
this.dw_cal,&
this.sle_date}
end on

on w_view_calendar.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_prev)
destroy(this.p_next)
destroy(this.dw_cal)
destroy(this.sle_date)
end on

type cb_2 from commandbutton within w_view_calendar
int X=421
int Y=881
int Width=257
int Height=109
int TabOrder=40
string Text="Cancel"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;bFinish	= TRUE
szReturnedString	= " "
CloseWithReturn(parent, " " )

end on

type cb_1 from commandbutton within w_view_calendar
int X=147
int Y=881
int Width=257
int Height=109
int TabOrder=30
string Text="OK"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;szReturnedString	= String(Date(nYear, nMonth, nDay))
bFinish	= TRUE
CloseWithReturn(parent, String(Date(nYear, nMonth, nDay)))

end on

type p_prev from picture within w_view_calendar
int X=19
int Y=881
int Width=110
int Height=113
string PictureName="prior1.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

on clicked;//Decrement the month, if 0, set to 12 (December)
nMonth = nMonth - 1
If nMonth = 0 then
	nMonth = 12
	nYear = nYear - 1
End If

//Darw the month
draw_month ( nYear, nMonth )
end on

type p_next from picture within w_view_calendar
int X=714
int Y=881
int Width=110
int Height=113
string PictureName="next1.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

on clicked;//Increment the month number, but if its 13, set back to 1 (January)
nMonth = nMonth + 1
If nMonth = 13 then
	nMonth = 1
	nYear = nYear + 1
End If

//Draw the month
draw_month ( nYear, nMonth )
end on

type dw_cal from datawindow within w_view_calendar
int X=19
int Y=17
int Width=805
int Height=833
int TabOrder=20
string DataObject="d_calendar"
BorderStyle BorderStyle=StyleRaised!
boolean LiveScroll=true
end type

on clicked;Int nClickedColumn, nClickedCol, nLength
String strOld, strOldNum, strDay, strModify, strReturn

//Find which column was clicked on and return if it is no valid
nClickedColumn = GetClickedColumn(dw_cal)
If nClickedColumn = 0 then Return

//Set Day to the text of the clicked column. Return if it is an
//empty column
strDay = GetItemString(dw_cal,1,nClickedColumn)
If strDay = "" then Return

//Convert to a number and place in Instance variable
nDay = Integer(strDay)

//????
SetItem(dw_cal,1,nClickedColumn,strDay)

//Highlight chosen day
//strModify = "#" + string(nClickedColumn) + ".font.weight=~"700~""
strModify = "#" + string(nClickedColumn) + ".border=5"
strReturn = Modify(dw_cal,strModify)
If strReturn <> "" then MessageBox("Modify",strReturn)

//If the highlight was on a previous column (i_old_column = 0)
//set the border of the old column back to normal
If i_old_column <> 0 then
//	strModify = "#" + string(i_old_Column) + ".font.weight=~"400~""
	strModify = "#" + string(i_old_Column) + ".border=0"
	strReturn = Modify(dw_cal,strModify)
	If strReturn <> "" then MessageBox("Modify",strReturn)
End If

//Set the old column for next time
i_old_column = nClickedColumn


nClickedCol = GetClickedColumn(dw_cal)
If nClickedCol = 0 then Return

//Set the Day to the chosen column
strDay = GetItemString(dw_cal,1,nClickedCol)
nDay = Integer(strDay)

//Return the chosen date into the SingleLineEdit in the chosen format
sle_date.text = String( Date(nYear,nMonth,nDay), strDateFormat )

//If there is an old column, reset the border
If i_old_column <> 0 then
	strModify = "#" + string(nClickedCol) + ".font.weight=~"400~""
	strReturn = Modify(dw_cal,strModify)
	If strReturn <> "" then MessageBox("Modify",strReturn)
End If


end on

type sle_date from singlelineedit within w_view_calendar
int X=513
int Y=65
int Width=439
int Height=97
int TabOrder=10
boolean Visible=false
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

