
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreGetTableNameForCookie(Index as integer)
	
	local Value as string
	
	Value = ""
	
	select Index
		case DIFFICULTY_EASY
			Value = "crystals_hs_table_easy.json"
		endcase
		case DIFFICULTY_MEDIUM
			Value = "crystals_hs_table_medium.json"
		endcase
		case DIFFICULTY_ADVANCED
			Value = "crystals_hs_table_advanced.json"
		endcase
		case DIFFICULTY_HARD
			Value = "crystals_hs_table_hard.json"
		endcase
		case DIFFICULTY_ULTRA
			Value = "crystals_hs_table_ultra.json"
		endcase
		case TABLEGEMS
			Value = "crystals_hs_table_gems.json"
		endcase
		case TABLELEVEL
			Value = "crystals_hs_table_level.json"
		endcase
		case TABLECASCADE
			Value = "crystals_hs_table_cascade.json"
		endcase
	endselect
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableSaveAsCookie(Table ref as THighScore[],TableIndex as integer)

	local JSONToBase64String as string
	local TableName as string
	
	TableName = HighScoreGetTableNameForCookie(TableIndex)
	JSONToBase64String = StringToBase64(Table.ToJSON())
	
	if Len(JSONToBase64String) < 4096 - Len(TableName)
		SaveSharedVariable(TableName,JSONToBase64String)
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreSaveAsCookie(HighScoreList ref as THighScoreList)
	
	local i as integer
	
	for i = 0 to MAXHIGHSCORETABLE
		HighScoreTableSaveAsCookie(HighScoreList.Score[i],i)
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreTableLoadFromCookie(Table ref as THighScore[],TableIndex as integer)

	local Base64JSONSString as string
	local TableName as string
	local JSONString as string
	local Value as integer
	
	Value = FALSE
	TableName = HighScoreGetTableNameForCookie(TableIndex)
	Base64JSONSString = LoadSharedVariable(TableName,"")
	if Base64JSONSString <> ""
		JSONString = Base64StringToJSON(Base64JSONSString)
		Table.Length = -1
		Table.FromJSON(JSONString)
		Value = TRUE
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function HighScoreLoadFromCookie(HighScoreList ref as THighScoreList)

	local Table as THighScore[]
	local i as integer
	local Value as integer
	local Index as integer
	
	HighScoreClear(HighScoreList)
	Value = TRUE
	
	for i = 0 to MAXHIGHSCORETABLE	
		Table.Length = -1
		if HighScoreTableLoadFromCookie(Table,i) = TRUE
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



