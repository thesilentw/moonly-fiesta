class zstogglepistol : MFWeapon {
	default {
		Weapon.SlotNumber 2;
		Weapon.SelectionOrder 2500;
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 40;
		Weapon.AmmoType "Clip";
		Obituary "test weapon please ignore";
		Inventory.Pickupmessage "ZSCRIPT CVARGUN";
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
				If (GetCvar("NORECOIL")) {
                    A_quake(1,2,0,5, "");
					A_PlaySound("weapons/labpistol_fire",CHAN_WEAPON);
                }
                Else {
                    A_quake(1,2,0,5, "");
                    A_SetPitch(pitch - random(1, 1));
                    A_SetAngle(angle + random(-1, 1));    
					A_PlaySound("weapons/weapons/sprf_fire",CHAN_WEAPON);
                }
				A_FireProjectile("boolet");
				A_FireProjectile("boolet", Frandom(-1500, 1500) / 400.0);
				A_FireProjectile("boolet", Frandom(-1500, 1500) / 700.0);
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
		
Class boolet : FastProjectile {
	default {
		+notimefreeze;
		+FORCEXYBILLBOARD;
		+thruspecies;
		damage 30;
		missileheight 1;
		speed 150;
		height 1;
		radius 1;
		Scale 1;
		alpha 0.95;
		-NOGRAVITY;
		+BLOODSPLATTER;
		+NOEXTREMEDEATH;
		decal "BulletChip";
	}
	
	states {
	Spawn:
		BAL1 B 1 A_ChangeVelocity(vel.x, vel.y, (vel.z-10.), CVF_RELATIVE);
		loop;
	}
}
// EOF