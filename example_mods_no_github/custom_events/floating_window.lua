x = 0

function onStepHit()
	if curStep == 704 then
	hmm = getPropertyFromClass("openfl.Lib", "application.window.x")
	hmm2 = getPropertyFromClass("openfl.Lib", "application.window.y")

end

function onUpdate()
	if curStep == 704 then

	x = x + 1
	y = math.sin(x / 200)
	y2 = math.sin(x / 60)

	setPropertyFromClass("openfl.Lib", "application.window.x", hmm + y * 400)
	setPropertyFromClass("openfl.Lib", "application.window.y", hmm2 + y2 * 80)
end