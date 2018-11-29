$PBExportHeader$n_partmaster_relatedpartitem.sru
forward
global type n_partmaster_relatedpartitem from n_base
end type
end forward

global type n_partmaster_relatedpartitem from n_base
end type
global n_partmaster_relatedpartitem n_partmaster_relatedpartitem

type variables

boolean IsGroup
string	GroupName, RelatedPart
end variables

on n_partmaster_relatedpartitem.create
call super::create
end on

on n_partmaster_relatedpartitem.destroy
call super::destroy
end on

