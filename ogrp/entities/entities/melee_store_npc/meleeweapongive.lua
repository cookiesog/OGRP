
function GivePlayerAMelee( ply, cmd, args ) 
	if args[1] == "crowbar" then	
		if ply:MoneyHas( 5000 ) then	
			ply:Give("weapon_crowbar") 
			ply:ChatPrint("YOU HAVE PURCHASED: WEAPON_CROWBAR") 
			ply:MoneyTake( 5000 )
		end
	end 
end 

concommand.Add("melee_weapon_take", GivePlayerAMelee)


 