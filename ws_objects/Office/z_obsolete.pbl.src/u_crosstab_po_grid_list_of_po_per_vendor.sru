$PBExportHeader$u_crosstab_po_grid_list_of_po_per_vendor.sru
$PBExportComments$(mrs) Added 862 mode process.
forward
global type u_crosstab_po_grid_list_of_po_per_vendor from u_crosstab_po_grid_po_creation_ancestor
end type
type cbx_allpo from checkbox within u_crosstab_po_grid_list_of_po_per_vendor
end type
end forward

global type u_crosstab_po_grid_list_of_po_per_vendor from u_crosstab_po_grid_po_creation_ancestor
int Height=1028
cbx_allpo cbx_allpo
end type
global u_crosstab_po_grid_list_of_po_per_vendor u_crosstab_po_grid_list_of_po_per_vendor

type variables
boolean		ib_success = TRUE
boolean		ib_plant_no_match
s_parm_list	istr_parm_list

long		il_po

string		is_part, &
		is_plant
end variables

forward prototypes
public subroutine uf_initialize ()
public subroutine uf_fill_release_entry_dw (long al_po, string as_part, string as_vendor, date ad_date, decimal ac_qty)
public subroutine uf_save ()
public subroutine uf_insert_po (string as_vendor, string as_part, string as_plant)
end prototypes

public subroutine uf_initialize ();string		ls_vendor

date			ld_start, &
				ld_end

istr_parm_list	= message.powerobjectparm

ls_vendor	= istr_parm_list.s_parm_list[1]
is_plant	= istr_parm_list.s_parm_list[2]
is_part		= istr_parm_list.s_key_value

dw_selection.settransobject( SQLCA )
dw_selection.retrieve(ls_vendor,is_part)  // changed retrieval arguments to make sure po's with that part only show up.

IF cbx_allpo.checked = False then
	IF is_plant > '' THEN
		dw_selection.setfilter("plant = '" + trim(is_plant) + "'")
		dw_selection.filter()
	END IF
else
	dw_selection.setfilter("")
	dw_selection.filter()
end if 

IF dw_selection.rowcount() = 0 THEN
	ib_success	= FALSE
	IF messagebox( monsys.msg_title, "There is no active P.O. available for part: " + is_part + &
									" and  Vendor : " + ls_vendor + ". Would you like to add a PO now? ", StopSign!, YesNO! , 2) = 1 THEN
      	uf_insert_po(ls_vendor,is_part,is_plant)		
		opensheetwithparm(w_blanket_po_entry, il_po, wmainscreen, 3, layered!)	
	END IF
END IF
uo_release.uf_reset()


end subroutine

public subroutine uf_fill_release_entry_dw (long al_po, string as_part, string as_vendor, date ad_date, decimal ac_qty);Decimal 	lc_LeadTime, &
			lc_MinOnOrder, &
			lc_VendorStdPack, &
			lc_POQty

string	ls_po_um, &
			l_s_currency_unit

long		ll_release

SELECT 	part_vendor.receiving_um ,
		 	part_vendor.lead_time,
		 	part_vendor.min_on_order,
		 	part_vendor.vendor_standard_pack
  INTO 	:ls_po_um, :lc_LeadTime, :lc_MinOnOrder, :lc_VendorStdPack  
  FROM 	part_vendor  
 WHERE 	( part_vendor.part 		= :as_Part ) AND  
       	( part_vendor.vendor 	= :as_vendor );

SELECT po_header.release_no,
		 po_header.currency_unit
  INTO :ll_release,
  		 :l_s_currency_unit
  FROM po_header  
 WHERE po_header.po_number = :al_PO   ;

if isnull(ls_PO_UM) then
	ls_PO_UM	= f_get_part_info(as_Part, "STANDARD UNIT")
end If

lc_POQty	= Truncate(f_convert_units("", ls_PO_UM, as_Part, ac_qty), 4)

uo_release.uf_setup(String(ad_date), &
						  String(Truncate(ac_qty, 4)), &
						  String(lc_POQty), &
						  string(ll_release), &
						  '0', &
						  String(Truncate(lc_LeadTime, 2)), &
						  String(Truncate(lc_MinOnOrder, 2)), &
						  String(Truncate(lc_VendorStdPack, 2)), &
						  f_get_part_info(as_Part, "STANDARD UNIT"), &
						  ls_PO_UM, &
						  as_vendor, &
						  as_Part, &
						  l_s_currency_unit)

								  

								  
		
end subroutine

public subroutine uf_save ();if il_po > 0 then &
	uo_release.uf_create_po_detail(il_po, is_part, is_plant, istr_parm_list.b_parm_list[1], SQLCA )
end subroutine

public subroutine uf_insert_po (string as_vendor, string as_part, string as_plant);/* 01-26-2000 KAZ Modified to use 'of_getnextparmvalue' function instead of 'w_get_parm_value'
                  window to populate 'li_PO' (next PO number).  */

long	li_PO
string	ls_description, &
	ls_unit
datetime  ld_date
string	ls_terms, &
	ls_currencyunit
string	ls_units[]
int	li_show_euro[], &
	li_showeuroamt
	
if not sqlca.of_getnextparmvalue ( "purchase_order", li_PO ) then // Failed to get current value 		-  ADD 01-26-2000 KAZ
	 rollback;																														// ADD 01-26-2000 KAZ
	 messagebox(monsys.msg_title, "Failed to retrieve new PO #, unable to create PO! ", Information! )	// ADD 01-26-2000 KAZ
	 return																															// ADD 01-26-2000 KAZ
end if																																// ADD 01-26-2000 KAZ

ls_Unit				= f_get_part_info(as_Part, "STANDARD UNIT")
if isnull(ls_unit) or ls_unit = '' then ls_unit = 'EA' 
ls_description		= f_get_part_info(as_Part, "NAME")
ld_date				= datetime(today(), now())

select	terms
into	:ls_terms
from	vendor
where	code = :as_vendor;

sqlca.of_get_currency_unit ( '', as_Vendor, '', 0, 0, 0, ls_units[], li_show_euro[])
if UpperBound ( ls_units ) > 0 then &
	ls_currencyunit = ls_units[1]

if UpperBound ( li_show_euro ) > 0 then &
	li_showeuroamt = li_show_euro[1]

INSERT INTO po_header (
	po_number,
	vendor_code,
	po_date,
	status,
	type,
	description,
	plant,
	printed,
	blanket_part,
	std_unit,
	terms,
	currency_unit,
	show_euro_amount)
VALUES (
	:li_PO,
	:as_vendor,
	:ld_date,
	'A',
	'B',
	:ls_description,
	:as_plant,
	'N',
	:as_part,
	:ls_unit,
	:ls_terms,
	:ls_currencyunit,
	:li_showeuroamt) ;

if sqlca.sqlcode = 0 then
	 commit ;
	 il_po = li_PO
else
	 rollback ;
	 messagebox(monsys.msg_title, "Unable to create PO! " + sqlca.sqlerrtext, Information! )
end if

end subroutine

on u_crosstab_po_grid_list_of_po_per_vendor.create
int iCurrent
call super::create
this.cbx_allpo=create cbx_allpo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_allpo
end on

on u_crosstab_po_grid_list_of_po_per_vendor.destroy
call super::destroy
destroy(this.cbx_allpo)
end on

type dw_selection from u_crosstab_po_grid_po_creation_ancestor`dw_selection within u_crosstab_po_grid_list_of_po_per_vendor
event ue_message pbm_custom06
string DataObject="dw_active_po_per_vendor_grid"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_message;if ib_plant_no_match then
	MessageBox ( monsys.msg_title, "This P.O.'s plant code does not match any mps records!", StopSign! )
end if

end event

event dw_selection::clicked;call super::clicked;
/*
Description	:	To create 
Author		:	Jim Wu
Start Date	:	06/12/96
Modification:
*/

/* Declaration */
long		ll_row,&
			ll_count
string	ls_plant
			
/* Initialization */
ll_row	= this.getclickedrow()
uo_release.uf_reset()

/* Main Process */
if ll_row > 0 then

	il_po	= this.getitemnumber( ll_row, 'po_number' )
	parent.uf_fill_release_entry_dw( &
								il_po, &	
								istr_parm_list.s_key_value, &
								istr_parm_list.s_parm_list[1], &
								istr_parm_list.d_parm_list[2], & 
								istr_parm_list.c_parm_list[1] )
								// relativedate( istr_parm_list.d_parm_list[2], -7 ), &								

end if	 
end event

type cbx_allpo from checkbox within u_crosstab_po_grid_list_of_po_per_vendor
int X=41
int Y=940
int Width=1184
int Height=76
boolean BringToTop=true
string Text="Show all open POs for the current vendor"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean RightToLeft=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_release.uf_reset()
uf_initialize()
end event

