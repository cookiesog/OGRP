/*
function zombiekillcounter()  
	local zombies = LocalPlayer():GetNWInt( "zombiekillcounter" )
	draw.SimpleText( "Zombies Killed: ".. zombies, "CloseCaption_Bold", 16, ScrH() / 2 - 50, Color(200,50,255 ) )
end
hook.Add("HUDPaint","ZombieKillCounter", zombiekillcounter)  

function playerkillcounter()  
	local survivors = LocalPlayer():GetNWInt( "playerkillcounter" )
	draw.SimpleText( "Survivors Killed: ".. survivors, "CloseCaption_Bold", 16, ScrH() / 2, Color(200,50,255 ) )
end
hook.Add("HUDPaint","PlayerKillCounter", playerkillcounter)  


local function HumanityDraw()
	local humanity = LocalPlayer():GetNWInt( "humanity" )
	draw.SimpleText( "Sanity: ".. humanity, "CloseCaption_Bold", 16, ScrH() / 2 - 150, Color(200,50,255 ) )
end
hook.Add("HUDPaint", "HumanityPainting", HumanityDraw)





