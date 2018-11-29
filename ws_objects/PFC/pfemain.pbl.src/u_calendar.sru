$PBExportHeader$u_calendar.sru
$PBExportComments$Extension Calendar class
forward
global type u_calendar from pfc_u_calendar
end type
end forward

global type u_calendar from pfc_u_calendar
end type
global u_calendar u_calendar

type variables

protected:

integer	origheight = 640
integer	origwidth = 695
end variables

forward prototypes
public function integer of_setdate (date ad_date, boolean ab_setrequestor)
end prototypes

public function integer of_setdate (date ad_date, boolean ab_setrequestor);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_setdate
//
//	access:    protected
//
//	arguments:
//  ad_date		the date to set.
//	 ab_setrequestor	switch stating if the requestor object should get this date.
//
//	returns:  integer
//		1 if it succeeds and -1 if an error occurs.
//
//	description: sets a new date on the visual calendar date.  if appropriate, it
//		will also set the requestor to get this new date.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer			li_rc = 1
integer 			li_month
integer 			li_year
integer 			li_day
integer  		li_firstdaynum
string			ls_newcell
string			ls_date

// check the argument(s).
if not inv_datetime.of_isvalid(ad_date) then
	return -1
end if

// set the new date.
id_date = ad_date

// if appropriate, set the requestor with the new date.
if ab_setrequestor then
	// convert the date into a string.
	ls_date = string(ad_date, is_dateformat)

	// set the requestor with the new date.
	if isvalid(idw_requestor) then
		if	idw_requestor.SetText(ls_date) = -1 then
			//	Send event instead.
			idw_requestor.dynamic Event pfc_dateselected(ad_date)
		end if
	elseif isvalid(iem_requestor) then
		iem_requestor.text = ls_date	
		iem_requestor.post event modified ( )
	else 
		return -1
	end if
end if
						 
//if appropriate, draw a new month.
if (year(ad_date) <> year(id_prevdate) or month(ad_date) <> month(id_prevdate)) or &
	ib_alwaysredraw then
	of_drawmonth(ad_date)
end if
						 
//initialize local values.
li_year = year(ad_date)
li_month = month(ad_date)
li_day = day(ad_date)

// unhighlight any previous cell.
if len(trim(is_prevcell)) > 0 then
	if dw_cal.modify(is_prevcell + ".border=0") <> "" then
		li_rc = -1
	end if
end if

//highlight the current date.
li_firstdaynum = daynumber(date(li_year, li_month, 1))
ls_newcell = 'cell'+string(li_firstdaynum + li_day - 1)
if dw_cal.modify(ls_newcell + ".border=5") <> "" then
	li_rc = -1
end if

// store the new previous infomration.
is_prevcell = ls_newcell
id_prevdate = ad_date

return li_rc




end function

on u_calendar.create
call super::create
end on

on u_calendar.destroy
call super::destroy
end on

event constructor;call super::constructor;
//	setup resize.
of_setresize ( true )

//	set original size.
inv_resize.post function of_setorigsize ( origwidth, origheight )

//	register controls.
inv_resize.of_register ( dw_cal, 0, 0, 100, 100 )
end event

type dw_cal from pfc_u_calendar`dw_cal within u_calendar
end type

event dw_cal::constructor;call super::constructor;
//	setup datawindow resize.
of_setresize ( true )

//	set original size.
inv_resize.post function of_setorigsize ( origwidth, origheight )

//	set minimum size.
inv_resize.post function of_setminsize ( width / 2, origheight )

//	register controls.
inv_resize.post function of_register ( "prevmonth", 0, 0, 10, 0 )
inv_resize.post function of_register ( "st_month", 10, 0, 80, 0 )
inv_resize.post function of_register ( "nextmonth", 90, 0, 10, 0 )
inv_resize.post function of_register ( "s", 0, 0, 14, 0 )
inv_resize.post function of_register ( "m", 14, 0, 14, 0 )
inv_resize.post function of_register ( "t", 29, 0, 14, 0 )
inv_resize.post function of_register ( "w", 43, 0, 14, 0 )
inv_resize.post function of_register ( "r", 57, 0, 14, 0 )
inv_resize.post function of_register ( "f", 71, 0, 14, 0 )
inv_resize.post function of_register ( "a", 86, 0, 14, 0 )
inv_resize.post function of_register ( "l", 0, 0, 100, 0 )
inv_resize.post function of_register ( "cell1", 0, 0, 14, 16 )
inv_resize.post function of_register ( "cell2", 14, 0, 14, 16 )
inv_resize.post function of_register ( "cell3", 29, 0, 14, 16 )
inv_resize.post function of_register ( "cell4", 43, 0, 14, 16 )
inv_resize.post function of_register ( "cell5", 57, 0, 14, 16 )
inv_resize.post function of_register ( "cell6", 71, 0, 14, 16 )
inv_resize.post function of_register ( "cell7", 86, 0, 14, 16 )
inv_resize.post function of_register ( "cell8", 0, 16, 14, 16 )
inv_resize.post function of_register ( "cell9", 14, 16, 14, 16 )
inv_resize.post function of_register ( "cell10", 29, 16, 14, 16 )
inv_resize.post function of_register ( "cell11", 43, 16, 14, 16 )
inv_resize.post function of_register ( "cell12", 57, 16, 14, 16 )
inv_resize.post function of_register ( "cell13", 71, 16, 14, 16 )
inv_resize.post function of_register ( "cell14", 86, 16, 14, 16 )
inv_resize.post function of_register ( "cell15", 0, 33, 14, 16 )
inv_resize.post function of_register ( "cell16", 14, 33, 14, 16 )
inv_resize.post function of_register ( "cell17", 29, 33, 14, 16 )
inv_resize.post function of_register ( "cell18", 43, 33, 14, 16 )
inv_resize.post function of_register ( "cell19", 57, 33, 14, 16 )
inv_resize.post function of_register ( "cell20", 71, 33, 14, 16 )
inv_resize.post function of_register ( "cell21", 86, 33, 14, 16 )
inv_resize.post function of_register ( "cell22", 0, 50, 14, 16 )
inv_resize.post function of_register ( "cell23", 14, 50, 14, 16 )
inv_resize.post function of_register ( "cell24", 29, 50, 14, 16 )
inv_resize.post function of_register ( "cell25", 43, 50, 14, 16 )
inv_resize.post function of_register ( "cell26", 57, 50, 14, 16 )
inv_resize.post function of_register ( "cell27", 71, 50, 14, 16 )
inv_resize.post function of_register ( "cell28", 86, 50, 14, 16 )
inv_resize.post function of_register ( "cell29", 0, 67, 14, 16 )
inv_resize.post function of_register ( "cell30", 14, 67, 14, 16 )
inv_resize.post function of_register ( "cell31", 29, 67, 14, 16 )
inv_resize.post function of_register ( "cell32", 43, 67, 14, 16 )
inv_resize.post function of_register ( "cell33", 57, 67, 14, 16 )
inv_resize.post function of_register ( "cell34", 71, 67, 14, 16 )
inv_resize.post function of_register ( "cell35", 86, 67, 14, 16 )
inv_resize.post function of_register ( "cell36", 0, 83, 14, 16 )
inv_resize.post function of_register ( "cell37", 14, 83, 14, 16 )
inv_resize.post function of_register ( "cell38", 29, 83, 14, 16 )
inv_resize.post function of_register ( "cell39", 43, 83, 14, 16 )
inv_resize.post function of_register ( "cell40", 57, 83, 14, 16 )
inv_resize.post function of_register ( "cell41", 71, 83, 14, 16 )
inv_resize.post function of_register ( "cell42", 86, 83, 14, 16 )

end event

