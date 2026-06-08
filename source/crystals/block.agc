
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function ProtoBlockLoad(ProtoBlock ref as TProtoBlock)
	
	local x as float
	local y as float
	local ImageFile as TFilePath
	
	ImageFile.Path = "/media/gfx"
	ImageFile.Name = "block.png"
	
	if FilePathSetAndCheck(ImageFile) = TRUE
		ProtoBlock.ImageID = LoadImage(ImageFile.Name)
		if ProtoBlock.ImageID > 0
			ProtoBlock.SpriteID = CreateSprite(ProtoBlock.ImageID)
			if ProtoBlock.SpriteID > 0
				x = GetSpriteWidth(ProtoBlock.SpriteID)/2
				y = GetSpriteHeight(ProtoBlock.SpriteID)/2
				SetSpriteOffset(ProtoBlock.SpriteID,x,y)
			endif
		endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function ProtoBlockDraw(ProtoBlock ref as TProtoBlock,Position as TPosition,Scale as float,Angle as float)
	
	SetSpritePositionByOffset(ProtoBlock.SpriteID,Position.x,Position.y)
	SetSpriteScaleByOffset(ProtoBlock.SpriteID,Scale,Scale)
	SetSpriteAngle(ProtoBlock.SpriteID,Angle)
	DrawSprite(ProtoBlock.SpriteID)
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BlockCreate(Block ref as TBlock)
	
	local i as integer
	
	for i = 0 to Block.Array.Length
		Block.Array[i].Position.x = Block.Position.x
		Block.Array[i].Position.y = Block.Position.y - FIELDSIZE + i * FIELDSIZE
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BlockDraw(Block ref as TBlock,ProtoCrystalList ref as TProtoCrystalList)
	
	local i as integer
	local Index as integer
	local Position as TPosition
	
	for i = 0 to Block.Array.Length
		Index = Block.Array[i].ProtoCrystalIndex
		if Index >= 0
			Position = Block.Array[i].Position
			ProtoCrystalDraw(ProtoCrystalList.Array[Index],Position,1,0)
		endif
	next i
	 
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BlockGenerate(Block ref as TBlock,List ref as TProtoCrystalList,Difficulty as integer)
	
	local i as integer
	
	for i = 0 to Block.Array.Length
		Block.Array[i].ProtoCrystalIndex = random(0,List.Array.Length-1-(DIFFICULTY_MAX-Difficulty))
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BlockCopyToField(MovebleBlock ref as TMovebleBlock,Field ref as TField)
	
	local i as integer
	local x as integer
	local y as integer
	
	x = MovebleBlock.FieldPosition.x
	y = MovebleBlock.FieldPosition.y-2
	
	if y >= 0
		for i = 0 to MovebleBlock.Block.Array.Length
		
			Field.Array[x,y+i].ProtoCrystalIndex = MovebleBlock.Block.Array[i].ProtoCrystalIndex

		next i
	endif
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockInit(MovebleBlock ref as TMovebleBlock,Now as integer)
	
	MovebleBlock.BoardPosition = MovebleBlock.BasePosition
	MovebleBlock.FieldPosition.x = 3
	MovebleBlock.FieldPosition.y = -1
	MovebleBlockPositionRefresh(MovebleBlock)
	
	TimeSet(MovebleBlock.MoveTime,MOVE_TIMESPAN,MOVE_RANGE)
	TimeReset(MovebleBlock.MoveTime,Now)
	
	MovebleBlock.IsFast = FALSE
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockPositionRefresh(MovebleBlock ref as TMovebleBlock)
	
	local i as integer
	
	MovebleBlock.Block.Position = MovebleBlock.BoardPosition
	
	for i = 0 to MovebleBlock.Block.Array.Length
		MovebleBlock.Block.Array[i].Position.x = MovebleBlock.Block.Position.x
		MovebleBlock.Block.Array[i].Position.y = MovebleBlock.Block.Position.y - 63 + i * FIELDSIZE + FIELDSIZE/2
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockShuffle(MovebleBlock ref as TMovebleBlock,Now as integer)
	
	Crystal as TCrystal

	Crystal = MovebleBlock.Block.Array[2]
	MovebleBlock.Block.Array[2] = MovebleBlock.Block.Array[1]
	MovebleBlock.Block.Array[1] = MovebleBlock.Block.Array[0]
	MovebleBlock.Block.Array[0] = Crystal

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockMoveLeft(MovebleBlock ref as TMovebleBlock,Field ref as TField,Now as integer)

	if MovebleBlock.FieldPosition.x > 0
		if Field.Array[MovebleBlock.FieldPosition.x-1,MovebleBlock.FieldPosition.y+2].ProtoCrystalIndex < 0
			MovebleBlock.BoardPosition.x = MovebleBlock.BoardPosition.x - FIELDSIZE
			MovebleBlock.FieldPosition.x = MovebleBlock.FieldPosition.x - 1
		endif
	endif
	MovebleBlockPositionRefresh(MovebleBlock)

endfunction
			
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockMoveRight(MovebleBlock ref as TMovebleBlock,Field ref as TField,Now as integer)

	if MovebleBlock.FieldPosition.x < Field.Array.Length
		if Field.Array[MovebleBlock.FieldPosition.x+1,MovebleBlock.FieldPosition.y+2].ProtoCrystalIndex < 0
			MovebleBlock.BoardPosition.x = MovebleBlock.BoardPosition.x + FIELDSIZE
			MovebleBlock.FieldPosition.x = MovebleBlock.FieldPosition.x + 1
		endif
	endif
	MovebleBlockPositionRefresh(MovebleBlock)
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockMoveFast(MovebleBlock ref as TMovebleBlock)

	MovebleBlock.IsFast = TRUE

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockSpeedSet(MovebleBlock ref as TMovebleBlock,Level as integer)

	MovebleBlock.MoveSpeed = 0.025 + Floor(Level/10)*0.01 + (Level - Floor(Level/10)*10) * 0.025
	
	if MovebleBlock.IsFast = TRUE
		MovebleBlock.MoveSpeed = MovebleBlock.MoveSpeed * 2
		if MovebleBlock.MoveSpeed < 1
			MovebleBlock.MoveSpeed = 1
		endif
	endif

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockMoveDown(MovebleBlock ref as TMovebleBlock,Field ref as TField,Now as integer)
	
	local Value as integer
	
	if TimeGet(MovebleBlock.MoveTime,Now) > 0
		
		Value = MovebleBlock.MoveSpeed * MovebleBlock.MoveTime.CalcRange
		
		MovebleBlock.BoardPosition.y = MovebleBlock.BoardPosition.y + Value
		
		if MovebleBlock.BoardPosition.y > MovebleBlock.BasePosition.y + FIELDSIZE * 15 + 4
			MovebleBlock.BoardPosition.y = MovebleBlock.BasePosition.y + FIELDSIZE * 15 + 4
		endif
		
		MovebleBlock.FieldPosition.y = floor((MovebleBlock.BoardPosition.y - MovebleBlock.BasePosition.y - 4) / FIELDSIZE) -1
		
		if MovebleBlock.FieldPosition.y > Field.Array[0].Length
			MovebleBlock.FieldPosition.y = Field.Array[0].Length
		endif
		
		MovebleBlockPositionRefresh(MovebleBlock)
		
		TimeReset(MovebleBlock.MoveTime,Now)
		
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockDraw(MovebleBlock ref as TMovebleBlock,ProtoBlock ref as TProtoBlock,ProtoCrystalList ref as TProtoCrystalList,Position1 as TPosition,Position2 as TPosition)
	
	local i as integer
	
	SetSpriteScissor(ProtoBlock.SpriteID,Position1.x,Position1.y,Position2.x,Position2.y)
	
	for i = 0 to ProtoCrystalList.Array.Length
		SetSpriteScissor(ProtoCrystalList.Array[i].SpriteID,Position1.x,Position1.y,Position2.x,Position2.y)
	next i
	
	ProtoBlockDraw(ProtoBlock,MovebleBlock.Block.Position,1,0)
	BlockDraw(MovebleBlock.Block,ProtoCrystalList)
	
	SetSpriteScissor(ProtoBlock.SpriteID,0,0,0,0)
	
	for i = 0 to ProtoCrystalList.Array.Length
		SetSpriteScissor(ProtoCrystalList.Array[i].SpriteID,0,0,0,0)
	next i
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockCollide(MovebleBlock ref as TMovebleBlock,Field ref as TField)
	
	local Value as integer
	
	Value = FALSE
	
	if MovebleBlock.FieldPosition.y = Field.Array[0].Length
		if MovebleBlock.BoardPosition.y = MovebleBlock.BasePosition.y + FIELDSIZE * 15 + 4
			Value = TRUE
		endif
	else
		if MovebleBlock.FieldPosition.y >= -1
			if Field.Array[MovebleBlock.FieldPosition.x,MovebleBlock.FieldPosition.y+1].ProtoCrystalIndex >= 0
				MovebleBlock.BoardPosition.y = MovebleBlock.BasePosition.y + FIELDSIZE * (MovebleBlock.FieldPosition.y+1) + 4
				MovebleBlockPositionRefresh(MovebleBlock)
				Value = TRUE
			endif
		endif
	endif
	
endfunction Value

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function MovebleBlockOutOfBounds(MovebleBlock ref as TMovebleBlock)
	
	local Value as integer
	
	Value = FALSE
	
	if MovebleBlock.FieldPosition.y < 2
		Value = TRUE
	endif
	
endfunction Value
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------






