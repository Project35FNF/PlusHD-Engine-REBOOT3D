
local comboGone = false
local textScale = 2.3
local textX = 1280 / 2 - ((1280/2 - 70) / textScale)
local textY = 720 * 0.8
local opponentCombo = 0

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        opponentCombo = opponentCombo + 1
        if comboGone then
            doTweenX('ctt', 'aicomboText', 130, stepCrochet / 1000, 'linear');
            doTweenX('cbt', 'aicomboBG', 0, stepCrochet / 1000, 'linear');
            comboGone = false;
        end
        setTextString('aicomboText', opponentCombo .. 'x');
    end
end

function opponentNoteMissPress()
    if not comboGone then 
        aiyeetCombo()
        opponentCombo = 0
    end
end

function opponentNoteMissRelease()
    aiyeetCombo()
    opponentCombo = 0
end

function aiyeetCombo()
	doTweenX('ctt', 'aicomboText', -170, stepCrochet / 1000, 'linear');
	doTweenX('cbt', 'aicomboBG', -300, stepCrochet / 1000, 'linear');
	comboGone = true;
	opponentCombo = 0;
end

function onCreatePost()
	makeLuaSprite('aicomboBG', 'hqr/hmratings/backthing', 0, screenHeight * 0.7);
	setBlendMode('aicomboBG', 'multiply');
	setObjectCamera('aicomboBG', 'hud');
	addLuaSprite('aicomboBG');

	makeLuaText('aicomboText', '', 130, 160, getProperty('aicomboBG.y') + 30);
	addLuaText('aicomboText');
	setTextFont('aicomboText', 'bulletinyourhead.ttf');
	setTextSize('aicomboText', 43);
	setTextColor('aicomboText', '0xFFff00aa');
	setTextBorder('aicomboText', 1, '0xFF000000');
	setTextAlignment('aicomboText', 'left');
	setProperty('aicomboText.scale.x', 3);
	setProperty('aicomboText.scale.y', 3);
end
