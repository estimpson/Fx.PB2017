$PBExportHeader$u_rma_serial_scan.sru
forward
global type u_rma_serial_scan from u_dw_base
end type
end forward

global type u_rma_serial_scan from u_dw_base
int Width=905
int Height=192
string DataObject="d_serial_scan_interface_mri"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type
global u_rma_serial_scan u_rma_serial_scan

type variables
long  il_Serial

window iw_host
end variables

event itemchanged;Accepttext ()

int    li_strlen

long 	 ll_serial[]

string ls_newserial, &
       ls_orgstr, &
		 ls_tmpstr, &
		 ls_part
		 
decimal ln_qty

ls_orgstr = trim(upper(data))
li_strlen = LenA(ls_orgstr)
ls_newserial=''
ls_tmpstr =''

// extract only the numbers from right
DO WHILE (li_strlen > 0)
	IF AscA(MidA(ls_orgstr,li_strlen,1)) > 47 AND AscA(MidA(ls_orgstr,li_strlen,1)) < 58 THEN
		ls_newserial = ls_newserial + MidA(ls_orgstr,li_strlen,1)	
	ELSE
		li_strlen = 0
   END IF 
	li_strlen -- 
LOOP

// reverse the sequence back to the correct serial 
IF LenA(ls_newserial) > 0 THEN
	li_strlen = LenA(ls_newserial)
	DO WHILE (li_strlen > 0)
		ls_tmpstr = ls_tmpstr  + MidA(ls_newserial,li_strlen,1)
		li_strlen -- 
	LOOP
	ls_newserial = ls_tmpstr
END IF 

// return the new serial 
il_serial = long ( ls_newserial )

datastore  lds_object_info

lds_object_info = create datastore
lds_object_info.dataobject = 'd_audit_trail_info'
lds_object_info.settransobject ( sqlca )

if lds_object_info.retrieve ( il_serial ) <= 0 then
	messagebox ( monsys.msg_title, 'Invalid Serial!', Stopsign! )	
end if

destroy lds_object_info ;

iw_host.trigger dynamic event ue_manual_scan ( il_serial )



end event

event constructor;iw_host = message.powerobjectparm
end event

