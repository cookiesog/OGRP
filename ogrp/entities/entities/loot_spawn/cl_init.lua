include('shared.lua')

function ENT:Draw()
	self:DrawModel()
    if(EyePos():Distance(self.Entity:GetPos())<258)then
        hook.Add("PreDrawHalos","AddHalos",function()
		    if self.lootLeft then
                halo.Add(ents.FindByClass("loot_spawn"),Color(255,0,0),1,1,2)
			    else if !self.lootLeft then
			        halo.Add(ents.FindByClass("loot_spawn"),Color(0,255,0),1,1,2)
				end
			end
	    end)
    end
end