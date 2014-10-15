AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( 'shared.lua' )
AddCSLuaFile( 'cl_init.lua' )
include( 'shared.lua' )



function ENT:Initialize()
    self.lootLeft = true
    modelTable = {"models/props_c17/Lockers001a.mdl","models/props_c17/oildrum001.mdl", "models/props_borealis/bluebarrel001.mdl", "models/props_c17/FurnitureDresser001a.mdl"}
	self:SetModel( modelTable[math.random(1,4)] )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()


end

function ENT:AcceptInput( Name, Activator, Caller )
if not IsValid(self) then return end
	if self.lootLeft then
	    self.beginSoundEffects = true
		timer.Create( "timerbla", 5, 0, function()
		    if not IsValid(self) then return end
            Activator:SendLua("GAMEMODE:AddNotify(\"You found loot, now fuck off.\", NOTIFY_GENERIC, 5)")
			
			self.lootLeft = false
			self.beginSoundEffects = false
			
			self.moneyBonus = math.random(1, 2)		
			if(self.moneyBonus == 2)then
			    self.lootMoney = math.random(1, 500)
			    Activator:SendLua("GAMEMODE:AddNotify(\"You have scavenged $"..self.lootMoney..".\", NOTIFY_GENERIC, 5)")
		    end
		end)
	else
	    Activator:SendLua("GAMEMODE:AddNotify(\"There is nothing left to loot here.\", NOTIFY_GENERIC, 5)")
	end
	
	timer.Create("soundeffects", 1, 0, function()
	    if self.beginSoundEffects then
		    Activator:EmitSound("ambient/misc/clank"..math.random(1,4)..".wav")
		end
	end)
end