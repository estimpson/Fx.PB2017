$PBExportHeader$u_dw_po_detail_hard_queue_coverage.sru
$PBExportComments$mpo
forward
global type u_dw_po_detail_hard_queue_coverage from u_jw_dw_super
end type
end forward

global type u_dw_po_detail_hard_queue_coverage from u_jw_dw_super
int Width=1669
int Height=681
string DataObject="d_demand_from_hard_queue"
boolean TitleBar=true
string Title="Coverage for hard queue"
end type
global u_dw_po_detail_hard_queue_coverage u_dw_po_detail_hard_queue_coverage

forward prototypes
public subroutine uf_retrieve (string as_part)
end prototypes

public subroutine uf_retrieve (string as_part);this.retrieve( as_part )
end subroutine

