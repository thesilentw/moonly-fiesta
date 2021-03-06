Class Labrat : DoomPlayer {
	
	int labrat_tox_level;
	int labrat_tox_crippled;
	int labrat_tox_dead;
	
	PlayerInfo player;

	// TEST VARS - use these to test shaders, gameplay situations, etc.
	bool testRedoutShader;
	bool testGasShader;
			
	//DRUG VARS - purple, red, blue, yellow, orange, green, and white
	int damageResist; //damage threshold given when using RED
	
	default {
		Player.StartItem "Injector";
		Player.StartItem "GrenLauncher";
		Player.StartItem "Bullgut";
		Player.StartItem "ColorGun";
		Player.StartItem "Handgun";
		Player.StartItem "GrenThrower";
		Player.StartItem "Clip", 999;
		Player.StartItem "Shell", 999;
		Player.StartItem "RocketAmmo", 999;
		Player.StartItem "Cell", 999;
		Player.DisplayName "Labrat";
		//Player.ForwardMove 0.75, 0.75;
		//Player.RunHealth 15;
		//Player.SideMove 0.75, 0.75;
		Player.ViewBob 0.5;
		//Player.MaxHealth 125;
	}
	
	//setup fxns
	override void PostBeginPlay() {
		player = players[consoleplayer];
		labrat_tox_level = 0;
		labrat_tox_dead = 1000;
		labrat_tox_crippled = 50; //int(labrat_tox_dead * 0.8);
		damageResist = 0;
		
		testRedoutShader = true;
		testGasShader = false;
		
		super.PostBeginPlay();
	}	
	
	//
	//Gameplay fxns
	//
	// 
	/* ... this override doesn't work.
	override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags = 0, double angle = 0) {
		//int newdamage;
		int damagePostArmor = Super.DamageMobj(inflictor, source, damage, mod, flags, angle);
		// Deal the original damage...
		/// and now let's UNDEAL some of it. crime!!!
		if (damageResist > 0) {
			if (damagePostArmor - damageResist < 1) {
				newdamage = 1;
			}
			else {
				newdamage = damagePostArmor - damageResist;
			}
			Console.printf("DT save: %i (%i -> %i)", damageResist, damagePostArmor, newdamage);
			return newdamage; // Return the damage amount, as expected
		}
		else {
			return damagePostArmor;
		}
    }
	*/
	//override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags = 0, double angle = 0) {
	override int DamageMobj(Actor inflictor, Actor source, int damage, Name mod, int flags, double angle) {	
		int originalDamage, reducedDamage, finalDamage;
		originalDamage = damage;
		
		if (damageResist > 0) {
			reducedDamage = originalDamage - damageResist;
			
			if (reducedDamage < 1) {
				reducedDamage = 1;
			}
			
			finalDamage = reducedDamage;
			Console.printf("Resisted: %i (%i -> %i)", damageResist, originalDamage, reducedDamage);
		}
		
		else {
			finalDamage = damage;
			Console.printf("No resist. %i (%i -> %i)", damageResist, originalDamage, reducedDamage);
		}
		
		int actualDamage = super.DamageMobj(inflictor, source, finalDamage, mod, flags, angle);
		return actualDamage;
	}
	
	override void Tick() {
		super.Tick();
		
		/* PSEUDOCODE
		checkaddiction()
		
		checktoxlevel()
		
		checktimers()
			
		
		
		END PSEUDOCODE */

		if (player) {
			if (labrat_tox_level >= labrat_tox_dead) {
				// player gotta die, oops
			}
			if (labrat_tox_level >= labrat_tox_crippled) {
				Shader.SetUniform1f(player, "Redout", "mf_time", (level.totaltime / 35.0));
				Shader.SetEnabled(player, "Redout", true);
				//do crippled movement and shit
			}
			else {
				Shader.SetEnabled(player, "Redout", false);
			}
		}
		
		if (player && testGasShader) {
			Shader.SetUniform1f(player, "TearGas", "mf_time", (level.totaltime / 35.0));
			Shader.SetEnabled(player, "TearGas", true);
		}
	}
}
//eof