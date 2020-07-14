//ZSCRIPT GREAT GOD IMP OF JUSTICE
class ZSuperImp : Actor {
	Default {
		Health 666000;
		Radius 80;
		Height 240;
		Mass 1000;
		Speed 4;
		Scale 4;
		PainChance 0;
		Monster;
		+FLOORCLIP
		SeeSound "cyber/sight";
		PainSound "cyber/pain";
		DeathSound "cyber/death";
		ActiveSound "cyber/active";
		HitObituary "%o was erased by the great god imp.";
		Obituary "%o was purified.";
	}

	States {
		Spawn:
			TROO AB 10 A_Look();
			Loop;
		See:
			TROO AABBCCDD 3 A_Chase();
			Loop;
		Melee:
		Missile:
			TROO EF 8 A_FaceTarget();
			TROO G 6 A_SpawnProjectile("SuperImpBall", 150);
			Goto See;
		Death:
			TROO I 8;
			TROO J 8 A_Scream();
			TROO K 6;
			TROO L 6 A_NoBlocking();
			TROO M -1;
			Stop;
	}
}

class SuperImpBall : Actor {
	Default {
		Radius 32;
		Height 32;
		Speed 40;
		Damage 30;
		Scale 4;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		SeeSound "imp/attack";
		DeathSound "weapons/bfgx";
	}
	States {
		Spawn:
		BFS1 AB 4 Bright;
		Loop;
	Death:
		BFE1 ABC 8 Bright;
		BFE1 DEF 8 Bright A_Explode(256, 512);
		Stop;
	}
}