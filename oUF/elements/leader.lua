local parent = debugstack():match[[\AddOns\(.-)\]]
local global = GetAddOnMetadata(parent, 'X-oUF')
assert(global, 'X-oUF needs to be defined in the parent add-on.')
local oUF = _G[global]

function oUF:PARTY_LEADER_CHANGED(event)
	if(UnitInParty(self.unit) and UnitIsPartyLeader(self.unit)) then
		self.Leader:Show()
	else
		self.Leader:Hide()
	end
end

table.insert(oUF.subTypes, function(self)
	local leader = self.Leader
	if(leader) then
		self:RegisterEvent"PARTY_LEADER_CHANGED"
		self:RegisterEvent"PARTY_MEMBERS_CHANGED"

		if(leader:IsObjectType"Texture" and not leader:GetTexture()) then
			leader:SetTexture[[Interface\GroupFrame\UI-Group-LeaderIcon]]
		end
	end
end)
oUF:RegisterSubTypeMapping"PARTY_LEADER_CHANGED"
