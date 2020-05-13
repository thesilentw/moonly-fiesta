/// all the grenade shit in one place

Class GrenThrower : MFWeapon {

	default {
		Radius 20;
		Height 16;
		Weapon.SelectionOrder 2500;
		+WEAPON.NOAUTOFIRE
		+WEAPON.NOAUTOAIM
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 999;
		Weapon.AmmoType "RocketAmmo";
		Weapon.SlotNumber 5;
		Inventory.PickupMessage "Grabbed some Grenades.";	
	}

	States {
		Spawn:
			LAUN A -1;
			Stop;
		Ready:
			TGRN A 1 A_WeaponReady();
			Loop;
		Deselect:
			TGRN A 1 A_Lower();
			Loop;
		Select: 
			TGRN A 1 A_Raise();
			Loop;
		Fire: 
			TGRN A 10 A_PlaySound("weapons/grenade_pinpull", CHAN_WEAPON);
		Holding:
			TGRN A 15;
			TNT1 A 0 A_Refire("Holding");
			Goto Throw;
		Throw:
			TGRN B 15 A_FireProjectile("GrenFragThrown", 0, 1, 0, 0, 0, -1);
			TGRN C 30;
			Goto Ready;
	}	
}

Class GrenFragThrown : Actor {
	
	bool logDeath, logGrenade, logDetonate, logMushroom, logAll;

	override void PostBeginPlay() {
		logAll = true;
		super.PostBeginPlay();
	}
	
	default {
		Radius 8;
        Height 8;
        Speed 50;
        Scale 0.5;
        DamageFunction (random(20,30));
        BounceType "Doom";
        BounceFactor 0.25; //.35
        WallBounceFactor 0.40; //.75
        Gravity 0.60;
        ReactionTime 85;
        Species "Grenade";
        DamageType "Explosive";
        Projectile;
		DeathSound "weapons/thumper_explosionamped";
        +THRUGHOST
        +THRUSPECIES
        +BOUNCEONWALLS
        +BOUNCEONFLOORS
        +BOUNCEONCEILINGS
        +ALLOWBOUNCEONACTORS
        -NOGRAVITY
        +DONTGIB
        +MOVEWITHSECTOR
        +EXTREMEDEATH
        +ROLLCENTER
        +ROLLSPRITE
        +USEBOUNCESTATE
        +CANBOUNCEWATER
        +DONTBLAST
        +DONTTHRUST
		+ROCKETTRAIL
		Obituary "Once you've pulled the pin on Mr. Grenade, he is no longer your friend, %o.";
	}
	
	States {
		Spawn:
			SGRN A 1 Bright;
			Loop;
		Death:
			MISL B 8 Bright {
				if (logAll) {
					Console.printf("projectile went to death state");
				}	
			}
			MISL B 15 A_Explode();
			MISL C 6 Bright;
			MISL D 4 Bright;
			Stop;
	}
}

Class GrenMIRVThrown : GrenFragThrown {

	default {
		BounceType "None";
		BounceFactor 0.0;
        WallBounceFactor 0.0;
	}

	override void PostBeginPlay() {
		logAll = true;
		super.PostBeginPlay();
	}
	
	States {
		Spawn:
			SGRN A 1 Bright;
			Loop;
		Death:
			TNT1 A 0 {
				int subCount = 8;
				int subAngleMult = 45;
				while (subCount > 0) {
					A_SpawnItemEx("GrenMIRVSubmun", xofs: 0.0, yofs: 0.0, zofs: FRandom(0.0, 5.0), xvel: 0.12, yvel: 0, zvel: 0.15, angle: ((subAngleMult*subCount)+random(-10,10)), flags: SXF_NOCHECKPOSITION | SXF_TRANSFERTRANSLATION | SXF_MULTIPLYSPEED);
					if (logAll) {
						Console.printf("MIRV child spawned, angle %i", subAngleMult*subCount);
					}
					subCount--;
				}
			}
			MISL B 10 Bright {
				if (logAll) {
					Console.printf("MIRV parent went to death state");
				}
				A_Explode();				
			}			
			MISL C 6 Bright;
			MISL D 4 Bright;
			Stop;
	}

}

Class GrenMIRVSubmun : GrenFragThrown {

	int lifetime;
	
	property lifetime: lifetime;
	
	default {
		GrenMIRVSubmun.lifetime 35;
		BounceFactor 0.35;
        WallBounceFactor 0.35;
		Gravity 0.85;
        Scale 0.35;
        DamageFunction (random(10,20));
		DeathSound "";
	}

	override void PostBeginPlay() {
		logAll = true;
		super.PostBeginPlay();
	}
	
	States {
		Spawn:
			SGRN A 10 Bright; //A_ChangeVelocity(x:25, y:vely, z:velz, flags:CVF_RELATIVE);
			Goto Flight;
		Flight:
			SGRN A 1 Bright;
			Loop;
		Death:
			SGRN A 1 {
				if (logAll) {Console.printf("MIRV submunition went to death state");}
			}
			SGRN A 5 A_Jump(256, "Delay1","Delay2","Delay3","Delay4","Delay5","Delay6");
		Delay1:	
			SGRN A 1;
			TNT1 A 0 A_Jump(256, "Boom");
		Delay2:	
			SGRN A 10;
			TNT1 A 0 A_Jump(256, "Boom");
		Delay3:	
			SGRN A 20;
			TNT1 A 0 A_Jump(256, "Boom");
		Delay4:	
			SGRN A 25;
			TNT1 A 0 A_Jump(256, "Boom");
		Delay5:	
			SGRN A 7;
			TNT1 A 0 A_Jump(256, "Boom");
		Delay6:	
			SGRN A 15;
			TNT1 A 0 A_Jump(256, "Boom");
		Boom:
			MISL B 6 Bright {
				A_PlaySound("weapons/mirv_explosion", CHAN_AUTO);
				A_Explode();
			}
			MISL C 5 Bright;
			MISL D 4 Bright;
			Stop;
	}
}

Class GrenTearThrown: GrenFragThrown {
		
	default {
		DamageFunction (0);
		DamageType "None";
	}
	
	override void PostBeginPlay() {
		logAll = true;
		super.PostBeginPlay();
	}
	
	States {
		Spawn:
			SGRN A 1 Bright;
			Loop;
		Death:
			MISL B 8 Bright {
				if (logAll) {
					Console.printf("projectile went to death state");
				}
				//A_Explode();
				A_SpawnItemEx("tearGasCloud", random(-2,2), random(-2,2), random(1,3), random(-2,2), random(-2,2), 0);
				A_SpawnItemEx("tearGasCloud", random(-2,2), random(-2,2), random(1,3), random(-2,2), random(-2,2), 0);
				A_SpawnItemEx("tearGasCloud", random(-2,2), random(-2,2), random(1,3), random(-2,2), random(-2,2), 0);
				A_SpawnItemEx("tearGasCloud", random(-2,2), random(-2,2), random(1,3), random(-2,2), random(-2,2), 0);
			}
			MISL C 6 Bright;
			MISL D 4 Bright;
			Stop;
	}
	
	
}

Class tearGasCloud : Actor {

	int gasDuration;
	int cloudRadius;
	
	property gasDuration: gasDuration;
	property cloudRadius: cloudRadius;
	
	default {
		tearGasCloud.cloudRadius 64;
		tearGasCloud.GasDuration 4;
		Radius 32;
		Height 64;
		Mass 0x7fffffff;
		+NOBLOCKMAP
		+NOGRAVITY
		+DROPOFF
		+NODAMAGETHRUST
		+DONTSPLASH
		+FLOAT
		FloatSpeed 10;
		+BLOODLESSIMPACT
		RenderStyle "Translucent";
		Alpha 0.4;
	}	
	States {
		Spawn:
			GTXM A 1;
			GTXM A 1 A_Scream();
			GTXM ABCDE 10 A_Explode(1, invoker.cloudRadius, XF_HURTSOURCE, false, invoker.cloudRadius);
			goto CloudLoop;
		CloudLoop:
			GTXM ABCD 10 A_Explode(1, invoker.cloudRadius, XF_HURTSOURCE, false, invoker.cloudRadius);
			GTXM E 10 {
				A_Explode(1, invoker.cloudRadius, XF_HURTSOURCE, false, invoker.cloudRadius);
				if (invoker.gasDuration > 0) {
					invoker.gasDuration--;
					return resolveState("CloudLoop");
					}
				else return resolveState("Death");
			}
		Death:
			GTXS ABCDE 7 {
				A_Explode(1, invoker.cloudRadius, XF_HURTSOURCE, false, invoker.cloudRadius);
				A_FadeOut(0.1);
			}
			Stop;
	}
}


/* /// 
Grenade Launcher:
8-chamber cylinder
Fire fires the current chamber
Altfire advances the chamber by 1
Reload changes the type of ammo in the current chamber
user1 reloads all chambers with the current chamber's ammotype
/// */

Class GrenLauncher : MFWeapon {
	int[8] magazine;
	int chamberIndex;
	int previousAmmoIndex;
	int currentlyLoaded;
	
	static const String ammoTypes[] = {
		"Unloaded",
		"Frag",
		"Gas",
		"MIRV",
		"Shock",
		"Flame",
		"Bees"
	};
	
	property chamberIndex: chamberIndex;
	property previousAmmoIndex: previousAmmoIndex;
	property currentlyLoaded: currentlyLoaded;
	
	default {
		inventory.pickupMessage "Grabbed a Grenade Launcher! Lots of ammo types to choose from...";
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 10;
		Weapon.AmmoType "RocketAmmo";
		weapon.slotNumber 5;
		weapon.SelectionOrder 3500;
		Weapon.BobRangeX 0.0;
		Weapon.BobRangeY 0.0;
		+WEAPON.NODEATHINPUT
		+WEAPON.AMMO_OPTIONAL
		+WEAPON.NOAUTOFIRE
		+WEAPON.NOAUTOAIM
		GrenLauncher.chamberIndex 0;
		GrenLauncher.previousAmmoIndex 1; //start off with Frag as last selected so that an initial BigReload works correctly
		GrenLauncher.currentlyLoaded 0; //starts off empty
	}

	
	States {
		Spawn:
			TLGL A -1;
			Stop;
		Ready:
			GRLN A 1 A_WeaponReady(WRF_ALLOWUSER1|WRF_ALLOWRELOAD);
			Loop;
		Select:
			GRLN A 1 A_Raise();
			Loop;
		Deselect:
			GRLN A 1 A_Lower();
			Loop;
		Fire:
			GRLN A 1 {
				switch( invoker.magazine[invoker.chamberIndex]) {
					case 0:
						return ResolveState("Unloaded");
						break;
					case 1:
						return ResolveState("Frag");
						break;
					case 2:
						return ResolveState("Gas");
						break;
					case 3:
						return ResolveState("MIRV");
						break;
					case 4:
						return ResolveState("Shock");
						break;
					case 5:				
						return ResolveState("Flame");
						break;
					case 6:			
						return ResolveState("Bees");
						break;
					default:
						return ResolveState("Unloaded");
				}
				return ResolveState("Unloaded");
			}
		Frag:
			GRLN E 4 {
				A_PlaySound("weapons/thumper_fireamped", CHAN_WEAPON);
				A_FireProjectile("GrenFragThrown", useammo: 0, spawnofs_xy: 3.5,  flags: FPF_NOAUTOAIM, pitch: -5.0);
				invoker.previousAmmoIndex = 1;
				invoker.magazine[invoker.chamberIndex] = 0;
			}
			Goto AdvanceChamber;
		Gas:
			GRLN E 4 {
				A_PlaySound("weapons/thumper_fireamped", CHAN_WEAPON);
				A_FireProjectile("GrenTearThrown", useammo: 0, spawnofs_xy: 3.5,  flags: FPF_NOAUTOAIM, pitch: -5.0);
				invoker.previousAmmoIndex = 2;
				invoker.magazine[invoker.chamberIndex] = 0;
			}
			Goto AdvanceChamber;
		MIRV:
			GRLN E 4 {
				A_PlaySound("weapons/thumper_fireamped", CHAN_WEAPON);
				A_FireProjectile("GrenMIRVThrown", useammo: 0, spawnofs_xy: 3.5,  flags: FPF_NOAUTOAIM, pitch: -5.0);
				invoker.previousAmmoIndex = 3;
				invoker.magazine[invoker.chamberIndex] = 0;
			}
			Goto AdvanceChamber;
		Shock:
		Flame:
		Bees:
		Unloaded:
			GRLN A 5 A_PlaySound("weapons/jugg_dry");
			Goto Ready;		
		
		AltFire:
			Goto SwapAmmo;
		Reload:
			Goto BigReload;
		User1:
			Goto AdvanceChamber;
			
		AdvanceChamber:
			GRLN A 3;
			GRLN C 3 A_PlaySound("weapons/jugg_reload2", CHAN_AUTO);
			GRLN B 3;
			GRLN A 2 {
				if (invoker.chamberIndex >= 7) {
					invoker.chamberIndex = 0;
				}
				else {
					invoker.chamberIndex++;
				}
				Console.printf("chamber advanced to chamber %i", invoker.chamberIndex);
			}
			Goto Ready;
		
		SwapAmmo:
			GRLN A 10 {
				A_PlaySound("weapons/thumper_reloadshort", CHAN_AUTO);
				invoker.previousAmmoIndex = invoker.magazine[invoker.chamberIndex];
				if (invoker.magazine[invoker.chamberIndex] <= 3) {
					invoker.magazine[invoker.chamberIndex] += 1;
				}
				else {
					invoker.magazine[invoker.chamberIndex] = 1;
				}
				Console.printf("chamber %i loaded with %s, previously %s", invoker.chamberIndex, GrenLauncher.ammoTypes[invoker.magazine[invoker.chamberIndex]], GrenLauncher.ammoTypes[invoker.previousAmmoIndex]);
			}
			Goto Ready;
			

		BigReload:
			TNT1 A 0 {
				invoker.currentlyLoaded = invoker.magazine[invoker.chamberIndex];
				if (invoker.currentlyLoaded == 0) {
					Console.printf("currently loaded ammo is %s (should be Unloaded!), loading previous type (%s)", (GrenLauncher.ammoTypes[invoker.currentlyLoaded]), GrenLauncher.ammoTypes[invoker.previousAmmoIndex]);
					invoker.currentlyLoaded = invoker.previousAmmoIndex;
				}
				else {
					Console.printf("currently loaded ammo is %s, using that", GrenLauncher.ammoTypes[invoker.currentlyloaded]);
				}
				for (int curcham = 0; curcham < 8; curcham++) {
						invoker.magazine[curcham] = invoker.currentlyLoaded;
						Console.printf("loaded chamber %i with %s", curcham, GrenLauncher.ammoTypes[invoker.currentlyLoaded]);
				}
				
			}
			GRNL AAAAAAAA 6 A_PlaySound("weapons/thumper_reloadshort", CHAN_AUTO);
			Goto Ready;

	}

}