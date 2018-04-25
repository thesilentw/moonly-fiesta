// injector class for DRUGSMOD
//
//	DRUGS
//	0 - Red - Damage Resistance
//	1 - Orange - Faster run and higher jump
//	2 - Yellow - Slow time
//	3 - Green - Health Regen
//	4 - Blue - Vision Mode (nightvision)
//	5 - White - Detox
//
//
//

Class Injector : DoomWeapon {
	
	int drugNum, drugMax;
	
	property SelectedDrug: drugNum;
	property SelectedDrugMax: drugMax;
	
	
	default {
		Injector.SelectedDrug 0;
		Injector.SelectedDrugMax 5;
		+weapon.noautofire
		+weapon.ammo_optional
		Weapon.SlotNumber 1;
		Inventory.PickupMessage "ERROR: DEFIBRILLATING ICONOCLAST.";
	}
	
	States {
		Spawn:
			TLGL A -1;
			Stop;
		Ready:
			INJC A 1 A_WeaponReady();
			Loop;
		Deselect:
			INJC A 1 A_Lower();
			Loop;
		Select: 
			INJC A 1 A_Raise();
			Loop;
		Fire:
			TNT1 A 0 {
				if (!invoker.drugNum) {
					invoker.drugNum = 0;
				}
			}
			INJC ABCDEF 3;
			INJC G 3 {
				A_Pain();
				invoker.A_StartDrugs(invoker.drugNum, invoker.owner);
			}
			INJC HI 8;
			Goto Ready;
		AltFire:
			INJC A 10 {
				invoker.drugNum++;
				if (invoker.drugNum > invoker.drugMax) invoker.drugNum = 0;
				String logstring = String.Format("Drug mode changed to %i", invoker.drugNum);
				A_PrintBold(logstring);
				Console.printf(logstring);
			}
			Goto Ready;
	}
	
	void A_StartDrugs(int passedDrug, Actor passedPlayer) {
		switch (passedDrug) {
			default:	
				String logstring = String.Format("Undefined drug %i injected", passedDrug);
				A_PrintBold(logstring);
				Console.printf(logstring);
				break;
			case 0:
				Labrat(passedPlayer).damageResist += 3;
				Labrat(passedPlayer).labrat_tox_level += 10;
				Console.printf(String.format("RED injected - Resist %i / Toxicity %i", Labrat(passedPlayer).damageResist, Labrat(passedPlayer).labrat_tox_level));
				break;
			case 5:
				Labrat(passedPlayer).labrat_tox_level -= 20;
				Labrat(passedPlayer).damageResist = 0;
				Console.printf(String.format("WHITE injected - Effects removed, Toxicity %i", Labrat(passedPlayer).labrat_tox_level));
				break;
		}
	}

}
//eof