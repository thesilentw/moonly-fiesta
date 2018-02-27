/* LAWGIVER MK IV
DREDD: You betrayed THE LAW!
RICO: LAWWWWW!
Yeah, this is it. A composite of the 1995 movie, the 2012 movie, and Rebellion's Dredd vs. Death Lawgivers, this puppy has it all.
// DESIGN NOTES
LawgiverMag - 14 shots
LawgiverFireMode 0 - Standard - 1 bullet per shot
LawgiverFireMode 1 - Armor Piercing - 2 bullets per shot, pierces enemies
LawgiverFireMode 2 - Heatseeker - 3 bullets per shot, tracks enemies
LawgiverFireMode 3 - High Ex - 7 bullets per shot - minirocket
LawgiverFireMode 4 - Incendiary - 4 bullets per shot - minirocket with flame
LawgiverFireMode 5 - Ricochet - 1 bullet per shot - bounces
LawgiverFireMode 6 - Autofire/burst *NOT IMPLEMENTED* - 3-round burst, ammo discount.
*/

#include "mfzscript/lawgiver_incshot.zsc"

class Lawgiver : DoomWeapon {
	default {
		inventory.pickupMessage "Well, look at that. I must be a Judge.";
		weapon.AmmoType1 "LawgiverMag";
		weapon.AmmoUse1 0;
		weapon.AmmoGive1 0;
		weapon.AmmoType2 "clip";
		weapon.AmmoUse2 0;
		weapon.AmmoGive2 20;
		weapon.slotNumber 2;
		Weapon.SelectionOrder 2000;
		weapon.upsound "weapons/lg_deploy";
		+weapon.Ammo_Optional
		+weapon.Ammo_CheckBoth
	}

	States {
		Spawn:
			LAWP A -1;
			Stop;
		Ready:
			LAWG A 1 {
				if (countInv("LawgiverMag") > 13) {
					A_WeaponReady();
				}
				else {
					A_WeaponReady(WRF_ALLOWRELOAD);
				}
			}
			Loop;
		Select:
			LAWG A 1 A_Raise();
			Loop;
		Deselect:
			LAWG A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 0 {
				if (countInv("LawgiverMag") < 1) {
					if (countInv("clip") < 1) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("DryReload");
					}
				} else {return ResolveState(null);}
			}
			TNT1 A 0 {
				if (countInv("LawgiverFireMode") == 0) {
					return ResolveState("FireSTD"); // we already checked if we have at least 1 shot
				}
				else if (countInv("LawgiverFireMode") == 1) {
					if (countInv("LawgiverMag") >= 2) {
						return ResolveState("FireAP");
					} else if ((countInv("LawgiverMag") + countInv("clip")) < 2) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("Reload");
					}
				}
				else if (countInv("LawgiverFireMode") == 2) {
					if (countInv("LawgiverMag") >= 3) {
						return ResolveState("FireHEAT");
					} else if ((countInv("LawgiverMag") + countInv("clip")) < 3) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("Reload");
					}
				}
				else if (countInv("LawgiverFireMode") == 3) {
					if (countInv("LawgiverMag") >= 7) {
						return ResolveState("FireHIEX");
					} else if ((countInv("LawgiverMag") + countInv("clip")) < 7) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("Reload");
					}
				}
				else if (countInv("LawgiverFireMode") == 4) {
					if (countInv("LawgiverMag") >= 4) {
						return ResolveState("FireINC");
					} else if ((countInv("LawgiverMag") + countInv("clip")) < 4) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("Reload");
					}
				}
				else if (countInv("LawgiverFireMode") == 5) {
					if (countInv("LawgiverMag") >= 1) {
						return ResolveState("FireRICO");
					} else if ((countInv("LawgiverMag") + countInv("clip")) < 1) {
						return ResolveState("NoAmmo");
					} else {
						return ResolveState("Reload");
					}
				}
				else {
					return ResolveState("NoAmmo"); //this SHOULD never call unless the firemode goes haywire
				}
			}
		AltFire:
			TNT1 A 0 {
				if (countInv("LawgiverFireMode") > 4) {
					A_SetInventory("LawgiverFireMode", 0);
				}
				else {
					A_GiveInventory("LawgiverFireMode", 1);
				}
			}
			TNT1 A 0 {
				if (countInv("LawgiverFireMode") == 0) {
					return ResolveState("SwitchToSTD");
				}
				else if (countInv("LawgiverFireMode") == 1) {
					return ResolveState("SwitchToAP");
				}
				else if (countInv("LawgiverFireMode") == 2) {
					return ResolveState("SwitchToHEAT");
				}
				else if (countInv("LawgiverFireMode") == 3) {
					return ResolveState("SwitchToHIEX");
				}
				else if (countInv("LawgiverFireMode") == 4) {
					return ResolveState("SwitchToINC");
				}
				else if (countInv("LawgiverFireMode") == 5) {
					return ResolveState("SwitchToRICO");
				}
				else {
					return ResolveState("SwitchToSTD"); // this shouldn't happen unless everything's fucked
				}
			}	
		SwitchToSTD:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_stdselected");
			Goto Ready;
		SwitchToAP:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_apselected");
			Goto Ready;
		SwitchToHEAT:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_seekerselected");
			Goto Ready;
		SwitchToHIEX:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_hiexselected");
			Goto Ready;
		SwitchToINC:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_incselected");
			Goto Ready;
		SwitchToRICO:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_ricoselected");
			Goto Ready;
		/*
		SwitchToAUTO:
			TNT1 A 0 A_StopSound(CHAN_WEAPON);
			LAWG A 10 A_PlaySound("weapons/lg_ammoswitched");
			LAWG A 1 A_PlaySound("weapons/lg_autoselected");
			Goto Ready;
		*/	
		FireAP: // Now with punchthrough
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 2);// 7 shots per mag
				A_RailAttack(60, 0, true, "", "", RGF_SILENT, 0, "APBulletPuff", frandom(-0.1,0.1), frandom(-0.1,0.1), 0, 0, 0, 0, null, 0, 0, 6);
			}
			LAWG A 2;
			LAWG BC 3;
			LAWG AAAAAA 1 A_ReFire();
			Goto Ready;	
		FireHEAT: // aggressive seeker round
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 3); // 4 shots per mag
				A_FireProjectile("LawgiverHEATShot", 1, true);
			}
			LAWG A 2;
			LAWG BC 5;
			LAWG AAAAAA 1 A_ReFire();
			Goto Ready;
		FireHIEX: // Fast rocket, essentially
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 7); // 2 shots per mag
				A_FireProjectile("LawgiverHIEXShot", 1, true);
			}
			LAWG A 2;
			LAWG BC 5;
			LAWG AAAAAA 1 A_ReFire(); 
			Goto Ready;
		FireINC: // Fast rocket with BURNING, ahahaha
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 4); // 3 shots per mag
				//A_FireBullets(1,1,1,200,"BulletPuff",FBF_USEAMMO);
				A_FireProjectile("LawgiverINCShot", 1, true);
			}
			LAWG A 2;
			LAWG BC 5;
			LAWG AAAAAA 1 A_ReFire(); 
			Goto Ready;
		FireRICO: // pwing pwang pwong AAAGH
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 1); // 14 shots per mag
				A_FireProjectile("LawgiverRICOShot", 1, true);
			}
			LAWG A 2;
			LAWG BC 3;
			LAWG AAAAAA 1 A_ReFire(); 
			Goto Ready;
		FireSTD: //needs to be here, not at the beginning, as a fallthrough safety
			TNT1 A 0 {
				A_GunFlash();
				A_PlaySound("weapons/lg_firesingle", CHAN_WEAPON);
				A_TakeInventory("LawgiverMag", 1); // 14 shots per mag
				A_FireBullets(1,1,1,40);
			}
			LAWG A 2;
			LAWG BC 3;
			LAWG AAAAAA 1 A_ReFire();
			Goto Ready;
		NoAmmo:
			TNT1 A 0 {
				A_StopSound(CHAN_WEAPON);
				//A_SetInventory("LawgiverFireMode", 0);
			}
			LAWG A 10 A_PlaySound("weapons/lg_outofammo");
			Goto Ready;
		Flash:
			TNT1 A 4 A_Light(2);
			TNT1 A 1 A_Light(0);
			Goto LightDone;
		Reload:
			TNT1 A 0 {
				if (countInv("LawgiverMag") == 14) { // if mag's full...
					if (countInv("clip") < 1) { // ..and we have no reserve, tell us!
						return ResolveState("NoAmmo");
					}
					else {
						return ResolveState("Ready"); // otherwise ignore the reload.
					}
				}
				else {
					return ResolveState("DoReload");
				}
			}		
		DoReload:
			LAWG R 1 Offset(0,38);
			LAWG R 1 Offset(0,44);
			LAWG R 1 Offset(0,52);
			LAWG R 1 Offset(0,62);
			LAWG R 1 Offset(0,72);
			LAWG R 1 Offset(0,82);
			LAWG R 1 A_PlaySound("weapons/shotgr", CHAN_WEAPON); //placeholder reload sound
			TNT1 A 0 {
				while ((countInv("LawgiverMag") < 14) && (countInv("clip") > 0)) {
					A_GiveInventory("LawgiverMag", 1);
					A_TakeInventory("clip", 1);
				}
			}
			LAWG R 1 Offset(0,82);
			LAWG R 1 Offset(0,72);
			LAWG R 1 Offset(0,62);
			LAWG R 1 Offset(0,52);
			LAWG R 1 Offset(0,44);
			LAWG R 1 Offset(0,38);
			LAWG R 1 Offset(0,35);
			LAWG R 1 Offset(0,32);
			Goto Ready;
		DryReload: //not implemented
			Goto Reload;
	}
}

class LawgiverMag : Ammo {
	default {
		Inventory.MaxAmount 14;
		+Inventory.IGNORESKILL
	}
}

class LawgiverFireMode : Inventory {
	default {
		Inventory.MaxAmount 6; //autofire not implemented
		+Inventory.IGNORESKILL
		// 0 - Standard
		// 1 - Armor Piercing
		// 2 - Heatseeker
		// 3 - High Ex
		// 4 - Incendiary
		// 5 - Ricochet		 
		// 6 - Auotfire/burst *NOT IMPLEMENTED*
	}
}

/*
class LawgiverSTDShot {
	Obituary "%k rendered their verdict on %o's crimes in 10mm FMJ."
	Decal BulletChip
}

class LawgiverAPShot {
	Obituary "%o needs to pick better cover if he's up against %k's Armor Piercing rounds."
	Decal BulletChip
}
*/

class LawgiverHIEXShot : FastProjectile {
	default {
		Obituary "%k's found some bits of %o in their teeth after connecting with that High-Ex round.";
		Decal "DoomImpScorch";
		Radius 4;
		Height 4;
		Speed 75;
		Damage 100;
		Scale 0.5;
		Projectile;
		+RANDOMIZE
		+ROCKETTRAIL
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
	}
		States {
			Spawn:
				SGRN A 1 Bright;
				Loop;
			Death:
				MISL B 8 Bright A_Explode();
				MISL C 6 Bright A_Mushroom();
				MISL D 4 Bright;
				Stop;
		}
}

class LawgiverRICOShot : Actor { //fastprojectile doesn't allow bouncing
	default {
		Projectile;
		Obituary "%o was surprised to find out %k's Lawgiver was set on Ricochet.";
		Decal "BulletChip";
		Radius 4;
		Height 4;
		Speed 70;
		Damage 20;
		BounceType "Hexen";
		BounceFactor 0.99;
		BounceCount 5;
		DamageType "Bullet";
		Scale 0.25;
		Alpha 0.9;
		DeathSound "weapons/lpst_impact"; // placeholder
		//BounceSound "";
	}
	States {
		Spawn:
			BAL2 A 1 Bright;
			Loop;
		Death:
			BAL2 CDE 2 Bright;
			Stop;
	}
}

/*
class LawgiverAUTOShot : FastProjectile {
	default {
		Obituary "%o had Justice served at 2500 RPM, courtesy of %k's Lawgiver.";
		Decal "BulletChip";
	}
}
*/

class APBulletPuff : BulletPuff {
	default { 
		+ALWAYSPUFF
	}
}

// ++ HEATSEEKER STUFF +++
// Seeking code from Lithium by Marrub, thanks murb
class LawgiverHEATShot : FastProjectile {
	default {
		Obituary "%o discovered that there's no escape from %k's Heatseeker rounds.";
		Decal "BulletChip";
		MissileType "SeekerTrail";
		Damage 45;
		Speed 70;
		Radius 4;
		Height 4;
		Projectile;
		+SEEKERMISSILE
		//+SCREENSEEKER  // we want it to seek aggressively and without limit
   }  
   states {
   Spawn:
      TNT1 A 0 A_SeekerMissile(5, 45, SMF_LOOK | SMF_PRECISE, 100);
      TNT1 A 1 A_SpawnItemEx("SeekerTrail");
      loop;
   Death:
      TNT1 A 0 A_SpawnItemEx("SeekerTrailPuff");
      stop;
   }
}

class SeekerTrail : Actor {
   default {
      RenderStyle "Add";
      Scale 0.3;
      Alpha 0.5;
      Translation "160:167=192:199", "64:79=197:201";
      +BRIGHT
      +NOINTERACTION
   }
   states {
   Spawn:
      PUFF A 1 A_FadeOut(0.05);
      wait;
   }
}

class SeekerTrailPuff : SeekerTrail {
   states {
   Spawn:
      PUFF BCD 2;
      stop;
   }
}

//eof