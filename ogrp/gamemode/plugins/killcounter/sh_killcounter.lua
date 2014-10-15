
function ZombieKillCounterAndLoot( victim, killer, weapon ) 
    local lootchance = math.random( 3 )
	local lootMoney = math.random( 500 )
	if victim:GetClass() == "npc_zombie" then
		if killer:IsPlayer() then
			killer:SetNWInt("zombiekillcounter", killer:GetNWInt("zombiekillcounter") + 1) 
			if lootchance == 2 then
				killer:MoneyAdd( lootMoney )
				killer:SendLua("GAMEMODE:AddNotify(\"You found $".. lootMoney .." on the body.\", NOTIFY_GENERIC, 5)")
			else
				killer:SendLua("GAMEMODE:AddNotify(\"You did not find anything on the body.\", NOTIFY_GENERIC, 5)")
			end
		end 
	end
end
hook.Add("OnNPCKilled","ZombieKillCounter", ZombieKillCounterAndLoot)
 
function PlayerKillCounter(victim, weapon, killer)
		killer:SetNWInt("playerkillcounter", killer:GetNWInt("playerkillcounter") + 1)
end
hook.Add( "PlayerDeath", "DeathHS", PlayerKillCounter )

function playerDiesResetCounters( victim, weapon, killer )
	victim:SetNWInt("zombiekillcounter", 0)
	victim:SetNWInt("playerkillcounter", 0)
end
hook.Add( "PlayerDeath", "playerDeathTestZCandPC", playerDiesResetCounters )
