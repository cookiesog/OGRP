--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

OGRP = OGRP or GM

-- Start of documentation for OGRP.
local mysql_hostname = '127.0.0.1' -- Your MySQL server address.
local mysql_username = 'root' -- Your MySQL username.
local mysql_password = 'root' -- Your MySQL password.
local mysql_database = 'ogrp' -- Your MySQL database.
local mysql_table_name = 'player_data' -- Your MySQL table name.
local mysql_port = 3306 -- Your MySQL port. Most likely is 3306.
local mysql_create_tables = false -- Set this to true when you want to create tables and make sure to set to false afterwards.
local mysql_save_time = 30 -- The interval in between saving player data.

-- It is best you do not edit below this point.
require('mysqloo')

local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)
db:connect()

function OGRP:Initialize()
end

function db:onConnected()
    print('MySQL: Connected!')
	
	if(mysql_create_tables) then
	    MySQL_CreateTables()
	
	end
	
end

function db:onConnectionFailed(err)
    print('MySQL: Connection Failed, please check your settings: ' .. err)
end

function OGRP:PlayerInitialSpawn( ply )
	
	timer.Create("Delay", 1, 1, function()
		SteamID = ply:SteamID()
		ply:SetNWString("SteamID", SteamID)
	    MySQL_PlayerExists( ply )		
	end)
	
	timer.Create("MySQL_SaveData", mysql_save_time, 0, function() MySQL_SaveData( ply ) end)
	
end

function MySQL_PlayerExists ( ply )
	steamID = ply:GetNWString("SteamID")	
	selectPlayer = "SELECT steam_id, cash, blood FROM "..mysql_database.."."..mysql_table_name.." WHERE steam_id = '"..steamID.."'"
	
	local fplayer = ply
	local mysqlQuery = db:query(selectPlayer)
	mysqlQuery:start()
	
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
	
    checkIfCreated = "SELECT steam_id FROM "..mysql_database.."."..mysql_table_name.." WHERE steam_id = '"..steamID.."'"	
	createPlayer = "INSERT INTO "..mysql_database.."."..mysql_table_name.."(steam_id, cash, blood)VALUES ('"..steamID.."', '5000', '10000')"
	
    local createCheck = db:query(checkIfCreated)	
	local playerMySQLQuery = db:query(createPlayer)
	
    local finishedQuery = createCheck:start()
	playerMySQLQuery:start()

 	--MySQL_LoadData( ply )

end

function MySQL_LoadData ( ply )
	Data = "SELECT * FROM "..mysql_database.."."..mysql_table_name.." WHERE steam_id = '"..steamID.."'"
	local mysqlQuery = db:query(Data)
	mysqlQuery:start()
	
	local fplayer = ply	
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then
	        local row = data[1]
			
	        local rowData = {} 
            rowData.SteamID = row.steam_id
            rowData.Cash = row.cash
            rowData.Blood = row.blood	
			
			fplayer:SetNWString("steam_id", rowData.SteamID)			
		    fplayer:SetNWInt("cash", rowData.Cash)
	        fplayer:SetNWInt("blood", rowData.Blood)
		
	    end
	end
	
end

function MySQL_SaveData ( ply )
	cash = ply:GetNWInt("cash")
	blood = ply:GetNWInt("blood")
	steam_id = ply:GetNWString("SteamID")
	
	cashQueryString = "UPDATE "..mysql_database.."."..mysql_table_name.." SET cash = "..cash.." WHERE steam_id = '"..steam_id.."'"
	bloodQueryString = "UPDATE "..mysql_database.."."..mysql_table_name.." SET blood = "..blood.." WHERE steam_id = '"..steam_id.."'"
	
    local cashQuery = db:query(cashQueryString)	
	local bloodQuery = db:query(bloodQueryString)
	
	cashQuery:start()
	bloodQuery:start()
	
	print("[SAVE] Steam ID: "..steam_id.." Money: $"..cash.." Blood: "..blood.."L")
end

function MySQL_CreateTables()
	mTable = "CREATE Table "..mysql_database.."."..mysql_table_name.." ( steam_id varchar(255), cash int, blood int)"
	local mysqlQuery = db:query(mTable)
	
	function mysqlQuery:onError(err)
        print('MySQL: Query Failed: '..err)
    end
	
	mysqlQuery:start()
end

function GM:PlayerDisconnected(ply)
   MySQL_SaveData( ply )
end
