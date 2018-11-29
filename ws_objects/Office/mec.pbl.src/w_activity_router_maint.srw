$PBExportHeader$w_activity_router_maint.srw
forward
global type w_activity_router_maint from Window
end type
type cb_2 from commandbutton within w_activity_router_maint
end type
type cb_1 from commandbutton within w_activity_router_maint
end type
type dw_1 from datawindow within w_activity_router_maint
end type
end forward

global type w_activity_router_maint from Window
int X=1074
int Y=484
int Width=2066
int Height=848
boolean TitleBar=true
string Title="Activity Maintenance"
long BackColor=79741120
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_activity_router_maint w_activity_router_maint

type variables
STRING		i_s_activity_type,&
		i_s_activity
end variables

on w_activity_router_maint.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_activity_router_maint.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;st_generic_structure	l_str_parm

l_str_parm = Message.PowerObjectParm

IF l_str_parm.value10 = 'Add' THEN
	dw_1.InsertRow ( 1 )
	dw_1.SetItem ( 1, "parent_part", l_str_parm.value2 )
	dw_1.SetItem ( 1, "part", l_str_parm.value2 )
	dw_1.SetItem ( 1, "code", l_str_parm.value3 )
	dw_1.SetItem ( 1, "sequence", 1 )
ELSE
	dw_1.Retrieve ( l_str_parm.value2, l_str_parm.value2 )
END IF
end event

type cb_2 from commandbutton within w_activity_router_maint
int X=1719
int Y=592
int Width=293
int Height=128
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn ( Parent, 0 )
end event

type cb_1 from commandbutton within w_activity_router_maint
int X=1390
int Y=592
int Width=293
int Height=128
int TabOrder=20
string Text="&Ok"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;STRING	l_s_part,&
			l_s_machine,&
			l_s_activity,&
			l_s_activity_type,&
			l_s_message
INT		l_i_count

IF dw_1.Update ( ) = 1 THEN
	l_s_activity	= dw_1.object.code[1]
	l_s_part	= dw_1.object.part[1]
	
	UPDATE	activity_router
	SET 	code = :l_s_activity  
	WHERE 	activity_router.part = :l_s_part   ;
	
	IF sqlca.sqlcode = -1 THEN
		Rollback;
		MessageBox ( "Router Maintenance", "Unable to update activities for part " + l_s_part + "  Reason: " + l_s_message, StopSign! )
		return
	END IF
	
	IF isnull(i_s_activity_type,'') > '' THEN
		select 	flow_route_window  
		into	:l_s_activity_type  
		from	activity_codes  
		where	code = :l_s_activity   ;

		IF i_s_activity_type <> l_s_activity_type THEN
			DELETE FROM	part_machine_tool
			WHERE		part = :l_s_part AND
					machine	in ( select machine from part_machine where part = :l_s_part AND activity = :i_s_activity ) ;
			IF sqlca.sqlcode = -1 THEN
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete Tool.  Reason: " + l_s_message, StopSign! )
				return
			END IF

			DELETE FROM part_machine
			WHERE part = :l_s_part AND
			      activity = :i_s_activity ;
			IF sqlca.sqlcode = -1 THEN
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to delete machine / vendor.  Reason: " + l_s_message, StopSign! )
				return
			END IF
		ELSE
			UPDATE	part_machine 
			SET	activity = :l_s_activity
			WHERE	part = :l_s_part ;
//				AND activity = :i_s_activity ; // REMOVED it as this condition is not required.

			IF sqlca.sqlcode = -1 THEN
				l_s_message = sqlca.sqlerrtext
				Rollback;
				MessageBox ( "Router Maintenance", "Unable to update machine / vendor.  Reason: " + l_s_message, StopSign! )
				return
			END IF
		END IF
	ELSE
		UPDATE	part_machine 
		SET		activity = :l_s_activity
		WHERE		part = :l_s_part ;
//					and activity = :i_s_activity ; // REMOVED it as this condition is not required.
		IF sqlca.sqlcode = -1 THEN
			l_s_message = sqlca.sqlerrtext
			Rollback;
			MessageBox ( "Router Maintenance", "Unable to update machine / vendor.  Reason: " + l_s_message, StopSign! )
			return
		END IF
	END IF
	Commit;
	CloseWithReturn ( Parent, 1 )
ELSE
	Rollback;
	MessageBox ( Parent.Title, "Unable to save activity!", StopSign! )
END IF
end event

type dw_1 from datawindow within w_activity_router_maint
int X=18
int Y=16
int Width=2011
int Height=544
int TabOrder=10
string DataObject="d_activity_router_new"
boolean Border=false
boolean LiveScroll=true
end type

event constructor;SetTransObject ( sqlca )

end event

event retrieveend;IF RowCount ( ) > 0 THEN
	i_s_activity		= object.code[1]
	i_s_activity_type = object.flow_route_window[1]
END IF
end event

