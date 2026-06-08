
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BackgroundLoad(Background ref as TBackground,cx as float,cy as float)
	
	local x as float
	local y as float
	
	Background.File.Path = "/media/gfx"
	Background.File.Name = "back.png"
	
	if FilePathSetAndCheck(Background.File) = TRUE
		Background.ImageID = LoadImage(Background.File.Name)
		if Background.ImageID > 0
			Background.SpriteID = CreateSprite(Background.ImageID)
			if Background.SpriteID
				x = GetSpriteWidth(Background.SpriteID)/2
				y = GetSpriteHeight(Background.SpriteID)/2
				SetSpriteOffset(Background.SpriteID,x,y)
				SetSpritePositionByOffset(Background.SpriteID,cx,cy)
			endif
		endif
	endif
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

function BackgroundDraw(Background ref as TBackground)

	DrawSprite(Background.SpriteID)
	
endfunction

//----------------------------------------------------------------------
//
//----------------------------------------------------------------------

