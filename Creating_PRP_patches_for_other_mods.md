# Creating PRP patches by feeddanoob
Hello, welcome to my little tutorial on creating patches for PRP (or at least the way I did it). It is suggested to read [command line manual](/MANUAL.md) as a reference first. This guide heavily relies on the CK fixes and I will be using the clean method only.

## Prerequisites
- The Creation Kit for Fallout 4 installed where the game is located at
- [F4 Creation Kit Fixes](https://www.nexusmods.com/fallout4/mods/51165) version 1.6.3[^1]
- [f4ck_loader](https://github.com/Perchik71/Fallout4Test/releases) [^2]
- [xedit](https://www.nexusmods.com/fallout4/mods/2737) x64 type will be used due to the possibility of needing the larger memory size 
- [Pra's FO4Edit Scripts](https://www.nexusmods.com/fallout4/mods/28898)
- [PRP](https://www.nexusmods.com/fallout4/mods/46403) and/or [PPF.esm](/PPF.esm)[^3]
- A decent size of ram (could be 16gbs to 32gbs depending on the mod) and/or swap size/page file
- General information on command line interfaces (I will be using Window's command prompt for this guide to create batch files)
- Patience as this will take a while

## Terminology
- Previsibines - Precombines and Previs steps combined
- CELL(s) - Normally refers to Interior (Cell) and Exterior (Worldspace) records, in xEdit this would be in the Record Header/Signature
- Cell(s) - Refers to just the Interior portion, in xedit this would have its own category on the left side
- So, CELL vs Cell: All Caps on cell is refering to both Worldspace and Cell, One Cap is referring to the interior cell (the thing you see in xedit on the left side when checking for plugins

## Finding out which mods would need patching
Before I begin the guide, let's talk about what needs to be patched: 
- Any mod that touches precombined references will most likely need to be patched. To find these records you can use xedit's precombine filter. [Pic1](/Patch-Tutorial-Pics/Xedit_filter_for_checking_precombine.png)
- Any mod that has its own precombine files, found in Meshes/Precombined, or its own Visibility files, found in the Vis folder, might need a patch with PRP. If the files are conflicting, then it is possible the mod needs a patch or to at least to have its precombined files regenerated with the Apply Material Swap.pas script if the mod in question didn't do that.

## Preparation of the esp patch
Once you have figured out which mods would need PRP patches, let us get down to business. You should open xedit with just one of the mods in question and PRP (I do not believe load order would be relevant here). Deep copy as override the Cell and Worldspace records of the plugin in question to a new esp file, that is a plain esp file (no esl/esm flags set), you can name the new plugin with spaces since this guide is using the CKfixes, as mentioned in the [Manual](/MANUAL.md), but I still prefer to name the file without spaces. Apply the "Apply Material Swap" script to the newly generated plugin and wait for it to finish. Once it is done, add every plugin as a master[^4]. Apply a filter to show only navmesh entries on your plugin only [Pic2](/Patch-Tutorial-Pics/Xedit_filter_for_navmesh.png). Remove every navmesh entry and only the navmesh entries (keep the Cell and Worldspace records)[^5]. Now check your plugin again, if there are no subrecords in the CELLs you would need to create an intentional ITM preferably in the temporary references subrecords[^6][^7]. Now it is time to save the plugin in the creation kit to update the Version Control Info (there is the Copy version script in xedit but I like to save the esp in the CK). Once the plugin is saved in the creation kit, open the plugin in xedit and check for errors[^8][^9]. If your PRP patch is free of errors, I recommend backing up your PRP patch file. Now it is time to do the precombine generation.

## Batch File Creation
Gotcha, before we do the precombine step, I recommend creating batch files or powershell scripts for doing these steps. If you wish you could skip this step, but I swear batch files will make your life easier especially when working with multiple patches in question or if the creationkit crashes for whatever reason (more info on that below). For your convenience, I created 4 [batch files](/Generic-Batch-Files) for each step that will happen for the Creation Kit (I will be using f4ck_loader.exe as the executable instead of Creationkit.exe because I use an enb but you are free to switch it to whichever executable you want from the [Manual](/MANUAL.md)). Place these files in the Fallout 4 root folder (where the exe is) and replace the brackets in the batch file to what your PRP patch's name is with the extension.

## Precombine Generation - Step 1 Part A
Now you are at the Precombine generation step, for this you can choose to follow the [Manual](/MANUAL.md) or use the batch files. There is two options for doing this step, copying all the mods (including the ba2 files, if the files are loose I recommend packing them in a ba2 before hand) required for your patch to the data folder in Fallout 4 folder or using Mod Organizer 2. I recommend using the first option because this is the way I have created my patches and ensures minimal conflict but you do need more space in the drive. Vortex is NOT supported for this guide, but, you can try the first option with it.
### Option 1
As previously mentioned, this option requires you to copy your esps and ba2s to the Fallout 4 data folder. Once you have done that, you can open the first batch file,  type this in the command prompt: `f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`, or type this in powershell `.\f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`, the Creation Kit will open and begin generating the precombines and close when it is finished giving you the meshes/precombined folder, a .psg file, and a CombinedObjects.esp file.
### Option 2
For using MO2, I would recommend creating a new profile (you can copy your current one), and name it something like Previsibine Generation (it could be anything). Deselect everything on the left side in that new profile, and enable your patch's requirements. Next is to go into MO2s [Explore Virtual Folder](/Patch-Tutorial-Pics/ModOrganizer2_Explore.png) and go to Fallout's root folder [using this icon](/Patch-Tutorial-Pics/Explore_Toolbar_Up.png). Then either find the batch files you have created or modified and open them or use the [command prompt button](/Patch-Tutorial-Pics/Explore_Toolbar_Command_Prompt.png) and type `f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`. The Creation Kit should open, there may be a delay but check your task manager to see if the CK is running, and the precombine generation should start and finish with the Creation Kit closing, giving you the meshes/precombined folder, a .psg file, and a CombinedObjects.esp file. It is important to not close the Explorer++ process until the creation Kit is finished.
### Possible Errors when generating Precombines
The CK may crash with an exception 0xc0000005 and this can happen using both options above. The only solution so far is to exclude the cells from precombine generation by removing them in the PRP patch. So far I have only experienced this when trying to generate precombines for Fusion City Rising, Hookes of the Commonwealth, and Outcast and Remnants and have listed the Cell records [here](/Bad-Cells). If you are creating a patch, and notice the CK crashing during precombine generation, please submit a pull request or issue with the problematic cell records that way other people can be aware when they are generating precombines.

If you get a psg file that is 0kb in size my only guess is you typed something wrong in the terminal.
## Precombine Generation - Step 2 Part B 

[^1]:Guide was built using this version, but you can probably use the latest version.
[^2]:Guide will be using this because I use an enb
[^3]:For now I suggest using PRP 0.53. Once PRP gets updated to 0.55, PPF.esm should be shipped with the PRP.esp file
[^4]:That is all the DLC + UF4P + PRP + the plugin in question's masters. There is a problem when the CK adds the masters of other plugins to your new plugin and that causes errors when generating the precombine data.
[^5]:We will be saving the esp in the creation kit (as opposed to using the copy version control script in xedit) and sometimes the CK adjusts the navmesh entries to some unknown parameters, so for simplicity sake we skip everything related to navmeshes.
[^6]:The Precombined Timestamps (PCMB in xedit) and the Combined References (XCRI in xedit) will not update if the cell has no subrecords.
[^7]:There is an exception to this however, if there is a mod that creates its own worldspace (let's say Xander's Aid for example [Pic3](/Patch-Tutorial-Pics/Xedit_example_of_not_creating_an_ITM.png)) then there will be records with just navmeshes in them, and in that case you just keep the record (they might still be used for the previs step later on).
[^8]: If XPRI errors are present, you probably didn't add the plugins above as master to your PRP patch plugin as mentioned earlier. You should remove all of the Cell and Worldspace entries in xedit and start over again with the preparation step, making sure that all the plugins are listed as master files. If the XPRI errors are still present, create an issue to me (feeddanoob) or contact me in the Collective Modding Discord (also feeddanoob) and I will try to see what the problem is.
[^9]: Please note: Some of the parent mods have XPRI errors in them too, example is Nuka World [Pic4](/Patch-Tutorial-Pics/Example_of_Nuka_World_having_XPRI_errors.png)
