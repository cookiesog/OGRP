--[[
	© 2013 Drakansoftentertainment.com do not share, re-distribute or modify
	without permission of its author (Drakanouhai@drakansoftentertainment.com).
--]]


function PlayerSpawned( ply )
	ply:ChatPrint( "Enjoy your new life!" )
end
hook.Add("PlayerSpawn", "Spawned", PlayerSpawned)

function FirstSpawn( ply )
	PrintMessage( HUD_PRINTTALK, "Player ".. ply:Nick() .." has joined the server."  )
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

function playerDies( victim, weapon, killer )
	local plyKiller = killer:GetName()
	PrintMessage( HUD_PRINTTALK, "Player [".. victim:Nick() .."] has died."  )
	if(!plyKiller == nil) then
	victim:ChatPrint( "You were killed by "..plykiller.."!" )
	else
	victim:ChatPrint( "You have died!")
	end
end
hook.Add( "PlayerDeath", "playerDeathTest", playerDies )