local Money = FindMetaTable("Player")

function Money:MoneySet( moneynumber )
	self:SetNWInt( "cash", tonumber(moneynumber) )
end

function Money:MoneyAdd( moneynumber )
	if moneynumber > 0 then
		local currentmoney = tonumber(self:GetNWInt( "cash" ) )
		if(currentmoney == nil) then 
		    currentmoney = 0
		end
		self:MoneySet( currentmoney + moneynumber )
	end
end

function Money:MoneyTake( moneynumber )
	local currentmoney = tonumber(self:GetNWInt( "cash" ) )
	self:MoneySet( currentmoney - moneynumber )
end

function Money:MoneyHas( moneynumber )
	local currentmoney = tonumber(self:GetNWInt( "cash" ) )
	if currentmoney >= tonumber(moneynumber) then
		return true
	else
		return false
	end
end


timer.Create( "payDay_timer", 5, 0, function()
    for k, ply in pairs(player.GetAll()) do
        ply:MoneyAdd(5)
    end
end )

	
	
	
	
	
	