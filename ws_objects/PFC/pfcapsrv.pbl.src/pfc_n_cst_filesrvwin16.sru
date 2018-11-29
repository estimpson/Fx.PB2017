$PBExportHeader$pfc_n_cst_filesrvwin16.sru
$PBExportComments$PFC Win16 File handler service
forward
global type pfc_n_cst_filesrvwin16 from n_cst_filesrv
end type
end forward

type os_findt from structure
	character		ch_reserved[21]
	character		ch_attrib
	unsignedinteger		ui_wrtime
	unsignedinteger		ui_wrdate
	unsignedlong		ul_size
	character		ch_name[13]
end type

type os_diskfreet from structure
	uint		ui_totalclusters
	uint		ui_availclusters
	uint		ui_sectorspercluster
	uint		ui_bytespersector
end type

global type pfc_n_cst_filesrvwin16 from n_cst_filesrv
end type
global pfc_n_cst_filesrvwin16 pfc_n_cst_filesrvwin16

type prototypes
// PFCFLSRV.DLL
Function int DirectoryCreate  (string directoryname) Library "PFCFLSRV.DLL" alias for "DirectoryCreate;Ansi"
Function boolean DirectoryExists  (string directoryname) Library "PFCFLSRV.DLL" alias for "DirectoryExists;Ansi"
Function int DirectoryRemove  (string directoryname) Library "PFCFLSRV.DLL" alias for "DirectoryRemove;Ansi"
Function int ChangeDirectory  (char drive, string directoryname) Library "PFCFLSRV.DLL" alias for "ChangeDirectory;Ansi"
Function string CurrentDirectory  () Library "PFCFLSRV.DLL" alias for "CurrentDirectory;Ansi"
Function int RenameFile  (string oldname, string newname) Library "PFCFLSRV.DLL" alias for "RenameFile;Ansi"
Function int GetFileAttr  (string filename, ref uint attrib) Library "PFCFLSRV.DLL" alias for "GetFileAttr;Ansi"
Function int SetFileAttr  (string filename, uint attrib) Library "PFCFLSRV.DLL" alias for "SetFileAttr;Ansi"
Function int GetFileDateTime(string filename, ref string date, ref string time) Library "PFCFLSRV.DLL" alias for "GetFileDateTime;Ansi"
Function int SetFileDateTime  (string filename, uint newdate, uint newtime) Library "PFCFLSRV.DLL" alias for "SetFileDateTime;Ansi"
Function int FindFirst(string filename, uint attrib, ref os_findt findbuffer) Library "PFCFLSRV.DLL" alias for "FindFirst;Ansi"
Function int FindNext(ref os_findt findbuffer) Library "PFCFLSRV.DLL" alias for "FindNext;Ansi"
Function int FindClose(ref os_findt findbuffer) Library "PFCFLSRV.DLL" alias for "FindClose;Ansi"
Function boolean ConvDate(uint date, ref string sdate) Library "PFCFLSRV.DLL" alias for "ConvDate;Ansi"
Function boolean ConvTime(uint time, ref string stime) Library "PFCFLSRV.DLL" alias for "ConvTime;Ansi"
Function int GetDiskSpace(int drive, ref os_diskfreet diskfree) Library "PFCFLSRV.DLL" alias for "GetDiskSpace;Ansi"

//Win 3.1 calls
Function uint GetDriveType (int drive) library "KERNEL.EXE"

end prototypes

type variables

end variables

forward prototypes
public function string of_GetCurrentDirectory ()
public function integer of_CreateDirectory (string as_directoryname)
public function boolean of_DirectoryExists (string as_directoryname)
public function integer of_changedirectory (string as_newdirectory)
public function integer of_RemoveDirectory (string as_directoryname)
public function integer of_GetFileAttributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive)
public function integer of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function integer of_getlastwritedatetime (string as_filename, ref date ad_date, ref time at_time)
public function integer of_dirlist (string as_filespec, long al_filetype, ref n_cst_dirattrib anv_dirlist[])
protected function date of_convertdate (unsignedinteger aui_date)
protected function time of_ConvertTime (unsignedinteger aui_time)
public function integer of_FileRename (string as_sourcefile, string as_targetfile)
public function integer of_setlastwritedatetime (string as_filename, date ad_date, time at_time)
public function double of_getfilesize (string as_filename)
public function integer of_getdrivetype (string as_drive)
public function integer of_getdiskspace (string as_drive, ref long al_totalspace, ref long al_freespace)
end prototypes

public function string of_GetCurrentDirectory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCurrentDirectory
//
//	Access:  public
//
//	Arguments:	None.
//
//	Returns:		String
//					The current working directory.
//
//	Description:	Get the current working directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_CurrentDir

ls_CurrentDir = CurrentDirectory()

Return ls_CurrentDir

end function

public function integer of_CreateDirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreateDirectory
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be created; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Create a new directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If DirectoryCreate(as_DirectoryName) = 0 Then
	Return 1
Else
	Return -1
End If

end function

public function boolean of_DirectoryExists (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DirectoryExists
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be checked; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Boolean
//					True if the directory exists, False if it does not.
//
//	Description:	Check if the specified directory exists.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Boolean	lb_RC

lb_RC = DirectoryExists(as_DirectoryName)

Return lb_RC

end function

public function integer of_changedirectory (string as_newdirectory);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ChangeDirectory
//
//	Access:  public
//
//	Arguments:
//	as_NewDirectory			The name of the new working directory; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Change the current working directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Char	lc_Drive

If Trim(as_NewDirectory) = "" Then Return -1

If Mid(as_NewDirectory, 2, 1) = ":" Then
	lc_Drive = Left(as_NewDirectory, 1)
Else
	lc_Drive = " "
End if

If ChangeDirectory(lc_Drive, as_NewDirectory) = 0 Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_RemoveDirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RemoveDirectory
//
//	Access:  public
//
//	Arguments:
//	as_DirectoryName		The name of the directory to be deleted; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Delete a directory.  The directory must be empty or it will not
//						be deleted (returns a -1).
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If DirectoryRemove(as_DirectoryName) = 0 Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_GetFileAttributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file for which you want the attributes; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//	ab_ReadOnly				The Read-Only attribute, passed by reference.
//	ab_Hidden					The Hidden attribute, passed by reference.
//	ab_System					The System attribute, passed by reference.
//	ab_Subdirectory			The Subdirectory attribute, passed by reference.
//	ab_Archive					The Archive attribute, passed by reference.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Get the attributes for a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


UInt						lui_Attrib
n_cst_numerical		lnv_Numeric

// Get the attribute bit
If GetFileAttr(as_FileName, lui_Attrib) <> 0 Then Return -1

// Set file attributes
ab_ReadOnly = lnv_Numeric.of_getbit(lui_Attrib, 1)
ab_Hidden = lnv_Numeric.of_getbit(lui_Attrib, 2)
ab_System = lnv_Numeric.of_getbit(lui_Attrib, 3)
ab_SubDirectory = lnv_Numeric.of_getbit(lui_Attrib, 5)
ab_Archive = lnv_Numeric.of_getbit(lui_Attrib, 6)

Return 1

end function

public function integer of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file whose attributes you want to set; an
//									absolute path may be specified or it will
//									be relative to the current working directory.
//	ab_ReadOnly				The new value for the Read-Only attribute.
//	ab_Hidden					The new value for the Hidden attribute.
//	ab_System					The new value for the System attribute.
//	ab_Archive					The new value for the Archive attribute.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the attributes of a file.  If null is passed for any of the attributes,
//						it will not be changed.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer		li_RC
ULong		lul_Attrib

// Calculate the new attribute byte for the file
lul_Attrib = of_CalculateFileAttributes(as_FileName, ab_ReadOnly, ab_Hidden, ab_System, ab_Archive)
If lul_Attrib = -1 Then Return -1

If SetFileAttr(as_FileName, lul_Attrib) = 0 Then
	li_RC = 1
Else
	li_RC = 0
End If

Return li_RC

end function

public function integer of_getlastwritedatetime (string as_filename, ref date ad_date, ref time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date
//									and time; an absolute path may be specified or it
//									will be relative to the current working directory
//	ad_Date						The date the file was last modified, passed by reference.
//	at_Time						The time the file was last modified, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date and time a file was last modified.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fixed - function would fail under some international date formats
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Date, ls_Time
string	ls_yy, ls_mm, ls_dd

ls_Date = Space(12)
ls_Time = Space(10)

If GetFileDateTime(as_FileName, ls_Date, ls_Time) <> 0 Then Return -1

//date is returned as "2/1/1996"  Make it format neutral for internationalization
ls_yy = right(ls_date,4)
ls_mm = left(ls_date,2)
if right(ls_mm,1) = "/" then
	ls_dd = mid(ls_date,3,2)
	ls_mm = left(ls_mm,1)
else
	ls_dd = mid(ls_date,4,2)
end if
if right(ls_dd,1) = "/" then
	ls_dd = left(ls_dd,1)
end if

ad_Date = Date(integer(ls_yy), integer(ls_mm), integer(ls_dd))
at_Time = Time(ls_Time)

Return 1

end function

public function integer of_dirlist (string as_filespec, long al_filetype, ref n_cst_dirattrib anv_dirlist[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_DirList
//
//	Access:  public
//
//	Arguments:
//	as_FileSpec				The file spec. to list (including wildcards); an
//									absolute path may be specified or it will
//									be relative to the current working directory
//	al_FileType				A number representing one or more types of files
//									to include in the list, see PowerBuilder Help on
//									the DirList listbox function for an explanation.
//	anv_DirList[]				An array of n_cst_dirattrib structure whichl will contain
//									the results, passed by reference.
//
//	Returns:		Integer
//					The number of elements in anv_DirList if successful, -1 if an error occurrs.
//
//	Description:	List the contents of a directory (Name, Date, Time, and Size).
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03	Match parameter datatypes to of_includefile function correctly.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer					li_Cnt, li_Entries, li_RC
Uint						lui_Mask
Ulong						lul_Attrib
Char						lc_Drive
os_findt				lstr_FindData
n_cst_dirattrib			lnv_Empty[]
n_cst_numerical		lnv_Numeric

// Empty the result array
anv_DirList = lnv_Empty

// List the entries in the directory
lui_Mask = al_FileType
li_RC = FindFirst(as_FileSpec, lui_Mask, lstr_FindData)

Do While li_RC = 0
	lul_Attrib = Asc(lstr_FindData.ch_attrib)
	
	// Determine if this file should be included.
	If of_IncludeFile(String(lstr_FindData.ch_name), al_FileType, lul_Attrib) Then
	
		// Add it to the array
		li_Entries ++
		anv_DirList[li_Entries].is_FileName = lstr_FindData.ch_name
	
		// Set date and time
		anv_DirList[li_Entries].id_LastWriteDate = of_ConvertDate(lstr_FindData.ui_wrdate)
		anv_DirList[li_Entries].it_LastWriteTime = of_ConvertTime(lstr_FindData.ui_wrtime)

		// Set file size
		anv_DirList[li_Entries].idb_FileSize = lstr_FindData.ul_Size
		
		// Set file attributes
		anv_DirList[li_Entries].ib_ReadOnly = lnv_Numeric.of_getbit(lul_Attrib, 1)
		anv_DirList[li_Entries].ib_Hidden = lnv_Numeric.of_getbit(lul_Attrib, 2)
		anv_DirList[li_Entries].ib_System = lnv_Numeric.of_getbit(lul_Attrib, 3)
		anv_DirList[li_Entries].ib_SubDirectory = lnv_Numeric.of_getbit(lul_Attrib, 5)
		anv_DirList[li_Entries].ib_Archive = lnv_Numeric.of_getbit(lul_Attrib, 6)
		anv_DirList[li_Entries].ib_Drive = False
		
		// Put brackets around subdirectories
		If anv_DirList[li_Entries].ib_SubDirectory Then
			anv_DirList[li_Entries].is_FileName = "[" + anv_DirList[li_Entries].is_FileName + "]"
		End If
	End If
	
	li_RC = FindNext(lstr_FindData)
Loop

li_RC = FindClose(lstr_FindData)

// Add the drives if desired.
// If the type is > 32768 this was to prevent read-write files from being included.
If al_FileType >=32768 Then al_FileType = al_FileType - 32768

// If the type is > 16384, then a list of drives should be included
If al_FileType >= 16384 Then
	For li_Cnt = 0 To 25
		lc_Drive = Char(li_Cnt + 97)
		If of_GetDriveType(lc_Drive) > 1 Then
			li_Entries ++
			anv_DirList[li_Entries].is_FileName = "[-" + lc_Drive + "-]"
			anv_DirList[li_Entries].is_AltFileName = anv_DirList[li_Entries].is_FileName
			anv_DirList[li_Entries].ib_ReadOnly = False
			anv_DirList[li_Entries].ib_Hidden = False
			anv_DirList[li_Entries].ib_System = False
			anv_DirList[li_Entries].ib_SubDirectory = False
			anv_DirList[li_Entries].ib_Archive = False
			anv_DirList[li_Entries].ib_Drive = True
		End if
	Next
End if

Return li_Entries

end function

protected function date of_convertdate (unsignedinteger aui_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertDate
//
//	Access:  protected
//
//	Arguments:
//	aui_Date					The file date to be converted to PB fomat.
//
//	Returns:		Date
//
//	Description:	Convert a file date (as an unsigned integer) to a PowerBuilder Date.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fixed - function would fail under some international date formats
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Date		ld_date
String	ls_Date
String	ls_yy, ls_mm, ls_dd


ls_Date = Space(12)
convdate(aui_Date, ls_Date)

//date is returned as "2/1/1996"  Make it format neutral for internationalization
ls_yy = right(ls_date,4)
ls_mm = left(ls_date,2)
if right(ls_mm,1) = "/" then
	ls_dd = mid(ls_date,3,2)
	ls_mm = left(ls_mm,1)
else
	ls_dd = mid(ls_date,4,2)
end if
if right(ls_dd,1) = "/" then
	ls_dd = left(ls_dd,1)
end if

ld_date = date(integer(ls_yy), integer(ls_mm), integer(ls_dd))

Return ld_Date

end function

protected function time of_ConvertTime (unsignedinteger aui_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertTime
//
//	Access:  protected
//
//	Arguments:
//	aui_Time					The file time to be converted to PB fomat.
//
//	Returns:		Date
//
//	Description:	Convert a file time (as an unsigned integer) to a PowerBuilder Time.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Time

ls_Time = Space(10)
convtime(aui_Time, ls_Time)

Return Time(ls_Time)

end function

public function integer of_FileRename (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FileRename
//
//	Access:  public
//
//	Arguments:
//	as_SourceFile			The file to rename.
//	as_TargetFile				The new file name.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Rename or move a file or directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If RenameFile(as_SourceFile, as_TargetFile) = 0 Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_setlastwritedatetime (string as_filename, date ad_date, time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose date is to be set;
//									an absolute path may be specified or it will
//									be relative to the current working directory.
//	ad_Date						The date to be set.
//	at_Time						The time to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the date and time on a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Fixed problem with seconds doubling.  Dos only stores 0-29 seconds 
//				so seconds will also always be an even number.  Added calc comments
//	5.0.03	Fix Problem with Century not being on the year portion of a date
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC, li_Mon, li_DD, li_YY, li_HH, li_MM, li_SS
Uint		lui_Date, lui_Time
String	ls_Time, ls_Date

ls_Date = String(ad_Date, "mmddyyyy")
ls_Time = String(at_Time, "hhmmss")

li_Mon = Integer(Left(ls_Date, 2))
li_DD = Integer(Mid(ls_Date, 3, 2))
li_YY = Integer(Right(ls_Date, 4))

// fix problem with century not being passed in
if li_YY < 50 then
	li_YY = li_YY + 2000
elseif li_YY < 100 then
	li_YY = li_YY + 1900
end if


//The date consists of the year, month and day packed into 16 bits as follows:
//	bits 0-4	Day (1-31)	bits 5-8 Month (1-12)	bits 9-15 Year (0-119 representing 1980-2099)
lui_Date = ((li_YY - 1980) * 512) + (li_Mon * 32) + li_DD

li_HH = Integer(Left(ls_Time, 2))
li_MM = Integer(Mid(ls_Time, 3, 2))
li_SS = Integer(Right(ls_Time, 2))

//The time consists of the hour, minute and seconds/2 packed into 16 bits as follows:
//	bits 0-4 Seconds/2 (0-29)	bits 5-10 Minutes (0-59)	bits 11-15 Hours (0-23)
lui_Time = (li_HH * 2048) + (li_MM * 32) + Int(li_SS/2)

li_RC = SetFileDateTime(as_FileName, lui_Date, lui_Time)

Return li_RC

end function

public function double of_getfilesize (string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFileSize
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file whose size is desired; an
//									absolute path may be specified or it will
//									be relative to the current working directory
//
//	Returns:		Double
//					The size of the file if successful, -1 if an error occurrs.
//
//	Description:	Get the size (in bytes) of a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer					li_RC
Double					ldb_Size
os_findt					lstr_FindData

// Get the file
li_RC = FindFirst(as_FileName, 0, lstr_FindData)
If li_RC <> 0 Then Return -1

ldb_Size = lstr_FindData.ul_Size

li_RC = FindClose(lstr_FindData)

Return ldb_Size

end function

public function integer of_getdrivetype (string as_drive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDriveType
//
//	Access:  public
//
//	Arguments:
//	ac_Drive					The letter of the drive to be checked.
//
//	Returns:		Integer
//					The type of the drive:
//					2 - floppy drive,
//					3 - hard drive,
//					4 - network drive,
//					5 - cdrom drive,
//					6 - ramdisk,
//					any other value is the result of an error.
//
//	Description:	Determine the type of a drive.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03	Changed argument datatype to string from char to fix polymorphism problem
//				with literals passed in.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_Drive

// drive a=0, b=1, and so on.
li_Drive = Asc(lower(left(as_drive,1))) - 97

Return GetDriveType(li_Drive)

end function

public function integer of_getdiskspace (string as_drive, ref long al_totalspace, ref long al_freespace);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetDiskSpace
//
//	Access:  public
//
//	Arguments:
//	ac_Drive					The letter of the drive to be checked.
//	al_TotalSpace			The total number of bytes on the drive, passed
//									by reference.
//	al_FreeSpace				The number of bytes free, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get space information about a drive.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03	Changed argument datatype to string from char to fix polymorphism problem
//				with literals passed in.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer			li_Drive, li_RC
Long				ll_ClusterBytes
os_diskfreet	lstr_DiskFree

// drive a=1, b=2, and so on.
li_Drive = Asc(lower(left(as_drive,1))) - 96

li_RC = getdiskspace(li_drive, lstr_DiskFree)
If li_RC < 0 Then Return -1

ll_ClusterBytes = lstr_DiskFree.ui_bytespersector * lstr_DiskFree.ui_sectorspercluster
al_TotalSpace = lstr_DiskFree.ui_totalclusters * ll_ClusterBytes
al_FreeSpace = lstr_DiskFree.ui_availclusters * ll_ClusterBytes

Return 1

end function

on pfc_n_cst_filesrvwin16.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_filesrvwin16.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call n_cst_filesrv::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Constructor
//
//	Description:	Set the instance variables for the directory separator
//						and wildcard for all files for this OS.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

is_Separator = "\"
is_AllFiles = "*.*"

end event

