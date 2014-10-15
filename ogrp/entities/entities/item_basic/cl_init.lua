include("shared.lua")

function ENT:Think()
end

function ENT:Draw()
	self:DrawModel()
    if(EyePos():Distance(self.Entity:GetPos())<124)then
        hook.Add("PreDrawHalos","AddHalos",function()
            halo.Add(ents.FindByClass("item_basic"),Color(0,255,0),1,1,2)
	    end)
    end
end