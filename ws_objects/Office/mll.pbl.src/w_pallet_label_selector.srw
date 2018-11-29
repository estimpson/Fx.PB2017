$PBExportHeader$w_pallet_label_selector.srw
forward
global type w_pallet_label_selector from window
end type
end forward

global type w_pallet_label_selector from window
integer x = 1056
integer y = 484
integer width = 2569
integer height = 1516
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
end type
global w_pallet_label_selector w_pallet_label_selector

event open;// Pallet Label Selector 2/01
// Mod 11/01 to look up mixed load labels flexibly

//	Prints the pallet label in order detail
//	for a pallet staged to a shipper.

//	Declarations.
long		ll_PalletSerial
long		ll_Shipper
long		ll_Suffix
long		ll_OrderNo
long		ll_partcnt
long		ll_labelcnt

string	ls_PalletLabel
string	ls_Part
string	ls_Check

st_generic_structure	lst_Parm

//	Initialize.
lst_Parm = message.powerobjectparm
ll_PalletSerial = Long ( lst_Parm.Value1 )

//	A.  Get the shipper and 1st child part and suffix for the pallet from object table.
select	Min ( shipper ),
	Min ( part )
into	:ll_Shipper,
	:ls_Part
from	object
where	parent_serial = :ll_PalletSerial  ;

select	Min ( suffix )
into	:ll_Suffix
from	object
where	parent_serial = :ll_PalletSerial and
	part = :ls_Part  ;

//	B.  Get the order from shipper detail.
select	order_no
into	:ll_OrderNo
from	shipper_detail
where	shipper = :ll_Shipper and
	part_original = :ls_Part and
	IsNull ( suffix, -1 ) = IsNull ( :ll_Suffix, -1 )  ;

//	C.  Get the 1st pallet label from order detail.
select	Min ( pallet_label )
into	:ls_PalletLabel
from	order_detail
where	order_no = :ll_OrderNo and
	part_number = :ls_Part and
	IsNull ( suffix, -1 ) = IsNull ( :ll_Suffix, -1 )  ;
	
// C.1 Change "PALLET" to "PALLET1" to avoid loop and default not found to PALLET1

if upper( ls_PalletLabel ) = "PALLET" or ls_PalletLabel = "" or isNull(ls_PalletLabel) then
	ls_PalletLabel = "PALLET1"
end if

// C.2 Check for Mixed Load and adjust format

select	count ( distinct part )
into	:ll_partcnt
from	object
where	parent_serial = :ll_PalletSerial  ;

if ll_partcnt > 1 then // Mixed Load

	// See if name allows name change
	if Upper( Right( ls_PalletLabel, 6 ) ) = "MASTER" or &
			Upper( Right( ls_PalletLabel, 6 ) ) = "PALLET" then
		ls_Check = Left( ls_PalletLabel, Len(ls_PalletLabel) - 6) + "MIXED"
		
		// Check existence of new name
		select	count (1)
		into	:ll_labelcnt
		from	report_library
		where	name = :ls_Check  ;
		
		if ll_labelcnt > 0 then
			ls_PalletLabel = ls_Check
		end if
	end if		
end if

//	D.  Print the pallet label.
n_cst_associative_array	printerParm

printerParm.of_SetItem ( "Arg1", ll_PalletSerial )
printerParm.of_SetItem ( "Report", "Label" )
printerParm.of_SetItem ( "Name", ls_PalletLabel )
Print(printerParm)

//	Close
close ( this )

end event

on w_pallet_label_selector.create
end on

on w_pallet_label_selector.destroy
end on

