-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
include( 'meleeweapongive.lua' )
-------------------------------

----------------
-- Initialize --
----------------
function ENT:Initialize()
	self:SetModel( "models/Humans/Group02/male_09.mdl" )
	self:SetHullType( HULL_HUMAN )
	self:SetHullSizeNormal( )
	self:SetNPCState( NPC_STATE_SCRIPT )
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd( CAP_ANIMATEDFACE )
	self:SetUseType( SIMPLE_USE )
	self:DropToFloor()
 
	self:SetMaxYawSpeed( 180 )
end


-----------------
-- Take Damage -- 
-----------------
function ENT:OnTakeDamage( dmginfo )
	return false
end

------------
-- On use --
------------
function ENT:AcceptInput( Name, Activator, Caller )	
	if Name == "Use" and Caller:IsPlayer() then
		Activator:SendLua("MeleeShopMenu()")
	end
end

