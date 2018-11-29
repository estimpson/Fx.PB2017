$PBExportHeader$u_treeview_ancestor.sru
forward
global type u_treeview_ancestor from treeview
end type
end forward

global type u_treeview_ancestor from treeview
int Width=325
int Height=229
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_treeview_ancestor u_treeview_ancestor

forward prototypes
public function long of_additem (boolean a_b_bold, boolean a_b_children, any a_a_data, boolean a_b_expanded, string a_s_label, integer a_i_pictureindex, integer a_i_selectedpictureindex, long a_l_parenthandle)
public function long of_findparent (long a_l_handle)
end prototypes

public function long of_additem (boolean a_b_bold, boolean a_b_children, any a_a_data, boolean a_b_expanded, string a_s_label, integer a_i_pictureindex, integer a_i_selectedpictureindex, long a_l_parenthandle);treeviewitem	l_tvi_item

l_tvi_item.bold						= a_b_bold
l_tvi_item.children 					= a_b_children
l_tvi_item.data 						= a_a_data
l_tvi_item.expanded					= a_b_expanded
l_tvi_item.label 						= a_s_label
l_tvi_item.pictureindex 			= a_i_pictureindex
l_tvi_item.selectedpictureindex 	= a_i_selectedpictureindex

return InsertItemLast ( a_l_parenthandle, l_tvi_item )

end function

public function long of_findparent (long a_l_handle);return FindItem ( ParentTreeItem!, a_l_handle )
end function

