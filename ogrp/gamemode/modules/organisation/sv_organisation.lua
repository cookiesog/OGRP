--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

OGRP = OGRP or GM
local Organisation = FindMetaTable("Player")

local mysql_hostname = '127.0.0.1'
local mysql_username = 'root'
local mysql_password = 'root'
local mysql_database = 'ogrp' 
local mysql_table_name = 'organisation_data'
local mysql_port = 3306 
local mysql_save_time = 30 
local mysql_create_tables = false

local db = mysqloo.connect(mysql_hostname, mysql_username, mysql_password, mysql_database, mysql_port)

db:connect()

function db:onConnected()
    print('Organisation MySQL: Connected!')

	MySQL_CreateTables()		
end

function db:onConnectionFailed(err)
    print('Organisation MySQL: Connection Failed, please check your settings: ' .. err)
end

function MySQL_CreateTables()	

	if(mysql_create_tables == true) then
	    mTable = "CREATE Table "..mysql_database.."."..mysql_table_name.." ( steam_id varchar(255), name varchar(255))"
	    local mysqlQuery = db:query(mTable)
	
	    function mysqlQuery:onError(err)
            print('MySQL: Query Failed: '..err)
        end
	
	    mysqlQuery:start()
	end
	
end

function Organisation:MySQL_OrganisationExistsThenCreate ( ply, OrgName )
    orgname = OrgName
	Data = "SELECT * FROM "..mysql_database.."."..mysql_table_name.." WHERE name = '"..orgname.."'"
	
	local fplayer = ply
	local mysqlQuery = db:query(Data)
	
	mysqlQuery:start()
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then	
            print("Organisation exists, cannot create.")	
	    else
		    print("Debug:CreateNewOrganisation")
		    MySQL_CreateNewOrganisation( fplayer, orgname )	
	    end
	end
	
end

function Organisation:MySQL_CreateNewOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
	
	insertQueryString = "INSERT INTO "..mysql_database.."."..mysql_table_name.." (`steam_id`, `name`)VALUES ('"..steamID.."', '"..orgname.."')" 
	local insertQuery = db:query(insertQueryString)
	
	insertQuery:start()		
end

function Organisation:MySQL_DeleteOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
    
	Data = "SELECT * FROM "..mysql_database.."."..mysql_table_name.." WHERE steam_id = '"..steamID.."'"
	local mysqlQuery = db:query(Data)
	
	mysqlQuery:start()
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then	
			local row = data[1]		
	        local rowData = {} 
			
            rowData.SteamID = row.steam_id
			rowData.OrgName = row.name

	        queryString = "DELETE FROM "..mysql_database.."."..mysql_table_name.." WHERE steam_id = '"..rowData.SteamID.."'"
			queryQuery = db:query(queryString)
			
			queryQuery:start()
	    else
		    print("Could not delete organisation, player does not own or not a valid organisation.")
	    end
	end
	
end

	
	
	