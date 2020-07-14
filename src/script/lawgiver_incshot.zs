// LawgiverINCShot
// for keeping the incendiary shot and all of its complex methods out of the main file
//
class LawgiverINCShot : FastProjectile {
	default {
		Obituary "%o felt the burning sensation of a Hotshot round from %k's Lawgiver.";
		Decal "DoomImpScorch";
		Radius 4;
		Height 4;
		Speed 75;
		Damage 0;
		Scale 0.5;
		Projectile;
		+RANDOMIZE
		+ROCKETTRAIL    
		explosionradius 32;
		explosiondamage 45;
		damagetype "Fire";
		SeeSound "weapons/rocklf";
		DeathSound "weapons/rocklx";
	}
	// flaregun rip start here
	States {
	Spawn:
		MISL A 0 Bright A_LoopActiveSound();
		MISL ABC 1 Bright;
		MISL ABC 1 Bright;
		MISL AAA 0 A_SpawnProjectile("Flaretrail",0,0,random(0,360),2,random(-90,90));
		Loop;
	Death:
		MISL A 0 A_Explode();
		MISL A 0 A_RadiusGive("SetActorOnFire",32,RGF_MONSTERS,1);
		MISL A 1 Bright;
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		stop;
	XDeath:
		MISL A 0 A_Explode();
		MISL A 0 A_RadiusGive("SetActorOnFire",32,RGF_MONSTERS,1);
		MISL A 1 Bright;
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		TNT1 AAAAAAAAAAAAAAAAAAAAAAAAA 0 A_SpawnItemEx("Flaretrail",0,0,10,random(-4,4),random(-4,4),random(-4,4),random(1,360));
		stop;
	}
   // end flaregun rip
}

// +++ FIRE STUFF +++
class Flaretrail : Actor {
	default {
		health 5;
		radius 1;
		height 1;
		Speed 10;
		PROJECTILE;
		+NOBLOCKMAP
		+DONTSPLASH
		+RANDOMIZE
		-NOGRAVITY
		-SOLID
		Scale 0.1;
		translation "176:191=32:47","208:223=16:31";
	}
	states {
		Spawn:
			FSPK A 0 bright A_Jump(192,3,4,6,8);
			FSPK A 10 bright;
			FSPK A 200 bright A_LowGravity();
			stop;
			FSPK B 10 bright;
			FSPK B 200 bright A_LowGravity();
			stop;
			FSPK C 10 bright;
			FSPK C 200 bright A_LowGravity();
			stop;
			FSPK D 10 bright;
			FSPK D 200 bright A_LowGravity();
			stop;
			FSPK E 10 bright;
			FSPK E 200 bright A_LowGravity();
			stop;
		Death:
			FSPK A 1;
			stop;
	}
}

// Setting on fire of actors taken from TerminusEst13's High Noon Drifter.
class SetActorOnFire : CustomInventory {
    States {
		Pickup:
			TNT1 AAAAAAAAAA 0 A_SpawnItemEx("FireTexturesOnActorWithLifetime",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_SETTRACER);
			TNT1 AAAAAAAAAA 0 A_SpawnItemEx("FireTexturesOnActorWithLifetime",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_SETTRACER);
			TNT1 A 0 A_SpawnItemEx("ActorOnFire",0,0,0,0,0,0,0,SXF_NOCHECKPOSITION | SXF_SETTRACER);
			stop;
    }
}

// Setting on fire of actors taken from TerminusEst13's High Noon Drifter.
class ActorOnFire : Actor {
    int lifetimer;
    int burntime;
    int burntics;

    default {
        +NOBLOCKMAP
        +DONTGIB
    }

    override void BeginPlay() {
        burntics = 0;
        burntime = 350; // Ten seconds
    }

    States {
		Spawn:
		SpawnLoop:
			TNT1 A 2;
			TNT1 A 0 {
				statelabel nextstate = "SpawnLoop";
				if (tracer == NULL) {
					return ResolveState("Death2");
				}
				if (tracer.health <= 0) {
					return ResolveState("Death");
				}
				A_Warp(AAPTR_TRACER);
				A_SpawnItemEx("FireTexturesOnActor",frandom(-tracer.radius, tracer.radius) / 1.5,frandom(-tracer.radius, tracer.radius) / 1.5,frandom(24, tracer.height),frandom(-0.5,0.5),frandom(-0.5,0.5),frandom(0.25,1.0),0,SXF_NOCHECKPOSITION);
				A_SpawnItemEx("FireTexturesOnActor",frandom(-tracer.radius, tracer.radius) / 1.5,frandom(-tracer.radius, tracer.radius) / 1.5,frandom(24, tracer.height),frandom(-0.5,0.5),frandom(-0.5,0.5),frandom(0.25,1.0),0,SXF_NOCHECKPOSITION);
				tracer.bFRIGHTENED = 1;
				lifetimer++;
				burntics++;
				if (lifetimer >= burntime) {
					nextstate = "Death";
				}
				if (burntics >= 10) { 
					A_DamageTracer(random(1,5),"Fire", DMSS_NOFACTOR | DMSS_NOPROTECT);
					// The fire doesn't burn with heat! It burns with VIOLENCE.
					// Even enemies immune to fire should be set on fire and burn anyway.
					burntics = 0;
				}
				return ResolveState(nextstate);
			}
			stop;
		Death:
			TNT1 A 0 {
				tracer.bFRIGHTENED = 0;
			}
			stop;
		Death2:
			TNT1 A 0;
			stop;
    }
}

// Setting on fire of actors taken from TerminusEst13's High Noon Drifter.
class FireTexturesOnActorWithLifetime : Actor {
    float randomx, randomy, randomz;
    int lifetime, lifecheck;
    int chance;

    default {
        Radius 2;
        Height 2;
        Scale 0.75;
        Alpha 0.99;
        RenderStyle "Add";
        +NOBLOCKMAP;
        +NOGRAVITY;
        +FORCEXYBILLBOARD
    }

    override void BeginPlay() {
        lifecheck = 0;
        lifetime = 700;
    }

    States {
		Spawn:
			TNT1 A 1;
			TNT1 A 0 {
				if (tracer == NULL) { return ResolveState("SpawnEnd"); }
				if (tracer.health > 0) {
					randomx = frandom((-tracer.radius / 1.5), (tracer.radius / 1.5));
					randomy = frandom((-tracer.radius / 1.5), (tracer.radius / 1.5));
					randomz = frandom(16, (tracer.height - 8));
					if (chance == 1) { A_SetScale(scale.x + frandom(-0.15,0.15),scale.y + frandom(-0.15,0.15)); }
					if (chance == 2) { A_SetScale(-scale.x + frandom(-0.15,0.15),scale.y + frandom(-0.15,0.15)); }
				}
				else { return ResolveState("SpawnEnd"); }
				return ResolveState(Null);
			}
		SpawnLoop:
			CFCF ABCDEFGEHIJKLM 1 BRIGHT {
			   if (tracer == NULL) { return ResolveState("SpawnEnd"); }
			   A_Warp(AAPTR_TRACER,randomx,randomy,randomz,0,WARPF_NOCHECKPOSITION | WARPF_INTERPOLATE);
			   lifecheck++;
			   if (lifecheck >= lifetime) { return ResolveState("SpawnEnd"); }
			   if (tracer.health <= 0) { return ResolveState("SpawnEnd"); }
			   return ResolveState(Null);
			}
			loop;
		SpawnEnd:
			CFCF NOP 1 Bright;
			stop;
    }
}

// Setting on fire of actors taken from TerminusEst13's High Noon Drifter.
class FireTexturesOnActor : Actor {
    int chance;

    default {
        Radius 2;
        Height 2;
        Scale 0.2;
        Alpha 0.99;
        RenderStyle "Add";
        +FORCEXYBILLBOARD
        +NOINTERACTION
    }

    States {
    Spawn:
        FLML A 1 BRIGHT {
            chance = random(1,2);
            if (chance == 1) { A_SetScale(scale.x + frandom(-0.05,0.05),scale.y + frandom(-0.05,0.05)); }
            if (chance == 2) { A_SetScale(-scale.x + frandom(-0.05,0.05),scale.y + frandom(-0.05,0.05)); }
        }
    SpawnLoop:
        FLML ABCDE 2 BRIGHT {
           A_FadeOut(0.025);
           A_SetScale(scale.x - 0.005,scale.y - 0.005);
           A_SetTics(random(1,3));
        }
        loop;
    }
} 
//eof