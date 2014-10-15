local pistolPrice = 1000
local fragPrice = 1250
local revolverPrice = 3000
local smgPrice = 4000
local shotgunPrice = 5000
local ar2Price = 6000

function GivePlayerAWeapon( ply, cmd, args )
	if args[1] == "pistol" then	
		if ply:MoneyHas( pistolPrice ) then
		    if(!ply:HasWeapon("weapon_pistol"))then
			    ply:Give("weapon_pistol")
				ply:SendLua(
	            [[
				local pistolPrice = 1000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased a 9MM Pistol for $"..pistolPrice..".")]])
			    ply:MoneyTake( pistolPrice )
			else
				ply:SendLua(
	            [[
				local pistolPrice = 1000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have a 9MM Pistol.")]])
			end
		end
	end
	if args[1] == "frag" then	
		if ply:MoneyHas( fragPrice ) then
		    if(!ply:HasWeapon("weapon_frag"))then
			    ply:Give("weapon_frag")
				ply:SendLua(
	            [[
				local fragPrice = 1250
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased a Frag Grenade for $"..fragPrice..".")]])
			    ply:MoneyTake( fragPrice )
			else
				ply:SendLua(
	            [[
				local fragPrice = 1250
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have a Frag Grenade.")]])
			end
		end
	end
	if args[1] == "revolver" then	
		if ply:MoneyHas( revolverPrice ) then
		    if(!ply:HasWeapon("weapon_357"))then
			    ply:Give("weapon_357")
				ply:SendLua(
	            [[
				local revolverPrice = 3000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased a Revolver for $"..revolverPrice..".")]])
			    ply:MoneyTake( revolverPrice )
			else
				ply:SendLua(
	            [[
				local revolverPrice = 3000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have a Revolver.")]])
			end
		end
	end
	if args[1] == "smg" then 
		if ply:MoneyHas( smgPrice ) then		
		    if(!ply:HasWeapon("weapon_smg1"))then
			    ply:Give("weapon_smg1") 
				ply:SendLua(
	            [[
				local smgPrice = 4000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased a Hechlar & Koch Mp7 for $"..smgPrice..".")]])
			    ply:MoneyTake( smgPrice )
			else
				ply:SendLua(
	            [[
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have a Hechlar & Koch Mp7.")]])
			end
		end
	end
	if args[1] == "shotgun" then 
		if ply:MoneyHas( shotgunPrice ) then		
		    if(!ply:HasWeapon("weapon_shotgun"))then
			    ply:Give("weapon_shotgun") 
				ply:SendLua(
	            [[
				local shotgunPrice = 5000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased a SPAS-12 for $"..shotgunPrice..".")]])
			    ply:MoneyTake( shotgunPrice )
			else
				ply:SendLua(
	            [[
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have a SPAS-12.")]])
			end
		end
	end
	if args[1] == "ar2" then 
		if ply:MoneyHas( shotgunPrice ) then		
		    if(!ply:HasWeapon("weapon_ar2"))then
			    ply:Give("weapon_ar2") 
				ply:SendLua(
	            [[
				local ar2Price = 6000
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You have purchased an Assault Rifle 2 (AR2) for $"..ar2Price..".")]])
			    ply:MoneyTake( ar2Price )
			else
				ply:SendLua(
	            [[
	            chat.AddText( Color(255,0,0), "[Gun Dealer]", Color(255,255,255), " You already have an Assault Rifle 2 (AR2).")]])
			end
		end
	end
end --close our function

concommand.Add("gun_weapon_take", GivePlayerAWeapon) 


 