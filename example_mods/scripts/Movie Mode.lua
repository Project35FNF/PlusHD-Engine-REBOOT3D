function onCreate()
if (getProperty('cpuControlled') == true) then
local Strums_Texture_P = 'invisinotes'
local Notes_Texture_P = 'invisinotes'
local Strums_Texture_O = 'invisinotes'
local Notes_Texture_O = 'invisinotes'
local Splashes_Texture = 'invisisplashes'


get = getRandomInt(1,1)
function onUpdatePost(elapsed)
	if botPlay then
	 	setProperty('iconP1.alpha', 0);
		setProperty('iconP2.alpha', 0);
		setProperty('healthBar.alpha', 0);
	 setProperty('timeBar.alpha', 0);
	  setProperty('timeBarBG.alpha', 0);
	  setProperty('timeTxt.alpha', 0);
	   setProperty('scoreTxt.alpha', 0);
		setPropertyFromClass('ClientPrefs', 'noteSplashes', false)
		for i = 0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
		for i = 4,7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
		end
		
	end
  for i = 0, getProperty('opponentStrums.length')-1 do

    setPropertyFromGroup('opponentStrums', i, 'texture', Strums_Texture_O);

    if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
      setPropertyFromGroup('notes', i, 'texture', Notes_Texture_O);
    end

  end 

  for i = 0, getProperty('playerStrums.length')-1 do

    setPropertyFromGroup('playerStrums', i, 'texture', Strums_Texture_P);

    if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
      setPropertyFromGroup('notes', i, 'texture', Notes_Texture_P);
      setPropertyFromGroup('notes', i, 'noteSplashTexture', Splashes_Texture);
    end
    
  end
end
end
end
function onUpdate()
if get == 1 then
setTextString('botplayTxt', ' ')
end
end
function onEndSong() --replace in with on
    if botPlay then
        restartSong();
    end
         return Function_Stop
end
function onDestroy()
	setPropertyFromClass('ClientPrefs', 'noteSplashes', true)
	setPropertyFromClass('ClientPrefs', 'hideHud', false)
end