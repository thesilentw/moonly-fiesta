// Super Revenant!!!!
// AAAAAAAAAAAAAAAAAAAAAAAAAA

Class SuperRev : Actor	{
	//
	// class vars	
	//
	int max_consec_melee;
	
	//
	// class setup
	//
	override void PostBeginPlay() {
		max_consec_melee = 1;
		super.PostBeginPlay();
	}
	
	//
	// class fxns
	//
	void A_SkelMissile_Big() {
		if (!target) return;
		A_FaceTarget();
		AddZ(16);
		Actor missile = SpawnMissile(target, "RevenantTracer");
		AddZ(-16);
		if (missile) {
			missile.SetOrigin(missile.Vec3Offset(missile.vel.x, missile.vel.y, 0), false);
			missile.tracer = target;
			if (!CheckLOF()) {
				missile.addZ(50, true);
			}
		}			
	}
	void A_SmartChase() {
		if (CheckSight(target) == true) {
			A_Chase();
			//A_PrintBold(" I   S E E   Y O U . . . ");
		} else {
			A_Wander();
			//A_PrintBold(" D O N ' T   H I D E . . . ");
		}
	}
	
	default {
		Health 300;
		Radius 20;
		Height 56;
		Mass 500;
		Speed 10;
		PainChance 100;
		Monster;
		MeleeThreshold 196;
		+MISSILEMORE;
		+FLOORCLIP;
		SeeSound "skeleton/sight";
		PainSound "skeleton/pain";
		DeathSound "skeleton/death";
		ActiveSound "skeleton/active";
		MeleeSound "skeleton/melee";
		HitObituary "%o got beaten down by an agitated bag 'o bones.";
		Obituary "%o decided to try blocking a homing missile with their face.";
	}
	States {
		Spawn:
			SKEL AB 10 A_Look();
			Loop;
		See:
			SKEL AABBCCDDEEFF 2 A_SmartChase();
			Loop;
		Melee:
			SKEL G 6 {
				if (max_consec_melee > 0) {
					max_consec_melee--;
				} else {
					SetStateLabel("Missile");
				}
				A_FaceTarget();
				A_Recoil(-16);
				A_SkelWhoosh();
			}
			SKEL H 6 {
				A_FaceTarget();
				A_Recoil(-16);
			}
			SKEL I 6 {
				A_Recoil(-16);
				A_SkelFist();
			}
			Goto See;
		Missile:
			SKEL J 0 Bright {
				if (CheckSight(target)) {
					if (!CheckLOF()) {
						SetStateLabel("See");
						//A_PrintBold("Y O U ' R E  I N  M Y  W A Y . . .");
					}
				}
			}
			SKEL J 10 Bright A_FaceTarget();
			SKEL K 10 {
				A_SkelMissile_Big(); 
				max_consec_melee++;
			}
			SKEL K 10 A_FaceTarget();
			Goto See;
		Pain:
			SKEL L 5;
			SKEL L 5 A_Pain();
			Goto See;
		Death:
			SKEL LM 7;
			SKEL N 7 A_Scream();
			SKEL O 7 A_NoBlocking();
			SKEL P 7;
			SKEL Q -1;
			Stop;
		Raise:
			SKEL Q 5;
			SKEL PONML 5;
			Goto See;
	}
}
//eof