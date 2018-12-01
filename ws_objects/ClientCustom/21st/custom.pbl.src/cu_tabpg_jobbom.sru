$PBExportHeader$cu_tabpg_jobbom.sru
forward
global type cu_tabpg_jobbom from u_tabpg_jobbom
end type
type cb_changeletdown from commandbutton within cu_tabpg_jobbom
end type
type dw_2 from u_fxdw within cu_tabpg_jobbom
end type
type cb_verify from commandbutton within cu_tabpg_jobbom
end type
type gb_2 from groupbox within cu_tabpg_jobbom
end type
end forward

global type cu_tabpg_jobbom from u_tabpg_jobbom
cb_changeletdown cb_changeletdown
dw_2 dw_2
cb_verify cb_verify
gb_2 gb_2
end type
global cu_tabpg_jobbom cu_tabpg_jobbom

forward prototypes
public function integer refresh ()
end prototypes

public function integer refresh ();
dw_2.event pfc_retrieve()
return super::refresh()

end function

on cu_tabpg_jobbom.create
int iCurrent
call super::create
this.cb_changeletdown=create cb_changeletdown
this.dw_2=create dw_2
this.cb_verify=create cb_verify
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_changeletdown
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_verify
this.Control[iCurrent+4]=this.gb_2
end on

on cu_tabpg_jobbom.destroy
call super::destroy
destroy(this.cb_changeletdown)
destroy(this.dw_2)
destroy(this.cb_verify)
destroy(this.gb_2)
end on

event constructor;call super::constructor;
inv_Resize.of_SetOrigSize(cb_resetbom.X + (cb_resetbom.X - gb_1.X - gb_1.Width) + cb_resetbom.Width, gb_parent.Y + gb_1.Y + gb_1.Height)
inv_Resize.of_Register(cb_changeletdown, 100, 0, 0, 0)
inv_Resize.of_Register(cb_verify, 100, 100, 0, 0)
inv_Resize.of_Register(gb_2, 0, 0, 100, 0)
inv_Resize.of_Register(dw_2, 0, 0, 100, 0)

InventoryTrans = create n_cst_mes_inventorytrans

end event

type gb_1 from u_tabpg_jobbom`gb_1 within cu_tabpg_jobbom
integer y = 596
end type

type dw_1 from u_tabpg_jobbom`dw_1 within cu_tabpg_jobbom
integer y = 676
end type

type dw_parent from u_tabpg_jobbom`dw_parent within cu_tabpg_jobbom
end type

type gb_parent from u_tabpg_jobbom`gb_parent within cu_tabpg_jobbom
end type

type cb_substitute from u_tabpg_jobbom`cb_substitute within cu_tabpg_jobbom
integer y = 780
end type

type cb_deletesub from u_tabpg_jobbom`cb_deletesub within cu_tabpg_jobbom
integer y = 912
end type

type cb_resetbom from u_tabpg_jobbom`cb_resetbom within cu_tabpg_jobbom
end type

type cb_changeletdown from commandbutton within cu_tabpg_jobbom
integer x = 1810
integer y = 408
integer width = 489
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Change Letdown"
end type

event clicked;
dw_2.AcceptText()

int jobLetDownRow
jobLetDownRow = dw_2.GetRow()
if	jobLetDownRow <= 0 then
	MessageBox(gnv_App.iapp_Object.DisplayName, "Invalid row selected.")
	return
end if

long jobID
decimal {6} newLetDownRate

jobID = dw_2.object.WODID[jobLetDownRow]
newLetDownRate = dw_2.object.JobLetDownRate[jobLetDownRow]

n_cst_custom_mes_inventorytrans customMES
customMES = create n_cst_custom_mes_inventorytrans
customMES.ChangeLetDownRate (jobID, newLetDownRate)
destroy customMES

Refreshing=true
Refresh()

end event

type dw_2 from u_fxdw within cu_tabpg_jobbom
integer x = 5
integer y = 324
integer width = 1737
integer height = 268
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_custom_mes_moldingjobcolorletdown"
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;
return Retrieve(WODID)

end event

event constructor;call super::constructor;
of_SetTransObject(SQLCA)

end event

event itemchanged;call super::itemchanged;
decimal letDownRate, pieceWeight, baseMaterialWeight, colorantWeight
choose case lower(dwo.Name)
	case lower("JobLetDownRate")
		letDownRate = dec(data)
		pieceWeight = object.PieceWeight[row]
		baseMaterialWeight = pieceWeight * (1 - letDownRate)
		colorantWeight = pieceWeight * letDownRate
end choose
object.BaseMaterialWeight[row] = baseMaterialWeight
object.ColorantWeight[row] = colorantWeight


end event

type cb_verify from commandbutton within cu_tabpg_jobbom
integer x = 1810
integer y = 1568
integer width = 489
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Verify BOM..."
end type

event clicked;
//	Open dialog to verify BOM:
open(w_mes_verifybom)

//	Check return value...
if	message.DoubleParm = 1 then
	
	//	Get the substitute part and substitution rate.
	string notes, operatorCode
	notes = message.inv_Parm.of_GetItem("Notes")
	operatorCode = message.inv_Parm.of_GetItem("OperatorCode")
	
	//	Verify BOM.
	n_cst_custom_mes_inventorytrans customMES
	customMES = create n_cst_custom_mes_inventorytrans
	customMES.VerifyBOM (WODID, notes, operatorCode)
	commit using SQLCA  ;
	destroy customMES
end if

Refreshing=true;
Refresh()

end event

type gb_2 from groupbox within cu_tabpg_jobbom
integer y = 248
integer width = 1751
integer height = 352
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "Molding Colorant"
end type

