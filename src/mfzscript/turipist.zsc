class turrican_pist : MFWeapon {
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "TEST TURRICAN PISTOL";
	}
	
	States {
		Ready:
			PISG A 1 A_WeaponReady();
			Loop;
		Deselect:
			PISG A 1 A_Lower();
			Loop;
		Select:
			PISG A 1 A_Raise();
			Loop;
		Fire:
			TNT1 A 0 {
				if (countInv("Clip") < 30)
					return ResolveState("FireOne");
				else if (countInv("Clip") < 60)
					return ResolveState("FireThree");
				else
					return ResolveState("FireSix");
			}
		FireOne:
			PISG A 1;
			PISF A 3 { 
				A_FireProjectile("turibal", useammo: 1);
				A_PlaySound("weapons/chngun", CHAN_WEAPON);
			}
			PISG B 2;
			PISG B 2;
			PISG C 2;
			PISG A 1 A_ReFire();
			Goto Ready;
		FireThree:
			PISG A 1;
			PISF A 3 { 
				A_FireProjectile("turibal", angle: -2, useammo: 0);
				A_FireProjectile("turibal", angle: 2, useammo: 0);
				A_FireProjectile("turibal", useammo: 1);
				A_PlaySound("weapons/chngun", CHAN_WEAPON);
			}
			PISG B 2;
			PISG B 2;
			PISG C 2;
			PISG A 1 A_ReFire();
			Goto Ready;
		FireSix:
			PISG A 1;
			PISF A 3 { 
				A_FireProjectile("turibal", angle: -1, useammo: 0);
				A_FireProjectile("turibal", angle: 1, useammo: 0);
				A_FireProjectile("turibal", angle: -3, useammo: 0);
				A_FireProjectile("turibal", angle: 3, useammo: 0);
				A_FireProjectile("turibal", angle: -5, useammo: 0);
				A_FireProjectile("turibal", angle: 5, useammo: 1);
				A_PlaySound("weapons/chngun", CHAN_WEAPON);
			}
			PISG B 2;
			PISG B 2;
			PISG C 2;
			PISG A 1 A_ReFire();
			Goto Ready;
		Spawn:
			PIST A -1;
			Stop;
	}
}	

Class turibal : Actor {
	default {
		damage 15;
		missileheight 4;
		speed 80;
		height 4;
		radius 4;
		Scale 0.5;
		alpha 0.95;
		Projectile;
		decal "BulletChip";
	}
	
	states {
	Spawn:
		BAL1 AB 2 BRIGHT;
		Loop;
	Death:
		BAL1 CDE 3 BRIGHT;
		Stop;
	}

}