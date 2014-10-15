ENT.Base="base_ai"
ENT.Type="ai"
ENT.PrintName="Nordahl_zombies"
ENT.Author="Nordahl"
ENT.Category="SNPCs"
ENT.Spawnable=false
ENT.AdminSpawnable=false
ENT.AutomaticFrameAdvance=true
function ENT:PhysicsCollide(data,physobj)
end
function ENT:PhysicsUpdate(physobj)
end
function ENT:SetAutomaticFrameAdvance(bUsingAnim)
self.AutomaticFrameAdvance=bUsingAnim
end 