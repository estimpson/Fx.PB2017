$PBExportHeader$u_it_list_box.sru
$PBExportComments$This is a list box to replace the drop down list boxes from the past.
forward
global type u_it_list_box from listbox
end type
end forward

global type u_it_list_box from listbox
int Width=494
int Height=360
int TabOrder=1
boolean VScrollBar=true
long TextColor=33554432
long BackColor=77897888
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_it_list_box u_it_list_box

forward prototypes
public function integer uf_find_item (string a_s_item)
public function string uf_get_current_item (string a_s_value)
public function integer uf_setup (string a_s_table_name, string a_s_column_name, integer a_i_obj_x, integer a_i_obj_y, integer a_i_obj_height, integer a_i_down_limit, integer a_i_text_size, integer a_i_obj_width, string a_s_where_column, string a_s_where_value, readonly listbox a_lb_alt_list, datawindow a_dw_limit_locs)
end prototypes

public function integer uf_find_item (string a_s_item);Return SelectItem ( a_s_item, 0 )
end function

public function string uf_get_current_item (string a_s_value);SelectItem ( a_s_value, 1 )
Return SelectedItem ( )
end function

public function integer uf_setup (string a_s_table_name, string a_s_column_name, integer a_i_obj_x, integer a_i_obj_y, integer a_i_obj_height, integer a_i_down_limit, integer a_i_text_size, integer a_i_obj_width, string a_s_where_column, string a_s_where_value, readonly listbox a_lb_alt_list, datawindow a_dw_limit_locs);string	l_s_string,&
	l_s_statement
int	l_i_count
long	ll_rowcount = 0
long	ll_foundrow

if (a_s_table_name = 'machine' or a_s_table_name = 'location') then ll_rowcount = a_dw_limit_locs.Rowcount()

Reset ( )

if a_s_table_name = "" then
	for l_i_count = 1 to a_lb_alt_list.TotalItems ( )
		a_lb_alt_list.SelectItem ( l_i_count )
		AddItem ( a_lb_alt_list.SelectedItem ( ) )
	next
else
	DECLARE data_list DYNAMIC CURSOR FOR SQLSA ;
	
	l_s_statement = "SELECT DISTINCT " + a_s_column_name + " FROM " + a_s_table_name
	if f_get_string_value ( a_s_where_column ) > '' and f_get_string_value ( a_s_where_value ) > '' then
		l_s_statement += " WHERE " + a_s_where_column + " = '" + a_s_where_value + "'"
	end if
	
	PREPARE SQLSA FROM :l_s_statement ;
	
	OPEN DYNAMIC data_list ;
	FETCH data_list INTO :l_s_string ;
	Do While sqlca.sqlcode = 0
		if ll_rowcount > 0 then 
			if a_dw_limit_locs.find("location_code = '"+l_s_string+"'", 1, ll_rowcount ) > 0 then 
				AddItem ( l_s_string )
			end if 
		else
			AddItem ( l_s_string )			
		end if 			
		FETCH data_list INTO :l_s_string ;
	Loop
	CLOSE data_list ;
end if

x 	= a_i_obj_x
y	= a_i_obj_y + a_i_obj_height
height	= a_i_down_limit - y
width	= a_i_obj_width
TextSize= a_i_text_size

Return TotalItems ( ) 
end function

event selectionchanged;Parent.Event POST DYNAMIC ue_return_value ( SelectedItem ( ) )
end event

