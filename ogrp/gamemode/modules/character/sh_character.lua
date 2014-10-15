local Character = FindMetaTable("Player")

function PlayerInitialSpawnCreateChar( ply )
	ply:CharCreate()
end
hook.Add("PlayerInitialSpawn", "InitialSpawn", PlayerInitialSpawnCreateChar)

function Character:CharCreate()
	if self:GetPData("char") == nil then
		self:SetPData( "char", 0 )
	else
		local current = tonumber(self:GetPData( "char" ) )
		self:CharSet( current )
	end
end

function Character:CharSet( charnumber )
	self:SetPData( "char", tonumber(charnumber) )
	self:SetNWInt( "char", tonumber(charnumber) )
end

function Character:CharAdd( charnumber )
	if charnumber > 0 then
		local currentChar = tonumber(self:GetPData( "char" ) )
		self:CharSet( currentChar + charnumber )
	end
end

function Character:CharTake( charnumberr )
	local currentChar = tonumber(self:GetPData( "char" ) )
	self:CharSet( currentChar - charnumber )
end

function Character:CharHas( charnumber )
	local currentChar = tonumber(self:GetPData( "char" ) )
	if currentChar >= tonumber(charnumber) then
		return true
	else
		return false
	end
end
