$PBExportHeader$u_part_node.sru
$PBExportComments$The node used in visual BOM tree.
forward
global type u_part_node from radiobutton
end type
end forward

global type u_part_node from radiobutton
int Width=375
int Height=65
string Text="none"
BorderStyle BorderStyle=StyleRaised!
long TextColor=33554432
long BackColor=12632256
int TextSize=-7
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_part_node u_part_node

type variables
Decimal 	i_d_StandardCost, &
	i_d_MaterialCost, &
	i_d_LaborCost, &	
	i_d_BurdenCost, &	
	i_d_OtherCost, &
	i_d_StandardCostCum, &	
	i_d_MaterialCostCum, &	
	i_d_LaborCostCum, &
	i_d_BurdenCostCum, &
	i_d_OtherCostCum

String	i_s_Part

Integer	i_i_Node_Ptr

Window	i_w_ParentWindow

Boolean	i_b_Changed = FALSE
end variables

forward prototypes
public subroutine uf_set_part_number (string l_s_part)
end prototypes

public subroutine uf_set_part_number (string l_s_part);u_part_node.text	= l_s_Part
end subroutine

on clicked;g_i_Node_Ptr	= i_i_Node_Ptr
i_w_ParentWindow.PostEvent("ue_display_info")

end on

on constructor;i_w_ParentWindow	= Parent
end on

