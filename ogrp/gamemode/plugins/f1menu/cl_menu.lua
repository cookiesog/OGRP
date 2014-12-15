--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

local function DrawFancyRectangle( x, y, Wide, Tall, Color )

	draw.RoundedBox( 0, x, y, Wide, Tall, Color )

	surface.SetDrawColor( 255, 255, 255, Color.a - 251 )
	surface.DrawOutlinedRect( x + 1, y + 1, Wide - 2, Tall - 2 )

	surface.SetDrawColor( 0, 0, 0, Color.a / 2 )
end

function F1Menu()
    local w = 605
    local h = 100

	local f = vgui.Create("DFrame")
	f:SetSize(ScrW(), h)
	f:SetPos(0, (ScrH()/2) - (h*5.5) )
	f:SetTitle("")
	f:SetDraggable(false)
	f:ShowCloseButton(false)
    f:SetBackgroundBlur(true)
    f:MakePopup()
    f.Paint = function()
        ---draw.RoundedBox(0,0,0,self:GetWide(), self:GetTall(), Color(255,255,255,255))
		DrawFancyRectangle(0,0,f:GetWide(), 800, Color(50,50,50,255))
		DrawFancyRectangle(0,f:GetTall() - 5,f:GetWide(), 5, Color(255,255,255,255))
    end

local ButtonColor = {} 

ButtonColor.butt1 = Color(52,52,52,255)
ButtonColor.butt1bot = Color(255,255,255,255)

ButtonColor.butt2 = Color(52,52,52,255)
ButtonColor.butt2bot = Color(255,255,255,255)

ButtonColor.butt3 = Color(52,52,52,255)
ButtonColor.butt3bot = Color(255,255,255,255)

local Button = vgui.Create("DButton", f)
Button:SetParent( f )
Button:SetText( "Inventory" )
Button:SetPos(860,10)
Button:SetSize( 200, 90)
Button:SetFont("ogrpHUD22")
Button.DoClick = function ( btn )
f:Close()
end

Button.Paint = function()
	DrawFancyRectangle( 0, 0, Button:GetWide(), Button:GetTall(), ButtonColor.butt1 )
	DrawFancyRectangle( 0, 85, Button:GetWide(), Button:GetTall() - 85, ButtonColor.butt1bot )
end

Button.OnCursorEntered = function()
	--ButtonColor.butt1 = Color(235,235,235,255)
    ButtonColor.butt1bot = Color(0,180,255,255)
end

Button.OnCursorExited = function()
	--ButtonColor.butt1 = Color(50,50,50,255)
    ButtonColor.butt1bot = Color(255,255,255,255)	
end

local Button2 = vgui.Create("DButton", f)
Button2:SetParent( f )
Button2:SetText( "Character" )
Button2:SetPos(650, 10)
Button2:SetSize( 200, 90)
Button2:SetFont("ogrpHUD22")

Button2.DoClick = function ( btn )
f:Close()
end

Button2.Paint = function()
	DrawFancyRectangle( 0, 0, Button:GetWide(), Button:GetTall(), ButtonColor.butt2 )
	DrawFancyRectangle( 0, 85, Button:GetWide(), Button:GetTall() - 85, ButtonColor.butt2bot )	
end

Button2.OnCursorEntered = function()
	--ButtonColor.butt2 = Color(235,235,235,255)
    ButtonColor.butt2bot = Color(0,180,255,255)	
end

Button2.OnCursorExited = function()
	--ButtonColor.butt2 = Color(50,50,50,255)
    ButtonColor.butt2bot = Color(255,255,255,255)	
end

local Button3 = vgui.Create("DButton", f)
Button3:SetParent( f )
Button3:SetText( "Organisation" )
Button3:SetPos(1070, 10)
Button3:SetSize( 200, 90)
Button3:SetFont("ogrpHUD22")
Button3.DoClick = function ( btn )
OrganisationMenu()
end
Button3.Paint = function()
	DrawFancyRectangle( 0, 0, Button:GetWide(), Button:GetTall(), ButtonColor.butt3 )
	DrawFancyRectangle( 0, 85, Button:GetWide(), Button:GetTall() - 85, ButtonColor.butt3bot )	
end

Button3.OnCursorEntered = function()
	--ButtonColor.butt3 = Color(235,235,235,255)
    ButtonColor.butt3bot = Color(0,180,255,255)	
end

Button3.OnCursorExited = function()
	--ButtonColor.butt3 = Color(50,50,50,255)
    ButtonColor.butt3bot = Color(255,255,255,255)	
end

end
concommand.Add("f1menu", F1Menu)

function OrganisationMenu()
local OrgMenu = vgui.Create("DFrame")
OrgMenu:SetSize(500, 250)
OrgMenu:Center()
OrgMenu:SetTitle("Organisation Window")
OrgMenu:SetDraggable(false)
OrgMenu:SetSizable(false)
OrgMenu:ShowCloseButton(true)
OrgMenu:MakePopup() 
OrgMenu.Paint = function()
    draw.RoundedBox(4, 0, 0, OrgMenu:GetWide(), OrgMenu:GetTall(), Color(212,212,212,255))
	draw.RoundedBox(2, 2, 2, OrgMenu:GetWide()-4, 21, Color(80,50,120,250))
end

local OrgCreate = vgui.Create("DButton", OrgMenu)
OrgCreate:SetSize(235, 200)
OrgCreate:SetPos(10, 35)
OrgCreate:SetText("Create Organisation")
OrgCreate.DoClick = function()
Derma_StringRequest( 
 "Create Organisation", 
 "Input a name for your new organisation.",
 "",
 function( text ) 
       print( "Sending text to server" )
       net.Start( "CreateOrganisation" )
           net.WriteString( text )
       net.SendToServer()
	
   end,
 function( text ) print( "Cancelled input" ) end,
 "Create Organisation.",
 "Nevermind."
 )
end
OrgCreate.Paint = function()
    draw.RoundedBox(4, 0, 0, OrgCreate:GetWide(), OrgCreate:GetTall(), Color(255,255,255,220))
end

local OrgJoin = vgui.Create("DButton", OrgMenu)
OrgJoin:SetSize(230, 200)
OrgJoin:SetPos(255, 35)
OrgJoin:SetText("Join Organisation")
OrgJoin.DoClick = function()

end
OrgJoin.Paint = function()
    draw.RoundedBox(4, 0, 0, OrgJoin:GetWide(), OrgJoin:GetTall(), Color(255,255,255,220))
end


end


	
