local inventory = FindMetaTable("Player")

drakz = drakz or GM

function drakz:ShowHelp( ply )
    ply:ConCommand("inventory")
end

function inventory:InventorySave( i )
	if not i then return end
	self:DatabaseSetValue("inventory", i)
end

function inventory:InventoryGet()
	local i = self:DatabaseGetValue("inventory")
	return i
end

function inventory:InventoryHasItem(name, amount)
	if not amount then amount = 1 end
	
	local i = self:InventoryGet()

	if i then
		if i[name] then
			if i[name].amount >= amount then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function inventory:InventoryTakeItem( name, amount )
	if not amount then amount = 1 end
	
	local i = self:InventoryGet()
	
	if self:InventoryHasItem( name, amount ) then
		i[name].amount = i[name].amount - amount
		
		self:InventorySave(i)
		self:DatabaseSend()
		return true
	else
		return false
	end
end

function inventory:InventoryGiveItem(name, amount)
	if not amount then amount = 1 end

	local i = self:InventoryGet()
	local item = GetItems( name )

	if not item then return end
	
	if amount == 1 then
		self:PrintMessage(HUD_PRINTTALK, "You have picked up a "..item.name.."!")
	elseif amount > 1 then
		self:PrintMessage(HUD_PRINTTALK, "You recieved "..amount.." "..item.name.."!")
	end

	if self:InventoryHasItem(name, amount)then
		if i[name].stackable then
			if i[name].amount == i[name].amount + amount >= i[name].maxStack then
				i[name].amount = maxStack
			else
		        i[name].amount = i[name].amount + amount
		    end
		end
	else
		i[name] = { amount = amount }
	end

	self:InventorySave()
	self:DatabaseSend()
end

net.Receive("inventory_drop", function(len, ply)
	local name = net.ReadString()
	if ply:InventoryHasItem(name, 1) then
		ply:InventoryTakeItem(name, 1)
		CreateItem(ply, name, itemSpawnPos(ply), stackable, maxStack)
	end
end)

net.Receive("inventory_use", function(len, ply)
	local name = net.ReadString()
	
	local item = GetItems( name )
	
	if item then
		if ply:InventoryHasItem( name, 1 ) then
			ply:InventoryTakeItem( name, 1 )
			item.use( ply )
		end
	end
end)

local idd = 0
function CreateItem( ply, name, pos)
	local itemT = GetItems(name)
	local i = ply:InventoryGet()
	if itemT then
		idd = idd + 1
		local item = ents.Create( itemT.ent )
		item:SetNWString("name", itemT.name)
		item:SetNWString("itemName", name)
		item:SetNWInt("uID", idd)
		item:SetNWBool("pickup", true)
		item:SetPos( pos )
		item:SetNWEntity("owner", ply)
		item:SetSkin(itemT.skin or 0)
		itemT.spawn(ply, item)

		item:Spawn()
		item:Activate()
	else
		return false
	end
end

function itemSpawnPos( ply )
	local pos = ply:GetShootPos()
	local ang = ply:GetAimVector()

	local td = {}
	td.start = pos
	td.endpos = pos+(ang*80)
	td.filter = ply
	local trace = util.TraceLine(td)
	return trace.HitPos
end

function InventoryPickup(ply)
	local trace = {}
	trace.start = ply:EyePos()
	trace.endpos = trace.start + ply:GetAimVector() * 85
	trace.filter = ply
	local tr = util.TraceLine(trace)

	if(tr.HitWorld) then return end
	if !tr.Entity:IsValid() then return end

	if tr.Entity:GetNWBool("pickup") then
		local item = GetItems(tr.Entity:GetNWString("itemName") )
		if tr.Entity:GetNWBool("pickup") then
			ply:InventoryGiveItem(tr.Entity:GetNWString("itemName"), 1)
			tr.Entity:Remove()
		else
			if tr.Entity:GetNWBool("pickup") then
				ply:InventoryGiveItem( tr.Entity:GetNWString("itemName"), 1)
				tr.Entity:Remove()
			end
		end
	end
end
hook.Add( "KEY_E", "InventoryPickup", InventoryPickup)

net.Receive("KEY_E", function(len, ply)
    hook.Call("KEY_E", GAMEMODE, ply)
end)

