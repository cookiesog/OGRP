surface.CreateFont( "DrakZHUD3",

	{
	
		font = "Roboto",
		size = 22,
		weight = 400,
		shadow = true
	
	}
	
)

surface.CreateFont( "DrakZHUD4",

	{
	
		font = "Roboto",
		size = 20,
		weight = 400
	
	}
	
)

surface.CreateFont( "DrakZHUD5",

	{
	
		font = "Roboto",
		size = 16,
		weight = 400,
		shadow = true
	
	}
	
)

surface.CreateFont( "DrakZHUD6",

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

	DrawFancyRectangle( 8, ScrH() - ( 172), 480, 18, Color( 152, 0, 0, 64 ) )
	
	DrawFancyRectangle( 8, ScrH() - ( 172), bloodVariable * 4.80, 18, Color( 152, 0, 0, 255 ) )
	local drawbloodVariable = LocalPlayer():GetNWInt( "blood" )
	draw.DrawText( "Blood: "..drawbloodVariable.."L", "DrakZHUD5",280,ScrH() - (172), Color( 228, 228, 228, 255 ), 2, 1 )
end



--[[ 
function DrawThirst()
    local thirstVariable = LocalPlayer():GetNWInt( "thirst" ) / 100
    local drawthirstVariable = LocalPlayer():GetNWInt( "thirst" )
	DrawFancyRectangle( 8, ScrH() - ( 32 + 24 + 995 ), 480, 24, Color( 0, 80, 156, 64 ) )
	
	DrawFancyRectangle( 8, ScrH() - ( 32 + 24 + 995 ), thirstVariable * 4.80, 24, Color( 0, 80, 156, 255 ) )
	draw.DrawText( "Thirst: " ..drawthirstVariable, "DrakZHUD5",280,ScrH() - (32 + 26 + 990), Color( 228, 228, 228, 255 ), 2, 1 )
end

function DrawHunger()
    local hungerVariable = LocalPlayer():GetNWInt( "hunger" ) / 100
    local drawhungerVariable = LocalPlayer():GetNWInt( "hunger" )
	DrawFancyRectangle( 8, ScrH() - ( 32 + 993), 480, 24, Color( 0, 156, 80, 64 ) )
	
	DrawFancyRectangle( 8, ScrH() - ( 32 + 993), hungerVariable * 4.80, 24, Color( 0, 156, 80, 255 ) )
	draw.DrawText( "Hunger: " ..drawhungerVariable, "DrakZHUD5",280,ScrH() - (32 + 990), Color( 228, 228, 228, 255 ), 2, 1 )
	
end

-- ]]

function DrawBleeding()
    local isBleeding = LocalPlayer():GetNWBool( "isBleeding" )

	if(isBleeding)then
		DrawFancyRectangle( 8, ScrH() - ( 197), 480, 18, Color( 255, 100, 100, 255 ) )
        draw.DrawText( "You are bleeding!", "DrakZHUD5", math.Clamp( 16 + 100 * 1.60, 96, 16 + 100 * 1.60 ), ScrH() - ( 197 ), Color( 228, 228, 228, 255 ), 2, 1 )
	end
end

local function DrawInfo()
	local money = LocalPlayer():GetNWInt( "cash" )
	local humanity = LocalPlayer():GetNWInt( "humanity" )
	local blood = LocalPlayer():GetNWInt( "blood" )
	local bloodstring = "Healthy"
	surface.SetFont( "DrakZHUD3" )
  
	DrawFancyRectangle( 8, ScrH() - ( 150), 480, 140, Color( 0, 0, 0, 170 ) )
	draw.DrawText( "Money: $"..money, "DrakZHUD4", 42, ScrH() - 130, Color( 214, 214, 214, 255 ), 0, 1 )
	
	if(blood >= 9000) then
	    bloodstring = "Healthy"
	elseif(blood >= 7000)then
	    bloodstring = "Mildly Injured"
	elseif(blood >= 5000)then
	    bloodstring = "Badly Injured"
	elseif(blood >= 3000) then
	    bloodstring = "Severely Injured"
	end
	draw.DrawText( "Health: "..bloodstring, "DrakZHUD4", 42, ScrH() - 110, Color( 214, 214, 214, 255 ), 0, 1 )	
    draw.DrawText( "Organisation: null", "DrakZHUD4", 42, ScrH() - 90, Color( 214, 214, 214, 255 ), 0, 1 )
	draw.DrawText( "Stamina: 100", "DrakZHUD4", 42, ScrH() - 70, Color( 214, 214, 214, 255 ), 0, 1 )	
	draw.DrawText( "Playtime: null", "DrakZHUD4", 42, ScrH() - 50, Color( 214, 214, 214, 255 ), 0, 1 )		
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