AddCSLuaFile()


ENT.Base 			= "base_nextbot"
ENT.Spawnable		= true

local range = 1000
local atkrange = 180
function ENT:PlaySequence( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed  )

end

function ENT:Initialize()


	self:SetModel( "models/Zombie/Classic.mdl" );
	self:SetSkin(math.random(0,1))
	self:SetHealth(200)
	self.maxhealth = self:Health()
	self.speed = 50
	self.damage = 10
	self.flechette_rate = 0
	self.atkdelay = 0
	self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	self.loco:SetDeathDropHeight(500)	//default 200
	self.loco:SetAcceleration(900)		//default 400
	self.loco:SetDeceleration(900)		//default 400
	self.loco:SetStepHeight(18)			//default 18
	self.loco:SetJumpHeight(50)		//default 58
	self.injdelay = 0
	self.Isjumping = false
	self:SetCollisionBounds( Vector(-4,-4,0), Vector(4,4,64) ) 
	
end


--
-- Name: NEXTBOT:BehaveUpdate
-- Desc: Called to update the bot's behaviour
--ord operator">-- Arg1: numberord operator">|interval|How long since the last update
-- Ret1:
--
function ENT:BehaveUpdate( fInterval )


	if ( !self.BehaveThread ) then return end
	
			for k, ply in pairs (player.GetAll()) do
				if ply:GetPos():Distance(self:GetPos()) < 50 and !ply.dodging then
					local push = ( self:GetPos() - ply:GetPos() ):GetNormalized() * -140 --p:GetForward() * -140
					if ply:IsOnGround() then
					ply:SetVelocity(push)
					else
					ply:SetVelocity(push + ply:GetUp() * -140)
					end
				end
			end
			if !self.attacking then
				local ent = ents.FindInSphere( self:GetPos(), atkrange )
					for k,v in pairs( ent ) do
						if v:IsPlayer() and v:Alive() and v:IsValid() then
						self.loco:FaceTowards( v:GetPos() )
						self.target = v
						end
					end
			else
				if !self.target or !self.target:IsValid() then 
				local ent = player.GetAll()
					for k,v in pairs( ent ) do
						if v:IsPlayer() and v:Alive() and v:IsValid() and v:GetPos():Distance(self:GetPos()) < 2100 then
						self.loco:FaceTowards( v:GetPos() )
						self.target = v
						end
					end
				end
			end
	local ok, message = coroutine.resume( self.BehaveThread )
	if ( ok == false ) then


		self.BehaveThread = nil
		Msg( self, "error: ", message, "\n" );


	end


end

function ENT:OnInjured( dmg )
	if self.injdelay < CurTime() then
	self.injdelay = CurTime() + math.random(0.3, 0.4)
	if self:Health() < self.maxhealth/6 and math.random(1,4) == 2 then
		self.escapepos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 
	end
	if dmg:GetAttacker():IsValid() and self.id and timer.Exists("script_attack"..self.id) and dmg:GetDamageType() == DMG_SLASH then
	timer.Remove("script_attack"..self.id)
	self:SetCycle( 0 )
	end
	---self:EmitSound("npc"..math.random(1,2)..".wav")
	end
end

function ENT:PlaySequenceAndAttack( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed  );
	self:EmitSound("npc/fast_zombie/claw_strike"..math.random(1,3)..".wav")
				self.id = CurTime() + math.random(-20,20)
				self.attacking = true
				timer.Create("script_attack"..self.id, len/speed/2 - 0.1, 1, function()
				self.attacking = false
				local ent = ents.FindInCone(self:GetPos(), self:GetForward(),50,70)
					for k,v in pairs( ent ) do
						if v:IsPlayer() and v:Alive() and v:IsValid() then
						self.loco:FaceTowards( v:GetPos() )
						self.Isjumping = false
						v:TakeDamage( math.random(self.damage - 3, self.damage + 4), self, self )  
						--self:MoveToPos( self:GetForward()*-100 )
						end
					end
				end)
	-- wait for it to finish
	coroutine.wait( len / speed )

end
local mdls = {"models/props_c17/pottery06a.mdl",
"models/props_canal/mattpipe.mdl",
"models/gibs/hgibs.mdl",
"models/gibs/antlion_gib_large_2.mdl",
"models/props_c17/doll01.mdl"}

function ENT:PlaySequenceAndAttack2( name, speed )

	local len = self:SetSequence( name )
	speed = speed or 1

	self:ResetSequenceInfo()
	self:SetCycle( 0 )
	self:SetPlaybackRate( speed  );
	self:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")
				self.id = CurTime() + math.random(-20,20)
				self.attacking = true
				timer.Simple(len/speed/2 - 0.1, function()
				self.attacking = false
				if self.target and self.target:IsPlayer() and !self.target.dying and self.target:GetPos():Distance(self:GetPos()) > 500 then
				self.loco:FaceTowards( self.target:GetPos() )
				local angle = self.target:GetPos() - self:GetPos() + Vector(0,0,10)
				local ent = ents.Create( "prop_physics" )
				ent:SetModel(table.Random(mdls))
				ent:SetPos( self:WorldSpaceCenter() + Vector(0,0,20) )
				ent:SetAngles( angle:GetNormalized():Angle() )
				ent:Spawn()
				local time = self:GetPos():Distance(self.target:GetPos())/1000
				timer.Simple(time, function() ent:Remove() end)
				ent:GetPhysicsObject():SetMass(10)
				ent:GetPhysicsObject():ApplyForceCenter(angle:GetNormalized() * time*1000*50)
				ent:SetOwner( self )
				end
				end)
	-- wait for it to finish
	coroutine.wait( len / speed )

end

function ENT:PlayActivity(act)
	if self:GetActivity()~=act then
		self:StartActivity(act)
	end
end

function ENT:ChaseTarget(pos, options)      // Follow a target
    local options = options or {}
    local path = Path("Chase")
    path:SetMinLookAheadDistance(options.lookahead or 300)
    path:SetGoalTolerance(options.tolerance or 20)
 
    path:Compute(self, pos)
	
	local ply = self.Target
 
    while IsValid(ply) && (ply:GetPos()-self:GetPos()):Length() > 50 do
 
        path:Compute(self, ply:GetPos())
        path:Draw()
        path:Chase(self, ply)
         
        -- If we're stuck then call the HandleStuck function and abandon
        if ( self.loco:IsStuck() ) then
 
            self:HandleStuck();
            return "stuck"
        end
 
        coroutine.yield()
    end
 
    return "ok"
end

function ENT:RunBehaviour()


	while ( true ) do

		local ent = player.GetAll()
		local pos
		local oldpos
		local range = 650
		for k, v in pairs (ent) do
			if v:GetPos():Distance(self:GetPos()) < range then
			pos = v:GetPos()
			self.loco:FaceTowards( v:GetPos() )
			end
		end
			if ( pos ) then
				self:StartActivity( ACT_WALK )
				self.loco:SetDesiredSpeed( self.speed )
				self:MoveToPos( pos - self:GetForward()*20 )
				self:SetSequence( "run_all" )
				local ent = ents.FindInSphere( self:GetPos(), atkrange )
					for k,v in pairs( ent ) do
						if v:IsPlayer() and v:Alive() and v:IsValid() then
						self.loco:FaceTowards( v:GetPos() )
						self:PlaySequenceAndAttack( "swing" )
						end
					end
			else
				local pos = self:GetPos() + Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), 0 ) * 200 
				if pos then
				self:StartActivity( ACT_WALK )
				self.loco:SetDesiredSpeed( self.speed )
				self:MoveToPos( pos - self:GetForward()*20 )
				end
				local ent = player.GetAll()
					for k,v in pairs( ent ) do
						if v:IsPlayer() and v:Alive() and v:IsValid() and v:GetPos():Distance(self:GetPos()) > 500 then
						self.loco:FaceTowards( v:GetPos() )
						self:PlaySequenceAndAttack2( "swing" )
						end
					end
			end


		coroutine.yield()


	end


end


function ENT:OnLandOnGround()


	self.Isjumping = false
	self:StartActivity( ACT_WALK )
	
end


function ENT:OnKilled( damageinfo )
	self:BecomeRagdoll( damageinfo )
	if self.id and timer.Exists("script_attack"..self.id) then
	timer.Remove("script_attack"..self.id)
	end
end