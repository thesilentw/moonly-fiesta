class ZTutorialPistol : Weapon {

	default {
		Scale 0.75;
		Radius 20;
		Height 16;	
		AttackSound "weapons/pistol";
		Obituary "%k peppered %o with a powerful ZScript pistol!";
		Inventory.Pickupmessage "Picked up a ZScript Pistol!";
		Weapon.SelectionOrder 400;
		Weapon.SlotNumber 2;
		Weapon.Kickback 100;
		Weapon.AmmoType "Clip";
		Weapon.AmmoUse 1;
		Weapon.AmmoGive 25;
	}
	
	States {
		Spawn:
			TPIP A -1;
			Loop;
		Ready:
			TPIS A 1 A_WeaponReady();
			Loop;
		Deselect:
			TPIS A 1 A_Lower();
			Loop;
		Select:
			TPIS A 1 A_Raise();
			Loop;
		Fire:
			TPIS A 1;
			TPIF A 3 A_FireBullets(3, 3, 1, 5, "BulletPuff");
			TPIS B 2;
			TPIS C 2;
			TPIS A 2 A_ReFire();
			Goto Ready;
	}
}