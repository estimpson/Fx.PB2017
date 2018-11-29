$PBExportHeader$u_tabpg_pricecustomer.sru
forward
global type u_tabpg_pricecustomer from u_tabpg_dw
end type
end forward

global type u_tabpg_pricecustomer from u_tabpg_dw
string text = "Part-Customer-Price"
end type
global u_tabpg_pricecustomer u_tabpg_pricecustomer

on u_tabpg_pricecustomer.create
call super::create
end on

on u_tabpg_pricecustomer.destroy
call super::destroy
end on

type gb_1 from u_tabpg_dw`gb_1 within u_tabpg_pricecustomer
integer width = 1143
end type

type dw_1 from u_tabpg_dw`dw_1 within u_tabpg_pricecustomer
integer width = 1038
string dataobject = "d_partcustprice"
boolean controlmenu = true
end type

event dw_1::constructor;call super::constructor;
ib_RMBMenu = false
of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

of_SetTransObject(SQLCA)
event pfc_retrieve()
of_SetRowManager(true)


end event

event dw_1::pfc_retrieve;call super::pfc_retrieve;
return Retrieve()
end event

event dw_1::clicked;call super::clicked;
if dwo.Name = "b_1" then
	// Export datawindow rows to Excel spreadsheet
	string spreadsheetpath
	string fileName
	integer li_rtn
	
	// Pull file path from Registry (if it exists) to use as the default export path
	string ls_filepath
	n_cst_registry registryValues
	RegistryGet(registryValues.UserRoot, "PriceChanges", RegString!, ls_filepath)
	
	// Save file dialog box
	if ls_filepath > "" then
		li_rtn = GetFileSaveName("Name Price File", spreadsheetpath, filename, "CSV", "Comma Separated Files (*.CSV),*.CSV,", ls_filepath, 18)
	else
		li_rtn = GetFileSaveName("Name Price File", spreadsheetpath, filename, "CSV", "Comma Separated Files (*.CSV),*.CSV,", GetCurrentDirectory(), 18)
	end if
	
	if li_rtn < 1 then return
		// Save file
		dw_1.SaveAs(spreadsheetpath, CSV!, true)
	
		// Add file path to Registry
		RegistrySet(registryValues.UserRoot, "PriceChanges", RegString!, spreadsheetpath)

		// Get the latest version of Excel that is installed on the machine
		string ls_subkeylist[]
		li_rtn = RegistryKeys("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\", ls_subkeylist)
		if li_rtn > -1 then

			string version = "0"
			int i
			for i = 1 to upperbound(ls_subkeylist)
				if ls_subkeylist[i] = "14.0" then
					version = "14.0"
					exit
				end if
			next
			
			if version= "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "12.0" then
						version = "12.0"
						exit
					end if
				next
			end if
						
			if version = "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "11.0" then
						version = "11.0"
						exit
					end if
				next
			end if
						
			if version = "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "10.0" then
						version = "10.0"
						exit
					end if
				next
			end if
						
			if version = "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "9.0" then
						version = "9.0"
						exit
					end if
				next
			end if
			
			if version = "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "8.0" then
						version = "8.0"
						exit
					end if
				next
			end if
			
			if version = "0" then
				for i = 1 to upperbound(ls_subkeylist)
					if ls_subkeylist[i] = "7.0" then
						version = "7.0"
						exit
					end if
				next
			end if
			
			if version <> "0" then
				// Open file
				string ls_regpath
				string ls_excelpath

				ls_regpath = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\" + version + "\Excel\InstallRoot"
				RegistryGet(ls_regpath, "Path", RegString!, ls_excelpath)
				
				// Open file
				ls_excelpath += "\Excel.exe"
				run("~"" + ls_excelpath + "~" ~"" + spreadsheetpath + "~"")
				
			else
				messagebox("Open Excel spreadsheet failed", "Microsoft Excel was not found on this machine.")
			end if	
		
		else
			messagebox("Open Excel spreadsheet failed", "Microsoft Office was not found on this machine.")
		end if

end if

end event

event dw_1::rbuttondown;call super::rbuttondown;//messagebox("right-click", xpos)

//uo_1.Show()
end event

