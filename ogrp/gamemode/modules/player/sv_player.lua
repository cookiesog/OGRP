--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

function GM:PlayerSpawn( ply )
	ply:ChatPrint( "GM:PlayerSpawn" )
	
	ply:SetWalkSpeed(ogrp.config.walkSpeed)
	ply:SetRunSpeed(ogrp.config.runSpeed)
end

function GM:PlayerLoadout( ply )
	ply:Give("weapon_fists")
	ply:Give("weapon_physgun")
    ply:SelectWeapon("weapon_fists")
	
   	if(ply:GetUserGroup() == "VIP" or ply:IsAdmin() or ply:SteamID() == "STEAM_0:0:29277001") then 	
   	    ply:Give("weapon_physgun")
	end
	
	return false
end
