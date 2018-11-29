$PBExportHeader$u_datawindow_key_increment_ancestor.sru
forward
global type u_datawindow_key_increment_ancestor from datawindow
end type
end forward

global type u_datawindow_key_increment_ancestor from datawindow
int Width=494
int Height=361
int TabOrder=1
boolean LiveScroll=true
end type
global u_datawindow_key_increment_ancestor u_datawindow_key_increment_ancestor

type variables
string		i_s_key_column,&
		i_s_key_table
int		i_i_error_count
boolean		i_b_new
end variables

forward prototypes
public function long of_getnextvalue (string a_s_table, string a_s_column)
end prototypes

public function long of_getnextvalue (string a_s_table, string a_s_column);//	Declare local variables
string	l_s_sql
long		l_l_value

// Build sql syntax
l_s_sql = "SELECT isnull( max (" + a_s_column + "), 0 ) + 1 FROM " + a_s_table

// Main section
DECLARE get_value DYNAMIC CURSOR FOR SQLSA ;
PREPARE SQLSA FROM :l_s_sql ;
OPEN DYNAMIC get_value ;
FETCH get_value INTO :l_l_value ;
CLOSE get_value ;

return l_l_value

end function

event updateend;if i_b_new and rowsinserted < 1 then
	if i_i_error_count > 10 then
		MessageBox ( "System Message", "Unable to save " + i_s_key_table + " at this time.  Please try again later.", Information! )
	else
		i_i_error_count++
		SetItem ( 1, i_s_key_column, 0 )
		Update ( )
	end if
end if
end event

event updatestart;long	l_l_data

if f_get_value ( GetItemNumber ( 1, i_s_key_column ) ) <= 0 then
	
	i_b_new = TRUE
	
	l_l_data = of_getnextvalue ( i_s_key_table, i_s_key_column )

	SetItem ( 1, i_s_key_column, l_l_data )
	
else
	
	i_b_new = FALSE
	
end if

return 0
end event

event dberror;return 1
end event

