--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]
local ply = FindMetaTable("Player")
-- local dataFolder = "server/ogrp/inventory_data/"

util.AddNetworkString( "inventory" )

-- Player default inventory.
function ply:DefaultInventory()
    local inventoryItem = {}

	inventoryItem["weapon_pistol"] = { amount = 1 }
	self:InventorySetValue( "inventory", inventoryItem)
end

function ply:CreateSteamID()
	    local id = self:SteamID()
	    local id = tostring(id)
	    local id = string.Replace(id, "STEAM_0:0:", "")
	    local id = string.Replace(id, "STEAM_0:1:", "")
	    
	    return id
end

function ply:InventorySaveFolder()
	return "server/ogrp/players/"..self:CreateSteamID().."/"
end

function ply:InventorySaveLocation()
    return self:InventorySaveFolder().."inventory.txt"
end

-- The inventory is basically a big table.
function ply:InventorySet( tab )
    self.inventory = tab
end

function ply:InventoryExists()
	local Exists = file.Exists(self:InventorySaveLocation(), "DATA")
	return Exists
end

-- Function to check if player has an inventory. If a player doesn't have one it will create and if they do it will load.
function ply:InventoryInitialize()
    self.inventory = {}
	
	if self:InventoryExists() then
	    self:InventoryLoad()
	else
	    self:InventoryCreate()
	end
	
	self:InventorySendToClient()
end

-- Returns the inventory table.
function ply:GetInventory()
    return self.inventory
end

-- Sending information to client via a net stream (cannot be intercepted)
function ply:InventorySendToClient()
    net.Start( "inventory" )
	    local pInventory = net.WriteTable( self:GetInventory() )
    net.Send( pInventory )	
end

-- Converting the separated table into a readable table. (Load) Converting KeyValues into a table.
function ply:InventoryLoad() 
    self:InventorySet( util.KeyValuesToTable( file.Read(self:InventorySaveLocation(), "DATA") ) )
end

-- Writing to the inventory.txt in the personalized folder, with the table self.inventory and converting to KeyValues
function ply:InventorySave()
	local dataString = util.TableToKeyValues(self.inventory)
	local f = file.Write(self:InventorySaveLocation(), dataString)
	self:InventorySendToClient()
end

-- Creates a player's personal folder and sets a player's default inventory then saves (which creates the file because it doesn't exist)
function ply:InventoryCreate()
	local b = file.CreateDir(self:InventorySaveFolder())
	self:InventorySave()
end

-- Set a value to an item in a player's inventory.
function ply:InventorySetValue( name, v )
    if not v then return end
	
	if type(v) == "table" then
        if name == "inventory" then
            for k,b in pairs(v) do
			    if b.amount <= 0 then
				    v[k] = nil 
                end
		    end
		end
	end
	
	local i = self:GetInventory()
	i[name] = v
	
	self:InventorySave()
	
end

-- Get a value from an item in a player's inventory.
function ply:InventoryGetValue( name )
    local pInventory = self:GetInventory()
	
    return pInventory[name]
end

-- When a player's SteamID is authorized by VAC servers it will initalize and create/load inventory.
function ogrp:PlayerAuthed(ply, steamID, uniqueID)
   ply:InventoryInitialize()

end

-- If a player disconnects, save their inventory.
function ogrp:PlayerDisconnected( ply )
   self:InventorySave()
end














