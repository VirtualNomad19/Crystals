
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundInit(Game ref as TGame)
	
	local File as TFilePath
	
	File.Path = "/media/sfx"
	
	File.Name = "sndnextlvl.wav"
	
	if FilePathSetAndCheck(File)
		Game.NextLevelSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndexplode.wav"
	
	if FilePathSetAndCheck(File)
		Game.ExplodeSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndblockfall.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockFallSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndblockdrop.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockDropSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndshuffle.wav"
	
	if FilePathSetAndCheck(File)
		Game.BlockShuffleSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndmenu.wav"
	
	if FilePathSetAndCheck(File)
		Game.MenuSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndmenuselect.wav"
	
	if FilePathSetAndCheck(File)
		Game.MenuSelectSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "sndscore.wav"
	
	if FilePathSetAndCheck(File)
		Game.ScoreSoundID = LoadSound(File.Name)
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundPlayPitched(SoundID as integer,Rate as integer)
	
	local Value as integer
	
	if GetSoundExists(SoundID) = 1
		if GetSoundMinRate() < Rate and GetSoundMaxRate() > Rate
			SetSoundInstanceRate(SoundID,Rate)
		else
			SetSoundInstanceRate(SoundID,1)
		endif
		Value = PlaySound(SoundID)
	endif

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SoundPlay(SoundID as integer)
	
	local Value as integer
	
	SoundPlayPitched(SoundID,1)

endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------





