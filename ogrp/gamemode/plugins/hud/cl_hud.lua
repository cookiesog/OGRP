--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

surface.CreateFont( "ogrpHUD3",

	{
	
		font = "Roboto",
		size = 22,
		weight = 400,
		shadow = true
	
	}
	
)

surface.CreateFont( "ogrpHUD4",

	{
	
		font = "Roboto",
		size = 20,
		weight = 400
	
	}
	
)

surface.CreateFont( "ogrpHUD5",

	{
	
		font = "Roboto",
		size = 16,
		weight = 400,
		shadow = true
	
	}
	
)

surface.CreateFont( "ogrpHUD6",

	{
	
		font = "Roboto",
		size = 32,
		weight = 400,
		shadow = false,
		italic = true
	
	}
	
)

local ConVars = {}
local HUDWidth
local HUDHeight

CreateClientConVar("weaponhud", 0, true, false)

local function ReloadConVars()
	ConVars = {
		background = {0,0,0,100},
		Healthbackground = {0,0,0,200},
		Healthforeground = {140,0,0,180},
		HealthText = {255,255,255,200},
	}

	for name, Colour in pairs(ConVars) do
		ConVars[name] = {}
		for num, rgb in SortedPairs(Colour) do
			local CVar = GetConVar(name..num) or CreateClientConVar(name..num, rgb, true, false)
			table.insert(ConVars[name], CVar:GetInt())

			if not cvars.GetConVarCallbacks(name..num, false) then
				cvars.AddChangeCallback(name..num, function() timer.Simple(0,ReloadConVars) end)
			end
		end
		ConVars[name] = Color(unpack(ConVars[name]))
	end


	HUDWidth = (GetConVar("HudW") or  CreateClientConVar("HudW", 240, true, false)):GetInt()
	HUDHeight = (GetConVar("HudH") or CreateClientConVar("HudH", 115, true, false)):GetInt()

	if not cvars.GetConVarCallbacks("HudW", false) and not cvars.GetConVarCallbacks("HudH", false) then
		cvars.AddChangeCallback("HudW", function() timer.Simple(0,ReloadConVars) end)
		cvars.AddChangeCallback("HudH", function() timer.Simple(0,ReloadConVars) end)
	end
end
ReloadConVars()

local GradientU = surface.GetTextureID( "vgui/gradient-d" )

local function DrawFancyRectangle( x, y, Wide, Tall, Color )

	draw.RoundedBox( 0, x, y, Wide, Tall, Color )

	surface.SetDrawColor( 255, 255, 255, Color.a - 251 )
	surface.DrawOutlinedRect( x + 1, y + 1, Wide - 2, Tall - 2 )

	surface.SetDrawColor( 0, 0, 0, Color.a / 2 )
	surface.SetTexture( GradientU )
	surface.DrawTexturedRect( x, y, Wide, Tall )

end

local Health = 0

local function DrawBlood()
	local bloodVariable = LocalPlayer():GetNWInt( "blood" ) / 100

	DrawFancyRectangle( 8, ScrH() - ( 1070), 480, 18, Color( 152, 0, 0, 64 ) )
	
	DrawFancyRectangle( 8, ScrH() - ( 1070), bloodVariable * 4.80, 18, Color( 152, 0, 0, 255 ) )
	local drawbloodVariable = LocalPlayer():GetNWInt( "blood" )
	draw.DrawText( "Blood: "..drawbloodVariable.."L", "ogrpHUD5",280,ScrH() - (1070), Color( 228, 228, 228, 255 ), 2, 1 )
end

function DrawBleeding()
    local isBleeding = LocalPlayer():GetNWBool( "isBleeding" )

	if(isBleeding)then
		DrawFancyRectangle( 8, ScrH() - ( 1050), 480, 18, Color( 255, 100, 100, 255 ) )
        draw.DrawText( "You are bleeding!", "ogrpHUD5", 280, ScrH() - ( 1050 ), Color( 228, 228, 228, 255 ), 2, 1 )
	end
end

local function DrawInfo()
	local money = LocalPlayer():GetNWInt( "cash" )
	local blood = LocalPlayer():GetNWInt( "blood" )
	local organisation = LocalPlayer():GetNWString( "organisation" )
	local bloodstring = "Healthy"

	if(blood >= 9000) then
	    bloodstring = "Healthy"
	elseif(blood >= 7000)then
	    bloodstring = "Mildly Injured"
	elseif(blood >= 5000)then
	    bloodstring = "Badly Injured"
   elseif(blood >= 3000) then
	    bloodstring = "Severely Injured"
	end	
	
	-- [[ Make more open ended, use a function to create these in us for the future .. ughh, temporary hud ]] --
	DrawFancyRectangle( 88, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 88, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Health ", "ogrpHUD4", 182, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( bloodstring, "ogrpHUD4", 150, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )		

	DrawFancyRectangle( 380, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 380, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Armour ", "ogrpHUD4", 472, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( "None", "ogrpHUD4", 475, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )
	
	DrawFancyRectangle( 672, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 672, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Stamina", "ogrpHUD4", 764, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( "100%", "ogrpHUD4", 773, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )	

	DrawFancyRectangle( 964, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 964, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Playtime", "ogrpHUD4", 1056, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( "NULL", "ogrpHUD4", 1059, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )

	DrawFancyRectangle( 1256, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 1256, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Wallet", "ogrpHUD4", 1348, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( "$"..money, "ogrpHUD4", 1331, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )

	DrawFancyRectangle( 1548, ScrH() - ( 40), 250, 30, Color( 60, 60, 60, 170 ) )
	DrawFancyRectangle( 1548, ScrH() - ( 60), 250, 20, Color( 255, 255, 255, 170 ) )
 	draw.DrawText( "Organisation", "ogrpHUD4", 1620, ScrH() -60, Color( 0, 0, 0, 255 ), 0, 1 )	 	
 	draw.DrawText( organisation, "ogrpHUD4", 1613, ScrH() -35, Color( 214, 214, 214, 255 ), 0, 1 )			
end

local function DrawHUD()
	Scrw, Scrh = ScrW(), ScrH()
	RelativeX, RelativeY = 0, Scrh

	--DrawFancyRectangle( 16, ScrH() - ( 136 + 32 ), 320 + 32, 166, Color( 24, 24, 30, 224 ) )

	DrawBlood()
	DrawInfo()
	DrawBleeding()
end

function GM:HUDPaint()
	DrawHUD()

	self.BaseClass:HUDPaint()
end

function hidehud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then return false end
	end
end
hook.Add("HUDShouldDraw", "HideOurHud", hidehud)