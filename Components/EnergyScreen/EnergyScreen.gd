extends Node2D

func update_energy(remainingEnergy:int):
	if remainingEnergy > 80:
		$Monitor/EnergyLabel.add_color_override("font_color", Color.green)
		$Light2D.color = Color.green
	
	if remainingEnergy <= 80:
		$Monitor/EnergyLabel.add_color_override("font_color", Color.yellow)
		$Light2D.color = Color.yellow
		
		
	if remainingEnergy <= 20:	
		$Monitor/EnergyLabel.add_color_override("font_color", Color.red)
		$Light2D.color = Color.red
		
	$Monitor/EnergyLabel.text = str(remainingEnergy)
