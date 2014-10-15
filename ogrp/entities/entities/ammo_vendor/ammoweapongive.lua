
function GivePlayerAmmo( ply, cmd, args )
	if args[1] == "pistolammo" then	
		if ply:MoneyHas( 1000 ) then	
			ply:Give("item_ammo_pistol")
			ply:ChatPrint("YOU HAVE PURCHASED: PISTOL_AMMUNITION")
			ply:MoneyTake( 1000 )
		end
	end
	if args[1] == "smgammo" then 
		if ply:MoneyHas( 2000 ) then		
			ply:Give("item_ammo_smg1") 
			ply:ChatPrint("You have purchased")
			ply:MoneyTake( 2000 )
		end
	end
end --close our function

concommand.Add("ammo_weapon_take", GivePlayerAmmo) 


 