
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldClear(Field ref as TField)

	local i as integer
	local k as integer
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			
			Field.Array[i,k].ProtoCrystalIndex = -1
			Field.Array[i,k].Position.x = Field.Position.x + i*FIELDSIZE + 23
			Field.Array[i,k].Position.y = Field.Position.y + k*FIELDSIZE + 23
			
		next k
	next i

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckIndex(FieldIndex as integer,Index as integer)
	
	local Value as integer
	
	Value = FALSE
	
	if FieldIndex = Index or FieldIndex = RAINBOWINDEX
		Value = TRUE
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheck(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer,RangeX as integer,RangeY as integer)
	
	local Found as integer
	
	if x+RangeX >= 0 and X+RangeX <= Field.Array.Length and y+RangeY >= 0 and y+RangeY <= Field.Array[0].Length
		if FieldCheckIndex(Field.Array[x+RangeX,y+RangeY].ProtoCrystalIndex,Crystal.ProtoCrystalIndex) = TRUE
			Found = TRUE
		endif
	endif
	
endfunction Found

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckHorizontal(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer)
	
	local RangeX as integer
	local RangeY as integer
	local Count as integer
	local i as integer
	local PositionList as TPos[-1]
	local Position as TPos
	
	Count = 1
	RangeX = 1
	RangeY = 0
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		inc RangeX
		inc Count
	endwhile
	
	RangeX = -1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		dec RangeX
		inc Count
	endwhile
	
	if Count > 2
		Crystal.Explode = TRUE
		for i = 0 to PositionList.Length
			Field.Array[PositionList[i].x,PositionList[i].y].Explode = TRUE
		next
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckVertical(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer)
	
	local RangeX as integer
	local RangeY as integer
	local Count as integer
	local i as integer
	local PositionList as TPos[-1]
	local Position as TPos
	
	Count = 1
	RangeX = 0
	RangeY = 1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		inc RangeY
		inc Count
	endwhile
	
	RangeY = -1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		dec RangeY
		inc Count
	endwhile
	
	if Count > 2
		Crystal.Explode = TRUE
		for i = 0 to PositionList.Length
			Field.Array[PositionList[i].x,PositionList[i].y].Explode = TRUE
		next
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckDiagonalLeft(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer)
	
	local RangeX as integer
	local RangeY as integer
	local Count as integer
	local i as integer
	local PositionList as TPos[-1]
	local Position as TPos
	
	Count = 1
	RangeX = 1
	RangeY = 1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		inc RangeX
		inc RangeY
		inc Count
	endwhile
	
	RangeX = -1
	RangeY = -1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		dec RangeX
		dec RangeY
		inc Count
	endwhile
	
	if Count > 2
		Crystal.Explode = TRUE
		for i = 0 to PositionList.Length
			Field.Array[PositionList[i].x,PositionList[i].y].Explode = TRUE
		next
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckDiagonalRight(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer)
	
	local RangeX as integer
	local RangeY as integer
	local Count as integer
	local i as integer
	local PositionList as TPos[-1]
	local Position as TPos
	
	Count = 1
	RangeX = -1
	RangeY = 1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		dec RangeX
		inc RangeY
		inc Count
	endwhile
	
	RangeX = 1
	RangeY = -1
	
	while FieldCheck(Field,Crystal,x,y,RangeX,RangeY)
		Position.X = x + RangeX
		Position.Y = y + RangeY
		PositionList.Insert(Position)
		inc RangeX
		dec RangeY
		inc Count
	endwhile
	
	if Count > 2
		Crystal.Explode = TRUE
		for i = 0 to PositionList.Length
			Field.Array[PositionList[i].x,PositionList[i].y].Explode = TRUE
		next
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCountCheck(Field ref as TField)
	
	local Count as integer
	local Value as integer
	local i as integer
	local k as integer
	
	Value = 0
	Count = 0
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			if Field.Array[i,k].ProtoCrystalIndex >= 0
				if Field.Array[i,k].Explode = TRUE
					inc Value
				endif
			endif
		next k
	next i
	
	if Value > 2
		Count = Value
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldMagicCheck(Field ref as TField)
	
	local Value as integer
	local i as integer
	local k as integer

	Value = -1
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			if Field.Array[i,k].ProtoCrystalIndex = MAGICINDEX
				if k < Field.Array[0].Length
					if Field.Array[i,k+1].ProtoCrystalIndex <> MAGICINDEX
						Value = Field.Array[i,k+1].ProtoCrystalIndex
					endif
				endif
			endif
		next k
	next i
	
	if Value >= 0
		for i = 0 to Field.Array.Length
			for k = 0 to Field.Array[0].Length
				if Field.Array[i,k].ProtoCrystalIndex = Value
					Field.Array[i,k].Explode = TRUE
				endif
			next k
		next i
	endif
	
endfunction	

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckAll(Field ref as TField)
	
	local Count as integer
	local Value as integer
	local i as integer
	local k as integer
	
	Value = FALSE
	Count = 0
	
	FieldMagicCheck(Field)
	 
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			
			if Field.Array[i,k].ProtoCrystalIndex >= 0
			
				if FieldCheckHorizontal(Field,Field.Array[i,k],i,k) > 2
					Value = TRUE
				endif
				if FieldCheckVertical(Field,Field.Array[i,k],i,k) > 2
					Value = TRUE
				endif
				if FieldCheckDiagonalLeft(Field,Field.Array[i,k],i,k) > 2
					Value = TRUE
				endif
				if FieldCheckDiagonalRight(Field,Field.Array[i,k],i,k) > 2
					Value = TRUE
				endif
			
			endif
			
		next k
	next i
	
	if Value = TRUE
		Count = FieldCountCheck(Field)
	endif
	
endfunction Count

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldExplosionAnimate(Field ref as TField,Explosion ref as TExplosion,Now as integer)
	
	local Value as integer
	local i as integer
	local k as integer
	
	Value = FALSE
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			if Field.Array[i,k].Explode = TRUE
				if Explosion.Frame > Explosion.Array.Length / 2
					Field.Array[i,k].ProtoCrystalIndex = -1
				endif
				if Explosion.Frame > Explosion.Array.Length
					Field.Array[i,k].Explode = FALSE
				else
					Value = TRUE
				endif
			endif
		next k
	next i
	
	if Value = TRUE
		ExplosionAnimate(Explosion,Now)
	else	
		ExplosionReset(Explosion,Now)
	endif
		
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldDropCrystals(Field ref as TField)

	local Value as integer
	local i as integer
	local k as integer
	
	Value = FALSE
	
	for i = 0 to Field.Array.Length
		for k = Field.Array[0].Length to 0 step -1
				if k > 0
					if Field.Array[i,k].ProtoCrystalIndex = -1
						if Field.Array[i,k-1].ProtoCrystalIndex >= 0
							Field.Array[i,k].ProtoCrystalIndex = Field.Array[i,k-1].ProtoCrystalIndex
							Field.Array[i,k-1].ProtoCrystalIndex = -1
							Value = TRUE
						endif
					endif
				endif
		next k
	next i
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldLineCreate(Field ref as TField,List ref as TProtoCrystalList,Difficulty as integer,Index as integer)
	
	local i as integer
	
	for i = 0 to Field.Array.Length
		if Field.Array[i,Index].ProtoCrystalIndex = -1
			Field.Array[i,Index].ProtoCrystalIndex = random(0,List.Array.Length-1-(MAXDIFFICULTY-Difficulty+1))
		endif
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldLineCreateBottom(Field ref as TField,List ref as TProtoCrystalList,Difficulty as integer)
	
	local i as integer
	local k as integer
	local Index as integer
	local Found as integer

	Index = Field.Array[i].Length
	
	Found = FALSE
	
	for i = 0 to Field.Array.Length
		if Field.Array[i,0].ProtoCrystalIndex > -1
			Found = TRUE
		endif
	next i
	
	if Found = FALSE
		
		for i = 0 to Field.Array.Length
			for k = 1 to Field.Array[i].Length
				Field.Array[i,k-1].ProtoCrystalIndex = Field.Array[i,k].ProtoCrystalIndex
			next k
		next i
		
		for i = 0 to Field.Array.Length
				Field.Array[i,Index].ProtoCrystalIndex = random(0,List.Array.Length-1-(MAXDIFFICULTY-Difficulty+1))
		next i

	endif
	
endfunction not Found

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldDraw(Field ref as TField,ProtoCrystalList ref as TProtoCrystalList)

	local i as integer
	local k as integer
	local Index as integer
	local Position as TPosition
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			
			if Field.Array[i,k].ProtoCrystalIndex >= 0
				Index = Field.Array[i,k].ProtoCrystalIndex 
				Position = Field.Array[i,k].Position
				ProtoCrystalDraw(ProtoCrystalList.Array[Index],Position,1,0)
			endif
			
		next k
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------


