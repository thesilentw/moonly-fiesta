class Bullgut : MFWeapon {
	default {
		Weapon.SlotNumber 5;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 0;
		Weapon.AmmoGive 50;
		Weapon.AmmoType "RocketBox";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "bullgut bullgot";
		+weapon.ammo_optional;
		weapon.upsound "weapons/bullgut_select";
	}

	States {
		Ready:
			BLGT A 1 A_WeaponReady();
			Loop;
		Deselect:
			BLGT A 1 A_Lower();
			Loop;
		Select:
			BLGT A 1 A_Raise();
			Loop;
		Fire:
			BLGT A 1;
			BLGT AAAAAAA 4 {  
				A_FireProjectile("SpiralMis", angle: frandom(-2.0,4.0), useammo: false, flags: FPF_NOAUTOAIM, pitch: frandom(-2.5,1.5));
				A_PlaySound("weapons/bullgut_fire",CHAN_WEAPON);
				A_WeaponOffset(frandom(-2,2), frandom(2.5, 4), WOF_ADD);
				A_QuakeEx(1, 1, 2, 4, 0, 30, "", flags: QF_RELATIVE|QF_SCALEDOWN);
				}
			BLGT A 10;
			BLGT A 13 A_PlaySound("weapons/jugg_reload1",CHAN_BODY);
			BLGT A 25 A_PlaySound("weapons/jugg_reload2",CHAN_BODY);
			BLGT A 10;
			Goto Ready;
		Spawn:
			TLGL A -1;
			Stop;
	}
}	

Class SpiralMis : FastProjectile {
	default {
		Decal "DoomImpScorch";
		damage 0;
		Speed 50;
		height 8;
		radius 8;
		Scale 0.8;
		alpha 0.95;
		-RANDOMIZE;
		//+ROCKETTRAIL;
		WeaveIndexXY 16;
		WeaveIndexZ 32;
	}
	states {
		Spawn:
			//MISL A 5;
			MISL A 2 A_Weave(10, 10, 2.0, 2.0);
			//MISL A 3 A_Weave(10, 10, 2.0, 2.0);			
			goto flight;
		
		Flight:
			MISL A 1 A_ChangeVelocity (1.1, frandom(-1.5,1.5), frandom(-0.5,0.5), CVF_RELATIVE);
			MISL A 4 A_Weave(10, 10, 2.0, 2.0);
			//MISL A 1;
			loop;
		
		Death:
			MISL B 4 Bright { 
				A_Explode();
				A_PlaySound("weapons/bullgut_impact",CHAN_AUTO);
			}
			MISL C 3 Bright;
			MISL D 2 Bright;
			Stop;
	}
}



Class TestMis : Rocket {
	default {
		damage 0;
		Speed 45;
		height 8;
		radius 8;
		Scale 1;
		alpha 0.95;
		-RANDOMIZE;
		WeaveIndexXY 32;
		WeaveIndexZ 0;
	}
	states {
		Spawn:
			MISL A 1;
			MISL A 1 A_ChangeVelocity (1.1, frandom(-5.0,5.0), frandom(0.0,2.5), CVF_RELATIVE);
			MISL A 1;
			MISL A 1 A_SeekerMissile(2.5,2,SMF_LOOK,64,5);
			MISL A 1 A_ChangeVelocity (1.1, frandom(-5.0,5.0), frandom(-2.0,3.0), CVF_RELATIVE); 
			MISL A 1;
			MISL A 1 A_SeekerMissile(2.5,2,SMF_LOOK,64,5);
			MISL A 1 A_ChangeVelocity (1.1, frandom(-5.0,5.0), frandom(-4.0,4.0), CVF_RELATIVE);
			goto flight;
		
		Flight:
			MISL A 3 A_SeekerMissile(2.5,2,SMF_LOOK,64,5);
			MISL A 5 A_Weave(2,2,6.0,6.0);
			MISL A 1; //A_ChangeVelocity (1.5, frandom(-5.0,5.0), frandom(-2.5,2.5), CVF_RELATIVE); 
			MISL A 2;
			MISL A 3 A_SeekerMissile(1.1,1,SMF_LOOK,64,5);
			MISL A 5 A_Weave(2,2,6.0,6.0);
			loop;
		
		Death:
			TNT1 A 0 A_Explode();
			//TNT1 AAAAAAAAAA 0 bright A_SpawnItemEx("Smoke", 0, 0, 0, random(2,-2), random(2,-2), 1+random(1,-3), 0, 128, 0);
			//TNT1 AAAA 0 bright A_SpawnItemEx("Boomy", 0, random(2,-2), random(2,-2), 0, 0, 1, 0, 128, 0);
			TNT1 A 1;
			Stop;
	}
}