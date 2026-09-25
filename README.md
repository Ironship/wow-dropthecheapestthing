# DropTheCheapestThing (Ironship branch)

This is [kemayo's DropTheCheapestThing](https://github.com/kemayo/wow-dropthecheapestthing) with two changes that are still waiting in upstream pull requests:

- **Appearance threshold** ([#37](https://github.com/kemayo/wow-dropthecheapestthing/pull/37)): when unknown appearances are protected, a quality floor lets greys and whites count as junk again.
- **Ignore-list modifier** ([#38](https://github.com/kemayo/wow-dropthecheapestthing/pull/38)): the right-click that adds the cheapest item to the ignore list can use Alt or Shift instead of Control.

Everything else follows upstream master, and this branch will be dropped once both are merged. The libraries (Ace3, LibDBIcon) are pulled in by the packager, so a plain download of this repository also needs them installed as standalone addons.
