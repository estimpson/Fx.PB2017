$PBExportHeader$w_fxcop_integratedsetups.srw
forward
global type w_fxcop_integratedsetups from w_sheet_headerdetail_4t
end type
type tabpage_overview from u_tabpg_integrated_machinemfg within tab_1
end type
type tabpage_overview from u_tabpg_integrated_machinemfg within tab_1
end type
type p_smalllogo from picture within w_fxcop_integratedsetups
end type
type p_banner from picture within w_fxcop_integratedsetups
end type
end forward

global type w_fxcop_integratedsetups from w_sheet_headerdetail_4t
integer width = 2523
integer height = 2732
string title = "Integrated Setups"
string menuname = "m_sheet_4t_updateablenew"
long backcolor = 0
p_smalllogo p_smalllogo
p_banner p_banner
end type
global w_fxcop_integratedsetups w_fxcop_integratedsetups

on w_fxcop_integratedsetups.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_sheet_4t_updateablenew" then this.MenuID = create m_sheet_4t_updateablenew
this.p_smalllogo=create p_smalllogo
this.p_banner=create p_banner
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_smalllogo
this.Control[iCurrent+2]=this.p_banner
end on

on w_fxcop_integratedsetups.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_smalllogo)
destroy(this.p_banner)
end on

event pfc_preopen;call super::pfc_preopen;
inv_Resize.of_Register(p_smalllogo, 100, 0, 0, 0)
inv_Resize.of_Register(p_banner, 50, 0, 0, 0)

end event

event pfc_refresh;call super::pfc_refresh;
tab_1.tabpage_overview.Refresh()

end event

event pfc_save;call super::pfc_save;
return tab_1.tabpage_overview.Save()

end event

type tab_1 from w_sheet_headerdetail_4t`tab_1 within w_fxcop_integratedsetups
integer y = 336
tabpage_overview tabpage_overview
end type

on tab_1.create
this.tabpage_overview=create tabpage_overview
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_overview
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_overview)
end on

type tab_2 from w_sheet_headerdetail_4t`tab_2 within w_fxcop_integratedsetups
integer y = 1524
end type

type st_1 from w_sheet_headerdetail_4t`st_1 within w_fxcop_integratedsetups
integer y = 1504
end type

type tabpage_overview from u_tabpg_integrated_machinemfg within tab_1
integer x = 18
integer y = 100
integer width = 2263
integer height = 1064
end type

type p_smalllogo from picture within w_fxcop_integratedsetups
integer x = 1307
integer width = 1001
integer height = 336
boolean bringtotop = true
boolean originalsize = true
string picturename = "SmallLogo.jpg"
boolean focusrectangle = false
end type

type p_banner from picture within w_fxcop_integratedsetups
integer x = 192
integer y = 44
integer width = 1371
integer height = 196
boolean originalsize = true
string picturename = "FX_IntegratedSetups.jpg"
boolean focusrectangle = false
end type

