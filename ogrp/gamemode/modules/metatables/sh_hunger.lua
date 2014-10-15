local startHunger = 10000
local hunger = true

local Hunger = FindMetaTable("Player")

function playerDiesHunger( victim, weapon, killer )
	victim:SetNWInt("hunger", startHunger)
	victim:SetPData("hunger", startHunger)
	timer.Stop("hunger_timer")
end
hook.Add( "PlayerDeath", "playerDeathHunger", playerDiesHunger )

function PlayerInitialSpawnCreateMoney( ply )
	ply:HungerCreate()
end
hook.Add("PlayerInitialSpawn", "InitialSpawn", PlayerInitialSpawnCreateMoney)

function Hunger:HungerStartAmount()
    return startHunger
end

function Hunger:HungerCreate()
	print("Creating a Metafile row for: " .. self:Nick() )
	if self:GetPData("hunger") == nil then
		self:SetPData( "hunger", startHunger )
	else
		local current = tonumber(self:GetPData( "hunger" ) )
		self:SetPData( "hunger", tonumber(current) )
	    self:SetNWInt( "hunger", tonumber(current) )
	end
end

function Hunger:HungerSet( hungernumber )
	self:SetPData( "hunger", tonumber(hungernumber) )
	self:SetNWInt( "hunger", tonumber(hungernumber) )
end

function Hunger:HungerAdd( hungernumber )
	if hungernumber > 0 then
		local current = tonumber(self:GetPData( "hunger" ) )
		self:HungerSet( current + hungernumber )
	end
end

function Hunger:HungerTake( hungernumber )
	local current = tonumber(self:GetPData( "hunger" ) )
	self:HungerSet( current - hungernumber )
end

function Hunger:HungerHas( hungernumber )
	local current = tonumber(self:GetPData( "hunger" ) )
	if current >= tonumber(hungernumber) then
		return true
	else
		return false
	end
end

if SERVER then
    if hunger == true then
        timer.Create( "hunger_timer", 2, 0, function()
	        for k, ply in pairs(player.GetAll()) do
				local current = tonumber(ply:GetPData( "hunger" ) )
		        ply:HungerTake(1)
		        ply:DataAdd("Hunger", 50)
		        print(ply:GetCurrentData("Hunger"))
				if(current <= 0)then
				    ply:HungerSet(startHunger)
				end
		    end
	    end )
    end
end
	
	
	
	
	
	