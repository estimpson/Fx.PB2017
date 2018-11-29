$PBExportHeader$w_edi_overlay_structure_builder.srw
$PBExportComments$Build the EDI overlay structure
forward
global type w_edi_overlay_structure_builder from Window
end type
type mle_help from multilineedit within w_edi_overlay_structure_builder
end type
type dw_temp from datawindow within w_edi_overlay_structure_builder
end type
type dw_edi_overlay_structure from datawindow within w_edi_overlay_structure_builder
end type
type cb_new from commandbutton within w_edi_overlay_structure_builder
end type
type cb_exit from commandbutton within w_edi_overlay_structure_builder
end type
type cb_delete from commandbutton within w_edi_overlay_structure_builder
end type
type cb_save from commandbutton within w_edi_overlay_structure_builder
end type
type st_2 from statictext within w_edi_overlay_structure_builder
end type
type ddlb_data_set from dropdownlistbox within w_edi_overlay_structure_builder
end type
type st_1 from statictext within w_edi_overlay_structure_builder
end type
type ddlb_overlay from dropdownlistbox within w_edi_overlay_structure_builder
end type
type gb_3 from groupbox within w_edi_overlay_structure_builder
end type
type gb_2 from groupbox within w_edi_overlay_structure_builder
end type
type gb_1 from groupbox within w_edi_overlay_structure_builder
end type
end forward

global type w_edi_overlay_structure_builder from Window
int X=1
int Y=1
int Width=2940
int Height=1937
boolean TitleBar=true
string Title="EDI Overlay Structure Builder"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event new_item pbm_custom01
event delete_item pbm_custom02
event save_item pbm_custom03
event exit_item pbm_custom04
mle_help mle_help
dw_temp dw_temp
dw_edi_overlay_structure dw_edi_overlay_structure
cb_new cb_new
cb_exit cb_exit
cb_delete cb_delete
cb_save cb_save
st_2 st_2
ddlb_data_set ddlb_data_set
st_1 st_1
ddlb_overlay ddlb_overlay
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_edi_overlay_structure_builder w_edi_overlay_structure_builder

type variables
Boolean 	bitemchanged = False, &
	ib_badsave = False
end variables

forward prototypes
public subroutine wf_build_overlay_list_box ()
end prototypes

on new_item;If ddlb_overlay.text = "" then
	MessageBox("Warning", "Please select overlay group first", StopSign!)
End If

If ddlb_data_set.text = "" then
	MessageBox("Warning", "Please select data set group first", StopSign!)
End If

dw_edi_overlay_structure.InsertRow(1)
dw_edi_overlay_structure.SetItem(1, "overlay_group", ddlb_overlay.text)
dw_edi_overlay_structure.SetItem(1, "data_set", ddlb_data_set.text)
end on

on delete_item;If MessageBox("Warning", "Sure to delete the current line?" , Question!, YesNo!) = 1 then
	dw_edi_overlay_structure.DeleteRow(0)
	bitemchanged = False
End If
end on

on save_item;Long 	iRow
Long 	iLastLine
Long 	iTotalItems

Boolean bError	= FALSE

Integer iTriggerCount

If dw_edi_overlay_structure.AcceptText( ) <> 1 Then
	ib_badsave = TRUE
	Return
End If

iTriggerCount 	= 0
iLastLine		= 1
iTotalItems		= 0

dw_edi_overlay_structure.SetSort("2a")
dw_edi_overlay_structure.Sort()

For iRow = 1 to dw_edi_overlay_structure.RowCount()
	If dw_edi_overlay_structure.GetItemNumber(iRow, "line") = iLastLine then
		iTotalItems ++
		If iTotalItems > 10 then
			MessageBox("Error", "Total number of items in line " + String(iLastLine) + " exceeds the limit.", StopSign!)
			Exit
		End If
	Else
		iTotalItems = 1
	End If

	dw_edi_overlay_structure.SetRow(iRow)
	dw_edi_overlay_structure.SetColumn("last_line_in_detail_section")
	If dw_edi_overlay_structure.GetText() = "Y" then
		iTriggerCount ++
	End If

Next


If Not bError then

	iRow	= dw_edi_overlay_structure.RowCount()
	If iRow > 0 then
		If dw_edi_overlay_structure.GetItemNumber(iRow, "line") > 75 then
			MessageBox("Error", "The last line number is too big.", StopSign!)
			Return
		End If

		If (iTriggerCount = 0)  then
			MessageBox("Error", "Missing TRIGGER. Every overlay must have at least one 'trigger' line", StopSign!)
			Return
		End If
	End If	
	
	If dw_edi_overlay_structure.Update() > 0 then
		Commit;
		bitemchanged = False
	Else
		Rollback;
	End If

End If
end on

on exit_item;

Integer imess1

If bItemchanged Then
	Imess1 = Messagebox ("Warning", "Do you want to save changes?", &
								Exclamation!, YesNoCancel!,1 )

	If imess1 = 1 Then
		w_edi_overlay_structure_builder. TriggerEvent ( "Save_Item" )
		If ib_badsave Then Return

	Elseif imess1 = 2 Then
		bItemchanged = False

	ELSE
		Return

	End If

End If

close(w_edi_overlay_structure_builder)
end on

public subroutine wf_build_overlay_list_box ();Integer iCount

dw_temp.ImportFile("asnovlgp.txt")
ddlb_overlay.reset()

dw_temp.SetSort("1d")
dw_temp.Sort()

For iCount = 1 to dw_temp.RowCount()
	ddlb_overlay.AddItem(dw_temp.GetItemString(iCount, 1))
Next

If ddlb_overlay.TotalItems() = 0 then
	ddlb_overlay.AddItem("FD5")
	ddlb_overlay.AddItem("CH1")
	ddlb_overlay.AddItem("GMV")
	ddlb_overlay.AddItem("GM9")
	ddlb_overlay.AddItem("JO3")
	ddlb_overlay.AddItem("GN0")
End If	
end subroutine

on activate;gnv_App.of_GetFrame().ChangeMenu(m_edi_overlay)
end on

on open;dw_edi_overlay_structure.SetTransObject(sqlca)
wf_build_overlay_list_box()
end on

on w_edi_overlay_structure_builder.create
this.mle_help=create mle_help
this.dw_temp=create dw_temp
this.dw_edi_overlay_structure=create dw_edi_overlay_structure
this.cb_new=create cb_new
this.cb_exit=create cb_exit
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.st_2=create st_2
this.ddlb_data_set=create ddlb_data_set
this.st_1=create st_1
this.ddlb_overlay=create ddlb_overlay
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.mle_help,&
this.dw_temp,&
this.dw_edi_overlay_structure,&
this.cb_new,&
this.cb_exit,&
this.cb_delete,&
this.cb_save,&
this.st_2,&
this.ddlb_data_set,&
this.st_1,&
this.ddlb_overlay,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_edi_overlay_structure_builder.destroy
destroy(this.mle_help)
destroy(this.dw_temp)
destroy(this.dw_edi_overlay_structure)
destroy(this.cb_new)
destroy(this.cb_exit)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.st_2)
destroy(this.ddlb_data_set)
destroy(this.st_1)
destroy(this.ddlb_overlay)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

on closequery;Int iRtnCode

If bitemchanged = True Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1

			 TriggerEvent( "save_item" )

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

type mle_help from multilineedit within w_edi_overlay_structure_builder
int X=55
int Y=529
int Width=695
int Height=833
int TabOrder=120
boolean Border=false
boolean AutoVScroll=true
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_temp from datawindow within w_edi_overlay_structure_builder
int X=74
int Y=1457
int Width=494
int Height=361
int TabOrder=100
boolean Visible=false
string DataObject="dw_external_asn_dictionary_import"
boolean LiveScroll=true
end type

type dw_edi_overlay_structure from datawindow within w_edi_overlay_structure_builder
int X=823
int Y=97
int Width=1774
int Height=1233
int TabOrder=40
string DataObject="dw_edi_overlay_structure"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemerror;
//dw_edi_overlay_structure.SetText ("")
end on

on editchanged;bitemchanged = True
end on

on rbuttondown;MessageBox("Help", "'Trigger' is used in parsor program. If it is 'Yes', the system will consider it to be the last row for one EDI record", Information!)

end on

on itemchanged;bitemchanged = True
end on

type cb_new from commandbutton within w_edi_overlay_structure_builder
int X=129
int Y=625
int Width=247
int Height=109
int TabOrder=110
boolean Visible=false
string Text="New"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If ddlb_overlay.text = "" then
	MessageBox("Warning", "Please select overlay group first", StopSign!)
End If

If ddlb_data_set.text = "" then
	MessageBox("Warning", "Please select data set group first", StopSign!)
End If

dw_edi_overlay_structure.InsertRow(1)
dw_edi_overlay_structure.SetItem(1, "overlay_group", ddlb_overlay.text)
dw_edi_overlay_structure.SetItem(1, "data_set", ddlb_data_set.text)
end on

type cb_exit from commandbutton within w_edi_overlay_structure_builder
int X=129
int Y=1009
int Width=247
int Height=109
int TabOrder=90
boolean Visible=false
string Text="Exit"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(w_edi_overlay_structure_builder)
end on

type cb_delete from commandbutton within w_edi_overlay_structure_builder
int X=129
int Y=753
int Width=247
int Height=109
int TabOrder=80
boolean Visible=false
string Text="Delete"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If MessageBox("Warning", "Sure to delete the current line?" , Question!, YesNo!) = 1 then
	dw_edi_overlay_structure.DeleteRow(0)
End If
end on

type cb_save from commandbutton within w_edi_overlay_structure_builder
int X=129
int Y=881
int Width=247
int Height=109
int TabOrder=70
boolean Visible=false
string Text="Save"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Long iRow
Integer iTriggerCount

iTriggerCount = 0

For iRow = 1 to dw_edi_overlay_structure.RowCount()
	dw_edi_overlay_structure.SetRow(iRow)
	dw_edi_overlay_structure.SetColumn("last_line_in_detail_section")
	If dw_edi_overlay_structure.GetText() = "Y" then
		iTriggerCount ++
	End If
Next

If (iTriggerCount = 0)  then
	MessageBox("Error", "Missing TRIGGER. Every overlay must have at least one 'trigger' line", StopSign!)
	Return
End If


	
If dw_edi_overlay_structure.Update() > 0 then
	Commit;
	dw_edi_overlay_structure.SetSort("2a")
	dw_edi_overlay_structure.Sort()
Else
	Rollback;
End If
end on

type st_2 from statictext within w_edi_overlay_structure_builder
int X=202
int Y=273
int Width=421
int Height=65
boolean Enabled=false
string Text="Data Set"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_data_set from dropdownlistbox within w_edi_overlay_structure_builder
int X=202
int Y=337
int Width=421
int Height=417
int TabOrder=50
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"830",&
"862"}
end type

on selectionchanged;If ddlb_overlay.text > " " then
	dw_edi_overlay_structure.Retrieve(ddlb_overlay.text, this.text)
	dw_edi_overlay_structure.SetSort("2a")
	dw_edi_overlay_structure.Sort()
End If
end on

type st_1 from statictext within w_edi_overlay_structure_builder
int X=202
int Y=81
int Width=421
int Height=65
boolean Enabled=false
string Text="Overlay"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_overlay from dropdownlistbox within w_edi_overlay_structure_builder
int X=202
int Y=145
int Width=421
int Height=417
int TabOrder=30
boolean VScrollBar=true
long BackColor=12632256
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"CH1",&
"FD5",&
"GM9",&
"JO3"}
end type

on selectionchanged;If ddlb_data_set.text > " " then
	dw_edi_overlay_structure.Retrieve(this.text, ddlb_data_set.text)
	dw_edi_overlay_structure.SetSort("2a")
	dw_edi_overlay_structure.Sort()
End If
end on

type gb_3 from groupbox within w_edi_overlay_structure_builder
int X=19
int Y=465
int Width=769
int Height=913
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_edi_overlay_structure_builder
int X=19
int Y=33
int Width=769
int Height=449
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_edi_overlay_structure_builder
int X=787
int Y=33
int Width=1847
int Height=1345
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

