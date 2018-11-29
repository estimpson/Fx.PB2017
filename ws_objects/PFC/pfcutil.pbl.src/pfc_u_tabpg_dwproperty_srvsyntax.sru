$PBExportHeader$pfc_u_tabpg_dwproperty_srvsyntax.sru
$PBExportComments$PFC DataWindow Property - The Syntax tabpage
forward
global type pfc_u_tabpg_dwproperty_srvsyntax from u_tabpg_dwproperty_base
end type
type mle_syntax from u_mle within pfc_u_tabpg_dwproperty_srvsyntax
end type
type cb_save from u_cb within pfc_u_tabpg_dwproperty_srvsyntax
end type
end forward

global type pfc_u_tabpg_dwproperty_srvsyntax from u_tabpg_dwproperty_base
event type integer pfc_propertypopulate ( )
mle_syntax mle_syntax
cb_save cb_save
end type
global pfc_u_tabpg_dwproperty_srvsyntax pfc_u_tabpg_dwproperty_srvsyntax

type variables
Protected:
integer	ii_style = -1
string	is_endtext = '~r~n'
end variables

forward prototypes
public function integer of_setsyntax (string as_syntax)
public function string of_getsyntax ()
public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib)
public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib)
end prototypes

public function integer of_setsyntax (string as_syntax);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetSyntax
//
//	Access:   		Public
//
//	Arguments:
//	as_syntax		The syntax to be put on the mle.
//
//	Returns:  		Integer
//	 1 success
//	-1 error
//
//	Description:  
//	 Sets the Syntax on the mle.
//
//	Note:
//	The is_endtext instance variable is used
//	to append to the text.  If nothing is desired
//	just blank out the variable on the constructor event.
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

mle_syntax.Text = as_syntax + is_endtext
Return 1

end function

public function string of_getsyntax ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetSyntax
//
//	Access:   		Public
//
//	Arguments:	None
//
//	Returns:  		String
//	 The Syntax currently found on the mle.
//
//	Description:  
//	 Gets the Syntax currently found on the mle.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return mle_syntax.Text

end function

public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_infoattrib	(By reference) The Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Object Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Populate Information.
anv_infoattrib.is_name = 'DW Property Syntax Tab'
anv_infoattrib.is_description = 'DW Property Syntax Tab'

Return 1
end function

public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetPropertyInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_attrib	(By ref.) The Property Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Service Property Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_infoattrib lnv_infoattrib

// Get the first two attributes from the Main Information attributes.
of_GetInfo(lnv_infoattrib)
anv_attrib.is_name = lnv_infoattrib.is_name
anv_attrib.is_description = lnv_infoattrib.is_description

// The Property Tab Text.
anv_attrib.is_propertytabtext ='Syntax'

Return 1
end function

on pfc_u_tabpg_dwproperty_srvsyntax.create
int iCurrent
call u_tabpg_dwproperty_base::create
this.mle_syntax=create mle_syntax
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=mle_syntax
this.Control[iCurrent+2]=cb_save
end on

on pfc_u_tabpg_dwproperty_srvsyntax.destroy
call u_tabpg_dwproperty_base::destroy
destroy(this.mle_syntax)
destroy(this.cb_save)
end on

type mle_syntax from u_mle within pfc_u_tabpg_dwproperty_srvsyntax
int X=18
int Y=36
int Width=1257
int Height=812
int TabOrder=10
boolean HScrollBar=true
boolean VScrollBar=true
boolean DisplayOnly=true
end type

type cb_save from u_cb within pfc_u_tabpg_dwproperty_srvsyntax
int X=928
int Y=880
int TabOrder=20
string Text="&Save"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Arguments:  None
//
//	Returns: None
//
//	Description:
//	 Saves the current text to a file.
//	 Opens the GetFileSaveName dialog window, gets a filename, and allows 
//	 for the saving of text to the file.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant string TITLE='Save PowerScript File'
string	ls_path_filename
string	ls_filename
string	ls_text
integer	li_rc
integer	li_filenumber

SetPointer(HourGlass!)

//Get the filename
li_rc = GetFileSaveName  (TITLE, ls_path_filename, ls_filename, & 
				'TXT', 'Text Files (*.TXT), *.TXT' )

If li_rc > 0 Then
	
	If FileExists (ls_path_filename) Then
		//Existing file has been found
		If of_MessageBox ('pfc_dwpropertysyntax_replacefile', TITLE, &
			'Replace existing file '+ls_path_filename, &
			Question!, YesNo!, 1) = 2 Then
			//Do not replace the file
			Return 1
		End If
	End If
	
	//Write the history to the file
	SetPointer (HourGlass!)
	li_filenumber = FileOpen(ls_path_filename, StreamMode!, Write!, LockWrite!, Replace!)
	If li_filenumber > 0 Then
		ls_text = mle_syntax.Text
		FileWrite (li_filenumber, ls_text)	
		FileClose (li_filenumber)
	End If
	
End If

Return li_rc

end event

