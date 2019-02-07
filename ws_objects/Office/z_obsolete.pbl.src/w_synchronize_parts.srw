$PBExportHeader$w_synchronize_parts.srw
forward
global type w_synchronize_parts from Window
end type
type st_title from statictext within w_synchronize_parts
end type
type st_percentage from statictext within w_synchronize_parts
end type
type cb_2 from commandbutton within w_synchronize_parts
end type
type cb_1 from commandbutton within w_synchronize_parts
end type
type rb_5 from radiobutton within w_synchronize_parts
end type
type rb_4 from radiobutton within w_synchronize_parts
end type
type rb_3 from radiobutton within w_synchronize_parts
end type
type rb_2 from radiobutton within w_synchronize_parts
end type
type rb_1 from radiobutton within w_synchronize_parts
end type
type sle_percentage from singlelineedit within w_synchronize_parts
end type
type dw_parts from datawindow within w_synchronize_parts
end type
type sle_base from singlelineedit within w_synchronize_parts
end type
type gb_1 from groupbox within w_synchronize_parts
end type
end forward

global type w_synchronize_parts from Window
int X=1
int Y=1
int Width=2926
int Height=1937
boolean TitleBar=true
string Title="Synchronize Part Tables"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_title st_title
st_percentage st_percentage
cb_2 cb_2
cb_1 cb_1
rb_5 rb_5
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
sle_percentage sle_percentage
dw_parts dw_parts
sle_base sle_base
gb_1 gb_1
end type
global w_synchronize_parts w_synchronize_parts

forward prototypes
public subroutine wf_characteristics (string szpart)
public subroutine wf_inventory (string szpart)
public subroutine wf_mfg (string szpart)
public subroutine wf_online (string szpart)
public subroutine wf_standard (string szpart)
end prototypes

public subroutine wf_characteristics (string szpart);String szCurrentPart

SetNull(szCurrentPart)

  SELECT part_characteristics.part  
    INTO :szCurrentPart  
    FROM part_characteristics  
   WHERE part_characteristics.part = :szPart   ;

If IsNull(szCurrentPart) then
	  INSERT INTO part_characteristics  
         ( part,   
           unit_weight,   
           length_x,   
           height_y,   
           width_z,   
           color,   
           hazardous,   
           part_size,   
           user_defined_1,   
           package_type,   
           returnable )  
  VALUES ( :szPart,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

	If SQLCA.SQLCode = -1 then
		Rollback;
	Else
		Commit;
	End If
End If

rb_1.checked	= TRUE

		


end subroutine

public subroutine wf_inventory (string szpart);String szCurrentPart

SetNull(szCurrentPart)

SELECT part_inventory.part  
  INTO :szCurrentPart  
  FROM part_inventory  
 WHERE part_inventory.part = :szPart   ;

If IsNull(szCurrentPart) then
	  INSERT INTO part_inventory  
         ( part,   
           standard_pack,   
           unit_weight,   
           standard_unit,   
           cycle,   
           abc,   
           saftey_stock_qty,   
           primary_location,   
           location_group,   
           ipa,   
           label_format,   
           shelf_life_days,   
           material_issue_type )  
  VALUES ( :szPart,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

	If SQLCA.SQLCode = -1 then
		Rollback;
	Else
		Commit;
	End If
End If		
	

end subroutine

public subroutine wf_mfg (string szpart);String szCurrentPart

SetNull(szCurrentPart)

  SELECT part_mfg.part  
    INTO :szCurrentPart  
    FROM part_mfg  
   WHERE part_mfg.part = :szPart   ;

If IsNull(szCurrentPart) then
  INSERT INTO part_mfg  
         ( part,   
           mfg_lot_size,   
           process_id,   
           parts_per_cycle,   
           parts_per_hour,   
           cycle_unit,   
           cycle_time,   
           overlap_type,   
           overlap_time,   
           engineering_level,   
           drawing_number,   
           labor_code,   
           gl_account_code,   
           activity,   
           setup_time )  
  VALUES ( :szPart,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )  ;

	If  SQLCA.SQLCode = -1 then
		Rollback;
	Else
		Commit;
	End If

End If

end subroutine

public subroutine wf_online (string szpart);String szCurrentPart

SetNull(szCurrentPart)

  SELECT part_online.part  
    INTO :szCurrentPart  
    FROM part_online  
   WHERE part_online.part = :szPart   ;

If IsNull(szCurrentPart) then
	  INSERT INTO part_online  
         ( part,   
           on_hand,   
           on_demand,   
           on_schedule,   
           bom_net_out )  
  VALUES ( :szPart,   
           0,   
           0,   
           0,   
           0 )  ;

	If SQLCA.SQLCode = -1 then
		Rollback;
	Else
		Commit;
	End If
End If


end subroutine

public subroutine wf_standard (string szpart);String szCurrentPart

SetNull(szCurrentPart)

  SELECT part_standard.part  
    INTO :szCurrentPart  
    FROM part_standard  
   WHERE part_standard.part = :szPart   ;

If IsNull(szCurrentPart) then
	  INSERT INTO part_standard  
         ( part,   
           price,   
           cost,   
           account_number )  
  VALUES ( :szPart,   
           null,   
           null,   
           null )  ;

	If SQLCA.SQLCode = -1 then
		Rollback;
	Else
		Commit;
	End If
End If


end subroutine

on open;dw_parts.SetTransObject(sqlca)
dw_parts.Retrieve()
end on

on w_synchronize_parts.create
this.st_title=create st_title
this.st_percentage=create st_percentage
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_5=create rb_5
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.sle_percentage=create sle_percentage
this.dw_parts=create dw_parts
this.sle_base=create sle_base
this.gb_1=create gb_1
this.Control[]={ this.st_title,&
this.st_percentage,&
this.cb_2,&
this.cb_1,&
this.rb_5,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.sle_percentage,&
this.dw_parts,&
this.sle_base,&
this.gb_1}
end on

on w_synchronize_parts.destroy
destroy(this.st_title)
destroy(this.st_percentage)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.sle_percentage)
destroy(this.dw_parts)
destroy(this.sle_base)
destroy(this.gb_1)
end on

type st_title from statictext within w_synchronize_parts
int X=426
int Y=321
int Width=810
int Height=73
boolean Enabled=false
string Text="Process Part:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_percentage from statictext within w_synchronize_parts
int X=1354
int Y=653
int Width=110
int Height=73
boolean Enabled=false
string Text="0%"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_synchronize_parts
int X=2291
int Y=1233
int Width=247
int Height=109
int TabOrder=60
string Text="Exit"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type cb_1 from commandbutton within w_synchronize_parts
int X=2007
int Y=1237
int Width=247
int Height=109
int TabOrder=50
string Text="Start"
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Long 		iRow
String	szPart

dw_parts.Retrieve()

sle_percentage.visible	= TRUE
sle_percentage.width 	= 0

this.Enabled	= FALSE

For iRow = 1 to dw_parts.RowCount()

	rb_1.checked			= FALSE
	rb_2.checked			= FALSE
	rb_3.checked			= FALSE
	rb_4.checked			= FALSE
	rb_5.checked			= FALSE

	szPart					= dw_parts.GetItemString(iRow, "part")
	st_title.text			= "Processing part:" + szPart

	st_percentage.text	= String(Truncate(iRow * 100 / dw_parts.RowCount(), 0)) + "%"
	sle_percentage.width	= (iRow / dw_parts.RowCount()) * sle_base.width

	wf_characteristics(szPart)
	rb_1.checked			= TRUE

	wf_inventory(szPart)
	rb_2.checked			= TRUE

	wf_mfg(szPart)
	rb_3.checked			= TRUE
	
	wf_online(szPart)
	rb_4.checked			= TRUE

	wf_standard(szPart)
	rb_5.checked			= TRUE

Next

this.Enabled				= TRUE
sle_percentage.visible	= TRUE
sle_percentage.width 	= 0

st_title.text	= "Process part:"


end on

type rb_5 from radiobutton within w_synchronize_parts
int X=1669
int Y=829
int Width=627
int Height=73
string Text="Part Standard"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_synchronize_parts
int X=1669
int Y=741
int Width=627
int Height=73
string Text="Part OnLine"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_3 from radiobutton within w_synchronize_parts
int X=1669
int Y=657
int Width=627
int Height=73
string Text="Part Mfg"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_synchronize_parts
int X=1669
int Y=565
int Width=627
int Height=73
string Text="Part Inventory"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_synchronize_parts
int X=1669
int Y=477
int Width=627
int Height=73
string Text="Part Characteristics"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_percentage from singlelineedit within w_synchronize_parts
int X=572
int Y=645
int Width=42
int Height=89
int TabOrder=40
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=255
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_parts from datawindow within w_synchronize_parts
int X=293
int Y=217
int Width=631
int Height=733
int TabOrder=10
boolean Visible=false
string DataObject="dw_list_of_parts"
boolean LiveScroll=true
end type

type sle_base from singlelineedit within w_synchronize_parts
int X=572
int Y=645
int Width=773
int Height=89
int TabOrder=30
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_synchronize_parts
int X=353
int Y=317
int Width=2195
int Height=737
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

