local maxZombie = 10
local spawntable = { Vector(-437,-639,-83), Vector(-413,824,-83), Vector(-1742,632,-83), Vector(-135,-824,-83), Vector(-346,-372,-83), Vector(-542,589,-83), Vector(-738,100,-83), Vector(-1000,0,-83), Vector(-1256,-135,-83), Vector(-1620,-1100,-83)  }
local zombieOn = true

local function GetAliveZombie()
	local zombieCount = 0

	local ZombieTypes = {"npc_zombie", "npc_fastzombie"}
	for _, Type in pairs(ZombieTypes) do
		zombieCount = zombieCount + #ents.FindByClass(Type)
	end

	return zombieCount
end

local function SpawnZombie()
	timer.Create("zombietimer", 5, 0, function()
	if GetAliveZombie() >= maxZombie then return end

	local ZombieTypes = {"npc_zombie", "npc_fastzombie"}
	local zombieType = math.random(1, #ZombieTypes)
    local pos = table.Random(spawntable)
	local Zombie = ents.Create(ZombieTypes[zombieType])
	Zombie:Spawn()
	Zombie:Activate()
	
	Zombie:SetPos(pos)
	end )
end