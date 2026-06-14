
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreCreate(HighScoreList ref as THighScoreList,fcx as float,fcy as float)
	
	HighScoreList.fcx = fcx
	HighScoreList.fcy = fcy
	
	HighScoreList.Table = 0
	HighScoreList.IsInit = TRUE
	HighScoreList.IsNew = TRUE
	
	if Device$ = "windows"
		if HighScoreLoad(HighScoreList) = FALSE
			HighScoreInit(HighScoreList)
			HighScoreSave(HighScoreList)
		endif
	endif
	
	if Device$ = "html5"
		if HighScoreLoadFromCookie(HighScoreList) = FALSE
			HighScoreInit(HighScoreList)
			HighScoreSaveAsCookie(HighScoreList)
		endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreInit(HighScoreList ref as THighScoreList)
	
	local i as integer
	local k as integer
	local Score as THighScore
	
	HighScoreClear(HighScoreList)
	
	HighScoreList.Score.Length = MAXHIGHSCORETABLE
	
	for i = 0 to HighScoreList.Score.Length
		for k = MAXHIGHSCOREITEMS+1 to 1 step -1
			Score.Name = "XXX"
			if i <= MAXDIFFICULTY
				Score.Score = k*10000*(i+1)
			else
				if i = TABLEGEMS then Score.Score = k*1000
				if i = TABLELEVEL then Score.Score = k*10
				if i = TABLECASCADE then Score.Score = k*2
			endif			
			HighScoreList.Score[i].Insert(Score)
		next k
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreClear(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	for i = 0 to HighScoreList.Score.Length
		HighScoreList.Score[i].Length = -1
	next i
	
	HighScoreList.Score.Length = -1
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreSet(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	if HighScoreList.Table <= HighScoreList.Score.Length
		for i = 0 to MAXHIGHSCOREITEMS
			SetTextString(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.Score[HighScoreList.Table,i].Name)
			SetTextString(HighScoreList.TxtFieldsScore[i].TxtScore,str(HighScoreList.Score[HighScoreList.Table,i].Score))
		next i
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreAnimateReset(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	for i = 0 to HighScoreList.TxtFieldsScore.Length
		SetTextX(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.fcx+450-125+i*50)
		SetTextX(HighScoreList.TxtFieldsScore[i].TxtScore,HighScoreList.fcx+450+125+i*50)
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreAnimate(HighScoreList ref as THighScoreList,Now as integer)
	
	local i as integer
	
	if TimeGet(HighScoreList.AnimationTimer,Now)
		TimeReset(HighScoreList.AnimationTimer,Now)
		if HighScoreList.IsInit = TRUE
			
			if Device$ = "windows"
				HighScoreLoad(HighScoreList)
			endif
			
			if Device$ = "html5"
				HighScoreLoadFromCookie(HighScoreList)
			endif
			
			if HighScoreList.IsNew = FALSE
				inc HighScoreList.Table
			endif
			
			if HighScoreList.Table > MAXHIGHSCORETABLE
				HighScoreList.Table = 0
			endif
			
			HighScoreAnimateReset(HighScoreList)
			HighScoreSet(HighScoreList)
			HighScoreList.IsInit = FALSE
			HighScoreList.IsNew = FALSE
			HighScoreList.IsAnimating = TRUE
			TimeReset(HighScoreList.VisibleTimer,Now)
			
		else
			if HighScoreList.IsAnimating = TRUE			
				for i = 0 to HighScoreList.TxtFieldsScore.Length
					SetTextX(HighScoreList.TxtFieldsScore[i].TxtName,GetTextX(HighScoreList.TxtFieldsScore[i].TxtName)-HighScoreList.AnimationTimer.CalcRange)
					SetTextX(HighScoreList.TxtFieldsScore[i].TxtScore,GetTextX(HighScoreList.TxtFieldsScore[i].TxtScore)-HighScoreList.AnimationTimer.CalcRange)
					if GetTextX(HighScoreList.TxtFieldsScore[i].TxtName) < HighScoreList.fcx-125
						SetTextX(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.fcx-125)
					endif
					if GetTextX(HighScoreList.TxtFieldsScore[i].TxtScore) < HighScoreList.fcx+125
						SetTextX(HighScoreList.TxtFieldsScore[i].TxtScore,HighScoreList.fcx+125)
					endif
				next i
				if GetTextX(HighScoreList.TxtFieldsScore[HighScoreList.TxtFieldsScore.Length].TxtName) = HighScoreList.fcx-125
					HighScoreList.IsAnimating = FALSE
					HighScoreList.IsPause = TRUE
					TimeReset(HighScoreList.VisibleTimer,Now)
				endif
			else
				if HighScoreList.IsPause = TRUE
					if TimeGet(HighScoreList.VisibleTimer,Now)
						TimeReset(HighScoreList.VisibleTimer,Now)
						HighScoreList.IsPause = FALSE
						HighScoreList.IsInit = TRUE
					endif
				endif
			endif
		endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreCheckTable(Table ref as THighScore[],Score as integer)

	local Found as integer
	local Value as integer
	local i as integer
	
	Value = -1
	
	i = Table.Length
	Found = TRUE
	while Found = TRUE and i <= Table.Length
		if Score > Table[i].Score
			Value = i
			dec i
		else
			Found = FALSE
		endif
	endwhile
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreCheck(HighScoreList ref as THighScoreList,Summary ref as TSummary)
	
	local Value as integer
	
	Value = FALSE
	
	if HighScoreCheckTable(HighScoreList.Score[Summary.Difficulty],Summary.AbsoluteScore) >= 0 then Value = TRUE
	if HighScoreCheckTable(HighScoreList.Score[TABLEGEMS],Summary.Gems) >= 0 then Value = TRUE
	if HighScoreCheckTable(HighScoreList.Score[TABLELEVEL],Summary.Level) >= 0 then Value = TRUE
	if HighScoreCheckTable(HighScoreList.Score[TABLECASCADE],Summary.HighestCascade) >= 0 then Value = TRUE

endfunction Value



//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableInsertName(TableIndex as integer,NewScore ref as THighScore)

	local Value as integer
	local Table as THighScore[]

	if Device$ = "windows"
		if HighScoreTableLoad(Table,TableIndex) = TRUE
			Value = HighScoreCheckTable(Table,NewScore.Score)
			if Value > -1
				Table.Insert(NewScore,Value)
				Table.Remove(Table.Length)
				HighScoreTableSave(Table,TableIndex)
			endif
		endif
	endif
	
	if Device$ = "html5"
		if HighScoreTableLoadFromCookie(Table,TableIndex) = TRUE
			Value = HighScoreCheckTable(Table,NewScore.Score)
			if Value > -1
				Table.Insert(NewScore,Value)
				Table.Remove(Table.Length)
				HighScoreTableSaveAsCookie(Table,TableIndex)
			endif
		endif
	endif
				
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreInsertName(HighScoreList ref as THighScoreList,Summary ref as TSummary)
	
	SummaryHighscoreSetName(Summary)
	
	SummaryHighscoreSetScore(Summary,Summary.Difficulty)
	if HighScoreTableInsertName(Summary.Difficulty,Summary.HighScore) > -1
		HighScoreList.Table = Summary.Difficulty
	endif

	SummaryHighscoreSetScore(Summary,TABLECASCADE)
	if HighScoreTableInsertName(TABLECASCADE,Summary.HighScore) > -1
		HighScoreList.Table = TABLECASCADE
	endif
	
	SummaryHighscoreSetScore(Summary,TABLELEVEL)
	if HighScoreTableInsertName(TABLELEVEL,Summary.HighScore) > -1
		HighScoreList.Table = TABLELEVEL
	endif
	
	SummaryHighscoreSetScore(Summary,TABLEGEMS)
	if HighScoreTableInsertName(TABLEGEMS,Summary.HighScore) > -1
		HighScoreList.Table = TABLEGEMS
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreShiftLeft(HighScoreList ref as THighScoreList)

	if HighScoreList.Table > 0
		dec HighScoreList.Table
	else
		HighScoreList.Table = MAXHIGHSCORETABLE
	endif
	
	HighScoreList.IsInit = TRUE
	HighScoreList.IsNew = TRUE
	HighScoreList.IsPause = FALSE
	HighScoreList.IsAnimating = FALSE
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreShiftRight(HighScoreList ref as THighScoreList)	

	if HighScoreList.Table < MAXHIGHSCORETABLE
		inc HighScoreList.Table
	else
		HighScoreList.Table = 0
	endif
	
	HighScoreList.IsInit = TRUE
	HighScoreList.IsNew = TRUE
	HighScoreList.IsPause = FALSE
	HighScoreList.IsAnimating = FALSE
		
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------




