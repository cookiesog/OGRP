include('shared.lua')

hook.Add("PostDrawOpaqueRenderables", "Organisation", function()
	for _, ent in pairs (ents.FindByClass("organisation_npc")) do
		if ent:GetPos():Distance(LocalPlayer():GetPos()) < 1000 then
			local Ang = ent:GetAngles()

			Ang:RotateAroundAxis( Ang:Forward(), 90)
			Ang:RotateAroundAxis( Ang:Right(), -90)
		
			cam.Start3D2D(ent:GetPos()+ent:GetUp()*80, Ang, 0.35)
				draw.SimpleTextOutlined( 'Organisation Creation', "TargetID", 0, 0, Color( 150, 70, 50, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0, 0, 0, 255))		
                halo.Add(ents.FindByClass("organisation_npc"),Color(150, 70, 50),1,1,2)				
			cam.End3D2D()
		end
	end
end)

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
 function( text ) print( text ) end,
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




 

