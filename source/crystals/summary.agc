
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryCreate(Summary ref as TSummary,fcx as float,fcy as float)
	
	local i as integer
	
	Summary.fcx = fcx
	Summary.fcy = fcy
	
	Summary.CharList.Insert(" ")
	Summary.CharList.Insert("A")
	Summary.CharList.Insert("B")
	Summary.CharList.Insert("C")
	Summary.CharList.Insert("D")
	Summary.CharList.Insert("E")
	Summary.CharList.Insert("F")
	Summary.CharList.Insert("G")
	Summary.CharList.Insert("H")
	Summary.CharList.Insert("I")
	Summary.CharList.Insert("J")
	Summary.CharList.Insert("K")
	Summary.CharList.Insert("L")
	Summary.CharList.Insert("M")
	Summary.CharList.Insert("N")
	Summary.CharList.Insert("O")
	Summary.CharList.Insert("P")
	Summary.CharList.Insert("Q")
	Summary.CharList.Insert("R")
	Summary.CharList.Insert("S")
	Summary.CharList.Insert("T")
	Summary.CharList.Insert("U")
	Summary.CharList.Insert("V")
	Summary.CharList.Insert("W")
	Summary.CharList.Insert("X")
	Summary.CharList.Insert("Y")
	Summary.CharList.Insert("Z")
	Summary.CharList.Insert("0")
	Summary.CharList.Insert("1")
	Summary.CharList.Insert("2")
	Summary.CharList.Insert("3")
	Summary.CharList.Insert("4")
	Summary.CharList.Insert("5")
	Summary.CharList.Insert("6")
	Summary.CharList.Insert("7")
	Summary.CharList.Insert("8")
	Summary.CharList.Insert("9")
	Summary.CharList.Insert(".")
	Summary.CharList.Insert(",")
	Summary.CharList.Insert(":")
	Summary.CharList.Insert(";")
	Summary.CharList.Insert("-")
	Summary.CharList.Insert("+")
	Summary.CharList.Insert("*")
	Summary.CharList.Insert("/")
	Summary.CharList.Insert("\")
	Summary.CharList.Insert("(")
	Summary.CharList.Insert(")")
	Summary.CharList.Insert("[")
	Summary.CharList.Insert("]")
	Summary.CharList.Insert("{")
	Summary.CharList.Insert("}")
	Summary.CharList.Insert("_")
	Summary.CharList.Insert("§")
	Summary.CharList.Insert("$")
	Summary.CharList.Insert("%")
	Summary.CharList.Insert("&")
	Summary.CharList.Insert("!")
	Summary.CharList.Insert("?")
	Summary.CharList.Insert("#")
	Summary.CharList.Insert("~")
	Summary.CharList.Insert("=")
	Summary.CharList.Insert("^")
	Summary.CharList.Insert("°")
	Summary.CharList.Insert("<")
	Summary.CharList.Insert(">")
	Summary.CharList.Insert("|")
	
	for i = 0 to Summary.Char.Length
		Summary.Char[i] = 0
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryEnterNameInit(Game ref as TGame,Summary ref as TSummary)
	
	local i as integer
	
	Summary.EnterCharIndex = 0
	
	for i = 0 to Summary.Char.Length
		Summary.Char[i] = Summary.LastChars[i]
	next i
	
	Summary.HighScore.Name = ""
	Summary.HighScore.Score = 0
	
	Summary.Difficulty = Game.Difficulty
	Summary.HighestCascade = Game.HighestCascade
	Summary.Gems = Game.Gems
	Summary.Level = Game.Level
	Summary.AbsoluteScore = Game.AbsoluteScore

	Game.Summary.IsInit = FALSE
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
	
function SummaryHighscoreSetName(Summary ref as TSummary)
	
	local i as integer
	
	Summary.HighScore.Name = ""
	
	for i = 0 to MAXCHARS
		Summary.HighScore.Name = Summary.HighScore.Name + Summary.CharList[Summary.Char[i]]
	next i

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
	
function SummaryHighscoreSetScore(Summary ref as TSummary,Index as integer)

	select Index
		case TABLECASCADE
			Summary.HighScore.Score = Summary.HighestCascade
		endcase
		case TABLELEVEL
			Summary.HighScore.Score = Summary.Level
		endcase
		case TABLEGEMS
			Summary.HighScore.Score = Summary.Gems
		endcase
		case default
			Summary.HighScore.Score = Summary.AbsoluteScore
		endcase
	endselect

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryEnterNameShiftUp(Summary ref as TSummary)
	
	if Summary.Char[Summary.EnterCharIndex] < Summary.CharList.Length
		inc Summary.Char[Summary.EnterCharIndex]
	else
		Summary.Char[Summary.EnterCharIndex] = 0
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryEnterNameShiftDown(Summary ref as TSummary)
	
	
	if Summary.Char[Summary.EnterCharIndex] > 0
		dec Summary.Char[Summary.EnterCharIndex]
	else
		Summary.Char[Summary.EnterCharIndex] = Summary.CharList.Length
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryEnterNameShiftRight(Summary ref as TSummary)
	
	if Summary.EnterCharIndex < Summary.Char.Length
		inc Summary.EnterCharIndex
	else
		Summary.EnterCharIndex = 0
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function SummaryEnterNameShiftLeft(Summary ref as TSummary)
	
	if Summary.EnterCharIndex > 0
		dec Summary.EnterCharIndex
	else
		Summary.EnterCharIndex = Summary.Char.Length
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
