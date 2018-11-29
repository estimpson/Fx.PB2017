$PBExportHeader$w_customer_category_pricing.srw
forward
global type w_customer_category_pricing from w_sheet_4t
end type
type ddlb_2 from dropdownlistbox within w_customer_category_pricing
end type
type ddlb_1 from dropdownlistbox within w_customer_category_pricing
end type
type dw_price_list from datawindow within w_customer_category_pricing
end type
type dw_category from datawindow within w_customer_category_pricing
end type
type dw_crosstab from datawindow within w_customer_category_pricing
end type
end forward

global type w_customer_category_pricing from w_sheet_4t
integer height = 1560
string title = "Customer Category Pricing"
string menuname = "m_customer_category_pricing"
event ue_save pbm_custom01
event ue_print ( )
ddlb_2 ddlb_2
ddlb_1 ddlb_1
dw_price_list dw_price_list
dw_category dw_category
dw_crosstab dw_crosstab
end type
global w_customer_category_pricing w_customer_category_pricing

type variables
Boolean ib_Crosstab = FALSE
Boolean ib_Changed = FALSE

s_price  st_price 
end variables

forward prototypes
public subroutine wf_build_dropdown (string as_flag)
public subroutine wf_build_category_crosstab (string as_flag, string as_part, string as_category)
public subroutine wf_build_crosstab_header (string as_flag, string as_category)
public subroutine wf_build_color_code (string spart, string scategory, string scolname, long lcount, long lrow)
end prototypes

on ue_save;String  s_Part, &
		  s_Category, &
		  s_ColName

Long    l_RowCount, &
  		  l_Count[2], &
		  l_CategoryCount

Dec {6} dec_StdPrice, &
		  dec_CatPrice

str_Progress StParm

l_RowCount      = dw_crosstab.RowCount ( )
l_CategoryCount = dw_category.RowCount ( )

IF ib_Crosstab AND ib_Changed THEN
	FOR l_Count[1] = 1 TO l_RowCount
		s_Part       = f_get_string_value ( dw_crosstab.GetItemString ( l_Count[1], "part" ) )
		dec_StdPrice = dw_crosstab.GetItemDecimal ( l_Count[1], "std_price" )

		stParm.Title	= "Updating Part/Pricing Info"
		OpenWithParm ( w_progress, stParm )

		UPDATE part_standard
			SET price = :dec_StdPrice
		 WHERE part = :s_Part	;

		w_progress.wf_progress(l_Count[1] / l_RowCount, "Updating Part/Pricing Info for: " + s_Part )

		FOR l_Count[2] = 1 TO 25
			s_ColName  = "cat" + String ( l_Count[2] )
			IF l_Count[2] <= l_CategoryCount THEN
				s_Category = dw_crosstab.Describe ( "t_cat" + String ( l_Count[2] ) + ".Text" )
				dec_CatPrice = dw_crosstab.GetItemDecimal ( l_Count[1], s_ColName )

				IF dec_StdPrice <> 0 AND ( NOT IsNull ( s_Category ) OR s_Category <> "" ) THEN
//					UPDATE part_customer_price_matrix
//						SET price = :dec_CatPrice
//					 WHERE part = :s_Part AND
//							 category = :s_Category	;
				END IF
			END IF
		NEXT
	NEXT

	Close ( w_progress )

	IF SQLCA.SQLCode = 0 THEN
		Commit;
		dw_category.Reset ( )
		dw_price_list.Reset ( )
		dw_category.Retrieve ( )
		dw_price_list.Retrieve ( )
		MessageBox ( "Save", "The Information Saved Successfully!", &
						 Exclamation!, OK! )
	ELSE
		Rollback;
		MessageBox ( "Save", "Save of Pricing Information Failed!", &
						 Exclamation!, OK! )
		Return
	END IF
END IF
end on

event ue_print();dw_crosstab.print()
end event

public subroutine wf_build_dropdown (string as_flag);String s_category, &
		 l_s_Part, &
		 l_s_temp, &
		 l_s_name

Long   ll_Sequence, &
		 l_Count = 1

SetPointer ( HourGlass! )

IF as_Flag = "Category" THEN

	ddlb_2.Reset ( )

	 DECLARE category_list CURSOR FOR
	  SELECT code
	    FROM category
	ORDER BY code ASC;

	Open category_list;

	DO WHILE SQLCA.SQLCode = 0
		Fetch category_list into :s_Category;
		ll_sequence = ddlb_2.FindItem ( s_Category, l_Count )
			IF ll_sequence < 1 THEN
			ddlb_2.AddItem ( s_Category )
		END IF
		l_Count++
	LOOP

	Close category_list;

ELSEIF as_Flag = "Part" THEN

	ddlb_2.Reset ( )

 	  DECLARE part_list CURSOR FOR
	   SELECT part, name
	     FROM part
	 ORDER BY part ASC;

	Open part_list;

	DO WHILE SQLCA.SQLCode = 0
		l_s_temp = l_s_part  + Space (35- LenA ( l_s_part ) ) + l_s_name
	   ddlb_2.AddItem ( l_s_temp )
		Fetch part_list into :l_s_Part, :l_s_name;

	LOOP

	Close part_list;
ELSE
	Return
END IF
//String s_Category, &
//		 s_Part
//
//Long   ll_Sequence, &
//		 l_Count = 1
//
//SetPointer ( HourGlass! )
//
//IF as_Flag = "Category" THEN
//
//	ddlb_2.Reset ( )
//
//	 DECLARE category_list CURSOR FOR
//	  SELECT code
//	    FROM category
//	ORDER BY code ASC;
//
//	Open category_list;
//
//	DO WHILE SQLCA.SQLCode = 0
//		Fetch category_list into :s_Category;
//		ll_sequence = ddlb_2.FindItem ( s_Category, l_Count )
//			IF ll_sequence < 1 THEN
//			ddlb_2.AddItem ( s_Category )
//		END IF
//		l_Count++
//	LOOP
//
//	Close category_list;
//
//ELSEIF as_Flag = "Part" THEN
//
//	ddlb_2.Reset ( )
//
// 	  DECLARE part_list CURSOR FOR
//	   SELECT part
//	     FROM part
//	 ORDER BY part ASC;
//
//	Open part_list;
//
//	DO WHILE SQLCA.SQLCode = 0
//		Fetch part_list into :s_Part;
//		ll_sequence = ddlb_2.FindItem ( s_Part, l_Count )
//			IF ll_sequence < 1 THEN
//			ddlb_2.AddItem ( s_Part )
//		END IF
//		l_Count++
//	LOOP
//
//	Close part_list;
//ELSE
//	Return
//END IFString s_Category, &

end subroutine

public subroutine wf_build_category_crosstab (string as_flag, string as_part, string as_category);Long    l_PartCount, &
		  l_CategoryCount, &
		  l_Count[2]

String  s_Part, &
		  s_Category, &
		  s_ColName, &
		  s_Multiple, &
		  s_Premium

Dec {2} dec_StdPrice, &
		  dec_Markup, &
		  dec_Total, &
		  dec_Premium

str_Progress StParm

dw_category.Retrieve ( )
dw_price_list.Retrieve ( )

ib_Crosstab = TRUE

IF as_Flag = "All" THEN

	dw_crosstab.Reset ( )

	l_PartCount     = dw_price_list.RowCount ( )
	l_CategoryCount = dw_category.RowCount ( )

	wf_build_crosstab_header ( "+", "" )
	
	bcancel = true
	stParm.title	= "Building Price/Category Crosstab"
	OpenWithParm ( w_progress, stParm )
   	
	FOR l_Count[1] = 1 TO l_PartCount
		YIELD()
		IF NOT bcancel THEN
	
			s_Part       = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_part" ) )
			dec_StdPrice = f_get_value ( dw_price_list.GetItemNumber ( l_Count[1], "part_standard_price" ) )
			s_Premium    = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_standard_premium" ) )

			w_progress.wf_progress(l_Count[1] / l_PartCount, "Building Category Prices for Part: " + s_Part )

			dw_crosstab.InsertRow ( l_Count[1] )
			dw_crosstab.SetItem ( l_Count[1], "part", s_Part )
			dw_crosstab.SetItem ( l_Count[1], "std_price", dec_StdPrice )

			FOR l_Count[2] = 1 TO 25
				s_ColName  = "cat" + String ( l_Count[2] )
				IF l_Count[2] <= l_CategoryCount THEN
					s_Category  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "code" ) )
					s_Multiple  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "multiplier" ) )
					dec_Markup  = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "markup" ) )
					dec_Premium = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "premium" ) )

					wf_build_color_code(s_part, s_category, s_colname, l_count[1], l_Count[2])

					IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
						dec_Premium = 0.00
					END IF

					CHOOSE CASE s_Multiple

						CASE "+"
							dec_Total = dec_StdPrice + dec_Markup + dec_Premium

						CASE "-"
							dec_Total = dec_StdPrice - dec_Markup + dec_Premium
	
						CASE "x"
							dec_Total = dec_StdPrice * dec_Markup + dec_Premium

						CASE "%"
							dec_Total = (dec_stdPrice + (dec_StdPrice * dec_Markup * 0.01) ) + dec_Premium

					END CHOOSE

					dw_crosstab.SetItem ( l_Count[1], s_ColName, dec_Total )
				END IF
			NEXT
		END IF
	NEXT
   
	Close ( w_progress )
	bcancel = false	

ELSEIF as_Flag = "Part" THEN

	dw_crosstab.Reset ( )

	l_CategoryCount = dw_category.RowCount ( )

	wf_build_crosstab_header ( "+", "" )

	SELECT part
	  INTO :s_Part
     FROM part
	 WHERE part = :as_Part	;

	SELECT price,
			 premium
	  INTO :dec_StdPrice,
			 :s_Premium
	  FROM part_standard
	 WHERE part = :as_Part	;

	IF IsNull ( dec_StdPrice ) THEN
		dec_StdPrice = 0.00
	END IF

	dw_crosstab.InsertRow ( l_Count[1] )
	dw_crosstab.SetItem ( 1, "part", s_Part )
	dw_crosstab.SetItem ( 1, "std_price", dec_StdPrice )

	FOR l_Count[2] = 1 TO 25
		s_ColName  = "cat" + String ( l_Count[2] )
		IF l_Count[2] <= l_CategoryCount THEN
			s_Category  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "code" ) )
			s_Multiple  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "multiplier" ) )
			dec_Markup  = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "markup" ) )
			dec_Premium = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "premium" ) )

			wf_build_color_code(s_part, s_category, s_colname, 1, l_count[2])

			IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
				dec_Premium = 0.00
			END IF

				CHOOSE CASE s_Multiple

					CASE "+"
						dec_Total = dec_StdPrice + dec_Markup + dec_Premium

					CASE "-"
						dec_Total = dec_StdPrice - dec_Markup + dec_Premium

					CASE "x"
						dec_Total = dec_StdPrice * dec_Markup + dec_Premium

					CASE "%"
						dec_Total = (dec_stdPrice + (dec_StdPrice * dec_Markup * 0.01) ) + dec_Premium

				END CHOOSE

			dw_crosstab.SetItem ( 1, s_ColName, dec_Total )
		END IF
	NEXT

ELSEIF as_Flag = "Category" THEN

	dw_crosstab.Reset ( )

	l_PartCount     = dw_price_list.RowCount ( )
	as_Category = ddlb_2.Text

	wf_build_crosstab_header ( "-", as_Category )

	stParm.title	= "Building Price/Category Crosstab"
	OpenWithParm ( w_progress, stParm )

	s_ColName  = "cat" + "1"

	FOR l_Count[1] = 1 TO l_PartCount
		IF NOT bcancel THEN			
		Yield()
		
		s_Part       = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_part" ) )
		dec_StdPrice = f_get_value ( dw_price_list.GetItemNumber ( l_Count[1], "part_standard_price" ) )
		s_Premium    = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_standard_premium" ) )

		dw_crosstab.InsertRow ( l_Count[1] )
		dw_crosstab.SetItem ( l_Count[1], "part", s_Part )

		wf_build_color_code(s_part, as_Category, s_colname, l_Count[1], 1)

		SELECT markup,
				 multiplier,
				 premium
		  INTO :dec_Markup,
				 :s_Multiple,
				 :dec_Premium
		  FROM category
		 WHERE code = :as_Category	;

		IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
			dec_Premium = 0.00
		END IF

		CHOOSE CASE s_Multiple

			CASE "+"
				dec_Total = dec_StdPrice + dec_Markup + dec_Premium

			CASE "-"
				dec_Total = dec_StdPrice - dec_Markup + dec_Premium

			CASE "x"
				dec_Total = dec_StdPrice * dec_Markup + dec_Premium

			CASE "%"
				dec_Total = (dec_stdPrice + (dec_StdPrice * dec_Markup * 0.01) ) + dec_Premium

		END CHOOSE

		w_progress.wf_progress(l_Count[1] / l_PartCount, "Building Category Prices for Part: " + s_Part )

		dw_crosstab.SetItem ( l_Count[1], "std_price", dec_StdPrice )
		dw_crosstab.SetItem ( l_Count[1], "cat1", dec_Total )
	  END IF
	NEXT
	
	Close ( w_progress )
	bcancel = False

ELSE
	Return
END IF
//Long    l_PartCount, &
//		  l_CategoryCount, &
//		  l_Count[2]
//
//String  s_Part, &
//		  s_Category, &
//		  s_ColName, &
//		  s_Multiple, &
//		  s_Premium
//
//Dec {2} dec_StdPrice, &
//		  dec_Markup, &
//		  dec_Total, &
//		  dec_Premium
//
//str_Progress StParm
//
//ib_Crosstab = TRUE
//
//IF as_Flag = "All" THEN
//
//	dw_crosstab.Reset ( )
//
//	l_PartCount     = dw_price_list.RowCount ( )
//	l_CategoryCount = dw_category.RowCount ( )
//
//	wf_build_crosstab_header ( "+", "" )
//
//	stParm.title	= "Building Price/Category Crosstab"
//	OpenWithParm ( w_progress, stParm )
//
//	FOR l_Count[1] = 1 TO l_PartCount
//		s_Part       = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_part" ) )
//		dec_StdPrice = f_get_value ( dw_price_list.GetItemNumber ( l_Count[1], "part_standard_price" ) )
//		s_Premium    = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_standard_premium" ) )
//
//		w_progress.wf_progress(l_Count[1] / l_PartCount, "Building Category Prices for Part: " + s_Part )
//
//		dw_crosstab.InsertRow ( l_Count[1] )
//		dw_crosstab.SetItem ( l_Count[1], "part", s_Part )
//		dw_crosstab.SetItem ( l_Count[1], "std_price", dec_StdPrice )
//
//		FOR l_Count[2] = 1 TO 25
//			s_ColName  = "cat" + String ( l_Count[2] )
//			IF l_Count[2] <= l_CategoryCount THEN
//				s_Category  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "code" ) )
//				s_Multiple  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "multiplier" ) )
//				dec_Markup  = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "markup" ) )
//				dec_Premium = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "premium" ) )
//
//				wf_build_color_code(s_part, s_category, s_colname, l_count[1], l_Count[2])
//
//				IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
//					dec_Premium = 0.00
//				END IF
//
//				CHOOSE CASE s_Multiple
//
//					CASE "+"
//						dec_Total = dec_StdPrice + dec_Markup + dec_Premium
//
//					CASE "-"
//						dec_Total = dec_StdPrice - dec_Markup + dec_Premium
//
//					CASE "x"
//						dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//					CASE "%"
//						dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//				END CHOOSE
//
//				dw_crosstab.SetItem ( l_Count[1], s_ColName, dec_Total )
//			END IF
//		NEXT
//	NEXT
//
//	Close ( w_progress )
//
//ELSEIF as_Flag = "Part" THEN
//
//	dw_crosstab.Reset ( )
//
//	l_CategoryCount = dw_category.RowCount ( )
//
//	wf_build_crosstab_header ( "+", "" )
//
//	SELECT part
//	  INTO :s_Part
//     FROM part
//	 WHERE part = :as_Part	;
//
//	SELECT price,
//			 premium
//	  INTO :dec_StdPrice,
//			 :s_Premium
//	  FROM part_standard
//	 WHERE part = :as_Part	;
//
//	IF IsNull ( dec_StdPrice ) THEN
//		dec_StdPrice = 0.00
//	END IF
//
//	dw_crosstab.InsertRow ( l_Count[1] )
//	dw_crosstab.SetItem ( 1, "part", s_Part )
//	dw_crosstab.SetItem ( 1, "std_price", dec_StdPrice )
//
//	FOR l_Count[2] = 1 TO 25
//		s_ColName  = "cat" + String ( l_Count[2] )
//		IF l_Count[2] <= l_CategoryCount THEN
//			s_Category  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "code" ) )
//			s_Multiple  = f_get_string_value ( dw_category.GetItemString ( l_Count[2], "multiplier" ) )
//			dec_Markup  = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "markup" ) )
//			dec_Premium = f_get_value ( dw_category.GetItemNumber ( l_Count[2], "premium" ) )
//
//			wf_build_color_code(s_part, s_category, s_colname, 1, l_count[2])
//
//			IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
//				dec_Premium = 0.00
//			END IF
//
//				CHOOSE CASE s_Multiple
//
//					CASE "+"
//						dec_Total = dec_StdPrice + dec_Markup + dec_Premium
//
//					CASE "-"
//						dec_Total = dec_StdPrice - dec_Markup + dec_Premium
//
//					CASE "x"
//						dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//					CASE "%"
//						dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//				END CHOOSE
//
//			dw_crosstab.SetItem ( 1, s_ColName, dec_Total )
//		END IF
//	NEXT
//
//ELSEIF as_Flag = "Category" THEN
//
//	dw_crosstab.Reset ( )
//
//	l_PartCount     = dw_price_list.RowCount ( )
//	as_Category = ddlb_2.Text
//
//	wf_build_crosstab_header ( "-", as_Category )
//
//	stParm.title	= "Building Price/Category Crosstab"
//	OpenWithParm ( w_progress, stParm )
//
//	s_ColName  = "cat" + "1"
//
//	FOR l_Count[1] = 1 TO l_PartCount
//		s_Part       = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_part" ) )
//		dec_StdPrice = f_get_value ( dw_price_list.GetItemNumber ( l_Count[1], "part_standard_price" ) )
//		s_Premium    = f_get_string_value ( dw_price_list.GetItemString ( l_Count[1], "part_standard_premium" ) )
//
//		dw_crosstab.InsertRow ( l_Count[1] )
//		dw_crosstab.SetItem ( l_Count[1], "part", s_Part )
//
//		wf_build_color_code(s_part, as_Category, s_colname, l_Count[1], 1)
//
//		SELECT markup,
//				 multiplier,
//				 premium
//		  INTO :dec_Markup,
//				 :s_Multiple,
//				 :dec_Premium
//		  FROM category
//		 WHERE code = :as_Category	;
//
//		IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
//			dec_Premium = 0.00
//		END IF
//
//		CHOOSE CASE s_Multiple
//
//			CASE "+"
//				dec_Total = dec_StdPrice + dec_Markup + dec_Premium
//
//			CASE "-"
//				dec_Total = dec_StdPrice - dec_Markup + dec_Premium
//
//			CASE "x"
//				dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//			CASE "%"
//				dec_Total = dec_StdPrice * dec_Markup + dec_Premium
//
//		END CHOOSE
//
//		w_progress.wf_progress(l_Count[1] / l_PartCount, "Building Category Prices for Part: " + s_Part )
//
//		dw_crosstab.SetItem ( l_Count[1], "std_price", dec_StdPrice )
//		dw_crosstab.SetItem ( l_Count[1], "cat1", dec_Total )
//
//	NEXT
//
//	Close ( w_progress )
//
//ELSE
//	Return
//END IF
end subroutine

public subroutine wf_build_crosstab_header (string as_flag, string as_category);Long   l_Count, &
	    l_CategoryCount

String s_Category, &
		 s_ColName, &
		 s_ModString, &
		 s_rc

IF as_Flag = "+" THEN

	l_CategoryCount = dw_category.RowCount ( )

	FOR l_Count = 1 TO 25
		IF l_Count <= l_CategoryCount THEN
			s_Category = dw_category.GetItemString ( l_Count, "code" )
		ELSE
			s_Category = ""
		END IF

		s_ColName = "t_cat" + String ( l_Count )

		IF NOT IsNull ( s_Category ) OR s_Category <> "" THEN
			s_ModString = s_ColName + ".Text='" + s_Category + "'"
			s_rc = dw_crosstab.Modify ( s_ModString )
		ELSE
			s_ModString = s_ColName + ".Text=''"
			s_rc = dw_crosstab.Modify ( s_ModString )
		END IF

	NEXT
ELSEIF as_Flag = "-" THEN

	FOR l_Count = 1 TO 25
		s_ColName = "t_cat" + String ( l_Count )

		IF NOT IsNull ( as_Category ) OR as_Category <> "" THEN
			IF s_ColName = "t_cat1" THEN
				s_ModString = s_ColName + ".Text='" + as_Category + "'"
				s_rc = dw_crosstab.Modify ( s_ModString )
			ELSE
				s_ModString = s_ColName + ".Text=''"
				s_rc = dw_crosstab.Modify ( s_ModString )
			END IF
		ELSE
			s_ModString = s_ColName + ".Text=''"
			s_rc = dw_crosstab.Modify ( s_ModString )
		END IF
	NEXT

ELSE
	Return
END IF
end subroutine

public subroutine wf_build_color_code (string spart, string scategory, string scolname, long lcount, long lrow);String 	s_err
Date  	d_End
Datetime ld_end
Long     l_promotion

SELECT end_date,
		 promotion
INTO   :ld_End,
		 :l_promotion
FROM   price_promotion
WHERE  part = :spart AND
		 category = :scategory ;

If SQLCA.SQLCODE = 0 Then
	If daysafter( today(), date(ld_End) ) < 0 Then

		DELETE FROM price_promotion
		where promotion = :l_promotion ;  

		If SQLCA.SQLCODE = 0 Then
			commit ;
		End If

	Else

		s_err = "date" + string(lrow)
		dw_crosstab.SetItem( lcount, s_err, date(ld_End) )
		
	End IF
End If 





end subroutine

event open;call super::open;dw_category.SetTransObject ( SQLCA )
dw_price_list.SetTransObject ( SQLCA )

dw_category.Retrieve ( )
dw_price_list.Retrieve ( )

wf_build_crosstab_header ( "+", "" )

dw_crosstab.SetFocus ( )

w_customer_category_pricing.SetMicroHelp ( "Please use dropdown at top " + &
														 "to select desired data." )

Timer ( 0.5 )


end event

event timer;call super::timer;IF ddlb_1.BackColor = f_get_color_value ( "white" ) THEN
	ddlb_1.BackColor = f_get_color_value ( "gray" )
ELSE
	ddlb_1.BackColor = f_get_color_value ( "white" )
END IF

end event

on w_customer_category_pricing.create
int iCurrent
call super::create
if this.MenuName = "m_customer_category_pricing" then this.MenuID = create m_customer_category_pricing
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.dw_price_list=create dw_price_list
this.dw_category=create dw_category
this.dw_crosstab=create dw_crosstab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_2
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.dw_price_list
this.Control[iCurrent+4]=this.dw_category
this.Control[iCurrent+5]=this.dw_crosstab
end on

on w_customer_category_pricing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.dw_price_list)
destroy(this.dw_category)
destroy(this.dw_crosstab)
end on

event resize;call super::resize;dw_crosstab.Resize ( Width - 109, Height - 288 )
end event

type ddlb_2 from dropdownlistbox within w_customer_category_pricing
boolean visible = false
integer x = 658
integer y = 32
integer width = 663
integer height = 468
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean hscrollbar = true
boolean vscrollbar = true
end type

event selectionchanged;String s_Part, &
       s_Category, &
       s_Flag

s_Flag = ddlb_1.Text

IF s_Flag = "Part" THEN
	this.text = TRIM ( LeftA ( this.text, 25 ) )
	s_Part = This.Text
	wf_build_category_crosstab ( s_Flag, s_Part, "" )
ELSEIF s_Flag = "Category" THEN
	s_Category = ddlb_2.Text
	wf_build_category_crosstab ( s_Flag, "", s_Category )
ELSE
	Return
END IF


end event

type ddlb_1 from dropdownlistbox within w_customer_category_pricing
integer x = 37
integer y = 32
integer width = 603
integer height = 316
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All","Part","Category"}
end type

event selectionchanged;String s_Flag

Timer ( 0 )
ddlb_1.BackColor = f_get_color_value ( "white" )
w_customer_category_pricing.SetMicroHelp ( "Ready" )

s_Flag = ddlb_1.Text

IF s_Flag = "All" THEN
	ddlb_2.Visible = FALSE
	wf_build_category_crosstab ( s_Flag, "", "" )
ELSEIF s_Flag = "Category" THEN
	ddlb_2.Visible = TRUE
	wf_build_dropdown ( s_Flag )
ELSEIF s_Flag = "Part" THEN
	ddlb_2.Visible = TRUE
	wf_build_dropdown ( s_Flag )
ELSE
	Return
END IF
end event

type dw_price_list from datawindow within w_customer_category_pricing
boolean visible = false
integer x = 805
integer y = 1408
integer width = 498
integer height = 360
integer taborder = 50
string dataobject = "d_price_list"
boolean livescroll = true
end type

type dw_category from datawindow within w_customer_category_pricing
boolean visible = false
integer x = 242
integer y = 1408
integer width = 494
integer height = 360
integer taborder = 40
string dataobject = "d_category_setup"
boolean livescroll = true
end type

type dw_crosstab from datawindow within w_customer_category_pricing
integer x = 37
integer y = 152
integer width = 2816
integer height = 1244
integer taborder = 30
string dataobject = "d_category_crosstab_ver2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;LONG l_row

Integer i_count

string s_part, &
		 s_category, &
		 s_colname

l_row 				= row
i_Count 				= dw_crosstab.GetClickedColumn()
st_price.spart  	=  ""
st_price.scategory = ""

If i_Count >= 3 Then
	
	//this line is included to check whether the clicked column is null, if so return
	if IsNull(dw_crosstab.getitemdecimal(l_row,i_count)) then return
	
	//checking for promotion, if part has promotion then open the next window for editing else return
	s_colname = dwo.name
	s_colname = "date" + MidA ( s_colname, 4, ( LenA ( s_colname ) - 3 ) )
	
	if daysafter(today(),this.getitemdate ( row, s_colname ) ) < 0  & 
		or isnull ( this.getitemdate ( row, s_colname ) ) then return
	
	st_price.spart  	=  dw_crosstab.GetItemstring( l_row, "part" )
	
	//else included to prevent null object reference errors for dw_category
	If ddlb_1.Text = "Category" then
		st_price.scategory = ddlb_2.Text
	Else
		if dw_category.rowcount() > 0 then
			st_price.scategory = dw_category.GetItemString( i_count - 2, "code" )
		end if
	End If

	OpenSheetwithparm(w_edit_price_promotion, st_price, w_customer_category_pricing , 3, Original!)
	
End If

end event

on itemchanged;String  s_Part, &
		  s_Category, &
		  s_ColName, &
		  s_Multiple, &
		  s_Premium

Long    l_ColNum, &
	     l_RowNum, &
		  l_Count, &
		  l_CategoryCount

Dec {2} dec_StdPrice, &
		  dec_Markup, &
		  dec_Total, &
		  dec_Premium

l_ColNum        = dw_crosstab.GetColumn ( )
l_RowNum        = dw_crosstab.GetRow ( )
l_CategoryCount = dw_category.RowCount ( )

dw_crosstab.AcceptText ( )

ib_Changed = TRUE

dec_StdPrice = f_get_value ( dw_crosstab.GetItemDecimal ( l_RowNum, "std_price" ) )
s_Part       = f_get_string_value ( dw_crosstab.GetItemString ( l_RowNum, "part" ) )

SELECT premium
  INTO :s_Premium
  FROM part_standard
 WHERE part = :s_Part	;

FOR l_Count = 1 TO 25
	s_ColName  = "cat" + String ( l_Count )
	IF l_Count <= l_CategoryCount THEN
		s_Category = dw_crosstab.Describe ( "t_cat" + String ( l_Count ) + ".Text" )

		SELECT markup,
			    multiplier,
				 premium
		  INTO :dec_Markup,
				 :s_Multiple,
				 :dec_Premium
		  FROM category
		 WHERE code = :s_Category	;

		IF s_Premium = "N" OR s_Premium = "" OR IsNull ( s_Premium ) THEN
			dec_Premium = 0.00
		END IF

		IF SQLCA.SQLCode = 0 THEN

				CHOOSE CASE s_Multiple

					CASE "+"
						dec_Total = dec_StdPrice + dec_Markup + dec_Premium

					CASE "-"
						dec_Total = dec_StdPrice - dec_Markup + dec_Premium

					CASE "x"
						dec_Total = dec_StdPrice * dec_Markup + dec_Premium

					CASE "%"
						dec_Total = dec_StdPrice * dec_Markup + dec_Premium

				END CHOOSE

			dw_crosstab.SetItem ( l_RowNum, s_ColName, dec_Total )
		END IF

	END IF
NEXT
end on

