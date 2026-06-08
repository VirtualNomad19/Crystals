
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameCreate(Game ref as TGame,cx as float,cy as float,Now as integer)
	
	local fcx as float
	local fcy as float
	local fx as float
	local fy as float
	local File as TFilePath
	local i as integer
	
	fcx = cx +(264-225)
	fcy = cy +(463-400)
	
	fx = cx +(264-225) -(298/2)
	fy = cy +(463-400) -(634/2)
	
	Game.IsRunning = FALSE
	Game.IsPause = FALSE
	
	HighScoreCreate(Game.HighScore,fcx,fcy)
	Game.HighScore.Difficulty = 0
	Game.HighScore.IsInit = TRUE
	TimeSet(Game.HighScore.AnimationTimer,MOVE_TIMESPAN,MOVE_RANGE)
	TimeReset(Game.HighScore.AnimationTimer,Now)
	TimeSet(Game.HighScore.VisibleTimer,5000,MOVE_RANGE)
	TimeReset(Game.HighScore.VisibleTimer,Now)
			
	ExplosionLoad(Game.Explosion)
	
	BackgroundLoad(Game.Background,cx,cy)
	
	Game.NextBlock.Position.x = cx +(61-225)
	Game.NextBlock.Position.y = cy +(211-400)
	
	BlockCreate(Game.NextBlock)
	
	ProtoBlockLoad(Game.ProtoBlock)
	
	Game.CurrentBlock.BasePosition.x = fx + FIELDSIZE * 3 + 23
	Game.CurrentBlock.BasePosition.y = fy - 65
	
	Game.Field.Position.x = fx
	Game.Field.Position.y = fy
	
	Game.Field.Position1.x = fx
	Game.Field.Position1.y = fy
	
	Game.Field.Position2.x = fx+298
	Game.Field.Position2.y = fy+634
	
	BlockCreate(Game.CurrentBlock.Block)
	
	ProtoCrystalListLoad(Game.ProtoCrystalList)

	Game.TextLevel = CreateText("LEVEL")
	SetTextPosition(Game.TextLevel,100,17)
	SetTextSize(Game.TextLevel,20)
	SetTextBold(Game.TextLevel,1)
	SetTextAlignment(Game.TextLevel,1)
	
	Game.TextGems = CreateText("GEMS")
	SetTextPosition(Game.TextGems,85,62)
	SetTextSize(Game.TextGems,20)
	SetTextBold(Game.TextGems,1)
	SetTextAlignment(Game.TextGems,1)
	
	Game.TextStart = CreateText("PRESS START")
	SetTextPosition(Game.TextStart,fcx,fcy+(634/2)-60)
	SetTextSize(Game.TextStart,32)
	SetTextBold(Game.TextStart,1)
	SetTextAlignment(Game.TextStart,1)
	
	Game.TextPause = CreateText("PAUSE")
	SetTextPosition(Game.TextPause,fcx,fcy)
	SetTextSize(Game.TextPause,32)
	SetTextBold(Game.TextPause,1)
	SetTextAlignment(Game.TextPause,1)
		
	Game.TxtGems = CreateText("0")
	SetTextPosition(Game.TxtGems,110,81)
	SetTextSize(Game.TxtGems,20)
	SetTextBold(Game.TxtGems,1)
	SetTextAlignment(Game.TxtGems,2)
	
	Game.TxtLevel = CreateText("0")
	SetTextPosition(Game.TxtLevel,125,37)
	SetTextSize(Game.TxtLevel,20)
	SetTextBold(Game.TxtLevel,1)
	SetTextAlignment(Game.TxtLevel,1)
	
	Game.TxtAbsoluteScore = CreateText("0")
	SetTextPosition(Game.TxtAbsoluteScore,405,22)
	SetTextSize(Game.TxtAbsoluteScore,44)
	SetTextBold(Game.TxtAbsoluteScore,1)
	SetTextAlignment(Game.TxtAbsoluteScore,2)
	
	Game.TxtCollectedScore = CreateText("0")
	SetTextPosition(Game.TxtCollectedScore,335,64)
	SetTextSize(Game.TxtCollectedScore,30)
	SetTextBold(Game.TxtCollectedScore,1)
	SetTextAlignment(Game.TxtCollectedScore,2)
	
	Game.TxtCascade = CreateText("0")
	SetTextPosition(Game.TxtCascade,355,65)
	SetTextSize(Game.TxtCascade,20)
	SetTextBold(Game.TxtCascade,1)
	SetTextAlignment(Game.TxtCascade,1)	
	
	Game.TextSelectDifficulty = CreateText("SELECT DIFFICULTY")
	SetTextPosition(Game.TextSelectDifficulty,fcx,fcy-125)
	SetTextSize(Game.TextSelectDifficulty,32)
	SetTextBold(Game.TextSelectDifficulty,1)
	SetTextAlignment(Game.TextSelectDifficulty,1)
	
	Game.TextUltra = CreateText("ULTRA")
	SetTextPosition(Game.TextUltra,fcx,fcy-70)
	SetTextSize(Game.TextUltra,32)
	SetTextBold(Game.TextUltra,1)
	SetTextAlignment(Game.TextUltra,1)
	
	Game.TextHard = CreateText("HARD")
	SetTextPosition(Game.TextHard,fcx,fcy-35)
	SetTextSize(Game.TextHard,32)
	SetTextBold(Game.TextHard,1)
	SetTextAlignment(Game.TextHard,1)
	
	Game.TextAdvanced = CreateText("ADVANCED")
	SetTextPosition(Game.TextAdvanced,fcx,fcy)
	SetTextSize(Game.TextAdvanced,32)
	SetTextBold(Game.TextAdvanced,1)
	SetTextAlignment(Game.TextAdvanced,1)
	
	Game.TextMedium = CreateText("MEDIUM")
	SetTextPosition(Game.TextMedium,fcx,fcy+35)
	SetTextSize(Game.TextMedium,32)
	SetTextBold(Game.TextMedium,1)
	SetTextAlignment(Game.TextMedium,1)
	
	Game.TextEasy = CreateText("EASY")
	SetTextPosition(Game.TextEasy,fcx,fcy+70)
	SetTextSize(Game.TextEasy,32)
	SetTextBold(Game.TextEasy,1)
	SetTextAlignment(Game.TextEasy,1)
	
	Game.TextSelect = CreateText("______")
	SetTextPosition(Game.TextSelect,fcx,fcy+35)
	SetTextSize(Game.TextSelect,32)
	SetTextBold(Game.TextSelect,1)
	SetTextAlignment(Game.TextSelect,1)
	
	Game.HighScore.TxtHighScore = CreateText("HIGHSCORE")
	SetTextPosition(Game.HighScore.TxtHighScore,fcx,fcy-8*35)
	SetTextSize(Game.HighScore.TxtHighScore,32)
	SetTextBold(Game.HighScore.TxtHighScore,1)
	SetTextAlignment(Game.HighScore.TxtHighScore,1)
	
	Game.HighScore.TxtDifficulty = CreateText("MEDIUM")
	SetTextPosition(Game.HighScore.TxtDifficulty,fcx,fcy-7*35)
	SetTextSize(Game.HighScore.TxtDifficulty,32)
	SetTextBold(Game.HighScore.TxtDifficulty,1)
	SetTextAlignment(Game.HighScore.TxtDifficulty,1)
	
	for i = 0 to Game.HighScore.TxtFieldsScore.Length
	
		Game.HighScore.TxtFieldsScore[i].TxtName = CreateText("AAA")
		SetTextPosition(Game.HighScore.TxtFieldsScore[i].TxtName,fcx-125,fcy-5*35+i*35)
		SetTextSize(Game.HighScore.TxtFieldsScore[i].TxtName,32)
		SetTextBold(Game.HighScore.TxtFieldsScore[i].TxtName,1)
		SetTextAlignment(Game.HighScore.TxtFieldsScore[i].TxtName,0)
		
		Game.HighScore.TxtFieldsScore[i].TxtScore = CreateText("0")
		SetTextPosition(Game.HighScore.TxtFieldsScore[i].TxtScore,fcx+125,fcy-5*35+i*35)
		SetTextSize(Game.HighScore.TxtFieldsScore[i].TxtScore,32)
		SetTextBold(Game.HighScore.TxtFieldsScore[i].TxtScore,1)
		SetTextAlignment(Game.HighScore.TxtFieldsScore[i].TxtScore,2)

		SetTextScissor(Game.Highscore.TxtFieldsScore[i].TxtName,Game.Field.Position1.x,Game.Field.Position1.y,Game.Field.Position2.x,Game.Field.Position2.y)
		SetTextScissor(Game.Highscore.TxtFieldsScore[i].TxtScore,Game.Field.Position1.x,Game.Field.Position1.y,Game.Field.Position2.x,Game.Field.Position2.y)

	next
	
	Game.TextSummaryScore = CreateText("SCORE")
	SetTextPosition(Game.TextSummaryScore,fcx,fcy-185)
	SetTextSize(Game.TextSummaryScore,42)
	SetTextBold(Game.TextSummaryScore,1)
	SetTextAlignment(Game.TextSummaryScore,1)
	
	Game.TextSummaryDifficulty = CreateText("MEDIUM")
	SetTextPosition(Game.TextSummaryDifficulty,fcx,fcy-135)
	SetTextSize(Game.TextSummaryDifficulty,22)
	SetTextBold(Game.TextSummaryDifficulty,1)
	SetTextAlignment(Game.TextSummaryDifficulty,1)
	
	Game.TxtSummaryScore = CreateText("0")
	SetTextPosition(Game.TxtSummaryScore,fcx,fcy-105)
	SetTextSize(Game.TxtSummaryScore,42)
	SetTextBold(Game.TxtSummaryScore,1)
	SetTextAlignment(Game.TxtSummaryScore,1)
	
	Game.TextSummaryLevel = CreateText("LEVEL")
	SetTextPosition(Game.TextSummaryLevel,fcx,fcy-35)
	SetTextSize(Game.TextSummaryLevel,32)
	SetTextBold(Game.TextSummaryLevel,1)
	SetTextAlignment(Game.TextSummaryLevel,1)
	
	Game.TxtSummaryLevel = CreateText("0")
	SetTextPosition(Game.TxtSummaryLevel,fcx,fcy)
	SetTextSize(Game.TxtSummaryLevel,32)
	SetTextBold(Game.TxtSummaryLevel,1)
	SetTextAlignment(Game.TxtSummaryLevel,1)
	
	Game.TextSummaryGems = CreateText("GEMS")
	SetTextPosition(Game.TextSummaryGems,fcx,fcy+45)
	SetTextSize(Game.TextSummaryGems,32)
	SetTextBold(Game.TextSummaryGems,1)
	SetTextAlignment(Game.TextSummaryGems,1)
	
	Game.TxtSummaryGems = CreateText("GEMS")
	SetTextPosition(Game.TxtSummaryGems,fcx,fcy+80)
	SetTextSize(Game.TxtSummaryGems,32)
	SetTextBold(Game.TxtSummaryGems,1)
	SetTextAlignment(Game.TxtSummaryGems,1)
	
	File.Path = "/media/sfx"
	File.Name = "snd4.wav"
	
	if FilePathSetAndCheck(File)
		Game.NextLevelSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "snd2.wav"
	
	if FilePathSetAndCheck(File)
		Game.ExplodeSoundID = LoadSound(File.Name)
	endif
	
	File.Name = "snd3.wav"
	
	if FilePathSetAndCheck(File)
		Game.MenuSoundID = LoadSound(File.Name)
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameInit(Game ref as TGame,Now as integer)
		
	FieldClear(Game.Field)
	BlockGenerate(Game.CurrentBlock.Block,Game.ProtoCrystalList,Game.Difficulty)
	BlockGenerate(Game.NextBlock,Game.ProtoCrystalList,Game.Difficulty)
	
	MovebleBlockInit(Game.CurrentBlock,Now)
	
	Game.Difficulty = 2
	
	Game.HighScore.Difficulty = Game.Difficulty-1
	Game.HighScore.IsInit = TRUE
	
	Game.AbsoluteScore = 0
	Game.CollectedScore = 0
	
	Game.Cascade = 0
	Game.Gems = 0
	Game.Level = 1
	
	MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
	
	SetTextString(Game.TxtGems,Str(Game.Gems))
	SetTextString(Game.TxtLevel,Str(Game.Level))
	
	SetTextString(Game.TxtAbsoluteScore,Str(Game.AbsoluteScore))
	SetTextString(Game.TxtCollectedScore,Str(Game.CollectedScore))
	SetTextString(Game.TxtCascade,Str(Game.Cascade))

	Game.IsDifficultySelect = TRUE
	Game.IsLost = FALSE
	Game.IsRunning = FALSE
	Game.IsPause = FALSE
	Game.IsBlockMoving = TRUE
	Game.IsFieldExploding = FALSE
	
	ExplosionReset(Game.Explosion,Now)
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GamePause(Game ref as TGame)
	
	if Game.IsRunning = TRUE
		if Game.IsPause = TRUE
			Game.IsPause = FALSE
		else
			Game.IsPause = TRUE
		endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameDo(Game ref as TGame,Now as integer)
	
	local CountSteps as integer
	local GemCount as integer
	local NewLevel as integer
	local Color as TColor
	
	if Game.IsRunning = TRUE
		if Game.IsPause = FALSE
			
			if Game.IsBlockMoving = TRUE
				
				if MovebleBlockCollide(Game.CurrentBlock,Game.Field) = FALSE
					CountSteps = MovebleBlockMoveDown(Game.CurrentBlock,Game.Field,Now)
					TimeReset(Game.CurrentBlock.SetUpTime,Now)
					if Game.CurrentBlock.IsFast
						Game.CollectedScore = Game.CollectedScore + Ceil(CountSteps/10)
					endif
				else
					if MovebleBlockOutOfBounds(Game.CurrentBlock) = TRUE
						Game.IsRunning = FALSE
						Game.IsLost = TRUE
					else
						if TimeGet(Game.CurrentBlock.SetUpTime,Now) > 0						
							BlockCopyToField(Game.CurrentBlock,Game.Field)
							Game.IsBlockMoving = FALSE
						endif
					endif
				endif
			else
				if Game.IsFieldExploding = FALSE
					if FieldDropCrystals(Game.Field) = FALSE
						
						GemCount = FieldCheck(Game.Field)
						if GemCount > 0
							Game.Gems = Game.Gems + GemCount
							NewLevel = Floor(Game.Gems/(9+Ceil(Game.Level*0.25))) + 1
							if NewLevel > Game.Level
								Game.Level = NewLevel
								PlaySound(Game.NextLevelSoundID)
								MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
							endif
							ExplosionReset(Game.Explosion,Now)
							Game.IsFieldExploding = TRUE
							PlaySound(Game.ExplodeSoundID)
							Game.Cascade = Game.Cascade +1
							if Game.Cascade > 1
								ColorSet(Color,0,0,0,255)
								GetRandomColor(Color)
								SetTextColor(Game.TxtCascade,Color.Red,Color.Green,Color.Blue,Color.Alpha)
								ColorSet(Color,0,0,0,255)
								GetRandomColor(Color)
								SetTextColor(Game.TxtCollectedScore,Color.Red,Color.Green,Color.Blue,Color.Alpha)
							endif
							Game.CollectedScore = Game.CollectedScore * Game.Cascade + (GemCount*Game.Level)^2 * Game.Cascade
						else
							Game.CurrentBlock.Block = Game.NextBlock
							BlockGenerate(Game.NextBlock,Game.ProtoCrystalList,Game.Difficulty)
							MovebleBlockInit(Game.CurrentBlock,Now)
							Game.IsBlockMoving = TRUE
							Game.CurrentBlock.IsFast = FALSE
							MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
							Game.Cascade = 0
							Game.AbsoluteScore = Game.AbsoluteScore + Game.CollectedScore
							Game.CollectedScore = 0
							SetTextColor(Game.TxtCascade,255,255,255,255)
							SetTextColor(Game.TxtCollectedScore,255,255,255,255)
						endif
					endif
				else
					if FieldExplosionAnimate(Game.Field,Game.Explosion,Now) = FALSE
						Game.IsFieldExploding = FALSE
					endif
				endif
			endif
			
		endif
	else
		HighScoreAnimate(Game.HighScore,Now)
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameDraw(Game ref as TGame)
	
	local Text as integer
	local x as float
	local y as float
	local i as integer
	
	BackgroundDraw(Game.Background)
		
	if Game.IsRunning = TRUE
		
		BlockDraw(Game.NextBlock,Game.ProtoCrystalList)
		FieldDraw(Game.Field,Game.ProtoCrystalList)
		if Game.IsBlockMoving = TRUE
			MovebleBlockDraw(Game.CurrentBlock,Game.ProtoBlock,Game.ProtoCrystalList,Game.Field.Position1,Game.Field.Position2)
		endif
		if Game.IsFieldExploding = TRUE
			ExplosionDraw(Game.Field,Game.Explosion)
		endif
		
		if Game.IsPause = TRUE
			Drawtext(Game.TextPause)
		endif
		
		SetTextString(Game.TxtGems,Str(Game.Gems))
		SetTextString(Game.TxtLevel,Str(Game.Level))
		
		SetTextString(Game.TxtAbsoluteScore,Str(Game.AbsoluteScore))
		SetTextString(Game.TxtCollectedScore,Str(Game.CollectedScore))
		SetTextString(Game.TxtCascade,Str(Game.Cascade))
	
		Drawtext(Game.TxtLevel)
		Drawtext(Game.TxtGems)
		
		Drawtext(Game.TxtAbsoluteScore)
		Drawtext(Game.TxtCollectedScore)
		Drawtext(Game.TxtCascade)
		
	else
		if Game.IsDifficultySelect = TRUE
			
			Drawtext(Game.TextSelectDifficulty)
			
			Drawtext(Game.TextUltra)
			Drawtext(Game.TextHard)
			Drawtext(Game.TextAdvanced)
			Drawtext(Game.TextMedium)
			Drawtext(Game.TextEasy)
			
			select Game.Difficulty
				case 5
					Text = Game.TextUltra
					SetTextString(Game.TextSelect,"_______")
				endcase
				case 4
					Text = Game.TextHard
					SetTextString(Game.TextSelect,"______")
				endcase
				case 3
					Text = Game.TextAdvanced
					SetTextString(Game.TextSelect,"___________")
				endcase
				case 2
					Text = Game.TextMedium
					SetTextString(Game.TextSelect,"_________")
				endcase
				case 1
					Text = Game.TextEasy
					SetTextString(Game.TextSelect,"_____")
				endcase
			endselect
			
			x = GetTextX(Text)
			y = GetTextY(Text)
			SetTextPosition(Game.TextSelect,x,y)
			DrawText(Game.TextSelect)
			
		else
			
			if Game.IsLost = TRUE
				SetTextString(Game.TxtSummaryScore,Str(Game.AbsoluteScore))
				
				select Game.Difficulty
					case 5
						SetTextString(Game.TextSummaryDifficulty,GetTextString(Game.TextUltra))
					endcase
					case 4
						SetTextString(Game.TextSummaryDifficulty,GetTextString(Game.TextHard))
					endcase
					case 3
						SetTextString(Game.TextSummaryDifficulty,GetTextString(Game.TextAdvanced))
					endcase
					case 2
						SetTextString(Game.TextSummaryDifficulty,GetTextString(Game.TextMedium))
					endcase
					case 1
						SetTextString(Game.TextSummaryDifficulty,GetTextString(Game.TextEasy))
					endcase
				endselect
				
				SetTextString(Game.TxtSummaryLevel,Str(Game.Level))
				SetTextString(Game.TxtSummaryGems,Str(Game.Gems))
				Drawtext(Game.TextSummaryScore)
				Drawtext(Game.TextSummaryDifficulty)
				Drawtext(Game.TxtSummaryScore)
				Drawtext(Game.TextSummaryLevel)
				Drawtext(Game.TxtSummaryLevel)
				Drawtext(Game.TextSummaryGems)
				Drawtext(Game.TxtSummaryGems)
			
			else
			
				select Game.Highscore.Difficulty
					case 4
						SetTextString(Game.Highscore.TxtDifficulty,GetTextString(Game.TextUltra))
					endcase
					case 3
						SetTextString(Game.Highscore.TxtDifficulty,GetTextString(Game.TextHard))
					endcase
					case 2
						SetTextString(Game.Highscore.TxtDifficulty,GetTextString(Game.TextAdvanced))
					endcase
					case 1
						SetTextString(Game.Highscore.TxtDifficulty,GetTextString(Game.TextMedium))
					endcase
					case 0
						SetTextString(Game.Highscore.TxtDifficulty,GetTextString(Game.TextEasy))
					endcase
				endselect
				
				for i = 0 to Game.Highscore.TxtFieldsScore.Length
					Drawtext(Game.Highscore.TxtHighScore)
					Drawtext(Game.Highscore.TxtDifficulty)
					Drawtext(Game.Highscore.TxtFieldsScore[i].TxtName)
					Drawtext(Game.Highscore.TxtFieldsScore[i].TxtScore)
				next
			
			endif
			
			Drawtext(Game.TextStart)
		endif
	endif
	
	Drawtext(Game.TextLevel)
	Drawtext(Game.TextGems)
		
endfunction
	
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



