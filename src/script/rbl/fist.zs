// --------------------------------------------------------------------------
//
// Fist 
//
//	The fist is unchanged aside from being slightly faster.
//
// --------------------------------------------------------------------------

class RBLFist : MFWeapon replaces Fist {
	
	Default {
		Weapon.SlotNumber 1;
		Weapon.SelectionOrder 3700;
		Weapon.Kickback 100;
		Weapon.AmmoUse 0;
		Weapon.AmmoType "";
		Obituary "$OB_MPFIST";
		Tag "$TAG_FIST";
		+WEAPON.WIMPY_WEAPON
		+WEAPON.MELEEWEAPON
	}
	
	States {
		Ready:
			PUNG A 1 A_WeaponReady;
			Loop;
		Deselect:
			PUNG A 1 A_Lower;
			Loop;
		Select:
			PUNG A 1 A_Raise;
			Loop;
		Fire:
			PUNG A 4 A_WeaponOffset(24, 42, WOF_ADD);
			PUNG B 3 A_WeaponOffset(-24, -42, WOF_ADD);
			PUNG C 2 A_Punch;
			PUNG D 4;
			PUNG C 5;
			PUNG B 6 A_ReFire("Hold"); 
			//PUNG A 10 A_ReFire("Hold");
			PUNG B 4 A_WeaponOffset(0, 42, WOF_ADD);
			PUNG A 4 A_WeaponOffset(0, -42, WOF_ADD);
			Goto Ready;
		Hold:
			PUNG B 3;
			PUNG C 2 A_Punch;
			PUNG D 4;
			PUNG C 5;
			PUNG B 4 A_ReFire("Hold"); 
			//PUNG A 10 A_ReFire("Hold");
			PUNG B 4 A_WeaponOffset(0, 42, WOF_ADD);
			PUNG A 4 A_WeaponOffset(0, -42, WOF_ADD);
			Goto Ready;
	}

	action void A_Punch() {
		FTranslatedLineTarget t;

		if (player != null)
		{
			Weapon weap = player.ReadyWeapon;
			if (weap != null && !weap.bDehAmmo && invoker == weap && stateinfo != null && stateinfo.mStateType == STATE_Psprite)
			{
				if (!weap.DepleteAmmo (weap.bAltFire))
					return;
			}
		}

		int damage = random[Punch](1, 10) << 1;

		if (FindInventory("PowerStrength"))
			damage *= 10;

		double ang = angle + Random2[Punch]() * (5.625 / 256);
		double pitch = AimLineAttack (ang, DEFMELEERANGE, null, 0., ALF_CHECK3D);

		LineAttack (ang, DEFMELEERANGE, pitch, damage, 'Melee', "BulletPuff", LAF_ISMELEEATTACK, t);

		// turn to face target
		if (t.linetarget)
		{
			A_PlaySound ("*fist", CHAN_WEAPON);
			angle = t.angleFromSource;
		}
	}
}