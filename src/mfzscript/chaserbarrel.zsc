class chaserBarrel : Actor replaces ExplosiveBarrel {
  
	default {
		Speed 1;
		Health 20;
		Radius 10;
		Height 34;
		MaxStepHeight 9999;
		MaxDropOffHeight 9999;
		MONSTER;
		-COUNTKILL
		+AMBUSH
		-CANUSEWALLS
		-CANPUSHWALLS
		-ACTIVATEMCROSS
		+LOOKALLAROUND
		//+NEVERRESPAWN   // ahahahahahahahah
		+NOTARGETSWITCH
		//+NOTARGET
		//+NOINFIGHTING
		+NOFEAR
		+CANTSEEK
		+SEEINVISIBLE
		+DONTMORPH
		+NOBLOOD
		+NOBLOODDECALS
		+DONTGIB
		+NOICEDEATH
		+TOUCHY
		DeathSound "world/barrelx";
		Obituary "...%o could have SWORN that barrel was farther away.";
	}
  
	States {
		Spawn:
			BAR1 AB 6 A_Look();
			Loop;
		See:
			TNT1 A 0 A_JumpIfInTargetLOS("Seen", 170);
			BAR1 A 3 A_Chase();
			TNT1 A 0 A_JumpIfInTargetLOS("Seen", 170);
			BAR1 A 3 A_Chase();
			//
			TNT1 A 0 A_JumpIfInTargetLOS("Seen", 170);
			BAR1 B 3 A_Chase();
			TNT1 A 0 A_JumpIfInTargetLOS("Seen", 170);
			BAR1 B 3 A_Chase();
			//
			Goto See;
		Seen:
			BAR1 AB 6;
			TNT1 A 0 A_JumpIfInTargetLOS("Seen", 170);
			Goto See;
		Death:
			BEXP A 5 BRIGHT;
			BEXP B 5 BRIGHT A_Scream();
			BEXP C 5 BRIGHT;
			BEXP D 5 BRIGHT A_Explode();
			BEXP E 10 BRIGHT;
			BEXP E 1050 BRIGHT A_BarrelDestroy();
			BEXP E 5 A_Respawn();
			Wait;
  }
}