--[[
	© 2014 Overload-Gaming.com do not share, re-distribute or modify
	without permission of its author - Cookies@overload-gaming.com.
--]]

ogrp.db = ogrp.db or {}

function ogrp.db.Connect()
	if (ogrp.db.object) then
		return
	end

	ogrp.db.object = mysqloo.connect(ogrp.config.dbHost, ogrp.config.dbUser, ogrp.config.dbPassword, ogrp.config.dbDatabase, ogrp.config.dbPort)
	ogrp.db.object.onConnected = function()
		print("ogrp has connected to the database via mysqloo.")
		
		if(ogrp.config.dbCreateTables) then 
	        local mysqlQuery = ogrp.db.object:query("CREATE Table "..ogrp.config.dbDatabase.."."..ogrp.config.dbOrganisation.." ( steam_id varchar(255), name varchar(255))")
            local mysqlQuery2 = ogrp.db.object:query("CREATE Table "..ogrp.config.dbDatabase.."."..ogrp.config.dbPlayer.." ( steam_id varchar(255), cash int, blood int, organisation text)")	
	
	        mysqlQuery:start()
			mysqlQuery2:start()
	    end
	end
	ogrp.db.object.onConnectionFailed = function(_, fault)
		print("ogrp could not connect to the database!")
		print(fault)
	end
	
	ogrp.db.object:connect()
end

ogrp.db.Connect()