

local Blood = FindMetaTable("Player")

function PlayerInitialSpawnCreateBlood( ply )
	ply:SetNWBool( "isBleeding", false)
end
hook.Add("PlayerInitialSpawn", "HumanityInitialSpawn", PlayerInitialSpawnCreateBlood)

function Blood:BloodSet( bloodnumber )
	self:SetNWInt( "blood", tonumber(bloodnumber) )
end

function Blood:BloodAdd( bloodnumber )
	if bloodnumber > 0 then
		local current = tonumber(self:GetNWInt( "blood" ) )
		self:BloodSet( current + Bloodnumber )
	end
end

function Blood:BloodTake( bloodnumber, ply )
	local current = tonumber(self:GetNWInt( "blood" ) )
	self:BloodSet( current - bloodnumber )
	if current <= 1 then
		self:Kill()
	end
end

function Blood:BloodHas( bloodnumber )
	local current = tonumber(self:GetNWInt( "blood" ) )
	if current >= tonumber(bloodnumber) then
		return true
	else
		return false
	end
end

function playerDiesBlood( victim, weapon, killer )
	victim:SetNWInt("blood", 10000)
	timer.Stop("bleed_timer")
end
hook.Add( "PlayerDeath", "playerDeathBlood", playerDiesBlood )

function checkAlive(ply)
	if ply:Alive() then
		return true
	else 
		return false
	end 
end 

function GM:EntityTakeDamage( ent, inflictor, attacker, amount )
	if ( ent:IsPlayer() ) then ent:SetHealth(100) end
	local rando = math.random(1, 5)
	if ( ent:IsPlayer() ) then
		ent:BloodTake( 250 )
		if rando == 2 then
			local randomBleedTime = math.random(2, 18)
			timer.Create( "bleed_timer", 1, randomBleedTime, function()	
				ent:BloodTake( 100 )
				ent:SetNWBool("isBleeding", true)
			    timer.Simple(randomBleedTime, function()
	                ent:SetNWBool("isBleeding", false)
			    end)
			end)
		end 
	end
end
--[[
function GM:EntityTakeDamage( ent, inflictor, attacker, amount )
	if ( ent:IsPlayer() ) then ent:SetHealth(100) end
	local rando = math.random(1, 5)
	if ( ent:IsPlayer() ) then
		ent:BloodTake( math.random(50,250) )
		if rando == 2 then
			local randomBleedTime = math.random(15, 120)
			timer.Create( "bleed_timer", 1, randomBleedTime, function()	
			    ent:SetPData
				ent:BloodTake( math.random(1, 15) )
				ent:SetNWBool("isBleeding", true)
			    timer.Simple(randomBleedTime, function()
	                ent:SetNWBool("isBleeding", false)
			    end)
			end)
		end 
	end
end
]]--


 

