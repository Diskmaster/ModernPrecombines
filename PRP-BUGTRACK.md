Current PPF Version: 0.54.17

Current known issues:
- [PRP] Vault114 Third floor railing occlusion is broken (haven't figured out a good way to fix, tried all the usual methods)
- [U31719] [-8, 0] Commonwealth - 16002F and 16002A missing side of SCOL mesh (sidewalk), partially obscured, a work in progress as I need to figure out a better static choice that doesn't look awful

Current fixed issues: (UF4OP bug numbers shown as Uxxxxx)
- [PRP] DLC04BottlingPlant01: Clear out about 45 or so invalid XRFG (Reference Group) entries that the CK did automatically in previous builds, otherwise leaves the area unchanged.
- [U23865] DLC03VimPopFactory01: 03017695 (BldWlpSmWall01) and 0301FB6F (MetalShelf01_Broken01) got moved and the room extended to clear up the door clobbering the shelf.
- [U?????, PRP] LaytonTowers01: 15D9B8 from UF4OP, 15D934, 15D9E1, 15D9E2 had slight adjustments, the reason why escapes me. Needs verifying.
- [PRP] DLC01Lair01: A pair of DefaultLightCoolFLSpotNS entries had their XRFG cleared.
- [U25794, PRP] DLC03Vault118: 0303B4DA and 030490BC got Z-flipped by 180 degrees to correct their likely intended way to use a camera, all other records were more invalid XFRG clearing.
- [PRP?] DLC01FortHagenSatelliteArray01: 01001BD0, 010046C5, 010046C6, 010047B8, 010047B9, 010088B6, 0100F997 got shifted around to look proper in that room. All large crates.
- [U21471] FensStreetSewer01: Shifted position of B3BDB to remove the obvious hole that was showing up in certain angles.
- [PRP] DLC04NukaWorldPowerPlant01: 0602CF9B Moved countertop to not z-fight the neighboring countertop.
...