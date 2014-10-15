ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Unnamed"
ENT.Author = "Cookies"
ENT.Spawnable = true
ENT.Category = "Cookies"
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"amount")
end
