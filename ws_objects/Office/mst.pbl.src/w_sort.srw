$PBExportHeader$w_sort.srw
$PBExportComments$Select sort order for a datawindow
forward
global type w_sort from Window
end type
type cb_cancel from commandbutton within w_sort
end type
type cb_ok from commandbutton within w_sort
end type
type dw_1 from datawindow within w_sort
end type
end forward

global type w_sort from Window
int X=444
int Y=345
int Width=2021
int Height=1241
boolean TitleBar=true
long BackColor=12632256
boolean ControlMenu=true
WindowType WindowType=popup!
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_sort w_sort

type variables
datawindow idw_dw
string is_title

end variables

on open;string cols[],label,tmp,resp,col,vis,col_name
integer num_cols,i,cnt
str_sort parm

parm = message.powerobjectparm

idw_dw = parm.dw
is_title = parm.title
this.title = 'Sort - '+parm.title
num_cols = f_dw_get_objects_attrib(idw_dw,cols,'column','*','visible')
cnt = 1

for i = 1 to num_cols
	col_name =  f_get_token(cols[i],'~n') // get the column name
	vis = f_get_token(cols[i],'~n') // is it visible
	if vis = '1' then // if not visible then do not allow sorting on it
		label = idw_dw.Describe(col_name+"_t.text")
		if label = '!' then // label not found to use the column name
			tmp = "evaluate('wordcap(~""+col_name+"~")',1)" // make it pretty
			label =  idw_dw.Describe(tmp)
		end if
		dw_1.setvalue('col',cnt,label+'~t'+col_name)
		cnt++
		dw_1.insertrow(0)
	end if
next

dw_1.setvalue('col',cnt,'~t') // add a blank line so they can cancel
// only show the direction RB's if there is something in the row
resp = dw_1.Modify("direction.visible = '0~t if(len(col)>0,1,0)'")
if LenA(resp) > 0 then messagebox("",resp)
// SHow the current sort, if there is one
label = idw_dw.Describe('datawindow.table.sort')
if RightA(label,1) = '!' then label = LeftA(label,LenA(label) - 1)
cnt = 0
do while LenA(label) > 1 
	tmp = trim(f_get_token(label,','))
	col = f_get_token(tmp,' ')	
	cnt++
	dw_1.setitem(cnt,'col',col)
	dw_1.setitem(cnt,'direction',tmp)
loop

// size the window to the number of rows
If num_cols > 10 Then
	dw_1.height = 100 + 10 *integer(dw_1.Describe('datawindow.detail.height'))
Else
	dw_1.height = 100 + num_cols*integer(dw_1.Describe('datawindow.detail.height'))
End if

cb_ok.y = dw_1.height + 20
cb_cancel.y = cb_ok.y

this.height = cb_ok.y + cb_ok.height + 120
end on

on deactivate;Close ( w_sort )
end on

on w_sort.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={ this.cb_cancel,&
this.cb_ok,&
this.dw_1}
end on

on w_sort.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

type cb_cancel from commandbutton within w_sort
int X=1358
int Y=1017
int Width=298
int Height=109
int TabOrder=20
string Text="Cancel"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cb_ok from commandbutton within w_sort
int X=366
int Y=1021
int Width=298
int Height=109
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int i,cnt
string sort_list,tmp
cnt = dw_1.rowcount()
for i = 1 to cnt
	tmp = dw_1.getitemstring(i,'col')
	if LenA(trim(tmp)) > 0 then
		tmp = tmp + ' ' + dw_1.getitemstring(i,'Direction')
		if LenA(sort_list) > 0 then
			sort_list = sort_list + ', '+tmp
		else
			sort_list = tmp
		end if
	end if
next

if LenA(sort_list) > 0 then
	if idw_dw.setsort(sort_list) <> 1 then 
		messagebox(is_title,"Unable to set the sort. "+sort_list)
		return
	end if
	if idw_dw.sort() <> 1 then 
		messagebox(is_title,"Unable to perform sort. "+sort_list)
		return
	end if
end if

close(parent)

end on

type dw_1 from datawindow within w_sort
int Y=5
int Width=1980
int Height=993
int TabOrder=10
string DataObject="d_sort"
boolean Border=false
boolean LiveScroll=true
end type

