--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

OGRP = OGRP or GM

function OGRP:Initialize()
	MySQL_TableExists()
end

function MySQL_TableExists()
    if(!sql.TableExists("organisation_data")) then
		    CreateTable = "CREATE Table organisation_data ( owner_id varchar(255), name string)"
			sqlQuery = sql.Query(CreateTable)
		if(!sql.TableExists("organisation_data")) then
			print( sql.LastError(sqlQuery))
		end	
	end
end

function MySQL_OrganisationExistsThenCreate ( ply, OrgName )
    orgname = OrgName
	
	sqlQuery = sql.Query( "SELECT owner_id, name FROM organisation_data WHERE name = '"..orgname.."'" )
	if(!sqlQuery) then
		MySQL_CreateNewOrganisation( ply, orgname )
	else
	    print("An organisation named ".. orgname .. " was trying to be created but failed because that name is already taken.")
	end
end

function MySQL_CreateNewOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
	
	sql.Query( "INSERT INTO organisation_data (`owner_id`, `name`)VALUES ('"..steamID.."', '"..orgname.."')" )
end

function MySQL_DeleteOrganisation( ply, OrgName )
    orgname = OrgName
 	steamID = ply:SteamID()
    
    orgToBeDeleted = sql.QueryValue("SELECT name FROM organisation_data WHERE owner_id = '"..steamID.."'")
	
	if(orgToBeDeleted) then
	
	sql.Query( "DELETE FROM organisation_data WHERE owner_id = '"..steamID.."'")
	
	else
	    print("You must own an organisation to delete one.")
	end
end

	
	
	
	