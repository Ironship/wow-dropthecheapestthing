# DropTheCheapestThing (Ironship fork)

A fork of [DropTheCheapestThing](https://github.com/kemayo/wow-dropthecheapestthing) by kemayo, the addon that finds and drops or sells the cheapest junk in your bags.

What this fork changes (the first two are open upstream pull requests; the fork goes away once they are merged):

- Appearance quality floor ([#37](https://github.com/kemayo/wow-dropthecheapestthing/pull/37)): with unknown appearances protected, greys and whites can still count as junk.
- Ignore-list click modifier ([#38](https://github.com/kemayo/wow-dropthecheapestthing/pull/38)): the right-click that ignores the cheapest item can use Alt or Shift instead of Control.
- Low-level consumables on every client: the consumable class id falls back to `Enum.ItemClass.Consumable` where the `LE_ITEM_CLASS_CONSUMABLE` global is missing (World of Warcraft: Forever), and "Levels below yours" replaces the hardcoded ten-level gap. `/dtctwhy` says why an item is or is not junk.

Install: unzip the release zip from [Releases](https://github.com/Ironship/wow-dropthecheapestthing/releases) into `Interface/AddOns`; it already contains the libraries.

Licence: BSD, as the original.
