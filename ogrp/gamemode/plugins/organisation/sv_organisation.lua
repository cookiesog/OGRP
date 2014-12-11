--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

local Organisation = FindMetaTable("Player")

util.AddNetworkString( "CreateOrganisation" )

net.Receive( "CreateOrganisation", function( len, ply )
    
	ply:MySQL_OrganisationExistsThenCreate(ply, net.ReadString())
     
end )

function Organisation:MySQL_OrganisationExistsThenCreate ( ply, OrgName )
    orgname = OrgName
	Data = "SELECT * FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbOrganisation.." WHERE name = '"..orgname.."'"
	
	local fplayer = ply
	local mysqlQuery = ogrp.db.object:query(Data)
	
	mysqlQuery:start()
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then	
            print("Organisation exists, cannot create.")	
	    else
		    print("Debug:CreateNewOrganisation")
		    ply:MySQL_CreateNewOrganisation( fplayer, orgname )	
	    end
	end
	
end

function Organisation:MySQL_CreateNewOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
	
	insertQueryString = "INSERT INTO "..ogrp.config.dbDatabase.."."..ogrp.config.dbOrganisation.." (`steam_id`, `name`)VALUES ('"..steamID.."', '"..orgname.."')" 
	local insertQuery = ogrp.db.object:query(insertQueryString)
	
	ply:SetNWString("organisation", OrgName)
	
	insertQuery:start()		
end

function Organisation:MySQL_DeleteOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
    
	Data = "SELECT * FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbOrganisation.." WHERE steam_id = '"..steamID.."'"
	local mysqlQuery = ogrp.db.object:query(Data)
	
	mysqlQuery:start()
	
	function mysqlQuery:onSuccess(data)
	    if #data > 0 then	
			local row = data[1]		
	        local rowData = {} 
			
            rowData.SteamID = row.steam_id
			rowData.OrgName = row.name

	        queryString = "DELETE FROM "..ogrp.config.dbDatabase.."."..ogrp.config.dbOrganisation.." WHERE steam_id = '"..rowData.SteamID.."'"
			queryQuery = ogrp.db.object:query(queryString)
			
			queryQuery:start()
	    else
		    print("Could not delete organisation, player does not own or not a valid organisation.")
	    end
	end
	
end

	
	
	