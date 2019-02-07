$PBExportHeader$n_outproc_definition.sru
forward
global type n_outproc_definition from n_base
end type
end forward

global type n_outproc_definition from n_base autoinstantiate
end type

type variables

//	Model Data
long OPDefRowID
string OutputPart
string InputPartList
string SupplierCode
long ActiveBlanketPONumber
int IsOutputDropShip
string NextPart
string ShipToSupplier

end variables
on n_outproc_definition.create
call super::create
end on

on n_outproc_definition.destroy
call super::destroy
end on

