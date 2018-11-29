$PBExportHeader$u_tv.sru
$PBExportComments$Extension TreeView class
forward
global type u_tv from pfc_u_tv
end type
end forward

global type u_tv from pfc_u_tv
end type
global u_tv u_tv

type variables

n_cst_associative_array	PictureArray

end variables

forward prototypes
public function integer getpictureindex (string _picturename)
end prototypes

public function integer getpictureindex (string _picturename);
integer	pictureIndex
//	Look for picture in array.
pictureIndex = IsNull(PictureArray.of_GetItem(_pictureName),-1)
if	pictureIndex <= 0 then
	
	//	Not found.  Add to tree view and array.
	pictureIndex = AddPicture(_pictureName)
	PictureArray.of_SetItem(_pictureName, pictureIndex)
end if

//	Return index.
return	pictureIndex

end function

on u_tv.create
call super::create
end on

on u_tv.destroy
call super::destroy
end on

