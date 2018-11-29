$PBExportHeader$w_print_setup.srw
forward
global type w_print_setup from window
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
type str_print_parameters from structure within w_print_setup
end type
end forward

type str_print_parameters from structure
	string		printer_name
	string		page_range
	integer		print_option
	integer		copies
	boolean		collate
end type

global type w_print_setup from window
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
private Str_print_parameters i_str_print_parameters
Datawindow      i_s_dw

n_cst_printer _printer

end variables

forward prototypes
public function integer setprintervalues (string printername)
public function integer doprinting (string printername)
end prototypes

public function integer setprintervalues (string printername);
string	registeryKey
registeryKey = "HKEY_LOCAL_MACHINE\SYSTEM\CURRENTCONTROLSET\CONTROL\PRINT\PRINTERS\" + printerName

string printerValues[4]
RegistryGet(registeryKey, "Name", printerValues[1])
RegistryGet(registeryKey, "Port", printerValues[2])
RegistryGet(registeryKey, "Printer Driver", printerValues[3])
RegistryGet(registeryKey, "Description", printerValues[4])
st_status.text = 'Idle'
st_type.text = printerValues[1]
st_where.text = printerValues[2]

return 1

end function

public function integer doprinting (string printername);
//	Store default printer.
_printer.of_StoreDefault()

//	Change printer to the one selected.
_printer.of_SetPrinter(printerName)

i_s_dw.Object.DataWindow.Print.Collate = i_str_print_parameters.Collate
i_s_dw.Object.DataWindow.Print.Copies  = i_str_print_parameters.Copies
i_s_dw.Object.DataWindow.Print.Page.Range	= i_str_print_parameters.page_range
i_s_dw.Object.DataWindow.Print.Page.RangeInclude = i_str_print_parameters.print_option

if	i_s_dw.print(true)  = 1 then
	_printer.of_RestoreDefault()
	return 1
end if
//long	printerHandle
//printerHandle = PrintOpen()
//if	PrintDataWindow(printerHandle, i_s_dw) = 1 then
//	PrintClose(printerHandle)
//	
//	_printer.of_RestoreDefault()
//	return 1
//end if
//
//PrintClose(printerHandle)

_printer.of_RestoreDefault()
return -1



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

event close;
//	Done with printer service.
f_setprinter(_printer, false)

end event

event open;
//	Read messages.
i_s_dw = Message.PowerObjectParm
em_1.text = i_s_dw.Object.Datawindow.Print.Copies

end event

type st_where from statictext within w_print_setup
integer x = 361
integer y = 292
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_comment from statictext within w_print_setup
integer x = 361
integer y = 356
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_type from statictext within w_print_setup
integer x = 361
integer y = 232
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_status from statictext within w_print_setup
integer x = 361
integer y = 156
integer width = 1358
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_7 from statictext within w_print_setup
integer x = 87
integer y = 364
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Comment:"
boolean focusrectangle = false
end type

type st_6 from statictext within w_print_setup
integer x = 91
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Where:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_print_setup
integer x = 91
integer y = 228
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Type:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_print_setup
integer x = 91
integer y = 160
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Status:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_print_setup
integer x = 96
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Name:"
boolean focusrectangle = false
end type

type p_5 from picture within w_print_setup
event constructor pbm_constructor
integer x = 1637
integer y = 724
integer width = 101
integer height = 104
string picturename = "page2.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within w_print_setup
integer x = 1367
integer y = 768
integer width = 101
integer height = 104
string picturename = "page1.bmp"
boolean focusrectangle = false
end type

type r_8 from rectangle within w_print_setup
long linecolor = 8421504
integer linethickness = 4
long fillcolor = 79741120
integer x = 1289
integer y = 508
integer width = 887
integer height = 448
end type

type r_9 from rectangle within w_print_setup
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 79741120
integer x = 1294
integer y = 512
integer width = 878
integer height = 440
end type

type st_1 from statictext within w_print_setup
integer x = 1358
integer y = 484
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Copies"
boolean focusrectangle = false
end type

type cbx_collate from checkbox within w_print_setup
integer x = 1883
integer y = 740
integer width = 256
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type em_1 from editmask within w_print_setup
integer x = 1783
integer y = 564
integer width = 343
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type st_13 from statictext within w_print_setup
integer x = 1344
integer y = 564
integer width = 507
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Number of &copies:"
boolean focusrectangle = false
end type

type st_12 from statictext within w_print_setup
integer x = 87
integer y = 812
integer width = 1111
integer height = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Enter Page Numbers and/or page ranges separated by commas. For Example, 1, 3, 5-12"
boolean focusrectangle = false
end type

type sle_print_page from singlelineedit within w_print_setup
integer x = 370
integer y = 712
integer width = 709
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_pages from radiobutton within w_print_setup
integer x = 87
integer y = 704
integer width = 270
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Pa&ges:"
end type

event clicked;sle_print_page.SetFocus ()
end event

type rb_3 from radiobutton within w_print_setup
integer x = 571
integer y = 624
integer width = 389
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Selection"
end type

type rb_curr_page from radiobutton within w_print_setup
integer x = 87
integer y = 624
integer width = 434
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Curr&ent page"
end type

event clicked;i_s_print_range = i_s_dw.Object.Datawindow.Print.Page.range
end event

type rb_all from radiobutton within w_print_setup
integer x = 87
integer y = 544
integer width = 247
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "&All"
boolean checked = true
end type

type st_11 from statictext within w_print_setup
integer x = 50
integer y = 1004
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "   P&rint:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_print_setup
integer x = 1893
integer y = 992
integer width = 288
integer height = 108
integer taborder = 130
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;closewithreturn ( w_print_Setup, 0 )
end event

type cb_1 from commandbutton within w_print_setup
integer x = 1563
integer y = 992
integer width = 297
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;
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

if	DoPrinting(i_str_print_parameters.printer_name) <> 1 then

	MessageBox ( monsys.msg_title, "Unable to Print" )
else	
	Closewithreturn (parent, '1' )
end if

end event

type ddlb_print from dropdownlistbox within w_print_setup
integer x = 352
integer y = 1000
integer width = 1138
integer height = 228
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "All pages in range"
boolean vscrollbar = true
string item[] = {"All pages in range","Odd pages","Even pages"}
integer accelerator = 114
end type

event selectionchanged;i_l_print_option = index
end event

type st_2 from statictext within w_print_setup
integer x = 1783
integer y = 64
integer width = 357
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "&Properties"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type gb_page from groupbox within w_print_setup
integer x = 41
integer y = 480
integer width = 1234
integer height = 476
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Page Range"
end type

type p_2 from picture within w_print_setup
integer x = 1413
integer y = 724
integer width = 101
integer height = 104
string picturename = "page2.bmp"
boolean focusrectangle = false
end type

type p_3 from picture within w_print_setup
integer x = 1458
integer y = 684
integer width = 101
integer height = 104
string picturename = "page3.bmp"
boolean focusrectangle = false
end type

type p_6 from picture within w_print_setup
event constructor pbm_constructor
integer x = 1682
integer y = 684
integer width = 101
integer height = 104
string picturename = "page3.bmp"
boolean focusrectangle = false
end type

type p_4 from picture within w_print_setup
event constructor pbm_constructor
integer x = 1586
integer y = 768
integer width = 101
integer height = 104
boolean bringtotop = true
string picturename = "page1.bmp"
boolean focusrectangle = false
end type

type ddplb_printer from dropdownpicturelistbox within w_print_setup
integer x = 361
integer y = 56
integer width = 1385
integer height = 320
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
string picturename[] = {"Print!"}
long picturemaskcolor = 553648127
end type

event constructor;

//	Get a printer service.
if	f_setprinter(_printer, true) <> 1 then
	//	Error
	MessageBox(gnv_App.iapp_Object.DisplayName, "Error retrieving printer list.")
	close(parent)
	return
end if

string	printerList[]
_printer.of_getprinters(printerList)
	
int i
for	i = 1 to UpperBound(printerList)
	AddItem(printerList[i])
next

//	Get and display current printer.
string currentPrinter
_printer.GetCurrentPrinter(ref currentPrinter)
for i = 1 to UpperBound(printerList)
	if	left(currentPrinter, len(printerList[i]) + 1) = printerList[i] + "," then
		currentPrinter = printerList[i]
		exit
	end if
next
Text = currentPrinter

SetPrinterValues(currentPrinter)

end event

event selectionchanged;
SetPrinterValues(Text(index))

end event

type gb_printer from groupbox within w_print_setup
integer x = 41
integer y = 12
integer width = 2139
integer height = 444
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Printer"
end type

