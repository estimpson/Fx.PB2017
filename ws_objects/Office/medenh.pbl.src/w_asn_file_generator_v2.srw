$PBExportHeader$w_asn_file_generator_v2.srw
$PBExportComments$(med)
forward
global type w_asn_file_generator_v2 from w_sheet_4t
end type
type cb_create from commandbutton within w_asn_file_generator_v2
end type
type sle_file from singlelineedit within w_asn_file_generator_v2
end type
type st_4 from statictext within w_asn_file_generator_v2
end type
type uo_edi_generator from u_edi_file_generator_stx_856 within w_asn_file_generator_v2
end type
type dw_error from datawindow within w_asn_file_generator_v2
end type
type em_date_to from editmask within w_asn_file_generator_v2
end type
type st_3 from statictext within w_asn_file_generator_v2
end type
type em_date_from from editmask within w_asn_file_generator_v2
end type
type st_2 from statictext within w_asn_file_generator_v2
end type
type st_1 from statictext within w_asn_file_generator_v2
end type
type dw_purpose_code from datawindow within w_asn_file_generator_v2
end type
type cbx_status from checkbox within w_asn_file_generator_v2
end type
type dw_shipper_detail from datawindow within w_asn_file_generator_v2
end type
type gb_5 from groupbox within w_asn_file_generator_v2
end type
type gb_4 from groupbox within w_asn_file_generator_v2
end type
type gb_2 from groupbox within w_asn_file_generator_v2
end type
type gb_1 from groupbox within w_asn_file_generator_v2
end type
type dw_shippers from datawindow within w_asn_file_generator_v2
end type
type gb_3 from groupbox within w_asn_file_generator_v2
end type
end forward

global type w_asn_file_generator_v2 from w_sheet_4t
integer width = 2926
integer height = 1996
string title = "ASN Control Center"
string menuname = "m_asn_file_generator_v2"
boolean controlmenu = true
boolean minbox = true
long backcolor = 12632256
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
global w_asn_file_generator_v2 w_asn_file_generator_v2

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
		ls_EDIListINI = 'c:\Fx\edilist.ini'
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

on w_asn_file_generator_v2.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_asn_file_generator_v2" then this.MenuID = create m_asn_file_generator_v2
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_create
this.Control[iCurrent+2]=this.sle_file
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.uo_edi_generator
this.Control[iCurrent+5]=this.dw_error
this.Control[iCurrent+6]=this.em_date_to
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_date_from
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_purpose_code
this.Control[iCurrent+12]=this.cbx_status
this.Control[iCurrent+13]=this.dw_shipper_detail
this.Control[iCurrent+14]=this.gb_5
this.Control[iCurrent+15]=this.gb_4
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.dw_shippers
this.Control[iCurrent+19]=this.gb_3
end on

on w_asn_file_generator_v2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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

type cb_create from commandbutton within w_asn_file_generator_v2
integer x = 1417
integer y = 8
integer width = 238
integer height = 80
integer taborder = 130
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Create"
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

type sle_file from singlelineedit within w_asn_file_generator_v2
event ue_paint pbm_custom01
integer x = 782
integer y = 12
integer width = 603
integer height = 76
integer taborder = 140
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer limit = 50
end type

event ue_paint;STRING	ls_Path, &
		ls_MonitorINI

ls_MonitorINI = monsys.root + '\monitor.ini'
IF NOT FileExists ( ls_MonitorINI ) THEN
	ls_MonitorINI = 'c:\Fx\monitor.ini'
	IF NOT FileExists ( ls_MonitorINI ) THEN
		MessageBox ( 'Warning', 'Unable to locate Monitor~'s INI file called ~'Monitor.ini~'' )
		Return
	END IF
END IF

ls_Path = ProfileString ( ls_MonitorINI, 'EDI PARMS', 'ASNDirectory', 'c:\Fx' )
ls_Path += '\dx-fx-ff.080'

Text = ls_Path
end event

on constructor;PostEvent ( 'ue_paint' )
end on

type st_4 from statictext within w_asn_file_generator_v2
integer x = 325
integer y = 1268
integer width = 672
integer height = 56
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "(Enter correct value in Col Value)"
boolean focusrectangle = false
end type

type uo_edi_generator from u_edi_file_generator_stx_856 within w_asn_file_generator_v2
integer x = 55
integer y = 96
integer taborder = 20
end type

event constructor;call super::constructor;this.ib_dump	= FALSE			//Do not do the auto-dump
il_shipper		= message.doubleparm

end event

on uo_edi_generator.destroy
call u_edi_file_generator_stx_856::destroy
end on

type dw_error from datawindow within w_asn_file_generator_v2
integer x = 55
integer y = 1324
integer width = 1609
integer height = 404
integer taborder = 100
string dataobject = "d_dw_error_list_for_edi"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
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

type em_date_to from editmask within w_asn_file_generator_v2
integer x = 1298
integer y = 1168
integer width = 311
integer height = 80
integer taborder = 80
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
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

type st_3 from statictext within w_asn_file_generator_v2
integer x = 914
integer y = 1168
integer width = 105
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "To"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_date_from from editmask within w_asn_file_generator_v2
integer x = 603
integer y = 1168
integer width = 311
integer height = 80
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yyyy"
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

type st_2 from statictext within w_asn_file_generator_v2
integer x = 73
integer y = 1136
integer width = 457
integer height = 112
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Retrieve Shipper for Period of"
boolean focusrectangle = false
end type

type st_1 from statictext within w_asn_file_generator_v2
integer x = 914
integer y = 1072
integer width = 370
integer height = 72
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Purpose Code"
boolean focusrectangle = false
end type

type dw_purpose_code from datawindow within w_asn_file_generator_v2
string tag = "purpose_code;purpose_code"
integer x = 1289
integer y = 1072
integer width = 329
integer height = 80
integer taborder = 60
string dataobject = "d_dw_purpose_for_asn"
boolean border = false
boolean livescroll = true
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

type cbx_status from checkbox within w_asn_file_generator_v2
string tag = "partial_complete;P,"
integer x = 55
integer y = 1072
integer width = 603
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Flag Partial Complete"
boolean lefttext = true
end type

type dw_shipper_detail from datawindow within w_asn_file_generator_v2
integer x = 1755
integer y = 1072
integer width = 1024
integer height = 640
integer taborder = 50
string dataobject = "dw_shipper_detail_info_white8"
boolean vscrollbar = true
boolean livescroll = true
end type

on constructor;this.settransobject( SQLCA )
end on

type gb_5 from groupbox within w_asn_file_generator_v2
integer x = 18
integer y = 1264
integer width = 1682
integer height = 480
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Error List"
end type

type gb_4 from groupbox within w_asn_file_generator_v2
integer x = 1701
integer y = 1008
integer width = 1115
integer height = 736
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Shipper Detail"
end type

type gb_2 from groupbox within w_asn_file_generator_v2
integer x = 18
integer y = 1008
integer width = 1682
integer height = 256
integer taborder = 30
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Selection"
end type

type gb_1 from groupbox within w_asn_file_generator_v2
integer x = 18
integer y = 16
integer width = 1682
integer height = 992
integer taborder = 110
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Generated Overlay Flat  File"
end type

type dw_shippers from datawindow within w_asn_file_generator_v2
event ue_retrieve pbm_custom01
integer x = 1737
integer y = 96
integer width = 1042
integer height = 864
integer taborder = 10
string dataobject = "dw_list_of_closed_shippers_white8"
boolean vscrollbar = true
boolean livescroll = true
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

type gb_3 from groupbox within w_asn_file_generator_v2
integer x = 1701
integer y = 16
integer width = 1115
integer height = 992
integer taborder = 120
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Shipper Header"
end type

