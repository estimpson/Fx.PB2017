$PBExportHeader$u_alt_part_choice.sru
$PBExportComments$Gives the user a choice of alternate parts.
forward
global type u_alt_part_choice from UserObject
end type
type cb_5 from commandbutton within u_alt_part_choice
end type
type cb_4 from commandbutton within u_alt_part_choice
end type
type cb_3 from commandbutton within u_alt_part_choice
end type
type cb_2 from commandbutton within u_alt_part_choice
end type
type cb_1 from commandbutton within u_alt_part_choice
end type
end forward

global type u_alt_part_choice from UserObject
int Width=2204
int Height=1057
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global u_alt_part_choice u_alt_part_choice

type variables
string		i_s_chosen_part
end variables

forward prototypes
public subroutine uf_wait_for_response ()
public function string uf_init (window a_w_parent, ref datawindow a_dw_pallets, string a_s_part)
end prototypes

public subroutine uf_wait_for_response ();Do While i_s_chosen_part = ""
	Yield ( )
Loop
end subroutine

public function string uf_init (window a_w_parent, ref datawindow a_dw_pallets, string a_s_part);int		l_i_count,&
			l_i_alts,&
			l_i_row
boolean	l_b_done
string	l_s_alt,&
			l_s_pallet

x = ( a_w_parent.Width - Width ) / 2
y = ( a_w_parent.Height - Height ) / 2

DECLARE alts CURSOR FOR
SELECT 	alt_part
FROM		alternative_parts
WHERE		main_part = :a_s_part ;

l_s_pallet = ""
l_i_row = a_dw_pallets.Find ( "part = '" + a_s_part + "'", 1, a_dw_pallets.RowCount ( ) )
if l_i_row > 0 then
	if a_dw_pallets.GetItemString ( l_i_row, "part" ) = a_s_part then
		l_s_pallet = " (Pallet-" + String ( a_dw_pallets.GetItemNumber ( l_i_row, "pallet_number" ) ) + ")"
	end if
end if
cb_1.Text = a_s_part + l_s_pallet
cb_1.Tag = a_s_part
cb_1.Show ( )

Open alts ;
Do While Not l_b_done
	l_i_count++
	if l_i_count < 4 then
		l_s_pallet = ""
		Fetch alts into :l_s_alt ;
		if sqlca.sqlcode = 0 then
			l_i_row = a_dw_pallets.Find ( "part = '" + l_s_alt + "'", 1, a_dw_pallets.RowCount ( ) )
			if l_i_row > 0 then
				if a_dw_pallets.GetItemString ( l_i_row, "part" ) = l_s_alt then
					l_s_pallet = " (Pallet-" + String ( a_dw_pallets.GetItemNumber ( l_i_row, "pallet_number" ) ) + ")"
				end if
			end if
			Choose Case l_i_count
			Case 1
				cb_2.Tag = l_s_alt
				cb_2.Text = cb_2.Tag + l_s_pallet
				cb_2.Show ( )
			Case 2
				cb_3.Tag = l_s_alt
				cb_3.Text = cb_2.Tag + l_s_pallet
				cb_3.Show ( )
			Case 3
				cb_4.Tag = l_s_alt
				cb_4.Text = cb_2.Tag + l_s_pallet
				cb_4.Show ( )
			End Choose
		else
			l_b_done = TRUE
		end if
	else
		l_b_done = TRUE
	end if
Loop
Close alts ;





//l_i_alts = 
//
//if l_i_alts > 4 then l_i_alts = 4
//
//for l_i_count = 1 to l_i_alts
//	Choose Case l_i_count
//	Case 1
//		cb_1.Text = a_dw_pallets.GetItemString ( l_i_count, "part" ) + &
//			" (Pallet-" + string ( a_dw_pallets.GetItemNumber ( l_i_count, "pallet_number" ) ) + ")"
//		cb_1.Tag = a_dw_pallets.GetItemString ( l_i_count, "part" )
//		cb_1.Show ( )
//	Case 2
//		cb_2.Text = a_dw_pallets.GetItemString ( l_i_count, "part" ) + &
//			" (Pallet-" + string ( a_dw_pallets.GetItemNumber ( l_i_count, "pallet_number" ) ) + ")"
//		cb_2.Tag = a_dw_pallets.GetItemString ( l_i_count, "part" )
//		cb_2.Show ( )
//	Case 3
//		cb_3.Text = a_dw_pallets.GetItemString ( l_i_count, "part" ) + &
//			" (Pallet-" + string ( a_dw_pallets.GetItemNumber ( l_i_count, "pallet_number" ) ) + ")"
//		cb_3.Tag = a_dw_pallets.GetItemString ( l_i_count, "part" )
//		cb_3.Show ( )
//	Case 4
//		cb_4.Text = a_dw_pallets.GetItemString ( l_i_count, "part" ) + &
//			" (Pallet-" + string ( a_dw_pallets.GetItemNumber ( l_i_count, "pallet_number" ) ) + ")"
//		cb_4.Tag = a_dw_pallets.GetItemString ( l_i_count, "part" )
//		cb_4.Show ( )
//	End choose
//next

uf_wait_for_response ( )
return i_s_chosen_part
end function

on u_alt_part_choice.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on u_alt_part_choice.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_5 from commandbutton within u_alt_part_choice
int X=19
int Y=849
int Width=2158
int Height=193
int TabOrder=50
string Text="&Cancel"
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_s_chosen_part = "cancel_button"
end on

type cb_4 from commandbutton within u_alt_part_choice
int X=19
int Y=641
int Width=2158
int Height=193
int TabOrder=40
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_s_chosen_part = Tag
end on

type cb_3 from commandbutton within u_alt_part_choice
int X=19
int Y=433
int Width=2158
int Height=193
int TabOrder=30
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_s_chosen_part = Tag
end on

type cb_2 from commandbutton within u_alt_part_choice
int X=19
int Y=225
int Width=2158
int Height=193
int TabOrder=20
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_s_chosen_part = Tag
end on

type cb_1 from commandbutton within u_alt_part_choice
int X=19
int Y=17
int Width=2158
int Height=193
int TabOrder=10
boolean Visible=false
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;i_s_chosen_part = Tag
end on

