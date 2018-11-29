$PBExportHeader$u_nvo_library_list.sru
forward
global type u_nvo_library_list from nonvisualobject
end type
end forward

shared variables
STRING	s_s_original_list, &
	s_s_current_list

APPLICATION	s_app_this
end variables

global type u_nvo_library_list from nonvisualobject
end type
global u_nvo_library_list u_nvo_library_list

forward prototypes
public function integer uof_register (ref application a_app_this)
public function integer uof_add_library (string a_s_library)
public function integer uof_reset_library ()
public function string uof_what_added ()
end prototypes

public function integer uof_register (ref application a_app_this);s_app_this = a_app_this

CHOOSE CASE s_app_this.appname
	CASE "monitor"
		s_s_original_list = &
			"custom.pbl,medenh.pbl,monitor.pbl,mst.pbl,mll.pbl,mbo.pbl,moe.pbl,base.pbl" + &
			"mpo.pbl,mps.pbl,mps1.pbl,mrd.pbl,mrs.pbl,mri.pbl,med.pbl,miv.pbl,mic.pbl,constants.pbl" + &
			"common.pbl,globals.pbl,mqe.pbl,mvb.pbl,mad.pbl,mad1.pbl,mci.pbl,newshift.pbl" + &
			"mct.pbl,mec.pbl,mit.pbl,scale.pbl,mpl.pbl,msc.pbl,msd.pbl,msf.pbl,mul.pbl,mei.pbl"
	CASE "mct"
		s_s_original_list = &
			"mct.pbl,mst.pbl,mci.pbl,mad.pbl,mad1.pbl,mbo.pbl,mec.pbl,med.pbl,medenh.pbl," + &
			"mei.pbl,mfm.pbl,mic.pbl,mit.pbl,miv.pbl,mll.pbl,moe.pbl,monitor.pbl,mpl.pbl," + &
			"mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl,msc.pbl,msd.pbl," + &
			"msf.pbl,mul.pbl,mvb.pbl,newshift.pbl,scale.pbl"
	CASE "mei"
		s_s_original_list = &
			"mei.pbl,mst_com.pbl,mci.pbl"
	CASE "mit"
		s_s_original_list = &
			"mit.pbl,mst.pbl,mll.pbl,mci.pbl,scale.pbl,mad.pbl,mad1.pbl,mbo.pbl,mct.pbl," + &
			"mec.pbl,med.pbl,medenh.pbl,mei.pbl,mfm.pbl,mic.pbl,miv.pbl,moe.pbl," + &
			"monitor.pbl,mpl.pbl,mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl," + &
			"msc.pbl,msd.pbl,msf.pbl,mul.pbl,mvb.pbl,newshift.pbl"
	CASE "mpl"
		s_s_original_list = &
			"mpl.pbl,mst.pbl,mll.pbl,mci.pbl,scale.pbl,mad.pbl,mad1.pbl,mbo.pbl,mct.pbl," + &
			"mec.pbl,med.pbl,medenh.pbl,mei.pbl,mfm.pbl,mic.pbl,mit.pbl,miv.pbl,moe.pbl," + &
			"monitor.pbl,mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl,msc.pbl," + &
			"msd.pbl,msf.pbl,mul.pbl,mvb.pbl,newshift.pbl"
	CASE "mrd"
		s_s_original_list = &
			"mrd.pbl,mst.pbl,mpo.pbl,mll.pbl,mci.pbl,mri.pbl,mps.pbl,mps1.pbl,mrs.pbl," + &
			"mad.pbl,mad1.pbl,mbo.pbl,mct.pbl,mec.pbl,med.pbl,medenh.pbl,mei.pbl,mfm.pbl," + &
			"mic.pbl,mit.pbl,miv.pbl,moe.pbl,monitor.pbl,mpl.pbl,mpo.pbl,mqe.pbl,msc.pbl," + &
			"msd.pbl,msf.pbl,mul.pbl,mvb.pbl,newshift.pbl,scale.pbl"
	CASE "msc"
		s_s_original_list = &
			"msc.pbl,mst.pbl,mci.pbl,newshift.pbl,mad.pbl,mad1.pbl,mbo.pbl,mct.pbl," + &
			"mec.pbl,med.pbl,medenh.pbl,mei.pbl,mfm.pbl,mic.pbl,mit.pbl,miv.pbl,mll.pbl," + &
			"moe.pbl,monitor.pbl,mpl.pbl,mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl," + &
			"mrs.pbl,msd.pbl,msf.pbl,mul.pbl,mvb.pbl,scale.pbl"
	CASE "msd"
		s_s_original_list = &
			"msd.pbl,mst.pbl,mfm.pbl,mll.pbl,mci.pbl,med.pbl,mbo.pbl,moe.pbl,mad.pbl," + &
			"mad1.pbl,mct.pbl,mec.pbl,medenh.pbl,mei.pbl,mic.pbl,mit.pbl,miv.pbl," + &
			"monitor.pbl,mpl.pbl,mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl," + &
			"msc.pbl,msf.pbl,mul.pbl,mvb.pbl,newshift.pbl,scale.pbl"
	CASE "msf"
		s_s_original_list = &
			"msf.pbl,mst.pbl,mll.pbl,mit.pbl,mci.pbl,mps.pbl,mps1.pbl,scale.pbl,mad.pbl," + &
			"mad1.pbl,mbo.pbl,mct.pbl,mec.pbl,med.pbl,medenh.pbl,mei.pbl,mfm.pbl,mic.pbl," + &
			"miv.pbl,moe.pbl,monitor.pbl,mpl.pbl,mpo.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl," + &
			"msc.pbl,msd.pbl,mul.pbl,mvb.pbl,newshift.pbl"
	CASE "mul"
		s_s_original_list = &
			"mul.pbl,mst.pbl,mci.pbl,mct.pbl,mad.pbl,mad1.pbl,mbo.pbl,mec.pbl,med.pbl," + &
			"medenh.pbl,mei.pbl,mfm.pbl,mic.pbl,mit.pbl,miv.pbl,mll.pbl,moe.pbl," + &
			"monitor.pbl,mpl.pbl,mpo.pbl,mps.pbl,mps1.pbl,mqe.pbl,mrd.pbl,mri.pbl,mrs.pbl," + &
			"msc.pbl,msd.pbl,msf.pbl,mvb.pbl,newshift.pbl,scale.pbl"
	CASE ELSE
		s_s_original_list = "Error"
END CHOOSE

//  The following two statements simulate using compiled forms or windows at runtime.
uof_add_library ( "garbage.pbd" )
Return uof_reset_library ( )
end function

public function integer uof_add_library (string a_s_library);IF s_app_this.SetLibraryList ( s_s_original_list + "," + a_s_library ) < 0 THEN
	Return -1
ELSE
	s_s_current_list = s_s_original_list + "," + a_s_library
END IF
end function

public function integer uof_reset_library ();INTEGER	l_i_set_return

l_i_set_return = s_app_this.SetLibraryList ( s_s_original_list )

IF l_i_set_return < 0 THEN
	Return l_i_set_return
ELSE
	s_s_current_list = s_s_original_list
	Return 1
END IF
end function

public function string uof_what_added ();Return RightA ( s_s_current_list, LenA ( s_s_current_list ) - LenA ( s_s_original_list ) )
end function

on u_nvo_library_list.create
TriggerEvent( this, "constructor" )
end on

on u_nvo_library_list.destroy
TriggerEvent( this, "destructor" )
end on

