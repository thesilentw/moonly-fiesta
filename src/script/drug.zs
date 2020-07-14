// drug.zsc
//
// Terry! Drug bag fuck!
//
//

class DrugManager : Inventory {

	default {
		inventory.PickupMessage "YOU SHOULD NEVER SEE THIS!";
		inventory.MaxAmount 9999;
		-inventory.PickupFlash
		-inventory.InvBar
		+inventory.untossable
	}
	
	// arrays?

}

class UsedDrug : Actor {



}





/*

Injector selects type of drug
Injector 'shoots' - tells manager to add a drug state.
manager initialzies a Drug with a duration
Drug modifies the aplyer and check its duration
	if timer < 1
		termiante and remove drug ( call manager.removedrug() )
	else if timer >= 50%
		manager.applybonus(ptr_player, drugtype)
	else if timer =< 50%
		manager.applymalus(ptr_player, drugtype)
	else 
		oh shit, terminate and raise the alarm
*/