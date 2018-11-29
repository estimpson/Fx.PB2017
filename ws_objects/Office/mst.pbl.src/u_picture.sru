$PBExportHeader$u_picture.sru
forward
global type u_picture from picture
end type
end forward

global type u_picture from picture
int Width=110
int Height=97
string PictureName="pallet.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type
global u_picture u_picture

type variables
long	il_sequence
end variables

on doubleclicked;parent.triggerevent( 'ue_view_flow_sequence', 0, il_sequence )
end on

