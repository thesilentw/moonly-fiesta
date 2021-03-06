class Labpistol : MFWeapon {
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "%o realized 'puny' is relative when you're talking about supersonic projectiles, thanks to %k.";
		Inventory.Pickupmessage "Snatched up a Securitek H950!";
	}
	States {
		Ready:
			TPIS A 1 A_WeaponReady();
			Loop;
		Deselect:
			TPIS A 1 A_Lower();
			Loop;
		Select:
			TPIS A 1 A_Raise();
			Loop;
		Fire:
			TPIS A 1;
			TPIF A 3 { 
				A_FireBullets(2,2,-1,20,"BulletPuff",FBF_USEAMMO | FBF_NORANDOM);
				//A_Light(5);
				A_PlaySound("weapons/labpistol_fire",CHAN_WEAPON);
			}
			TPIS B 2 Offset(6,40);
			TPIS B 2 Offset(4,42);
			TPIS C 2 Offset(0,32);
			TPIS A 1 A_ReFire();
			Goto Ready;
		Spawn:
			TPIP A -1;
			Stop;
	}
}