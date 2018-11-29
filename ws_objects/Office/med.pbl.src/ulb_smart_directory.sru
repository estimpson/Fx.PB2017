$PBExportHeader$ulb_smart_directory.sru
forward
global type ulb_smart_directory from listbox
end type
end forward

global type ulb_smart_directory from listbox
int Width=997
int Height=881
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_open pbm_custom01
event ue_resize pbm_custom02
event ue_fileopen pbm_custom03
end type
global ulb_smart_directory ulb_smart_directory

type variables
STRING	is_Path, &
	is_FileMask, &
	is_FileName

BOOLEAN	ib_ReadOnly, &
		ib_Hidden, &
		ib_System, &
		ib_SubDirectory, &
		ib_Archive, &
		ib_Drive, &
		ib_ExcludeReadWrite, &
		ib_StaticText

StaticText	ist_Path
end variables

forward prototypes
private function integer uof_refresh_directory ()
end prototypes

on ue_open;uof_refresh_directory ( )
end on

private function integer uof_refresh_directory ();INTEGER	li_FileType = 0

IF ib_ReadOnly THEN
	li_FileType += 1
END IF
IF ib_Hidden THEN
	li_FileType += 2
END IF
IF ib_System THEN
	li_FileType += 4
END IF
IF ib_Subdirectory THEN
	li_FileType += 16
END IF
IF ib_Archive THEN
	li_FileType += 32
END IF
IF ib_Drive THEN
	li_FileType += 16384
END IF
IF ib_ExcludeReadWrite THEN
	li_FileType += 32768
END IF

IF ib_StaticText THEN
	DirList ( is_Path + is_FileMask, li_FileType, ist_Path )
ELSE
	DirList ( is_Path + is_FileMask, li_FileType )
END IF

Return 0
end function

on doubleclicked;STRING	ls_Indicator1, &
		ls_Indicator2, &
		ls_DriveLetter, &
		ls_Directory, &
		ls_FileName

INTEGER	li_Count

BOOLEAN	lb_FirstSlash, &
			lb_SecondSlash
			
ls_Indicator1 = LeftA ( SelectedItem ( ), 1 )
ls_Indicator2 = MidA ( SelectedItem ( ), 2, 1 )

IF ls_Indicator1 = '[' THEN
	is_FileName = ''
	IF ls_Indicator2 = '-' THEN
		ls_DriveLetter = MidA ( SelectedItem ( ), 3, LenA ( SelectedItem ( ) ) - 4 )
		is_Path = ls_DriveLetter + ':\'
	ELSE
		IF MidA ( SelectedItem ( ), 2, 2 ) = '..' THEN
			li_Count = LenA ( is_Path )
			DO WHILE li_Count > 0 AND NOT lb_SecondSlash
				IF MidA ( is_Path, li_Count, 1 ) = '\' THEN
					IF lb_FirstSlash THEN
						lb_SecondSlash = TRUE
					ELSE
						lb_FirstSlash = TRUE
					END IF
				END IF
				li_Count --
			LOOP
			is_Path = LeftA ( is_Path, li_Count + 1 )
		ELSE
			ls_Directory = MidA ( SelectedItem ( ), 2, LenA ( SelectedItem ( ) ) - 2 )
			is_Path += ls_Directory + '\'
		END IF
	END IF
ELSE
	is_FileName = is_Path + SelectedItem ( )
	PostEvent ( 'ue_fileopen' )
END IF
uof_refresh_directory ( )
end on

