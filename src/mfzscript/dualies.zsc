/* dualeeeez 
A weapon that uses independent akimbo. Everything you see here was only done by looking at
Xaser's original synthfire script, and the ZDoom wiki.

Wants the following frames (but you can change this)
DPSP A  - pickup sprite
DPRH ABCDE - A is fire, B is idle, C / D are recoiling, E is empty (currently not handled)
DPLH ABCDE - same as above but for the right hand

Note that in the mod I made this for, I used TEXTURES to mirror the left-hand sprites
and used them for the right hand, but you can do whatever you want.
*/

class Dualies : DoomWeapon {

	default {
		Weapon.SelectionOrder 200;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 999;
		Weapon.AmmoType "Clip";
		Weapon.SlotNumber 4;
		Weapon.BobStyle "Normal";
		Weapon.BobRangeX 1.5;
		Weapon.BobRangeY 0.5;
		+WEAPON.NODEATHINPUT;
		Inventory.PickupMessage "yo dawg i herd u like akimboz";
	}

	// Normally you don't need to separate out the spawn state like this, but you can.
	// You can define the same state differently for different types of existence of the actor -
	// so when it's dropped by a monster, maybe, it's a box, but when it's spawned it's a gun.
	States(actor) { 
		Spawn:
			DPSP A -1;
			Stop;
	}
	// these states below are only valid for when this actor is instantianted as a weapon
	States(weapon) {
		// in the ready state, we call these two overlays.
		// Overlays are essentially additional states that can be layered on top of existing ones.
		// If you're familliar with how A_GunFlash works in DECORATE,
		// think of overlays as a more general implementation of that.
		// Overlays are numbered - think of it like a layer name / number in photoshop
		Ready:
			TNT1 A 0 A_Overlay(888, "LIdle");
			TNT1 A 0 A_Overlay(889, "RIdle");
		ReadyMain:
			TNT1 A 1 A_WeaponReady();
			Loop;
		// Each side needs to have its own set of states defined, so we can display 2 guns at once,
		// have them animate independently, and respond to input independently.
		// Because Overlay states run at the same time as other states, you can grab input
		// using the overlays, and seemingly invoke multiple commands simultaneously.
		// LIdle and RIdle run concurrently, so they can BOTH poll for input at the same time,
		// and that's how you get independent akimbo firing.
		////
		// left weapon states, layer 888
		LIdle:
			GLKL A 1 {
				// if the player is pressing the attack button...
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK) {
					// go to the fire state
					return ResolveState("LFire");
				}
				else {
					// otherwise just do nothing.
					// NOTE - DO NOT USE "null", THAT WILL DESTROY THE WEAPON ACTOR.
					return ResolveState(null);
				}
			}
			Loop;	
		// ok, we are shooting
		LFire:
			TNT1 A 0 A_Jump(256, "LFireB", "LFireC", "LFireD", "LFireE");
		LFireB:
			GLKL B 3 {
				// shot boolet
				A_FireBullets(1, 1, 1, 10);
				// bang
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LFireC:
			GLKL C 3 {
				// shot boolet
				A_FireBullets(1, 1, 1, 10);
				// bang
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LFireD:
			GLKL D 3 {
				// shot boolet
				A_FireBullets(1, 1, 1, 10);
				// bang
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LFireE:
			GLKL E 3 {
				// shot boolet
				A_FireBullets(1, 1, 1, 10);
				// bang
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LRecoil:
			// do recoil frames
			GLKL F 4;
			GLKL A 2;
			// see if we're still shooting 
			// (you can probably more elegantly replace this with A_ReFire())
			TNT1 A 0 {
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK) {
					// in case you haven't figured it out yet,
					// ResolveState() is the equivalent of a state jump in DECORATE
					return ResolveState("LFire");
				}
				else {
					return ResolveState(null);
				}
			}
			Goto Ready;

		// right weapon states, layer 889
		RIdle:
			GLKR A 1 {
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ALTATTACK) {
					return ResolveState("RFire");
				}
				else {
					return ResolveState(null);
				}
			}
			Loop;		
		RFire:
			TNT1 A 0 A_Jump(256, "RFireB", "RFireC", "RFireD", "RFireE");
		RFireB:
			GLKR B 3 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto RRecoil;
		RFireC:
			GLKR C 3 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto RRecoil;
		RFireD:
			GLKR D 3 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto RRecoil;
		RFireE:
			GLKR E 3 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto RRecoil;
		RRecoil:
			GLKR F 4;
			GLKR A 2;
			TNT1 A 0 {
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ALTATTACK) {
					return ResolveState("RFire");
				}
				else {
					return ResolveState(null);
				}
			}
			Goto Ready;	
			
		// other states
		Deselect:
			TNT1 A 1 A_Lower();
			Loop;
		Select: 
			TNT1 A 1 A_Raise();
			Loop;
		// we subvert the existing fire states to point us back to our special
		// global ready state that invokes the overlays
		Fire: 
			TNT1 A 0;
			Goto ReadyMain;
		AltFire:
			TNT1 A 0;
			Goto ReadyMain;
	}	
}