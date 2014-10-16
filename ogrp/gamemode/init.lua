--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]
OGRP = OGRP or GM

local developmentMode = true

AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )
util.AddNetworkString( "KEY_E" )
include( 'shared.lua' )

function OGRP:PlayerSpawn( ply )
	ply:ChatPrint( "Enjoy your new life!" )
end

function OGRP:PlayerLoadout( ply )
	ply:Give("weapon_fists")
	ply:Give("weapon_gravgun")
    ply:SelectWeapon("weapon_fists")
	
    if(ply:GetUserGroup() == "VIP" or ply:IsAdmin()) then 
    	ply:Give("weapon_physgun")
    end
 
	return false
end

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


