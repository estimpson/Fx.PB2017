$PBExportHeader$u_tabpg_pricecustomerimport.sru
forward
global type u_tabpg_pricecustomerimport from u_tabpg_dw
end type
end forward

global type u_tabpg_pricecustomerimport from u_tabpg_dw
integer width = 3035
integer height = 1300
string text = "Part-Customer-Price Import"
end type
global u_tabpg_pricecustomerimport u_tabpg_pricecustomerimport

type variables
string User
end variables

on u_tabpg_pricecustomerimport.create
call super::create
end on

on u_tabpg_pricecustomerimport.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_pricecustomerimport
integer width = 2213
integer height = 1272
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_pricecustomerimport
integer x = 14
integer y = 60
integer height = 1192
string dataobject = "d_partcustpriceimport"
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

// Get user
gnv_App.inv_StateMSGRouter.Register("User", this, true)

end event

event dw_1::clicked;call super::clicked;if dwo.Name = "b_1" then
	// Import blanket price data from Excel file
	dw_1.Reset()
	
	// Pull file path from Registry
	string ls_filepath
	n_cst_registry registryValues
	RegistryGet(registryValues.UserRoot, "PriceChanges", RegString!, ls_filepath)

	//	dw_1.ImportFile(string(ls_filepath), 2)
	//	dw_1.Filter()
	
	// Import file
	string docpath, docname[], fullpath
	integer i, li_cnt, li_rtn, li_filenum

	li_rtn = GetFileOpenName("Select File", docpath, docname[], "DOC", &
	+ "CSV Files (*.CSV),*.CSV,", ls_filepath, 18)

	if li_rtn < 1 then return
		li_cnt = Upperbound(docname)

		// if only one file is picked, docpath contains the path and file name
		if li_cnt = 1 then
			dw_1.ImportFile(string(docpath), 2)
			dw_1.Filter()
		else
			// if multiple files are picked, docpath contains the path only - concatenate docpath and docname
		   for i=1 to li_cnt
      	   		fullpath += string(docpath) &
				+ "\" +(string(docname[i]))+"~r~n"
		   next
			dw_1.ImportFile(string(fullpath), 2)
			dw_1.Filter()
		end if
	
elseif dwo.Name = "b_2" then
	// Update part_customer_price_import table (temp table) with spreadsheet data
	// All rows will be inserted because none were retrieved from the database - only from the spreadsheet
	
	dw_1.Update()
		
	string		ls_user
	select		name
	into		:ls_user
	from		employee
	where	operator_code = :User  ;
	
	update	BlanketPriceImport
	set 		UserCode = :User,
				UserName = :ls_user,
				ChangedDate = getdate() ;
	
	if SQLCA.SQLCode <> 0 then
		string ErrMessage
		ErrMessage = SQLCA.SQLErrText
		rollback using SQLCA  ;
		MessageBox ("Update failed", ErrMessage)
	else
		commit using SQLCA  ;
	end if


	// Update prices in part_customer_blanketprice_changes table, or insert new records into it
	// (trigger will be fired on BlanketPriceChanges table to update BlanketPriceChangesLog table)
	execute immediate 'usp_PriceAdmin_ImportBlanketPriceChanges'  using SQLCA ;
	
	if SQLCA.SQLCode <> 0 then
		string ErrMessage2
		ErrMessage2 = SQLCA.SQLErrText
		rollback using SQLCA  ;
		MessageBox ("Save to database failed", ErrMessage2)
	else
		// Clear BlanketPriceImport table
		delete from BlanketPriceImport ;
		dw_1.Reset()
		
		commit using SQLCA  ;
	end if
	
	n_cst_associative_array Parm
	Parm.of_SetItem ("BlanketPriceChangesImported", "")
	gnv_App.inv_StateMSGRouter.of_Broadcast (Parm)
end if
end event

event dw_1::pfd_event;call super::pfd_event;
choose case EventName
	case "User"
		User = eventmessage.of_GetItem("User")
end choose

end event

