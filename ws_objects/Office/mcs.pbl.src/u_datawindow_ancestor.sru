$PBExportHeader$u_datawindow_ancestor.sru
forward
global type u_datawindow_ancestor from datawindow
end type
end forward

global type u_datawindow_ancestor from datawindow
int Width=494
int Height=361
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
event ue_change_color ( string a_s_column,  any a_a_value,  long a_l_color_greater,  long a_l_color_equal,  long a_l_color_less,  string a_s_mode,  boolean a_b_allcolumns )
end type
global u_datawindow_ancestor u_datawindow_ancestor

event ue_change_color;string	l_s_modstring,&
			l_s_return
int		l_i_count

if a_b_allcolumns then

	For l_i_count = 1 to Integer ( Object.Datawindow.Column.Count )

		Choose Case lower ( a_s_mode )
			Case "background"
				Modify ( "#" + String ( l_i_count ) + ".Background.Mode='0'" )
				l_s_modstring = "#" + String ( l_i_count ) + ".Background.Color='0~~t"
			Case "foreground"
				l_s_modstring = "#" + String ( l_i_count ) + ".Color='0~~t"
			Case Else
				return
		End Choose
		
		Choose Case ClassName ( a_a_value )
			Case "string","char"
				l_s_modstring += &
					"if(" + a_s_column + " > ~"" + String ( a_a_value ) + "~"," + String ( a_l_color_greater ) + &
					",if( " + a_s_column + " = ~"" + String ( a_a_value ) + "~"," + String ( a_l_color_equal ) + "," + &
					String ( a_l_color_less ) + " ) )'"
			Case "date"
				l_s_modstring += &
					"if(" + a_s_column + " > date(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
					",if( " + a_s_column + " = date(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
					String ( a_l_color_less ) + " ) )'"
			Case "datetime"
				l_s_modstring += &
					"if(" + a_s_column + " > datetime(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
					",if( " + a_s_column + " = datetime(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
					String ( a_l_color_less ) + " ) )'"
			Case "time"
				l_s_modstring += &
					"if(" + a_s_column + " > time(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
					",if( " + a_s_column + " = time(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
					String ( a_l_color_less ) + " ) )'"
			Case else
				l_s_modstring += &
					"if(" + a_s_column + " > " + String ( a_a_value ) + "," + String ( a_l_color_greater ) + &
					",if( " + a_s_column + " = " + String ( a_a_value ) + "," + String ( a_l_color_equal ) + "," + &
					String ( a_l_color_less ) + " ) )'"
		End Choose

		Modify ( l_s_modstring )
		
	Next

else

	Choose Case lower ( a_s_mode )
		Case "background"
			Modify ( a_s_column + ".Background.Mode='0'" )
			l_s_modstring = a_s_column + ".Background.Color='0~~t"
		Case "foreground"
			l_s_modstring = a_s_column + ".Color='0~~t"
		Case Else
			return
	End Choose
	
	Choose Case ClassName ( a_a_value )
		Case "string","char"
			l_s_modstring += &
				"if(" + a_s_column + " > ~"" + String ( a_a_value ) + "~"," + String ( a_l_color_greater ) + &
				",if( " + a_s_column + " = ~"" + String ( a_a_value ) + "~"," + String ( a_l_color_equal ) + "," + &
				String ( a_l_color_less ) + " ) )'"
		Case "date"
			l_s_modstring += &
				"if(" + a_s_column + " > date(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
				",if( " + a_s_column + " = date(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
				String ( a_l_color_less ) + " ) )'"
		Case "datetime"
			l_s_modstring += &
				"if(" + a_s_column + " > datetime(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
				",if( " + a_s_column + " = datetime(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
				String ( a_l_color_less ) + " ) )'"
		Case "time"
			l_s_modstring += &
				"if(" + a_s_column + " > time(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_greater ) + &
				",if( " + a_s_column + " = time(~"" + String ( a_a_value ) + "~")," + String ( a_l_color_equal ) + "," + &
				String ( a_l_color_less ) + " ) )'"
		Case else
			l_s_modstring += &
				"if(" + a_s_column + " > " + String ( a_a_value ) + "," + String ( a_l_color_greater ) + &
				",if( " + a_s_column + " = " + String ( a_a_value ) + "," + String ( a_l_color_equal ) + "," + &
				String ( a_l_color_less ) + " ) )'"
	End Choose

	Modify ( l_s_modstring )

end if
end event

