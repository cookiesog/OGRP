--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]
DeriveGamemode("base")

ogrp = ogrp or GM
GM.Name = "ogrp"
GM.Author = "Cookies"

AddCSLuaFile( 'sh.config.lua' )
include( 'sh_config.lua' )

if SERVER then
    require('mysqloo')
end
