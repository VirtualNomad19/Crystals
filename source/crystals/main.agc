
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
			if GetRawKeyPressed(KEY_ENTER) = 1 or GetRawJoystickButtonPressed(1,joystickButtonStart) = 1
				PlaySound(Game.MenuSelectSoundID)
				GameInit(Game,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
	endif
		
	if Game.IsRunning = TRUE
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetRawKeyPressed(KEY_P) = 1 or GetRawJoystickButtonPressed(1,joystickButtonStart) = 1
				PlaySound(Game.MenuSelectSoundID)
				GamePause(Game)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
	endif
	
	if Game.IsRunning = TRUE and Game.IsBlockMoving = TRUE
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetRawKeyPressed(KEY_W) = 1 or GetRawKeyPressed(KEY_UP) = 1 or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickY(1) < -0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickButtonPressed(1,joystickButtonCrossUp) = 1) or GetRawJoystickButtonPressed(1,joystickButtonA) = 1
				MovebleBlockShuffle(Game.CurrentBlock,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetRawKeyPressed(KEY_A) = 1 or GetRawKeyPressed(KEY_LEFT) = 1 or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickX(1) < -0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickButtonState(1,joystickButtonCrossLeft) = 1)
				MovebleBlockMoveLeft(Game.CurrentBlock,Game.Field,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
		if TimeGet(InputTimer,Time.RealNow) > 0
			if GetRawKeyPressed(KEY_D) = 1 or GetRawKeyPressed(KEY_RIGHT) = 1 or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickX(1) > 0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickButtonState(1,joystickButtonCrossRight) = 1)
				MovebleBlockMoveRight(Game.CurrentBlock,Game.Field,Time.RealNow)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
			
		if TimeGet(InputTimer,Time.RealNow) > 0	
			if GetRawKeyPressed(KEY_S) = 1 or GetRawKeyPressed(KEY_DOWN) = 1 or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickY(1) > 0.5) or (TimeGet(InputTimer,Time.RealNow) > 50 and GetRawJoystickButtonPressed(1,joystickButtonCrossDown) = 1) or GetRawJoystickButtonPressed(1,joystickButtonB) = 1
				MovebleBlockMoveFast(Game.CurrentBlock)
				MovebleBlockSpeedSet(Game.CurrentBlock,Game.Level)
				TimeReset(InputTimer,Time.RealNow)
			endif
		endif
		
	endif
	
	if Game.IsRunning = FALSE
		if Game.IsDifficultySelect = TRUE
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetRawKeyPressed(KEY_W) = 1 or GetRawKeyPressed(KEY_UP) = 1 or (TimeGet(InputTimer,Time.RealNow) > 120 and GetRawJoystickY(1) < -0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossUp) = 1
					Game.Difficulty = Game.Difficulty +1
					if Game.Difficulty > MAXDIFFICULTY
						Game.Difficulty = 0
					endif
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0	
				if GetRawKeyPressed(KEY_S) = 1 or GetRawKeyPressed(KEY_DOWN) = 1 or (TimeGet(InputTimer,Time.RealNow) > 120 and GetRawJoystickY(1) > 0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossDown) = 1
					Game.Difficulty = Game.Difficulty -1
					if Game.Difficulty < 0
						Game.Difficulty = MAXDIFFICULTY
					endif
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetRawKeyPressed(KEY_ENTER) = 1 or GetRawJoystickButtonPressed(1,joystickButtonA) = 1 or GetRawJoystickButtonPressed(1,joystickButtonStart) = 1
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
					if GetRawKeyPressed(KEY_W) = 1 or GetRawKeyPressed(KEY_UP) = 1 or (TimeGet(InputTimer,Time.RealNow) > 75 and GetRawJoystickY(1) < -0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossUp) = 1
						SummaryEnterNameShiftUp(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0	
					if GetRawKeyPressed(KEY_S) = 1 or GetRawKeyPressed(KEY_DOWN) = 1 or (TimeGet(InputTimer,Time.RealNow) > 75 and GetRawJoystickY(1) > 0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossDown) = 1
						SummaryEnterNameShiftDown(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0
					if GetRawKeyPressed(KEY_A) = 1 or GetRawKeyPressed(KEY_LEFT) = 1 or (TimeGet(InputTimer,Time.RealNow) > 75 and GetRawJoystickX(1) < -0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossLeft) = 1
						SummaryEnterNameShiftLeft(Game.Summary)
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
				
				if TimeGet(InputTimer,Time.RealNow) > 0	
					if GetRawKeyPressed(KEY_D) = 1 or GetRawKeyPressed(KEY_RIGHT) = 1 or (TimeGet(InputTimer,Time.RealNow) > 75 and GetRawJoystickX(1) > 0.5) or GetRawJoystickButtonPressed(1,joystickButtonCrossRight) = 1
						SummaryEnterNameShiftRight(Game.Summary)				
						PlaySound(Game.MenuSoundID)
						TimeReset(InputTimer,Time.RealNow)
					endif
				endif
			
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0
				if GetRawKeyPressed(KEY_ENTER) = 1 or GetRawJoystickButtonPressed(1,joystickButtonA) = 1 or GetRawJoystickButtonPressed(1,joystickButtonStart) = 1
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
				if GetRawKeyPressed(KEY_A) = 1 or GetRawKeyPressed(KEY_LEFT) = 1 or GetRawJoystickX(1) < -0.5 or GetRawJoystickButtonPressed(1,joystickButtonCrossLeft) = 1
					HighScoreShiftLeft(Game.HighScore)
					PlaySound(Game.MenuSoundID)
					TimeReset(InputTimer,Time.RealNow)
				endif
			endif
			
			if TimeGet(InputTimer,Time.RealNow) > 0	
				if GetRawKeyPressed(KEY_D) = 1 or GetRawKeyPressed(KEY_RIGHT) = 1 or GetRawJoystickX(1) > 0.5 or GetRawJoystickButtonPressed(1,joystickButtonCrossRight) = 1
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
	
until GetRawKeyPressed(Key_Escape) = 1 or GetRawJoystickButtonPressed(1,joystickButtonBack) = 1