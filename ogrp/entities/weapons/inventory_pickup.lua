SWEP.PrintName = "Inventory Pickup"

SWEP.Purpose = "Picking up stuff"
SWEP.Instructions = "Primary attack: pick up item\nSecondary attack: view inventory"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = ""

SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.Slot               = 1
SWEP.SlotPos 			= 10
SWEP.DrawAmmo           = false
SWEP.DrawCrosshair      = true

function SWEP:Initialize()
	self:SetWeaponHoldType( "normal" )
end

if SERVER then
	AddCSLuaFile()
	
	function SWEP:PrimaryAttack()
		self.Owner:PickupItem()
	end

	function SWEP:SecondaryAttack()
		local w, h = unpack( self.Owner:GetInventoryDimensions() )
		itemstore.containers.Open( self.Owner, self.Owner:GetInventory(), "Inventory", w, h, true )
	end
else
	function SWEP:PrimaryAttack()
	end

	function SWEP:SecondaryAttack()
	end
end
	