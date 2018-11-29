$PBExportHeader$w_asn_version2.srw
forward
global type w_asn_version2 from Window
end type
type dw_returnable from datawindow within w_asn_version2
end type
type cb_7 from commandbutton within w_asn_version2
end type
type cb_6 from commandbutton within w_asn_version2
end type
type cb_rc_print from commandbutton within w_asn_version2
end type
type cb_print_detail from commandbutton within w_asn_version2
end type
type cb_4 from commandbutton within w_asn_version2
end type
type mle_warning from multilineedit within w_asn_version2
end type
type dw_temp from datawindow within w_asn_version2
end type
type cb_delete_detail from commandbutton within w_asn_version2
end type
type cb_add_detail from commandbutton within w_asn_version2
end type
type cb_delete_header from commandbutton within w_asn_version2
end type
type cb_add_header from commandbutton within w_asn_version2
end type
type dw_asn_overlay_detail from datawindow within w_asn_version2
end type
type dw_asn_overlay_header from datawindow within w_asn_version2
end type
type st_25 from statictext within w_asn_version2
end type
type dw_asn from datawindow within w_asn_version2
end type
type ddlb_1 from dropdownlistbox within w_asn_version2
end type
type sle_dtl_len13 from singlelineedit within w_asn_version2
end type
type sle_dtl_ln13 from singlelineedit within w_asn_version2
end type
type sle_dtl_len12 from singlelineedit within w_asn_version2
end type
type sle_dtl_pos12 from singlelineedit within w_asn_version2
end type
type gb_3 from groupbox within w_asn_version2
end type
type gb_2 from groupbox within w_asn_version2
end type
type gb_1 from groupbox within w_asn_version2
end type
end forward

type ASN_Structure from structure
    statictext field_name
    singlelineedit line
    singlelineedit position
    singlelineedit length
end type

global type w_asn_version2 from Window
int X=1
int Y=1
int Width=2917
int Height=2193
boolean TitleBar=true
string Title="ASN Structure Builder"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_save pbm_custom01
event ue_test pbm_custom02
dw_returnable dw_returnable
cb_7 cb_7
cb_6 cb_6
cb_rc_print cb_rc_print
cb_print_detail cb_print_detail
cb_4 cb_4
mle_warning mle_warning
dw_temp dw_temp
cb_delete_detail cb_delete_detail
cb_add_detail cb_add_detail
cb_delete_header cb_delete_header
cb_add_header cb_add_header
dw_asn_overlay_detail dw_asn_overlay_detail
dw_asn_overlay_header dw_asn_overlay_header
st_25 st_25
dw_asn dw_asn
ddlb_1 ddlb_1
sle_dtl_len13 sle_dtl_len13
sle_dtl_ln13 sle_dtl_ln13
sle_dtl_len12 sle_dtl_len12
sle_dtl_pos12 sle_dtl_pos12
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_asn_version2 w_asn_version2

type variables
ASN_structure Header[]        //Header Section
ASN_structure Detail[]          //Detail Section

Integer iHeaderCol = 34           //Total # of cols in header
Integer iDetailCol   = 15           //Total # of cols in detail

DataWindowChild dwASNColHeader
DataWindowChild dwASNColDetail
DataWindowChild dwASNColRC

Boolean    bitemchanged = False
end variables

forward prototypes
public subroutine wf_create_asn_column_dddw ()
public subroutine wf_create_overlay_group_list_box ()
end prototypes

on ue_save;If ddlb_1.text > " " then

	If (dw_asn_overlay_header.Update() > 0) THEN
		Commit;
		bitemchanged = False
	Else
		Rollback;
      MessageBox ( "Error", "Unable to save infor")
	End If

	If	(dw_asn_overlay_detail.Update() > 0) THEN
		Commit;
		bitemchanged = False
	Else
		Rollback;
	   MessageBox ( "Error", "Unable to save infor")
	End If

   IF	(dw_returnable.Update() >0) then
      Commit;
		bitemchanged = False
	Else
		Rollback;
	   MessageBox ( "Error", "Unable to save infor")
	End If	


Else

	MessageBox("Warning", "Please select overlay group first!", StopSign!)

End If
end on

on ue_test;If bitemchanged = True Then

  w_asn_version2.Triggerevent ( "ue_save" )

End If

szReturnedString= ddlb_1.text

OpenSheetWithParm(w_asn_file_generator, 0, gnv_App.of_GetFrame(), 0, Original!)

end on

public subroutine wf_create_asn_column_dddw ();dwASNColHeader.ImportFile("asnovlhd.txt")
dwASNColHeader.SetSort("1a")
dwASNColHeader.Sort()

dwASNColDetail.ImportFile("asnovldt.txt")
dwASNColDetail.SetSort("1a")
dwASNColDetail.Sort()

dwASNColRC.ImportFile("asnovldt.txt")
dwASNColRC.SetSort("1a")
dwASNColRC.Sort()
end subroutine

public subroutine wf_create_overlay_group_list_box ();Integer iCount

dw_temp.ImportFile("asnovlgp.txt")
ddlb_1.reset()

dw_temp.SetSort("1d")
dw_temp.Sort()

For iCount = 1 to dw_temp.RowCount()
	ddlb_1.AddItem(dw_temp.GetItemString(iCount, 1))
Next

If ddlb_1.TotalItems() = 0 then
	mle_warning.visible	= TRUE
	ddlb_1.AddItem("FD5")
	ddlb_1.AddItem("CH1")
	ddlb_1.AddItem("GMV")
	ddlb_1.AddItem("GM9")
	ddlb_1.AddItem("JO3")
	ddlb_1.AddItem("GN0")
End If	
end subroutine

on open;Long iRtnCode

dw_asn_overlay_header.SetTransObject(sqlca)
dw_asn_overlay_detail.SetTransObject(sqlca)
dw_returnable.SetTransObject(sqlca)

wf_create_overlay_group_list_box()

iRtncode	= dw_asn_overlay_header.dwGetChild("column_name", dwASNColHeader)
iRtnCode	= dw_asn_overlay_detail.dwGetChild("column_name", dwASNColDetail)
iRtnCode	= dw_returnable.dwGetChild("column_name", dwASNColRC)

wf_create_ASN_column_dddw()


end on

on closequery;Int iRtnCode

If bitemchanged = True Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			 TriggerEvent( "ue_save" )

          If bitemchanged = True AND iRtnCode = 1 Then
				  Message.Returnvalue = 1   
	       End If

	  Case 2 

        close ( this )
  
     Case 3

		  Message.Returnvalue = 1       

     End Choose

Else

      close ( this )
     
End If
	
end on

on activate;gnv_App.of_GetFrame().ChangeMenu (m_asn_version2)
end on

on w_asn_version2.create
this.dw_returnable=create dw_returnable
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_rc_print=create cb_rc_print
this.cb_print_detail=create cb_print_detail
this.cb_4=create cb_4
this.mle_warning=create mle_warning
this.dw_temp=create dw_temp
this.cb_delete_detail=create cb_delete_detail
this.cb_add_detail=create cb_add_detail
this.cb_delete_header=create cb_delete_header
this.cb_add_header=create cb_add_header
this.dw_asn_overlay_detail=create dw_asn_overlay_detail
this.dw_asn_overlay_header=create dw_asn_overlay_header
this.st_25=create st_25
this.dw_asn=create dw_asn
this.ddlb_1=create ddlb_1
this.sle_dtl_len13=create sle_dtl_len13
this.sle_dtl_ln13=create sle_dtl_ln13
this.sle_dtl_len12=create sle_dtl_len12
this.sle_dtl_pos12=create sle_dtl_pos12
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.dw_returnable,&
this.cb_7,&
this.cb_6,&
this.cb_rc_print,&
this.cb_print_detail,&
this.cb_4,&
this.mle_warning,&
this.dw_temp,&
this.cb_delete_detail,&
this.cb_add_detail,&
this.cb_delete_header,&
this.cb_add_header,&
this.dw_asn_overlay_detail,&
this.dw_asn_overlay_header,&
this.st_25,&
this.dw_asn,&
this.ddlb_1,&
this.sle_dtl_len13,&
this.sle_dtl_ln13,&
this.sle_dtl_len12,&
this.sle_dtl_pos12,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_asn_version2.destroy
destroy(this.dw_returnable)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_rc_print)
destroy(this.cb_print_detail)
destroy(this.cb_4)
destroy(this.mle_warning)
destroy(this.dw_temp)
destroy(this.cb_delete_detail)
destroy(this.cb_add_detail)
destroy(this.cb_delete_header)
destroy(this.cb_add_header)
destroy(this.dw_asn_overlay_detail)
destroy(this.dw_asn_overlay_header)
destroy(this.st_25)
destroy(this.dw_asn)
destroy(this.ddlb_1)
destroy(this.sle_dtl_len13)
destroy(this.sle_dtl_ln13)
destroy(this.sle_dtl_len12)
destroy(this.sle_dtl_pos12)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_returnable from datawindow within w_asn_version2
int X=499
int Y=1045
int Width=2012
int Height=373
int TabOrder=110
string DataObject="dw_asn_overlay_structure"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemerror;dw_returnable.SetText ("")
dw_returnable.SetFocus()
end on

on editchanged;bitemchanged = True
end on

on itemchanged;bitemchanged = True
end on

type cb_7 from commandbutton within w_asn_version2
int X=2529
int Y=1177
int Width=247
int Height=109
int TabOrder=160
string Text="Add"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_returnable.InsertRow(1)
dw_returnable.SetItem(1, "overlay_group", ddlb_1.text)
dw_returnable.SetItem(1, "section", "C")
end on

type cb_6 from commandbutton within w_asn_version2
int X=2529
int Y=1309
int Width=247
int Height=109
int TabOrder=100
string Text="Delete"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If MessageBox("Delete", "Are you sure about deleting this row?", Question!, YesNo!) = 1 then
	dw_returnable.DeleteRow(0)
	bitemchanged = True
End If
end on

type cb_rc_print from commandbutton within w_asn_version2
int X=2529
int Y=1037
int Width=247
int Height=109
int TabOrder=50
string Text="Print"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_returnable.Print()
end on

type cb_print_detail from commandbutton within w_asn_version2
int X=2524
int Y=541
int Width=247
int Height=109
int TabOrder=40
string Text="Print"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Integer iPrintJob

iPrintJob	= PrintOpen()

PrintDataWindow(iPrintJob, dw_asn_overlay_detail)

MessageBox("Message", "The overlay detail information has been printed!")

PrintClose(iPrintJob)
end on

on rbuttondown;MessageBox("Help", "Print the ASN detail overlay structure", Information!)
end on

type cb_4 from commandbutton within w_asn_version2
int X=2524
int Y=61
int Width=247
int Height=109
int TabOrder=30
string Text="Print"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on rbuttondown;MessageBox("Help", "Print the ASN header overlay structure", Information!)
end on

on clicked;Integer iPrintJob

iPrintJob	= PrintOpen()

PrintDataWindow(iPrintJob, dw_asn_overlay_header)

MessageBox("Message", "The overlay header information has been printed!")

PrintClose(iPrintJob)
end on

type mle_warning from multilineedit within w_asn_version2
int X=55
int Y=225
int Width=421
int Height=337
int TabOrder=20
boolean Visible=false
boolean Border=false
string Text="Warning: Missing ASN Overlay Group Dictionary File (asnovlgp.mon)"
long TextColor=255
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
boolean Italic=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_temp from datawindow within w_asn_version2
int X=74
int Y=1697
int Width=494
int Height=361
int TabOrder=130
boolean Visible=false
string DataObject="dw_external_asn_dictionary_import"
boolean LiveScroll=true
end type

type cb_delete_detail from commandbutton within w_asn_version2
int X=2519
int Y=805
int Width=247
int Height=109
int TabOrder=90
string Text="Delete"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If MessageBox("Delete", "Are you sure about deleting this row?", Question!, YesNo!) = 1 then
	dw_asn_overlay_detail.DeleteRow(0)
	bitemchanged = True
End If
end on

on rbuttondown;MessageBox("Help", "Delete the current row in ASN detail overlay structure", Information!)
end on

type cb_add_detail from commandbutton within w_asn_version2
int X=2519
int Y=669
int Width=247
int Height=109
int TabOrder=70
string Text="Add"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_asn_overlay_detail.InsertRow(1)
dw_asn_overlay_detail.SetItem(1, "overlay_group", ddlb_1.text)
dw_asn_overlay_detail.SetItem(1, "section", "D")
end on

on rbuttondown;MessageBox("Help", "add a new row in ASN detail overlay structure", Information!)
end on

type cb_delete_header from commandbutton within w_asn_version2
int X=2529
int Y=329
int Width=247
int Height=109
int TabOrder=80
string Text="Delete"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If MessageBox("Delete", "Are you sure about deleting this row?", Question!, YesNo!) = 1 then
	dw_asn_overlay_header.DeleteRow(0)
	bitemchanged = True
End If

end on

on rbuttondown;MessageBox("Help", "Delete the current row in ASN header overlay structure", Information!)
end on

type cb_add_header from commandbutton within w_asn_version2
int X=2529
int Y=201
int Width=247
int Height=109
int TabOrder=60
string Text="Add"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_asn_overlay_header.InsertRow(1)
dw_asn_overlay_header.SetItem(1, "overlay_group", ddlb_1.text)
dw_asn_overlay_header.SetItem(1, "section", "H")
end on

on rbuttondown;MessageBox("Help", "Insert a new row in ASN header overlay structure", Information!)
end on

type dw_asn_overlay_detail from datawindow within w_asn_version2
int X=499
int Y=545
int Width=2012
int Height=373
int TabOrder=170
string DataObject="dw_asn_overlay_structure"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemerror;dw_asn_overlay_detail.SetText ("")
dw_asn_overlay_detail.SetFocus ()
end on

on itemchanged;bitemchanged = True
end on

on rbuttondown;MessageBox("Help", "The dropdown datawindow for column name is from ASNOVLDT.TXT", Information!)
end on

on editchanged;bitemchanged = True
end on

type dw_asn_overlay_header from datawindow within w_asn_version2
int X=499
int Y=61
int Width=2017
int Height=385
int TabOrder=140
string DataObject="dw_asn_overlay_structure"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemerror;dw_asn_overlay_header.SetText ( "" )
dw_asn_overlay_header.SetFocus ()
end on

on itemchanged;bitemchanged = True
end on

on rbuttondown;MessageBox("Help", "The dropdown datawindow for column name is from ASNOVLHD.TXT", Information!)

end on

on editchanged;bitemchanged = True
end on

type st_25 from statictext within w_asn_version2
int X=51
int Y=21
int Width=380
int Height=73
boolean Enabled=false
string Text="Overlay Group"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_asn from datawindow within w_asn_version2
end type

type ddlb_1 from dropdownlistbox within w_asn_version2
int X=42
int Y=105
int Width=403
int Height=457
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"FD5",&
"CH1",&
"GMV",&
"GM9",&
"JO3",&
"GN0"}
end type

on selectionchanged;dw_asn_overlay_header.Retrieve(this.text, "H")
dw_asn_overlay_detail.Retrieve(this.text, "D")
dw_returnable.Retrieve(this.text, "C")


end on

on rbuttondown;MessageBox("Help", "This dropdown list shows all available ASN overlay group codes. The list is &
generated from ASNOVLGP.TXT", Information!)

			 
end on

type sle_dtl_len13 from singlelineedit within w_asn_version2
end type

type sle_dtl_ln13 from singlelineedit within w_asn_version2
end type

type sle_dtl_len12 from singlelineedit within w_asn_version2
end type

type sle_dtl_pos12 from singlelineedit within w_asn_version2
end type

type gb_3 from groupbox within w_asn_version2
int X=476
int Y=957
int Width=2323
int Height=481
int TabOrder=120
string Text="Returnable Container"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_asn_version2
int X=476
int Y=481
int Width=2314
int Height=461
int TabOrder=180
string Text="Detail Section"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_asn_version2
int X=476
int Width=2314
int Height=473
int TabOrder=150
string Text="Header Section"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

