$PBExportHeader$w_customreport_printsetup.srw
forward
global type w_customreport_printsetup from window
end type
type st_where from statictext within w_customreport_printsetup
end type
type st_comment from statictext within w_customreport_printsetup
end type
type st_type from statictext within w_customreport_printsetup
end type
type st_status from statictext within w_customreport_printsetup
end type
type st_7 from statictext within w_customreport_printsetup
end type
type st_6 from statictext within w_customreport_printsetup
end type
type st_5 from statictext within w_customreport_printsetup
end type
type st_4 from statictext within w_customreport_printsetup
end type
type st_3 from statictext within w_customreport_printsetup
end type
type p_5 from picture within w_customreport_printsetup
end type
type p_1 from picture within w_customreport_printsetup
end type
type cbx_collate from checkbox within w_customreport_printsetup
end type
type em_1 from editmask within w_customreport_printsetup
end type
type st_13 from statictext within w_customreport_printsetup
end type
type st_12 from statictext within w_customreport_printsetup
end type
type sle_print_page from singlelineedit within w_customreport_printsetup
end type
type rb_pages from radiobutton within w_customreport_printsetup
end type
type rb_3 from radiobutton within w_customreport_printsetup
end type
type rb_curr_page from radiobutton within w_customreport_printsetup
end type
type rb_all from radiobutton within w_customreport_printsetup
end type
type st_11 from statictext within w_customreport_printsetup
end type
type cb_2 from commandbutton within w_customreport_printsetup
end type
type cb_1 from commandbutton within w_customreport_printsetup
end type
type ddlb_print from dropdownlistbox within w_customreport_printsetup
end type
type st_2 from statictext within w_customreport_printsetup
end type
type gb_page from groupbox within w_customreport_printsetup
end type
type p_2 from picture within w_customreport_printsetup
end type
type p_3 from picture within w_customreport_printsetup
end type
type p_6 from picture within w_customreport_printsetup
end type
type p_4 from picture within w_customreport_printsetup
end type
type ddplb_printer from dropdownpicturelistbox within w_customreport_printsetup
end type
type gb_printer from groupbox within w_customreport_printsetup
end type
type gb_copies from groupbox within w_customreport_printsetup
end type
type structprintparameters from structure within w_customreport_printsetup
end type
end forward

type StructPrintParameters from structure
	string		printer_name
	string		page_range
	integer		print_option
	integer		copies
	boolean		collate
end type

global type w_customreport_printsetup from window
integer x = 832
integer y = 360
integer width = 2222
integer height = 1224
boolean titlebar = true
string title = "Print"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "None!"
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
gb_copies gb_copies
end type
global w_customreport_printsetup w_customreport_printsetup

type prototypes
FUNCTION ulong GetWindowsDirectoryA ( Ref string wdir, ulong buf) LIBRARY "kernel32.dll" alias for "GetWindowsDirectoryA;Ansi"
end prototypes

type variables
long PrintOption
String StringValue[]
String PrintRange
String WindowsDirectory
StructPrintParameters StructPrintParameters
Datawindow PrintDW


end variables

forward prototypes
public function boolean setprinter (string a_s_printer_name)
end prototypes

public function boolean setprinter (string a_s_printer_name);
//	Set printer options and print the datawindow.
PrintSetPrinter(a_s_printer_name)
PrintDW.Object.DataWindow.Print.Collate = StructPrintParameters.Collate
PrintDW.Object.DataWindow.Print.Copies = StructPrintParameters.Copies
PrintDW.Object.DataWindow.Print.Page.Range = StructPrintParameters.page_range
PrintDW.Object.DataWindow.Print.Page.RangeInclude = StructPrintParameters.print_option
PrintDW.describe ("Printer = StructPrintParameters.printer_name")

if	PrintDW.print()  = 1 then
	return true
else
	return false
end if

end function

on w_customreport_printsetup.create
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
this.gb_copies=create gb_copies
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
this.gb_printer,&
this.gb_copies}
end on

on w_customreport_printsetup.destroy
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
destroy(this.gb_copies)
end on

event open;
//	Calling window must pass the form to print.
PrintDW = Message.PowerObjectParm
em_1.text = PrintDW.Object.Datawindow.Print.Copies

end event

type st_where from statictext within w_customreport_printsetup
integer x = 361
integer y = 292
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_comment from statictext within w_customreport_printsetup
integer x = 361
integer y = 356
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_type from statictext within w_customreport_printsetup
integer x = 361
integer y = 232
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_status from statictext within w_customreport_printsetup
integer x = 361
integer y = 156
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_7 from statictext within w_customreport_printsetup
integer x = 87
integer y = 364
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Comment:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_customreport_printsetup
integer x = 91
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Where:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_customreport_printsetup
integer x = 91
integer y = 228
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Type:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_customreport_printsetup
integer x = 91
integer y = 160
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Status:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_customreport_printsetup
integer x = 96
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Name:"
boolean focusrectangle = false
end type

type p_5 from picture within w_customreport_printsetup
event constructor pbm_constructor
integer x = 1637
integer y = 724
integer width = 101
integer height = 104
string picturename = "page2.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_customreport_printsetup
integer x = 1367
integer y = 768
integer width = 101
integer height = 104
string picturename = "page1.bmp"
boolean focusrectangle = false
end type

type cbx_collate from checkbox within w_customreport_printsetup
integer x = 1883
integer y = 740
integer width = 256
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Colla&te"
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

type em_1 from editmask within w_customreport_printsetup
integer x = 1783
integer y = 564
integer width = 343
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
integer accelerator = 99
borderstyle borderstyle = stylelowered!
string mask = "#####"
boolean spin = true
string displaydata = "Ä"
double increment = 1
string minmax = "1~~"
end type

event constructor;em_1.text = '1'
end event

type st_13 from statictext within w_customreport_printsetup
integer x = 1344
integer y = 564
integer width = 507
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Number of &copies:"
boolean focusrectangle = false
end type

type st_12 from statictext within w_customreport_printsetup
integer x = 87
integer y = 812
integer width = 1111
integer height = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Enter Page Numbers and/or page ranges separated by commas. For Example, 1, 3, 5-12"
boolean focusrectangle = false
end type

type sle_print_page from singlelineedit within w_customreport_printsetup
integer x = 370
integer y = 712
integer width = 709
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;rb_pages.checked = true
end event

type rb_pages from radiobutton within w_customreport_printsetup
integer x = 96
integer y = 704
integer width = 270
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Pa&ges:"
end type

event clicked;
sle_print_page.SetFocus ()
end event

type rb_3 from radiobutton within w_customreport_printsetup
integer x = 571
integer y = 620
integer width = 389
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Selection"
end type

type rb_curr_page from radiobutton within w_customreport_printsetup
integer x = 91
integer y = 620
integer width = 434
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Curr&ent page"
end type

event clicked;
PrintRange = PrintDW.Object.Datawindow.Print.Page.range

end event

type rb_all from radiobutton within w_customreport_printsetup
integer x = 87
integer y = 544
integer width = 247
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "&All"
boolean checked = true
end type

type st_11 from statictext within w_customreport_printsetup
integer x = 50
integer y = 1004
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "   P&rint:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_customreport_printsetup
integer x = 1893
integer y = 992
integer width = 288
integer height = 108
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;
closewithreturn (Parent, 0 )

end event

type cb_1 from commandbutton within w_customreport_printsetup
integer x = 1563
integer y = 992
integer width = 297
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
end type

event clicked;
string  l_s_print_page

Boolean l_b_checked

Integer l_i_page

Long    l_l_pos

StructPrintParameters.printer_name = ddplb_printer.text
StructPrintParameters.print_option	= PrintOption 
StructPrintParameters.copies			= Integer ( em_1.text )
StructPrintParameters.collate		= cbx_collate.checked

IF rb_all.checked THEN
		 StructPrintParameters.page_range = ''
END IF
IF rb_curr_page.checked THEN
		StructPrintParameters.page_range   =  "-1" //?
END IF
IF rb_pages.checked THEN
		StructPrintParameters.page_range   =  sle_print_page.text
END IF

IF NOT SetPrinter ( StructPrintParameters.printer_name ) THEN 

	MessageBox ( monsys.msg_title, "Unable to Print" )
	
ELSE
	Closewithreturn (parent, '1' )
END IF

end event

type ddlb_print from dropdownlistbox within w_customreport_printsetup
integer x = 352
integer y = 1000
integer width = 1138
integer height = 228
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 33554431
string text = "All pages in range"
string item[] = {"All pages in range","Odd pages","Even pages"}
integer accelerator = 114
end type

event selectionchanged;PrintOption = index
end event

type st_2 from statictext within w_customreport_printsetup
integer x = 1783
integer y = 64
integer width = 357
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
string text = "&Properties"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_page from groupbox within w_customreport_printsetup
integer x = 41
integer y = 480
integer width = 1234
integer height = 476
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Page Range"
end type

type p_2 from picture within w_customreport_printsetup
integer x = 1413
integer y = 724
integer width = 101
integer height = 104
string picturename = "page2.bmp"
boolean focusrectangle = false
end type

type p_3 from picture within w_customreport_printsetup
integer x = 1458
integer y = 684
integer width = 101
integer height = 104
string picturename = "page3.bmp"
boolean focusrectangle = false
end type

type p_6 from picture within w_customreport_printsetup
event constructor pbm_constructor
integer x = 1682
integer y = 684
integer width = 101
integer height = 104
string picturename = "page3.bmp"
boolean focusrectangle = false
end type

type p_4 from picture within w_customreport_printsetup
event constructor pbm_constructor
integer x = 1586
integer y = 768
integer width = 101
integer height = 104
boolean bringtotop = true
string picturename = "page1.bmp"
boolean focusrectangle = false
end type

type ddplb_printer from dropdownpicturelistbox within w_customreport_printsetup
integer x = 361
integer y = 56
integer width = 1385
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 33554431
boolean vscrollbar = true
string picturename[] = {"Print!"}
long picturemaskcolor = 553648127
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
WindowsDirectory = space (144)

GetWindowsDirectoryA(WindowsDirectory,l_buf)

//

RegistryKeys ( "HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS", StringValue ) 
	
FOR l_l_count = 1  TO UPPERBOUND ( StringValue )
	
	ddplb_printer.AddItem ( StringValue [ l_l_count ], 1 )

NEXT

l_s_registry =  ProfileString ( WindowsDirectory + "\win.ini", "Windows", "Device", "None" )

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

type gb_printer from groupbox within w_customreport_printsetup
integer x = 41
integer y = 12
integer width = 2139
integer height = 444
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Printer"
end type

type gb_copies from groupbox within w_customreport_printsetup
integer x = 1303
integer y = 480
integer width = 878
integer height = 476
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
string text = "Copies"
end type

