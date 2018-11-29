$PBExportHeader$w_bom_edit_add.srw
forward
global type w_bom_edit_add from window
end type
type cb_2 from commandbutton within w_bom_edit_add
end type
type cb_1 from commandbutton within w_bom_edit_add
end type
type dw_1 from datawindow within w_bom_edit_add
end type
end forward

global type w_bom_edit_add from window
integer x = 832
integer y = 360
integer width = 2706
integer height = 1448
boolean titlebar = true
string title = "BOM Entry"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 78682240
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_bom_edit_add w_bom_edit_add

type variables
Pointer		i_p_oldpointer
DateTime		i_dt_end_datetime
BOOLEAN	i_b_add

end variables

on w_bom_edit_add.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_bom_edit_add.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;date						l_d_temp
time						l_t_temp
datetime					l_dt_datetime
st_generic_structure	l_str_parm
String               l_s_eng_level						

l_str_parm = Message.PowerObjectParm

l_d_temp = Date ( LeftA ( l_str_parm.value3, PosA ( l_str_parm.value3, " " ) - 1 ) )
l_t_temp	= Time ( RightA ( l_str_parm.value3, LenA ( l_str_parm.value3 ) - PosA ( l_str_parm.value3, " " ) ) )

l_dt_datetime = DateTime ( l_d_temp, l_t_temp )

Select engineering_level
into :l_s_eng_level
from effective_change_notice
where part = :l_str_parm.value2
and effective_date = (select max(effective_date)
from effective_change_notice
where part = :l_str_parm.value2
and effective_date <=  GetDate());

//	Retrieve unit list for this part.
datawindowchild	unitDWC
if	dw_1.GetChild("unit_measure", unitDWC) = 1 then
	unitDWC.SetTransObject(SQLCA)
	if	unitDWC.Retrieve(l_str_parm.value2) = 0 then
		unitDWC.InsertRow(0)
	end if
end if	

IF IsNull ( l_str_parm.value10, '' ) <> 'Add' THEN
	IF dw_1.Retrieve ( l_str_parm.value1, l_str_parm.value2, l_dt_datetime ) > 0 THEN
		datetime rightNow
		
		select
			dt.RightNow
		into
			:rightNow
		from
			(	select
					RightNow = getdate()
			) dt  ;
		
		dw_1.SetItem ( 1, "engineering_level", l_s_eng_level )
		if	dw_1.GetItemDateTime(1, "end_datetime") < rightNow then
			MessageBox ( Title, "You will only be able to view this component since historical records can not be changed!", Information! )
		end if
	ELSE
		CloseWithReturn ( This, 0 )
	END IF
ELSE
	i_b_add = TRUE
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "parent_part", l_str_parm.value1 )
	dw_1.SetItem ( 1, "part", l_str_parm.value2 )
	dw_1.SetItem ( 1, "start_datetime", DateTime ( Today ( ), Time ( String ( Now ( ), "hh:mm:ss" ) ) ) )
	dw_1.SetItem ( 1, "substitute_part", "N" )
	dw_1.SetItemStatus ( 1, "start_datetime", Primary!, NotModified! )
	dw_1.SetItem ( 1, "engineering_level", l_s_eng_level )
END IF
end event

type cb_2 from commandbutton within w_bom_edit_add
integer x = 2322
integer y = 1184
integer width = 279
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_bom_edit_add
integer x = 1993
integer y = 1184
integer width = 274
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Ok"
boolean default = true
end type

event clicked;STRING	l_s_operator,&
			l_s_message


//dw_1.AcceptText()
IF dw_1.ModifiedCount ( ) > 0 THEN
	
//	Open ( w_generic_operator_entry )
//	l_s_operator = Message.StringParm
//	
//	IF l_s_operator > '' THEN
		dw_1.SetItem ( 1, "date_changed", DateTime ( Today ( ), Now ( ) ) )
//		dw_1.object.operator[1] = l_s_operator
		
		IF i_b_add AND &
			dw_1.GetItemStatus ( 1, "start_datetime", Primary! ) = NotModified! THEN
			dw_1.SetItem ( 1, "start_datetime", "1980/01/01 00:00:00" )
		END IF
		
//		dw_1.AcceptText ( )
		
		IF dw_1.Update ( ) = -1 THEN
			l_s_message = sqlca.sqlerrtext
			rollback;
			MessageBox ( Parent.Title, "Unable to save component!  Reason: " + l_s_message, StopSign! )
			return
		ELSE
			commit;
		END IF
//	END IF
	
END IF

CloseWithReturn ( Parent, 1 )

end event

type dw_1 from datawindow within w_bom_edit_add
event ue_key_pressed pbm_dwnkey
integer y = 16
integer width = 2651
integer height = 1152
integer taborder = 10
string dataobject = "d_bom_setup"
boolean border = false
boolean livescroll = true
end type

event ue_key_pressed;//work around to pb5.0.02 and earlier - cannot use delete key to set date mask to null

string ls_coltype, ls_colname
datetime ldt_null

setnull(ldt_null)

// if delete key pressed in a datetime field then set field to null.
ls_colname = this.getcolumnname()

ls_coltype = this.describe(ls_colname + ".coltype")
IF ls_coltype = "datetime" AND keydown(KeyDelete!) THEN
	this.setitem(1,ls_colname,ldt_null)
END IF

end event

event clicked;//str_part_revision lstr_part_revision
//
//IF dwo.name = 'start_datetime' OR dwo.name = 'engineering_level' THEN
//	openwithparm(w_part_revision, getitemstring(row,1))
//	lstr_part_revision = message.powerobjectparm
//	if not isnull(lstr_part_revision.engineering_level) then
//		setitem(row, 'start_datetime', lstr_part_revision.effective_datetime)
//		setitem(row, 'engineering_level' , lstr_part_revision.engineering_level)
//	end if
//END IF
//
end event

event doubleclicked;string ls_colname
datetime ld_caldatetime

ls_colname = this.getcolumnname()

if ls_colname = 'start_datetime' or ls_colname = 'end_datetime' then
	openwithparm(w_calendar_responce,string(date(this.getitemdatetime(1,ls_colname))))
	ld_caldatetime = datetime(date(message.stringparm))
	this.setitem(1,ls_colname,ld_caldatetime)
end if

end event

event constructor;SetTransObject ( sqlca )
end event

event dberror;return 1

end event

