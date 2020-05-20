# Ai Zombies
THANK YOU FOR DOWNLOADING AI ZOMBIES VERSION 0.10.1b
http://youtube.com/leafized
Supported Maps: Underpass, Rust

When you download a new version, please delete all old files. This can cause issues of functions being defined when they're not supposed to. I have removed many folders which causes duplicate files.

THIS IS A PUBLIC RELEASE.

TO RECORDERS: PLEASE KEEP IN MIND THAT THIS IS IN BETA 

TO DEVELOPERS: FEEL FREE TO CONTRIBUTE TO A FUNCTION, AND TELL ME ABOUT IT.

NOTE: IT IS BEST TO PLAY SOLO AT THE MOMENT, BUT, MULTIPLE PLAYERS IS OKAY.


THANK YOU FOR READING, ENJOY YOUR GAMEPLAY

Changelog**
0.11.0b LIVE CHANGE

[Drops]
- Fixed a bug related to huds.
- Removed the carepackage model.
	*INSTEAD, you will see a waypoint icon.
- Removed Firesale temporarily ( Still present in code base, you can add it back if you'd like )
- Fixed a bug allowing more than one drop to spawn. This prevents overlapped drops.

[Player]
- Fixed player monitoring (for stores)

[Store]
- Mystery Box fully animated.
- Store monitoring fix. (Previously, there was a bug allowing money to be taken later thn the purchase)


0.10.2b LIVE CHANGE

NOTE: A bug is found relating to the player. I suggest waiting until i push the fix ( In the works now )

[Drops]
- Reworked how drops are done. This will allow easier implementation of more drops.
- Added InstaKill

[Store]
- All store items can now have cusotm angles, these were pre defined before.
- All stores will now give a message if you cannot afford to pay.
- Mysterybox has a new animation.

[AI Changes]
- AI recieved a small change to kills.
- AI changes to prepare for waypoint mapping.
- AI changes to prevent some clipping.

[General Changes]
- Files have been moved, to clean up the source.
- Files have been named according to their location (Eyecandy i guess)

0.10.1b LIVE CHANGE

[Xbox Changes]
	- Xbox Support Fixes.
[General Changes]
	- Added custom setLower function, this allows further customization to the hud.
	- Reworked hud for points, this will be continued. (Work not yet finished)
	- Added a check for the box being used.
	- Added checks to perks, You will not be sold an item if you alredy have it.
[Drops]
	- Changes to drop ratio, and changes to how the drops work
	- Fixed a bug causing a loop in drops (Rarely happened)
	- Fixed some aspects
	- Added a new mechanic, drops will be redone so that they work similarly to how it's done in other AIZ games
[Zombies]
	- Removed a check for if the player is visible to the zombie, this is temporary and will be added back.
	- Removed a bug that allowed zombies to damage you after death.
	- Fixed some clipping
	- Fixed an issue causing client to lag out due to too many entities.
	- Fixed health progression (Still being tweaked.)
	- Fixed spawn progressoin (Still being tweaked.)
[Player]
	- Player will now spawn at a specified location
	- Player will now see other players name and money.
	- Players will no longer be able to interact with a store item at the same time as another user.
		* instead, if the store item cannot be used more than one at a time, it will display that it's in use, and who is using it.
	- Players will have a task system for each map, they must either Die, or Complete the task to end the game. (Not implemented, but layed out.
	

0.8b
[Xbox Changes]
	- Possible fix for mystery box issues
[General Changes]
	- Changes to mysterybox monitor, this will allow users to see if the box is in use.
	- Changes in mysterybox, will now take out money at time of purchase.
	- Changes to mysterybox, will now display the current user for the box. (if in use)
	- Changes to Zombies Spawning, will now spawn appropriately.
[Drops]
	- Drop ratio has been decreased to fit a resonable drop ratio of 1/20. This makes drops less frequent.
	
[Zombies]
	- Changes to health progression
	
[TODO]Zombie Animations when unable to detect players, walking zombies, running zombies, Special Round (Deciding how to implement)


0.7b
[]Xbox bugs are showing up
  - Movement and Angles fixed
[]General Improvements to round progression
[]Decrease in drop probability
[]Decrease in spawn per round

0.6b
[]Xbox bugs 
   -found with ai movement
   - bug found with angles
   - Waypoint bug with boxes, they are disappearing.
[]General bugs
   -Respawned players will no repeat spawn each round after zombie elminiation.
