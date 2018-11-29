$PBExportHeader$u_notes.sru
forward
global type u_notes from pfc_u_notes
end type
end forward

global type u_notes from pfc_u_notes
end type
global u_notes u_notes

on u_notes.create
call super::create
end on

on u_notes.destroy
call super::destroy
end on

type dw_note from pfc_u_notes`dw_note within u_notes
end type

