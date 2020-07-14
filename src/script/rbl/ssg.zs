// --------------------------------------------------------------------------
// Super Shotgun
//
// The rebalanced Super Shotgun has a tighter spread, as well as a slightly 
// altered reload sequence.
//
// --------------------------------------------------------------------------

class RBLSuperShotgun : MFWeapon replaces SuperShotgun {

	Default {
		Weapon.slotNumber 3;
		Weapon.SelectionOrder 400;
		Weapon.AmmoUse 2;
		Weapon.AmmoGive 8;
		Weapon.AmmoType "Shell";
		Inventory.PickupMessage "$GOTSHOTGUN2";
		Obituary "$OB_MPSSHOTGUN";
		Tag "$TAG_SUPERSHOTGUN";
	}
	
	States {
		Ready:
			SHT2 A 1 A_WeaponReady;
			Loop;
		Deselect:
			SHT2 A 1 A_Lower;
			Loop;
		Select:
			SHT2 A 1 A_Raise;
			Loop;
		Fire:
			SHT2 A 3;
			SHT2 A 1 {
				A_GunFlash();
				A_PlaySound ("weapons/sshotf", CHAN_WEAPON);
				A_FireBullets (6.5, 3.1, 20, 5, "BulletPuff");
				A_AlertMonsters();
			}
			SHT2 A 6 A_WeaponOffset(0, 7, WOF_ADD);
			SHT2 B 5 A_WeaponOffset(0, -7, WOF_ADD);
			SHT2 C 5; 
			TNT1 A 0 A_CheckReload();
			SHT2 D 5;
			TNT1 A 0 A_PlaySound("weapons/sshoto", CHAN_WEAPON);
			SHT2 E 5;
			TNT1 A 0 A_PlaySound("weapons/sshotl", CHAN_WEAPON);
			SHT2 F 7;
			SHT2 G 4;
			SHT2 H 4;
			TNT1 A 0 A_PlaySound("weapons/sshotc", CHAN_WEAPON);
			SHT2 A 7;
			TNT1 A 0 A_ReFire();
			Goto Ready;
		Flash:
			SHT2 I 4 Bright A_Light1();
			SHT2 J 3 Bright A_Light2();
			Goto LightDone;
		Spawn:
			SGN2 A -1;
			Stop;
	}
}
