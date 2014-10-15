ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Uncooked Meth"
ENT.Author = "Drakanouhai"
ENT.Category = "Drakanouhai"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar( "Float", 0, "MethTimer" );
end