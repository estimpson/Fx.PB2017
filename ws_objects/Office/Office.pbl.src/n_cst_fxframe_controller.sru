$PBExportHeader$n_cst_fxframe_controller.sru
forward
global type n_cst_fxframe_controller from n_cst_virtual_controller
end type
end forward

global type n_cst_fxframe_controller from n_cst_virtual_controller
string proxyname = "0"
integer _displaymode = 0
end type
global n_cst_fxframe_controller n_cst_fxframe_controller

type variables

private:
w_frame_office _myFrame

end variables

forward prototypes
public function integer registerframe (ref w_frame_office framewindow)
public function integer startscanning (ref n_cst_virtual_controller scanhandler)
public function integer stopscanning ()
public function integer hidetree ()
public function integer showtree ()
public function integer showlogin ()
public function integer hidelogin ()
public function integer setapplicationprofile (string applicationprofle)
end prototypes

public function integer registerframe (ref w_frame_office framewindow);
if	not IsValid(frameWindow) then
	return FAILURE
end if

_myFrame = frameWindow

if	gnv_app.inv_Global.of_GetIndexorKey("ApplicationProfile") > 0 then
	string applicationProfile
	applicationProfile = IsNull(gnv_app.inv_Global.of_GetItem("ApplicationProfile"), "")
	if	applicationProfile > "" then
		SetApplicationProfile(applicationProfile)
	end if
else
	SetApplicationProfile("Default")
end if

return SUCCESS

end function

public function integer startscanning (ref n_cst_virtual_controller scanhandler);
if	not IsValid(scanHandler) or not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.StartScanning(scanHandler)

end function

public function integer stopscanning ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.StopScanning()

end function

public function integer hidetree ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.HideTree()

end function

public function integer showtree ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.ShowTree()

end function

public function integer showlogin ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.ShowLogin()

end function

public function integer hidelogin ();
if	not IsValid(_myFrame) then
	return FAILURE
end if

return _myFrame.HideLogin()

end function

public function integer setapplicationprofile (string applicationprofle);
n_ds	applicationProfilesDS
applicationProfilesDS = create n_ds
applicationProfilesDS.DataObject = "d_applicationprofiles"
applicationProfilesDS.ImportFile("ApplicationProfiles.txt")

long row
row = applicationProfilesDS.Find("ApplicationProfile = ~"" + applicationProfle + "~"", 1, applicationProfilesDS.RowCount())

if	row > 0 then
	long menuVisible, loginVisible
	string defaultSheet
	menuVisible = applicationProfilesDS.Object.MenuVisible[row]
	loginVisible = applicationProfilesDS.Object.LoginVisible[row]
	defaultSheet = applicationProfilesDS.Object.DefaultSheet[row]
	
	return _myFrame.SetApplicationProfile(menuVisible, loginVisible, defaultSheet)
end if

return _myFrame.SetApplicationProfile(1, 1, "")

end function

on n_cst_fxframe_controller.create
call super::create
end on

on n_cst_fxframe_controller.destroy
call super::destroy
end on

