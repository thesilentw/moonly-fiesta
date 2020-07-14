// --------------------------------------------------------------------------
//
// BFG 9000
//
// The rebalanced BFG gets some more rays, and no longer depends on the
// player's position to calculate who gets damaged.
//
// --------------------------------------------------------------------------

class RBLBFG : MFWeapon replaces BFG9000 {
	
	Default {
		Weapon.SlotNumber 7;
		Height 20;
		Weapon.SelectionOrder 2800;
		Weapon.AmmoUse 40;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Cell";
		+WEAPON.NOAUTOFIRE;
		Inventory.PickupMessage "$GOTBFG9000";
		Tag "$TAG_BFG9000";
	}
	
	States {
		Ready:
			BFGG A 1 A_WeaponReady;
			Loop;
		Deselect:
			BFGG A 1 A_Lower;
			Loop;
		Select:
			BFGG A 1 A_Raise;
			Loop;
		Fire:
			BFGG A 20 A_PlaySound("weapons/bfgf", CHAN_WEAPON); 
			BFGG B 10 A_GunFlash;
			BFGG B 10 {
				A_FireProjectile("RBLBFGBall", 0, 1);
				A_AlertMonsters();
			}
			BFGG B 20 A_ReFire;
			Goto Ready;
		Flash:
			BFGF A 11 Bright A_Light1;
			BFGF B 6 Bright A_Light2;
			Goto LightDone;
		Spawn:
			BFUG A -1;
			Stop;
	}
}
	
class RBLBFGBall : Actor {

	Default {
		Radius 13;
		Height 8;
		Speed 25;
		Damage 100;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 0.75;
		DeathSound "weapons/bfgx";
		Obituary "$OB_MPBFG_BOOM";
	}
	
	States {
		Spawn:
			BFS1 AB 4 Bright;
			Loop;
		Death:
			BFE1 AB 8 Bright;
			BFE1 C 8 Bright A_BFGSpray;
			BFE1 DEF 8 Bright;
			Stop;
	}
	
	action void A_BFGSpray(class<Actor> spraytype = "RBLBFGExtra", int numrays = 92, int damagecnt = 15, double ang = 90, double distance = 16*64, double vrange = 32, int defdamage = 0, int flags = 0) {
		int damage;
		FTranslatedLineTarget t;

		// validate parameters
		if (spraytype == null) spraytype = "RBLBFGExtra";
		if (numrays <= 0) numrays = 92;
		if (damagecnt <= 0) damagecnt = 15;
		if (ang == 0) ang = 90.;
		if (distance <= 0) distance = 16 * 64;
		if (vrange == 0) vrange = 32.;

		// [RH] Don't crash if no target
		if (!target) return;

		// [XA] Set the originator of the rays to the projectile (self) if
		//      the new flag is set, else set it to the player (target)
		//Actor originator = (flags & BFGF_MISSILEORIGIN) ? self : target;
		Actor originator = self;
		
		// offset angles from its attack ang
		for (int i = 0; i < numrays; i++) {
			double an = angle - ang / 2 + ang / numrays*i;
			originator.AimLineAttack(an, distance, t, vrange);

			if (t.linetarget != null) {
				Actor spray = Spawn(spraytype, t.linetarget.pos + (0, 0, t.linetarget.Height / 4), ALLOW_REPLACE);
				int dmgFlags = 0;
				Name dmgType = 'BFGSplash';

				if (spray != null) {
					if ((spray.bMThruSpecies && target.GetSpecies() == t.linetarget.GetSpecies()) || 
						(!(flags & BFGF_HURTSOURCE) && target == t.linetarget)) // [XA] Don't hit oneself unless we say so.
					{
						spray.Destroy(); // [MC] Remove it because technically, the spray isn't trying to "hit" them.
						continue;
					}
					if (spray.bPuffGetsOwner) spray.target = target;
					if (spray.bFoilInvul) dmgFlags |= DMG_FOILINVUL;
					if (spray.bFoilBuddha) dmgFlags |= DMG_FOILBUDDHA;
					dmgType = spray.DamageType;
				}

				if (defdamage == 0) {
					damage = 0;
					for (int j = 0; j < damagecnt; ++j)
						damage += Random[BFGSpray](1, 8);
				}
				else {
					// if this is used, damagecnt will be ignored
					damage = defdamage;
				}

				int newdam = t.linetarget.DamageMobj(originator, target, damage, dmgType, dmgFlags|DMG_USEANGLE, t.angleFromSource);
				t.TraceBleed(newdam > 0 ? newdam : damage, self);
			}
		}
	}
}
		
class RBLBFGExtra : Actor {
	Default {
		+NOBLOCKMAP
		+NOGRAVITY
		RenderStyle "Add";
		Alpha 0.75;
		DamageType "BFGSplash";
	}
	
	States {
		Spawn:
			BFE2 ABCD 8 Bright;
			Stop;
	}
}
