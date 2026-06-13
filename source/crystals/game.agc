
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameCreate(Game ref as TGame,cx as float,cy as float)
	
	local fcx as float
	local fcy as float
	local fx as float
	local fy as float
	local i as integer
	
	fcx = cx +(264-225)
	fcy = cy +(463-400)
	
	fx = cx +(264-225) -(298/2)
	fy = cy +(463-400) -(634/2)
	
	Game.FPS = CreateText("")
	SetTextPosition(Game.FPS,10,cy-200)
	SetTextSize(Game.FPS,20)
	
	Game.IsRunning = FALSE
	Game.IsPause = FALSE
	Game.IsDifficultySelect = FALSE
	Game.IsLost = FALSE
	Game.IsHighScore = TRUE
	Game.IsSummary = FALSE
	Game.IsBlockMoving = FALSE
	Game.IsFieldExploding = FALSE
	Game.IsNewHighScore = FALSE
	
	SetJoystickIndex(Game)
	
	HighScoreCreate(Game.HighScore,fcx,fcy)
	
	TimeSet(Game.InputTimer,60,1)
	TimeReset(Game.InputTimer,Game.Time.RealNow)
	
	TimeSet(Game.HighScore.AnimationTimer,MOVE_TIMESPAN,MOVE_RANGE)
	TimeReset(Game.HighScore.AnimationTimer,Game.Time.RealNow)
	TimeSet(Game.HighScore.VisibleTimer,5000,1)
	TimeReset(Game.HighScore.VisibleTimer,Game.Time.RealNow)
	TimeSet(Game.TimerSummeryText,250,1)
	TimeReset(Game.TimerSummeryText,Game.Time.RealNow)
	
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

	SummaryCreate(Game.Summary,fcx,fcy)

	Game.TextLevel = CreateText(OUTPUT_LEVEL)
	SetTextPosition(Game.TextLevel,100,17)
	SetTextSize(Game.TextLevel,20)
	SetTextBold(Game.TextLevel,1)
	SetTextAlignment(Game.TextLevel,1)
	
	Game.TextGems = CreateText(OUTPUT_GEMS)
	SetTextPosition(Game.TextGems,85,62)
	SetTextSize(Game.TextGems,20)
	SetTextBold(Game.TextGems,1)
	SetTextAlignment(Game.TextGems,1)
	
	Game.TextStart = CreateText(OUTPUT_PRESS_START)
	SetTextPosition(Game.TextStart,fcx,fcy+(634/2)-60)
	SetTextSize(Game.TextStart,32)
	SetTextBold(Game.TextStart,1)
	SetTextAlignment(Game.TextStart,1)

	Game.TextEnterName = CreateText(OUTPUT_ENTER_NAME)
	SetTextPosition(Game.TextEnterName,fcx,fcy+(634/2)-60)
	SetTextSize(Game.TextEnterName,32)
	SetTextBold(Game.TextEnterName,1)
	SetTextAlignment(Game.TextEnterName,1)

	
	Game.TextPause = CreateText(OUTPUT_PAUSE)
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
	
	Game.TextSelectDifficulty = CreateText(OUTPUT_SELECT_DIFFICULTY)
	SetTextPosition(Game.TextSelectDifficulty,fcx,fcy-125)
	SetTextSize(Game.TextSelectDifficulty,32)
	SetTextBold(Game.TextSelectDifficulty,1)
	SetTextAlignment(Game.TextSelectDifficulty,1)
	
	Game.TextUltra = CreateText(OUTPUT_ULTRA)
	SetTextPosition(Game.TextUltra,fcx,fcy-70)
	SetTextSize(Game.TextUltra,32)
	SetTextBold(Game.TextUltra,1)
	SetTextAlignment(Game.TextUltra,1)
	
	Game.TextHard = CreateText(OUTPUT_HARD)
	SetTextPosition(Game.TextHard,fcx,fcy-35)
	SetTextSize(Game.TextHard,32)
	SetTextBold(Game.TextHard,1)
	SetTextAlignment(Game.TextHard,1)
	
	Game.TextAdvanced = CreateText(OUTPUT_ADVANCED)
	SetTextPosition(Game.TextAdvanced,fcx,fcy)
	SetTextSize(Game.TextAdvanced,32)
	SetTextBold(Game.TextAdvanced,1)
	SetTextAlignment(Game.TextAdvanced,1)
	
	Game.TextMedium = CreateText(OUTPUT_MEDIUM)
	SetTextPosition(Game.TextMedium,fcx,fcy+35)
	SetTextSize(Game.TextMedium,32)
	SetTextBold(Game.TextMedium,1)
	SetTextAlignment(Game.TextMedium,1)
	
	Game.TextEasy = CreateText(OUTPUT_EASY)
	SetTextPosition(Game.TextEasy,fcx,fcy+70)
	SetTextSize(Game.TextEasy,32)
	SetTextBold(Game.TextEasy,1)
	SetTextAlignment(Game.TextEasy,1)
	
	Game.TextSelect = CreateText("______")
	SetTextPosition(Game.TextSelect,fcx,fcy+35)
	SetTextSize(Game.TextSelect,32)
	SetTextBold(Game.TextSelect,1)
	SetTextAlignment(Game.TextSelect,1)
	
	Game.HighScore.TxtHighScore = CreateText(OUTPUT_HIGHSCORE)
	SetTextPosition(Game.HighScore.TxtHighScore,fcx,fcy-8*35)
	SetTextSize(Game.HighScore.TxtHighScore,32)
	SetTextBold(Game.HighScore.TxtHighScore,1)
	SetTextAlignment(Game.HighScore.TxtHighScore,1)
	
	Game.HighScore.TxtTable = CreateText(OUTPUT_MEDIUM)
	SetTextPosition(Game.HighScore.TxtTable,fcx,fcy-7*35)
	SetTextSize(Game.HighScore.TxtTable,28)
	SetTextBold(Game.HighScore.TxtTable,1)
	SetTextAlignment(Game.HighScore.TxtTable,1)
	
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

	next i
	
	Game.TextSummaryScore = CreateText(OUTPUT_SCORE)
	SetTextPosition(Game.TextSummaryScore,fcx,fcy-225)
	SetTextSize(Game.TextSummaryScore,42)
	SetTextBold(Game.TextSummaryScore,1)
	SetTextAlignment(Game.TextSummaryScore,1)
	
	Game.TextSummaryDifficulty = CreateText(OUTPUT_MEDIUM)
	SetTextPosition(Game.TextSummaryDifficulty,fcx,fcy-175)
	SetTextSize(Game.TextSummaryDifficulty,22)
	SetTextBold(Game.TextSummaryDifficulty,1)
	SetTextAlignment(Game.TextSummaryDifficulty,1)
	
	Game.TxtSummaryScore = CreateText("0")
	SetTextPosition(Game.TxtSummaryScore,fcx,fcy-145)
	SetTextSize(Game.TxtSummaryScore,42)
	SetTextBold(Game.TxtSummaryScore,1)
	SetTextAlignment(Game.TxtSummaryScore,1)
	
	Game.TextSummaryLevel = CreateText(OUTPUT_LEVEL)
	SetTextPosition(Game.TextSummaryLevel,fcx,fcy-70)
	SetTextSize(Game.TextSummaryLevel,32)
	SetTextBold(Game.TextSummaryLevel,1)
	SetTextAlignment(Game.TextSummaryLevel,1)
	
	Game.TxtSummaryLevel = CreateText("0")
	SetTextPosition(Game.TxtSummaryLevel,fcx,fcy-35)
	SetTextSize(Game.TxtSummaryLevel,32)
	SetTextBold(Game.TxtSummaryLevel,1)
	SetTextAlignment(Game.TxtSummaryLevel,1)
	
	Game.TextSummaryGems = CreateText(OUTPUT_GEMS)
	SetTextPosition(Game.TextSummaryGems,fcx,fcy)
	SetTextSize(Game.TextSummaryGems,32)
	SetTextBold(Game.TextSummaryGems,1)
	SetTextAlignment(Game.TextSummaryGems,1)
	
	Game.TxtSummaryGems = CreateText("0")
	SetTextPosition(Game.TxtSummaryGems,fcx,fcy+35)
	SetTextSize(Game.TxtSummaryGems,32)
	SetTextBold(Game.TxtSummaryGems,1)
	SetTextAlignment(Game.TxtSummaryGems,1)
	
	Game.TextSummaryCascade = CreateText(OUTPUT_CASCADE)
	SetTextPosition(Game.TextSummaryCascade,fcx,fcy+70)
	SetTextSize(Game.TextSummaryCascade,32)
	SetTextBold(Game.TextSummaryCascade,1)
	SetTextAlignment(Game.TextSummaryCascade,1)
	
	Game.TxtSummaryCascade = CreateText("0")
	SetTextPosition(Game.TxtSummaryCascade,fcx,fcy+105)
	SetTextSize(Game.TxtSummaryCascade,32)
	SetTextBold(Game.TxtSummaryCascade,1)
	SetTextAlignment(Game.TxtSummaryCascade,1)
	
	for i = 0 to Game.TxtSummaryChar.Length
		Game.TxtSummaryChar[i] = CreateText("A")
		SetTextPosition(Game.TxtSummaryChar[i],fcx,fcy+200)
		SetTextSize(Game.TxtSummaryChar[i],42)
		SetTextBold(Game.TxtSummaryChar[i],1)
		SetTextAlignment(Game.TxtSummaryChar[i],1)
	next i
	
	Game.TxtSummerySelectChar = CreateText("_")
	SetTextPosition(Game.TxtSummerySelectChar,fcx,fcy+200)
	SetTextSize(Game.TxtSummerySelectChar,42)
	SetTextBold(Game.TxtSummerySelectChar,1)
	SetTextAlignment(Game.TxtSummerySelectChar,1)
	
	SoundInit(Game)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function GameInit(Game ref as TGame)
		
	FieldClear(Game.Field)
	BlockGenerate(Game.CurrentBlock.Block,Game.ProtoCrystalList,Game.Difficulty,Game.Level)
	BlockGenerate(Game.NextBlock,Game.ProtoCrystalList,Game.Difficulty,Game.Level)
	
	MovebleBlockInit(Game.CurrentBlock,Game.Time.RealNow)
	
	Game.Difficulty = 1
	
	Game.HighScore.Table = Game.Difficulty
	Game.HighScore.IsInit = TRUE
	Game.HighScore.IsNew = TRUE
	
	Game.AbsoluteScore = 0
	Game.CollectedScore = 0
	
	Game.Cascade = 0
	Game.HighestCascade = 0
	Game.Gems = 0
	Game.Level = 1
	
	Game.NewLevel = 1
	Game.LastLevel = 1
	
	MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
	
	SetTextString(Game.TxtGems,Str(Game.Gems))
	SetTextString(Game.TxtLevel,Str(Game.Level))
	
	SetTextString(Game.TxtAbsoluteScore,Str(Game.AbsoluteScore))
	SetTextString(Game.TxtCollectedScore,Str(Game.CollectedScore))
	SetTextString(Game.TxtCascade,Str(Game.Cascade))

	Game.IsDifficultySelect = TRUE
	Game.IsLost = FALSE
	Game.IsSummary = FALSE
	Game.IsHighScore = FALSE
	Game.IsPause = FALSE
	Game.IsBlockMoving = FALSE
	Game.IsFieldExploding = FALSE
	Game.IsNewHighScore = FALSE
	
	ExplosionReset(Game.Explosion,Game.Time.RealNow)
	
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

function GameDo(Game ref as TGame)
	
	local CountSteps as integer
	local GemCount as integer
	local Color as TColor
	local i as integer
	
	if Game.IsRunning = TRUE
		if Game.IsPause = FALSE
			
			if Game.IsBlockMoving = TRUE
				
				if MovebleBlockCollide(Game.CurrentBlock,Game.Field) = FALSE
					CountSteps = MovebleBlockMoveDown(Game.CurrentBlock,Game.Field,Game.Time.RealNow)
					TimeReset(Game.CurrentBlock.SetUpTime,Game.Time.RealNow)
					if Game.CurrentBlock.IsFast
						Game.CollectedScore = Game.CollectedScore + Ceil(CountSteps/10)
					endif
				else
					if MovebleBlockOutOfBounds(Game.CurrentBlock) = TRUE
						Game.IsRunning = FALSE
						Game.IsLost = TRUE
						Game.IsSummary = TRUE
						Game.Summary.IsInit = TRUE
						Game.HighScore.IsNew = TRUE
					else
						SoundPlay(Game.BlockDropSoundID)
						if TimeGet(Game.CurrentBlock.SetUpTime,Game.Time.RealNow) > 0
							BlockCopyToField(Game.CurrentBlock,Game.Field)
							Game.IsBlockMoving = FALSE
						endif
					endif
				endif
				
			else
				
				if Game.IsFieldExploding = FALSE
					if FieldDropCrystals(Game.Field) = FALSE
						
						GemCount = FieldCheckAll(Game.Field)
						if GemCount > 2
							Game.Gems = Game.Gems + GemCount
							Game.NewLevel = Floor(Game.Gems/(9+Ceil(Game.Level*0.25))) + 1
							if Game.NewLevel > Game.Level
								Game.LastLevel = Game.Level
								Game.Level = Game.NewLevel
								SoundPlay(Game.NextLevelSoundID)
								MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
							endif
							ExplosionReset(Game.Explosion,Game.Time.RealNow)
							Game.IsFieldExploding = TRUE
							SoundPlay(Game.ExplodeSoundID)
							Game.Cascade = Game.Cascade +1
							if Game.Cascade > 1
								ColorSet(Color,0,0,0,255)
								GetRandomColor(Color)
								SetTextColor(Game.TxtCascade,Color.Red,Color.Green,Color.Blue,Color.Alpha)
								ColorSet(Color,0,0,0,255)
								GetRandomColor(Color)
								SetTextColor(Game.TxtCollectedScore,Color.Red,Color.Green,Color.Blue,Color.Alpha)
							endif
							Game.CollectedScore = Game.CollectedScore * Game.Cascade + 0.1 * (GemCount*Game.Level)^2 * Game.Cascade
							SoundPlayPitched(Game.ScoreSoundID,1+Game.Cascade*0.1)
						else
						
								if Game.Cascade > Game.HighestCascade
									Game.HighestCascade = Game.Cascade
								endif
								
								Game.Cascade = 0
								Game.AbsoluteScore = Game.AbsoluteScore + Game.CollectedScore
								Game.CollectedScore = 0
								SetTextColor(Game.TxtCascade,255,255,255,255)
								SetTextColor(Game.TxtCollectedScore,255,255,255,255)
								
								If Game.NewLevel > Game.LastLevel
									if mod(Game.NewLevel,10) = 0
										for i = 1 to Game.NewLevel - Game.LastLevel
											if FieldLineCreateBottom(Game.Field,Game.ProtoCrystalList,Game.Difficulty) = FALSE
												Game.IsRunning = FALSE
												Game.IsLost = TRUE
												Game.Summary.IsInit = TRUE
												Game.HighScore.IsNew = TRUE
											else
												Game.LastLevel = Game.NewLevel
											endif
										next i
									else
										Game.LastLevel = Game.NewLevel
									endif
								else
									
									Game.CurrentBlock.Block = Game.NextBlock
									BlockGenerate(Game.NextBlock,Game.ProtoCrystalList,Game.Difficulty,Game.Level)
									MovebleBlockInit(Game.CurrentBlock,Game.Time.RealNow)
									Game.IsBlockMoving = TRUE
									Game.CurrentBlock.IsFast = FALSE
									MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
								
								endif
							
						endif
					endif
				else
					if FieldExplosionAnimate(Game.Field,Game.Explosion,Game.Time.RealNow) = FALSE
						Game.IsFieldExploding = FALSE
					endif
				endif
			endif
			
		endif
	else
		
		if Game.IsLost = FALSE
			HighScoreAnimate(Game.HighScore,Game.Time.RealNow)
		else
			if Game.Summary.IsInit = TRUE
				HighScoreAnimateReset(Game.HighScore)
				Game.HighScore.Table = Game.Difficulty
				SummaryEnterNameInit(Game,Game.Summary)
				if HighScoreCheck(Game.HighScore,Game.Summary)
					Game.IsNewHighScore = TRUE
				endif
			endif
		endif
		
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
				case DIFFICULTY_ULTRA
					Text = Game.TextUltra
					SetTextString(Game.TextSelect,OUTPUT_SELECTULTRA)
				endcase
				case DIFFICULTY_HARD
					Text = Game.TextHard
					SetTextString(Game.TextSelect,OUTPUT_SELECTHARD)
				endcase
				case DIFFICULTY_ADVANCED
					Text = Game.TextAdvanced
					SetTextString(Game.TextSelect,OUTPUT_SELECTADVANCED)
				endcase
				case DIFFICULTY_MEDIUM
					Text = Game.TextMedium
					SetTextString(Game.TextSelect,OUTPUT_SELECTMEDIUM)
				endcase
				case DIFFICULTY_EASY
					Text = Game.TextEasy
					SetTextString(Game.TextSelect,OUTPUT_SELECTEASY)
				endcase
			endselect
			
			x = GetTextX(Text)
			y = GetTextY(Text)
			SetTextPosition(Game.TextSelect,x,y)
			DrawText(Game.TextSelect)
			
		else
			
			if Game.IsLost = TRUE
				SetTextString(Game.TxtSummaryScore,Str(Game.Summary.AbsoluteScore))
				
				select Game.Summary.Difficulty
					case DIFFICULTY_ULTRA
						SetTextString(Game.TextSummaryDifficulty,OUTPUT_ULTRA)
					endcase
					case DIFFICULTY_HARD
						SetTextString(Game.TextSummaryDifficulty,OUTPUT_HARD)
					endcase
					case DIFFICULTY_ADVANCED
						SetTextString(Game.TextSummaryDifficulty,OUTPUT_ADVANCED)
					endcase
					case DIFFICULTY_MEDIUM
						SetTextString(Game.TextSummaryDifficulty,OUTPUT_MEDIUM)
					endcase
					case DIFFICULTY_EASY
						SetTextString(Game.TextSummaryDifficulty,OUTPUT_EASY)
					endcase
				endselect
				
				SetTextString(Game.TxtSummaryLevel,Str(Game.Summary.Level))
				SetTextString(Game.TxtSummaryGems,Str(Game.Summary.Gems))
				SetTextString(Game.TxtSummaryCascade,Str(Game.Summary.HighestCascade))
				
				Drawtext(Game.TextSummaryScore)
				Drawtext(Game.TextSummaryDifficulty)
				Drawtext(Game.TxtSummaryScore)
				Drawtext(Game.TextSummaryLevel)
				Drawtext(Game.TxtSummaryLevel)
				Drawtext(Game.TextSummaryGems)
				Drawtext(Game.TxtSummaryGems)
				Drawtext(Game.TextSummaryCascade)
				Drawtext(Game.TxtSummaryCascade)
				
				if Game.IsNewHighScore = TRUE
					
					for i = 0 to Game.TxtSummaryChar.Length
						SetTextString(Game.TxtSummaryChar[i],Game.Summary.CharList[Game.Summary.Char[i]])
						SetTextX(Game.TxtSummaryChar[i],Game.Summary.fcx-20*MAXCHARS/2+20*i)
						DrawText(Game.TxtSummaryChar[i])
					next i
					
					if TimeGet(Game.TimerSummeryText,Game.Time.RealNow) > 0
						if Game.SwitchSummeryText = TRUE
							Game.SwitchSummeryText = FALSE
						else
							Game.SwitchSummeryText = TRUE
						endif
						TimeReset(Game.TimerSummeryText,Game.Time.RealNow)
					endif
					
					if Game.SwitchSummeryText = TRUE
						SetTextX(Game.TxtSummerySelectChar,Game.Summary.fcx-20*MAXCHARS/2+20*Game.Summary.EnterCharIndex)
						DrawText(Game.TxtSummerySelectChar)
					endif
					
					Drawtext(Game.TextEnterName)
					
				else
					Drawtext(Game.TextStart)
				endif
			
			else
			
				select Game.Highscore.Table
					case TABLECASCADE
						SetTextString(Game.Highscore.TxtTable,OUTPUT_CASCADE)
					endcase
					case TABLELEVEL
						SetTextString(Game.Highscore.TxtTable,OUTPUT_LEVEL)
					endcase
					case TABLEGEMS
						SetTextString(Game.Highscore.TxtTable,OUTPUT_GEMS)
					endcase
					case DIFFICULTY_ULTRA
						SetTextString(Game.Highscore.TxtTable,OUTPUT_ULTRA)
					endcase
					case DIFFICULTY_HARD
						SetTextString(Game.Highscore.TxtTable,OUTPUT_HARD)
					endcase
					case DIFFICULTY_ADVANCED
						SetTextString(Game.Highscore.TxtTable,OUTPUT_ADVANCED)
					endcase
					case DIFFICULTY_MEDIUM
						SetTextString(Game.Highscore.TxtTable,OUTPUT_MEDIUM)
					endcase
					case DIFFICULTY_EASY
						SetTextString(Game.Highscore.TxtTable,OUTPUT_EASY)
					endcase
				endselect
				
				for i = 0 to Game.Highscore.TxtFieldsScore.Length
					Drawtext(Game.Highscore.TxtHighScore)
					Drawtext(Game.Highscore.TxtTable)
					Drawtext(Game.Highscore.TxtFieldsScore[i].TxtName)
					Drawtext(Game.Highscore.TxtFieldsScore[i].TxtScore)
				next
			
				Drawtext(Game.TextStart)
				
			endif
			
		endif
	endif
	
	Drawtext(Game.TextLevel)
	Drawtext(Game.TextGems)
		
endfunction
	
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------



