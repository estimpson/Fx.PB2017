$PBExportHeader$w_sqlspyinspect.srw
$PBExportComments$Extension SQL Spy Inspect window
forward
global type w_sqlspyinspect from pfc_w_sqlspyinspect
end type
end forward

global type w_sqlspyinspect from pfc_w_sqlspyinspect
end type
global w_sqlspyinspect w_sqlspyinspect

on w_sqlspyinspect.create
call pfc_w_sqlspyinspect::create
end on

on w_sqlspyinspect.destroy
call pfc_w_sqlspyinspect::destroy
end on

