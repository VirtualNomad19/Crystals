
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function ProtoCrystalListLoad(List ref as TProtoCrystalList)

	local i as integer
	local JsonFile as TFilePath
	local x as float
	local y as float
	local ProtoCrystal as TProtoCrystal
	
	JsonFile.Path = "/media/data"
	JsonFile.Name = "crystal.json"

	if FilePathSetAndCheck(JsonFile) = TRUE
		List.Array.Load(JsonFile.Name)
		for i = 0 to List.Array.Length
			
			if FilePathSetAndCheck(List.Array[i].File) = TRUE
				List.Array[i].ImageID = LoadImage(List.Array[i].File.Name)
				if List.Array[i].ImageID > 0
					List.Array[i].SpriteID = CreateSprite(List.Array[i].ImageID)
					if List.Array[i].SpriteID > 0
						x = GetSpriteWidth(List.Array[i].SpriteID)/2
						y = GetSpriteHeight(List.Array[i].SpriteID)/2
						SetSpriteOffset(List.Array[i].SpriteID,x,y)
					endif
				endif
			endif
			
		next i
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function ProtoCrystalDraw(ProtoCrystal ref as TProtoCrystal,Position as TPosition,Scale as float,Angle as float)
	
	SetSpritePositionByOffset(ProtoCrystal.SpriteID,Position.x,Position.y)
	SetSpriteScaleByOffset(ProtoCrystal.SpriteID,Scale,Scale)
	SetSpriteAngle(ProtoCrystal.SpriteID,Angle)
	DrawSprite(ProtoCrystal.SpriteID)

endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
