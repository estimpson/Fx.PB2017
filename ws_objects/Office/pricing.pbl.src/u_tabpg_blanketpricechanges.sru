$PBExportHeader$u_tabpg_blanketpricechanges.sru
forward
global type u_tabpg_blanketpricechanges from u_tabpg_dw
end type
end forward

global type u_tabpg_blanketpricechanges from u_tabpg_dw
integer width = 1977
string text = "Blanket Price Admin"
end type
global u_tabpg_blanketpricechanges u_tabpg_blanketpricechanges

type variables

string User

end variables

on u_tabpg_blanketpricechanges.create
call super::create
end on

on u_tabpg_blanketpricechanges.destroy
call super::destroy
end on

event constructor;call super::constructor;
gnv_App.inv_StateMSGRouter.Register("User", this, true)
gnv_App.inv_StateMSGRouter.Register("BlanketPriceChangesImported", this, false)

end event

event pfd_event;call super::pfd_event;
choose case EventName
	case "User"
		User = eventmessage.of_GetItem("User")
	case "BlanketPriceChangesImported"
		dw_1.event pfc_retrieve()
end choose

end event

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_blanketpricechanges
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_blanketpricechanges
string dataobject = "d_blanketpricechanges"
end type

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()

end event

event dw_1::constructor;call super::constructor;
ib_RMBMenu = false
of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

of_SetTransObject(SQLCA)
event pfc_retrieve()
of_SetRowManager(true)




end event

event dw_1::clicked;call super::clicked;string		ls_user
int 		rw = 1
int			li_SaveChanges
string		ErrMessage

if dwo.Name = "b_2" then
	// Activate blanket price changes
	
	int li_Records
	int li_Confirm
	
	// Make sure there are records available to activate
	select		count(1) as recordcount
	into		:li_Records
	from		BlanketPriceChanges
	where	EffectiveDate < getdate() and Activated = 0 ;
	
	if li_Records > 0 then
				
		// Check to see if any rows have been modified but not saved - if so, user must update before proceeding
		if dw_1.ModifiedCount() > 0 then
			li_SaveChanges = dw_1.of_MessageBox("1", "Activate blanket prices", "The changes you've made to the data must be saved before proceeding.  Save now?", StopSign!, OKCancel!, 2)
	 
			if li_SaveChanges = 1 then
				// Set UserCode, UserName, and ChangedDate values in datawindow
				select		name
				into		:ls_user
				from		employee
				where	operator_code = :User  ;
				
				do while rw <= dw_1.RowCount()
					dw_1.SetItem(rw, "UserCode", User)
					dw_1.SetItem(rw, "UserName", ls_user)
					dw_1.SetItem(rw, "ChangedDate", today())
					rw++
				loop
				
				// Update BlanketPriceChanges table
				dw_1.Update()
				commit using SQLCA  ;
					
				// Call procedure to activate price changes
				li_Confirm = dw_1.of_MessageBox("1", "Blanket price change confirmation", "Are you sure you want to activate blanket price changes?", Exclamation!, YesNo!, 2)
				if li_Confirm = 1 then
					declare PriceAdminProc1 procedure for dbo.usp_PriceAdmin_ActivateBlanketPriceChanges 
					@UserCode = :User, 
					@UserName = :ls_user,
					@TranDT datetime = null output,
					@Result int = 0 output
					using SQLCA ; 
					execute PriceAdminProc1 ; 
					
					if SQLCA.SQLCode <> 0 then
						ErrMessage = SQLCA.SQLErrText
						rollback using SQLCA  ;
						MessageBox ("Price change activation failed", ErrMessage)
					else
						commit using SQLCA  ;
						dw_1.Reset()
						dw_1.Retrieve()
					end if		
				end if
			end if
		
		else
			// Call procedure to activate price changes
			li_Confirm = dw_1.of_MessageBox("1", "Blanket price change confirmation", "Are you sure you want to activate blanket price changes?", Exclamation!, YesNo!, 2)
			if li_Confirm = 1 then
				declare PriceAdminProc2 procedure for dbo.usp_PriceAdmin_ActivateBlanketPriceChanges 
				@UserCode = :User, 
				@UserName = :ls_user,
				@TranDT datetime = null output,
				@Result int = 0 output
				using SQLCA ; 
				execute PriceAdminProc2 ; 
				
				if SQLCA.SQLCode <> 0 then
					ErrMessage = SQLCA.SQLErrText
					rollback using SQLCA  ;
					MessageBox ("Price change activation failed", ErrMessage)
				else
					commit using SQLCA  ;
					dw_1.Reset()
					dw_1.Retrieve()
				end if		
			end if
		end if
		
	else
		MessageBox("Price change activation cancelled", "Effective date of price change must be less than or equal to today.  There are no records that meet this criteria at this time.")
	end if
			
elseif dwo.Name = "b_3" then	
	// Save any EffectiveDate or BlanketPrice changes that have been made to non-activated records, and
	// Delete any checked rows from BlanketPriceChanges table
					
	// Set UserCode, UserName, and ChangedDate values in datawindow
	select		name
	into		:ls_user
	from		employee
	where	operator_code = :User  ;
	
	do while rw <= dw_1.RowCount()
		dw_1.SetItem(rw, "UserCode", User)
		dw_1.SetItem(rw, "UserName", ls_user)
		dw_1.SetItem(rw, "ChangedDate", today())
		rw++
	loop

	int deleteRow = 1
	do while deleteRow <= dw_1.RowCount()
		if	dw_1.object.selectedfordelete[deleteRow] = 1 then
			dw_1.DeleteRow(deleteRow)
		else
			deleteRow++
		end if
	loop
	
	dw_1.Update()
	commit using SQLCA  ;
	
	dw_1.Reset()
	dw_1.Retrieve()
	
elseif dwo.Name = "b_4" then
	// Clear old activated records

	int iActivated = 0
	int iRow = 1
	do while iRow <= dw_1.RowCount()
		if dw_1.object.activated[iRow] = 1 then
			iActivated = 1
			exit
		else
			iRow++
		end if
	loop
	
	if iActivated = 1 then
		string ls_returned
		
		// Check to see if any rows have been modified but not saved - if so, user must update before proceeding
		if dw_1.ModifiedCount() > 0 then
			li_SaveChanges = dw_1.of_MessageBox("1", "Clear activated price changes", "The changes you've made to the data must be saved before proceeding.  Save now?", StopSign!, OKCancel!, 2)
       
		 	if li_SaveChanges = 1 then	
				// Set UserCode, UserName, and ChangedDate values in datawindow
				select		name
				into		:ls_user
				from		employee
				where	operator_code = :User  ;
				
				do while rw <= dw_1.RowCount()
					dw_1.SetItem(rw, "UserCode", User)
					dw_1.SetItem(rw, "UserName", ls_user)
					dw_1.SetItem(rw, "ChangedDate", today())
					rw++
				loop
				
				// Update BlanketPriceChanges table
		 		dw_1.Update()
				commit using SQLCA  ;
			
				// Show 'Clear Activated' window
				open(w_clearactivated)
				
				// Check text returned in Message object by the 'clear' window when it closes
				ls_returned = Message.StringParm
				if ls_returned <> "" then
					update	BlanketPriceChanges
					set			Cleared = 1
					where	EffectiveDate <= :ls_returned ;
					
					commit using SQLCA  ;
					dw_1.Reset()
					dw_1.Retrieve()	
				end if
			end if

		else
			// Show 'Clear Activated' window
			open(w_clearactivated)
			
			// Check text returned in Message object by the 'clear' window when it closes
			ls_returned = Message.StringParm
			if ls_returned <> "" then
				update	BlanketPriceChanges
				set			Cleared = 1
				where	EffectiveDate <= :ls_returned ;
				
				commit using SQLCA  ;
				dw_1.Reset()
				dw_1.Retrieve()	
			end if
		end if

	else
		MessageBox("Clear activated cancelled", "There are no activated price changes to clear.")
	end if

elseif dwo.name = 'selectedallfordelete_1' then
	
	int deleteCbxRow = 1
			
	if dw_1.object.selectedallfordelete_1[1] = 0 then
		
		do while deleteCbxRow <= dw_1.RowCount()
			dw_1.object.selectedallfordelete_1[deleteCbxRow] = 1
			dw_1.object.selectedfordelete[deleteCbxRow] = 1
			
			deleteCbxRow ++
		loop
	else
		do while deleteCbxRow <= dw_1.RowCount()
			dw_1.object.selectedallfordelete_1[deleteCbxRow] = 0
			dw_1.object.selectedfordelete[deleteCbxRow] = 0
			
			deleteCbxRow ++
		loop
	end if
	
end if
end event

