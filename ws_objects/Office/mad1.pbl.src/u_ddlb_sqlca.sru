$PBExportHeader$u_ddlb_sqlca.sru
$PBExportComments$New object to get the profiles in the ini file.
forward
global type u_ddlb_sqlca from dropdownlistbox
end type
end forward

global type u_ddlb_sqlca from dropdownlistbox
int Width=787
int Height=405
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_ddlb_sqlca u_ddlb_sqlca

forward prototypes
public subroutine wf_setup ()
end prototypes

public subroutine wf_setup ();String s_profile, &
       s_Current

Long l_len, &
     l_position, &
     l_start, &
     l_next, &
     l_word_len

Long  a

s_Profile = ProfileString("c:\pb4\PB.INI", "DBMS_PROFILES", "PROFILES", "none")

l_len = LenA (s_profile)

l_position = PosA (s_profile, ',', 1)
l_word_len = l_position - 2
s_Current = MidA ( s_profile, 1, l_word_len )
this.AddItem(s_current)
l_start = l_position - 1
l_next  = l_start

Do while ( l_start > 0 )

    l_next = PosA (s_profile, "','" , l_start + 1)
    l_word_len   = ( l_next - (l_start + 3) )  
    s_Current = MidA ( s_profile, (l_start + 3), l_word_len )
    this.AddItem(s_current)
    If l_word_len < 0 Then
		this.AddItem( RightA(s_profile, (l_len - (l_start + 2))))
      l_start = -1
	 Else
      l_start = l_next
    End If
 
Loop

this.text = SQLCA.database


end subroutine

on constructor;wf_setup()
end on

