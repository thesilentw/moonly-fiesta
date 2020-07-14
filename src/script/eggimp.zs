class EggImp : DoomImp {
	States {
		Missile:
			TROO EF 8 A_FaceTarget();
			TROO G 6 A_EggAttack();
			Goto Super::See;
	}
}

class EggBall : MorphProjectile {	
	Default {
		Radius 6;
		Height 8;
		Speed 10;
		FastSpeed 20;
		Damage 3;
		Projectile;
		+RANDOMIZE
		+ZDOOMTRANS
		RenderStyle "Add";
		Alpha 1;
		SeeSound "imp/attack";
		MorphProjectile.PlayerClass "ChickenPlayer";
		MorphProjectile.MonsterClass "Chicken";
	}
	States {
		Spawn:
			EGGM ABCDE 4;
			Loop;
		Death:
			FX01 FFGH 3;
			Stop;
	}
}

extend class EggImp {
	void A_EggAttack() {
		let targ = target;
		if (targ) {
			SpawnMissile (targ, "EggBall");
		}
	}
}