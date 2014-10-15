local spawntable = { Vector(-437,-639,-83), Vector(-413,824,-83), Vector(-1742,632,-83), Vector(-135,-824,-83), Vector(-346,-372,-83), Vector(-542,589,-83), Vector(-738,100,-83), Vector(-1000,0,-83), Vector(-1256,-135,-83), Vector(-1620,-1100,-83)  }
local zombies = false
local maximumZombies = 5
local pos = table.Random(spawntable)
if SERVER then
    if zombies then
	    if(ents.FindInSphere(spawntable),64)) then
		    if(!ents.FindByName(npc_zombie)) then
			    if(ents.FindByClass("npc_zombie") < maximumZombies) then
	                timer.Create("zombietimer", 5, 0, function()
		                local pos = table.Random(spawntable)
		                spawn_zombie(pos)
				    end )	
                end
            end
	    end
    end

    function spawn_zombie( pos )
	    local zombie = ents.Create("npc_zombie")
	    zombie:SetPos(pos)
	    zombie:SetAngles(Angle(0, math.random(0, 360), 0))
	    zombie:Spawn()
	end
end