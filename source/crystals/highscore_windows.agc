
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

function HighScoreTableSave(Table ref as THighScore[],TableIndex as integer)
	
	local File as TFilePath
	
	File.Path = "/media"
	File.Name = HighScoreGetTableName(TableIndex)
	
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
		HighScoreTableSave(HighScoreList.Score[i],i)
	next i

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableLoad(Table ref as THighScore[],TableName as integer)
	
	local File as TFilePath
	local Value as integer
	
	File.Path = "/media"
	File.Name = HighScoreGetTableName(TableName)
	
	Value = FALSE
	
	Table.Length = -1
	
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
		if HighScoreTableLoad(Table,i) = TRUE
			HighScoreList.Score.Insert(Table)
			Index = HighScoreList.Score.Length
			if HighScoreList.Score[Index].Length <> MAXHIGHSCOREITEMS
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

