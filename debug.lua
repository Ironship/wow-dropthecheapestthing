local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon(myname)

local GetContainerNumSlots = _G.GetContainerNumSlots or C_Container.GetContainerNumSlots
local GetContainerItemLink = _G.GetContainerItemLink or C_Container.GetContainerItemLink

local function say(text)
	if not DEFAULT_CHAT_FRAME then
		return
	end
	for line in tostring(text):gmatch("[^\n]+") do
		DEFAULT_CHAT_FRAME:AddMessage("|cff59aefaDropTheCheapestThing:|r " .. line)
	end
end

SLASH_DTCTWHY1 = "/dtctwhy"
SlashCmdList = SlashCmdList or {}
SlashCmdList["DTCTWHY"] = function()
	local db = core.db
	say("profile: " .. tostring(db and db:GetCurrentProfile()))
	if db then
		say(("low: food=%s potion=%s bandage=%s scroll=%s levels=%s"):format(
			tostring(db.profile.low.food), tostring(db.profile.low.potion),
			tostring(db.profile.low.bandage), tostring(db.profile.low.scroll),
			tostring(db.profile.low.levels)))
		say(("thresholds: drop=%s sell=%s valueless=%s soulbound=%s"):format(
			tostring(db.profile.threshold), tostring(db.profile.sell_threshold),
			tostring(db.profile.valueless), tostring(db.profile.soulbound)))
	end
	say(("consumable class: global=%s Enum=%s used=%s"):format(
		tostring(_G.LE_ITEM_CLASS_CONSUMABLE),
		tostring(Enum and Enum.ItemClass and Enum.ItemClass.Consumable),
		tostring(ns.LE_ITEM_CLASS_CONSUMABLE)))
	say("player level: " .. tostring(UnitLevel("player")))
	local shown = 0
	for bag = 0, (NUM_BAG_SLOTS or 4) do
		for slot = 1, (GetContainerNumSlots and GetContainerNumSlots(bag) or 0) do
			local link = GetContainerItemLink and GetContainerItemLink(bag, slot)
			if link then
				local class = select(12, C_Item.GetItemInfo(link))
				if class == ns.LE_ITEM_CLASS_CONSUMABLE then
					say(core:ExplainSlot(bag, slot))
					shown = shown + 1
				end
			end
		end
	end
	if shown == 0 then
		say("no consumables in bags (or their info is not loaded yet)")
	end
end
