AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include( "shared.lua" )

function ENT:Initialize()
	self.Entity:SetModel( GetItems( self:GetNWString("itemName") ).model )
	
	self.Entity:PhysicsInit(SOLID_VPHYSICS)
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	self.Entity:SetSolid(SOLID_VPHYSICS)
	self.Entity:SetUseType(SIMPLE_USE)
	local phys = self.Entity:GetPhysicsObject()
	if phys and phys:IsValid() then phys:EnableGravity(true) phys:Wake() end
end

function ENT:SetItemName( name )
	self.itemName = name
end

function ENT:Use( activator, caller )
	GetItems( self:GetNWString("itemName") ).use(activator, self)
end

function ENT:Touch( ent )
end

function ENT:OnRemove()
end

function ENT:Think()
end