# Creating PRP patches by feeddanoob
Hello, welcome to my little tutorial on creating patches for PRP (or at least the way I did it). It is suggested to read [command line manual](/MANUAL.md) as a reference first. This guide heavily relies on the CK fixes and I will be using the clean method only.

## Prerequisites
- The Creation Kit for Fallout 4 installed where the game is located at
- [F4 Creation Kit Fixes](https://www.nexusmods.com/fallout4/mods/51165) version 1.6.3[^1]
- [f4ck_loader](https://github.com/Perchik71/Fallout4Test/releases) [^2]
- [xedit](https://www.nexusmods.com/fallout4/mods/2737) x64 type will be used due to the possibility of needing the larger memory size 
- [Pra's FO4Edit Scripts](https://www.nexusmods.com/fallout4/mods/28898)
- [PRP](https://www.nexusmods.com/fallout4/mods/46403) and/or [PPF.esm](./PPF.esm)[^3]
- [Mod Organizer 2](https://www.nexusmods.com/skyrimspecialedition/mods/6194) - optional
- [SeargeDP's set of xedit script files](https://forums.nexusmods.com/index.php?/topic/5522717-fallout-4-optimization-and-performance-systems-explained/page-52#entry100828598) - optional
- A decent size of ram (could be 16gbs to 64gbs depending on the mod that you are generating for) and/or swap size/page file
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
Gotcha, before we do the precombine step, I recommend creating batch files or powershell scripts for doing these steps. If you wish you could skip this step, but I swear batch files will make your life easier especially when working with multiple patches in question or if the creationkit crashes for whatever reason (more info on that below). For your convenience, I created 4 [batch files](/Generic-Batch-Files) for each step that will happen for the Creation Kit just replace the braketed area with your plugin's name (I will be using f4ck_loader.exe as the executable instead of Creationkit.exe because I use an enb but you are free to switch it to whichever executable you want from the [Manual](/MANUAL.md)). Place these files in the Fallout 4 root folder (where the exe is) and replace the brackets in the batch file to what your PRP patch's name is with the extension.

## Precombine Generation - Part A
Now you are at the Precombine generation step, for this you can choose to follow the [Manual](/MANUAL.md) or use the batch files. There is two options for doing this step, copying all the mods (including the ba2 files, if the files are loose I recommend packing them in a ba2 before hand) required for your patch to the data folder in Fallout 4 folder or using Mod Organizer 2. I recommend using the first option because this is the way I have created my patches and ensures minimal conflict but you do need more space in the drive. Vortex is NOT supported for this guide, but, you can try the first option with it.
### Fallout 4's Data Folder
As previously mentioned, this option requires you to copy your esps and ba2s to the Fallout 4 data folder. Once you have done that, you can open the first batch file,  type this in the command prompt: `f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`, or type this in powershell `.\f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`, the Creation Kit will open and begin generating the precombines and close when it is finished giving you the meshes/precombined folder, a .psg file, and a CombinedObjects.esp file.
### Mod Organizer
For using MO2, I would recommend creating a new profile (you can copy your current one), and name it something like Previsibine Generation (it could be anything). Deselect everything on the left side in that new profile, and enable your patch's requirements. Next is to go into MO2s [Explore Virtual Folder](/Patch-Tutorial-Pics/ModOrganizer2_Explore.png) and go to Fallout's root folder [using this icon](/Patch-Tutorial-Pics/Explore_Toolbar_Up.png). Then either find the batch files you have created or modified and open them or use the [command prompt button](/Patch-Tutorial-Pics/Explore_Toolbar_Command_Prompt.png) and type `f4ck_loader.exe -GeneratePrecombined:pluginname.esp clean all`. The Creation Kit should open, there may be a delay but check your task manager to see if the CK is running, and the precombine generation should start and finish with the Creation Kit closing, giving you the meshes/precombined folder, a .psg file, and a CombinedObjects.esp file possibly in the overwrite folder. It is important to not close the Explorer++ process until the creation Kit is finished.
### Possible Errors when generating Precombines
The CK may crash with an exception 0xc0000005, sadly this can happen when using either options above. The only solution so far is to exclude the cells from precombine generation by removing them in the PRP patch. So far I have only experienced this when trying to generate precombines for Fusion City Rising, Hookes of the Commonwealth, and Outcast and Remnants and have listed the Cell records [here](/Bad-Cells). If you are creating a patch, and notice the CK crashing during precombine generation, please submit a pull request or issue with the problematic cell records that way other people can be aware when they are generating precombines.

If you get a psg file that is 0kb in size my only guess is you typed something wrong in the terminal.

## Precombine Generation - Part B
Once you get the CombinedObjects.esp you should error check that in xedit. If any errors appear (exclude [^9] type errors) then something went wrong and this usually happens in the [Preparation of the esp patch](#preparation-of-the-esp-patch) step. The next step is to either use Searge's `03_MergeCombinedObjects.pas` script or to save the plugin in the Creation Kit.
### Using Searge's Combined Objects Script
This is the faster of the two options. Put the script in your xedit's `Edit Scripts` folder and run the script on the PRP patch plugin.
### Saving the CombinedObjects plugin in the CK
This is the slower method of the two options. Open the Creation Kit and set the `CombinedObjects.esp` as master. Once the CK finishes referencing everything, just save the plugin. Then open xedit and use the `Merge overrides into master.pas` script on the `CombinedObjects.esp` plugin and have it merge into the PRP patch plugin.

The CombinedObjects plugin can be safely deleted since we are now done with it.

## Precombine Generation - Part C
Now that we have generated the meshes for the precombined objects and the shared geometry file, .psg file, it's time to do two things, pack the meshes folder and compress the shared geometry file. There is a limit to how many precombined files you can have as loose files when generating previs, Star/Ben/Disk says 8,192 precombined meshes, another [source](https://forums.nexusmods.com/index.php?/topic/5522717-fallout-4-optimization-and-performance-systems-explained/page-47#entry76223088) says anything around 32,000 precombined meshes. So I suggest just pack the meshes into a ba2 before continuing on using these [settings](/Patch-Tutorial-Pics/Archive_2_precombine_packing.png)[^10] using Archive2. To pack in archive2 is simply dragging the meshes folder from generation to the program. If there are many files in the meshes folder the archive2 program will freeze but it will not crash as it is processing all those files. I have not used Pra's `Collect Assets.pas` so I have little information on what to do, you can follow the [Manual](/MANUAL.md) for that. I also do not trust CAO for Fallout 4 (Skyrim on the other hand I give my full trust on). Now that you packed your meshes into an archive, you can safely delete the loose files. It's time to compress the shared geometry file. So there is two ways of doing this, either run the second batch file or type these in either command prompt `f4ck_loader.exe -CompressPSG:pluginname.esp` (use this for MO2's virtual explorer) or in powershell `.\f4ck_loader.exe -CompressPSG:pluginname.esp`. This process generates quickly and after it is done you should see a .csg file. Like in the Manual, you can delete the .psg file once you have the .csg file.

## Previs Generation - Part A
Now comes the previs setup but first we need to populate the cell index by creating a .cdx file. So you can run the third batch file or type `f4ck_loader.exe -BuildCDX:pluginname.esp` in command prompt (also used in MO2 again) or `.\f4ck_loader.exe -BuildCDX:pluginname.esp` in Powershell. Once you have your .CDX file we can generate the Previs data.
### Information about Previs generation
This is the part where you need a lot of ram, pagefile/swap, and patience (can take between 30mins to hours). If you are on 16gbs of ram or lower, I suggest moving the texture archives to another location temporarly, like the Manual suggests. If you are above 16gbs of ram, I doubt you would need to move the texture ba2s, but if the previs generation crashes it might be because you ran out of memory. All my patches, TFTC, Fourville, Xander's Aid, etc, were ran using 16gbs of memory. The only time I crashed from lack of memory was generating previs data for Universal Working Bathroom Fixtures (there was a nice deal for 32gbs of ram so I took an upgrade).

If you are on MO2, I highly suggest to double check that no other mods are active on the left side (there could be loose textures or meshes from mods).

## Previs Generation - Part B
The final generation boss has arrived. As with all the other steps, you can run the final, fourth batch file, type this in command prompt (also for MO2) `f4ck_loader.exe -GeneratePreVisData:pluginname.esp clean all`, or this in powershell `.\f4ck_loader.exe -GeneratePreVisData:pluginname.esp clean all`. Once the creation kit finishes the generation, closing itself, you should see a VIS folder and a PreVis.esp plugin in either your DATA folder or your overwrite folder for MO2. You can pack the newly created VIS folder into your archive from the [Precombine generation step](#precombine-generation---part-c) using these [settings](/Patch-Tutorial-Pics/Archive_2_precombine_packing.png).
### Possible Reasons why Previs generation crashed with an error
There are a few reasons why Previs generation has failed:
- As mentioned above in the [Information section](#information-about-previs-generation), you probably ran out of memory. The only solution so far is increasing your ram size ($), increasing your pagefile/swap size (I might cover this, but there are plenty of tutorials online on how to do this), or moving the texture ba2s somewhere else.
- There is a mesh the CK really dislikes. You have to troubleshoot this by reading the creation kit crash logs, guessing which location the CK crashes, and pinpointing the reference that is causing the crash. The issue(s) that I know of where a mesh is causing the CK to crash are located [here](/Bad-Refs).
- Generated Precombine meshes were not packed into a ba2 archive. Solution - pack the files into an archive and then delete the loose files.
- Missing meshes. Use the `Assets manager.pas` script, making sure it is selected to `Check fo missing assests`, to the plugin you are trying to patch or to your plugin then press OK. As for a solution, I do not know of any other than asking for the missing meshes.

## Previs Generation - Part C


[^1]:Guide was built using this version, but you can probably use the latest version.
[^2]:Guide will be using this because I use an enb
[^3]:For now I suggest using PRP 0.53 since it is labeled stable. Once PRP gets updated to 0.55, PPF.esm should be shipped with the PRP.esp file
[^4]:That is all the DLC + UF4P + PRP + the plugin in question's masters. There is a problem when the CK adds the masters of other plugins to your new plugin and that causes errors when generating the precombine data.
[^5]:We will be saving the esp in the creation kit (as opposed to using the copy version control script in xedit) and sometimes the CK adjusts the navmesh entries to some unknown parameters, so for simplicity sake we skip everything related to navmeshes.
[^6]:The Precombined Timestamps (PCMB in xedit) and the Combined References (XCRI in xedit) will not update if the cell has no subrecords.
[^7]:There is an exception to this however, if there is a mod that creates its own worldspace (let's say Xander's Aid for example [Pic3](/Patch-Tutorial-Pics/Xedit_example_of_not_creating_an_ITM.png)) then there will be records with just navmeshes in them, and in that case you just keep the record (they might still be used for the previs step later on).
[^8]: If XPRI errors are present, you probably didn't add the plugins above as master to your PRP patch plugin as mentioned earlier. You should remove all of the Cell and Worldspace entries in xedit and start over again with the preparation step, making sure that all the plugins are listed as master files. If the XPRI errors are still present, create an issue to me (feeddanoob) or contact me in the Collective Modding Discord (also feeddanoob) and I will try to see what the problem is.
[^9]: Please note: Some of the parent mods have XPRI errors in them too, example is Nuka World [Pic4](/Patch-Tutorial-Pics/Example_of_Nuka_World_having_XPRI_errors.png) so you can ignore those.
[^10]: Note: The Maximum Archive Size could be anything your hardware can handle, I am only using the default value that it pops up with. The main setting to be focussed on is the Compression Setting to none. Please note if you do decide to pack into smaller archives that you will have to do additional work for the game to use those smaller archives (I suggest/recommend packing them all in one archive if you can) 
