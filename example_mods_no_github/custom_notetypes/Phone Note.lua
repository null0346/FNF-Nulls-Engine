function opponentNoteHit(id, dir, noteType, sus)
    if noteType == 'Phone Note' and not sus then
        characterPlayAnim('dad', 'pre-attack')
        setProperty('dad.specialAnim', true)
    end
end
function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Blammed Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Phone Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_Phone'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has penalties
			end
		end
	end
	--debugPrint('Script started!')
end