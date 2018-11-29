$PBExportHeader$w_asn_file_generator.srw
$PBExportComments$(med)
forward
global type w_asn_file_generator from Window
end type
type cb_create from commandbutton within w_asn_file_generator
end type
type sle_file from singlelineedit within w_asn_file_generator
end type
type st_4 from statictext within w_asn_file_generator
end type
type uo_edi_generator from u_edi_file_generator_stx_856 within w_asn_file_generator
end type
type dw_error from datawindow within w_asn_file_generator
end type
type em_date_to from editmask within w_asn_file_generator
end type
type st_3 from statictext within w_asn_file_generator
end type
type em_date_from from editmask within w_asn_file_generator
end type
type st_2 from statictext within w_asn_file_generator
end type
type st_1 from statictext within w_asn_file_generator
end type
type dw_purpose_code from datawindow within w_asn_file_generator
end type
type cbx_status from checkbox within w_asn_file_generator
end type
type dw_shipper_detail from datawindow within w_asn_file_generator
end type
type gb_5 from groupbox within w_asn_file_generator
end type
type gb_4 from groupbox within w_asn_file_generator
end type
type gb_2 from groupbox within w_asn_file_generator
end type
type gb_1 from groupbox within w_asn_file_generator
end type
type dw_shippers from datawindow within w_asn_file_generator
end type
type gb_3 from groupbox within w_asn_file_generator
end type
end forward

global type w_asn_file_generator from Window
int X=0
int Y=0
int Width=2926
int Height=1920
boolean TitleBar=true
string Title="ASN Control Center"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
event send pbm_custom01
event ue_open pbm_custom02
cb_create cb_create
sle_file sle_file
st_4 st_4
uo_edi_generator uo_edi_generator
dw_error dw_error
em_date_to em_date_to
st_3 st_3
em_date_from em_date_from
st_2 st_2
st_1 st_1
dw_purpose_code dw_purpose_code
cbx_status cbx_status
dw_shipper_detail dw_shipper_detail
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
dw_shippers dw_shippers
gb_3 gb_3
end type
global w_asn_file_generator w_asn_file_generator

type variables
integer &
  	ii_file_no

boolean &
	ib_error = TRUE, &
	ib_test = FALSE, &
	ib_auto_create = FALSE

long &
	il_shipper 

string &
	is_default_file
end variables

forward prototypes
public function string uf_add_to_flat_file (string as_file)
public function string uf_generate_asn (string as_destination)
public function string uf_get_destination (long al_shipper)
end prototypes

on send;long &
	ll_shipper, &
	ll_row

string &
	ls_return

ls_return	= uf_add_to_flat_file( sle_file.text ) 

if ls_return > '' then		//errors occurred
	messagebox( 'Monitor for Windows', ls_return, information! )
end if	


end on

event ue_open;string &
	ls_destination, &
	ls_return

uo_edi_generator.dw_header.uf_share_dw( this, dw_error )
uo_edi_generator.dw_body.uf_share_dw( this, dw_error )
uo_edi_generator.dw_end.uf_share_dw( this, dw_error )
uo_edi_generator.uf_init ( This )

//il_shipper is intantiated in 'Constructor' event of uo_edi_generator

ib_test		= ( il_shipper = 0 ) or (isnull( il_shipper ))

if (il_shipper > 0) then
	ls_destination	= uf_get_destination( il_shipper )
	ls_return	= uf_generate_asn( ls_destination )
//	cbx_status.TriggerEvent ( 'clicked' )
	if ls_return > '' then
		messagebox( 'Monitor for Windows', ls_return )
	else
		if sle_file.Text > '' then		
			ls_return	= uf_add_to_flat_file( sle_file.Text )
			if ls_return = '' then	//Success
				close( this )
				return
			else							//Failed
				messagebox( 'Monitor for Windows', ls_return )
			end if
		else
			messagebox( 'Monitor for Windows', 'You must specify default flat output file defult name.' )
		end if		
	end if			
else
	uo_edi_generator.dw_header.ib_test	= this.ib_test
	uo_edi_generator.dw_body.ib_test	= this.ib_test
	uo_edi_generator.dw_end.ib_test		= this.ib_test
end if
dw_shippers.triggerevent('ue_retrieve')
end event

public function string uf_add_to_flat_file (string as_file);string &
	ls_line, &
	ls_return = ''

long &
	ll_ptr, &
	ll_count, &
	ll_row

if profilestring( uo_edi_generator.is_ini_file, 'General', 'FileMode', 'Line' ) = 'Line' then
	ii_file_no = FileOpen( as_file, LineMode!, Write!, LockWrite!, Append! )
else
	ii_file_no = FileOpen( as_file, StreamMode!, Write!, LockWrite!, Append! )
end if

if ii_file_no <= 0 then
	ls_return	= 'Failed to open flat file ' + as_file + '.'
	return ls_return
end if

ll_count	=	uo_edi_generator.dw_flat_file.rowcount()

for ll_ptr = 1 to ll_count
	ls_line	= uo_edi_generator.dw_flat_file.getitemstring( ll_ptr, 1 )
	ls_line	+= space( 80 ) 
	ls_line	= LeftA( ls_line, 80 )
	filewrite( ii_file_no, ls_line )
next

fileclose( ii_file_no )

UPDATE shipper  
SET status = 'Z'  
WHERE shipper.id = :il_shipper USING SQLCA  ;
if SQLCA.SQLCode = 0 then
	COMMIT;
	ls_return	=	''
	messagebox( 'Monitor for Windows', 'Data has been added to ' + sle_file.text + &
						', and the shipper has been flaged successfully.' )
else
	ROLLBACK;
	ls_return	= 	'Data has been added to ' + sle_file.text + &
						', but failed to set ASN flag for the shipper.'
end if

return ls_return

end function

public function string uf_generate_asn (string as_destination);string	ls_overlay_group, &
	ls_EDIListINI, &
	ls_structure_ini, &
	ls_message

SELECT	edi_setups.asn_overlay_group
INTO	:ls_overlay_group
FROM	edi_setups
WHERE 	edi_setups.destination = :as_destination;

cb_create.enabled	= FALSE

if SQLCA.SQLCode = 0 then
	ls_EDIListINI	= monsys.root + '\edilist.ini'
	IF NOT FileExists ( ls_EDIListINI ) THEN
		ls_EDIListINI = 'c:\windows\edilist.ini'
		IF NOT FileExists ( ls_EDIListINI ) THEN
			ib_error		= TRUE
			ls_message 	= 'Unable to locate EDILIST.INI' 
			Return ls_message
		END IF
	END IF
	ls_structure_ini = profilestring( ls_EDIListINI, '856', ls_overlay_group + '_STX_STRUCTURE', '')
	if ls_structure_ini > '' then
		is_default_file	= profilestring( ls_structure_ini, 'General', 'Output', '' )
		if is_default_file > '' then
			sle_file.Text = is_default_file
		end if
		ib_test	= FALSE
		uo_edi_generator.dw_header.ib_test	= ib_test
		uo_edi_generator.dw_body.ib_test	= ib_test
		uo_edi_generator.dw_end.ib_test		= ib_test
		ib_error	= FALSE
		dw_error.reset()
		uo_edi_generator.uf_open_file( ls_structure_ini, il_shipper )	
		if dw_error.rowcount() > 0 then
			cb_create.enabled	= FALSE
			ls_message	= 'There are errors in flat file. Please correct them first.' 
		end if					
	else
		ib_error		= TRUE
		ls_message 	= 'STX Structure INI file is missing in EDILIST.INI' 
	end if
else
	ib_error		= TRUE
	ls_message 	= 'Overlay group setup is not found.' 
end if
yield()
return ls_message
end function

public function string uf_get_destination (long al_shipper);string &
	ls_destination

SELECT shipper.destination  
  INTO :ls_destination  
  FROM shipper  
 WHERE shipper.id = :al_shipper USING SQLCA  ;

return ls_destination
end function

event open;STRING	ls_Partial

SELECT set_asn_uop
  INTO :ls_Partial
  FROM parameters  ;

IF isnull(ls_Partial,'N') <> 'Y' THEN
	cbx_status.Checked = TRUE
END IF

PostEvent ( 'ue_open' )
end event

on w_asn_file_generator.create
this.cb_create=create cb_create
this.sle_file=create sle_file
this.st_4=create st_4
this.uo_edi_generator=create uo_edi_generator
this.dw_error=create dw_error
this.em_date_to=create em_date_to
this.st_3=create st_3
this.em_date_from=create em_date_from
this.st_2=create st_2
this.st_1=create st_1
this.dw_purpose_code=create dw_purpose_code
this.cbx_status=create cbx_status
this.dw_shipper_detail=create dw_shipper_detail
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_shippers=create dw_shippers
this.gb_3=create gb_3
this.Control[]={this.cb_create,&
this.sle_file,&
this.st_4,&
this.uo_edi_generator,&
this.dw_error,&
this.em_date_to,&
this.st_3,&
this.em_date_from,&
this.st_2,&
this.st_1,&
this.dw_purpose_code,&
this.cbx_status,&
this.dw_shipper_detail,&
this.gb_5,&
this.gb_4,&
this.gb_2,&
this.gb_1,&
this.dw_shippers,&
this.gb_3}
end on

on w_asn_file_generator.destroy
destroy(this.cb_create)
destroy(this.sle_file)
destroy(this.st_4)
destroy(this.uo_edi_generator)
destroy(this.dw_error)
destroy(this.em_date_to)
destroy(this.st_3)
destroy(this.em_date_from)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_purpose_code)
destroy(this.cbx_status)
destroy(this.dw_shipper_detail)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_shippers)
destroy(this.gb_3)
end on

event activate;If gnv_App.of_GetFrame().MenuName <> "m_asn_file_generator" Then &
	gnv_App.of_GetFrame().ChangeMenu ( m_asn_file_generator )
end event

type cb_create from commandbutton within w_asn_file_generator
int X=1417
int Y=8
int Width=238
int Height=80
int TabOrder=130
boolean Enabled=false
string Text="Create"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long &
	ll_shipper, &
	ll_row

string &
	ls_return

ls_return	= uf_add_to_flat_file( sle_file.text ) 

if ls_return > '' then		//errors occurred
	messagebox( 'Monitor for Windows', ls_return, information! )
end if	


end event

type sle_file from singlelineedit within w_asn_file_generator
event ue_paint pbm_custom01
int X=782
int Y=12
int Width=603
int Height=76
int TabOrder=140
int Limit=50
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_paint;STRING	ls_Path, &
		ls_MonitorINI

ls_MonitorINI = monsys.root + '\monitor.ini'
IF NOT FileExists ( ls_MonitorINI ) THEN
	ls_MonitorINI = 'c:\windows\monitor.ini'
	IF NOT FileExists ( ls_MonitorINI ) THEN
		MessageBox ( 'Warning', 'Unable to locate Monitor~'s INI file called ~'Monitor.ini~'' )
		Return
	END IF
END IF

ls_Path = ProfileString ( ls_MonitorINI, 'EDI PARMS', 'ASNDirectory', 'c:\windows' )
ls_Path += '\dx-fx-ff.080'

Text = ls_Path
end event

on constructor;PostEvent ( 'ue_paint' )
end on

type st_4 from statictext within w_asn_file_generator
int X=325
int Y=1268
int Width=672
int Height=56
boolean Enabled=false
string Text="(Enter correct value in Col Value)"
boolean FocusRectangle=false
long TextColor=255
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_edi_generator from u_edi_file_generator_stx_856 within w_asn_file_generator
int X=55
int Y=96
int TabOrder=20
end type

event constructor;call super::constructor;this.ib_dump	= FALSE			//Do not do the auto-dump
il_shipper		= message.doubleparm

end event

on uo_edi_generator.destroy
call u_edi_file_generator_stx_856::destroy
end on

type dw_error from datawindow within w_asn_file_generator
int X=55
int Y=1324
int Width=1609
int Height=404
int TabOrder=100
string DataObject="d_dw_error_list_for_edi"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;integer	li_row, &
			li_count

boolean	lb_error = FALSE

li_row	= row

if li_row > 0 then
	uo_edi_generator.uf_correct_error( gettext(), &
						getitemstring( li_row, 'col_line' ), &
						getitemnumber( li_row, 'col_pos' ), &
						getitemnumber( li_row, 'col_length' ) )

	
	li_count	= rowcount()
	AcceptText ( )
	li_row	= 1
	do while (not lb_error) and ( li_row <= li_count )
		lb_error	= 	isnull( getitemstring( li_row, 'col_value' )) or &
						getitemstring( li_row, 'col_value' ) = ''
		li_row ++
	loop

	cb_create.enabled	= (not lb_error )
end if
end event

type em_date_to from editmask within w_asn_file_generator
int X=1298
int Y=1168
int Width=311
int Height=80
int TabOrder=80
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;if this.text = '00/00/0000' then
	setprofilestring( 'EDILIST.INI', 'Data Period', 'To', '' )
else
	setprofilestring( 'EDILIST.INI', 'Data Period', 'To', this.text )
end if

dw_shippers.triggerevent( 'ue_retrieve' )
end on

on constructor;string &
	ls_date

ls_date 	= profilestring( 'EDILIST.INI', 'Data Period', 'To', '' )
if ls_date = '00/00/0000' then
	setnull( this.text )
else
	this.text	= ls_date
end if

end on

type st_3 from statictext within w_asn_file_generator
int X=914
int Y=1168
int Width=105
int Height=64
boolean Enabled=false
string Text="To"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_date_from from editmask within w_asn_file_generator
int X=603
int Y=1168
int Width=311
int Height=80
int TabOrder=70
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yyyy"
MaskDataType MaskDataType=DateMask!
long BackColor=16777215
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;if this.text = '00/00/0000' then
	setprofilestring( 'EDILIST.INI', 'Data Period', 'From', '' )
else
	setprofilestring( 'EDILIST.INI', 'Data Period', 'From', this.text )
end if

dw_shippers.triggerevent( 'ue_retrieve' )
end on

on constructor;string &
	ls_date

ls_date 	= profilestring( 'EDILIST.INI', 'Data Period', 'From', '' )
if ls_date = '00/00/0000' then
	setnull( this.text )
else
	this.text	= ls_date
end if
end on

type st_2 from statictext within w_asn_file_generator
int X=73
int Y=1136
int Width=457
int Height=112
boolean Enabled=false
string Text="Retrieve Shipper for Period of"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_asn_file_generator
int X=914
int Y=1072
int Width=370
int Height=72
boolean Enabled=false
string Text="Purpose Code"
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_purpose_code from datawindow within w_asn_file_generator
int X=1289
int Y=1072
int Width=329
int Height=80
int TabOrder=60
string Tag="purpose_code;purpose_code"
string DataObject="d_dw_purpose_for_asn"
boolean Border=false
boolean LiveScroll=true
end type

on itemchanged;//if uo_edi_generator.dw_header.rowcount() > 0 then
//	uo_edi_generator.dw_header_stx.is_purpose_code	= this.gettext() 
//	uo_edi_generator.uf_correct_error( &
//				this.gettext(), &
//				'01', &
//				3, &
//				2 )
//end if
end on

on constructor;this.insertrow( 1 )
end on

type cbx_status from checkbox within w_asn_file_generator
int X=55
int Y=1072
int Width=603
int Height=64
string Tag="partial_complete;P,"
string Text="Flag Partial Complete"
boolean LeftText=true
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_shipper_detail from datawindow within w_asn_file_generator
int X=1755
int Y=1072
int Width=1024
int Height=640
int TabOrder=50
string DataObject="dw_shipper_detail_info_white8"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on constructor;this.settransobject( SQLCA )
end on

type gb_5 from groupbox within w_asn_file_generator
int X=18
int Y=1264
int Width=1682
int Height=480
int TabOrder=90
string Text="Error List"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_asn_file_generator
int X=1701
int Y=1008
int Width=1115
int Height=736
int TabOrder=40
string Text="Shipper Detail"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_asn_file_generator
int X=18
int Y=1008
int Width=1682
int Height=256
int TabOrder=30
string Text="Selection"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_asn_file_generator
int X=18
int Y=16
int Width=1682
int Height=992
int TabOrder=110
string Text="Generated Overlay Flat  File"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_shippers from datawindow within w_asn_file_generator
event ue_retrieve pbm_custom01
int X=1737
int Y=96
int Width=1042
int Height=864
int TabOrder=10
string DataObject="dw_list_of_closed_shippers_white8"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_retrieve;string &
	ls_date_from, &
	ls_date_to, &
	ls_sql

datetime &
	ldt_date_from, &
	ldt_date_to

dataobject = "dw_list_of_closed_shippers_white8"
this.settransobject( SQLCA )

ls_date_from 	= profilestring( 'EDILIST.INI', 'Data Period', 'From', '' )
ls_date_to 	= profilestring( 'EDILIST.INI', 'Data Period', 'To', '' )
reset()

IF IsDate ( ls_date_from ) AND IsDate ( ls_date_to ) THEN
	if ls_date_from > '' and ls_date_from <> '00/00/0000' then
		ldt_date_from	= DateTime ( Date ( ls_date_from ) )
		ls_date_from	= string( ldt_date_from, 'yyyy-mm-dd 00:00:00' )
	end if

	if ls_date_to > '' and ls_date_to <> '00/00/0000' then
		ldt_date_to		= datetime ( Date ( ls_date_to ) )
		ls_date_to		= string( ldt_date_to, 'yyyy-mm-dd 23:59:59' )
	end if

	ls_sql = ''
	ls_sql = getsqlselect() 
	if ls_date_from > '' then
		ls_sql += " AND date_shipped >= '" + ls_date_from + "'"
	end if

	if ls_date_to > '' then
		ls_sql += " AND date_shipped <= '" + ls_date_to + "'"
	end if

	if ls_sql > '' then
		this.setsqlselect( ls_sql )
	end if
	
END IF

this.retrieve()
dw_shipper_detail.reset()
dw_error.reset()
uo_edi_generator.dw_flat_file.reset()
end event

event constructor;//PostEvent( 'ue_retrieve' )
settransobject(sqlca)
end event

event clicked;string	ls_overlay_group, &
	ls_destination, &
	ls_structure_ini, &
	ls_message

if row > 0 then
	selectrow( 0, FALSE )
	selectrow( row, TRUE )
	il_shipper	= object.id[row]
	ls_destination	= object.destination[row]	
	dw_shipper_detail.retrieve( il_shipper )
	ls_message	= uf_generate_asn( ls_destination )
	if ls_message > '' then
		messagebox( monsys.msg_title, ls_message )
	end if
end if
cb_create.enabled = (not ib_error ) and (not ib_test )	
end event

type gb_3 from groupbox within w_asn_file_generator
int X=1701
int Y=16
int Width=1115
int Height=992
int TabOrder=120
string Text="Shipper Header"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

