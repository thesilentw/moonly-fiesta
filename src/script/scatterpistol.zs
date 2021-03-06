class scatpistol : MFWeapon {
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "TEST SCATTERPISTOL";
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
				A_FireProjectile("MacePellet");
				A_FireProjectile("MacePellet", Frandom(-1500, 1500) / 400.0);
				A_FireProjectile("MacePellet", Frandom(-1500, 1500) / 700.0);
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
		
		
Class macepellet : FastProjectile {
	default {
		+notimefreeze;
		+FORCEXYBILLBOARD	;
		+thruspecies;
		damage 30;
		missileheight 1;
		speed 150;
		height 1;
		radius 1;
		Scale 1;
		alpha 0.95;
		-NOGRAVITY;
		//gravity 1.5;
		+BLOODSPLATTER;
		+NOEXTREMEDEATH;
		decal "BulletChip";
	}
	
	states {
	Spawn:
		BAL1 B 1 A_ChangeVelocity(vel.x, vel.y, (vel.z-10.), CVF_RELATIVE);
		loop;
	Death:
		TNT1 A 0;
		TNT1 A 0 a_stop();
		TNT1 A 1 a_spawnitemex ("scatterballhit",-5,-5,0,frandom(-2,-8),frandom(-8,8),frandom(5,10),0,SXF_NOCHECKPOSITION);
		stop;
	}
}

class scatterballhit : Actor {
	default {
		projectile;
		+THRUACTORS;
		+bright;
		-NOGRAVITY;
		gravity 1.5;
		+hexenbounce;
		radius 8;
		bouncecount 2;
		bouncefactor 0.8;
		//seesound "cannon/lilclang"
	}
	
	states {
	spawn:
		TNT1 A 0;
		BAL1 C 1;
		loop;
	death:
		TNT1 A 1;
		stop;
	}
}