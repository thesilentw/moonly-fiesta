/// axe.zsc
///
///

Class Axe : MFWeapon {
	default {
		inventory.pickupMessage "Yow. Where's Shia LaBoeuf?";
		//weapon.slotNumber 1;
		//weapon.SelectionOrder 1000;
		//+WEAPON.AMMO_OPTIONAL;
		Weapon.BobStyle "Alpha";
		Weapon.BobRangeX 1.5;
		Weapon.BobRangeY 0.5;
		+WEAPON.NODEATHINPUT;;
		+WEAPON.MELEEWEAPON
		+WEAPON.NOALERT
	}
	
	States {
		Ready:
			SUAX A 1 A_WeaponReady();
			Loop;
		Select:
			SUAX A 1 A_Raise();
			Loop;
		Deselect:
			SUAX A 1 A_Lower();
			Loop;
		Fire:
			TNT1 A 1 A_Overlay(777, "SwingOverlay");
			TNT1 A 20; 
			TNT1 A 16 A_CustomPunch((50 + Random(0,50)), true, range: 96);
			TNT1 A 1 A_ClearOverlays(776,778);
			SUAX A 1 A_WeaponReady();
			Goto Ready;
		SwingOverlay:	
			SUAX A 5 A_OverlayOffset(777, 0, 32, WOF_INTERPOLATE);
			SUAX A 5 A_OverlayOffset(777, 6, 32, WOF_INTERPOLATE);
			SUAX A 5 A_OverlayOffset(777, 12, 32, WOF_INTERPOLATE);
			SUAX A 4 A_OverlayOffset(777, 48, 32, WOF_INTERPOLATE);
			SUAX A 3 A_OverlayOffset(777, 50, 32, WOF_INTERPOLATE);
			SUAX B 3 A_OverlayOffset(777, -72, 32, WOF_INTERPOLATE);
			SUAX C 3 A_OverlayOffset(777, -132, 32, WOF_INTERPOLATE);
			SUAX D 3 A_OverlayOffset(777, -192, 32, WOF_INTERPOLATE);
			SUAX E 3 A_OverlayOffset(777, -232, 32, WOF_INTERPOLATE);	
		Spawn:
			TLGL A -1;
			Stop;
	}
}