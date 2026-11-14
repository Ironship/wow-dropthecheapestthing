local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("DropTheCheapestThing")

_G.DropTheCheapestThing.API = {}

-- `sell_only` means a sale must never turn into a deletion: an item that can't
-- be sold right now is skipped instead of being dropped. Selling is the only
-- thing that may run without a hardware event (auto-sell fires when the
-- merchant opens), and DeleteCursorItem() is blocked there.
local function drop(slots, count, sell_if_available, sell_only)
	if count == 0 then return 0, 0, false end
	local num, total = 0, 0
	local failed = false
	for _, bagslot in ipairs(slots) do
		-- if we've asked to sell if we can, and we're at a merchant, and the item is sellable:
		local sellable = sell_if_available and core.at_merchant and select(3, core.item_value_bagslot(bagslot, true))
		if sellable or not sell_only then
			local value = core.drop_bagslot(bagslot, sellable, not sellable)
			if not value then
				-- The drop/sell failed validation, so we can't continue from here
				failed = true
				break
			end
			num = num + 1
			total = total + value
			if num >= count then
				break
			end
		else
			core.Debug("Not selling, no vendor price", bagslot)
		end
	end
	return num, total, failed
end

-- Drops an item
--
-- You can only drop a single item per hardware-event, so this doesn't have a `count` argument
--
-- `sell_if_available` is a boolean saying whether to sell the item instead if you're at a merchant
-- Returns number of things dropped, total value of items dropped, and a boolean saying whether the attempt failed
DropTheCheapestThing.API.Drop = function(sell_if_available)
	return drop(core.drop_slots, 1, sell_if_available)
end

-- Drops an item
-- You can only drop a single item per hardware-event
--
-- `count` is the number of items to drop; if true will try to sell all items
-- `cautious` is a boolean saying whether to cap the number of items to sell at the number of items you can buyback
-- Returns number of things sold, total value of items sold, and a boolean saying whether the attempt failed
DropTheCheapestThing.API.Sell = function(count, cautious)
	-- Selling only works at a merchant:
	if not core.at_merchant then return 0, 0, true end
	count = count or 1
	if count == true then count = #core.sell_slots end
	if cautious then count = math.min(count, BUYBACK_ITEMS_PER_PAGE) end
	return drop(core.sell_slots, count, true, true)
end

DropTheCheapestThing.API.CanSell = function()
	return core.at_merchant
end
