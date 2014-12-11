--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

local inventory = {}

local function InventoryReceive( inventory_table )
    inventory = inventory_table
end 

net.Receive("inventory", function(len)
    local inventory_table = net.ReadTable()
	InventoryReceive( inventory_table )
end)

function Inventory()
    return inventory 
end 

function InventoryGetValue( name )
    local pInventory = Inventory()
	
	return pInventory[name]
end 