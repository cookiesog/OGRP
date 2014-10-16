local startMoney = 1000
local paydays = true
local paydayAmount = 0
local paydayTime = 60

local Money = FindMetaTable("Player")

function PlayerInitialSpawnCreateMoney( ply )
	ply:MoneyCreate()
end
hook.Add("PlayerInitialSpawn", "InitialSpawn", PlayerInitialSpawnCreateMoney)

function Money:MoneyCreate()
	print("Creating a Metafile row for: " .. self:Nick() )
	if self:GetPData("cash") == nil then
		self:SetPData( "cash", startMoney )
	else
		local current = tonumber(self:GetPData( "cash" ) )
		self:MoneySet( current )
	end
end

function Money:MoneyStartAmount()
    return startMoney
end

function Money:MoneySet( moneynumber )
	self:SetPData( "cash", tonumber(moneynumber) )
	self:SetNWInt( "cash", tonumber(moneynumber) )
end

function Money:MoneyAdd( moneynumber )
	if moneynumber > 0 then
		local currentmoney = tonumber(self:GetPData( "cash" ) )
		self:MoneySet( currentmoney + moneynumber )
	end
end

function Money:MoneyTake( moneynumber )
	local currentmoney = tonumber(self:GetPData( "cash" ) )
	self:MoneySet( currentmoney - moneynumber )
end

function Money:MoneyHas( moneynumber )
	local currentmoney = tonumber(self:GetPData( "cash" ) )
	if currentmoney >= tonumber(moneynumber) then
		return true
	else
		return false
	end
end


timer.Create( "payDay_timer", 0.1, 0, function()
    for k, ply in pairs(player.GetAll()) do
        ply:MoneyAdd(0)
    end
end )

	
	
	
	
	
	