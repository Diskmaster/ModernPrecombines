# Creating Previsibine Patches by feeddanoob (ikillyou233 on nexus)
Hello all welcome to my little tutorial on creating patches for PRP. It is suggested to read [command line manual] as a reference so I do suggest you read that first.

## Prerequisites
- [F4 Creation Kit Fixes](https://www.nexusmods.com/fallout4/mods/51165) version 1.6.3 - guide was built using this version (but it can change on newer releases)
- [f4ck_loader](https://github.com/Perchik71/Fallout4Test/releases) from the F4 Creation Kit Fixes github page(the guide will be using this due because I use an enb)
- [xedit version 4.0.4](https://www.nexusmods.com/fallout4/mods/2737) x64 type will be used due to the possibility of needing the larger memory size 
- [Pra's FO4Edit Scripts](https://www.nexusmods.com/fallout4/mods/28898)
- [PRP](https://www.nexusmods.com/fallout4/mods/46403) or [PPF.esm](/PPF.esm)
- A decent size of ram (could be 16gbs to 32 gbs depending on the mod) and/or swap size
- General information on command line interfaces (I will be using Window's cmd for this guide for creating batch files)
- Patience as this will take a while

## Finding out which mods would need patching
Before I begin the guide, let's talk about what needs to be patched. Any mod that touches precombined references will most likely need to be patched. For this you can use xedit's precombine filter. [Pic1] Any mod that has it's own precombine files, found in meshes/precombined
