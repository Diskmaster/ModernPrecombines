A small preface before I begin, I've never been that good at documenting in a clear and consice manner, so bear with me as I make some explanation here. This living manual is not going to be very pretty at this stage as my current goal is to explain the methods used as best I can to those that don't know that much on how to use the Creation Kit, like me. Also, if you are coming here from a certain pirate themed discord's guide channel, treat this manual as the commandline extension to the precombine guide written out inside and anything in here would superceed it over what Shadow wrote.

To start, what are precombines exactly? Well, depending on who you ask, trouble, a pain in the butt, a collection of smashed together meshes in the game, and quite possibly a menace to the modding community in some respects.

So, to start out, there's a few things that need to happen to get your game to be able to deal with this effectively. At the bare minimum, you need the following:

A copy of the Creation Kit, version 1.10.162 as of this manual's current commit. You can obtain this through the Bethseda launcher along with Archive2 and associated tools for mod development. This manual assumes you have them installed and working correctly.
The latest XEdit / FO4Edit release, version 4.0.4 as of this commit.
A copy of Pra's xedit scripts. Install them to Edit Scripts/ in your Fallout 4 installation so FO4Edit can find them. This also applies to Searge's script pack or any other scripts that have a .pas extension.
A decent amount of hard drive space, and more importantly, physical ram, depending on the size of the project and how it's created. The Previs Repair Pack, my mod, took up to 48GB system commit (that's used ram for those not in the know) at full previs generation of the game and all DLC, UF4OP included.
There's a set of optional scripts floating around that makes this easier to work with and I'll point out the options as they are relevant, this includes the previously mentioned pack above.
Also, I personally use CK Fixes 1.6, but it is somewhat optional. Some don't like it and it's got bugs in odd places, but it does the job for me. [note: post preferred configuration]

Alright, before you begin, the Creation Kit by default has a known bug where it incorrectly generates Havok information in the wrong bit range for the game. 32-bit, specifically, and we want 64-bit. To fix this, you have two options:

One would be hex editing the executable in a pair of places, the source of which I think is Searge [note: need to verify this]. The relevant places to edit with an appropriate hex editor are 0x34726D, change B9 01 00 00 00 to B9 00 00 00 00. Then repeat the same sequence at 0xDCAA76 and you are golden. [note: Expand this to a full hexedit tutorial]

The alternative would be to obtain a recently released set of xedit scripts by Searge in this topic [note: link to nexus forums for source]. Unpack CKPatcher.exe and run it in your Fallout 4 directory. If it was successful, you should see a 588MB sized patched CreationKit.patched.exe. Don't be too alarmed by the size. This patch greatly expands the record count and plugins the creation kit can handle, and does include the above hexedit. I'm personally using this in tandem with CKFixes 1.6 and it appears to work fine. Your mileage may vary.

