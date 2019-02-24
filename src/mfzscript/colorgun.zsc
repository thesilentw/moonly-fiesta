class ColorGun : MFWeapon {
	
	bool AOE;
	
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "OOOH PRETTY COLOR CHANGY FANCY FANCY";
	}
	
	override void PostBeginPlay() {
		AOE = false;
		super.PostBeginPlay();
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
				if (invoker.AOE) {
					A_FireProjectile("AOEpaintball");
				}
				else {
					A_FireProjectile("paintball");
				}
				A_PlaySound("weapons/labpistol_fire", CHAN_WEAPON);
			}
			TPIS B 2 Offset(6,40);
			TPIS B 2 Offset(4,42);
			TPIS C 2 Offset(0,32);
			TPIS A 1 A_ReFire();
			Goto Ready;
		Altfire:
			TPIS A 10 {
				if (invoker.AOE) {
					Console.printf("single mode selected");
				}
				else {
					Console.printf("AOE mode selected");
				}
				invoker.AOE = !invoker.AOE;
				A_PlaySound("weapons/lpst_reload", CHAN_WEAPON);
				
			}
			Goto Ready;
		Spawn:
			TPIP A -1;
			Stop;
	}
}	

Class paintball : FastProjectile {		
	int chosenTrans;
	static const String translations[] = {
		"ToxicGreen",
		"CharcoalGrey",
		"YellowLightning",
		"BlueLightning",
		"BlueGoo"
	};
	
	default {
		+FORCEXYBILLBOARD;
		+thruspecies;
		damage 30;
		missileheight 8;
		speed 155;
		height 8;
		radius 8;
		Scale 1;
		alpha 0.95;
		decal "BulletChip";
		+HITTRACER;
	}
	
	states {
		Spawn:
			BAL1 ABCD 1;
			loop;
		Death:
			TNT1 A 1;
			TNT1 A 0 {
				if (tracer) {
					chosenTrans = random(0,4);
					tracer.A_SetTranslation(translations[chosenTrans]);
					Console.printf("translation set to %s", translations[chosenTrans]);
				}
				else {
					Console.printf("invalid tracer pointer");
				}
				
			}
			Stop;
	}
}

Class AOEPaintball : paintball {
	Actor testActor;
	BlockThingsIterator nearbyActors;
	
	States {
		Death:
			TNT1 A 1;
			TNT1 A 1 {
				if (tracer) {
					Console.printf("have tracer");
					chosenTrans = random(0,4);
					nearbyActors = BlockThingsIterator.Create(tracer, 128);
					Console.printf("iterator created");
					while (nearbyActors.Next()) {
						let testActor = nearbyActors.thing;
						if (testActor) {
							Console.printf("testActor not null");
						}
						if (CheckSight(testActor, 0)) {
							Console.printf("checksight true");
							testActor.A_SetTranslation(translations[chosenTrans]);
						}
						Console.printf("looping");
					}
				}
				else {
					Console.printf("invalid tracer pointer");
				}
				
			}
			Stop;
	}
}