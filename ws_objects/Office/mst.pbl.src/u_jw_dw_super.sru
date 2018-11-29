$PBExportHeader$u_jw_dw_super.sru
$PBExportComments$The ancestor datawindow for jw's frame work.
forward
global type u_jw_dw_super from datawindow
end type
end forward

global type u_jw_dw_super from datawindow
int Width=494
int Height=361
int TabOrder=1
boolean LiveScroll=true
event ue_delete pbm_custom01
event ue_insert pbm_custom02
event ue_save pbm_custom03
event ue_find pbm_custom04
event ue_initialize pbm_custom05
end type
global u_jw_dw_super u_jw_dw_super

forward prototypes
public function boolean uf_save ()
public function boolean uf_initialize ()
public function boolean uf_delete (long al_row)
public function boolean uf_insert ()
public function boolean uf_ok_to_insert ()
public function string uf_clicked_value (string as_columnname)
public function long uf_row_clicked (integer ai_highlight_mode)
public function boolean uf_ok_to_delete (long al_row)
public function string uf_current_row_value (string as_columnname)
end prototypes

on ue_delete;/*
Description	:	To delete a row.
Author		:	Jim Wu
Start Date	:	02/15/96
Modification:
*/

/* Declaration */
Long	ll_row

/* Initialization */
ll_row	= this.GetRow()					//Assume the current row number

/* Main Process */
If this.uf_ok_to_delete(ll_row) then
	this.uf_delete(ll_row)
End If
end on

on ue_insert;/* JW Framework Copyright 1996 */

If uf_ok_to_insert() then
	uf_insert()
End If


end on

on ue_save;/* JW Framework Copyright 1996 */

uf_save()
end on

on ue_initialize;/*
Description	:	To initialize the datawindow.
Author		:	Jim Wu
Start Date	:	02/15/96
Modification:	
*/


/* Declaratiion */

/* Initialization */

/* Main Process */
this.uf_initialize()



end on

public function boolean uf_save ();/* Ancestor function for jw frame work */

If  (this.Update() > 0) then
	COMMIT;
	Return TRUE
Else
	Return FALSE
End If 


end function

public function boolean uf_initialize ();/* Ancestor function */



Return TRUE
end function

public function boolean uf_delete (long al_row);/* Ancestor function */

long	ll_row, &
		ll_total

if al_row > 0 then
	this.deleterow(al_row)
else
	ll_total	= this.rowcount()
	for ll_row = ll_total to 1 step -1
		this.deleterow(al_row)
	next
end if

Return this.uf_save()

end function

public function boolean uf_insert ();/* Ancestor function */

this.InsertRow(1)
this.ScrollToRow(1)
this.SetFocus()

Return TRUE


end function

public function boolean uf_ok_to_insert ();/* Ancestor function */

Return TRUE
end function

public function string uf_clicked_value (string as_columnname);/* JW Framework Copyright 1996 */

long		ll_row
string	ls_col_type, &
			ls_return

ll_row	= this.getclickedrow()
if ll_row > 0 then
	
	ls_col_type	= LeftA(this.describe( as_columnname + '.coltype' ), 5)
	
	choose case	ls_col_type
		case 'char('
			ls_return	= this.getitemstring(ll_row, as_columnname)

		case 'date'
			ls_return	= string( this.getitemdate(ll_row, as_columnname) )

		case 'numbe'
			ls_return	= string( &
							  this.getitemnumber(ll_row, as_columnname) )

		case 'datet'
			ls_return	= string( &
							  this.getitemdatetime(ll_row, as_columnname) )

		case 'decim'
			ls_return	= string( &
							  this.getitemnumber(ll_row, as_columnname) )

		case 'time'
			ls_return	= string( &
							  this.getitemtime(ll_row, as_columnname) )

		case 'times'
			ls_return	= string( &
							  this.getitemtime(ll_row, as_columnname) )

		case else
			setnull( ls_return )

	end choose

else

	setnull( ls_return )

end if

return ls_return
end function

public function long uf_row_clicked (integer ai_highlight_mode);/* JW Framework Copyright 1996 */

long ll_row

ll_row	= this.getclickedrow()

if ll_row > 0 then
	if ai_highlight_mode = 1 then
		this.selectrow( 0, FALSE )
		this.selectrow( ll_row, TRUE )
	else
		if ai_highlight_mode = 2 then
			this.selectrow( ll_row, Not this.IsSelected(ll_row) )
		end if
	end if
end if

return	ll_row
end function

public function boolean uf_ok_to_delete (long al_row);/* JW frame work, Copyright 1996 */

return TRUE
end function

public function string uf_current_row_value (string as_columnname);/* JW Framework Copyright 1996 */

long		ll_row
string	ls_col_type, &
			ls_return

ll_row	= this.getrow()
if ll_row > 0 then
	
	ls_col_type	= LeftA(this.describe( as_columnname + '.coltype' ), 5)
	
	choose case	ls_col_type
		case 'char('
			ls_return	= this.getitemstring(ll_row, as_columnname)

		case 'date'
			ls_return	= string( this.getitemdate(ll_row, as_columnname) )

		case 'numbe'
			ls_return	= string( &
							  this.getitemnumber(ll_row, as_columnname) )

		case 'datet'
			ls_return	= string( &
							  this.getitemdatetime(ll_row, as_columnname) )

		case 'decim'
			ls_return	= string( &
							  this.getitemnumber(ll_row, as_columnname) )

		case 'time'
			ls_return	= string( &
							  this.getitemtime(ll_row, as_columnname) )

		case 'times'
			ls_return	= string( &
							  this.getitemtime(ll_row, as_columnname) )

		case else
			setnull( ls_return )

	end choose

else

	setnull( ls_return )

end if

return ls_return
end function

on constructor;/*
Description	:	To initialize the datawindow (Set Transobject and etc.)
Author		:	Jim Wu
Start Date	:	02/15/96
Modification:
*/


/* Declaratiion */

/* Initializatiion */

/* Modificatiion */
this.SetTransObject(SQLCA)
this.TriggerEvent("ue_initialize")

end on

on clicked;/* JW Framework Copyright 1996 */

this.uf_row_clicked(1)
end on

on dberror;/* Ancestor function */

ROLLBACK;
end on

on itemerror;/* Ancestor */

ROLLBACK;

end on

