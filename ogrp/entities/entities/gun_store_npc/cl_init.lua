include('shared.lua')

hook.Add("PostDrawOpaqueRenderables", "Gun Store Head", function()
	for _, ent in pairs (ents.FindByClass("gun_store_npc")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
				draw.SimpleTextOutlined( 'Gun Dealer', "CloseCaption_Bold", 0, 0, Color( 150, 70, 50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))			
			cam.End3D2D()
		end
	end
end)

function GunShopMenu()
local WeaponFrame = vgui.Create("DFrame") --create a frame
WeaponFrame:SetSize(500, 250) --set its size
WeaponFrame:Center() --position it at the center of the screen
WeaponFrame:SetTitle("What would you like to buy?") --set the title of the menu 
WeaponFrame:SetDraggable(false) --can you move it around
WeaponFrame:SetSizable(false) --can you resize it?
WeaponFrame:ShowCloseButton(true) --can you close it
WeaponFrame:MakePopup() --make it appear
WeaponFrame.Paint = function()
    draw.RoundedBox(4, 0, 0, WeaponFrame:GetWide(), WeaponFrame:GetTall(), Color(50,150,100,255))
	draw.RoundedBox(2, 2, 2, WeaponFrame:GetWide()-4, 21, Color(80,50,120,250))
end
 
local PistolButton = vgui.Create("DButton", WeaponFrame)
PistolButton:SetSize(230, 50)
PistolButton:SetPos(10, 35)
PistolButton:SetText("Pistol ($1000)")
PistolButton.DoClick = function() RunConsoleCommand("gun_weapon_take", "pistol") end --make it run our "weapon_take" console command with "pistol" as the 1st argument and then close the menu
PistolButton.Paint = function()
    draw.RoundedBox(4, 0, 0, PistolButton:GetWide(), PistolButton:GetTall(), Color(250,100,100,220))
end

local FragButton = vgui.Create("DButton", WeaponFrame)
FragButton:SetSize(230, 50)
FragButton:SetPos(250, 35)
FragButton:SetText("Frag Grenade ($1250)") --Set the name of the button
FragButton.DoClick = function() RunConsoleCommand("gun_weapon_take", "frag") end
FragButton.Paint = function()
    draw.RoundedBox(4, 0, 0, FragButton:GetWide(), FragButton:GetTall(), Color(250,100,100,220))
end
--weapon_357
local RevolverButton = vgui.Create("DButton", WeaponFrame)
RevolverButton:SetSize(230, 50)
RevolverButton:SetPos(10, 95)
RevolverButton:SetText("Revolver ($3000)") --Set the name of the button
RevolverButton.DoClick = function() RunConsoleCommand("gun_weapon_take", "revolver") end
RevolverButton.Paint = function()
    draw.RoundedBox(4, 0, 0, RevolverButton:GetWide(), RevolverButton:GetTall(), Color(250,100,100,220))
end

local SMGButton = vgui.Create("DButton", WeaponFrame)
SMGButton:SetSize(230, 50)
SMGButton:SetPos(250, 95)
SMGButton:SetText("MP7 ($4000)") --Set the name of the button
SMGButton.DoClick = function() RunConsoleCommand("gun_weapon_take", "smg") end
SMGButton.Paint = function()
    draw.RoundedBox(4, 0, 0, SMGButton:GetWide(), SMGButton:GetTall(), Color(250,100,100,220))
end

local ShotgunButton = vgui.Create("DButton", WeaponFrame)
ShotgunButton:SetSize(230, 50)
ShotgunButton:SetPos(10, 155)
ShotgunButton:SetText("SPAS-12 ($5000)") --Set the name of the button
ShotgunButton.DoClick = function() RunConsoleCommand("gun_weapon_take", "shotgun") end
ShotgunButton.Paint = function()
    draw.RoundedBox(4, 0, 0, ShotgunButton:GetWide(), ShotgunButton:GetTall(), Color(250,100,100,220))
end

--weapon_ar2
local AR2Button = vgui.Create("DButton", WeaponFrame)
AR2Button:SetSize(230, 50)
AR2Button:SetPos(250, 155)
AR2Button:SetText("AR2 ($6000)") --Set the name of the button
AR2Button.DoClick = function() RunConsoleCommand("gun_weapon_take", "ar2") end
AR2Button.Paint = function()
    draw.RoundedBox(4, 0, 0, AR2Button:GetWide(), AR2Button:GetTall(), Color(250,100,100,220))
end

end




 

