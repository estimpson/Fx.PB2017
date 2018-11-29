$PBExportHeader$w_destination_edi.srw
forward
global type w_destination_edi from w_sheet_4t
end type
type dw_1 from datawindow within w_destination_edi
end type
end forward

global type w_destination_edi from w_sheet_4t
integer width = 3854
integer height = 1672
string title = "Destination EDI [w_destination_edi]"
string menuname = "m_destination_edi"
event save_item pbm_custom01
dw_1 dw_1
end type
global w_destination_edi w_destination_edi

type variables
st_generic_structure stparm

Boolean  bitemchanged = False
end variables

on save_item;If dw_1.Update () = -1 Then 
	RollBack ;
Else
	Commit ;
	bitemchanged = FALSE
End If
end on

event closequery;call super::closequery;Int iRtnCode

If bitemchanged Then

	iRtnCode = messagebox( 'Warning', 'Do you want to save the changes?', &
						Exclamation!, YesNoCancel! , 3 )

	CHOOSE Case iRtnCode 

     Case 1
			w_destination_edi.TriggerEvent( "save_item" )

	  Case 2
			close(this)

     Case 3
		   Message.Returnvalue = 1         

     End Choose

End If
end event

event open;call super::open;String szDestination

szDestination = Message.StringParm

dw_1.Reset()


If dw_1.Retrieve ( szDestination ) < 1 Then
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "destination", szDestination )
	dw_1.SetItem ( 1, "release_flag", '' )
End If 

dw_1.SetFocus()

end event

on w_destination_edi.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_destination_edi" then this.MenuID = create m_destination_edi
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_destination_edi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_destination_edi
integer width = 3698
integer height = 1304
integer taborder = 10
string dataobject = "d_destination_edi"
boolean border = false
end type

on editchanged;bitemchanged = True
end on

event itemchanged;String	ls_data


bitemchanged = True

choose case dwo.name
		
	case 'auto_create_asn' 
		if data = 'N' then
			ls_data = data
			setnull(ls_data)
			
			setitem(row,'asn_overlay_group',ls_data)      
		end if
		
	case 'pool_flag' 
	    if data = 'N' then
			ls_data = data
			setnull(ls_data)
			
			setitem (row, 'pool_code', ls_data)
		end if
		
end choose
end event

event constructor;SetTransObject ( sqlca )
end event

