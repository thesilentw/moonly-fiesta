// --------------------------------------------------------------------------
// Shotgun
//
// The rebalanced shotgun trades in the duckbill barrel for a more normal spread. 
//
// --------------------------------------------------------------------------

class RBLShotgun : MFWeapon replaces Shotgun {
	
	Default {
		Weapon.Kickback 100;
		weapon.slotNumber 3;
		Weapon.SelectionOrder 1300;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 16;
		Weapon.AmmoType "Shell";
		Inventory.PickupMessage "$GOTSHOTGUN";
		Obituary "$OB_MPSHOTGUN";
		Tag "$TAG_SHOTGUN";
	}
	
	States {
		Ready:
			SHTG A 1 A_WeaponReady;
			Loop;
		Deselect:
			SHTG A 1 A_Lower;
			Loop;
		Select:
			SHTG A 1 A_Raise;
			Loop;
		Fire:
			//SHTG A 3;
			SHTG A 7 {
				A_PlaySound ("weapons/shotgf", CHAN_WEAPON);
				A_FireBullets(3, 1.5, 7, 5);
				A_AlertMonsters();
			}
			SHTG BC 5;
			SHTG D 4;
			SHTG CB 5;
			SHTG A 6;
			SHTG A 10 A_ReFire;
			Goto Ready;
		Flash:
			SHTF A 4 Bright A_Light1;
			SHTF B 3 Bright A_Light2;
			Goto LightDone;
		Spawn:
			SHOT A -1;
			Stop;
	}
}