local allowCountdown = false
local stops = 0
local resetHideHud = false
local comboGone = true
local canAdvance = false
local textScale = 2.3
local textX = 1280 / 2 - ((1280/2 - 70) / textScale)
local textY = 720 * 0.8




function goodNoteHit(id, direction, noteType, isSustainNote)
	-- miamin ratings!!!
	if not isSustainNote and resetHideHud then
		strumTime = getPropertyFromGroup('notes', id, 'strumTime');
		local rating = getRating(strumTime - getSongPosition() + getPropertyFromClass('ClientPrefs','ratingOffset'));
		objectPlayAnimation('ratingText', rating, true);
		-- BRING BACK THE COMBO COUNTER LOL!!!!
		local combo = getProperty('combo');
		if combo >= 2 then
			if comboGone then
				doTweenX('ctt', 'comboText', 420, stepCrochet / 1000, 'linear');
				doTweenX('cbt', 'comboBG', 1000, stepCrochet / 1000, 'linear');
				comboGone = false;
			end
			setTextString('comboText', combo .. 'x');
		end
	end
end

function noteMiss()
	if not comboGone then yeetCombo() end
end
function noteMissPress()
	if not comboGone then yeetCombo() end
end

function yeetCombo()
	doTweenX('ctt', 'comboText', 420, stepCrochet / 1000, 'linear');
	doTweenX('cbt', 'comboBG',  1000, stepCrochet / 1000, 'linear');
	comboGone = true;
end

function getRating(diff)
	diff = math.abs(diff);
	if diff <= getPropertyFromClass('ClientPrefs', 'badWindow') then
		if diff <= getPropertyFromClass('ClientPrefs', 'goodWindow') then
			if diff <= getPropertyFromClass('ClientPrefs', 'sickWindow') then
				return 'sick';
			end
			return 'good';
		end
		return 'bad';
	end
	return 'shit';
end


function onCreatePost()
	-- this is probably really bad practice but oh well

	resetHideHud = not hideHud;

	if isStoryMode and not seenCutscene then
		precacheImage('hqr/hmratings/dialbg');
		precacheImage('hqr/hmratings/gradblu');
		precacheImage('hqr/hmratings/gradylw');
	end

	if resetHideHud then
	

		-- make rating texts

		
		setObjectCamera('ratingText', 'hud');
		addLuaSprite('ratingText', true);
		addAnimationByPrefix('ratingText', 'shit', 'shit', 60, false);
		addAnimationByPrefix('ratingText', 'bad', 'bad', 60, false);
		addAnimationByPrefix('ratingText', 'good', 'good', 60, false);
		addAnimationByPrefix('ratingText', 'sick', 'sick', 60, false);
		addAnimationByPrefix('ratingText', 'hide', 'bad_00039', 60, false);
		objectPlayAnimation('ratingText', 'hide');
		setProperty('ratingText.antialiasing', false);
		scaleObject('ratingText', 5, 5);
		setScrollFactor('ratingText', 1, 1);
		if middlescroll then
			setProperty('ratingText.x', screenWidth * 0.35 - 375);
		end

		makeLuaSprite('comboBG', 'hqr/hmratings/backthingplayer', 1000, screenHeight * 0.7);
		if downscroll then
			setProperty('comboBG.y', 40);
		end
		setBlendMode('comboBG', 'multiply');
		setObjectCamera('comboBG', 'hud');
		addLuaSprite('comboBG');

		makeLuaText('comboText', '', 420, 160, getProperty('comboBG.y') + 30);
		addLuaText('comboText');
		setTextFont('comboText', 'bulletinyourhead.ttf');
		setTextSize('comboText', 43);
		setTextColor('comboText', '0xFFff00aa');
		setTextBorder('comboText', 1, '0xFF000000');
		setTextAlignment('comboText', 'right');
		setProperty('comboText.scale.x', 3);
		setProperty('comboText.scale.y', 3);
	end
end



-- there is no hook for playstate closing so i have to cover all exiting options!!!
-- closing the game dont matter cuz this doesnt save the pref to save data anyway

-- there is no hook for playstate closing so i have to cover all exiting options!!!
-- closing the game dont matter cuz this doesnt save the pref to save data anyway
-- the ONLY WAY this fucks up to my knowledge is if u use chart/character debug key
-- to exit playstate so those are disabled now. if u wanna use em, enable hide hud!

function onGameOver()
	if resetHideHud then
		setPropertyFromClass('ClientPrefs', 'hideHud', false);
	end
end
function onEndSong()
	if resetHideHud then
		setPropertyFromClass('ClientPrefs', 'hideHud', false);
	end
end
function onPause()
	if resetHideHud then
		setPropertyFromClass('ClientPrefs', 'hideHud', false);
	end
end
function onResume() -- lol put it back on
	if resetHideHud then
		setPropertyFromClass('ClientPrefs', 'hideHud', true);
	end
end

