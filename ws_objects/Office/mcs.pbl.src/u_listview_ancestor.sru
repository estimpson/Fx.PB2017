$PBExportHeader$u_listview_ancestor.sru
forward
global type u_listview_ancestor from listview
end type
end forward

global type u_listview_ancestor from listview
int Width=494
int Height=361
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
ListViewView View=ListViewList!
string LargePictureName[]={"Custom039!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=536870912
string SmallPictureName[]={"Custom039!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=536870912
long StatePictureMaskColor=536870912
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_listview_ancestor u_listview_ancestor

forward prototypes
public function long of_additem (any a_a_data, string a_s_label, integer a_i_pictureindex)
public function integer of_addcolumn (string a_s_label, any a_a_alignment, long a_l_width)
public function integer of_deletecolumn (integer a_i_column)
public subroutine of_changeview (any a_a_view)
public function integer of_deleteitem (integer a_i_index)
end prototypes

public function long of_additem (any a_a_data, string a_s_label, integer a_i_pictureindex);listviewitem	l_lvi_item

l_lvi_item.label			= a_s_label
l_lvi_item.data			= a_a_data
l_lvi_item.pictureindex	= a_i_pictureindex

return AddItem ( l_lvi_item )
end function

public function integer of_addcolumn (string a_s_label, any a_a_alignment, long a_l_width);return AddColumn ( a_s_label, a_a_alignment, a_l_width )
end function

public function integer of_deletecolumn (integer a_i_column);Choose Case a_i_column
	Case 0
		return DeleteColumns ( )
	Case Else
		return DeleteColumn ( a_i_column )
End Choose
end function

public subroutine of_changeview (any a_a_view);view = a_a_view
end subroutine

public function integer of_deleteitem (integer a_i_index);Choose Case a_i_index
	Case 0
		return deleteitems ( )
	Case Else
		return deleteitem ( a_i_index )
End Choose
end function

