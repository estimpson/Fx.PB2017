$PBExportHeader$u_sheet_tabpg.sru
forward
global type u_sheet_tabpg from u_tabpg
end type
end forward

global type u_sheet_tabpg from u_tabpg
long tabbackcolor = 1073741824
long picturemaskcolor = 12632256
end type
global u_sheet_tabpg u_sheet_tabpg

type variables

private window SheetWindow

end variables

forward prototypes
public function integer of_setsheetwindow (ref window _sheetwindow, string _picturename)
public function integer of_showsheet ()
end prototypes

public function integer of_setsheetwindow (ref window _sheetwindow, string _picturename);
if	IsValid (_sheetWindow) then
	SheetWindow = _sheetWindow
	Text = sheetWindow.Title
	PictureName = _pictureName
	return SUCCESS
end if
return FAILURE

end function

public function integer of_showsheet ();
if	IsValid (SheetWindow) then
	SheetWindow.BringToTop = true
	return SUCCESS
end if
return NO_ACTION

end function

on u_sheet_tabpg.create
call super::create
end on

on u_sheet_tabpg.destroy
call super::destroy
end on

