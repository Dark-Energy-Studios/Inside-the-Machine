extends Node2D

func update_energy(remainingEnergy:int):
	print(remainingEnergy)
	if remainingEnergy > 80:
		$Monitor/EnergyLabel.add_color_override("font_color", Color.green)
	
	if remainingEnergy <= 80:
		$Monitor/EnergyLabel.add_color_override("font_color", Color.yellow)
		
	if remainingEnergy <= 20:	
		$Monitor/EnergyLabel.add_color_override("font_color", Color.red)
	$Monitor/EnergyLabel.text = str(remainingEnergy)
