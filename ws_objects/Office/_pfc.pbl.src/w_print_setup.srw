$PBExportHeader$w_print_setup.srw
forward
global type w_print_setup from Window
end type
type st_where from statictext within w_print_setup
end type
type st_comment from statictext within w_print_setup
end type
type st_type from statictext within w_print_setup
end type
type st_status from statictext within w_print_setup
end type
type st_7 from statictext within w_print_setup
end type
type st_6 from statictext within w_print_setup
end type
type st_5 from statictext within w_print_setup
end type
type st_4 from statictext within w_print_setup
end type
type st_3 from statictext within w_print_setup
end type
type p_5 from picture within w_print_setup
end type
type p_1 from picture within w_print_setup
end type
type r_8 from rectangle within w_print_setup
end type
type r_9 from rectangle within w_print_setup
end type
type st_1 from statictext within w_print_setup
end type
type cbx_collate from checkbox within w_print_setup
end type
type em_1 from editmask within w_print_setup
end type
type st_13 from statictext within w_print_setup
end type
type st_12 from statictext within w_print_setup
end type
type sle_print_page from singlelineedit within w_print_setup
end type
type rb_pages from radiobutton within w_print_setup
end type
type rb_3 from radiobutton within w_print_setup
end type
type rb_curr_page from radiobutton within w_print_setup
end type
type rb_all from radiobutton within w_print_setup
end type
type st_11 from statictext within w_print_setup
end type
type cb_2 from commandbutton within w_print_setup
end type
type cb_1 from commandbutton within w_print_setup
end type
type ddlb_print from dropdownlistbox within w_print_setup
end type
type st_2 from statictext within w_print_setup
end type
type gb_page from groupbox within w_print_setup
end type
type p_2 from picture within w_print_setup
end type
type p_3 from picture within w_print_setup
end type
type p_6 from picture within w_print_setup
end type
type p_4 from picture within w_print_setup
end type
type ddplb_printer from dropdownpicturelistbox within w_print_setup
end type
type gb_printer from groupbox within w_print_setup
end type
end forward

type str_print_parameters from structure
	string		printer_name
	string		page_range
	integer		print_option
	integer		copies
	boolean		collate
end type

global type w_print_setup from Window
int X=832
int Y=360
int Width=2222
int Height=1224
boolean TitleBar=true
string Title="Print"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="None!"
st_where st_where
st_comment st_comment
st_type st_type
st_status st_status
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
p_5 p_5
p_1 p_1
r_8 r_8
r_9 r_9
st_1 st_1
cbx_collate cbx_collate
em_1 em_1
st_13 st_13
st_12 st_12
sle_print_page sle_print_page
rb_pages rb_pages
rb_3 rb_3
rb_curr_page rb_curr_page
rb_all rb_all
st_11 st_11
cb_2 cb_2
cb_1 cb_1
ddlb_print ddlb_print
st_2 st_2
gb_page gb_page
p_2 p_2
p_3 p_3
p_6 p_6
p_4 p_4
ddplb_printer ddplb_printer
gb_printer gb_printer
end type
global w_print_setup w_print_setup

type prototypes
FUNCTION ulong GetWindowsDirectoryA ( Ref string wdir, ulong buf) LIBRARY "kernel32.dll" alias for "GetWindowsDirectoryA;Ansi"
end prototypes

type variables
Long                 i_l_print_option
String                i_s_value[]
String                i_s_print_range
String                windir
Str_print_parameters i_str_print_parameters
Datawindow      i_s_dw


end variables

forward prototypes
public function boolean wf_change_ini (string a_s_printer_name)
end prototypes

public function boolean wf_change_ini (string a_s_printer_name);String  l_s_value, &
		  l_s_temp

l_s_temp = ProfileString ( windir+'\win.ini', "Devices", a_s_printer_name, "none" )

IF l_s_temp > '' THEN

	IF SetProfileString ( windir+'\win.ini', "Windows", "Device",  a_s_printer_name + ',' + l_s_temp ) = 1 THEN

		i_s_dw.Object.DataWindow.Print.Collate = i_str_print_parameters.Collate
		i_s_dw.Object.DataWindow.Print.Copies  = i_str_print_parameters.Copies
		i_s_dw.Object.DataWindow.Print.Page.Range	= i_str_print_parameters.page_range
		i_s_dw.Object.DataWindow.Print.Page.RangeInclude = i_str_print_parameters.print_option
		i_s_dw.describe ("Printer = i_str_print_parameters.printer_name")

		IF i_s_dw.print()  = 1 THEN
//			w_report_view.i_b_printed = TRUE
			RETURN TRUE
		END IF
	ELSE
		  RETURN FALSE
   END IF

ELSE

	RETURN FALSE

END IF
end function

on w_print_setup.create
this.st_where=create st_where
this.st_comment=create st_comment
this.st_type=create st_type
this.st_status=create st_status
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.p_5=create p_5
this.p_1=create p_1
this.r_8=create r_8
this.r_9=create r_9
this.st_1=create st_1
this.cbx_collate=create cbx_collate
this.em_1=create em_1
this.st_13=create st_13
this.st_12=create st_12
this.sle_print_page=create sle_print_page
this.rb_pages=create rb_pages
this.rb_3=create rb_3
this.rb_curr_page=create rb_curr_page
this.rb_all=create rb_all
this.st_11=create st_11
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_print=create ddlb_print
this.st_2=create st_2
this.gb_page=create gb_page
this.p_2=create p_2
this.p_3=create p_3
this.p_6=create p_6
this.p_4=create p_4
this.ddplb_printer=create ddplb_printer
this.gb_printer=create gb_printer
this.Control[]={this.st_where,&
this.st_comment,&
this.st_type,&
this.st_status,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.p_5,&
this.p_1,&
this.r_8,&
this.r_9,&
this.st_1,&
this.cbx_collate,&
this.em_1,&
this.st_13,&
this.st_12,&
this.sle_print_page,&
this.rb_pages,&
this.rb_3,&
this.rb_curr_page,&
this.rb_all,&
this.st_11,&
this.cb_2,&
this.cb_1,&
this.ddlb_print,&
this.st_2,&
this.gb_page,&
this.p_2,&
this.p_3,&
this.p_6,&
this.p_4,&
this.ddplb_printer,&
this.gb_printer}
end on

on w_print_setup.destroy
destroy(this.st_where)
destroy(this.st_comment)
destroy(this.st_type)
destroy(this.st_status)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.p_5)
destroy(this.p_1)
destroy(this.r_8)
destroy(this.r_9)
destroy(this.st_1)
destroy(this.cbx_collate)
destroy(this.em_1)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.sle_print_page)
destroy(this.rb_pages)
destroy(this.rb_3)
destroy(this.rb_curr_page)
destroy(this.rb_all)
destroy(this.st_11)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_print)
destroy(this.st_2)
destroy(this.gb_page)
destroy(this.p_2)
destroy(this.p_3)
destroy(this.p_6)
destroy(this.p_4)
destroy(this.ddplb_printer)
destroy(this.gb_printer)
end on

event close;//close ( w_print_setup )
end event

event open;String l_s_copies

i_s_dw = Message.PowerObjectParm

l_s_copies = i_s_dw.Object.Datawindow.Print.Copies

em_1.text = l_s_copies








end event

type st_where from statictext within w_print_setup
int X=361
int Y=292
int Width=1358
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_comment from statictext within w_print_setup
int X=361
int Y=356
int Width=1358
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_type from statictext within w_print_setup
int X=361
int Y=232
int Width=1358
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_status from statictext within w_print_setup
int X=361
int Y=156
int Width=1358
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_print_setup
int X=87
int Y=364
int Width=247
int Height=76
boolean Enabled=false
string Text="Comment:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_print_setup
int X=91
int Y=300
int Width=247
int Height=76
boolean Enabled=false
string Text="Where:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_print_setup
int X=91
int Y=228
int Width=247
int Height=76
boolean Enabled=false
string Text="Type:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_print_setup
int X=91
int Y=160
int Width=247
int Height=76
boolean Enabled=false
string Text="Status:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_print_setup
int X=96
int Y=68
int Width=247
int Height=76
boolean Enabled=false
string Text="Name:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_5 from picture within w_print_setup
event constructor pbm_constructor
int X=1637
int Y=724
int Width=101
int Height=104
string PictureName="page2.bmp"
boolean FocusRectangle=false
end type

type p_1 from picture within w_print_setup
int X=1367
int Y=768
int Width=101
int Height=104
string PictureName="page1.bmp"
boolean FocusRectangle=false
end type

type r_8 from rectangle within w_print_setup
int X=1289
int Y=508
int Width=887
int Height=448
boolean Enabled=false
int LineThickness=4
long LineColor=8421504
long FillColor=79741120
end type

type r_9 from rectangle within w_print_setup
int X=1294
int Y=512
int Width=878
int Height=440
boolean Enabled=false
int LineThickness=4
long LineColor=16777215
long FillColor=79741120
end type

type st_1 from statictext within w_print_setup
int X=1358
int Y=484
int Width=174
int Height=76
boolean Enabled=false
string Text="Copies"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_collate from checkbox within w_print_setup
int X=1883
int Y=740
int Width=256
int Height=76
int TabOrder=100
string Text="Colla&te"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;IF NOT checked THEN
	
	p_2.x = p_1.x + 45
	p_2.y = p_1.y - 44
	p_3.x = p_2.x + 45
	p_3.y = p_2.y - 44
	p_4.x = p_1.x + 220
	p_4.y = p_1.y 
	p_4.Bringtotop = False
	p_5.x = p_4.x + 45
	p_5.y = p_4.y - 44
	p_5.Bringtotop = False
	p_6.x = p_5.x + 45
	p_6.y = p_5.y - 44
	p_6.Bringtotop = False
	
ELSE

	p_2.x = p_1.x + 150
	p_2.y = p_1.y 
	p_3.x = p_1.x + 300
	p_3.y = p_1.y 
	p_4.x = p_1.x + 45
	p_4.y = p_1.y - 44
	p_4.Bringtotop = False
	p_5.x = p_4.x + 150
	p_5.y = p_4.y
	p_5.Bringtotop = False
	p_6.x = p_4.x + 300
	p_6.y = p_4.y
	p_6.Bringtotop = False
	
END IF
end event

type em_1 from editmask within w_print_setup
int X=1783
int Y=564
int Width=343
int Height=88
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
boolean Spin=true
string DisplayData="$$HEX1$$c400$$ENDHEX$$"
double Increment=1
string MinMax="1~~"
int Accelerator=99
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;em_1.text = '1'
end event

type st_13 from statictext within w_print_setup
int X=1344
int Y=564
int Width=507
int Height=76
boolean Enabled=false
string Text="Number of &copies:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_print_setup
int X=87
int Y=812
int Width=1111
int Height=120
boolean Enabled=false
string Text="Enter Page Numbers and/or page ranges separated by commas. For Example, 1, 3, 5-12"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_print_page from singlelineedit within w_print_setup
int X=370
int Y=712
int Width=709
int Height=84
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_pages from radiobutton within w_print_setup
int X=96
int Y=704
int Width=270
int Height=76
int TabOrder=70
string Text="Pa&ges:"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;sle_print_page.SetFocus ()
end event

type rb_3 from radiobutton within w_print_setup
int X=571
int Y=620
int Width=389
int Height=76
boolean Enabled=false
string Text="Selection"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_curr_page from radiobutton within w_print_setup
int X=91
int Y=620
int Width=434
int Height=76
int TabOrder=60
string Text="Curr&ent page"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;i_s_print_range = i_s_dw.Object.Datawindow.Print.Page.range
end event

type rb_all from radiobutton within w_print_setup
int X=87
int Y=544
int Width=247
int Height=76
int TabOrder=50
string Text="&All"
boolean Checked=true
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_print_setup
int X=50
int Y=1004
int Width=247
int Height=76
boolean Enabled=false
string Text="   P&rint:"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_print_setup
int X=1893
int Y=992
int Width=288
int Height=108
int TabOrder=130
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn ( w_print_Setup, 0 )
end event

type cb_1 from commandbutton within w_print_setup
int X=1563
int Y=992
int Width=297
int Height=108
int TabOrder=120
string Text="Print"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string  l_s_print_page

Boolean l_b_checked

Integer l_i_page

Long    l_l_pos

i_str_print_parameters.printer_name = ddplb_printer.text
i_str_print_parameters.print_option	= i_l_print_option 
i_str_print_parameters.copies			= Integer ( em_1.text )
i_str_print_parameters.collate		= cbx_collate.checked

IF rb_all.checked THEN
		 i_str_print_parameters.page_range = ''
END IF
IF rb_curr_page.checked THEN
		i_str_print_parameters.page_range   =  i_s_print_range
END IF
IF rb_pages.checked THEN
		i_str_print_parameters.page_range   =  sle_print_page.text
END IF

IF NOT wf_change_ini ( i_str_print_parameters.printer_name ) THEN 

	MessageBox ( monsys.msg_title, "Unable to Print" )
	
ELSE
	
	Closewithreturn ( w_print_setup, '1' )
	
END IF

end event

type ddlb_print from dropdownlistbox within w_print_setup
int X=352
int Y=1000
int Width=1138
int Height=228
int TabOrder=110
string Text="All pages in range"
boolean VScrollBar=true
int Accelerator=114
long BackColor=33554431
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All pages in range",&
"Odd pages",&
"Even pages"}
end type

event selectionchanged;i_l_print_option = index
end event

type st_2 from statictext within w_print_setup
int X=1783
int Y=64
int Width=357
int Height=80
int TabOrder=30
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="&Properties"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_page from groupbox within w_print_setup
int X=41
int Y=480
int Width=1234
int Height=476
int TabOrder=40
string Text="Page Range"
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_2 from picture within w_print_setup
int X=1413
int Y=724
int Width=101
int Height=104
string PictureName="page2.bmp"
boolean FocusRectangle=false
end type

type p_3 from picture within w_print_setup
int X=1458
int Y=684
int Width=101
int Height=104
string PictureName="page3.bmp"
boolean FocusRectangle=false
end type

type p_6 from picture within w_print_setup
event constructor pbm_constructor
int X=1682
int Y=684
int Width=101
int Height=104
string PictureName="page3.bmp"
boolean FocusRectangle=false
end type

type p_4 from picture within w_print_setup
event constructor pbm_constructor
int X=1586
int Y=768
int Width=101
int Height=104
boolean BringToTop=true
string PictureName="page1.bmp"
boolean FocusRectangle=false
end type

type ddplb_printer from dropdownpicturelistbox within w_print_setup
int X=361
int Y=56
int Width=1385
int Height=320
int TabOrder=20
boolean VScrollBar=true
long BackColor=33554431
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string PictureName[]={"Print!"}
long PictureMaskColor=553648127
end type

event constructor;STRING l_s_printer[], &
		 l_s_registry, &
		 l_s_temp, &
		 l_s_entries
		 
LONG	 l_l_count, &
		 l_l_pos, &
		 l_l_Row
		 
// to get windows directory
ulong l_buf

l_buf = 144
windir = space (144)

GetWindowsDirectoryA(windir,l_buf)

//

RegistryKeys ( "HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS", i_s_value ) 
	
FOR l_l_count = 1  TO UPPERBOUND ( i_s_value )
	
	ddplb_printer.AddItem ( i_s_value [ l_l_count ], 1 )

NEXT

l_s_registry =  ProfileString ( windir + "\win.ini", "Windows", "Device", "None" )

IF l_s_registry > '' THEN

	l_l_pos = PosA ( l_s_registry, ',' , 1 )
	l_l_count = 1
	l_s_temp = MidA ( l_s_registry, 1, l_l_pos - 1 )

	ddplb_printer.Text = l_s_temp

	l_s_registry = "HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS\" + l_s_temp
	
	RegistryGet( l_s_registry, "Name", l_s_printer [ 1 ] )
	RegistryGet( l_s_registry, "Port", l_s_printer [ 2 ] )
	RegistryGet( l_s_registry, "Printer Driver", l_s_printer [ 3 ] )
	RegistryGet( l_s_registry, "Description", l_s_printer [ 4 ] )

	st_status.text = 'Idle'
	st_type.text = l_s_printer [ 1 ]
	st_where.text = l_s_printer [ 2 ]

END IF








end event

event selectionchanged;String l_s_registry, &
		 l_s_printer[]
		 
Long   l_l_row

st_status.text = ''
st_type.text = ''
st_where.text = ''

l_s_registry = "HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS\" + this.text ( index ) 

RegistryGet( l_s_registry, "Name", l_s_printer [ 1 ] )
RegistryGet( l_s_registry, "Port", l_s_printer [ 2 ] )
RegistryGet( l_s_registry, "Printer Driver", l_s_printer [ 3 ] )
RegistryGet( l_s_registry, "Description", l_s_printer [ 4 ] )

st_status.text = 'Idle'
st_type.text = l_s_printer [ 1 ]
st_where.text = l_s_printer [ 2 ]





end event

type gb_printer from groupbox within w_print_setup
int X=41
int Y=12
int Width=2139
int Height=444
int TabOrder=10
string Text="Printer"
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

