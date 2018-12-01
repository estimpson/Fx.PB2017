$PBExportHeader$w_tsm_internal.srw
forward
global type w_tsm_internal from Window
end type
end forward

shared variables

end variables

global type w_tsm_internal from Window
int X=673
int Y=265
int Width=1582
int Height=993
boolean TitleBar=true
string Title="w_std_lable_for_fin"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_tsm_internal w_tsm_internal

type variables
St_generic_structure ast_Parm
end variables

on open;////////////////////////////////////////////
//  Declaration
//

ast_Parm = Message.PowerObjectParm

LONG		l_Label, &
			l_Serial, &
			l_position, &
			l_pos_string, &
         l_ordno, & 
         l_shipper

STRING	c_Esc, &
			s_Part, &
			s_CuPart,&
			s_NumberofLabels, &
			szcompany, &
         s_cupo, &
			szaddress1, &
			szaddress2, &
			szaddress3, &
			s_shipper
			
Dec {0} dec_Quantity

///////////////////////////////////////////////
//  Initialization
//

l_Serial = LONG ( ast_Parm.Value1 )

  SELECT part,   
         quantity,   
			shipper
	 INTO :s_Part,   
         :dec_Quantity,   
			:l_shipper
			
    FROM object  
   WHERE serial = :l_Serial   ;

	SELECT parameters.company_name, address_1, address_2, address_3
	INTO :szCompany,
		  :szAddress1,
			:szAddress2,
			:szAddress3
	From parameters ;
 
// to get the number of copies of the label 

If ast_Parm.value11 = "" Then 
	s_NumberofLabels = "Q1"
Else
	s_NumberofLabels = "Q" + ast_Parm.value11
End If

c_Esc = "~h1B"

/////////////////////////////////////////////////
//  Main Routine
//

l_Label = PrintOpen ( )

//  Start Printing
PrintSend ( l_Label, c_Esc + "A" + c_Esc + "%1" )

PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H40" + c_Esc + "WL1" + "INTERNAL LABEL FOR TSM" )

//  Part Info
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H150" + c_Esc + "M" + "PART NO" )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H170" + c_Esc + "M" + "(1P)" )
PrintSend ( l_Label, c_Esc + "V960" + c_Esc + "H120" + c_Esc + "$A,130,150,0" + c_Esc + "$=" + s_Part )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H250" + c_Esc + "B103095" + "*" + s_Part + "*" )

//QTY
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H380" + c_Esc + "M" + "QUANTITY" )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H400" + c_Esc + "M" + "(Q)" )
PrintSend ( l_Label, c_Esc + "V940" + c_Esc + "H360" + c_Esc + "$A,110,120,0" + c_Esc +"$=" + String(dec_Quantity) )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H470" + c_Esc + "B103095" + "*" + String(dec_Quantity) + "*" )

//SERIAL NO
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H600" + c_Esc + "M" + "SERIAL NO." )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H620" + c_Esc + "M" + "(S)" )
PrintSend ( l_Label, c_Esc + "V900" + c_Esc + "H600" + c_Esc + "WL1" + STRING(l_serial) )
PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H660" + c_Esc + "B103095" + "*" + STRING(l_serial) + "*")

PrintSend ( l_Label, c_Esc + "V1100" + c_Esc + "H760" + c_Esc + "M" + szCompany + "  " + szAddress1 + " " + szAddress2 + "  " + szAddress3 )

//  Draw Lines
PrintSend ( l_Label, c_Esc + "N" )
PrintSend ( l_Label, c_Esc + "V050" + c_Esc + "H370" + c_Esc + "FW03V1100" )
PrintSend ( l_Label, c_Esc + "V050" + c_Esc + "H590" + c_Esc + "FW03V1100" )

PrintSend ( l_Label, c_Esc + s_NumberofLabels )
PrintSend ( l_Label, c_Esc + "Z" )
PrintClose ( l_Label )
Close ( this )
end on

on w_tsm_internal.create
end on

on w_tsm_internal.destroy
end on

