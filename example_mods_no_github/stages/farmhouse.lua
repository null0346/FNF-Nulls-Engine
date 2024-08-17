function onCreate()
	-- background shit
		makeLuaSprite('sky', 'sky', -600, -200);
		if not lowQuality then
		makeLuaSprite('flatgrass', 'gm_flatgrass', 350, 75);
		end
		if not lowQuality then
		makeLuaSprite('hills', 'orangey hills', -173, 100);
		end
		makeLuaSprite('farmHouse', 'funfarmhouse', 100, 125);
		makeLuaSprite('grassLand', 'grass lands', -600, 500);
		makeLuaSprite('cornFence', 'cornFence', -400, 200);
		makeLuaSprite('cornFence2', 'cornFence2', 1100, 200);
		makeLuaSprite('cornBag', 'cornbag', 1200, 550);
		makeLuaSprite('sign', 'sign', 0, 350);



	addLuaSprite('sky', false);
	if not lowQuality then
	addLuaSprite('flatgrass', false);
	end
	if not lowQuality then
	addLuaSprite('hills', false);
	end
	addLuaSprite('farmHouse', false);
	addLuaSprite('grassLand', false);
	addLuaSprite('cornFence', false);
	addLuaSprite('cornFence2', false);
	addLuaSprite('cornBag', false);
	addLuaSprite('sign', false);
end