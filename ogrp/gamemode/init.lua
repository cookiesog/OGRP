--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]
ogrp = ogrp or GM

require('mysqloo')

AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )

include( 'shared.lua' )

util.AddNetworkString( "KEY_E" )

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
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do
		include(fol.. folder .. "/" ..File)
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do
		AddCSLuaFile(fol.. folder .. "/" ..File)
	end
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
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/sv_*.lua", "LUA"), true) do
		include(fol.. folder .. "/" ..File)
	end

	for _, File in SortedPairs(file.Find(fol .. folder .."/cl_*.lua", "LUA"), true) do
		AddCSLuaFile(fol.. folder .. "/" ..File)
	end
end



