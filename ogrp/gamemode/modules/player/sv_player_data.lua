--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

function GM:PlayerInitialSpawn(ply)
	timer.Create("Delay", 1, 1, function()
		SteamID = ply:SteamID()
		ply:SetNWString("SteamID", SteamID)
	    MySQL_PlayerExists( ply )
		
	    timer.Create("DataSave"..steamID, ogrp.config.saveInterval, 0, function() MySQL_SaveData( ply ) end)
	end)
end

function MySQL_PlayerExists ( ply )
	steamID = ply:GetNWString("SteamID")	
	selectPlayer = "SELECT steam_id, cash, blood, organisation FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." WHERE steam_id = '"..steamID.."'"
	
	local fplayer = ply
	local mysqlQuery = ogrp.db.object:query(selectPlayer)
	mysqlQuery:start()
	
	print("PlayerExists")		
	function mysqlQuery:onSuccess(data)
	    print("Debug:Stage1")
	    if #data > 0 then	
            print("Loading data")
		    MySQL_LoadData( fplayer )			
	    else
		    print("Debug:CreateNewPlayer")
		    MySQL_CreateNewPlayer( steamID, fplayer )	
	    end
	end
end

function MySQL_CreateNewPlayer( SteamID, ply )
 	steamID = SteamID
	
    checkIfCreated = "SELECT steam_id FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." WHERE steam_id = '"..steamID.."'"	
	createPlayer = "INSERT INTO "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.."(steam_id, cash, blood, organisation)VALUES ('"..steamID.."', '5000', '10000', '')"
	
    local createCheck = ogrp.db.object:query(checkIfCreated)	
	local playerMySQLQuery = ogrp.db.object:query(createPlayer)
	
    local finishedQuery = createCheck:start()
	playerMySQLQuery:start()

 	MySQL_LoadData( ply )

end

function MySQL_LoadData ( ply )
	Data = "SELECT * FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." WHERE steam_id = '"..steamID.."'"
	local mysqlQuery = ogrp.db.object:query(Data)
	mysqlQuery:start()
	
	local fplayer = ply	
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then
	        local row = data[1]
			
	        local rowData = {} 
            rowData.SteamID = row.steam_id
            rowData.Cash = row.cash
            rowData.Blood = row.blood
            rowData.Organisation = row.organisation			
			
			fplayer:SetNWString("steam_id", rowData.SteamID)			
		    fplayer:SetNWInt("cash", rowData.Cash)
	        fplayer:SetNWInt("blood", rowData.Blood)
			fplayer:SetNWString("organisation", rowData.Organisation)
			
	    end
	end
	
end

function MySQL_SaveData ( ply )
	cash = ply:GetNWInt("cash")
	blood = ply:GetNWInt("blood")
	organisation = ply:GetNWString("organisation")
	steam_id = ply:GetNWString("SteamID")
	
	if(blood == nil) then
	    ply:SetNWInt("blood", 10000)
	end
	
	cashQueryString = "UPDATE "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." SET cash = "..cash.." WHERE steam_id = '"..steam_id.."'"
	bloodQueryString = "UPDATE "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." SET blood = "..blood.." WHERE steam_id = '"..steam_id.."'"
	
    local cashQuery = ogrp.db.object:query(cashQueryString)	
	local bloodQuery = ogrp.db.object:query(bloodQueryString)
	
	cashQuery:start()
	bloodQuery:start()

	
	print("[SAVE] Steam ID: "..steam_id.." Money: $"..cash.." Blood: "..blood.."L")	
end

function GM:PlayerDisconnected(ply)
   MySQL_SaveData( ply )
   
    if(ply:SteamID()) then 
        timer.Remove("DataSave"..ply:SteamID())
    end
end
