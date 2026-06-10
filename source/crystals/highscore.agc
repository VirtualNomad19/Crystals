
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreCreate(HighScoreList ref as THighScoreList,fcx as float,fcy as float)
	
	HighScoreList.fcx = fcx
	HighScoreList.fcy = fcy
	
	HighScoreList.Table = 0
	HighScoreList.IsInit = TRUE
	HighScoreList.IsNew = TRUE
	
	if HighScoreLoad(HighScoreList) = FALSE
		HighScoreInit(HighScoreList)
		HighScoreSave(HighScoreList)
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
				Score.Score = k*100000*(i+1)
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
		//if HighScoreList.TxtFieldsScore.Length = HighScoreList.Score[HighScoreList.Table].Length
			for i = 0 to MAXHIGHSCOREITEMS //HighScoreList.Score[HighScoreList.Table].Length
				SetTextString(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.Score[HighScoreList.Table,i].Name)
				SetTextString(HighScoreList.TxtFieldsScore[i].TxtScore,str(HighScoreList.Score[HighScoreList.Table,i].Score))
			next i
		//endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreGetTableName(Index as integer)
	
	local Value as string
	
	Value = ""
	
	select Index
		case DIFFICULTY_EASY
			Value = "hs_table_easy.json"
		endcase
		case DIFFICULTY_MEDIUM
			Value = "hs_table_medium.json"
		endcase
		case DIFFICULTY_ADVANCED
			Value = "hs_table_advanced.json"
		endcase
		case DIFFICULTY_HARD
			Value = "hs_table_hard.json"
		endcase
		case DIFFICULTY_ULTRA
			Value = "hs_table_ultra.json"
		endcase
		case TABLEGEMS
			Value = "hs_table_gems.json"
		endcase
		case TABLELEVEL
			Value = "hs_table_level.json"
		endcase
		case TABLECASCADE
			Value = "hs_table_cascade.json"
		endcase
	endselect
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableSave(Table ref as THighScore[],TableName as string)
	
	local File as TFilePath
	
	File.Path = "/media"
	File.Name = TableName
	
	if FilePathSet(File) = TRUE
		Table.Save(File.Name)
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreSave(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	for i = 0 to MAXHIGHSCORETABLE
		HighScoreTableSave(HighScoreList.Score[i],HighScoreGetTableName(i))
	next i

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableLoad(Table ref as THighScore[],TableName as string)
	
	local File as TFilePath
	local Value as integer
	
	File.Path = "/media"
	File.Name = TableName
	
	Value = FALSE
	
	if FilePathSetAndCheck(File) = TRUE
		Table.Load(File.Name)
		if Table.Length = MAXHIGHSCOREITEMS
			Value = TRUE
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreLoad(HighScoreList ref as THighScoreList)
	
	local Table as THighScore[]
	local i as integer
	local Value as integer
	local Index as integer
	
	HighScoreClear(HighScoreList)
	Value = TRUE
	
	for i = 0 to MAXHIGHSCORETABLE	
		Table.Length = -1
		if HighScoreTableLoad(Table,HighScoreGetTableName(i)) = TRUE
			HighScoreList.Score.Insert(Table)
			Index = HighScoreList.Score.Length
			if HighScoreList.Score[Index].Length <> MAXHIGHSCOREITEMS
				//Value = FALSE
				while HighScoreList.Score[Index].Length > MAXHIGHSCOREITEMS
					HighScoreList.Score[Index].Remove(HighScoreList.Score[Index].Length)
				endwhile
			endif
		else
			VALUE = FALSE
		endif
	next i
	
endfunction Value

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
			HighScoreLoad(HighScoreList)
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

function HighScoreTableInsertName(TableName as string,NewScore ref as THighScore)

	local Value as integer
	local Table as THighScore[]
	
	if HighScoreTableLoad(Table,TableName) = TRUE
		Value = HighScoreCheckTable(Table,NewScore.Score)
		if Value > -1
			Table.Insert(NewScore,Value)
			Table.Remove(Table.Length)
			HighScoreTableSave(Table,TableName)
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreInsertName(HighScoreList ref as THighScoreList,Summary ref as TSummary)
	
	SummaryHighscoreSetName(Summary)
	
	SummaryHighscoreSetScore(Summary,Summary.Difficulty)
	if HighScoreTableInsertName(HighScoreGetTableName(Summary.Difficulty),Summary.HighScore) > -1
		HighScoreList.Table = Summary.Difficulty
	endif

	SummaryHighscoreSetScore(Summary,TABLECASCADE)
	if HighScoreTableInsertName(HighScoreGetTableName(TABLECASCADE),Summary.HighScore) > -1
		HighScoreList.Table = TABLECASCADE
	endif
	
	SummaryHighscoreSetScore(Summary,TABLELEVEL)
	if HighScoreTableInsertName(HighScoreGetTableName(TABLELEVEL),Summary.HighScore) > -1
		HighScoreList.Table = TABLELEVEL
	endif
	
	SummaryHighscoreSetScore(Summary,TABLEGEMS)
	if HighScoreTableInsertName(HighScoreGetTableName(TABLEGEMS),Summary.HighScore) > -1
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




