$PBExportHeader$uo_check_bom_loop.sru
$PBExportComments$(mst)
forward
global type uo_check_bom_loop from UserObject
end type
type cb_exit from commandbutton within uo_check_bom_loop
end type
type st_1 from statictext within uo_check_bom_loop
end type
type mle_bom from multilineedit within uo_check_bom_loop
end type
type dw_bom from datawindow within uo_check_bom_loop
end type
end forward

type stack_stru from structure
    string part
    string gene_value
end type

global type uo_check_bom_loop from UserObject
int Width=1537
int Height=989
boolean Border=true
long BackColor=12632256
event ue_inifinite_loop pbm_custom01
cb_exit cb_exit
st_1 st_1
mle_bom mle_bom
dw_bom dw_bom
end type
global uo_check_bom_loop uo_check_bom_loop

type variables
Stack_stru	Stack[]        //Stack array
Stack_stru   	GeneValue[] //Keep all the gene values

String	szFatherPart      	//Keep the father part
String	szChildPart        	//Keep the child part
String	szCurrentGene   	//Keep the current gene value
String	szEndGene        	//Keep the end gene value
String	szPart               	//Current part number
String	szParentPart	//Parent part number
String	szComponent	//Component part number

Long	iStack_pointer   	//The pointer in stack
Long	iGene_pointer    	//The pointer in gene array
end variables

forward prototypes
public function boolean wf_check_loop_in_bom (string szpart)
public function boolean wf_loop_exists_in_bom (string szpart, string szgene)
public subroutine wf_draw_loop (string szfatherpart, string szchildpart, string szcurrentgene, string szendgene)
public function string wf_get_part_from_gene_array (string szGene)
end prototypes

on ue_inifinite_loop;parent.triggerevent( 'ue_inifinite_loop' )
end on

public function boolean wf_check_loop_in_bom (string szpart);String  szGene           //To keep the gene value
Integer iChildCounter    //To count the position of current child
Boolean bLoopExist       //Whether there is a loop in BOM

iStack_pointer = 1       //Initialize the stack
iGene_pointer	= 1
Stack[1].Part				= szPart
Stack[1].Gene_value		= "1"
GeneValue[1].Part			= szPart
GeneValue[1].Gene_value	= "1"
bLoopExist					= FALSE

dw_bom.SetTransObject(sqlca)

Do while (Not bLoopExist) AND (iStack_pointer > 0) 
	szPart 			= Stack[iStack_pointer].Part
	szGene 			= Stack[iStack_pointer].Gene_value
	iStack_pointer	= iStack_pointer - 1
	bLoopExist 		= wf_loop_exists_in_Bom(szPart, szGene)	//Get all the components for the part
Loop

If bLoopExist then
	wf_draw_loop(szFatherPart, szChildPart, szCurrentGene, szEndGene)
End If

Return bLoopExist

end function

public function boolean wf_loop_exists_in_bom (string szpart, string szgene);//***********************************************************************
//* Declaration
//***********************************************************************
Long iCount					//Counter for the components in the bill of material
Long iGeneCount			//Counter for the gene array
Long iLength				//The length of the string

String szComponentGene	//To keep the gene value for the component
String szComponent		//To keep the part number for the component
String szFatherGene     //To keep the father gene value

Boolean bLoopExists		//Whether there is a loop

//***********************************************************************
//* Initialization
//***********************************************************************

bLoopExists = FALSE
iCount		= 1
iGeneCount  = 1

//***********************************************************************
//* Main Routine
//***********************************************************************

dw_bom.Retrieve(szPart)

Do while (Not bLoopExists) and (iCount <= dw_bom.RowCount())
	szComponent	= dw_bom.GetItemString(iCount, "part")		

	//--------------------------------------------------------------------
	// Start to check whether this component already exists in the Gene 
	// array with Parent Gene value. If it is, then there is a loop
	//--------------------------------------------------------------------

	iGeneCount	= 1
	Do while (Not bLoopExists) and (iGeneCount <= iGene_Pointer)
		If GeneValue[iGeneCount].Part = szComponent then 
			iLength			= LenA(GeneValue[iGeneCount].Gene_value)
			szFatherGene	= LeftA(szGene, iLength)

			bLoopExists	= (szFatherGene = GeneValue[iGeneCount].Gene_value)
			If bLoopExists then
				szFatherPart	= szPart
				szChildPart		= szComponent
				szCurrentGene	= szGene
				szEndGene		= GeneValue[iGeneCount].Gene_value
			End If
		End If
		iGeneCount	= iGeneCount + 1
	Loop		
		
	If Not bLoopExists then
		iStack_pointer	= iStack_pointer + 1
		Stack[iStack_pointer].Part			= dw_bom.GetItemString(iCount, "part")
		Stack[iStack_pointer].Gene_value	= Trim(szGene) + String(iCount)

		iGene_pointer	= iGene_pointer  + 1
		GeneValue[iGene_pointer].Part			= Stack[iStack_pointer].Part
		GeneValue[iGene_pointer].Gene_value	= Stack[iStack_pointer].Gene_value
	End if

	iCount	= iCount + 1	
Loop


Return bLoopExists
end function

public subroutine wf_draw_loop (string szfatherpart, string szchildpart, string szcurrentgene, string szendgene);Long     iLength

String 	szPathText

szPathText 	= szFatherPart + "-->" + szChildPart

Do while szCurrentGene <> szEndGene
	iLength			= LenA(Trim(szCurrentGene))
	szCurrentGene	= LeftA(Trim(szCurrentGene), iLength - 1)
	szChildPart		= szFatherPart
	szFatherPart	= wf_get_part_from_gene_array(szCurrentGene)
	szPathText		= szFatherPart + "-->" + szChildPart + "  " + CharA(13) + " " + szPathText
Loop

mle_bom.text		= szPathText
	 		
end subroutine

public function string wf_get_part_from_gene_array (string szGene);Long iCount
String szPart

szPart 	= ""
iCount	= 1
Do while (iCount <= iGene_pointer) and (GeneValue[iCount].Gene_value <> szGene)
	iCount 	= iCount + 1
Loop	

If iCount <= iGene_pointer then
	szPart	= GeneValue[iCount].Part
End If

Return szPart 	 
end function

on uo_check_bom_loop.create
this.cb_exit=create cb_exit
this.st_1=create st_1
this.mle_bom=create mle_bom
this.dw_bom=create dw_bom
this.Control[]={ this.cb_exit,&
this.st_1,&
this.mle_bom,&
this.dw_bom}
end on

on uo_check_bom_loop.destroy
destroy(this.cb_exit)
destroy(this.st_1)
destroy(this.mle_bom)
destroy(this.dw_bom)
end on

type cb_exit from commandbutton within uo_check_bom_loop
int X=1207
int Y=865
int Width=238
int Height=97
int TabOrder=20
string Text="E&xit"
boolean Cancel=true
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Parent.visible	= FALSE
parent.triggerevent( 'ue_infinite_loop' )
end on

type st_1 from statictext within uo_check_bom_loop
int X=92
int Y=49
int Width=1354
int Height=81
boolean Enabled=false
string Text="Infinite Loop"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_bom from multilineedit within uo_check_bom_loop
int X=74
int Y=145
int Width=1372
int Height=705
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
long BackColor=16776960
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_bom from datawindow within uo_check_bom_loop
int X=110
int Y=177
int Width=494
int Height=361
int TabOrder=10
boolean Visible=false
string DataObject="d_bom"
boolean LiveScroll=true
end type

