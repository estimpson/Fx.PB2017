$PBExportHeader$n_cst_dwsrv_legend.sru
$PBExportComments$(PFD)
forward
global type n_cst_dwsrv_legend from n_cst_dwsrv
end type
end forward

type os_resize from structure
	string		s_control
	string		s_typeof
	boolean		b_scale
	boolean		b_movex
	boolean		b_movey
	boolean		b_scalewidth
	boolean		b_scaleheight
	real		r_x
	real		r_y
	real		r_width
	real		r_height
	integer		i_movex
	integer		i_movey
	integer		i_scalewidth
	integer		i_scaleheight
end type

global type n_cst_dwsrv_legend from n_cst_dwsrv
event type integer pfc_resize ( unsignedlong aul_sizetype,  integer ai_newwidth,  integer ai_newheight )
end type
global n_cst_dwsrv_legend n_cst_dwsrv_legend

type variables
public:
// predefined resize constants.
constant string fixedright =  'fixedtoright'
constant string fixedbottom = 'fixedtobottom'
constant string fixedrightbottom = 'fixedtoright&bottom'
constant string scale = 'scale'
constant string scaleright = 'scaletoright'
constant string scalebottom = 'scaletobottom'
constant string scalerightbottom = 'scaletoright&bottom'
constant string fixedright_scalebottom = 'fixedtoright&scaletobottom'
constant string fixedbottom_scaleright = 'fixedtobottom&scaletoright'


protected:

constant string line='line'
constant string empty=''

integer	ii_rounding = 5
long 	il_parentminimumwidth=0
long	il_parentminimumheight=0
long	il_parentprevwidth=-1
long	il_parentprevheight=-1

os_resize	istr_registered[]

end variables

forward prototypes
public function integer of_setminsize (integer ai_minwidth, integer ai_minheight)
public function integer of_setorigsize (integer ai_width, integer ai_height)
protected function integer of_resize (integer ai_newwidth, integer ai_newheight)
public function integer of_register (string as_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_register (string as_control, string as_method)
public function integer of_setrequestor (u_dw adw_requestor)
public function integer of_register (dwobject adwo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_register (dwobject adwo_control, string as_method)
protected function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight)
public function integer of_unregister (string as_control)
public function integer of_unregister (dwobject adwo_control)
protected function integer of_getobjectinformation (string as_control, ref string as_type, ref integer ai_x, ref integer ai_y, ref integer ai_width, ref integer ai_height)
public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib)
public function integer of_getregisterable (ref string as_objects[])
public function boolean of_isregistered (string as_control)
public function boolean of_isregistered (dwobject adwo_control)
public function integer of_getregistered (dwobject adwo_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight)
public function integer of_getregistered (string as_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight)
public function integer of_getregistered (ref string as_control[], ref boolean ab_scale[], ref integer ai_movex[], ref integer ai_movey[], ref integer ai_scalewidth[], ref integer ai_scaleheight[])
public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib)
end prototypes

event pfc_resize;//////////////////////////////////////////////////////////////////////////////
//
//	event:  resize
//
//	description:
//	send resize notification to services.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

return of_resize(ai_newwidth, ai_newheight)
end event

public function integer of_setminsize (integer ai_minwidth, integer ai_minheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_setminsize
//

//	access:  		public
//
//	arguments:		
//	ai_minwidth		the minimum width for the parent object.
//	ai_minheight	the minimum height for the parent object.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	sets the current object minimum size attributes.
//						note: the service object needs to be initialized (of_setorigsize())
//						prior to	setting the minimum size of the object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//check parameters
if	isnull(ai_minwidth) or isnull(ai_minheight) then
	return -1
end if

//confirm that the user object has already been initialized
if il_parentprevheight=-1 and il_parentprevwidth=-1 then
	return -1
end if

//set the minimum values for the width and height
il_parentminimumwidth = ai_minwidth
il_parentminimumheight = ai_minheight

return 1

end function

public function integer of_setorigsize (integer ai_width, integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_setorigsize
//
//	access:  		public
//
//	arguments:		
//	ai_width			the current width of the parent object.
//	ai_height		the current height of the parent object.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	initializes the resize object by setting the current object
//						size.
//						note: the service object needs to be initialized (this function)
//						prior to	the registering (of_register()) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//check parameters
if isnull(ai_width) or isnull(ai_height) then
	return -1
end if

//set the current width and height
il_parentprevwidth = ai_width
il_parentprevheight = ai_height

return 1

end function

protected function integer of_resize (integer ai_newwidth, integer ai_newheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_resize
//
//	access:  		protected
//
//	arguments:		
//	ai_newwidth		the new width of the parent object.
//	ai_newheight	the new height of the parent object.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	moves or resizes objects that were registered with the service.
//						performs the actions that were requested via the
//						of_setorigsize() and of_register functions.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//note: for the line control: the width and height variables are
//										used to hold endx and endy attributes.
//////////////////////////////////////////////////////////////////////////////

//local variables
constant integer minimum_size =0

string			ls_control
string			ls_type
integer			li_upperbound
integer			li_rc
integer			li_cnt
integer			li_x, li_y, li_width, li_height
integer			li_deltawidth, li_deltaheight
real				lr_ratiowidth, lr_ratioheight
real				lr_move_deltax, lr_move_deltay
real				lr_resize_deltawidth, lr_resize_deltaheight
string			ls_singlemodifyexp, ls_complexmodifyexp
string			ls_modifyret
integer 			li_placewidth, li_placeheight

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//confirm that the user object has already been initialized
if il_parentprevheight=-1 and il_parentprevwidth=-1 then
	return -1
end if

//check the parameters
if isnull(ai_newwidth) or isnull(ai_newheight) then
	return -1
end if

//prevent the contents of the windows from resizing past the min width/height
if ai_newwidth < il_parentminimumwidth   then ai_newwidth = il_parentminimumwidth
if ai_newheight < il_parentminimumheight then ai_newheight = il_parentminimumheight

//set the deltas/ratios for the width and height as compared to the previous size
li_deltawidth  = ai_newwidth  - il_parentprevwidth 
li_deltaheight = ai_newheight - il_parentprevheight
if il_parentprevwidth=0 then il_parentprevwidth=1
if il_parentprevheight=0 then il_parentprevheight=1	
lr_ratiowidth  = ai_newwidth  / il_parentprevwidth
lr_ratioheight = ai_newheight / il_parentprevheight

//only continue if the size has changed
if li_deltawidth=0 and li_deltaheight=0 then return 1

//set the new previous size
il_parentprevwidth = ai_newwidth
il_parentprevheight = ai_newheight

///////////////////////////////////////////////////////////////////////////////////////////////
// loop through all registered controls - moving and resizing as appropriate
///////////////////////////////////////////////////////////////////////////////////////////////

//loop trough all controls
li_upperbound = upperbound (istr_registered[])
for li_cnt = 1 to li_upperbound
	
	//initialize variables
	li_x = 0
	li_y = 0 
	li_width = 0
	li_height = 0
	lr_move_deltax = 0	
	lr_move_deltay = 0
	lr_resize_deltawidth = 0	
	lr_resize_deltaheight = 0	
	ls_singlemodifyexp = ''
	
	if len(istr_registered[li_cnt].s_control) > 0 then
		li_rc = of_getobjectinformation (istr_registered[li_cnt].s_control, ls_type, li_x, li_y, li_width, li_height)
		if li_rc < 0 then return -1
		
		//correct for any ii_rounding or moving/resizing of objects trough
		//any other means
		if abs(istr_registered[li_cnt].r_x - li_x) > ii_rounding then
			istr_registered[li_cnt].r_x = li_x
		end if				
		if abs(istr_registered[li_cnt].r_y - li_y) > ii_rounding then
			istr_registered[li_cnt].r_y = li_y
		end if		
		if abs(istr_registered[li_cnt].r_width - li_width) > ii_rounding and &
		   li_width > minimum_size  then
			istr_registered[li_cnt].r_width = li_width
		end if							
		if abs(istr_registered[li_cnt].r_height - li_height) > ii_rounding and &
		   li_height > minimum_size  then
			istr_registered[li_cnt].r_height = li_height
		end if			
		
		//define the deltas for this control:  move and resize
		if istr_registered[li_cnt].b_scale then
			lr_move_deltax = (istr_registered[li_cnt].r_x * lr_ratiowidth) - istr_registered[li_cnt].r_x
			lr_move_deltay = (istr_registered[li_cnt].r_y * lr_ratioheight) - istr_registered[li_cnt].r_y
			lr_resize_deltawidth = (istr_registered[li_cnt].r_width * lr_ratiowidth) - istr_registered[li_cnt].r_width
			lr_resize_deltaheight = (istr_registered[li_cnt].r_height * lr_ratioheight) - istr_registered[li_cnt].r_height
		else
			// prevent the weighted value from being overriden.
			if istr_registered[li_cnt].b_movex and istr_registered[li_cnt].i_movex = 0 then
				istr_registered[li_cnt].i_movex = 100
			end if
			if istr_registered[li_cnt].b_movey and istr_registered[li_cnt].i_movey = 0 then
				istr_registered[li_cnt].i_movey = 100
			end if
			if istr_registered[li_cnt].b_scalewidth and istr_registered[li_cnt].i_scalewidth=0 then
				istr_registered[li_cnt].i_scalewidth = 100
			end if
			if istr_registered[li_cnt].b_scaleheight and istr_registered[li_cnt].i_scaleheight=0 then
				istr_registered[li_cnt].i_scaleheight = 100
			end if			
			
			// support for weighted movement and sizing of controls.
			if istr_registered[li_cnt].b_movex then 
				lr_move_deltax = li_deltawidth * istr_registered[li_cnt].i_movex / 100
			end if
			if istr_registered[li_cnt].b_movey then 
				lr_move_deltay = li_deltaheight * istr_registered[li_cnt].i_movey / 100
			end if
			if istr_registered[li_cnt].b_scalewidth then 
				lr_resize_deltawidth = li_deltawidth * istr_registered[li_cnt].i_scalewidth / 100
			end if
			if istr_registered[li_cnt].b_scaleheight then 
				lr_resize_deltaheight = li_deltaheight * istr_registered[li_cnt].i_scaleheight /100
			end if
		end if

		//if appropriate move the control along the x and y attribute.
		if lr_move_deltax <> 0 or lr_move_deltay <> 0 then	
			//save the 'exact' x and y attributes.
			istr_registered[li_cnt].r_x = istr_registered[li_cnt].r_x + lr_move_deltax		
			istr_registered[li_cnt].r_y = istr_registered[li_cnt].r_y + lr_move_deltay
			
			if pos(ls_type, line) > 0 then
				istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_move_deltax
				istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_move_deltay
				ls_singlemodifyexp = ls_singlemodifyexp + &
									istr_registered[li_cnt].s_control+'.x1 = '+string(integer(istr_registered[li_cnt].r_x))+' '+&
									istr_registered[li_cnt].s_control+'.x2 = '+string(integer(istr_registered[li_cnt].r_width))+' '+&
									istr_registered[li_cnt].s_control+'.y1 = '+string(integer(istr_registered[li_cnt].r_y))+' '+ &
									istr_registered[li_cnt].s_control+'.y2 = '+string(integer(istr_registered[li_cnt].r_height))+' '
			else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									istr_registered[li_cnt].s_control+'.x = '+string(integer(istr_registered[li_cnt].r_x))+' '+&
									istr_registered[li_cnt].s_control+'.y = '+string(integer(istr_registered[li_cnt].r_y))+' '					
			end if
		end if /* move */
		
		//if appropriate resize the width and height of the control.
		if lr_resize_deltawidth <> 0 or lr_resize_deltaheight <> 0 then		
			//save the 'exact' width and height attributes.
			istr_registered[li_cnt].r_width = istr_registered[li_cnt].r_width + lr_resize_deltawidth	
			istr_registered[li_cnt].r_height = istr_registered[li_cnt].r_height + lr_resize_deltaheight		

			// determine the placement variables.
			if istr_registered[li_cnt].r_width > minimum_size  then
				li_placewidth = istr_registered[li_cnt].r_width
			else
				li_placewidth = minimum_size 
			end if
			if istr_registered[li_cnt].r_height > minimum_size  then
				li_placeheight = istr_registered[li_cnt].r_height
			else
				li_placeheight = minimum_size 
			end if							
			
			if pos(ls_type, line) > 0 then
				ls_singlemodifyexp = ls_singlemodifyexp + &
									istr_registered[li_cnt].s_control+'.x2 = '+string(integer(li_placewidth))+' '+ &
									istr_registered[li_cnt].s_control+'.y2 = '+string(integer(li_placeheight))+' '				
			else
				ls_singlemodifyexp = ls_singlemodifyexp + &
									istr_registered[li_cnt].s_control+'.width = '+string(integer(li_placewidth))+' '+ &
									istr_registered[li_cnt].s_control+'.height = '+string(integer(li_placeheight))+' '				
			end if			
		end if /* resize */

		// batch all into one large modify expression.
		if len(ls_singlemodifyexp) > 0 then
			ls_complexmodifyexp += '   ' + ls_singlemodifyexp
		end if
		
	end if /* if isvalid(istr_registered[li_cnt].wo_control) then */
next /* for li_cnt = 1 to li_upperbound */

// execute the one modify expression.
if len(ls_complexmodifyexp) > 0 then
	ls_modifyret = idw_requestor.modify(ls_complexmodifyexp)
	if isnull(ls_modifyret) or len(ls_modifyret) > 0 then	
		return -1
	end if				
end if

return 1

end function

public function integer of_register (string as_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_register
//
//	access:  		public
//
//	arguments:		
//	 as_control			the object being registered.
//  ai_movex			the percentage to move the object along the x axis.
//  ai_movey			the percentage to move the object along the y axis.
//  ai_scalewidth 	the percentage to scale the object along the x axis.
//  ai_scaleheight	the percentage to scale the object along the y axis.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean 		lb_scale=false

return of_register (as_control, lb_scale, ai_movex, ai_movey, &
		ai_scalewidth, ai_scaleheight)

end function

public function integer of_register (string as_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_register
//
//	access:  		public
//
//	arguments:		
//	as_control		the object being registered.
//	as_method		the desired resize/move method.
//						valid values are:
//						 'fixedtoright'
//						 'fixedtobottom'
//						 'fixedtoright&bottom'
//						 'scale'
//						 'scaletoright'
//						 'scaletobottom'
//						 'scaletoright&bottom'
//						 'fixedtoright&scaletobottom'
//						 'fixedtobottom&scaletoright'
//
//	returns:  		integer
//	1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//	register a control which needs to either be moved or resized
//	when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

constant integer full_percent= 100
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
integer			li_movex, li_movey
integer			li_scalewidth, li_scaleheight
boolean			lb_scale=false

//check parameters
if isnull(as_control) or len(trim(as_control))=0 or isnull(as_method) then
	return -1
end if

//translate and finish validating parameteters
choose case lower(as_method)
	case lower(fixedright)
		li_movex = full_percent
	case lower(fixedbottom)
		li_movey = full_percent
	case lower(fixedrightbottom)
		li_movex = full_percent
		li_movey = full_percent
	case lower(scale)
		lb_scale = true
	case lower(scaleright)
		li_scalewidth = full_percent
	case lower(scalebottom)
		li_scaleheight = full_percent
	case lower(scalerightbottom)
		li_scalewidth = full_percent
		li_scaleheight = full_percent
	case lower(fixedright_scalebottom)		
		li_movex = full_percent
		li_scaleheight = full_percent
	case lower(fixedbottom_scaleright)	
		li_movey = full_percent
		li_scalewidth = full_percent
case else
		return -1
end choose

return of_register(as_control, lb_scale, &
		li_movex, li_movey, li_scalewidth, li_scaleheight)
end function

public function integer of_setrequestor (u_dw adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_setrequestor
//
//	access:    public
//
//	arguments:
//   adw_requestor   the datawindow requesting the service
//
//	returns:  integer
//
//	description:  associates a datawindow control with a datawindow service nvo
//			        by setting the idw_requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_describeret
constant string composite='5'
constant string rte='7'

// validate the reference.
if isnull(adw_requestor) or not isvalid(adw_requestor) then
	return -1
end if

// confirm this datawindow does not contain an unsupported object.
ls_describeret = adw_requestor.object.datawindow.processing
//0 form, group, query, or tabular
//1 grid, 2 label, 3 graph, 4 crosstab
//5 composite, 6 ole, 7 rte
if ls_describeret=composite or ls_describeret=rte then 
	return -1
end if

idw_requestor = adw_requestor
return 1
end function

public function integer of_register (dwobject adwo_control, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_register
//
//	access:  		public
//
//	arguments:		
//	 adwo_control		the object being registered.
//  ai_movex			the percentage to move the object along the x axis.
//  ai_movey			the percentage to move the object along the y axis.
//  ai_scalewidth 	the percentage to scale the object along the x axis.
//  ai_scaleheight	the percentage to scale the object along the y axis.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	register a control which needs to either be moved or resized
//						when the parent object is resized.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_objname

//check parameters
if isnull(adwo_control) then
	return -1
end if

ls_objname = adwo_control.name
return of_register(ls_objname, ai_movex, ai_movey, ai_scalewidth, ai_scaleheight)
end function

public function integer of_register (dwobject adwo_control, string as_method);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_register
//
//	access:  		public
//
//	arguments:		
//	as_control		the object being registered.
//	as_method		the desired resize/move method.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	register a control which needs to either be moved or resized
//						when the parent object is resized. 
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_objname

//check parameters
if isnull(adwo_control) then
	return -1
end if

ls_objname = adwo_control.name
return of_register(ls_objname, as_method)
end function

protected function integer of_register (string as_control, boolean ab_scale, integer ai_movex, integer ai_movey, integer ai_scalewidth, integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_register
//
//	access:  		protected
//
//	arguments:		
//	 as_control			the object being registered.
//  ab_scale			if the object should be registered as a scale type.
//  ai_movex			the percentage to move the object along the x axis.
//  ai_movey			the percentage to move the object along the y axis.
//  ai_scalewidth 	the percentage to scale the object along the x axis.
//  ai_scaleheight	the percentage to scale the object along the y axis.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//	register a control which needs to either be moved or resized when the parent
//	object is resized.  the action taken on this control depends on the four
//	attributes: ai_movex, ai ai_movey, ai_scalewidth, ai_scaleheight.
//
//	note:
//	the service object needs to be initialized (of_setorigsize()) prior to	
//	any registering (this function) of objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer			li_rc
integer			li_x, li_y, li_width, li_height
integer			li_upperbound
integer			li_cnt
integer			li_slot_available
boolean			lb_movex=false, lb_movey=false
boolean			lb_scalewidth=false, lb_scaleheight=false
string			ls_describeret, ls_describeexp
string			ls_type

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//check parameters
if isnull(as_control) or len(trim(as_control))=0 or &
	isnull(ab_scale) or &
	isnull(ai_movex) or ai_movex<0 or ai_movex>100 or &
	isnull(ai_movey) or ai_movey<0 or ai_movey>100 or &
	isnull(ai_scalewidth) or ai_scalewidth<0 or ai_scalewidth>100 or & 
	isnull(ai_scaleheight) or ai_scaleheight<0 or ai_scaleheight>100 then
	return -1
end if

// validate the object.
ls_describeret = idw_requestor.describe(as_control+'.attributes')
if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' then
	return -1
end if

//translate parameteters.
if ab_scale then
	ai_movex = 0
	ai_movey = 0
	ai_scalewidth = 0
	ai_scaleheight = 0
end if
lb_movex = (ai_movex > 0)
lb_movey = (ai_movey > 0)
lb_scalewidth = (ai_scalewidth > 0)
lb_scaleheight = (ai_scaleheight > 0)

//confirm that the user object has already been initialized
if il_parentprevheight=-1 and il_parentprevwidth=-1 then
	return -1
end if

//get the previous bound
li_upperbound = upperbound (istr_registered[])

//determine if there is an open slot available other than a
//new entry on the array
li_slot_available = 0
for li_cnt = 1 to li_upperbound
	if isnull(istr_registered[li_cnt].s_control) or &
		len(trim(istr_registered[li_cnt].s_control))=0 then
		if li_slot_available = 0 then
			//get the first slot found
			li_slot_available = li_cnt
		end if
	else
		//check if control has already been registered
		if istr_registered[li_cnt].s_control = as_control then
			return -1
		end if
	end if
next

//if an available slot was not found then create a new entry
if li_slot_available = 0 then
	li_slot_available = li_upperbound + 1
end if

///////////////////////////////////////////////////////////////////////////////////////
//get the current object information/coordinates
///////////////////////////////////////////////////////////////////////////////////////
li_rc = of_getobjectinformation (as_control, ls_type, li_x, li_y, li_width, li_height)
if li_rc < 0 then return -1

///////////////////////////////////////////////////////////////////////////////////////
//register the new object
///////////////////////////////////////////////////////////////////////////////////////

//register the actual object
istr_registered[li_slot_available].s_control = as_control
istr_registered[li_slot_available].s_typeof = ls_type	

//set the behavior attributes
istr_registered[li_slot_available].b_movex = lb_movex
istr_registered[li_slot_available].i_movex = ai_movex
istr_registered[li_slot_available].b_movey = lb_movey
istr_registered[li_slot_available].i_movey = ai_movey
istr_registered[li_slot_available].b_scalewidth = lb_scalewidth
istr_registered[li_slot_available].i_scalewidth = ai_scalewidth
istr_registered[li_slot_available].b_scaleheight = lb_scaleheight
istr_registered[li_slot_available].i_scaleheight = ai_scaleheight
istr_registered[li_slot_available].b_scale = ab_scale

//set the initial position/size attributes
istr_registered[li_slot_available].r_x = li_x
istr_registered[li_slot_available].r_y = li_y
istr_registered[li_slot_available].r_width = li_width
istr_registered[li_slot_available].r_height = li_height

return 1

end function

public function integer of_unregister (string as_control);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_unregister	
//
//	access:  		public
//
//	arguments:		
//	as_control		the control to unregister.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer			li_upperbound
integer			li_cnt
integer			li_registered_slot

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//check parameters
if isnull(as_control) or len(trim(as_control))=0 then
	return -1
end if

//confirm that the user object has already been initialized
if il_parentprevheight=-1 and il_parentprevwidth=-1 then
	return -1
end if

//get the current upperbound
li_upperbound = upperbound (istr_registered[])

//find the registered object
li_registered_slot = 0
for li_cnt = 1 to li_upperbound
	if istr_registered[li_cnt].s_control = as_control then
		li_registered_slot = li_cnt
		exit
	end if
next

//if the control was not previously registered, return
//an error code.
if li_registered_slot = 0 then
	return -1
end if

//unregister the control
istr_registered[li_registered_slot].s_control = empty
istr_registered[li_registered_slot].s_typeof = ''
istr_registered[li_registered_slot].b_movex = false
istr_registered[li_registered_slot].i_movex = 0
istr_registered[li_registered_slot].b_movey = false
istr_registered[li_registered_slot].i_movey = 0
istr_registered[li_registered_slot].b_scalewidth = false
istr_registered[li_registered_slot].i_scalewidth = 0
istr_registered[li_registered_slot].b_scaleheight = false
istr_registered[li_registered_slot].i_scaleheight = 0

return 1

end function

public function integer of_unregister (dwobject adwo_control);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_unregister	
//
//	access:  		public
//
//	arguments:		
//	as_control		the control to unregister.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	unregister a control that was previously registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_objname

// validate the reference.
if isnull(adwo_control) then
	return -1
end if

ls_objname = adwo_control.name
return of_unregister(ls_objname)
end function

protected function integer of_getobjectinformation (string as_control, ref string as_type, ref integer ai_x, ref integer ai_y, ref integer ai_width, ref integer ai_height);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getobjectinformation
//
//	scope:  		protected
//
//	arguments:		
//	 as_control		the object whose current information is needed.
//  as_type(by reference)	the object type.
//  ai_x(by reference)		the object x.
//	 ai_y(by reference)		the object y.
//  ai_width(by reference)	the object width.		
//  ai_height(by reference) the object height.
//
//	returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//		get the desired object information from the datawindow object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string  ls_type
string  ls_describeret
integer li_x
integer li_y
integer li_height
integer li_width

// validate the reference.
if isnull(idw_requestor) or not isvalid(idw_requestor) then
	return -1
end if

//validate and set type value
ls_describeret = idw_requestor.describe(as_control+'.type')
if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' then
	return -1
end if
ls_type = ls_describeret

//get the coordinates.
if pos(ls_type, line) > 0 then
	ls_describeret = idw_requestor.describe(as_control+'.x1')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_x = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.y1')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_y = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.x2')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_width = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.y2')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_height = integer (ls_describeret)	
else
	ls_describeret = idw_requestor.describe(as_control+'.x')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_x = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.y')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_y = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.width')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_width = integer (ls_describeret)

	ls_describeret = idw_requestor.describe(as_control+'.height')
	if isnull(ls_describeret) or ls_describeret='!' or ls_describeret='?' or not isnumber(ls_describeret) then
		return -1
	end if
	li_height = integer (ls_describeret)
end if

as_type = ls_type
ai_x = li_x
ai_y = li_y
ai_width = li_width
ai_height = li_height
return 1
end function

public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getinfo
//
//	access:   		public
//
//	arguments:		
//		anv_infoattrib	(by reference) the information attributes.
//
//	returns:  		integer
//	 1 for success.
//	-1 for error.
//
//	description:  
//	 gets the service information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0    initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// populate information.
anv_infoattrib.is_name = 'resize'
anv_infoattrib.is_description = &
	'provides resize functionality to any object in proportion to its container.'

return 1
end function

public function integer of_getregisterable (ref string as_objects[]);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getregisterable
//
//	access:    		public
//
//	arguments:
//   as_objects[] (by ref)	 will hold all the objects that can be registered.
//
//	returns:   		integer
// number of entries in array.
//	-1 if an error occurs.
//
//	description:  
//	to get the list of all the objects that can be registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_numobjs
string	ls_objects[]
string	ls_empty[]

// clear the reference variable.
as_objects = ls_empty

// get all the visible objects on the datawindow.
// objects that are not visible do not coordinates and therefore cannot be registered.
li_numobjs = of_getobjects ( ls_objects, "*", "*", true ) 
if li_numobjs < 0 then return -1

// return the objects.
as_objects = ls_objects
return upperbound(as_objects)



end function

public function boolean of_isregistered (string as_control);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_isregistered
//
//	access:  		public
//
//	arguments:
//	as_control		object to test if registered.
//
//	returns:  		boolean
//	 true if the object is registered.
//	 false if not.
//
//	description:
//	 determine if the passed in object is registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer 		li_count
integer		li_cnt

// check arguments
if isnull(as_control) or len(trim(as_control))=0 then 
	return false
end if

// loop to find entry.
li_count = upperbound(istr_registered)
for li_cnt = 1 to li_count
	if istr_registered[li_cnt].s_control = as_control then
		return true
	end if
next

return false
end function

public function boolean of_isregistered (dwobject adwo_control);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_isregistered
//
//	access:  		public
//
//	arguments:		
//	adwo_control 	object to test if registered.
//
//	returns:  		boolean
//	 true if the object is registered.
//	 false if not.
//
//	description:
//	 determine if the passed in object is registered.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_control

//check parameters
if isnull(adwo_control) then
	return false
end if

ls_control = adwo_control.name
return of_isregistered(ls_control)
end function

public function integer of_getregistered (dwobject adwo_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getregistered
//
//	access:  		public
//
//	arguments:		
//	 adwo_control		the registered object.
//	 ab_scale			(by ref) the scale switch.
//  ai_movex			(by ref) the percentage to move the object along the x axis.
//  ai_movey			(by ref) the percentage to move the object along the y axis.
//  ai_scalewidth 	(by ref) the percentage to scale the object along the x axis.
//  ai_scaleheight	(by ref) the percentage to scale the object along the y axis.
//
//	returns:  		integer
//	1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//	get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_control

// initilize reference variables.
ab_scale = false
ai_movex = 0
ai_movey = 0
ai_scalewidth = 0
ai_scaleheight = 0

//check parameters
if isnull(adwo_control) then
	return -1
end if

ls_control = adwo_control.name
return of_getregistered(ls_control, ab_scale, &
	ai_movex, ai_movey, ai_scalewidth, ai_scaleheight)
end function

public function integer of_getregistered (string as_control, ref boolean ab_scale, ref integer ai_movex, ref integer ai_movey, ref integer ai_scalewidth, ref integer ai_scaleheight);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getregistered
//
//	access:  		public
//
//	arguments:		
//	 as_control			the registered object.
//	 ab_scale			(by ref) the scale switch.
//  ai_movex			(by ref) the percentage to move the object along the x axis.
//  ai_movey			(by ref) the percentage to move the object along the y axis.
//  ai_scalewidth 	(by ref) the percentage to scale the object along the x axis.
//  ai_scaleheight	(by ref) the percentage to scale the object along the y axis.
//
//	returns:  		integer
//	1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//	get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_count
integer	li_cnt

// initilize reference variables.
ab_scale = false
ai_movex = 0
ai_movey = 0
ai_scalewidth = 0
ai_scaleheight = 0

// loop to find entry.
li_count = upperbound(istr_registered)
for li_cnt = 1 to li_count
	if istr_registered[li_cnt].s_control = as_control then
		// set the reference variables and return.
		ab_scale = istr_registered[li_cnt].b_scale
		ai_movex = istr_registered[li_cnt].i_movex
		ai_movey = istr_registered[li_cnt].i_movey
		ai_scalewidth = istr_registered[li_cnt].i_scalewidth
		ai_scaleheight = istr_registered[li_cnt].i_scaleheight
		return 1
	end if
next

// did not find the entry.
return -1

end function

public function integer of_getregistered (ref string as_control[], ref boolean ab_scale[], ref integer ai_movex[], ref integer ai_movey[], ref integer ai_scalewidth[], ref integer ai_scaleheight[]);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getregistered
//
//	access:  		public
//
//	arguments:		
//	 as_control[]		(by ref) all of the registered objects.
//	 ab_scale[]			(by ref) the scale switch.
//  ai_movex[]			(by ref) the percentage to move the object along the x axis.
//  ai_movey[]			(by ref) the percentage to move the object along the y axis.
//  ai_scalewidth[] 	(by ref) the percentage to scale the object along the x axis.
//  ai_scaleheight[]	(by ref) the percentage to scale the object along the y axis.
//
//	returns:  		integer
//	1 if it succeeds and -1 if an error occurs.
//
//	description:  	
//	get the registered information for the passed in object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0   initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_regcount
integer	li_count
integer	li_cnt
boolean	lb_empty[]
integer	li_empty[]

// initilize reference variables.
ab_scale = lb_empty
ai_movex = li_empty
ai_movey = li_empty
ai_scalewidth = li_empty
ai_scaleheight = li_empty

// loop to find and populate all the entries.
li_count = upperbound(istr_registered)
for li_cnt = 1 to li_count
	if len(trim(istr_registered[li_cnt].s_control)) > 0 then

		li_regcount ++
		
		as_control[li_regcount] = istr_registered[li_cnt].s_control
		ab_scale[li_regcount] = istr_registered[li_cnt].b_scale
		ai_movex[li_regcount] = istr_registered[li_cnt].i_movex
		ai_movey[li_regcount] = istr_registered[li_cnt].i_movey
		ai_scalewidth[li_regcount] = istr_registered[li_cnt].i_scalewidth
		ai_scaleheight[li_regcount] = istr_registered[li_cnt].i_scaleheight
	end if
next

return li_regcount

end function

public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib);//////////////////////////////////////////////////////////////////////////////
//
//	function:  		of_getpropertyinfo
//
//	access:   		public
//
//	arguments:		
//		anv_attrib	(by ref.) the property information attributes.
//
//	returns:  		integer
//	 1 for success.
//	-1 for error.
//
//	description:  
//	 gets the service property information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	revision history
//
//	version
//	6.0    initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

n_cst_infoattrib lnv_infoattrib

// get the first two attributes from the main information attributes.
of_getinfo(lnv_infoattrib)
anv_attrib.is_name = lnv_infoattrib.is_name
anv_attrib.is_description = lnv_infoattrib.is_description

// set the rest of the attributes.
anv_attrib.is_propertypage = {'u_tabpg_dwproperty_srvresize'}
anv_attrib.ib_switchbuttons = true

return 1
end function

on n_cst_dwsrv_legend.create
triggerevent( this, "constructor" )
end on

on n_cst_dwsrv_legend.destroy
triggerevent( this, "destructor" )
end on

event constructor;//////////////////////////////////////////////////////////////////////////////
//
//	event:  pfc_n_cst_resize
//
//	description:
//	dw resize service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	revision history
//
//	version
//	6.0   initial version - c. quant
//
//////////////////////////////////////////////////////////////////////////////
//
//	copyright © 1996-1997 sybase, inc. and its subsidiaries.  all rights reserved.
//	any distribution of the powerbuilder foundation classes (pfc)
//	source code by other than sybase, inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
end event

