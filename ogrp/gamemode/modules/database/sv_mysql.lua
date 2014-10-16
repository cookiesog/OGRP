-- [[ MySQL Saving ]] --

function Initialize()
	MySQL_TableExists()
end

function PlayerInitialSpawn( ply )

	timer.Create("Delay", 1, 1, function()
		SteamID = ply:SteamID()
		ply:SetNWString("SteamID", SteamID)
		timer.Create("MySQL_SaveData", 10, 0, function() MySQL_SaveData( ply ) end)
		MySQL_PlayerExists( ply ) 
		print("hi")
	end)

end

function MySQL_TableExists()
    if(sql.TableExists("player_data")) then
	    print("player_data already exists, no need for creation")		
	else
	    if(!sql.TableExists("player_data")) then
		    CreateTable = "CREATE Table player_data ( steam_id varchar(255), cash int)"
			sqlQuery = sql.Query(CreateTable)
			if(sql.TableExists("player_data")) then
			
			else
		        print("Could not create table player_data")
				print( sql.LastError(sqlQuery))
			end
		end		
	end
end

function MySQL_PlayerExists ( ply )
	steamID = ply:GetNWString("SteamID")
	
	sqlQuery = sql.Query("SELECT steam_id, cash FROM plyer_data WHERE steam_id = '"..steamID.."'")
	if(sqlQuery) then
        print(sqlQuery)
		MySQL_LoadData( ply )
	else
		MySQL_CreateNewPlayer( steamID, ply )
	end
end
 
function MySQL_CreateNewPlayer( SteamID, ply )
 	steamID = SteamID
	sql.Query( "INSERT INTO player_data (`steam_id`, `cash`)VALUES ('"..steamID.."', '5000')" )
	sqlQuery = sql.Query( "SELECT steam_id, cash FROM player_data WHERE steam_id = '"..steamID.."'" )

	if (sqlQuery) then
	    print(sqlQuery)
 		MySQL_LoadData( ply )
	else
		print("Could not create a new player, id is: "..steamID)
	end
end

function MySQL_LoadData ( ply )
	steam_id = sql.QueryValue("SELECT steam_id FROM player_data WHERE steam_id = '"..steamID.."'")
	cash = sql.QueryValue("SELECT cash FROM player_data WHERE steam_id = '"..steamID.."'")
	ply:SetNWString("unique_id", steam_id)
	ply:SetNWInt("cash", cash)
end

function MySQL_SaveData ( ply )
	cash = ply:GetNWInt("cash")
	steam_id = ply:GetNWString ("SteamID")
	sql.Query("UPDATE player_data SET cash = "..cash.." WHERE steam_id = '"..steam_id.."'")
end

function GM:PlayerDisconnected(ply)
    MySQL_SaveData( ply )
end

hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn", PlayerInitialSpawn )
hook.Add("Initialize", "Initialize", Initialize )