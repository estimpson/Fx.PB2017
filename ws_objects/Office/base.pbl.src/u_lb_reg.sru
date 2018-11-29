$PBExportHeader$u_lb_reg.sru
forward
global type u_lb_reg from u_lb_base
end type
end forward

global type u_lb_reg from u_lb_base
boolean Sorted=false
end type
global u_lb_reg u_lb_reg

type variables
Public:

STRING	RegKey, &
	ItemValue [ ]
end variables

forward prototypes
public function integer reglist (string regspec, integer regtype)
end prototypes

public function integer reglist (string regspec, integer regtype);STRING	l_s_item [ ]

INTEGER	l_i_counter

Reset ( )
RegistryValues ( RegKey, l_s_item )

FOR l_i_counter = 1 TO UpperBound ( l_s_item )
	RegistryGet ( RegKey, l_s_item [ l_i_counter ], RegString!, ItemValue [ AddItem ( l_s_item [ l_i_counter ] ) ] )
NEXT

Return TotalItems ( )
end function

