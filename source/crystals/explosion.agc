
//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------

function ExplosionLoad(Explosion ref as TExplosion)

	local i as integer
	local JsonFile as TFilePath
	local x as float
	local y as float
	local ProtoCrystal as TProtoCrystal
	
	JsonFile.Path = "/media/data"
	JsonFile.Name = "explosion.json"

	if FilePathSetAndCheck(JsonFile) = TRUE
		Explosion.Array.Load(JsonFile.Name)
		for i = 0 to Explosion.Array.Length
			
			if FilePathSetAndCheck(Explosion.Array[i].File) = TRUE
				Explosion.Array[i].ImageID = LoadImage(Explosion.Array[i].File.Name)
				if Explosion.Array[i].ImageID > 0
					Explosion.Array[i].SpriteID = CreateSprite(Explosion.Array[i].ImageID)
					if Explosion.Array[i].SpriteID > 0
						x = GetSpriteWidth(Explosion.Array[i].SpriteID)/2
						y = GetSpriteHeight(Explosion.Array[i].SpriteID)/2
						SetSpriteScaleByOffset(Explosion.Array[i].SpriteID,0.75,0.75)
						x = GetSpriteWidth(Explosion.Array[i].SpriteID)/2
						y = GetSpriteHeight(Explosion.Array[i].SpriteID)/2
						SetSpriteOffset(Explosion.Array[i].SpriteID,x,y)
						SetSpriteColor(Explosion.Array[i].SpriteID,255,255,255,255)
					endif
				endif
			endif
			
		next i
	endif

endfunction

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------

function ExplosionAnimate(Explosion ref as TExplosion,Now as integer)
	
	if TimeGet(Explosion.FrameTime,Now) > 0
		Explosion.Frame = Explosion.Frame + 1
		TimeReset(Explosion.FrameTime,Now)
	endif
	
endfunction

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------

function ExplosionDraw(Field ref as TField,Explosion ref as TExplosion)
	
	local i as integer
	local k as integer

	for i = 0 to Field.Array.Length
		for k = 0 to Field.Array[0].Length
			
			if Field.Array[i,k].Explode = TRUE
				if Explosion.Frame <= Explosion.Array.Length
					SetSpritePositionByOffset(Explosion.Array[Explosion.Frame].SpriteID,Field.Array[i,k].Position.x,Field.Array[i,k].Position.y)
					DrawSprite(Explosion.Array[Explosion.Frame].SpriteID)
				endif
			endif
			
		next k
	next i
	
	
endfunction

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------

function ExplosionReset(Explosion ref as TExplosion,Now as integer)
	
	Explosion.Frame = 0
	TimeSet(Explosion.FrameTime,12,1)
	TimeReset(Explosion.FrameTime,Now)
	
endfunction

//----------------------------------------------------------------------
// 
//----------------------------------------------------------------------


