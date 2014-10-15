include('shared.lua')

hook.Add("PostDrawOpaqueRenderables", "Melee Store Head", function()
	for _, ent in pairs (ents.FindByClass("melee_store_npc")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
				draw.SimpleTextOutlined( 'Melee Dealer', "CloseCaption_Bold", 0, 0, Color( 0, 150, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))			
			cam.End3D2D()
		end
	end
end)

function MeleeShopMenu()
local WeaponFrame = vgui.Create("DFrame") --create a frame
WeaponFrame:SetSize(500, 250) --set its size
WeaponFrame:Center() --position it at the center of the screen
WeaponFrame:SetTitle("Melee Store") --set the title of the menu 
WeaponFrame:SetDraggable(false) --can you move it around
WeaponFrame:SetSizable(false) --can you resize it?
WeaponFrame:ShowCloseButton(true) --can you close it
WeaponFrame:MakePopup() --make it appear
 
local CrowbarButton = vgui.Create("DButton", WeaponFrame)
CrowbarButton:SetSize(100, 30)
CrowbarButton:SetPos(10, 35)
CrowbarButton:SetText("Crowbar ($5000)")
CrowbarButton.DoClick = function() RunConsoleCommand("melee_weapon_take", "crowbar") end
end
 


