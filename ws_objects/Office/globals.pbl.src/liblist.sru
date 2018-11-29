$PBExportHeader$liblist.sru
forward
global type liblist from nonvisualobject
end type
end forward

global type liblist from nonvisualobject
end type
global liblist liblist

type variables
Application	App

Private:
BOOLEAN	i_b_initiated

STRING	i_s_initial_list [ ], &
	i_s_cur_list
end variables

forward prototypes
public function integer uf_initiate_list ()
public function integer uf_add_library (string lib_name)
public function integer uf_remove_library (string lib_name)
public function integer uf_restore_list ()
end prototypes

public function integer uf_initiate_list ();STRING	l_s_reg
INTEGER	l_i_count

IF i_b_initiated THEN
	Return -1
END IF

l_s_reg = registry.MonitorLibList + "\" + monsys.title
RegistryValues ( l_s_reg, i_s_initial_list )

IF UpperBound ( i_s_initial_list ) = 0 THEN
	Return 0
END IF

i_b_initiated = TRUE

FOR l_i_count = 1 TO UpperBound ( i_s_initial_list ) - 1
	i_s_cur_list += i_s_initial_list [ l_i_count ] + ","
NEXT
i_s_cur_list += i_s_initial_list [ l_i_count ]

Return UpperBound ( i_s_initial_list )
end function

public function integer uf_add_library (string lib_name);IF NOT i_b_initiated THEN
	Return -1
END IF
i_s_cur_list += "," + lib_name

Return app.SetLibraryList ( i_s_cur_list )
end function

public function integer uf_remove_library (string lib_name);INTEGER	l_i_list_len, &
			l_i_lib_len, &
			l_i_lib_pos

IF NOT i_b_initiated THEN
	Return -1
END IF

l_i_list_len = LenA ( i_s_cur_list )
l_i_lib_len = LenA ( lib_name )

IF LeftA ( i_s_cur_list, l_i_lib_len + 1 ) = lib_name + "," THEN
	i_s_cur_list = RightA ( i_s_cur_list, l_i_list_len - l_i_lib_len - 1 )
	Return app.SetLibraryList ( i_s_cur_list )
END IF

IF RightA ( i_s_cur_list, l_i_lib_len + 1 ) = "," + lib_name THEN
	i_s_cur_list = LeftA ( i_s_cur_list, l_i_list_len - l_i_lib_len - 1 )
	Return app.SetLibraryList ( i_s_cur_list )
END IF

l_i_lib_pos = PosA ( i_s_cur_list, "," + lib_name + "," )
IF l_i_lib_pos > 1 THEN
	i_s_cur_list = LeftA ( i_s_cur_list, l_i_lib_pos ) + &
						RightA ( i_s_cur_list, l_i_list_len - ( l_i_lib_pos + l_i_lib_len ) - 1 )
	Return app.SetLibraryList ( i_s_cur_list )
END IF

Return -2
end function

public function integer uf_restore_list ();INTEGER	l_i_count

IF NOT i_b_initiated THEN
	Return -1
END IF

IF UpperBound ( i_s_initial_list ) = 0 THEN
	Return -2
END IF

i_s_cur_list = ""
FOR l_i_count = 1 TO UpperBound ( i_s_initial_list ) - 1
	i_s_cur_list += i_s_initial_list [ l_i_count ] + ","
NEXT
i_s_cur_list += i_s_initial_list [ l_i_count ]

Return app.SetLibraryList ( i_s_cur_list )
end function

on liblist.create
TriggerEvent( this, "constructor" )
end on

on liblist.destroy
TriggerEvent( this, "destructor" )
end on

