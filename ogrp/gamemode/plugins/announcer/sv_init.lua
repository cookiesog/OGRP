--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]
OGRP = OGRP or GM

function OGRP:PlayerSpawn( ply )
	ply:ChatPrint( "Enjoy your new life!" )
end

function OGRP:PlayerInitialSpawn( ply )
	PrintMessage( HUD_PRINTTALK, "Player ".. ply:Nick() .." has joined the server."  )
end

function OGRP:PlayerDeath( victim, weapon, killer )
	local plyKiller = killer:GetName()
	
	PrintMessage( HUD_PRINTTALK, "Player [".. victim:Nick() .."] has died."  )
	
	if(!plyKiller == nil) then
	victim:ChatPrint( "You were killed by "..plykiller.."!" )
	
	else
	victim:ChatPrint( "You have died!")
	
	end
	
end