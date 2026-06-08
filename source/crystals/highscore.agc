
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreCreate(HighScoreList ref as THighScoreList,fcx as float,fcy as float)
	
	HighScoreList.fcx = fcx
	HighScoreList.fcy = fcy
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreInit(HighScoreList ref as THighScoreList)
	
	local i as integer
	local k as integer
	local Score as THighScore
	
	HighScoreList.Score.Length = DIFFICULTY_MAX-1
	
	for i = 0 to HighScoreList.Score.Length
		for k = 10 to 1 step -1
			Score.Name = "XXX"
			Score.Score = k*10000
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
	
	if HighScoreList.Difficulty <= HighScoreList.Score.Length
		if HighScoreList.TxtFieldsScore.Length = HighScoreList.Score[HighScoreList.Difficulty].Length
			for i = 0 to HighScoreList.Score[HighScoreList.Difficulty].Length
				SetTextString(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.Score[HighScoreList.Difficulty,i].Name)
				SetTextString(HighScoreList.TxtFieldsScore[i].TxtScore,str(HighScoreList.Score[HighScoreList.Difficulty,i].Score))
			next i
		endif
	endif
	
endfunction


//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreSave(HighScoreList ref as THighScoreList)
	
	local File as TFilePath
	
	File.Path = "/media"
	File.Name = "highscore.json"
	
	if FilePathSetAndCheck(File) = TRUE
		
		HighScoreList.Score.Save(File.Name)
		
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreLoad(HighScoreList ref as THighScoreList)
	
	local File as TFilePath
	
	File.Path = "/media"
	File.Name = "highscore.json"
	
	if FilePathSetAndCheck(File) = TRUE
		
		HighScoreClear(HighScoreList)
		HighScoreList.Score.Load(File.Name)
		
	else
		
		HighScoreInit(HighScoreList)
		HighScoreSave(HighScoreList)
		
	endif
	
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
			HighScoreList.Difficulty = HighScoreList.Difficulty +1
			if HighScoreList.Difficulty >= DIFFICULTY_MAX
				HighScoreList.Difficulty = 0
			endif
			for i = 0 to HighScoreList.TxtFieldsScore.Length
				SetTextX(HighScoreList.TxtFieldsScore[i].TxtName,HighScoreList.fcx+450-125+i*50)
				SetTextX(HighScoreList.TxtFieldsScore[i].TxtScore,HighScoreList.fcx+450+125+i*50)
			next i
			HighScoreSet(HighScoreList)
			HighScoreList.IsInit = FALSE
			HighScoreList.IsAnimating = TRUE
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


