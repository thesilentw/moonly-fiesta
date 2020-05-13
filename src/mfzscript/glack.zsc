/* is glack with recoils */

class Glack : MFWeapon {

	int recoil;
	int centerSpeed;
	
	property recoil: recoil;
	property centerSpeed: centerSpeed;

	default {
		Weapon.SelectionOrder 200;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 999;
		Weapon.AmmoType "Clip";
		Weapon.SlotNumber 2;
		Weapon.BobStyle "Normal";
		Weapon.BobRangeX 1.5;
		Weapon.BobRangeY 0.5;
		+WEAPON.NODEATHINPUT;
		Inventory.PickupMessage "thing what kicks";
		Glack.recoil 0;
		Glack.centerSpeed 2;
	}
	
	void degradeRecoil(Actor gun, int maximum = 40, int minimum = 0) {
		Glack(gun).recoil = clamp((Glack(gun).recoil - Glack(gun).centerSpeed), minimum, maximum);
	}
	
	void addRecoil(Actor gun, int amount, int maximum = 40, int minimum = 0) {
		Glack(gun).recoil = clamp((Glack(gun).recoil + amount), minimum, maximum);		
	}
	
	States(actor) { 
		Spawn:
			DPSP A -1;
			Stop;
	}
	
	States(weapon) {
		// in the ready state, we call these two overlays.
		Ready:
			TNT1 A 0 A_Overlay(888, "LIdle");
		ReadyMain:
			TNT1 A 1 A_WeaponReady();
			Loop;
		// left weapon states, layer 888
		LIdle:
			GLKL A 1 {
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK) {
					return ResolveState("LFire");
				}
				else {
					invoker.degradeRecoil(invoker);
					A_OverlayOffset(888, -invoker.recoil, invoker.recoil);
					return ResolveState(null);
				}
			}
			Loop;
		LFire:
			TNT1 A 0 A_Jump(256, "LFireB", "LFireC", "LFireD", "LFireE");
		LFireB:
			GLKL B 1 {
				A_FireBullets(1, 1, 1, 10);
				A_PlaySound("weapons/labpistol_fire");
				invoker.addRecoil(invoker, 7);
				A_OverlayOffset(888, -invoker.recoil*0.2, invoker.recoil*0.2);
			}
			Goto LRecoil;
		LFireC:
			GLKL C 1 {
				A_OverlayOffset(888, -invoker.recoil*0.2, invoker.recoil*0.2);
				A_FireBullets(1, 1, 1, 10);
				invoker.recoil += 9;
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LFireD:
			GLKL D 1 {
				A_OverlayOffset(888, -invoker.recoil*0.2, invoker.recoil*0.2);
				A_FireBullets(1, 1, 1, 10);
				invoker.recoil += 11;
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LFireE:
			GLKL E 1 {
				A_OverlayOffset(888, -invoker.recoil*0.2, invoker.recoil*0.2);
				A_FireBullets(1, 1, 1, 10);
				invoker.recoil += 5;
				A_PlaySound("weapons/labpistol_fire");
			}
			Goto LRecoil;
		LRecoil:
			TNT1 A 0 {
				if (GetPlayerInput(INPUT_BUTTONS) & BT_ATTACK) {
					return ResolveState("LRecoilFiring");
				}
				else {
					return ResolveState(null);
				}
			}
			GLKL F 4;
			GLKL A 2;
			Goto Ready;
		LRecoilFiring:
			GLKL F 1;
			//GLKL A 1;
			Goto LFire;
		Deselect:
			TNT1 A 1 A_Lower();
			Loop;
		Select: 
			TNT1 A 1 A_Raise();
			Loop;
		Fire: 
			TNT1 A 0;
			Goto ReadyMain;
		AltFire:
			TNT1 A 0;
			Goto ReadyMain;
	}	
}