AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

MethSystemCookingTime = 300 
MethSystemHealth = 50 
MethSystemOverCookLowSeconds = 90 
MethSystemOverCookMaxSeconds = 180
MethSystemMoneyDropLowAmount = 500 
MethSystemMoneyDropMaxAmount = 2000
MethSystemMinRadius = 150 
MethSystemMaxRadius = 350

function ENT:Initialize()
	self:SetModel("models/props_c17/oildrum001.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMaterial("models/debug/debugwhite")
	self:SetColor(Color(150,150,150))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self.damage = MethSystemHealth
	self:SetMethTimer(MethSystemCookingTime)
		
	local phys = self:GetPhysicsObject()
	phys:Wake()
end

function ENT:OnTakeDamage(dmg)

	self.damage = (self.damage) - dmg:GetDamage()
	if self.damage < 1 then
	self:Explode()
	end
end

function ENT:StartTouch(ent)
	if ent:IsValid() and ent:GetClass() == "meth_stove" then
		self.IsCooking = true
		if !self.TimeOn then
		self:StartTimer()
		end
	end
end

function ENT:OverCook()
		if self.IsDone and self.IsCooking then
		timer.Create("Explode"..tostring(self:EntIndex()),math.random(MethSystemOverCookLowSeconds,MethSystemOverCookMaxSeconds), 1, function()
		self:Explode()
		end)
	end
end

function ENT:EndTouch(entt)

	if entt:IsValid() and entt:GetClass() == "meth_stove" then
	self.TimeOn = false
	self.Cooking = false
	timer.Pause("countdown"..tostring(self:EntIndex()))
	timer.Pause("Explode"..tostring(self:EntIndex()))
	end
end

function ENT:StartTimer()
	self.TimeOn = true
	
	if self:GetMethTimer() < 1 then 
	self.IsDone = true
	self:OverCook()
	return end
	
	timer.Create("countdown"..tostring(self:EntIndex()), 1, 1, function()
	if self.IsDone then
	self:SetMethTimer(0)
	return end
	
	self:SetMethTimer(self:GetMethTimer() - 1)
	self:StartTimer()
	end)

end

function ENT:Use(ply)
	local moneyrnd = math.random(MethSystemMoneyDropLowAmount,MethSystemMoneyDropMaxAmount)
	if self.IsDone then
	self:Remove()
	
	ply:SendLua(
	[[
	chat.AddText( Color(255,0,0), "[Meth]", Color(255,255,255), " You have sold your meth for $]] .. moneyrnd .. [[.")]])
	
	money = ents.Create("spawned_money")
	money:SetPos(self:GetPos())
	money:Setamount(moneyrnd)
	money:Spawn()
	else
	ply:SendLua(
	[[
	chat.AddText( Color(255,0,0), "[Meth]", Color(255,255,255), " The meth has not been cooked, place the meth on a stove too cook it.")]])
	
	
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
	local dist = math.random(MethSystemMinRadius, MethSystemMaxRadius) -- Explosion radius
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
	
function ENT:Remove()
	timer.Stop("countdown"..tostring(self:EntIndex()))
	timer.Stop("Explode"..tostring(self:EntIndex()))
	self:SetMethTimer(0)
end
