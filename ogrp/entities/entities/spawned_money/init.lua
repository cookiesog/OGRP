AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Gibs/HGIBS.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local phys = self:GetPhysicsObject()
	--self.nodupe = true
	self.ShareGravgun = true

	phys:Wake()
end


function ENT:Use(activator,caller)
	local amount = self:Getamount()

	activator:MoneyAdd(amount or 0)
	activator:ChatPrint( "You have found $"..amount )
	self:Remove()
end

