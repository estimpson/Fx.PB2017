$PBExportHeader$u_date_lists.sru
$PBExportComments$(mst.pbl) user object to list dates.
forward
global type u_date_lists from UserObject
end type
type st_indicate7 from statictext within u_date_lists
end type
type st_indicate6 from statictext within u_date_lists
end type
type st_indicate5 from statictext within u_date_lists
end type
type st_indicate4 from statictext within u_date_lists
end type
type st_indicate3 from statictext within u_date_lists
end type
type st_indicate2 from statictext within u_date_lists
end type
type st_indicate1 from statictext within u_date_lists
end type
type st_day7 from statictext within u_date_lists
end type
type st_day6 from statictext within u_date_lists
end type
type st_day5 from statictext within u_date_lists
end type
type st_day4 from statictext within u_date_lists
end type
type st_day3 from statictext within u_date_lists
end type
type st_day2 from statictext within u_date_lists
end type
type st_day1 from statictext within u_date_lists
end type
type st_date7 from statictext within u_date_lists
end type
type st_date6 from statictext within u_date_lists
end type
type st_date5 from statictext within u_date_lists
end type
type st_date3 from statictext within u_date_lists
end type
type st_date2 from statictext within u_date_lists
end type
type st_date1 from statictext within u_date_lists
end type
type st_date4 from statictext within u_date_lists
end type
end forward

global type u_date_lists from UserObject
int Width=2734
int Height=217
long BackColor=12632256
event ue_initialize pbm_custom01
st_indicate7 st_indicate7
st_indicate6 st_indicate6
st_indicate5 st_indicate5
st_indicate4 st_indicate4
st_indicate3 st_indicate3
st_indicate2 st_indicate2
st_indicate1 st_indicate1
st_day7 st_day7
st_day6 st_day6
st_day5 st_day5
st_day4 st_day4
st_day3 st_day3
st_day2 st_day2
st_day1 st_day1
st_date7 st_date7
st_date6 st_date6
st_date5 st_date5
st_date3 st_date3
st_date2 st_date2
st_date1 st_date1
st_date4 st_date4
end type
global u_date_lists u_date_lists

type variables
date	id_start_date

integer	ii_mode, &
	ii_count

string	is_copy_from, &
	is_copy_to

statictext	ist_day_list[], &
	ist_date_list[], &
	ist_indicate_list[]
end variables

forward prototypes
public subroutine uf_draw_dates (date as_start_date)
public subroutine uf_initialize ()
public subroutine uf_set_indicator (integer ai_ptr)
end prototypes

on ue_initialize;this.uf_initialize()
end on

public subroutine uf_draw_dates (date as_start_date);/*
Description	:	To display day and date list.
Author		:	Jim Wu
Start Date	:	03/22/96
Modification:
*/


/* Declaration */
integer	li_ptr

date		ld_date

/* Initialization */
ld_date	= as_start_date

/* Main Process */
for li_ptr = 1 to ii_count 
	ist_day_list[ li_ptr ].text	= LeftA( string( dayname(ld_date) ), 3)
	ist_date_list[ li_ptr ].text	= string( ld_date )
	ld_date	= relativedate( ld_date, ii_mode )
next
end subroutine

public subroutine uf_initialize ();ii_count				= 7

ist_day_list[ 1 ]	= st_day1
ist_day_list[ 2 ]	= st_day2
ist_day_list[ 3 ]	= st_day3
ist_day_list[ 4 ]	= st_day4
ist_day_list[ 5 ]	= st_day5
ist_day_list[ 6 ]	= st_day6
ist_day_list[ 7 ]	= st_day7

ist_date_list[ 1 ]	= st_date1
ist_date_list[ 2 ]	= st_date2
ist_date_list[ 3 ]	= st_date3
ist_date_list[ 4 ]	= st_date4
ist_date_list[ 5 ]	= st_date5
ist_date_list[ 6 ]	= st_date6
ist_date_list[ 7 ]	= st_date7

ist_indicate_list[ 1 ]	= st_indicate1
ist_indicate_list[ 2 ]	= st_indicate2
ist_indicate_list[ 3 ]	= st_indicate3
ist_indicate_list[ 4 ]	= st_indicate4
ist_indicate_list[ 5 ]	= st_indicate5
ist_indicate_list[ 6 ]	= st_indicate6
ist_indicate_list[ 7 ]	= st_indicate7

is_copy_from	= '3'
is_copy_to		= '4'








end subroutine

public subroutine uf_set_indicator (integer ai_ptr);/*
Description	:	To set up the indicator
Author		:	Jim Wu
Start Date	:	03/29/96
Modification:
*/


/* Declaration */
integer	ii_ptr

/* Initialization */


/* Main Process */
if not ist_indicate_list[ ai_ptr ].visible then
	ist_indicate_list[ ai_ptr ].visible	= TRUE
	ist_indicate_list[ ai_ptr ].text		= is_copy_from
else
	if ist_indicate_list[ ai_ptr ].text = is_copy_from then
		ist_indicate_list[ ai_ptr ].text = is_copy_to
	else
		ist_indicate_list[ ai_ptr ].visible	= FALSE
	end if
end if
	
end subroutine

on u_date_lists.create
this.st_indicate7=create st_indicate7
this.st_indicate6=create st_indicate6
this.st_indicate5=create st_indicate5
this.st_indicate4=create st_indicate4
this.st_indicate3=create st_indicate3
this.st_indicate2=create st_indicate2
this.st_indicate1=create st_indicate1
this.st_day7=create st_day7
this.st_day6=create st_day6
this.st_day5=create st_day5
this.st_day4=create st_day4
this.st_day3=create st_day3
this.st_day2=create st_day2
this.st_day1=create st_day1
this.st_date7=create st_date7
this.st_date6=create st_date6
this.st_date5=create st_date5
this.st_date3=create st_date3
this.st_date2=create st_date2
this.st_date1=create st_date1
this.st_date4=create st_date4
this.Control[]={ this.st_indicate7,&
this.st_indicate6,&
this.st_indicate5,&
this.st_indicate4,&
this.st_indicate3,&
this.st_indicate2,&
this.st_indicate1,&
this.st_day7,&
this.st_day6,&
this.st_day5,&
this.st_day4,&
this.st_day3,&
this.st_day2,&
this.st_day1,&
this.st_date7,&
this.st_date6,&
this.st_date5,&
this.st_date3,&
this.st_date2,&
this.st_date1,&
this.st_date4}
end on

on u_date_lists.destroy
destroy(this.st_indicate7)
destroy(this.st_indicate6)
destroy(this.st_indicate5)
destroy(this.st_indicate4)
destroy(this.st_indicate3)
destroy(this.st_indicate2)
destroy(this.st_indicate1)
destroy(this.st_day7)
destroy(this.st_day6)
destroy(this.st_day5)
destroy(this.st_day4)
destroy(this.st_day3)
destroy(this.st_day2)
destroy(this.st_day1)
destroy(this.st_date7)
destroy(this.st_date6)
destroy(this.st_date5)
destroy(this.st_date3)
destroy(this.st_date2)
destroy(this.st_date1)
destroy(this.st_date4)
end on

on constructor;this.triggerevent( 'ue_initialize' )
end on

type st_indicate7 from statictext within u_date_lists
int X=2579
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate6 from statictext within u_date_lists
int X=2250
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate5 from statictext within u_date_lists
int X=1939
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate4 from statictext within u_date_lists
int X=1628
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate3 from statictext within u_date_lists
int X=1299
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate2 from statictext within u_date_lists
int X=970
int Width=92
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_indicate1 from statictext within u_date_lists
int X=622
int Width=97
int Height=97
boolean Visible=false
boolean Enabled=false
string Text="3"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-14
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

type st_day7 from statictext within u_date_lists
int X=2414
int Y=49
int Width=247
int Height=49
string Text="Sat"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 7 )
end on

type st_day6 from statictext within u_date_lists
int X=2085
int Y=49
int Width=247
int Height=49
string Text="Fri"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 6 )
end on

type st_day5 from statictext within u_date_lists
int X=1756
int Y=49
int Width=247
int Height=49
string Text="Thu"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 5 )
end on

type st_day4 from statictext within u_date_lists
int X=1445
int Y=49
int Width=247
int Height=49
string Text="Wed"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 4 )
end on

type st_day3 from statictext within u_date_lists
int X=1116
int Y=49
int Width=247
int Height=49
string Text="Tue"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 3 )
end on

type st_day2 from statictext within u_date_lists
int X=787
int Y=49
int Width=238
int Height=49
string Text="Mon"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 2 )
end on

type st_day1 from statictext within u_date_lists
int X=458
int Y=49
int Width=238
int Height=49
string Text="Sun"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 1 )
end on

type st_date7 from statictext within u_date_lists
int X=2433
int Y=97
int Width=247
int Height=73
string Text="Date7"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 7 )
end on

type st_date6 from statictext within u_date_lists
int X=2103
int Y=97
int Width=247
int Height=73
string Text="Date6"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 6 )
end on

type st_date5 from statictext within u_date_lists
int X=1774
int Y=97
int Width=247
int Height=73
string Text="Date5"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 5 )
end on

type st_date3 from statictext within u_date_lists
int X=1116
int Y=97
int Width=247
int Height=73
string Text="Date3"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 3 )
end on

type st_date2 from statictext within u_date_lists
int X=787
int Y=97
int Width=247
int Height=73
string Text="Date2"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 2 )
end on

type st_date1 from statictext within u_date_lists
int X=458
int Y=97
int Width=247
int Height=73
string Text="Date1"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 1 )
end on

type st_date4 from statictext within u_date_lists
int X=1445
int Y=97
int Width=247
int Height=73
string Text="Date4"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on doubleclicked;uf_set_indicator( 4 )
end on

