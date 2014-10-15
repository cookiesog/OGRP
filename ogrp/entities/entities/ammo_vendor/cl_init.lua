include('shared.lua')

function AmmoShopMenu()
local WeaponFrame = vgui.Create("DFrame") --create a frame
WeaponFrame:SetSize(500, 250) --set its size
WeaponFrame:Center() --position it at the center of the screen
WeaponFrame:SetTitle("Ammo Store") --set the title of the menu 
WeaponFrame:SetDraggable(false) --can you move it around
WeaponFrame:SetSizable(false) --can you resize it?
WeaponFrame:ShowCloseButton(true) --can you close it
WeaponFrame:MakePopup() --make it appear
 
local PistolAmmoButton = vgui.Create("DButton", WeaponFrame)
PistolAmmoButton:SetSize(100, 30)
PistolAmmoButton:SetPos(10, 35)
PistolAmmoButton:SetText("Pistol Ammo ($250)")
PistolAmmoButton.DoClick = function() RunConsoleCommand("ammo_weapon_take", "pistolammo") end --make it run our "weapon_take" console command with "pistol" as the 1st argument and then close the menu
 
local SMGAmmoButton = vgui.Create("DButton", WeaponFrame)
SMGAmmoButton:SetSize(100, 30)
SMGAmmoButton:SetPos(120, 35)
SMGAmmoButton:SetText("SMG Ammo ($500)") --Set the name of the button
SMGAmmoButton.DoClick = function() RunConsoleCommand("ammo_weapon_take", "smgammo") end

end
