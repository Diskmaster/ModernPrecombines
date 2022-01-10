# Creating PRP patches by feeddanoob (ikillyou233 on nexus)
Hello all welcome to my little tutorial on creating patches for PRP. It is suggested to read [command line manual](/Manual.md) as a reference first.

## Prerequisites
- [F4 Creation Kit Fixes](https://www.nexusmods.com/fallout4/mods/51165) version 1.6.3[^1]
- [f4ck_loader](https://github.com/Perchik71/Fallout4Test/releases) [^2]
- [xedit](https://www.nexusmods.com/fallout4/mods/2737) x64 type will be used due to the possibility of needing the larger memory size 
- [Pra's FO4Edit Scripts](https://www.nexusmods.com/fallout4/mods/28898)
- [PRP](https://www.nexusmods.com/fallout4/mods/46403) and/or [PPF.esm](/PPF.esm)[^3]
- A decent size of ram (could be 16gbs to 32 gbs depending on the mod) and/or swap size
- General information on command line interfaces (I will be using Window's command prompt for this guide to create batch files)
- Patience as this will take a while

## Terminalogy
- Previsibines - Precombines and Previs steps combined
- CELL(s) - Normally refers to Interior (Cell) and Exterior (Worldspace) records, in XEdit this would be in the Record Header/Signature
- Cell(s) - Refers to just the Interior portion, in xedit this would have its own category on the left side
- So CELL vs Cell: All Caps on cell is refering to both Worldspace and Cell, One Cap is refering to the interior cell (the thing you see in xedit on the left side when checking for plugins

## Finding out which mods would need patching
Before I begin the guide, let's talk about what needs to be patched: 
- Any mod that touches precombined references will most likely need to be patched. To find these records you can use xedit's precombine filter. [Pic1](/Patch-Tutorial-Pics/Xedit_filter_for_checking_precombine.png)
- Any mod that has it's own precombine files, found in Meshes/Precombined, or it's own Visibility files, found in the Vis folder, might need a patch with PRP. If the files are conflicting then it is possible the mod needs a patch or to at least to have it's precombined files regenerated with the Apply Material Swap.pas script if the mod in question didn't do that.

## Preparation of the esp patch
Once you have figured out which mods would need PRP patches, let us get down to business. You should open xedit with just one of the mods in question and PRP (I do not believe load order would be relevant here). Deep copy as override the Cell and Worldspace records of the plugin in question to a new esp file, name it to something that makes sense. Apply the "Apply Material Swap" script to the newly generated plugin and wait for it to finish. Once it is done, add every plugin as a master[^4]. Apply a filter to show only navmesh entries on your plugin only [Pic2](/Patch-Tutorial-Pics/Xedit_filter_for_navmesh.png). Remove every navmesh entry and only the navmesh entries (keep the Cell and Worldspace records)[^5]. Now check your plugin again, if there are no subrecords in the CELLs you would need to create an intentional ITM perferably in the temporary references subrecords[^6].

[^1]: Guide was built using this version, but you can probably use the latest version.
[^2]: Guide will be using this because I use an enb
[^3]: For now I suggest using PRP 0.53. Once PRP gets updated to 0.55, PPF.esm should be shipped with the PRP.esp file
[^4]: That is all the DLC + UF4P + PRP + the plugin in question's masters. There is a problem when the CK adds the masters of other plugins to your new plugin and that causes errors when generating the precombine data.
[^5]: We will be saving the esp in the creation kit (as opposed to using the copy version control script in xedit) and sometimes the CK adjusts the navmesh entries to some unknown parameters, so for simiplicity sake we skip everything related to navmeshes.
[^6]: The Precombined Timestamps (PCMB in xedit) and the Combined References (XCRI in xedit) will not update if the cell has no subrecords. 
  There is an exception to this however, if there is a mod that creates its own worldspace (let's say Xander's Aid for example) then there will be records with just navmeshes in them, and in that case you just keep the record (they might still be used for the previs step later on).
