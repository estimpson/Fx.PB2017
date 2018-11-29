$PBExportHeader$u_popup.sru
forward
global type u_popup from listbox
end type
end forward

global type u_popup from listbox
int Width=974
int Height=200
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean Sorted=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"      Print",&
"      Demand Supply Screen",&
"      Demand Supply (Buckets) Screen"}
end type
global u_popup u_popup

event selectionchanged;choose case index	
		
	case 1
		
		parent.triggerevent ( 'ue_print' )

	case 2 

		parent.triggerevent ( 'ue_popup_one' )

	case 3

		parent.triggerevent ( 'ue_popup_two' )
	
	case else
	
		parent.triggerevent ( 'ue_popup_three' )

end choose
		
end event

