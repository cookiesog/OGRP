
local Humanity = FindMetaTable("Player")

function PlayerInitialSpawnCreateHumanity( ply )
	ply:HumanityCreate()
end
hook.Add("PlayerInitialSpawn", "HumanityInitialSpawn", PlayerInitialSpawnCreateHumanity)

function Humanity:HumanityCreate()
	print("Creating a Metafile row for: " .. self:Nick() )
	self:SetPData( "humanity", 10000 )
	self:SetNWInt( "humanity", 10000 )
end

function Humanity:HumanitySet( humanitynumber )
	self:SetPData( "humanity", tonumber(humanitynumber) )
	self:SetNWInt( "humanity", tonumber(humanitynumber) )
end

function Humanity:HumanityAdd( humanitynumber )
	if humanitynumber > 0 then
		local current = tonumber(self:GetPData( "humanity" ) )
		self:HumanitySet( current + humanitynumber )
	end
end

function Humanity:HumanityTake( humanitynumber )
	local current = tonumber(self:GetPData( "humanity" ) )
	self:HumanitySet( current - humanitynumber )
end

function Humanity:HumanityHas( humanitynumber )
	local current = tonumber(self:GetPData( "humanity" ) )
	if current >= tonumber(humanitynumber) then
		return true
	else
		return false
	end
end


function ZombieHumanity( victim, killer, weapon ) 
	if victim:GetClass() == "npc_zombie" then
		if killer:IsPlayer() then
			killer:HumanityAdd( 5 )
		end
	end
end
hook.Add("OnNPCKilled","ZombieHumanity", ZombieHumanity)

function playerDiesHumanity( victim, weapon, killer )
	victim:SetNWInt("humanity", 10000)
	victim:SetPData("humanity", 10000)
end
hook.Add( "PlayerDeath", "playerDeathHumanity", playerDiesHumanity )
