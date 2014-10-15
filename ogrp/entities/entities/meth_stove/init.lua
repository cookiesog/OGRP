AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/furnitureStove001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	local phys = self:GetPhysicsObject()
	phys:Wake()	
	self.damage = 350
end

function ENT:OnTakeDamage(dmg)

	self.damage = (self.damage) - dmg:GetDamage()
	if self.damage < 1 then
	self:Explode()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1000000000)
	util.Effect("Explosion", effectdata)
	
	local effectdata1 = EffectData()
	effectdata1:SetStart(vPoint)
	effectdata1:SetOrigin(vPoint)
	effectdata1:SetScale(1000000000)
	util.Effect("HelicopterMegaBomb", effectdata)
	
	local effectdata2 = EffectData()
	effectdata2:SetStart(self:GetPos() + self:GetAngles():Up() * 600)
	effectdata2:SetOrigin(self:GetPos() + self:GetAngles():Up() * 600)
	effectdata2:SetScale(1000000000)
	util.Effect("HelicopterMegaBomb", effectdata)
end


function ENT:Explode()
	local dist = math.random(150, 200) -- Explosion radius
	self:Destruct()
	for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
	if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" then
		v:Ignite(math.random(15, 30), 0)
	elseif v:IsPlayer() then
	local distance = v:GetPos():Distance(self:GetPos())
	v:TakeDamage(distance / dist * 150, self, self)
	v:Ignite(math.random(8, 25), 0)
	end
end
self:Remove()
end

local function PickupEnt3 (ply, ent)
	if(ent:GetClass() == "meth_stove") then
		if ply == ent.dt.owning_ent then return true
		else return false
		end
	end
end

hook.Add("PhysgunPickup", "PickUpStove", PickupEnt3)