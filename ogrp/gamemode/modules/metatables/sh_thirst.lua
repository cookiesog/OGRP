local startThirst = 10000
local thirst = true

local Thirst = FindMetaTable("Player")

function playerDiesThirst( victim, weapon, killer )
	victim:SetNWInt("thirst", startThirst)
	victim:SetPData("thirst", startThirst)
	timer.Stop("thirst_timer")
end
hook.Add( "PlayerDeath", "playerDeathThirst", playerDiesThirst )

function PlayerInitialSpawnCreateThirst( ply )
	ply:ThirstCreate()
	local current = tonumber(self:GetPData( "thirst" )) 
	self:SetPData( "thirst", current )
    self:SetNWInt( "thirst", tonumber(current) )
end
hook.Add("PlayerInitialSpawn", "InitialSpawn", PlayerInitialSpawnCreateThirst)

function Thirst:ThirstStartAmount()
    return startThirst
end

function Thirst:ThirstCreate()
	print("Creating a Metafile row for: " .. self:Nick() )
	if self:GetPData("thirst") == nil then
		self:SetPData( "thirst", startThirst )
	else
		local current = tonumber(self:GetPData( "thirst" ) )
		self:SetPData( "thirst", tonumber(current) )
	    self:SetNWInt( "thirst", tonumber(current) )
	end
end

function Thirst:ThirstSet( thirstnumber )
	self:SetPData( "thirst", tonumber(thirstnumber) )
	self:SetNWInt( "thirst", tonumber(thirstnumber) )
	if(current > 10000) then
		ply:ThirstSet(10000)
	end
end

function Thirst:ThirstAdd( thirstnumber )
	if thirstnumber > 0 then
		local current = tonumber(self:GetPData( "thirst" ) )
		self:ThirstSet( current + thirstnumber )
		if(current > 10000) then
		ply:ThirstSet(10000)
	    end
	end
end

function Thirst:ThirstTake( thirstnumber )
	local current = tonumber(self:GetPData( "thirst" ) )
	self:ThirstSet( current - thirstnumber )
	if(current > 10000) then
		ply:ThirstSet(10000)
	end
end

function Thirst:ThirstHas( thirstnumber )
	local current = tonumber(self:GetPData( "thirst" ) )
	if current >= tonumber(thirstnumber) then
		return true
	else
		return false
	end
end
if SERVER then
    if thirst == true then
        timer.Create( "thirst_timer", 0.9, 0, function()
	        for k, ply in pairs(player.GetAll()) do
			    local current = tonumber(ply:GetPData( "thirst" ) )
		        ply:ThirstTake(math.random(1, 4))
				if(current <= 0)then
				    ply:ThirstSet(startThirst)
				else if(current >= 10000) then
					ply:ThirstSet(10000)
			    end
				end
		    end
	    end )
    end
end

	
	
	
	
	
	