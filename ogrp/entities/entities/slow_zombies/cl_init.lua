include('shared.lua') language.Add("Slow_zombies","slow_zombies") killicon.Add("Slow_zombies","HUD/killicons/default",Color(255,255,255,255)) ENT.RenderGroup=RENDERGROUP_BOTH function ENT:Draw() self.Entity:DrawModel() end function ENT:DrawTranslucent() self:Draw() end function ENT:BuildBonePositions(NumBones,NumPhysBones) end function ENT:SetRagdollBones(bIn) self.m_bRagdollSetup=bIn end function ENT:DoRagdollBone(PhysBoneNum,BoneNum) end