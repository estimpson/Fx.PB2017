$PBExportHeader$u_upgrade_forms_labels_forms.sru
forward
global type u_upgrade_forms_labels_forms from u_wizard_ancestor
end type
type st_1 from statictext within u_upgrade_forms_labels_forms
end type
type p_1 from picture within u_upgrade_forms_labels_forms
end type
type p_2 from picture within u_upgrade_forms_labels_forms
end type
type st_list from statictext within u_upgrade_forms_labels_forms
end type
type st_used from statictext within u_upgrade_forms_labels_forms
end type
type p_3 from picture within u_upgrade_forms_labels_forms
end type
type lb_list_of_forms from ulb_smart_drag_drop within u_upgrade_forms_labels_forms
end type
type lb_used_forms from ulb_smart_drag_drop within u_upgrade_forms_labels_forms
end type
end forward

global type u_upgrade_forms_labels_forms from u_wizard_ancestor
int Width=1984
event ue_save pbm_custom03
st_1 st_1
p_1 p_1
p_2 p_2
st_list st_list
st_used st_used
p_3 p_3
lb_list_of_forms lb_list_of_forms
lb_used_forms lb_used_forms
end type
global u_upgrade_forms_labels_forms u_upgrade_forms_labels_forms

type variables
BOOLEAN	i_b_painted
String                       i_s_forms[]
end variables

forward prototypes
public function integer uof_paint_data ()
public function boolean uf_validate (string a_s_value)
end prototypes

event ue_save;call super::ue_save;INTEGER l_i_forms

STRING  l_s_report

FOR l_i_forms = 1 TO lb_used_forms.totalitems() 

	i_s_forms[l_i_forms] =  lb_used_forms.text(l_i_forms)

	SELECT report
	INTO	 :l_s_report
	FROM   report_list
	WHERE  report = :i_s_forms[l_i_forms] ;
	
	IF SQLCA.SQLCODE <> 0 THEN
		INSERT INTO report_list 
		( report, description ) 
		VALUES ( :i_s_forms[l_i_forms], :i_s_forms[l_i_forms] ) ;	
	END IF	
	
	INSERT INTO report_library 
	SELECT form_name, form_name, 'C', data_window_name, 'mfm.pbd', 'Y', 'Y',' ', 1 
	FROM   forms 
	WHERE  form_name = :i_s_forms[l_i_forms] ;

	IF SQLCA.SQLCODE <> 0 THEN
		Messagebox ( monsys.msg_title, 'Unable to save the forms list.' + sqlca.sqlerrtext, Information! )
		ROLLBACK ;
	ELSE
      COMMIT ;
	END IF 

NEXT


end event

public function integer uof_paint_data ();STRING	l_s_form_name

IF i_b_painted THEN
	IF lb_used_forms.TotalItems ( ) > 0 THEN
		w_upgrade_forms_labels.wf_enable_next ( TRUE )
	ELSE
		w_upgrade_forms_labels.wf_enable_next ( TRUE )
	END IF
ELSE
	i_b_painted = TRUE

	 DECLARE get_forms CURSOR FOR  
	  SELECT DISTINCT form_name
	    FROM forms
	   WHERE data_window_name > ''
	ORDER BY form_name
	   USING SQLCA  ;

	    OPEN get_forms  ;

	   FETCH get_forms
	    INTO :l_s_form_name  ;

	DO WHILE SQLCA.SQLCode = 0
		IF NOT IsNull ( l_s_form_name ) THEN
			lb_list_of_forms.AddItem ( l_s_form_name )
		END IF
	
		   FETCH get_forms
		    INTO :l_s_form_name  ;

	LOOP

	   CLOSE get_forms  ;

END IF
Return 0
end function

public function boolean uf_validate (string a_s_value);string l_s_report

select report
into   :l_s_report
from	 report_library
where  report = :a_s_value ;

if sqlca.sqlcode = 0 then
	
	Messagebox ( monsys.msg_title, "This form exists in the report_library!", Information! )
	Return True
	
Else
	
	Return False
	
end if

end function

on u_upgrade_forms_labels_forms.create
int iCurrent
call super::create
this.st_1=create st_1
this.p_1=create p_1
this.p_2=create p_2
this.st_list=create st_list
this.st_used=create st_used
this.p_3=create p_3
this.lb_list_of_forms=create lb_list_of_forms
this.lb_used_forms=create lb_used_forms
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.p_2
this.Control[iCurrent+4]=this.st_list
this.Control[iCurrent+5]=this.st_used
this.Control[iCurrent+6]=this.p_3
this.Control[iCurrent+7]=this.lb_list_of_forms
this.Control[iCurrent+8]=this.lb_used_forms
end on

on u_upgrade_forms_labels_forms.destroy
call super::destroy
destroy(this.st_1)
destroy(this.p_1)
destroy(this.p_2)
destroy(this.st_list)
destroy(this.st_used)
destroy(this.p_3)
destroy(this.lb_list_of_forms)
destroy(this.lb_used_forms)
end on

type st_1 from statictext within u_upgrade_forms_labels_forms
int X=315
int Y=48
int Width=1541
int Height=232
boolean Enabled=false
boolean BringToTop=true
string Text="none"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;Text = "The list on the left is a list of all of the standard forms.  Drag the names of the forms you use to the list on the left."
end event

type p_1 from picture within u_upgrade_forms_labels_forms
int X=1056
int Y=656
int Width=160
int Height=100
boolean Enabled=false
string PictureName="leftlow.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type p_2 from picture within u_upgrade_forms_labels_forms
int X=1056
int Y=516
int Width=160
int Height=100
boolean Enabled=false
string PictureName="rightlow.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type st_list from statictext within u_upgrade_forms_labels_forms
int X=370
int Y=312
int Width=571
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="List of Forms"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_used from statictext within u_upgrade_forms_labels_forms
int X=1294
int Y=312
int Width=571
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Used Forms"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=8388608
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_3 from picture within u_upgrade_forms_labels_forms
int X=9
int Y=16
int Width=279
int Height=904
boolean BringToTop=true
string PictureName="printers.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type lb_list_of_forms from ulb_smart_drag_drop within u_upgrade_forms_labels_forms
int X=370
int Y=404
int Width=571
int Height=492
int TabOrder=20
string DragIcon="lbdragp.ico"
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
end type

event dragdrop;call super::dragdrop;INTEGER	li_Count1
string   ls_item

lb_used_forms.drag(end!)
li_Count1 = 1

if DraggedObject ( ) = lb_used_forms then
	If  li_Count1 <= lb_used_forms.TotalItems ( ) then
		ls_item = lb_used_forms.selecteditem()
		lb_used_forms.DeleteItem ( lb_used_forms.finditem(ls_item , 1))
		lb_list_of_forms.additem(ls_item)
	End If
End if

if lb_used_forms.totalitems() >= 1 then
	w_upgrade_forms_labels.cb_2.enabled = true
else
	w_upgrade_forms_labels.cb_2.enabled = false	
end if
end event

event constructor;call super::constructor;iuos_Icons [ 1 ].s_TagValue = 'lb_list_of_forms'
iuos_Icons [ 1 ].s_LeaveIcon = 'nothere.ico'
iuos_Icons [ 1 ].s_BeginIcon = 'lbdrag.ico'
iuos_Icons [ 1 ].s_EnterIcon = 'lbdrag.ico'
iuos_Icons [ 2 ].s_TagValue = 'lb_used_forms'
iuos_Icons [ 2 ].s_EnterIcon = 'lbdragm.ico'
iuos_Icons [ 2 ].s_LeaveIcon = 'nothere.ico'
end event

type lb_used_forms from ulb_smart_drag_drop within u_upgrade_forms_labels_forms
int X=1294
int Y=404
int Width=571
int Height=492
int TabOrder=10
string DragIcon="lbdragm.ico"
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
long BackColor=12632256
end type

event dragdrop;call super::dragdrop;string ls_item

lb_list_of_forms.Drag(End!)

IF DraggedObject ( ) = lb_list_of_forms THEN
		ls_item = lb_list_of_forms.selecteditem()
		if lb_used_forms.finditem ( ls_item, 0 ) < 0 then
			if not uf_validate ( ls_item ) then
				lb_list_of_forms.DeleteItem ( lb_list_of_forms.finditem(ls_item , 1))
				lb_used_forms.additem(ls_item)
			End if
	End if
End if

If lb_used_forms.totalitems() >= 1 then
	w_upgrade_forms_labels.cb_2.enabled = true
else
	w_upgrade_forms_labels.cb_2.enabled = false
end if


end event

event constructor;call super::constructor;iuos_Icons [ 1 ].s_TagValue = 'lb_list_of_forms'
iuos_Icons [ 1 ].s_LeaveIcon = 'nothere.ico'
iuos_Icons [ 1 ].s_BeginIcon = 'lbdrag.ico'
iuos_Icons [ 1 ].s_EnterIcon = 'lbdrag.ico'
iuos_Icons [ 2 ].s_TagValue = 'lb_used_forms'
iuos_Icons [ 2 ].s_EnterIcon = 'lbdragm.ico'
iuos_Icons [ 2 ].s_LeaveIcon = 'nothere.ico'
end event

