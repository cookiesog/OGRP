

local GradientU = surface.GetTextureID( "vgui/gradient-d" )

local function DrawFancyRectangle( x, y, Wide, Tall, Color )

	draw.RoundedBox( 0, x, y, Wide, Tall, Color )

	surface.SetDrawColor( 255, 255, 255, Color.a - 251 )
	surface.DrawOutlinedRect( x + 1, y + 1, Wide - 2, Tall - 2 )

	surface.SetDrawColor( 0, 0, 0, Color.a / 2 )
	--surface.SetTexture( GradientU )
	--surface.DrawTexturedRect( x, y, Wide, Tall )

end

function F1Menu()
    local w = 1920
    local h = 100

	local f = vgui.Create("DFrame")
	f:SetSize(w, h)
	f:SetPos( (ScrW()/2) - (w/2), (ScrH()/2) - (h*5.5) )
	f:SetTitle("")
	f:SetDraggable(false)
	f:ShowCloseButton(false)
    f:SetBackgroundBlur(true)
    f:MakePopup()
    f.Paint = function()
        ---draw.RoundedBox(0,0,0,self:GetWide(), self:GetTall(), Color(255,255,255,255))
        draw.RoundedBox(0,0,0,f:GetWide(), 800, Color(0,0,0,170))
    end
	
local Button = vgui.Create("DButton", f)
Button:SetParent( f )
Button:SetText( "Inventory" )
Button:SetPos(955, 5)
Button:SetSize( 633, 90)
Button:Center()
Button.DoClick = function ( btn )
f:Close()
end

Button.Paint = function()
	DrawFancyRectangle( 0, 0, Button:GetWide(), Button:GetTall(), Color( 255, 255, 255, 230 ) )
end

local Button2 = vgui.Create("DButton", f)
Button2:SetParent( f )
Button2:SetText( "Attributes" )
Button2:SetPos(1282, 5)
Button2:SetSize( 633, 90)
Button2.DoClick = function ( btn )
f:Close()
end
Button2.Paint = function()
	DrawFancyRectangle( 0, 0, Button2:GetWide(), Button2:GetTall(), Color( 255, 255, 255, 230 ) )
end

local Button3 = vgui.Create("DButton", f)
Button3:SetParent( f )
Button3:SetText( "Crafting" )
Button3:SetPos(5, 5)
Button3:SetSize( 633, 90)
Button3.DoClick = function ( btn )
f:Close()
end
Button3.Paint = function()
	DrawFancyRectangle( 0, 0, Button3:GetWide(), Button3:GetTall(), Color( 255, 255, 255, 230 ) )
end

end
concommand.Add("f1menu", F1Menu)