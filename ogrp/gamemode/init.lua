--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

util.AddNetworkString( "KEY_E" )

include( 'shared.lua' )

-- Set this to true to allow console output!
local developmentMode = true

if(developmentMode)then
print("")
print("[OGRP] [MODULES] Loading modules...")
end

local fol = GM.FolderName.."/gamemode/modules/"
local files, folders = file.Find(fol .. "*", "LUA")
for k,v in pairs(files) do
	include(fol .. v)
end

for _, folder in SortedPairs(folders, true) do
	if folder == "." or folder == ".." then continue end
	for _, File in SortedPairs(file.Find(fol .. folder .."/sh_*.lua", "LUA"), true) do
		AddCSLuaFile(fol..folder .. "/" ..File)
		include(fol.. folder .. "/" ..File)
		if(developmentMode)then
		print("[OGRP] [SHARED] Loaded module file: ( "..File.." ) from module: ".."["..folder.."].")
	    end
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do
		include(fol.. folder .. "/" ..File)
		if(developmentMode)then
		print("[OGRP] [SERVER] Loaded module file: ( "..File.." ) from module: ".."["..folder.."].")
	    end
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do
		AddCSLuaFile(fol.. folder .. "/" ..File)
		if(developmentMode)then
		print("[OGRP] [CLIENT] Loaded module file: ( "..File.." ) from module: ".."["..folder.."].")
	    end
	end
end

if(developmentMode)then
print("")
print("[OGRP] [PLUGINS] Loading plugins...")
end

local fol = GM.FolderName.."/gamemode/plugins/"
local files, folders = file.Find(fol .. "*", "LUA")
for k,v in pairs(files) do
	include(fol .. v)
end

for _, folder in SortedPairs(folders, true) do
	if folder == "." or folder == ".." then continue end

	for _, File in SortedPairs(file.Find(fol .. folder .."/sh_*.lua", "LUA"), true) do
		AddCSLuaFile(fol..folder .. "/" ..File)
		include(fol.. folder .. "/" ..File)
        if(developmentMode)then
		print("[OGRP] [SHARED] Loaded plugin file: ( "..File.." ) from plugin: ".."["..folder.."].")
	    end
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do
		include(fol.. folder .. "/" ..File)
	    if(developmentMode)then
		print("[OGRP] [SERVER] Loaded plugin file: ( "..File.." ) from plugin: ".."["..folder.."].")
	    end
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do
		AddCSLuaFile(fol.. folder .. "/" ..File)
		if(developmentMode)then
		print("[OGRP] [CLIENT] Loaded plugin file: ( "..File.." ) from plugin: ".."["..folder.."].")
	    end
	end
end

function PlayerSpawned( ply )
	ply:ChatPrint( "Enjoy your new life!" )
	ply:MoneyCreate()
	ply:ThirstCreate()
	ply:HungerCreate()
	timer.Start("thirst_timer")
	timer.Start("hunger_timer")
	local currentChar = tonumber(ply:GetPData( "char" ) )
	print(currentChar)
end
hook.Add("PlayerSpawn", "Spawned", PlayerSpawned)

function Loadout( ply )
	ply:Give("weapon_fists")
	ply:Give("weapon_physgun")
    ply:SelectWeapon("weapon_fists")
 
	return false
end
hook.Add( "PlayerLoadout", "Loadout", Loadout)

function FirstSpawn( ply )
	local current = tonumber(ply:GetPData( "cash" ) )
	ply:MoneySet( current )
--	ply:DatabaseCheck()
	ply:DatabaseSetup()
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawn", FirstSpawn )

function playerDies( victim, weapon, killer )
	local current = tonumber(victim:GetPData( "cash" ) )
	victim:MoneySet( current )
end
hook.Add( "PlayerDeath", "playerDeathTest", playerDies )

function GM:PlayerDisconnected(ply)
	ply:DatabaseDisconnect()
end

hook.Add( "OnReloaded", "Test", function()
    print( "test" )
end )


