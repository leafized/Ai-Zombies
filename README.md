# Ai Zombies | Click View on Github and Download as Zip! Make sure to read this!
THANK YOU FOR DOWNLOADING AI ZOMBIES VERSION 0.16.3b
http://youtube.com/leafized


``Supported Maps: Highrise, Underpass, Rust, Terminal, Sub Base``
`https://github.com/leafized/Ai-Zombies/releases/ for the latest release download!` 

** MAKE SURE TO DELETE YOUR OLD FILE BEFORE UPDATING. THIS WILL CAUSE FUNCTION ISSUES**

0.2.5b LIVE CHANGE 

[user interface]
- Cash will now have a twinkle effect when you get more or less points.
- Ammo will provide a faster update speed
- Changed the objective text to red

[ai settings]
- Changes to ai health, and point system

[store]
- Reworked some pricing to make it easier to afford, but harder to get in later rounds
- Reworked weapon pap system to provide a proper power boost.

[maps]
- Subbase added at the same location as your original favorite ai zombies mode! (AIZ Extreme)

- Changes to rust and terminal (zm spawns)




== OLD  UPDATES! ==


0.2.0b LIVE CHANGE - Graphical Interface
[User interface]
- New weapon UI
   * This is a graphical overhaul, providing a cleaner ui for weapons and points! 
- New Points UI 
   * A new hud was designed for displaying your current money!
   * removed the ability to see other players money, as this information simply wasn't needed.
- Round Progression Hud
   * A round counter will now appear to the right of your screen.  



0.16.3b LIVE CHANGE - Graphical Interface
[User interface]
- New weapon UI
   * Weapon ui will now display your primary and secondary weapon, with its ammo placed accordingly. 

[store]
- Adjusted pricing math for pack a punc

[Drops] 
- Internal drop overhaul is coming. Will be favoring a tactical flare instead of a waypoint 

[Zombie Movement] 
- Changes to how the zombies detect players, this helps with map compatibility 
- Changed to movement progression. 



0.15.0b LIVE CHANGE- IMPORTANT
[store]
- Adjusted pricing slightly for pack-a-punch
- Adjusted huds for eye-candy.

[zombies]
- Fixed a bug causing the game to crash in early rounds.
(this bug made the game unplayable for the time being.

[Maps]
- Underpass temporarily does not have a perk. This will be added in the next update
# KNOWN BUGS :: CURRENTLY IN GAME #
- Zombies may stack, i will be working around this.
- Console should be fixed, but if you notice something, tell me.
- When you die, your player may respawn and get attacked until the nuke drops.
- When there is multiple players, player will respawn at the end of each intermission. Not really game breaking, but worth mentioning.


0.14.0b LIVE CHANGE
[STORE]
- Pack-A-Punch Added! (Terminal Only (until next update))

[AI]
- Multiple Models now, will make the gameplay more unique.

0.13.0b LIVE CHANGE
[Drops]
- Fixed a small bug.

[Player]
- Added functions to prepare for Revive System.

[AI] 
- Changes to AI speed, will now feel more natural.
- Changes will be made to models. They will have more than one model.
- Changes to the way an AI decides to move.

[MAP]
- Added Terminal as a map. BETA

0.12.2b LIVE CHANGE
[Drops]
- Fixed a bug allowing a drop to activate regardless of if a user picks it up. This is due to the game automatically returning true if the variable is no longer defined.
- Fixed a bug relating to UI.

[Player]
- Tweaks to player 

[AI Zombies]
- Changes to the way speed is handled. 
- Changes to the animation played when an AI targets the user (Round Based System)
- Preparation for "Crouched" AI, which will spawn similarly to how dogs work in Zombies.

[General] Updated developer_settings.gsc
- Allowed for more customization
- Setup for user to be able to add their own Custom map, which will override the original map.



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
