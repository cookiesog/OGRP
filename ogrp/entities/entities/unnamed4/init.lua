AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/prison_toiletchunk01f.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	self.ShareGravgun = true

	phys:Wake()
end


function ENT:AcceptInput( Name, Activator, Caller )
    if(Activator:GetNWBool( "isBleeding", true))then
	    Activator:SendLua("GAMEMODE:AddNotify(\"You used the bandage and stopped bleeding.\", NOTIFY_GENERIC, 5)")
		Activator:SetNWBool( "isBleeding", false)
		self:Remove()
	end
end

