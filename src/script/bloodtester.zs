class bloodtester : MFWeapon {
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "TEST BLOOD TESTER PISTOL TESTER BLOOD";
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
				A_FireProjectile("testproj");
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

Class testproj : FastProjectile {
	default {
		+FORCEXYBILLBOARD;
		+thruspecies;
		missileheight 8;
		speed 155;
		height 8;
		radius 8;
		Scale 1;
		alpha 0.95;
		+HITTRACER;
	}
	
	states {
		Spawn:
			BAL1 B 1;
			loop;
		Death:
			TNT1 A 0;
			TNT1 A 0 {
				if (tracer) {
					String temp = tracer.BloodType;
					double temp2 = tracer.BloodColor;
					String temp3 = tracer.Species;
					Console.printf("bloodtester hit target, bloodtype %s, blood color %d, species %s", temp, temp2, temp3);
				}
				else {
					Console.printf("invalid tracer pointer");
				}
				
			}
			stop;
	}


}