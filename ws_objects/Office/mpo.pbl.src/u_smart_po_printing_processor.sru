$PBExportHeader$u_smart_po_printing_processor.sru
forward
global type u_smart_po_printing_processor from userobject
end type
type em_date_from from editmask within u_smart_po_printing_processor
end type
type em_date_to from editmask within u_smart_po_printing_processor
end type
type ddlb_style from dropdownlistbox within u_smart_po_printing_processor
end type
type rb_release from radiobutton within u_smart_po_printing_processor
end type
type rb_date from radiobutton within u_smart_po_printing_processor
end type
type cbx_freeze from checkbox within u_smart_po_printing_processor
end type
type p_to from picture within u_smart_po_printing_processor
end type
type p_from from picture within u_smart_po_printing_processor
end type
type p_1 from picture within u_smart_po_printing_processor
end type
type st_4 from statictext within u_smart_po_printing_processor
end type
type cb_exit from commandbutton within u_smart_po_printing_processor
end type
type cb_print from commandbutton within u_smart_po_printing_processor
end type
type dw_parts from datawindow within u_smart_po_printing_processor
end type
type st_3 from statictext within u_smart_po_printing_processor
end type
type st_2 from statictext within u_smart_po_printing_processor
end type
type cbx_new_releases from checkbox within u_smart_po_printing_processor
end type
type cbx_all_releases from checkbox within u_smart_po_printing_processor
end type
type st_1 from statictext within u_smart_po_printing_processor
end type
type gb_5 from groupbox within u_smart_po_printing_processor
end type
type gb_4 from groupbox within u_smart_po_printing_processor
end type
type gb_3 from groupbox within u_smart_po_printing_processor
end type
type gb_2 from groupbox within u_smart_po_printing_processor
end type
type gb_1 from groupbox within u_smart_po_printing_processor
end type
end forward

global type u_smart_po_printing_processor from userobject
integer width = 1728
integer height = 956
boolean border = true
long backcolor = 78682240
em_date_from em_date_from
em_date_to em_date_to
ddlb_style ddlb_style
rb_release rb_release
rb_date rb_date
cbx_freeze cbx_freeze
p_to p_to
p_from p_from
p_1 p_1
st_4 st_4
cb_exit cb_exit
cb_print cb_print
dw_parts dw_parts
st_3 st_3
st_2 st_2
cbx_new_releases cbx_new_releases
cbx_all_releases cbx_all_releases
st_1 st_1
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global u_smart_po_printing_processor u_smart_po_printing_processor

type variables
Window wHostWindow

Long iPO

String szPart

Date dDate1, dDate2

Datetime  ld_date1
Datetime  ld_date2


end variables

forward prototypes
public function boolean uf_flag_releases (string szpart, date ddate1, date ddate2, long irelease1, long irelease2)
public subroutine uf_initialize_range (date dStartDate, date dEndDate)
public subroutine uf_setup (long icurrentpo, string szcurrentpart, date dstartdate, date denddate)
public function integer uf_validate_range (string szpart, date ddate1, date ddate2, long irelease1, long irelease2)
end prototypes

public function boolean uf_flag_releases (string szpart, date ddate1, date ddate2, long irelease1, long irelease2);Long		l_i_Len1, l_i_Len2, l_i_Count

If cbx_new_releases.checked then		//Only select new releases (Printed = 'N')

	If rb_date.checked then
	  	UPDATE po_detail  
	  	SET selected_for_print = 'Y'  
	  	WHERE ( po_number = :iPO ) AND  
	    	   ( part_number = :szPart ) AND  
	         ( date_due >= :ld_Date1 ) AND  
	         ( date_due <= :ld_Date2 ) AND  
	         ( printed = 'N' )   ;
	Else
	  	UPDATE po_detail  
	  	SET selected_for_print = 'Y'  
	  	WHERE ( po_number = :iPO ) AND  
	    	   ( part_number = :szPart ) AND  
	         ( Release_no >= :iRelease1 ) AND  
	         ( Release_no <= :iRelease2 ) AND  
	         ( printed = 'N' )   ;
	End If

Else											//Print all releases

	If rb_date.checked then
		UPDATE po_detail  
	  	SET selected_for_print = 'Y'  
	  	WHERE ( po_number 	= :iPO ) AND  
	     	   ( part_number 	= :szPart ) AND  
	         ( date_due >= :ld_Date1 ) AND  
	         ( date_due <= :ld_Date2 )  ;
	Else
		UPDATE po_detail  
	  	SET selected_for_print = 'Y'  
	  	WHERE ( po_number 	= :iPO ) AND  
	     	   ( part_number 	= :szPart ) AND  
	       	( release_no	>= :iRelease1 ) AND  
		      ( release_no	<= :iRelease2 );
	End If
End If

If SQLCA.SQLCode = 0 then
	Return TRUE
Else
	Return FALSE
End If

end function

public subroutine uf_initialize_range (date dStartDate, date dEndDate);If rb_date.checked then
	em_date_from.text	= String(dStartDate)
	em_date_to.text	= String(dEndDate)
Else
	em_date_from.text	= ''
	em_date_to.text	= ''
End If
end subroutine

public subroutine uf_setup (long icurrentpo, string szcurrentpart, date dstartdate, date denddate);wHostWindow.TriggerEvent("setup_parts_for_print")

dDate1	= dStartDate
dDate2	= dEndDate

uf_initialize_range(dStartDate, dEndDate)

cbx_all_releases.checked	= TRUE
cbx_new_releases.checked	= FALSE

ddlb_style.text				= "Normal PO"

dw_parts.SetTabOrder(1, 0)
dw_parts.SetTabOrder(2, 0)
dw_parts.SetTabOrder(3, 0)
dw_parts.SetTabOrder(4, 0)
dw_parts.SetTabOrder(5, 0)

iPO		= iCurrentPO
szPart	= szCurrentPart

Update po_detail  
Set 	 selected_for_print = 'N'  
Where  po_number = :iPO;

If SQLCA.SQLCode = 0 then
	Commit;
Else
	MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
	Rollback;
	wHostWindow.TriggerEvent("close_uo_for_print")
End If




end subroutine

public function integer uf_validate_range (string szpart, date ddate1, date ddate2, long irelease1, long irelease2);Long	l_i_Len1, l_i_Len2, l_i_Count

Int   li_Dummy

If cbx_new_releases.checked Then		//Only select new releases (Printed = 'N')

	If rb_date.checked Then
	  SELECT count(po_number)
		 INTO :li_Dummy
	  	 FROM po_detail  
	  	WHERE ( po_number = :iPO ) AND  
	    	   ( part_number = :szPart ) AND  
	         ( date_due >= :ld_Date1 ) AND  
	         ( date_due <= :ld_Date2 ) AND  
	         ( printed = 'N' ) ;
	Else
	  SELECT count(po_number)
		 INTO :li_Dummy
	  	 FROM po_detail    
	  	WHERE ( po_number = :iPO ) AND  
	    	   ( part_number = :szPart ) AND  
	         ( Release_no >= :iRelease1 ) AND  
	         ( Release_no <= :iRelease2 ) AND  
	         ( printed = 'N' )   ;
	End If

Else											//Print all releases

	If rb_date.checked Then
	  SELECT count(po_number)
		 INTO :li_Dummy
	  	 FROM po_detail  
	  	WHERE ( po_number 	= :iPO ) AND  
	     	   ( part_number 	= :szPart ) AND  
	         ( date_due >= :ld_Date1 ) AND  
	         ( date_due <= :ld_Date2 ) ;
	Else
	  SELECT count(po_number)
		 INTO :li_Dummy
	  	 FROM po_detail    
	  	WHERE ( po_number 	= :iPO ) AND  
	     	   ( part_number 	= :szPart ) AND  
	       	( release_no	>= :iRelease1 ) AND  
		      ( release_no	<= :iRelease2 );
	End If
End If

Return li_dummy 
end function

on constructor;wHostWindow	= Parent
end on

on u_smart_po_printing_processor.create
this.em_date_from=create em_date_from
this.em_date_to=create em_date_to
this.ddlb_style=create ddlb_style
this.rb_release=create rb_release
this.rb_date=create rb_date
this.cbx_freeze=create cbx_freeze
this.p_to=create p_to
this.p_from=create p_from
this.p_1=create p_1
this.st_4=create st_4
this.cb_exit=create cb_exit
this.cb_print=create cb_print
this.dw_parts=create dw_parts
this.st_3=create st_3
this.st_2=create st_2
this.cbx_new_releases=create cbx_new_releases
this.cbx_all_releases=create cbx_all_releases
this.st_1=create st_1
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_date_from,&
this.em_date_to,&
this.ddlb_style,&
this.rb_release,&
this.rb_date,&
this.cbx_freeze,&
this.p_to,&
this.p_from,&
this.p_1,&
this.st_4,&
this.cb_exit,&
this.cb_print,&
this.dw_parts,&
this.st_3,&
this.st_2,&
this.cbx_new_releases,&
this.cbx_all_releases,&
this.st_1,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on u_smart_po_printing_processor.destroy
destroy(this.em_date_from)
destroy(this.em_date_to)
destroy(this.ddlb_style)
destroy(this.rb_release)
destroy(this.rb_date)
destroy(this.cbx_freeze)
destroy(this.p_to)
destroy(this.p_from)
destroy(this.p_1)
destroy(this.st_4)
destroy(this.cb_exit)
destroy(this.cb_print)
destroy(this.dw_parts)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cbx_new_releases)
destroy(this.cbx_all_releases)
destroy(this.st_1)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type em_date_from from editmask within u_smart_po_printing_processor
integer x = 768
integer y = 224
integer width = 274
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
end type

type em_date_to from editmask within u_smart_po_printing_processor
integer x = 768
integer y = 304
integer width = 274
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
end type

type ddlb_style from dropdownlistbox within u_smart_po_printing_processor
integer x = 640
integer y = 776
integer width = 512
integer height = 352
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Release","Normal PO","Blanket PO","Requisition Form"}
borderstyle borderstyle = stylelowered!
end type

type rb_release from radiobutton within u_smart_po_printing_processor
integer x = 910
integer y = 160
integer width = 265
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Release"
end type

event clicked;rb_date.checked	= Not this.checked
em_date_from.SetMask ( StringMask!, 'xxxxxxxxxx' )
em_date_to.SetMask ( StringMask!, 'xxxxxxxxxx' )
uf_initialize_range(dDate1, dDate2)
end event

type rb_date from radiobutton within u_smart_po_printing_processor
integer x = 622
integer y = 160
integer width = 210
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Date"
boolean checked = true
end type

event clicked;rb_release.checked	= Not this.checked
em_date_from.SetMask ( DateMask!, 'mm/dd/yy' )
em_date_to.SetMask ( DateMask!, 'mm/dd/yy' )

uf_initialize_range(dDate1, dDate2)
end event

type cbx_freeze from checkbox within u_smart_po_printing_processor
integer x = 640
integer y = 592
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Freeze Release #"
end type

type p_to from picture within u_smart_po_printing_processor
integer x = 1079
integer y = 304
integer width = 73
integer height = 64
string picturename = "pick.bmp"
boolean focusrectangle = false
end type

type p_from from picture within u_smart_po_printing_processor
integer x = 1079
integer y = 224
integer width = 73
integer height = 64
string picturename = "pick.bmp"
boolean focusrectangle = false
end type

type p_1 from picture within u_smart_po_printing_processor
integer width = 101
integer height = 84
string picturename = "logo2.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within u_smart_po_printing_processor
integer x = 201
integer y = 160
integer width = 370
integer height = 48
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Select: Dbl Click"
boolean focusrectangle = false
end type

type cb_exit from commandbutton within u_smart_po_printing_processor
integer x = 1317
integer y = 592
integer width = 247
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit"
end type

on clicked;wHostWindow.TriggerEvent("close_uo_for_print")
end on

type cb_print from commandbutton within u_smart_po_printing_processor
integer x = 1317
integer y = 368
integer width = 247
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
end type

event clicked;Date 		l_d_Date1, l_d_Date2

String	szRelease1, szRelease2, ls_type	

Boolean bOK		= True
Boolean bSelected

Integer iRow
Integer li_ReleaseCount
Integer i_count

time    lt_time

If rb_date.checked then
	l_d_Date1		= relativeDate(date(em_date_from.text), -1 )
	l_d_Date2		= RelativeDate(Date(em_date_to.text), 1 )
	ld_date1			= datetime(l_d_Date1)
	ld_date2 		= datetime(l_d_Date2)
Else
	szRelease1		= em_date_from.text
	szRelease2		= em_date_to.text
End If

iRow				= 1
bSelected		= FALSE

Select count(po_number)
Into   :i_count 
From   po_detail
Where  ( po_number = :iPO ) ; 

// included and condition to enable printing blanket po's without releases - mb 

If i_count = 0  and ddlb_style.text <> 'Blanket PO' Then 
   MessageBox("System Message", "There are no releases in the date range: " + &
						 "(From: " + String( l_d_Date1 ) + " To: " + &
                   String( l_d_Date2 ) + ") you have specified!", StopSign!, OK! )
	Return
End If

Do while bOK AND (iRow <= dw_parts.RowCount())
	If dw_parts.IsSelected(iRow) Then
		szPart	       = dw_parts.GetItemString(iRow, "value1")
		bOK		       = uf_flag_releases( szPart, l_d_Date1, l_d_Date2, Long ( szRelease1 ), Long ( szRelease2 ) )
		bSelected       =  TRUE
		li_ReleaseCount = li_ReleaseCount + uf_validate_range ( szPart, l_d_Date1, l_d_Date2, Long ( szRelease1 ), Long ( szRelease2 ) ) 
	End If

	iRow ++
Loop

IF Not bselected THEN
	MessageBox(monsys.msg_title, "No parts selected for printing.", StopSign!)
	RETURN
END IF

// included and condition to enable printing blanket po's without releases - mb 

If li_ReleaseCount = 0 and ddlb_style.text <> 'Blanket PO' Then
	If rb_Date.checked Then
		MessageBox ( "monsys.msg_title", "All the releases in the date range: " + &
						 "(From: " + String( l_d_Date1 ) + " To: " + &
                   String( l_d_Date2 ) + ") have been printed!", StopSign!, OK! )
	Else
		MessageBox ( "monsys.msg_title", "All the releases in the release " + &
						 "range: (From: " + szRelease1 + " To: " + szRelease2 + &
                   ")~r have been printed!.", &
						 StopSign!, OK! )
	End If
	Return
End If

If bSelected then
	If bOK then
		Commit;
		wHostWindow.TriggerEvent("start_to_print_po")
	Else
		MessageBox(monsys.msg_title, SQLCA.SQLErrText, StopSign!)
		Rollback;
		wHostWindow.TriggerEvent("close_uo_for_print")
	End If
End If
end event

type dw_parts from datawindow within u_smart_po_printing_processor
integer x = 55
integer y = 224
integer width = 512
integer height = 672
integer taborder = 60
string dataobject = "dw_external_template"
boolean vscrollbar = true
boolean livescroll = true
end type

on doubleclicked;Long iRow

iRow	= this.GetClickedRow()

If iRow > 0 then
	this.SelectRow(iRow, Not this.IsSelected(iRow))
End If
end on

type st_3 from statictext within u_smart_po_printing_processor
integer x = 640
integer y = 304
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "To"
boolean focusrectangle = false
end type

type st_2 from statictext within u_smart_po_printing_processor
integer x = 640
integer y = 224
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "From"
boolean focusrectangle = false
end type

type cbx_new_releases from checkbox within u_smart_po_printing_processor
integer x = 640
integer y = 528
integer width = 503
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Print New Releases"
end type

on clicked;cbx_all_releases.checked	= Not this.checked
end on

type cbx_all_releases from checkbox within u_smart_po_printing_processor
integer x = 640
integer y = 464
integer width = 507
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Print All Releases    "
end type

on clicked;cbx_new_releases.checked	= Not this.checked
end on

type st_1 from statictext within u_smart_po_printing_processor
integer x = 398
integer y = 20
integer width = 914
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Smart Processor for P.O. Printing"
alignment alignment = center!
long bordercolor = 8421504
boolean focusrectangle = false
end type

type gb_5 from groupbox within u_smart_po_printing_processor
integer x = 585
integer y = 688
integer width = 603
integer height = 224
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Form Style"
end type

type gb_4 from groupbox within u_smart_po_printing_processor
integer x = 1207
integer y = 160
integer width = 475
integer height = 752
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Operation"
end type

type gb_3 from groupbox within u_smart_po_printing_processor
integer x = 585
integer y = 400
integer width = 603
integer height = 288
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Print Selection"
end type

type gb_2 from groupbox within u_smart_po_printing_processor
integer x = 585
integer y = 160
integer width = 603
integer height = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
end type

type gb_1 from groupbox within u_smart_po_printing_processor
integer x = 37
integer y = 160
integer width = 549
integer height = 752
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Parts"
end type

