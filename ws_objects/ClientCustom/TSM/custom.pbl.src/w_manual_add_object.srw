$PBExportHeader$w_manual_add_object.srw
forward
global type w_manual_add_object from window
end type
type lb_1 from listbox within w_manual_add_object
end type
type cb_2 from commandbutton within w_manual_add_object
end type
type cb_1 from commandbutton within w_manual_add_object
end type
type dw_1 from datawindow within w_manual_add_object
end type
end forward

global type w_manual_add_object from window
integer x = 416
integer y = 312
integer width = 2075
integer height = 1288
boolean titlebar = true
string title = "Manually Add Object"
boolean controlmenu = true
long backcolor = 78682240
lb_1 lb_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_manual_add_object w_manual_add_object

type variables
DataWindowChild dwcPackaging
String	szColumnName
Boolean	bMessage
Long		lSerialHold[50]
Int 		iSequence

st_dda_parmlist st_prmlst
String         szdimensionqtystr=''

end variables

forward prototypes
public function boolean wf_adjust_query ()
public subroutine wf_label (st_generic_structure l_st_parm)
end prototypes

public function boolean wf_adjust_query ();Int		iCount,&
			iRtnCode
String	szWhereClause
String	szNewSQL
String	szRtnCode

If iSequence > 1 Then
	szWhereClause = "object.serial >= " + String ( lSerialHold[1] ) + " AND " + "serial <= " + String ( lSerialHold[iSequence] )
Else
	szWhereClause = "object.serial = " + String ( lSerialHold[1] ) 
End if

szNewSQL = w_object_inquiry.i_s_original_syntax + " WHERE " + szWhereClause

iRtnCode = w_object_inquiry.dw_inquiry.SetSQLSelect ( szNewSQL )

If iRtnCode = 1 Then
	w_object_inquiry.dw_inquiry.Retrieve ( )
	Return True
Else
	Return False
End if


end function

public subroutine wf_label (st_generic_structure l_st_parm);LONG	l_l_serial

STRING l_s_label

st_generic_structure l_str_parm

w_report_view  l_w_instance

l_l_serial = Long ( l_str_parm.value1 )

l_str_parm.value11 = "Label"

l_s_label = dw_1.GetItemString(1, "field1")

IF NOT ( l_str_parm.value12 > "" ) THEN
	l_str_parm.value12 = l_s_label
END IF

IF IsValid ( gnv_App.of_GetFrame() ) THEN
	OpenSheetWithParm ( l_w_instance, l_str_parm, gnv_App.of_GetFrame(), 0, Original! )
ELSE
	OpenWithParm ( l_w_instance, l_str_parm )
END IF


end subroutine

event open;Long   l_l_count

dw_1.GetChild ( "unit_measure", dwcUnits )
dwcUnits.SetTransObject ( sqlca )
dw_1.GetChild ( "package_type", dwcPackaging )
dwcPackaging.SetTransObject ( sqlca )

dw_1.InsertRow ( 1 )
dw_1.SetFocus ( )
dw_1.SetItem ( 1, "sequence", 1 )
dw_1.SetItem ( 1, "status", 'A' )
dw_1.SetItem ( 1, "user_defined_status", "Approved" )


end event

on w_manual_add_object.create
this.lb_1=create lb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.lb_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_manual_add_object.destroy
destroy(this.lb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event resize;w_manual_add_object.Resize ( 2081, 1300 ) 
end event

type lb_1 from listbox within w_manual_add_object
boolean visible = false
integer x = 535
integer y = 1088
integer width = 498
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_manual_add_object
integer x = 1714
integer y = 1088
integer width = 256
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
end type

on clicked;Close ( Parent )
end on

type cb_1 from commandbutton within w_manual_add_object
integer x = 1367
integer y = 1084
integer width = 256
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
end type

event clicked;String 	szPart
String 	szUnit
String	szLocation
String	szStatus
String	lszoperator
String 	szLot
String	szStdUnit
String	szPlant
String	szPackaging
String   ls_Custom1
String   ls_Custom2
String   ls_Custom3
String   ls_Custom4
String   ls_Custom5
string	ls_UserDefinedStatus,&
		ls_eng_level
Long 		lSerial
Int 		iCounter
Int 		iLoop
Dec		dTareWeight
Dec 		dQty
Dec		dCost
Dec		dstdCost
Dec		dOnHand
Dec		dWeight
Dec		dStdQty
Dec		dNewOnHand
Date 		dToday
Time 		tTime
DateTime dtDateTime
str_progress stProgress
Dec      l_d_weight
st_generic_structure l_str_parm

IF dw_1.AcceptText ( ) <> 1 THEN RETURN

szPart     				= f_get_string_value ( dw_1.GetItemString ( 1, "part" ) )
szUnit     				= f_get_string_value ( dw_1.GetItemString ( 1, "unit_measure" ) )
szLocation 				= f_get_string_value ( dw_1.GetItemString ( 1, "location" ) )
ls_UserDefinedStatus = f_get_string_value ( dw_1.GetItemString ( 1, "user_defined_status" ) )
lszoperator 			= f_get_string_value ( dw_1.GetItemString ( 1, "operator_code" ) )
szLot      				= f_get_string_value ( dw_1.GetItemString ( 1, "lot" ) )
szPackaging				= f_get_string_value ( dw_1.GetItemString ( 1, "package_type" ) )
ls_Custom1  			= f_get_string_value ( dw_1.GetItemString ( 1, "custom1" ) )
ls_Custom2  			= f_get_string_value ( dw_1.GetItemString ( 1, "custom2" ) )
ls_Custom3  			= f_get_string_value ( dw_1.GetItemString ( 1, "custom3" ) )
ls_Custom4  			= f_get_string_value ( dw_1.GetItemString ( 1, "custom4" ) )
ls_Custom5  			= f_get_string_value ( dw_1.GetItemString ( 1, "custom5" ) )
dQty       				= f_get_value ( dw_1.GetItemNumber ( 1, "quantity" ) )
l_d_weight           = dw_1.GetItemNumber ( 1, "weight" )
iSequence  				= f_get_value ( dw_1.GetItemNumber ( 1, "sequence" ) )
dcost  				= f_get_value ( dw_1.GetItemNumber ( 1, "cost" ) )

If iSequence < 1 Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter number of objects!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "sequence" )
dw_1.SetFocus ( )
Return
END IF

If szPart = "" Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a part!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "part" )
dw_1.SetFocus ( )
Return
END IF

If dQty <= 0 Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a quantity!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "quantity" )
dw_1.SetFocus ( )
Return
END IF

If szUnit = "" Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a unit of measure!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "unit_measure" )
dw_1.SetFocus ( )
Return
END IF

If szLocation = "" Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a location!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "location" )
dw_1.SetFocus ( )
Return
END IF

If ls_UserDefinedStatus = "" Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a status!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "user_defined_status" )
dw_1.SetFocus ( )
Return
END IF

If lszoperator = "" Then
bMessage = True
MessageBox ( monsys.msg_title, "You must enter a operator code!", Exclamation! )
bMessage = False
dw_1.SetColumn ( "operator" )
dw_1.SetFocus ( )
Return
END IF

SELECT location.plant  
INTO :szPlant  
FROM location  
WHERE location.code = :szLocation   ;

If szPackaging <> "" Then
SELECT package_materials.weight  
  INTO :dTareWeight  
  FROM package_materials  
 WHERE package_materials.code = :szPackaging   ;
Else
dTareWeight = 0
End if

SELECT part_mfg.engineering_level  
INTO :ls_eng_level  
FROM part_mfg  
WHERE part_mfg.part = :szPart   ;

ls_eng_level = f_get_string_value ( ls_eng_level )

stProgress.Cancel_window = w_manual_add_object
stProgress.Title = "Manual Add"

bMessage = True

OpenWithParm ( w_progress, stProgress )

cb_1.enabled = false

SELECT user_defined_status.type  
INTO :szStatus  
FROM user_defined_status  
WHERE user_defined_status.display_name = :ls_UserDefinedStatus   ;

dw_1.SetItem ( 1, "status", szStatus )

For iLoop = 1 To iSequence
iCounter++
w_progress.wf_progress ( iCounter / ( iSequence * 3 ), "Getting Next Serial Number..." )

Yield ( )

//	OpenWithParm ( w_get_parm_value, "next_serial" )
//lSerial 		= Message.DoubleParm

if SQLCA.of_getnextparmvalue ( "next_serial", lserial) then
	
dw_1.SetItem ( 1, "serial", lSerial )

dToday 		= Today ( )
tTime 		= Now ( )
dtDateTime 	= DateTime ( Today ( ), Now ( ) )

lSerialHold[iLoop] = lSerial

SELECT part_inventory.unit_weight,   
		 part_inventory.standard_unit  
  INTO :dWeight,   
		 :szStdUnit  
  FROM part_inventory  
 WHERE part_inventory.part = :szPart   ;

SELECT part_standard.cost_cum  
  INTO :dstdCost  
  FROM part_standard  
 WHERE part_standard.part = :szPart   ;

if dcost = 0 then dcost = dstdcost

dStdQty = f_convert_units ( szUnit, szStdUnit, szPart, dQty )

INSERT INTO object  
					 ( serial,   
						part,   
						location,   
						last_date,   
						unit_measure,   
						operator,   
						status,   
						destination,   
						station,   
						origin,   
						cost,   
						weight,   
						parent_serial,   
						note,   
						quantity,   
						last_time,   
						date_due,   
						customer,   
						sequence,   
						shipper,   
						lot,   
						type,   
						po_number,   
						name,   
						plant,   
						start_date,   
						std_quantity,   
						package_type,   
						field1,   
						field2,   
						custom1,   
						custom2,   
						custom3,   
						custom4,   
						custom5,   
						show_on_shipper,
						tare_weight,
						user_defined_status,
						engineering_level,
						dimension_qty_string,
						varying_dimension_code,
						std_cost)  
			VALUES ( :lSerial,   
						:szPart,   
						:szLocation,   
						:dToday,   
						:szUnit,   
						:lszoperator,   
						:szStatus,   
						null,   
						null,   
						null,   
						:dCost,   
						:l_d_Weight,   
						null,   
						null,   
						:dQty,   
						:tTime,   
						null,   
						null,   
						:iLoop,   
						null,   
						:szLot,   
						null,   
						null,   
						null,   
						:szPlant,   
						null,   
						:dStdQty,   
						:szPackaging,   
						null,   
						null,   
						:ls_Custom1,   
						:ls_Custom2,   
						:ls_Custom3,   
						:ls_Custom4,   
						:ls_Custom5,   
						null,
						:dTareWeight,
						:ls_UserDefinedStatus,
						:ls_eng_level,
						:szdimensionqtystr,
						1,
						:dstdcost)  ;
	
If SQLCA.SQLCode = -1 Then
	RollBack ;
	Close ( w_progress )
	bMessage = False
	Return
End if

iCounter++
w_progress.wf_progress ( iCounter / ( iSequence * 3 ), "Creating Object " + String ( lSerial ) + "..." )

If szStatus = 'A' Then

	dNewOnHand = f_update_onhand ( szPart, dStdQty, "+*" )

Else

	SELECT part_online.on_hand  
	  INTO :dNewOnHand  
	  FROM part_online 
	 WHERE part_online.part = :szPart   ;

	dNewOnHand = f_get_value ( dNewOnHand )

End if

iCounter++
w_progress.wf_progress ( iCounter / ( iSequence * 3 ), "Creating Audit Trail " + String ( lSerial ) + "..." )

If Not f_create_audit_trail ( lSerial, "A", String ( dNewOnHand ), "", "", "", "", "", "", "", "", "No Commit" ) Then
	RollBack ;
	Close ( w_progress )
	bMessage = False
	Return
End if

Commit ;

l_str_parm.value1 = string (lserial)

// modified the print routine to print from f_print_label - mb - 12/22/98
l_str_parm.value11 = "Label"
l_str_parm.value12 = dw_1.GetItemString(1, "field1")
f_print_label ( l_str_parm )
else 
	rollback;
	return
end if

Next

Close ( w_progress )

bMessage = False

Close ( Parent )

end event

type dw_1 from datawindow within w_manual_add_object
event ue_key pbm_dwnkey
integer x = 18
integer y = 12
integer width = 2002
integer height = 1040
integer taborder = 10
string dataobject = "d_manual_add_object"
boolean border = false
end type

event ue_key;int li_current_row, &
	 li_current_column
string l_s_unit, &
       l_s_ddarequired
if (keydown(keyTab!) OR keydown(keyEnter!)) then
   if (dw_1.getcolumnname()='quantity') then 
		select dda_required
		  into :l_s_ddarequired
		  from parameters ;
		if (l_s_ddarequired='Y') then  
			li_current_row = dw_1.getrow()
			dw_1.accepttext()
			st_prmlst.s_arg_part   = dw_1.getitemstring(li_current_row,'part')
			select standard_unit
			  into :l_s_unit
			  from part_inventory
			 where part = :st_prmlst.s_arg_part ;
			st_prmlst.s_arg_module = l_s_unit
			st_prmlst.s_rtn_qtystr = szdimensionqtystr
			st_prmlst.s_rtn_qty    = dw_1.getitemnumber(li_current_row,'quantity') 
			Openwithparm(w_dda, st_prmlst)
			st_prmlst = Message.PowerObjectparm
			dw_1.setitem(li_current_row,'quantity',st_prmlst.s_rtn_qty)
			szdimensionqtystr = st_prmlst.s_rtn_qtystr
		end if 	
	end if 
End if 

end event

event itemfocuschanged;Long 		iLoop
Long 		lRow
String 	szPackageType
String 	szDummy

st_return_units_for_part stPartParm

If dw_1.GetColumnName ( ) <> "part" Then

	If szColumnName = "part" Then

		stPartParm.szPart = dw_1.GetItemString ( 1, "part" )

 	   SELECT part.part  
	     INTO :szDummy  
	     FROM part  
	    WHERE part.part = :stPartParm.szPart   ;

		If SQLCA.SQLCode <> 0 Then
			bMessage = True
			MessageBox ( monsys.msg_title, "Invalid part number!  Please re-enter a valid one.", StopSign! )
			bMessage = False
			dw_1.SetItem ( 1, "part", "" )
			dw_1.SetColumn ( "part" )
			Return
		End if

		 DECLARE packaging CURSOR FOR  
		  SELECT part_packaging.code  
		    FROM part_packaging  
		   WHERE part_packaging.part = :stPartParm.szPart   
		ORDER BY part_packaging.code ASC  ;
			
 	  	SELECT part_inventory.standard_unit  
	     INTO :stPartParm.szOriginalUnit  
	     FROM part_inventory  
	    WHERE part_inventory.part = :stPartParm.szPart   ;
		
		f_get_units_for_part ( stPartParm.szOriginalUnit, stPartParm.szPart, lb_1 )
	
		dwcUnits.Reset ( )

		For iLoop = 1 to lb_1.TotalItems ( )
			dwcUnits.InsertRow ( 0 )
			lb_1.SelectItem ( iLoop )
			dwcUnits.SetItem ( iLoop, "unit", lb_1.SelectedItem ( ) )
		Next

		dwcPackaging.Reset ( )

		Open Packaging ;

		Do
			Fetch Packaging Into :szPackageType ;
			If SQLCA.SQLCode = 0 Then
				lRow = dwcPackaging.RowCount ( ) + 1
				dwcPackaging.InsertRow ( 0 )
				dwcPackaging.SetItem ( lRow, "package_type", szPackageType )
			End if
		Loop While SQLCA.SQLCode = 0

		Close Packaging ;

	End if

End if

szColumnName = dw_1.GetColumnName ( )


end event

event itemchanged;choose  case dwo.name
	case "part"
		//	Don't allow correction of WIP, FIN.
		string pType
		
		select
			p.type
		into
			:pType
		from
			dbo.part p
		where
			p.part = :data;
		
		if	pType = 'W' then
			MsgBox("You cannot add WIP inventory from here.  Perform a cycle count.")
			return 1
		elseif	pType = 'F' then
			MsgBox("You cannot add finished inventory from here.  Perform a cycle count.")
			return 1
		end if
		
		string	ls_LabelFormat
		
		select	part_inventory.label_format 
		into	:ls_LabelFormat
		from	part
			join part_inventory on part.part = part_inventory.part
		where	part_inventory.part = :data;
		
		if SQLCA.SQLCode = 100 then
			MessageBox (monsys.msg_title, "Invalid part.  Please choose a valid part number!", StopSign!, Ok!)
			return 1
		end if
		
		SetItem (row, "field1", ls_LabelFormat)
	case "location"
		string	ls_LocationCode
		
		select	location.code
		into	:ls_LocationCode
		from	location
		where	location.code = :data;
		
		if SQLCA.SQLCode = 100 then
			MessageBox (monsys.msg_title, "Invalid location.  Please choose a valid location code!", StopSign!, Ok!)
			return 1
		end if
end choose

end event

event constructor;this.SetTransObject ( sqlca )
end event

