local enabled = false -- enable it here
local fps = 60 -- set the resulting video's fps here (pro tip: dont set it above 60)
local wWidth = 1280 -- screen width
local wHeight = 720 -- screen height
local outputFile = "outputFile.mp4" -- output file name
local codec = 'libx264' -- leave this as is... but if you are using vegas pro 13 for some reason set it to mpeg2video
local addAudio = false -- usually you want to have this be set to true

function onCreate()
	luaDebugMode = true
end

function onCreatePost()
	if enabled then
		addHaxeLibrary("Application", "lime.app")
		addHaxeLibrary("Rectangle", "lime.math")
		addHaxeLibrary("Process", "sys.io")
		if addAudio then
			runHaxeCode([[
				setVar('process', new Process('ffmpeg', ['-v', 'quiet', '-y', '-f', 'rawvideo', '-pix_fmt', 'rgba', '-s', ]]..wWidth..[[ + 'x' + ]]..wHeight..[[, '-r', ]] .. fps .. [[, '-i', '-', '-i', './mods/songs/'+Paths.formatToSongPath("]]..songName..[[")+'/Inst.ogg', '-i', './mods/songs/'+Paths.formatToSongPath("]]..songName..[[")+'/Voices.ogg', '-filter_complex', '[1:a][2:a]amix=inputs=2[a]', '-map', '0:v', '-map', '[a]', '-c:v', ']]..codec..[[', '-shortest', ']]..outputFile..[[']));
			]])
		else
			runHaxeCode([[
				setVar('process', new Process('ffmpeg', ['-v', 'quiet', '-y', '-f', 'rawvideo', '-pix_fmt', 'rgba', '-s', ]]..wWidth..[[ + 'x' + ]]..wHeight..[[, '-r', ]] .. fps .. [[, '-i', '-', '-c:v', ']]..codec..[[', ']]..outputFile..[[']));
			]])
		end
		setPropertyFromClass("openfl.Lib", "application.window.width", wWidth)
		setPropertyFromClass("openfl.Lib", "application.window.height", wHeight)
		setPropertyFromClass("openfl.Lib", "application.window.title", "Beginning rendering...")
		setPropertyFromClass("flixel.FlxG", "autoPause", false)
		setPropertyFromClass("flixel.FlxG", "fixedTimestep", true)
	end
end

local nextscr = -1
function onUpdate()
	if enabled then
		t = math.floor((getSongPosition() + 5000) / (1000 / fps))
		if nextscr < t then
			nextscr = nextscr + 1
			setPropertyFromClass("openfl.Lib", "application.window.title", "Rendering frame " .. (nextscr + 1))
			renderFrame()
		end
	end
end

function onEndSong()
	if enabled then
		finish()
	end
end

function onPause()
	if enabled and nextscr >= 0 then
		finish()
	end
end

function finish()
	enabled = false
	runHaxeCode([[
		var process = getVar('process');
		process.stdin.close();
		process.close();
		Application.current.window.title = 'Finished!';
		FlxG.autoPause = ClientPrefs.autoPause;
		FlxG.fixedTimestep = false;
	]])
end

function renderFrame()
	runHaxeCode([[
		var img = Application.current.window.readPixels(new Rectangle(FlxG.scaleMode.offset.x, FlxG.scaleMode.offset.y, FlxG.scaleMode.gameSize.x, FlxG.scaleMode.gameSize.y));
		var bytes = img.getPixels(new Rectangle(0, 0, img.width, img.height));
		var process = getVar('process');
		process.stdin.writeBytes(bytes, 0, bytes.length);
		//game.addTextToDebug('hi', 0xFFFFFFFF);
	]])
end