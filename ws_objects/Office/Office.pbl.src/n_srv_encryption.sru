$PBExportHeader$n_srv_encryption.sru
forward
global type n_srv_encryption from n_base
end type
end forward

global type n_srv_encryption from n_base autoinstantiate
end type

forward prototypes
public function string encrypt (string _data, string _key)
public function string decrypt (string _edata, string _key)
end prototypes

public function string encrypt (string _data, string _key);
//	Invoke encryption service.
string	eData
if	not IsNull(_data) then
	open (w_encryption)
	eData = w_encryption.Encrypt (_data, _key)
	close (w_encryption)
else
	SetNull(eData)
end if

return	eData

end function

public function string decrypt (string _edata, string _key);
//	Invoke decryption service.
string	data
if	not IsNull(_eData) then
	open (w_encryption)
	data = w_encryption.Decrypt (_eData, _key)
	close (w_encryption)
else
	SetNull(data)
end if

return	data

end function

on n_srv_encryption.create
call super::create
end on

on n_srv_encryption.destroy
call super::destroy
end on

