HA$PBExportHeader$u_sectioncollapser_categoryunitclass.sru
forward
global type u_sectioncollapser_categoryunitclass from u_control_sectioncollapser
end type
end forward

global type u_sectioncollapser_categoryunitclass from u_control_sectioncollapser
integer width = 1334
end type
global u_sectioncollapser_categoryunitclass u_sectioncollapser_categoryunitclass

on u_sectioncollapser_categoryunitclass.create
call super::create
end on

on u_sectioncollapser_categoryunitclass.destroy
call super::destroy
end on

type st_1 from u_control_sectioncollapser`st_1 within u_sectioncollapser_categoryunitclass
integer width = 1056
string text = "Categories / Units / Classification Codes"
end type

type dw_1 from u_control_sectioncollapser`dw_1 within u_sectioncollapser_categoryunitclass
end type

type ln_1 from u_control_sectioncollapser`ln_1 within u_sectioncollapser_categoryunitclass
integer endx = 1334
end type

type ln_2 from u_control_sectioncollapser`ln_2 within u_sectioncollapser_categoryunitclass
integer endx = 1334
end type

