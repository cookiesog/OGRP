ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stove"
ENT.Author = "Drakanouhai"
ENT.Category = "Drakanouhai"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity",1,"owning_ent")
end