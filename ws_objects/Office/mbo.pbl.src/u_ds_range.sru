$PBExportHeader$u_ds_range.sru
$PBExportComments$Expands an object.datawindow.selected string into a list of rows and columns in a range.
forward
global type u_ds_range from datastore
end type
end forward

global type u_ds_range from datastore
string DataObject="d_range"
end type
global u_ds_range u_ds_range

type variables
DataStore	ds_source
end variables

forward prototypes
public function integer uf_import_range (string range)
public function integer uf_set_source (STRING sorce_do)
end prototypes

public function integer uf_import_range (string range);STRING	l_s_range, &
			l_s_sub_range

INTEGER	l_i_next

LONG	l_l_begin_row, &
		l_l_end_row, &
		l_l_row, &
		l_l_column

Reset ( )
l_s_range = range

DO
	l_i_next = PosA ( l_s_range, ';' )
	IF l_i_next > 0 THEN
		l_s_sub_range = LeftA ( l_s_range, l_i_next - 1 )
		l_s_range = RightA ( l_s_range, LenA ( l_s_range ) - l_i_next )
	ELSE
		l_s_sub_range = l_s_range
		l_s_range = ""
	END IF
	l_i_next = PosA ( l_s_sub_range, '/' )
	l_l_begin_row = Long ( LeftA ( l_s_sub_range, l_i_next - 1 ) )
	l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )

	l_i_next = PosA ( l_s_sub_range, '/' )
	l_l_end_row = Long ( LeftA ( l_s_sub_range, l_i_next - 1 ) )
	l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )

	DO
		l_i_next = PosA ( l_s_sub_range, '/' )
		IF l_i_next > 0 THEN
			l_l_column = Long ( ds_source.Describe ( LeftA ( l_s_sub_range, l_i_next - 1 ) + ".ID" ) )
			l_s_sub_range = RightA ( l_s_sub_range, LenA ( l_s_sub_range ) - l_i_next )
		ELSE
			l_l_column = Long ( ds_source.Describe ( l_s_sub_range + ".ID" ) )
			l_s_sub_range = ""
		END IF
		IF l_l_begin_row < l_l_end_row THEN
			FOR l_l_row = l_l_begin_row TO l_l_end_row
				InsertRow ( 1 )
				object.range_row [ 1 ] = l_l_row
				object.range_col [ 1 ] = l_l_column
			NEXT
		ELSE
			FOR l_l_row = l_l_end_row TO l_l_begin_row
				InsertRow ( 1 )
				object.range_row [ 1 ] = l_l_row
				object.range_col [ 1 ] = l_l_column
			NEXT
		END IF
//		InsertRow ( 1 )
//		object.range_row [ 1 ] = l_l_end_row
//		object.range_col [ 1 ] = l_l_column
	LOOP WHILE l_s_sub_range > ""

LOOP WHILE l_s_range > ""
Sort ( )
GroupCalc ( )
Filter ( )
Return RowCount ( )
end function

public function integer uf_set_source (STRING sorce_do);IF NOT IsValid ( ds_source ) THEN
	ds_source = CREATE DataStore
END IF
ds_source.DataOBject = sorce_do
Return ds_source.InsertRow ( 1 )
end function

on u_ds_range.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_range.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

