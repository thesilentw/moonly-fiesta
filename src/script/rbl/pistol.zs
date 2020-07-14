// --------------------------------------------------------------------------
// Pistol 
//
// The rebalanced pistol is very similar - pinpoint precision, low damage.
// Cyclic rate has been slightly increased.
//
// --------------------------------------------------------------------------

class RBLPistol : MFWeapon replaces Pistol {
	
	Default {
		Weapon.Kickback 100;
		weapon.slotNumber 2;
		Weapon.SelectionOrder 1900;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 20;
		Weapon.AmmoType "Clip";
		Obituary "$OB_MPPISTOL";
		+WEAPON.WIMPY_WEAPON
		Inventory.Pickupmessage "$PICKUP_PISTOL_DROPPED";
		Tag "$TAG_PISTOL";
	}
	
	States {
		Ready:
			PISG A 1 A_WeaponReady;
			Loop;
		Deselect:
			PISG A 1 A_Lower;
			Loop;
		Select:
			PISG A 1 A_Raise;
			Loop;
		Fire:
			PISG A 3;
			PISG B 3 {
				A_PlaySound ("weapons/pistol", CHAN_WEAPON);
				A_AlertMonsters();
				A_FireBullets(0.5, 0.5, 1, 5);
				A_GunFlash();
			}
			PISG C 2 A_WeaponOffset(0, 2, WOF_ADD);
			PISG B 4 A_WeaponOffset(0, -2, WOF_ADD);
			TNT1 A 0 A_ReFire();
			Goto Ready;
		Flash:
			PISF A 3 Bright A_Light1;
			Goto LightDone;
		Spawn:
			PIST A -1;
			Stop;
	}
}