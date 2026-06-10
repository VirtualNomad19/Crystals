
#constant FIELDSIZE 42

#constant MOVE_TIMESPAN 10
#constant MOVE_RANGE 10

#constant MAXCHARS 4

#constant MAXHIGHSCOREITEMS 9
#constant MAXHIGHSCORETABLE 7

#constant TABLECASCADE 7
#constant TABLELEVEL 6
#constant TABLEGEMS 5

#constant MAXDIFFICULTY 4

#constant DIFFICULTY_ULTRA 4
#constant DIFFICULTY_HARD 3
#constant DIFFICULTY_ADVANCED 2
#constant DIFFICULTY_MEDIUM 1
#constant DIFFICULTY_EASY 0

#constant RAINBOWINDEX 9
#constant MAGICINDEX 8

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

type TPos
	
	x as integer
	y as integer
	
endtype

type TPosition
	
	x as float
	y as float
	
endtype

type TFieldPosition
	
	x as integer
	y as integer
	
endtype

type TSound
	
	NextLevel as integer
	CrystalExplode as integer
	EarnPoints as integer
	MenuClick as integer
	
endtype

type TAnimation
	
	File as TFilePath
	ImageID as integer
	SpriteID as integer
		
endtype

type TExplosion
	
	Array as TAnimation[-1]
	
	FrameTime as TTime
	Frame as integer
	
endtype

type TProtoCrystal
	
	File as TFilePath
	ImageID as integer
	SpriteID as integer
		
endtype

type TProtoCrystalList
	
	Array as TProtoCrystal[-1]
	
endtype

type TCrystal
	
	ProtoCrystalIndex as integer
	Position as TPosition
	Explode as integer
	
endtype

type TProtoBlock
	
	ImageID as integer
	SpriteID as integer
	
endtype

type TBlock
	
	Array as TCrystal[2]
	Position as TPosition
	
endtype

type TMovebleBlock
	
	Block as TBlock
	BasePosition as TPosition
	BoardPosition as TPosition
	FieldPosition as TFieldPosition
	MoveTime as TTime
	MoveSpeed as float
	MoveRange as float
	SetUpTime as TTime
	IsFast as integer
	
endtype

type TField
	
	Array as TCrystal[6,14]
	Position as TPosition
	Position1 as TPosition
	Position2 as TPosition
	
endtype

type TBackground
	
	File as TFilePath
	ImageID as integer
	SpriteID as integer
	
endtype

type THighScore
	
	Name as string
	Score as integer
	
endtype

type TTxtHighScore

	TxtScore as integer
	TxtName as integer
	
endtype

type THighScoreList
	
	fcx as float
	fcy as float
	
	TxtHighScore as integer
	TxtTable as integer
	
	VisibleTimer as TTime
	AnimationTimer as TTime
	
	IsNew as integer
	IsInit as integer
	IsAnimating as integer
	IsPause as integer
	
	Table as integer
	
	Score as THighScore[-1,-1]
	TxtFieldsScore as TTxtHighScore[9]
	
endtype

type TSummary
	
	IsInit as integer
	
	fcx as float
	fcy as float
	
	EnterCharIndex as integer
	CharList as String[-1]
	Char as integer[MAXCHARS]
	LastChars as integer[MAXCHARS]
	HighScore as THighScore
	
	Difficulty as integer
	AbsoluteScore as integer
	Gems as integer
	Level as integer
	HighestCascade as integer
	
endtype

type TGame
	
	Sound as TSound
	
	FPS as integer
	
	IsDifficultySelect as integer
	IsLost as integer
	IsHighScore as integer
	IsRunning as integer
	IsPause as integer
	IsBlockMoving as integer
	IsFieldExploding as integer
	IsNewHighScore as integer
	
	Background as TBackground
	
	ProtoCrystalList as TProtoCrystalList
	ProtoBlock as TProtoBlock
	
	Explosion as TExplosion
	
	NextBlock as TBlock
	CurrentBlock as TMovebleBlock
	Field as TField
	
	AbsoluteScore as integer
	CollectedScore as integer
	
	Cascade as integer
	HighestCascade as integer
	Gems as integer
	Level as integer
	
	NewLevel as integer
	LastLevel as integer
	
	Difficulty as integer
	
	Highscore as THighScoreList
	Summary as TSummary
	
	TextGems as integer
	TextLevel as integer
	TextStart as integer
	TextPause as integer
	TextEnterName as integer
	
	TxtGems as integer
	TxtLevel as integer
	TxtCascade as integer
	TxtAbsoluteScore as integer
	TxtCollectedScore as integer
	
	TextSelectDifficulty as integer
	TextUltra as integer
	TextHard as integer
	TextAdvanced as integer
	TextMedium as integer
	TextEasy as integer
	
	TextSelect as integer
	
	TextSummaryScore as integer
	TxtSummaryScore as integer
	TextSummaryDifficulty as integer
	TextSummaryLevel as integer
	TxtSummaryLevel as integer
	TextSummaryGems as integer
	TxtSummaryGems as integer
	TextSummaryCascade as integer
	TxtSummaryCascade as integer
	
	TxtSummaryChar as integer[MAXCHARS]
	TxtSummerySelectChar as integer
	TimerSummeryText as TTime
	SwitchSummeryText as integer
	
	NextLevelSoundID as integer
	ExplodeSoundID as integer
	BlockSoundID as integer
	MenuSoundID as integer
	MenuSelectSoundID as integer
	ScoreSoundID as integer
	
endtype

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
