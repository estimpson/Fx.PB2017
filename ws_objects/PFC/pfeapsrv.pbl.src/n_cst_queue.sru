$PBExportHeader$n_cst_queue.sru
$PBExportComments$Extension Queue List service
forward
global type n_cst_queue from pfc_n_cst_queue
end type
end forward

global type n_cst_queue from pfc_n_cst_queue
end type
global n_cst_queue n_cst_queue

on n_cst_queue.create
triggerevent( this, "constructor" )
end on

on n_cst_queue.destroy
triggerevent( this, "destructor" )
end on

