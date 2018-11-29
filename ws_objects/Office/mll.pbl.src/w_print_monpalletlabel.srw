$PBExportHeader$w_print_monpalletlabel.srw
forward
global type w_print_monpalletlabel from window
end type
end forward

global type w_print_monpalletlabel from window
boolean visible = false
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Mon Label Printer"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
end type
global w_print_monpalletlabel w_print_monpalletlabel

type prototypes
FUNCTION long RunWait(string command, long winstate) LIBRARY "runwait.dll"

end prototypes

on w_print_monpalletlabel.create
end on

on w_print_monpalletlabel.destroy
end on

event open;
st_generic_structure lstParm
lstParm = Message.PowerObjectParm

//	Find the pallet label format for this pallet.
string palletLabel, objectName

select
	PalletLabel = od.pallet_label
,	ObjectName = rl.object_name
into
	:palletLabel
,	:objectName
from
	dbo.object o
	join dbo.shipper_detail sd
		join dbo.shipper s
			on s.id = sd.shipper
			and s.status in ('O', 'S')
		on sd.shipper =
			(	select
					max(sd.shipper)
				from
					dbo.shipper_detail sd
					join dbo.shipper s
						on s.id = sd.shipper
						and s.status in ('O', 'S')
						and s.type is null
				where
					o.origin in (convert(varchar, sd.order_no), convert(varchar, sd.shipper))
					or o.shipper = sd.shipper
			)
		and sd.part_original = o.part
	join dbo.order_detail od
		on od.id =
			(	select
					min(od.id)
				from
					dbo.order_detail od
				where
					od.part_number = o.part
					and od.order_no = sd.order_no
			)
	left join dbo.report_library rl
		on rl.name = od.pallet_label
where
	o.serial =
		(	select
				min(o.serial)
			from
				dbo.object o
			where
				o.parent_serial = convert(int, :lstParm.value1)
		)  ;

window palletPrinterObject
if	SQLCA.SQLCode = 0 then
	lstParm.Value12 = PalletLabel
	OpenWithParm(palletPrinterObject, lstParm, objectName)
else
	lstParm.Value12 = "PALLET"
	OpenWithParm(palletPrinterObject, lstParm, "w_bartender")
end if
close (this)

end event

