Current PPF Version: 0.54.17

Current known issues:
- \[PRP\] Vault114 Third floor railing occlusion is broken \(haven't figured out a good way to fix, tried all the usual methods\)
- \[U31719\] \[-8, 0\] Commonwealth - 16002F and 16002A missing side of SCOL mesh \(sidewalk\), partially obscured, a work in progress as I need to figure out a better static choice that doesn't look awful

Current fixed issues: \(UF4OP bug numbers shown as Uxxxxx\)
- \[PRP\] DLC04BottlingPlant01: Clear out about 45 or so invalid XRFG \(Reference Group\) entries that the CK did automatically in previous builds, otherwise leaves the area unchanged.
- \[U23865\] DLC03VimPopFactory01: 03017695 \(BldWlpSmWall01\) and 0301FB6F \(MetalShelf01_Broken01\) got moved and the room extended to clear up the door clobbering the shelf.
- \[U?????, PRP\] LaytonTowers01: 15D9B8 from UF4OP, 15D934, 15D9E1, 15D9E2 had slight adjustments, the reason why escapes me. Needs verifying.
- \[PRP\] DLC01Lair01: A pair of DefaultLightCoolFLSpotNS entries had their XRFG cleared.
- \[U25794, PRP\] DLC03Vault118: 0303B4DA and 030490BC got Z-flipped by 180 degrees to correct their likely intended way to use a camera, all other records were more invalid XFRG clearing.
- \[PRP?\] DLC01FortHagenSatelliteArray01: 01001BD0, 010046C5, 010046C6, 010047B8, 010047B9, 010088B6, 0100F997 got shifted around to look proper in that room. All large crates.
- \[U21471\] FensStreetSewer01: Shifted position of B3BDB to remove the obvious hole that was showing up in certain angles.
- \[PRP\] DLC04NukaWorldPowerPlant01: 0602CF9B Moved countertop to not z-fight the neighboring countertop.
- \[U30536\] BostonPublicLibrary02: 174346 Corrected the position of a bookcase.
- \[PRP\] Vault114: 5C955, AB399, and AB3E9 got shifted to correct previs holes. Submitted by krrptd.
- \[U28872\] DmndSecurity01: 11A477 Corrected missing texture swap to match roof.
- \[U?????\] GoodneighborBobbisPlace: 10A7DB and 1F4253 Toilet and File folder got moved due to unknown reasons, ask UF4OP.
- \[U?????\] zVitalePumphouse01: 21A404, 21E06A, 21E06B, 21E06C, 21E06D More UF4OP records.
- \[U23801\] MedfordMemorial01: 45432 and 45436 countertops got shifted.
- \[U23460\] MedfordMemorial01: 7DC87 and 20B852 had placement corrected.
- \[U?????, PRP\] Vault75: 07038FB1 was resulting in a void hole on previs generation. Z adjustment needs verified.
- \[U23634\] GwinnettBrewery02: AD910 and AD911 moved to correctly stick to a wall.
- \[PRP\] UniversityPoint01: 87A62 the chair got moved to not be floating awkwardly.
- \[U?????\] CambridgeCollegeAdminBuilding: 21548A was moved by UF4OP
- \[U23302, PRP\] CorvegaAssemblyPlant01: D3DC1 got moved to prevent z-fighting, 208218, 208219 and 208DF3 were shifted to prevent awkward clobbering as a result.
- \[U23635\] IrishPrideShipyard01: 1362BD, 1362BE, 1362BF, 1362C6 positioning fixed to be on walls as intended. Spongebob, me boy.
- \[PRP\] GeneralAtomicsFactory01: 99AD3, 99AED, A5421, 2134AB, 2134BC, 213511, 213512, 213513, 213514, 213515, 213516, 213518, 213519, 21351A Various barrel and crate moves to stop object clobbering.
- \[U23636\] MedTekResearch01: 7AC6D Shifted the position of a floor tile.
- \[U24441\] USAFSatellite01: 24894F Moved a desk out of the way.
... 6F5DE is next to look at