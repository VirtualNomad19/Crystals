
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

function FieldCheckHorizontal(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer,Range as integer,Value as integer)
	
	local Found as integer
	
	Found = FALSE
	/*
	if x-Range >= 0
		if Field.Array[x-Range,y].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	*/
	if x+Range <= Field.Array.Length
		if Field.Array[x+Range,y].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	
	if Found = TRUE
		Value = FieldCheckHorizontal(Field,Crystal,x,y,Range+1,Value)
	endif
	
	if Value > 2
		Crystal.Explode = TRUE
		/*
		if x-Range >= 0
			if Field.Array[x-Range,y].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x-Range,y].Explode = TRUE
			endif
		endif
		*/
		if x+Range <= Field.Array.Length
			if Field.Array[x+Range,y].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x+Range,y].Explode = TRUE
			endif
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckVertical(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer,Range as integer,Value as integer)
	
	local Found as integer
	
	Found = FALSE
	/*
	if y-Range >= 0
		if Field.Array[x,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	*/
	if y+Range <= Field.Array[0].Length
		if Field.Array[x,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	
	if Found = TRUE
		Value = FieldCheckVertical(Field,Crystal,x,y,Range+1,Value)
	endif
	
	if Value > 2
		Crystal.Explode = TRUE
		/*
		if y-Range >= 0
			if Field.Array[x,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x,y-Range].Explode = TRUE
			endif
		endif
		*/
		if y+Range <= Field.Array[0].Length
			if Field.Array[x,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x,y+Range].Explode = TRUE
			endif
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckDiagonalLeft(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer,Range as integer,Value as integer)
	
	local Found as integer
	
	Found = FALSE
	/*
	if x-Range >= 0 and y-Range >= 0
		if Field.Array[x-Range,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	*/
	if x+Range <= Field.Array.Length and y+Range <= Field.Array[0].Length
		if Field.Array[x+Range,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	
	if Found = TRUE
		Value = FieldCheckDiagonalLeft(Field,Crystal,x,y,Range+1,Value)
	endif
	
	if Value > 2
		Crystal.Explode = TRUE
		/*
		if x-Range >= 0 and y-Range >= 0
			if Field.Array[x-Range,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x-Range,y-Range].Explode = TRUE
			endif
		endif
		*/
		if x+Range <= Field.Array.Length and y+Range <= Field.Array[0].Length
			if Field.Array[x+Range,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x+Range,y+Range].Explode = TRUE
			endif
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function FieldCheckDiagonalRight(Field ref as TField,Crystal ref as TCrystal,x as integer,y as integer,Range as integer,Value as integer)
	
	local Found as integer
	
	Found = FALSE
	/*
	if x-Range >= 0 and y+Range <= Field.Array[0].Length
		if Field.Array[x-Range,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	*/
	if x+Range <= Field.Array.Length and y-Range >= 0
		if Field.Array[x+Range,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
			Value = Value + 1
			Found = TRUE
		endif
	endif
	
	if Found = TRUE
		Value = FieldCheckDiagonalRight(Field,Crystal,x,y,Range+1,Value)
	endif
	
	if Value > 2
		Crystal.Explode = TRUE
		/*
		if x-Range >= 0 and y+Range <= Field.Array[0].Length
			if Field.Array[x-Range,y+Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x-Range,y+Range].Explode = TRUE
			endif
		endif
		*/
		if x+Range <= Field.Array.Length and y-Range >= 0
			if Field.Array[x+Range,y-Range].ProtoCrystalIndex = Crystal.ProtoCrystalIndex
				Field.Array[x+Range,y-Range].Explode = TRUE
			endif
		endif
	endif
	
endfunction Value

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
					Value = Value +1
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

function FieldCheck(Field ref as TField)
	
	local Count as integer
	local Value as integer
	local i as integer
	local k as integer
	
	Value = FALSE
	Count = 0
	
	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			
			if Field.Array[i,k].ProtoCrystalIndex >= 0
			
				if FieldCheckHorizontal(Field,Field.Array[i,k],i,k,1,1) > 2
					Value = TRUE
				endif
				if FieldCheckVertical(Field,Field.Array[i,k],i,k,1,1) > 2
					Value = TRUE
				endif
				if FieldCheckDiagonalLeft(Field,Field.Array[i,k],i,k,1,1) > 2
					Value = TRUE
				endif
				if FieldCheckDiagonalRight(Field,Field.Array[i,k],i,k,1,1) > 2
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


