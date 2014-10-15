local savingModule = FindMetaTable("Player")
local maxCharacters = 10
drakz = drakz or GM

-- Database global specific strings.
util.AddNetworkString("database")

-- Inventory Networked Strings
util.AddNetworkString("inventory_drop")
util.AddNetworkString("inventory_use")
util.AddNetworkString("KEY_E")

function savingModule:CreateSteamID()
	    local id = self:SteamID()
	    local id = tostring(id)
	    local id = string.Replace(id, "STEAM_0:0:", "")
	    local id = string.Replace(id, "STEAM_0:1:", "")
	    
	    return id
end

function savingModule:CreateCharacterID()
	local currentChar = tonumber(self:GetPData( "char" ) )
     if currentChar == currentChar then
    	self:CharAdd(1)
    	return tostring(self:GetPData("char"))
    end
end

local printing = print

local function print(s)
    printing("sv_database.lua: " .. s)
end

function savingModule:DatabaseNetworkedData()
	local backpack = {}
	local playerdata = {}

	backpack["soda1"] = { amount = 10 }
	backpack["soda2"] = { amount = 10 }
	backpack["pistol"] = { amount = 1 }

	playerdata["thirst"] = { data = self:ThirstStartAmount() }
	playerdata["blood"] = { data = self:BloodStartAmount() }
	playerdata["hunger"] = { data = self:HungerStartAmount() }
	playerdata["money"] = { data = self:MoneyStartAmount() }

	self:DatabaseSetValue( "inventory", backpack )
	self:DatabaseSetValue( "playerdata", playerdata )
end

function savingModule:DatabaseSaveFolder()
	local charID = self:CreateCharacterID()
    return "drakz/players/"..self:CreateSteamID().."/characters/"..charID.."/"
end

function savingModule:DatabasePath()
    return self:DatabaseSaveFolder().."savefile.txt"
end

function savingModule:DatabaseSet( tab )
	self.database = tab
end

function savingModule:DatabaseGet()
	return self.database
end

function savingModule:DatabaseSetup()
	self.database = {}
	if self:DatabaseExists() then
        self:DatabaseRead()
	else
		self:DatabaseCreate()
	end
    self:DatabaseSend()
    self:DatabaseNetworkedData()
end

function savingModule:DatabaseSend()
    net.Start("database")
        net.WriteTable(self:DatabaseGet())
    net.Send(self)
end

function savingModule:DatabaseExists()
	local f = file.Exists(self:DatabasePath(), "DATA")
	return f
end

function savingModule:DatabaseRead()
	local dataString = file.Read(self:DatabasePath(), "DATA")
	self:DatabaseSet(util.KeyValuesToTable(dataString))
end

function savingModule:DatabaseSave()
	local dataString = util.TableToKeyValues(self.database)
	local f = file.Write(self:DatabasePath(), dataString)
	self:DatabaseSend()
end

function savingModule:DatabaseCreate()
	local b = file.CreateDir(self:DatabaseSaveFolder())
	self:DatabaseSave()
end

function savingModule:DatabaseDisconnect()
	self:DatabaseSave()
end

-- OLD.
function savingModule:DatabaseSetValue( name, v )
	if not v then return end
	
	if type(v) == "table" then
		if name == "inventory" then
			for k,backpack in pairs(v) do
				if backpack.amount <= 0 then
					v[k] = nil
				end
			end
		end
	end
	
	if type(v) == "table" then
		if name == "playerdata" then
			for k,playerdata in pairs(v) do
				if playerdata.data <= 0 then
					v[k] = 0
				end
			end
		end
	end

	local d = self:DatabaseGet()
	d[name] = v
	
	self:DatabaseSave()
end

function savingModule:DatabaseGetValue(name)
	local d = self:DatabaseGet()
	return d[name]
end

function savingModule:GetData()
	return self:DatabaseGetValue("playerdata")
end

-- self:DataSet("hunger", 0)
function savingModule:DataSet( name, v )
	if not v then return end

	if type(v) == "table" then
		if name == "playerdata" then
			for k,playerdata in pairs(v) do
				if playerdata.data <= 0 then
					v[k] = 0
				end
			end
		end
	end

	local d = self:DatabaseGet()
	d[name] = v
	
	self:DatabaseSave()
end

--self:GetCurrentData("Hunger")
function savingModule:GetCurrentData(name, data)
	local i = self:GetData()

	if i then
		if i[name] then
			return i[name].data
		end
	end
end
-- self:DataAdd("hunger", 50)
function savingModule:DataAdd(name, add)
	if add == 0 then return end
    local curData = self:GetCurrentData(name)
    self:DataSet(name, add + curData)

end
