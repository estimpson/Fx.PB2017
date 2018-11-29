$PBExportHeader$dw.sru
forward
global type dw from dwsyntax
end type
end forward

global type dw from dwsyntax
string prefix = "release 10;"
end type

type variables

dwdatawindow	DWDataWindow
dwheader DWHeader
dwsummary DWSummary
dwfooter DWFooter
dwdetail DWDetail
dwtable DWTable
dwtext DWTextFields[]
dwcolumn DWColumnFields[]
dwcompute DWComputeFields[]

end variables

forward prototypes
public function string getsyntax ()
end prototypes

public function string getsyntax ();
string textFieldSyntax = ""
string columnFieldSyntax = ""

int i, textFields, columnFields, computeFields
textFields = UpperBound(DWTextFields)
for i = 1 to textFields
	textFieldSyntax += DWTextFields[i].GetSyntax() + CR
next

columnFields = UpperBound(DWColumnFields)
for i = 1 to columnFields
	columnfieldSyntax += DWColumnFields[i].GetSyntax() + CR
next

computeFields = UpperBound(DWComputeFields)
for i = 1 to computeFields
	columnfieldSyntax += DWComputeFields[i].GetSyntax() + CR
next

string	dwDataWindowSyntax 
string	dwHeaderSyntax
string	dwSummarySyntax
string	dwFooterSyntax
string	dwDetailSyntax 
string	dwTableSyntax

dwDataWindowSyntax = DWDataWindow.GetSyntax()
dwHeaderSyntax = DWHeader.GetSyntax()
dwSummarySyntax = DWSummary.GetSyntax()
dwFooterSyntax = DWFooter.GetSyntax()
dwDetailSyntax = DWDetail.GetSyntax()
dwTableSyntax = DWTable.GetSyntax()

return &
	Prefix + CR +&
	dwDataWindowSyntax + CR +&
	dwHeaderSyntax + CR +&
	dwSummarySyntax + CR +&
	dwFooterSyntax + CR +&
	dwDetailSyntax + CR +&
	dwTableSyntax + CR +&
	textFieldSyntax + columnFieldSyntax

end function

on dw.create
call super::create
end on

on dw.destroy
call super::destroy
end on

