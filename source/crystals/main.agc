
// Project: crystals 
// Created: 25-10-20

// show all errors

SetErrorMode(2)
global debug
debug = CreateText("")
SetTextPosition(debug,10,vy-50)
SetTextSize(debug,20)

// set window properties
SetWindowTitle("Cystals")

local dx as integer
local dy as integer
local wx as integer
local wy as integer
local vx as integer
local vy as integer
local cx as float
local cy as float

wx = 450
wy = 800

vx = 450
vy = 800

SetOrientationAllowed(1,0,0,0)
SetWindowSize(wx,wy,0)
SetWindowAllowResize(1)

dx = GetDeviceWidth()
dy = GetDeviceHeight()
vx = dx/(dy/vy)
cx = vx/2
cy = vy/2

SetVirtualResolution(vx,vy)

SetSyncRate(60,0)
SetScissor(0,0,0,0)
UseNewDefaultFonts(1)

#option_explicit

#constant FALSE 0
#constant TRUE 1
#constant Device$ GetDeviceBaseName()

#include "controls.agc"
#include "def_keys.agc"
#include "def_joypad.agc"
#include "def_game.agc"
#include "def_strings.agc"
#include "color.agc"
#include "file.agc"
#include "timer.agc"
#include "explosion.agc"
#include "background.agc"
#include "crystal.agc"
#include "block.agc"
#include "field.agc"
#include "summary.agc"
#include "highscore.agc"
#include "game.agc"


local FPS as integer

FPS = CreateText("")
SetTextPosition(FPS,10,vy-25)
SetTextSize(FPS,20)

local Time as TGlobalTime
local InputTimer as TTime
TimeSet(InputTimer,60,1)

local Game as TGame

Time.RealNow = GetMilliseconds()

GameCreate(Game,cx,cy,Time.RealNow)



repeat
	
	SetTextString(FPS,Str(Trunc(ScreenFPS())))
	
	Time.RealNow = GetMilliseconds()
	
	if Game.IsDifficultySelect = FALSE and Game.IsLost = FALSE
		if TimeGet(InputTimer,Time.RealNow) > 0
			//if GetRawKeyPressed(KEY_ENTER) = 1 or GetRawJoystickButtonPressed(1,joystickButtonStart) = 1
			If GetStartPressed()
                PlaySound(Game.MenuSelectSoundID)
				GameInit(Game,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
	endif
		
	if Game.IsRunning = TRUE
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetKeyPressed(KEY_P) or GetJoyPressed(joystickButtonStart)
				PlaySound(Game.MenuSelectSoundID)
				GamePause(Game)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
	endif
	
	if Game.IsRunning = TRUE and Game.IsBlockMoving = TRUE
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetKeyPressed(KEY_W) or GetKeyPressed(KEY_UP) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyY() < -0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyPressed(joystickButtonCrossUp) ) or GetJoyPressed(joystickButtonA) = 1
				MovebleBlockShuffle(Game.CurrentBlock,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetKeyPressed(KEY_A) or GetKeyPressed(KEY_LEFT) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyX() < -0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyState(joystickButtonCrossLeft) )
				MovebleBlockMoveLeft(Game.CurrentBlock,Game.Field,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetKeyPressed(KEY_D) or GetKeyPressed(KEY_RIGHT) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyX() > 0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyState(joystickButtonCrossRight) )
				MovebleBlockMoveRight(Game.CurrentBlock,Game.Field,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
			
		if TimeGet(InputTimer,Time.RealNow) > 0	
			if GetKeyPressed(KEY_S) or GetKeyPressed(KEY_DOWN) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyY() > 0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetJoyPressed(joystickButtonCrossDown) ) or GetJoyPressed(joystickButtonB) 
				MovebleBlockMoveFast(Game.CurrentBlock)
				MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
	endif
	
	if Game.IsRunning = FALSE
		if Game.IsDifficultySelect = TRUE
			
			if TimeGet(InputTimer,Time.RealNow) > 0
                //If GetUpPressed() or (TimeGet(InputTimer,Time.RealNow) > 120
				if GetKeyPressed(KEY_W) or GetKeyPressed(KEY_UP) or (TimeGet(InputTimer,Time.RealNow) > 120 and GetJoyY() < -0.5) or GetJoyPressed(joystickButtonCrossUp)
					Game.Difficulty = Game.Difficulty +1
					if Game.Difficulty > MAXDIFFICULTY
						Game.Difficulty = 0
					endif
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0	
				if GetKeyPressed(KEY_S) = 1 or GetKeyPressed(KEY_DOWN) = 1 or (TimeGet(InputTimer,Time.RealNow) > 120 and GetJoyY() > 0.5) or GetJoyPressed(joystickButtonCrossDown)
					Game.Difficulty = Game.Difficulty -1
					if Game.Difficulty < 0
						Game.Difficulty = MAXDIFFICULTY
					endif
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetKeyPressed(KEY_ENTER) or GetJoyPressed(joystickButtonA) or GetJoyPressed(joystickButtonStart)
					PlaySound(Game.MenuSelectSoundID)
					Game.IsRunning = TRUE
					TimeReset(InputTimer,Time.RealNow)
					Game.IsDifficultySelect = FALSE
					TimeReset(Game.CurrentBlock.MoveTime,Time.RealNow)
				endif
			endif
			
		endif
	endif
	
	if Game.IsRunning = FALSE
		if Game.IsLost = TRUE
					
			if Game.IsNewHighScore = TRUE
				
				if TimeGet(InputTimer,Time.RealNow) > 0
					if GetKeyPressed(KEY_W) or GetKeyPressed(KEY_UP) or (TimeGet(InputTimer,Time.RealNow) > 75 and GetJoyY() < -0.5) or GetJoyPressed(joystickButtonCrossUp)
						SummaryEnterNameShiftUp(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0	
					if GetKeyPressed(KEY_S) or GetKeyPressed(KEY_DOWN) or (TimeGet(InputTimer,Time.RealNow) > 75 and GetJoyY() > 0.5) or GetJoyPressed(joystickButtonCrossDown)
						SummaryEnterNameShiftDown(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0
					if GetKeyPressed(KEY_A) or GetKeyPressed(KEY_LEFT) or (TimeGet(InputTimer,Time.RealNow) > 75 and GetJoyX() < -0.5) or GetJoyPressed(joystickButtonCrossLeft)
						SummaryEnterNameShiftLeft(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0	
					if GetKeyPressed(KEY_D) or GetKeyPressed(KEY_RIGHT)or (TimeGet(InputTimer,Time.RealNow) > 75 and GetJoyX() > 0.5) or GetJoyPressed(joystickButtonCrossRight)
						SummaryEnterNameShiftRight(Game.Summary)				
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetKeyPressed(KEY_ENTER) or GetJoyPressed(joystickButtonA) or GetJoyPressed(joystickButtonStart)
					PlaySound(Game.MenuSelectSoundID)
					TimeReset(InputTimer,Time.RealNow)
					
					
					if Game.IsNewHighScore = TRUE
						HighScoreInsertName(Game.HighScore,Game.Summary)
					endif
					Game.IsLost = FALSE
				endif
			endif
			
		else
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetKeyPressed(KEY_A) or GetKeyPressed(KEY_LEFT) or GetJoyX() < -0.5 or GetJoyPressed(joystickButtonCrossLeft)
					HighScoreShiftLeft(Game.HighScore)
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0	
				if GetKeyPressed(KEY_D) or GetKeyPressed(KEY_RIGHT) or GetJoyX() > 0.5 or GetJoyPressed(joystickButtonCrossRight)
					HighScoreShiftRight(Game.HighScore)				
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
		endif
	endif

	GameDo(Game,Time.RealNow)

	GameDraw(Game,Time.RealNow)
	
	Drawtext(debug)
	Drawtext(FPS)
	
	Swap()
	
until GetESCPressed() or GetJoyPressed(joystickButtonBack)
