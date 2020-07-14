// --------------------------------------------------------------------------
// Rocket launcher
//
// The rebalanced Rocket Launcher fires slightly slower, but the rockets
// are much faster, and explode more quickly.
//
// --------------------------------------------------------------------------

class RBLRocketLauncher : MFWeapon replaces RocketLauncher {

	Default {
		Weapon.slotNumber 5;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 2;
		Weapon.AmmoType "RocketAmmo";
		+WEAPON.NOAUTOFIRE
		Inventory.PickupMessage "$GOTLAUNCHER";
		Tag "$TAG_ROCKETLAUNCHER";
	}
	
	States {
		Ready:
			MISG B 1 A_WeaponReady();
			Loop;
		Deselect:
			MISG B 1 A_Lower();
			Loop;
		Select:
			MISG B 1 A_Raise();
			Loop;
		Fire:
			MISG B 4 {
				A_WeaponOffset(0, 10, WOF_ADD);
				A_GunFlash();
				A_FireProjectile("RBLRocket", 0, 1, spawnheight: -10);
				A_AlertMonsters();
			}
			MISG B 7;
			MISG B 14 A_WeaponOffset(0, -10, WOF_ADD);
			TNT1 A 0 A_ReFire();
			Goto Ready;
		Flash:
			MISF A 3 Bright A_Light1;
			MISF B 4 Bright;
			MISF CD 4 Bright A_Light2;
			Goto LightDone;
		Spawn:
			LAUN A -1;
			Stop;
	}
}

class RBLRocket : FastProjectile {
	
	Default {
		Radius 11;
		Height 8;
		Speed 80;
		Damage 20;
		Projectile;
		//+RANDOMIZE
		+ROCKETTRAIL
		+ZDOOMTRANS
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
		Obituary "$OB_MPROCKET";
	}
	
	States {
		Spawn:
			MISL A 1 Bright;
			Loop;
		Death:
			MISL B 3 Bright A_Explode;
			MISL C 3 Bright;
			MISL D 3 Bright;
			Stop;
	}
}