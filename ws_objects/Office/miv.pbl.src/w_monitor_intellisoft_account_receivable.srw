$PBExportHeader$w_monitor_intellisoft_account_receivable.srw
forward
global type w_monitor_intellisoft_account_receivable from Window
end type
end forward

type str_gl_detail from structure
    string gl_account
    decimal {2} amount
end type

global type w_monitor_intellisoft_account_receivable from Window
int X=1
int Y=1
int Width=2949
int Height=1953
boolean TitleBar=true
string Title="Untitled"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_monitor_intellisoft_account_receivable w_monitor_intellisoft_account_receivable

type variables
//------------------------ ARB1 -------------------------------------
Integer 	iBatchId	
Integer	iDeleteFlag
String	szCustomer
String	szInvDate
String	szInvNumber
String	szDept
String	szInvDescription
Integer	iInvType
Integer	iIMLocation
String	szSalesOrder
String	szDateOrdered
String	szCustomerPO#
Integer	iPrintInvoice
Integer	iTermsType
Integer	iTermsDays
Integer	iTermsEOMCutOff
Integer	iTermsDiscountDays
Integer	iTermsDiscount
String	szTermsDescription
String	szShipTo#
String	szShipToFrt#
String	szShipToName
String	szShipToContact
String	szShipToAddress
String	szShipToInstructions
Integer	iUpdateShipToInfo
String	szDefaultAccountMgr
String	szDefaultPrice#
String	szDefaultSalesTax
Integer	iDefaultTaxExempt
Integer	iDefaultAllowComm
Integer	iFromSO
Integer	iItemDiscLevel
Integer	iDefaultDiscountPer
String	nDefaultFreight#
Decimal	nDefaultCreditLimit
Integer	iDefaultPayMethod
String	szDefaultReference
Integer	iUsingSchedPayments
Integer	iSchPayType
Integer	iSchPayEOMCutOff
Integer	iSchPayCycleDays
Integer	iSchPay#OfCycles
Integer 	iSchPayDownPay
Decimal	nSchPayMinDownPay
Decimal	nPayDist1
Decimal	nPayDist2
Decimal	nPayDist3
Decimal	nPayDist4
Decimal	nPayDist5
Decimal	nPayDist6	
Decimal	nPayDist7	
Decimal	nPayDist8	
Decimal	nPayDist9	
Decimal	nPayDist10
Decimal	nPayDist11
Integer	iAutoCalcFrt
String	szPaymentFrt#
Decimal	nTotalWeight
Decimal	nFreightChargeAmount
String	szPaymentTaxNum
Decimal	nTaxAmount
Decimal	nPaymentDiscount
Integer	iPaymentDisc
Integer	iNotesHandle
Integer	iImageHandle
Integer	iVoiceHandle

//---------------------------------- AR2 -------------------------------
Integer 	iDtlBatchId
Integer 	iLineItemId
String	szCode
Integer	iItemType
Integer	iTaxMask
String	szItemDescription
Integer	iQty
Decimal	iDtlExtendedAmount
String	szUnitOfMeasure
String	szUnitWeight
String	szIMLocation
String	szPriceNumber
Decimal	nExtraFreightAmount
Decimal	nUnitPrice
Decimal	nUnitCost
Integer	iPercentDiscount
Decimal	iCommissionType
Decimal	iCommissionAmount
Decimal	iCommissionRate
String	szAccountManager
String	szShipToNumber
Integer	iSerialNumbered
Integer	iItemIsTaxable
String	szClass
Integer	iDtlNotesHandle
Integer	iDtlImageHandle
Integer	iDtlVoiceHandle

//--------------------- General Declaration ---------------------
String 	szYear
String 	szMonth
String 	szDay
String 	szTemp
String 	szInvoiceAmount
String	szTerm
String	szDirectory
String	szDestination
String	szCustomerCode
String	szFileMode

Decimal	nItemUnitPrice
Decimal	nInvoiceAmount
Decimal	nFreight
Decimal	nTax
Decimal	nTaxRate

Integer	iSign

Long	iShipper
Long	iInvoice
Long	iGL_detail_count = 0

Str_GL_Detail GL_detail[]
end variables

forward prototypes
public subroutine wf_generate_header ()
public subroutine wf_output_header ()
public subroutine wf_generate_detail (long ishipper)
public subroutine wf_add_to_gl_account (string szGL_Account, decimal nAmount)
public subroutine wf_output_detail (long iFileNo)
public function decimal wf_get_tax_rate (string szdestination)
public function boolean wf_part_is_taxable (string szpart, string szcustomer)
public function string wf_get_freight_account ()
public function string wf_get_sales_tax_account ()
public subroutine wf_calculate_gl_account ()
end prototypes

public subroutine wf_generate_header ();Select shipper.date_shipped,   
       shipper.customer ,
		 shipper.terms 
  Into :szInvDate,   
       :szTemp,
		 :szTerm

  From shipper  
 Where shipper.id = :iShipper;

iBatchId				= iInvoice
iDeleteFlag			= 0

szCustomer			= '"' + f_get_string_value(szTemp) + '"'
szInvDate			= '"' + f_get_string_value(szInvDate) + '"'
szInvNumber			= '"' + String(iInvoice) + '"'
szDept				= '""'
szInvDescription	= '"' + String(iInvoice) + '"'
iInvType				= 0
iIMLocation			= 0
szSalesOrder		= '""'
szDateOrdered		= '""'
szCustomerPO#		= '""'
iPrintInvoice		= 0


If IsNull(szTerm) then
  	SELECT customer.terms  
    INTO :szTerm  
    FROM customer  
   WHERE customer.customer = :szCustomer   ;
	szTerm	= f_get_string_value(szTerm)
End If

  SELECT term.type,   
         term.due_day,   
         term.eom_cut_off,   
         term.discount_days,   
         term.discount_percentage  
    INTO :iTermsType,   
         :iTermsDays,   
         :iTermsEOMCutOff,   
         :iTermsDiscountDays,   
         :iTermsDiscount  
    FROM term  
   WHERE term.description = :szTerm   ;

iTermsType				= f_get_value(iTermsType)
iTermsDays				= f_get_value(iTermsDays)
iTermsEOMCutOff		= f_get_value(iTermsEOMCutOff)
iTermsDiscountDays	= f_get_value(iTermsDiscountDays)
iTermsDiscount			= f_get_value(iTermsDiscount)
szTermsDescription	= '""'
szShipTo#				= '""'
szShipToFrt#			= '""'
szShipToName			= '""'
szShipToContact		= '""'
szShipToAddress		= '""'
szShipToInstructions = '""'
iUpdateShipToInfo		= 0
szDefaultAccountMgr	= '""'
szDefaultPrice#		= '""'
szDefaultSalesTax		= '"no"'
iDefaultTaxExempt		= 0
iDefaultAllowComm		= 1
iFromSO					= 0
iItemDiscLevel			= 0
iDefaultDiscountPer 	= 0
nDefaultFreight#		= '""'
nDefaultCreditLimit 	= 0.00
iDefaultPayMethod		= 0
szDefaultReference	= '""'
iUsingSchedPayments	= 0
iSchPayType				= 0
iSchPayEOMCutOff		= 0
iSchPayCycleDays		= 0
iSchPay#OfCycles		= 0
iSchPayDownPay			= 0
nSchPayMinDownPay		= 0.00
nPayDist1				= f_get_value(Dec(szInvoiceAmount))
nPayDist2				= 0.00
nPayDist3				= 0.00
nPayDist4				= 0.00
nPayDist5				= 0.00
nPayDist6				= 0.00
nPayDist7				= 0.00
nPayDist8				= 0.00
nPayDist9				= 0.00
nPayDist10				= 0.00
nPayDist11				= 0.00
iAutoCalcFrt			= 0
szPaymentFrt#			= '""'
nTotalWeight			= 0.00
nFreightChargeAmount	= 0.00
szPaymentTaxNum		= '"no"'
nTaxAmount				= 0.00
nPaymentDiscount		= 0.00
iPaymentDisc			= 0
iNotesHandle			= 0
iImageHandle			= 0
iVoiceHandle			= 0

wf_output_header()




end subroutine

public subroutine wf_output_header ();String szLine
Long iFileNo

If szFileMode = "Replace" then
	iFileNo	= FileOpen(szDirectory + "arb1.txt", LineMode!, Write!, LockWrite!, Replace!)
Else
	iFileNo	= FileOpen(szDirectory + "arb1.txt", LineMode!, Write!, LockWrite!, Append!)
End If

If iFileNo <> -1 then
	szLine	= 	String(iBatchId) + &
					' , ' + String(iDeleteFlag)  + &
					' , ' + szCustomer  + &
					' , ' + szInvDate  + &
					' , ' + szInvNumber   + &
					' , ' + szDept  + &
					' , ' + szInvDescription  + &
					' , ' + String(iInvType)  + &
					' , ' + String(iIMLocation)  + &
					' , ' + szSalesOrder  + &
					' , ' + szDateOrdered  + &
					' , ' + szCustomerPO#  + &
					' , ' + String(iPrintInvoice)  + &
					' , ' + String(iTermsType)  + &
					' , ' + String(iTermsDays)  + &
					' , ' + String(iTermsEOMCutOff)  + &
					' , ' + String(iTermsDiscountDays)  + &
					' , ' + String(iTermsDiscount)  + &
					' , ' + szTermsDescription  + &
					' , ' + szShipTo#  + &
					' , ' + szShipToFrt#  + &
					' , ' + szShipToName  + &
					' , ' + szShipToContact  + &
					' , ' + szShipToAddress  + &
					' , ' + szShipToInstructions  + &
					' , ' + String(iUpdateShipToInfo)  + &
					' , ' + szDefaultAccountMgr  + &
					' , ' + szDefaultPrice#  + &
					' , ' + szDefaultSalesTax  + &
					' , ' + String(iDefaultTaxExempt)  + &
					' , ' + String(iDefaultAllowComm)  + &
					' , ' + String(iFromSO)  + &
					' , ' + String(iItemDiscLevel)  + &
					' , ' + String(iDefaultDiscountPer)  + &
					' , ' + nDefaultFreight#  + &
					' , ' + String(nDefaultCreditLimit)  + &
					' , ' + String(iDefaultPayMethod)  + &
					' , ' + szDefaultReference  + &
					' , ' + String(iUsingSchedPayments)  + &
					' , ' + String(iSchPayType)  + &
					' , ' + String(iSchPayEOMCutOff)  + &
					' , ' + String(iSchPayCycleDays)  + &
					' , ' + String(iSchPay#OfCycles)  + &
					' , ' + String(iSchPayDownPay)  + &
					' , ' + String(nSchPayMinDownPay)  + &
					' , ' + String(nPayDist1)  + &
					' , ' + String(nPayDist2)  + &
					' , ' + String(nPayDist3)  + &
					' , ' + String(nPayDist4)  + &
					' , ' + String(nPayDist5)  + &
					' , ' + String(nPayDist6)  + &
					' , ' + String(nPayDist7)  + &
					' , ' + String(nPayDist8)  + &
					' , ' + String(nPayDist9)  + &
					' , ' + String(nPayDist10)  + &
					' , ' + String(nPayDist11)  + &
					' , ' + String(iAutoCalcFrt)  + &
					' , ' + szPaymentFrt#  + &
					' , ' + String(nTotalWeight)  + &
					' , ' + String(nFreightChargeAmount)  + &
					' , ' + szPaymentTaxNum  + &
					' , ' + String(nTaxAmount)  + &
					' , ' + String(nPaymentDiscount)  + &
					' , ' + String(iPaymentDisc)  + &
					' , ' + String(iNotesHandle)  + &
					' , ' + String(iImageHandle)  + &
					' , ' + String(iImageHandle)  + &
					' , ' + String(iVoiceHandle)

	FileWrite(iFileNo, szLine)
	FileClose(iFileNo)

Else
	MessageBox("Warning", "Can not open ARB1.TXT.", StopSign!)
End If

end subroutine

public subroutine wf_generate_detail (long ishipper);Long iCount
Long iFileNo

If szFileMode = "Replace" then
	iFileNo	= FileOpen(szDirectory + "Arb2.txt", LineMode!, Write!, LockWrite!, Replace!)
Else
	iFileNo	= FileOpen(szDirectory + "Arb2.txt", LineMode!, Write!, LockWrite!, Append!)
End If

If iFileNo > 0 then

	For iCount = 1 to iGL_detail_count
		
		iDtlBatchId				= iInvoice
		iLineItemId				= iCount - 1
		szCode					= '"' + GL_detail[iCount].GL_account + '"'
		iItemType				= 0
		iTaxMask					= 1
		szItemDescription		= '"' + GL_detail[iCount].GL_account + '"'
		iQty						= 1
		iDtlExtendedAmount	= GL_detail[iCount].Amount
		szUnitOfMeasure		= '""'
		szUnitWeight			= '0'
		szIMLocation			= '0'
		szPriceNumber			= '""'
		nExtraFreightAmount	= 0.00
		nUnitPrice				= GL_detail[iCount].Amount
		nUnitCost				= 0
		iPercentDiscount		= 0
		iCommissionType		= 0
		iCommissionAmount		= 0
		iCommissionRate		= 0
		szAccountManager		= '""'
		szShipToNumber			= '""'
		iSerialNumbered		= 0
		iItemIsTaxable			= 1
		szClass					= '""'
		iDtlNotesHandle		= 0
		iDtlImageHandle		= 0
		iDtlVoiceHandle		= 0
	
		wf_output_detail(iFileNo)
	
	Next

	FileClose(iFileNo)

Else

	MessageBox("Warning", "Can not open ARB2.TXT.", StopSign!)

End If
end subroutine

public subroutine wf_add_to_gl_account (string szGL_Account, decimal nAmount);Long 		iCount

Boolean	bFound

bFound = FALSE
iCount = 1

Do while (Not bFound) AND (iCount <= iGL_detail_count)
	If GL_detail[iCount].GL_account = szGL_account then
		bFound	= TRUE
	Else
		iCount ++
	End If
Loop

If bFound then
	GL_detail[iCount].Amount	= 	GL_detail[iCount].amount + &
											f_get_value(nAmount)
Else
	iGL_detail_count ++
	GL_detail[iCount].Amount		= f_get_value(nAmount)
	GL_detail[iCount].GL_account	= szGL_account
End If

		
end subroutine

public subroutine wf_output_detail (long iFileNo);String szLine

szLine	= 	String(iDtlBatchId) + &
				" , " + String(iLineItemId) + &
				" , " + szCode + &
				" , " + String(iItemType) + &
				" , " + String(iTaxMask) + &
				" , " + szItemDescription + &
				" , " + String(iQty) + &
				" , " + String(iDtlExtendedAmount) + &
				" , " + szUnitOfMeasure + &
				" , " + szUnitWeight + &
				" , " + szIMLocation + &
				" , " + szPriceNumber + &
				" , " + String(nExtraFreightAmount) + &
				" , " + String(nUnitPrice) + &
				" , " + String(nUnitCost) + &
				" , " + String(iPercentDiscount) + &
				" , " + String(iCommissionType) + &
				" , " + String(iCommissionAmount) + &
				" , " + String(iCommissionRate) + &
				" , " + szAccountManager + &
				" , " + szShipToNumber + &
				" , " + String(iSerialNumbered) + &
				" , " + String(iItemIsTaxable) + &
				" , " + szClass + &
				" , " + String(iDtlNotesHandle) + &
				" , " + String(iDtlImageHandle) + &
				" , " + String(iDtlVoiceHandle) 


FileWrite(iFileNo, szLine)
end subroutine

public function decimal wf_get_tax_rate (string szdestination);Decimal nRate

SELECT destination.salestax_rate  
  INTO :nRate  
  FROM destination  
 WHERE destination.destination = :szDestination   ;

Return f_get_value(nRate)
end function

public function boolean wf_part_is_taxable (string szpart, string szcustomer);String szTaxable

SELECT part_customer.taxable  
  INTO :szTaxable  
  FROM part_customer  
 WHERE ( part_customer.part = :szPart ) AND  
       ( part_customer.customer = :szCustomer )   ;

Return (szTaxable = 'Y')
end function

public function string wf_get_freight_account ();String szFreightAccount

SELECT parameters.freight_account  
  INTO :szFreightAccount  
  FROM parameters  ;

If IsNull(szFreightAccount) or szFreightAccount = '' then
	Return 'BLANK'
Else
	Return szFreightAccount
End If

end function

public function string wf_get_sales_tax_account ();String szSales_taxAccount

SELECT parameters.Sales_tax_account  
  INTO :szSales_taxAccount  
  FROM parameters  ;

If IsNull(szSales_taxAccount) or szSales_taxAccount = '' then
	Return 'BLANK'
Else
	Return szSales_taxAccount
End If
end function

public subroutine wf_calculate_gl_account ();String 	szGL_account
String	szPriceType
String	szPart
String	szTaxable

Decimal	nPrice
Decimal	nQty
Decimal	nAmount

nInvoiceAmount	= 0
nTax				= 0

SELECT shipper.freight,   
       shipper.tax_rate  
  INTO :nFreight,   
       :nTaxRate  
  FROM shipper  
 WHERE shipper.id = :iShipper   ;

nFreight	= f_get_value(nFreight)
nTaxRate	= f_get_value(nTaxRate)

Declare Cur_GL Cursor For  
 Select shipper_detail.account_code,   
        shipper_detail.alternative_qty,   
        shipper_detail.price,   
        shipper_detail.price_type,  
		  shipper_detail.part,
		  shipper_detail.taxable
   From shipper_detail  
  Where shipper_detail.shipper = :iShipper   ;

Open Cur_GL;

Fetch Cur_GL into :szGL_Account, :nQty, :nPrice, :szPriceType, :szPart, :szTaxable;

Do while SQLCA.SQLCode = 0 
	
	If nPrice >= 0 then
		iSign	= 1
	Else
		iSign	= -1
	End If

	If szPriceType = 'T' then		//Price per thousand
		nAmount	= (nQty * nPrice / 1000) + (iSign * 0.005)
	Else 
		If szPriceType = 'L' then	//Lot price
			nAmount	= nPrice + (iSign * 0.005)
		Else
			nAmount	= (nQty * nPrice) + (iSign * 0.005)
		End If
	End If

	If IsNull(szGL_account) or (szGL_account = '') then
		szGL_account = f_get_part_info(szPart, 'GL ACCOUNT')
		If IsNull(szGL_account) or (szGL_account = '') then
			szGL_account = 'BLANK'
		End If
	End If

	nAmount			= Truncate(f_get_value(nAmount), 2)
	nInvoiceAmount	= nInvoiceAmount + nAmount

	If szTaxable = 'Y' then
		nTax	= nTax + Truncate((nAmount * nTaxRate) + 0.005, 2)
	End If

	//If nAmount > 0 then	
		wf_add_to_gl_account(szGL_account, nAmount)
	//End If

	Fetch Cur_GL into :szGL_Account, :nQty, :nPrice, :szPriceType, :szPart, :szTaxable;

Loop


Close Cur_GL;

nInvoiceAmount	= nInvoiceAmount + f_get_value(nFreight) + f_get_value(nTax)

nFreight	= Truncate(nFreight,2)
If nFreight > 0 then
	wf_add_to_gl_account(wf_get_freight_account(), nFreight)
End If

nTax		= f_get_value(nTax)

If nTax > 0 then
	wf_add_to_gl_account(wf_get_sales_tax_account(), nTax)
End If


end subroutine

on open;st_generic_structure stParm
str_progress stProgress

stParm				= Message.PowerObjectParm

iInvoice				= Long(stParm.value1)
szInvoiceAmount	= stParm.value2
szDirectory			= Trim(f_get_string_value(stParm.value3))
szFileMode			= stParm.value4

Select shipper.id, 
		 shipper.destination,
		 shipper.customer
  Into :iShipper, :szDestination, :szCustomerCode
  From shipper  
 Where shipper.invoice_number = :iInvoice   ;

If SQLCA.SQLCode = -1 then
	Close(this)		//Error finding the shipper
End If

wf_calculate_gl_account()
wf_generate_header()
wf_generate_detail(iShipper)

Close(this)


end on

on w_monitor_intellisoft_account_receivable.create
end on

on w_monitor_intellisoft_account_receivable.destroy
end on

