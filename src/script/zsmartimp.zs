//ZSCRIPT smart imp, maybe too smart.
class ZSmartImp : Actor {
	Default {
		Health 50;
		Radius 20;
		Height 56;
		Mass 100;
		Speed 10;
		PainChance 200;
		Monster;
		+FLOORCLIP
		SeeSound "imp/sight";
		PainSound "imp/pain";
		DeathSound "imp/death";
		ActiveSound "imp/active";
		HitObituary "%o was out-thought by a smarter-than-average imp!";
		Obituary "%o was predicted by a smart imp! Serpentine, serpentine!";
	}

	States {
		Spawn:
			TROO AB 10 A_Look();
			Loop;
		See:
			TNT1 A 0 {
				if (Random(0,2) == 0) {
					return ResolveState("Dodge");
				}
				else {
					return ResolveState("ContinueSee");
				}
			}
		ContinueSee:
			TROO AABBCCDD 2 A_Chase();
			Loop;
		Dodge:
			TROO AA 4 TDF_MonDodge();
			Goto See;
		Melee:
		Missile:
			TROO EF 6 A_FaceTarget();
			TROO G 4 TDF_LeadingProjectile("ZSmartImpBall");
			Goto See;
		Pain:
			TROO H 3 A_Pain();
			Goto See;
		Death:
			TROO I 8;
			TROO J 8 A_Scream();
			TROO K 6;
			TROO L 6 A_NoBlocking();
			TROO M -1;
			Stop;
		XDeath:
			TROO N 5;
			TROO O 5 A_XScream();
			TROO P 5;
			TROO Q 5 A_NoBlocking();
			TROO RST 5;
			TROO U -1;
			Stop;
		Raise:
			TROO ML 6;
			TROO KJI 4;
			Goto See;
	}

	action void TDF_MonDodge(int force = 8) {
    	ThrustThing(Self.angle*256/360+RandomPick(64, 192), force);
    }
    
    action void TDF_LeadingProjectile(class<Actor> mtype, double height = 32, double ofs = 0, int flags = 0) {
        let tgt  = Self.Target;
        if(!tgt) return;
        let proj = A_SpawnProjectile(mtype, height, ofs, 0.0, flags);
        if(!proj) return;
        proj.VelIntercept(tgt);
    }

}


class ZSmartImpBall : Actor {
	Default {
		Radius 8;
		Height 8;
		Speed 10; //doesn't actually matter
		Damage 6;
		Scale 1.1;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		SeeSound "imp/attack";
		DeathSound "imp/shotx";
		+SEEKERMISSILE
	}
	States {
		Spawn:
			BAL1 AB 2 Bright A_SeekerMissile(2, 5, SMF_PRECISE);
			Loop;
		Death:
			BAL1 CDE 3 Bright;
			Stop;
	}
}