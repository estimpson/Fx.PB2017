$PBExportHeader$u_dw_edi_header.sru
$PBExportComments$(med)
forward
global type u_dw_edi_header from u_dw_edi_ancestor
end type
end forward

global type u_dw_edi_header from u_dw_edi_ancestor
end type
global u_dw_edi_header u_dw_edi_header

forward prototypes
public subroutine uf_setup ()
end prototypes

public subroutine uf_setup ();// At this point the datawindow for the header has been retrieved from the database.
// This function gets any additional header information from the parent window (i.e. purpose code)

WindowObject		lwo_Control
CheckBox			lcb_Control
DataWindow			ldw_Control
DropDownListBox	lddlb_Control
EditMask			lem_Control
ListBox			llb_Control
MultiLineEdit		lmle_Control
RadioButton		lrb_Control
SingleLineEdit	lsle_Control
StaticText			lst_Control

LONG			ll_ControlCount, &
				ll_ColumnNumber, &
				ll_SourceColumnNumber

STRING			ls_TagValue, &
				ls_ColumnName, &
				ls_Value, &
				ls_SourceColumnName, &
				ls_Describe

IF IsValid ( iw_Parent ) = FALSE THEN
	Return
END IF

FOR ll_ControlCount = 1 TO UpperBound ( iw_Parent.Control )
	IF IsValid ( iw_Parent.Control [ ll_ControlCount ] ) THEN
		ls_TagValue = iw_Parent.Control [ ll_ControlCount ].Tag
		IF ls_TagValue > '' THEN
			CHOOSE CASE iw_Parent.Control [ ll_ControlCount ].TypeOf ( )
			CASE checkbox!						// tag value:  column_name;value1,value2
				lcb_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = LeftA ( ls_TagValue, PosA ( ls_TagValue, ';' ) - 1 ) 
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF lcb_Control.Checked THEN
					ls_Value = RightA ( ls_TagValue, LenA ( ls_TagValue ) - PosA ( ls_TagValue, ';' ) )
					ls_Value = LeftA ( ls_Value, PosA ( ls_Value, ',' ) - 1 )
				ELSE
					ls_Value = RightA ( ls_TagValue, LenA ( ls_TagValue ) - PosA ( ls_TagValue, ',' ) )
				END IF
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNumber, ls_Value )
				END IF
			CASE datawindow!						// tag value:  column_name;source_column_name
				ldw_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = LeftA ( ls_TagValue, PosA ( ls_TagValue, ';' ) - 1 ) 
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				ls_SourceColumnName = RightA ( ls_TagValue, LenA ( ls_TagValue ) - PosA ( ls_TagValue, ';' ) )
				ll_SourceColumnNumber = Integer ( ldw_Control.Describe( ls_SourceColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 AND ll_SourceColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNumber, ldw_Control.GetItemString ( 1, ll_SourceColumnNumber ) )
				END IF
			CASE dropdownlistbox!				// tag value:  column_name
				lddlb_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, lddlb_Control.Text )
				END IF
			CASE editmask!						// tag value:  column_name
				lem_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, lem_Control.Text )
				END IF
			CASE listbox!							// tag value:  column_name
				llb_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, llb_Control.SelectedItem ( ) )
				END IF
			CASE multilineedit!					// tag value:  column_name
				lmle_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, lmle_Control.Text )
				END IF
			CASE radiobutton!						// tag value:  column_name;value1,value2
				lrb_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = LeftA ( ls_TagValue, PosA ( ls_TagValue, ';' ) - 1 ) 
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF lrb_Control.Checked THEN
					ls_Value = RightA ( ls_TagValue, LenA ( ls_TagValue ) - PosA ( ls_TagValue, ';' ) )
					ls_Value = LeftA ( ls_Value, PosA ( ls_Value, ',' ) - 1 )
				ELSE
					ls_Value = RightA ( ls_TagValue, LenA ( ls_TagValue ) - PosA ( ls_TagValue, ',' ) )
				END IF
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNumber, ls_Value )
				END IF
			CASE singlelineedit!					// tag value:  column_name
				lsle_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, lsle_Control.Text )
				END IF
			CASE statictext!						// tag value:  column_name
				lst_Control = iw_Parent.Control [ ll_ControlCount ]
				ls_ColumnName = ls_TagValue
				ll_ColumnNumber = Integer ( Describe ( ls_ColumnName + '.ID' ) )
				IF ll_ColumnNumber > 0 THEN
					SetItem ( 1, ll_ColumnNUmber, lst_Control.Text )
				END IF
			END CHOOSE
		END IF
	END IF
NEXT
end subroutine

