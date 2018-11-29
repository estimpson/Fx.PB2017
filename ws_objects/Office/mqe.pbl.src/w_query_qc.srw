$PBExportHeader$w_query_qc.srw
forward
global type w_query_qc from Window
end type
type lb_status from listbox within w_query_qc
end type
type mle_1 from multilineedit within w_query_qc
end type
type st_4 from statictext within w_query_qc
end type
type sle_2 from singlelineedit within w_query_qc
end type
type sle_1 from singlelineedit within w_query_qc
end type
type st_3 from statictext within w_query_qc
end type
type cb_2 from commandbutton within w_query_qc
end type
type cb_1 from commandbutton within w_query_qc
end type
type gb_3 from groupbox within w_query_qc
end type
type gb_2 from groupbox within w_query_qc
end type
type gb_1 from groupbox within w_query_qc
end type
end forward

type qc_structure from structure
    long lRowNumber
    string szOldStatus
end type

global type w_query_qc from Window
int X=1161
int Y=472
int Width=1326
int Height=1452
boolean TitleBar=true
string Title="Quality Control"
long BackColor=79741120
WindowType WindowType=popup!
lb_status lb_status
mle_1 mle_1
st_4 st_4
sle_2 sle_2
sle_1 sle_1
st_3 st_3
cb_2 cb_2
cb_1 cb_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_query_qc w_query_qc

type variables
Long lCount
String	ic_MandatoryNotes
String cStatus
String szOperator
String szOldStatus
String	ic_DeleteScrapped
DataWindow dwName

end variables

forward prototypes
public function boolean create_audit_trail (decimal ld_onhand)
public subroutine wf_build_status_list ()
end prototypes

public function boolean create_audit_trail (decimal ld_onhand);//  Declare Variables

String   szPart
String   szLot
String   szLocation
String   szUnit
String   szNewStatus
String   szPoNumber
String	ls_Plant
String	ls_PackageType

Long     lSerial
Long     lParentSerial

Dec      dQuantity
Dec      dCost
Dec      dWeight
Dec      dOnHand
Dec      dStdQty

Date     dLastDate
Time     tLastTime
DateTime dtTimeStamp

//  Prime variables with values from object

lSerial     = dwName.GetItemNumber ( lCount, "serial" )
szPart      = dwName.GetItemString ( lCount, "part" )
szLot       = dwName.GetItemString ( lCount, "lot" )
szLocation  = dwName.GetItemString ( lCount, "location" )
dQuantity   = dwName.GetItemNumber ( lCount, "quantity" )
szUnit      = dwName.GetItemString ( lCount, "unit_measure" )
dLastDate   = Today ( )  
tLastTime   = Now ( )    
dCost       = dwName.GetItemNumber ( lCount, "cost" )
dWeight     = dwName.GetItemNumber ( lCount, "weight" )
szPoNumber  = dwName.GetItemString ( lCount, "po_number" )

dStdQty = f_convert_units ( szUnit, "", szPart, dQuantity )

SELECT object.package_type,   
       object.plant  
  INTO :ls_PackageType,   
       :ls_Plant  
  FROM object  
 WHERE object.serial = :lSerial   ;

dtTimeStamp = DateTime ( dLastDate, tLastTime )

//  Create audit trail record

INSERT INTO audit_trail  
		          ( serial,   
        		      date_stamp,   
		            type,   
		            part,   
		            quantity,   
		            remarks,   
		            cost,   
		            salesman,   
		            customer,   
		            vendor,   
		            po_number,   
		            operator,   
		            from_loc,   
       		      to_loc,   
		            on_hand,   
		            lot,   
		            weight,   
		            status,   
		            shipper,   
		            flag,   
		            activity,   
		            unit,   
		            workorder,   
		            std_quantity,
						package_type,
						plant )  
		   VALUES ( :lSerial,   
		            :dtTimeStamp,   
		            'Q',   
		            :szPart,   
		            :dQuantity,   
		            'Quality',   
		            :dCost,   
		            null,   
		            null,   
		            null,   
		            :szPoNumber,   
		            :szOperator,   
		            :szOldStatus,   
		            :cStatus,   
		            :ld_OnHand,   
		            :szLot,   
		            :dWeight,   
		            :cStatus,   
		            null,   
		            null,   
		            null,   
		            :szUnit,   
		            null,   
		            :dStdQty,
						:ls_PackageType,
						:ls_Plant )  ;


If SQLCA.SQLCode <> 0 Then
	Return False
Else
	Return True
End if
end function

public subroutine wf_build_status_list ();string	ls_status

DECLARE user_status CURSOR FOR  
 SELECT user_defined_status.display_name  
   FROM user_defined_status  ;

Open user_status;
Fetch user_status into :ls_Status;
Do While sqlca.sqlcode = 0
	lb_status.AddItem ( ls_Status )
	Fetch user_status into :ls_Status;
Loop
Close user_status;
end subroutine

on open;If dwName.RowCount ( ) < 1 Then
	Close ( This )
	Return
End if

wf_build_status_list ( )

SELECT delete_scrapped_objects,
		 mandatory_qc_notes
  INTO :ic_DeleteScrapped,
		 :ic_MandatoryNotes
  FROM parameters  ;

cStatus = 'A'

end on

on w_query_qc.create
this.lb_status=create lb_status
this.mle_1=create mle_1
this.st_4=create st_4
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_3=create st_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.lb_status,&
this.mle_1,&
this.st_4,&
this.sle_2,&
this.sle_1,&
this.st_3,&
this.cb_2,&
this.cb_1,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_query_qc.destroy
destroy(this.lb_status)
destroy(this.mle_1)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type lb_status from listbox within w_query_qc
int X=78
int Y=100
int Width=1170
int Height=480
int TabOrder=10
boolean VScrollBar=true
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_query_qc
int X=73
int Y=672
int Width=1170
int Height=240
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_query_qc
int X=622
int Y=1040
int Width=183
int Height=64
boolean Enabled=false
string Text="Code:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_2 from singlelineedit within w_query_qc
int X=823
int Y=1024
int Width=421
int Height=96
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_query_qc
int X=384
int Y=1024
int Width=219
int Height=96
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=5
TextCase TextCase=Upper!
long TextColor=8388608
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;String szOperator

SELECT employee.operator_code  
  INTO :szOperator  
  FROM employee  
 WHERE employee.password = :sle_1.Text   ;

If IsNull ( szOperator ) Or szOperator = '' Then
	MessageBox ( "Error", "Invalid Password!", StopSign! )
	Return
End if

sle_2.Text = szOperator

end on

on getfocus;If ic_MandatoryNotes = 'Y' And f_get_string_value ( mle_1.Text ) = "" Then &
	mle_1.SetFocus ( )
end on

type st_3 from statictext within w_query_qc
int X=73
int Y=1040
int Width=311
int Height=64
boolean Enabled=false
string Text="Password:"
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_query_qc
int X=677
int Y=1216
int Width=251
int Height=96
int TabOrder=50
string Text="&Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_query_qc
int X=366
int Y=1216
int Width=256
int Height=96
int TabOrder=40
string Text="&OK"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//  Declare Variables
String	ls_Part
String	ls_Unit
String	lc_MandatoryNotes
string	ls_Status
Dec		ld_Qty
Dec		ld_OnHand
Date 		ld_Today
Time 		lt_Now
Long		ll_RowCount
Long		ll_Serial
String	lc_DeleteScrapped
Int		li_StatusSelected

If f_get_string_value ( ic_MandatoryNotes ) = 'Y' And f_get_string_value ( mle_1.Text ) = "" Then
	MessageBox ( "Error", "You must enter a note to continue!", StopSign! )
	mle_1.SetFocus ( )
	Return
End if

If sle_2.Text = '' Then
	MessageBox ( "Error", "You must enter an operator~rto continue!", StopSign! )
	Return
End if

ls_Status = lb_status.SelectedItem ( )

SELECT user_defined_status.type  
  INTO :cStatus
  FROM user_defined_status  
 WHERE user_defined_status.display_name = :ls_Status   ;

szOperator = sle_2.Text

ll_RowCount = dwName.RowCount ( )

For lCount = ll_RowCount to 1 Step -1

	ld_Today = Today ( )
	lt_Now   = Now ( )

	szOldStatus = dwName.GetItemString ( lCount, "status" )
	dwName.SetItem ( lCount, "status", cStatus )
	dwName.SetItem ( lCount, "operator", szOperator )
	dwName.SetItem ( lCount, "last_date", ld_Today )
	dwName.SetItem ( lCount, "last_time", lt_Now )
	dwName.SetItem ( lCount, "note", mle_1.Text )
	dwName.SetItem ( lCount, "user_defined_status", ls_Status )

	ls_Part 		= dwName.GetItemString ( lCount, "part" )
	ls_Unit 		= dwName.GetItemString ( lCount, "unit_measure" )
	ll_Serial	= dwName.GetItemNumber ( lCount, "serial" )

// 02/18/97, 11:31 am by gph
// is inc. b'use qty is 0 for pallets/RMA  

   If (ls_part<>"PALLET") and (ls_part<>"RMA") Then  

		SELECT object.std_quantity  
		  INTO :ld_Qty  
		  FROM object  
		 WHERE object.serial = :ll_Serial   ;
	
		If dwName.Update ( ) = -1 Then
			RollBack ;
			MessageBox ( "Error", "QC Failed!", StopSign! )
			Return
		Else	
			If szOldStatus = 'A' And cStatus <> 'A' Then
				ld_OnHand = f_update_onhand ( ls_Part, ld_Qty, "-*" )
			Elseif cStatus = 'A' And szOldStatus <> 'A' Then
				ld_OnHand = f_update_onhand ( ls_Part, ld_Qty, "+*" )
			Else
				SELECT part_online.on_hand  
				  INTO :ld_OnHand  
				  FROM part_online  
				 WHERE part_online.part = :ls_Part   ;
			End if
			If ld_OnHand = -1 Then
				RollBack ;
				MessageBox ( "Error", "QC Failed!", StopSign! )
				Return
			Else
				If Not create_audit_trail ( ld_OnHand ) Then
					RollBack ;
					MessageBox ("Error", "QC Failed!", StopSign! )
					Return
				Else
					If lc_DeleteScrapped = 'Y' And cStatus = 'S' Then
						If Not f_create_audit_trail ( ll_Serial, "D", szOperator, String ( ld_OnHand ), "", "", "", "", "", "", "", "No Commit" ) Then
							RollBack ;
							MessageBox ( "Error", "QC Failed!", StopSign! )
							Return
						Else
							dwName.DeleteRow ( lCount )
							
							If dwName.Update ( ) = -1 Then
								RollBack ;
								MessageBox ( "Error", "QC Failed!", StopSign! )
								Return
							End if
						End if
					End if
					Commit ;
				End if
			End if
		End if
   End if  // end of pallet condition 
Next
Close ( Parent )
end on

type gb_3 from groupbox within w_query_qc
int X=37
int Y=944
int Width=1243
int Height=224
string Text="Operator:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_query_qc
int X=37
int Y=608
int Width=1243
int Height=336
string Text="Notes:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_query_qc
int X=37
int Y=16
int Width=1243
int Height=592
string Text="Please Choose Status For All Listed Items:"
BorderStyle BorderStyle=StyleLowered!
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

