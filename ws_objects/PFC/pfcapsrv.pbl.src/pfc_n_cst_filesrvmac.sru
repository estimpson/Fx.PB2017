$PBExportHeader$pfc_n_cst_filesrvmac.sru
$PBExportComments$PFC Macintosh File services
forward
global type pfc_n_cst_filesrvmac from n_cst_filesrv
end type
end forward

type os_systemtime from structure
	long		ui_wyear
	long		ui_wmonth
	long		ui_wdayofweek
	long		ui_wday
	long		ui_whour
	long		ui_wminute
	long		ui_wsecond
	long		ui_wmilliseconds
end type

type os_finddata from structure
	unsignedlong		ul_fileattributes
	unsignedlong		ul_creationtime
	unsignedlong		ul_lastaccesstime
	unsignedlong		ul_filesize
	string		s_filename
end type

global type pfc_n_cst_filesrvmac from n_cst_filesrv
end type
global pfc_n_cst_filesrvmac pfc_n_cst_filesrvmac

type prototypes
Function uint GetDriveType (ref string drive ) library "PFCMacFileSrv" alias for "GetDriveType;Ansi"
Function Boolean CreateDirectory (ref String  directoryname) library "PFCMacFileSrv" alias for "CreateDirectory;Ansi"
Function Boolean RemoveDirectory (ref String directoryname) library "PFCMacFileSrv" alias for "RemoveDirectory;Ansi"   
Function long GetCurrentDirectory (ref string curdir) library "PFCMacFileSrv" alias for "GetCurrentDirectory;Ansi"
Function Boolean SetCurrentDirectory (ref String directoryname ) library "PFCMacFileSrv" alias for "SetCurrentDirectory;Ansi"
Function Boolean RenameFile (ref String oldfile, ref String newfile) library "PFCMacFileSrv" alias for "RenameFile;Ansi"
Function Boolean GetDiskFreeSpace (ref String drive, ref long total, ref long free) library "PFCMacFileSrv" alias for "GetDiskFreeSpace;Ansi"
Function long GetDirList(ref string dir, ref os_finddata finddata, int action) library "PFCMacFileSrv" alias for "GetDirList;Ansi"
Function ulong GetFileSize (REF String filename) library "PFCMacFileSrv" alias for "GetFileSize;Ansi"

Function ulong GetFileAttributes (REF String filename) library "PFCMacFileSrv" alias for "GetFileAttributes;Ansi"
Function ulong SetFileAttributes (REF String filename, ulong attribs) library "PFCMacFileSrv" alias for "SetFileAttributes;Ansi"

Function Boolean GetFileTime(REF string filename, ref os_systemtime  lpCreationTime, REF os_systemtime  lpLastAccessTime  ) library "PFCMacFileSrv" alias for "GetFileTime;Ansi"
Function Boolean SetFileTime(REF String filename, ref os_systemtime  lpCreationTime, REF os_systemtime  lpLastAccessTime)library "PFCMacFileSrv" alias for "SetFileTime;Ansi"

Function Boolean GetSysTimeFromFileTime(ulong filetime, REF os_systemtime  lpTime  ) library "PFCMacFileSrv" alias for "GetSysTimeFromFileTime;Ansi"
Function Boolean GetFileTimeFromSysTime(ref ulong filetime, ref os_systemtime  lpTime  )library "PFCMacFileSrv" alias for "GetFileTimeFromSysTime;Ansi"

Function long GetVolumeCount()  library "PFCMacFileSrv"
Function Boolean GetVolumeName(long count, ref string name)  library "PFCMacFileSrv" alias for "GetVolumeName;Ansi"
end prototypes

type variables

end variables

forward prototypes
public function string of_getcurrentdirectory ()
public function integer of_createdirectory (string as_directoryname)
public function boolean of_directoryexists (string as_directoryname)
public function integer of_removedirectory (string as_directoryname)
public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive)
public function integer of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function integer of_getcreationdatetime (string as_filename, ref date ad_date, ref time at_time)
public function double of_getfilesize (string as_filename)
public function integer of_getlastaccessdate (string as_filename, ref date ad_date)
public function integer of_setcreationdatetime (string as_filename, date ad_filedate, time at_filetime)
public function integer of_setlastaccessdate (string as_filename, date ad_date)
public function integer of_changedirectory (string as_newdirectory)
public function integer of_filerename (string as_sourcefile, string as_targetfile)
public function integer of_dirlist (string as_filespec, long al_filetype, ref n_cst_dirattrib anv_dirlist[])
protected function integer of_convertfiledatetimetopb (unsignedlong aul_filetime, ref date ad_filedate, ref time at_filetime)
protected function integer of_convertpbdatetimetofile (date ad_filedate, time at_filetime, ref unsignedlong aul_filetime)
public function integer of_getdrivetype (string as_drive)
public function integer of_getvolumes (ref string as_volumes[])
public function integer of_getdiskspace (string as_drive, ref long al_totalspace, ref long al_freespace)
end prototypes

public function string of_getcurrentdirectory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCurrentDirectory
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  string   the current directory
//
//	Description:
//	Returns the current directory
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_CurrentDir

ls_CurrentDir = Space (80)

GetCurrentDirectory(ls_CurrentDir)

Return trim(ls_CurrentDir)

end function

public function integer of_createdirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If CreateDirectory(as_DirectoryName) Then
	Return 1
Else
	Return -1
End If


end function

public function boolean of_directoryexists (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ULong	lul_RC

lul_RC = GetFileAttributes(as_DirectoryName)

// Check if 3th bit is set, if so this is a directory
If Mod(Integer(lul_RC / 4), 2) > 0 Then 
	Return True
Else
	Return False
End If

end function

public function integer of_removedirectory (string as_directoryname);//////////////////////////////////////////////////////////////////////////////
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
//	Description:	Delete a directory.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

//If Not of_DirectoryExists(as_DirectoryName) Then Return 1

If RemoveDirectory(as_DirectoryName) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdirectory, ref boolean ab_archive);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetFileAttributes
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The file for which you want the attributes; an
//									absolute path may be specified or it will
//									be relative to the current working directory.
//	ab_ReadOnly				The Read-Only attribute, passed by reference.
//	ab_Hidden					The Hidden attribute, passed by reference.
//	ab_System					The System attribute, passed by reference (not used for mac)
//	ab_Subdirectory			The Subdirectory attribute, passed by reference.
//	ab_Archive					The Archive attribute, passed by reference (not used for mac)
//	
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the attributes for a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
ulong lul_fileflags
n_cst_numerical		lnv_Numeric
string ls_file
integer	li_rc

ls_file = as_filename

trim(ls_file)

 lul_fileflags = GetFileAttributes (ls_file)

if lul_fileflags > 0 then
	// Set file attributes
	ab_ReadOnly = lnv_Numeric.of_getbit(lul_fileflags, 1)
	ab_Hidden = lnv_Numeric.of_getbit(lul_fileflags, 2)
	ab_SubDirectory = lnv_Numeric.of_getbit(lul_fileflags, 3)
	// ab_system and ab_archive are not used and set to false for the Mac
	ab_system = false
	ab_archive = false
	li_rc = 1
else
	li_rc = -1
end if

Return li_rc


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
//	ab_System					The new value for the System attribute (no effect for mac)
//	ab_Archive					The new value for the Archive attribute (no effect for mac)
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
//	5.0.02   Initial version
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
if ab_readonly then 
	lul_Attrib =1
else
	lul_Attrib =0
end if

if ab_hidden then
	lul_Attrib +=2
end if

If SetFileAttributes(as_FileName, lul_Attrib) > 0 Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function integer of_getcreationdatetime (string as_filename, ref date ad_date, ref time at_time);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetCreationDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date
//									and time; an absolute path may be specified or it
//									will be relative to the current working directory
//	ad_Date						The date the file was created, passed by reference.
//	at_Time						The time the file was created, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date and time a file was created.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String					ls_Time, ls_Date
integer	li_rc

os_systemtime  CreationTime
os_systemtime  LastAccessTime


// Get the file information
if GetFileTime(as_filename, CreationTime, LastAccessTime) then

	// Convert the date and time
	ls_Date = String(CreationTime.ui_WMonth) + "/" + &
				String(CreationTime.ui_WDay) + "/" + &
				String(CreationTime.ui_wyear)
	ad_date = Date(ls_Date)

	ls_Time = String(CreationTime.ui_wHour) + ":" + &
				String(CreationTime.ui_wMinute) + ":" + &
				String(CreationTime.ui_wSecond) + ":" + &
				String(CreationTime.ui_wMilliseconds)
	at_time = Time(ls_Time)
	
	li_rc = 1
else
	li_rc = -1
end if

return li_rc
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

ulong			lul_filesize

// Get the file size
lul_filesize = GetFileSize(as_filename)

Return double(lul_filesize)

end function

public function integer of_getlastaccessdate (string as_filename, ref date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetLastaccessDate
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file for which you want its date;
//									an absolute path may be specified or it will be
//									relative to the current working directory
//	ad_Date						The date the file was last accessed, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Get the date a file was last accessed (opened).  Note:  This function
//						only returns the Date because Last Access Time is not stored by
//						the operating system.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Date
integer	li_rc
os_systemtime  CreationTime
os_systemtime  LastAccessTime

// Get the file information
if GetFileTime(as_filename, CreationTime, LastAccessTime) then

	// Convert the date and time
	ls_Date = String(LastAccessTime.ui_WMonth) + "/" + &
				String(LastAccessTime.ui_WDay) + "/" + &
				String(LastAccessTime.ui_wyear)
	ad_date = Date(ls_Date)
	li_rc = 1
else
	li_rc = -1
end if

return li_rc
end function

public function integer of_setcreationdatetime (string as_filename, date ad_filedate, time at_filetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetCreationDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to be updated.
//	ad_FileDate				The date to be set.
//	at_FileTime				The time to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the Creation Date/Time stamp on a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Ret
ulong			lul_FileTime
os_systemtime lstr_CreateSystemTime
os_systemtime lstr_ModSystemTime

// Convert the date and time
If of_ConvertPBDatetimeToFile(ad_filedate, at_filetime, lul_FileTime) < 0 Then Return -1

If Not GetSysTimeFromFileTime(lul_filetime, lstr_CreateSystemTime) Then Return -1

lstr_ModSystemTime.ui_wyear= 0

lb_Ret = SetFileTime(as_filename, lstr_CreateSystemTime, lstr_ModSystemTime)

if lb_Ret then
	Return 1
Else
	Return -1
End If

end function

public function integer of_setlastaccessdate (string as_filename, date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetLastwriteDatetime
//
//	Access:  public
//
//	Arguments:
//	as_FileName				The name of the file to be updated.
//	ad_FileDate				The date to be set.
//
//	Returns:		Integer
//					1 if successful,
//					-1 if an error occurrs.
//
//	Description:	Set the Last Access Date on a file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Boolean		lb_Ret
Time			lt_Time
ulong			lul_FileTime
os_systemtime lstr_ModSystemTime
os_systemtime lstr_CreateSystemTime

// Convert the date and time
If of_ConvertPBDatetimeToFile(ad_Date, lt_Time, lul_FileTime) < 0 Then Return -1

If Not GetSysTimeFromFileTime(lul_filetime, lstr_ModSystemTime) Then Return -1


lb_Ret = SetFileTime(as_filename, lstr_CreateSystemTime, lstr_ModSystemTime)


If lb_Ret Then
	Return 1
Else
	Return -1
End If

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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

If Trim(as_NewDirectory) = "" Then Return -1

If SetCurrentDirectory(as_NewDirectory) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

end function

public function integer of_filerename (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_file_rename
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_RC

If RenameFile(as_SourceFile, as_TargetFile) Then
	li_RC = 1
Else
	li_RC = -1
End If

Return li_RC

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
//	anv_DirList[]				An array of n_cst_dirattrib structure which will contain
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
Integer				li_Entries
long					ll_cnt
String 						ls_Drive
Time						lt_Time
os_finddata			lstr_FindData[]
n_cst_dirattrib			lnv_Empty[]
n_cst_numerical		lnv_Numeric
long ll_count, ll_i
string ls_filespec
long ll_pos_temp, ll_pos=0

// check for valid argument
if as_filespec = "" then
	return -1
end if

// get the directory name without any wildcards
do 
	ll_pos = pos(as_filespec, ":", ll_pos +1 ) 
	if ll_pos > 0 then ll_pos_temp = ll_pos
loop  while  ll_pos > 0 

ls_filespec = mid(as_filespec, 1, ll_pos_temp)

// get count of items within passed in directory
ll_count = GetDirList(ls_filespec, lstr_FindData[1], 0)
		
if ll_count >0 then
	for ll_i=1 to ll_count
		lstr_FindData[ll_i].s_filename = space(256)
		GetDirList(ls_filespec,lstr_FindData[ll_i], ll_i)
	next
else
	return -1
end if


// Empty the result array
anv_DirList = lnv_Empty

// List the entries in the directory
for ll_i=1 to ll_count
	// Determine if this file should be included.
	If of_IncludeFile(String(lstr_FindData[ll_i].s_filename), al_FileType, lstr_FindData[ll_i].ul_FileAttributes) Then
		
		// Add it to the array
		li_Entries ++
		anv_DirList[li_Entries].is_FileName = lstr_FindData[ll_i].s_filename
			
		// Set date and time
		of_ConvertFileDatetimeToPB(lstr_FindData[ll_i].ul_CreationTime, anv_DirList[li_Entries].id_CreationDate, &
											anv_DirList[li_Entries].it_CreationTime)
		of_ConvertFileDatetimeToPB(lstr_FindData[ll_i].ul_LastAccessTime, anv_DirList[li_Entries].id_LastAccessDate, lt_Time)
		
		// the last access datetime is also the last write datetime
		of_ConvertFileDatetimeToPB(lstr_FindData[ll_i].ul_LastAccessTime, anv_DirList[li_Entries].id_LastWriteDate, &
													anv_DirList[li_Entries].it_LastWriteTime)
		
		// Set file size
		anv_DirList[li_Entries].idb_FileSize = lstr_FindData[ll_i].ul_FileSize 
		
		// Set file attributes
		anv_DirList[li_Entries].ib_ReadOnly = lnv_Numeric.of_getbit(lstr_FindData[ll_i].ul_FileAttributes, 1)
		anv_DirList[li_Entries].ib_Hidden = lnv_Numeric.of_getbit(lstr_FindData[ll_i].ul_FileAttributes, 2)
		anv_DirList[li_Entries].ib_SubDirectory = lnv_Numeric.of_getbit(lstr_FindData[ll_i].ul_FileAttributes, 3)
		
		anv_DirList[li_Entries].ib_Drive = False
		
		// Put brackets around subdirectories
		If anv_DirList[li_Entries].ib_SubDirectory Then
			anv_DirList[li_Entries].is_FileName = "[" + anv_DirList[li_Entries].is_FileName + "]"
		End If
	//End If
End If	
next


// Add the drives if desired.
// If the type is > 32768 this was to prevent read-write files from being included.
If al_FileType >=32768 Then al_FileType = al_FileType - 32768

// If the type is > 16384, then a list of drives should be included
If al_FileType >= 16384 Then
	
// get a list of volumes
	ll_cnt = GetVolumeCount()
	
	For ll_i=1 to ll_Cnt 
		ls_Drive = space(256)
		If GetVolumeName(ll_i, ls_Drive)  Then
			li_Entries ++
			anv_DirList[li_Entries].is_FileName = "[-" + ls_Drive + "-]"
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

protected function integer of_convertfiledatetimetopb (unsignedlong aul_filetime, ref date ad_filedate, ref time at_filetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertFileDatetimeToPB
//
//	Access:  protected
//
//	Arguments:
//	aul_filetime				The  system date/time for the file.
//	ad_FileDate				The file date in PowerBuilder Date format,
//									passed by reference.
//	at_FileTime				The file time in PowerBuilder Time format,
//									passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Convert a sytem file type to PowerBuilder Date and Time.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String				ls_Date, ls_Time
os_systemtime	lstr_SystemTime
ulong lul_filetime

lul_filetime = aul_filetime

If Not GetSysTimeFromFileTime(lul_filetime, lstr_SystemTime) Then Return -1

ls_Date = String(lstr_SystemTime.ui_WMonth) + "/" + &
				String(lstr_SystemTime.ui_WDay) + "/" + &
				String(lstr_SystemTime.ui_wyear)
ad_FileDate = Date(ls_Date)

ls_Time = String(lstr_SystemTime.ui_wHour) + ":" + &
				String(lstr_SystemTime.ui_wMinute) + ":" + &
				String(lstr_SystemTime.ui_wSecond) + ":" + &
				String(lstr_SystemTime.ui_wMilliseconds)
at_FileTime = Time(ls_Time)

Return 1

end function

protected function integer of_convertpbdatetimetofile (date ad_filedate, time at_filetime, ref unsignedlong aul_filetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ConvertPBDatetimeToFile
//
//	Access:  protected
//
//	Arguments:
//	ad_FileDate				The file date in PowerBuilder Date format.
//	at_FileTime				The file time in PowerBuilder Time format.
//	aul_filetime				The system date/time for the file, passed by reference.
//
//	Returns:		Integer
//					1 if successful, -1 if an error occurrs.
//
//	Description:	Convert PowerBuilder Date and Time to the sytem file type.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

String				ls_Date, ls_Time
ulong 				lul_LocalTime
os_systemtime	lstr_SystemTime

ls_Date = String(ad_FileDate, "yyyy-mm-dd")
lstr_SystemTime.ui_wyear = Long(Left(ls_Date, 4))
lstr_SystemTime.ui_WMonth = Long(Mid(ls_Date, 6, 2))
lstr_SystemTime.ui_WDay = Long(Right(ls_Date, 2))

ls_Time = String(at_FileTime, "hh:mm:ss:ffffff")
lstr_SystemTime.ui_wHour = Long(Left(ls_Time, 2))
lstr_SystemTime.ui_wMinute = Long(Mid(ls_Time, 4, 2))
lstr_SystemTime.ui_wSecond = Long(Mid(ls_Time, 7, 2))
lstr_SystemTime.ui_wMilliseconds = Long(Right(ls_Time, 6))


If Not GetFileTimeFromSysTime(lul_LocalTime, lstr_SystemTime) Then Return -1

aul_filetime = lul_LocalTime

Return 1

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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_drive

ls_drive = trim(as_drive)

if pos(ls_drive, ":") = 0 then
	ls_drive  +=":"
end if

Return GetDriveType(ls_drive)

end function

public function integer of_getvolumes (ref string as_volumes[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetVolumes
//
//	Access:  public
//
//	Arguments:
//	as_volumes			An array of strings  which will contain
//									the volume names, passed by reference.
//
//	Returns:		Integer
//					The number of elements in as_volumes if successful, -1 if an error occurrs.
//
//	Description:	Populate passed string array with all available volumes.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
long ll_count, ll_i
string ls_volume

// get the number of volumes

ll_count = getvolumecount()

if not ll_count  > 0 then
	return 0
end if

for ll_i =1 to ll_count
	ls_volume = space(256)
	
	if GetVolumeName(ll_i, ls_volume) then
		if ls_volume <> "" then
			as_volumes[ll_i] = ls_volume
		end if
	end if
next

return upperbound(as_volumes)
		
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string ls_volume
long ll_free, ll_total
integer	li_rc

 if not pos(as_drive, ":", 1) > 0 then
	ls_volume = as_drive+":"
else
	ls_volume = as_drive
end if

if  getdiskfreespace ( ls_volume, ll_total, ll_free) then
	al_freespace = ll_free
	al_totalspace = ll_total
	li_rc = 1
else
	li_rc = -1
end if

return li_rc

end function

on pfc_n_cst_filesrvmac.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_filesrvmac.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
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
//	5.0.02   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

is_Separator = ":"
is_AllFiles = "*.*"

end event

