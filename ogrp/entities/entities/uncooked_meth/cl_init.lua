include("shared.lua")

function ENT:Initialize()

end

function ENT:Draw()
	self:DrawModel()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local Ang2 = self:GetAngles()
	local TextAng2 = Ang2
	local TextAng = Ang
	Ang:RotateAroundAxis(Ang:Forward(), 90)
	TextAng:RotateAroundAxis(TextAng:Right(), 0)

	Ang2:RotateAroundAxis(Ang:Forward(), 90)
	TextAng2:RotateAroundAxis(TextAng:Right(), 180)

	
	local time = self:GetMethTimer()
	local minutes = math.floor(time / 60)
	local sec = time - (minutes * 60)
	local dots = ":"
	if sec < 10 then dots = ":0"
	end
	local actualtime = tonumber(minutes)..dots..tonumber(sec)

	
	
	cam.Start3D2D(Pos + Ang:Right() * -60, TextAng, 0.21)
		
	if time <= 0 then
	draw.SimpleTextOutlined("COOKED", "CloseCaption_Bold", -3.5, -37, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,2, Color( 0,0,0,255))
	else
	draw.SimpleTextOutlined(actualtime, "CloseCaption_Bold", -3.5, -37, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,2, Color( 0,0,0,255))
	end
	cam.End3D2D()
	
	//Backside
	cam.Start3D2D(Pos + Ang2:Right() * -60, TextAng2, 0.21)
	if time <= 0 then
	draw.SimpleTextOutlined("COOKED", "CloseCaption_Bold", -3.5, -37, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,2, Color( 0,0,0,255))
	else
	draw.SimpleTextOutlined(actualtime, "CloseCaption_Bold", -3.5, -37, Color( 255,255,255 ), TEXT_ALIGN_CENTER,0,2, Color( 0,0,0,255))
	end
	cam.End3D2D()
	
end


