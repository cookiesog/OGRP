AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	--self:SetModel("models/props/cs_office/water_bottle.mdl")
	self:SetModel("models/props_combine/combine_intmonitor001.mdl")
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()

end


function ENT:AcceptInput( Name, Activator, Caller )

end

