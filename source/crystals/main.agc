
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

#constant Device$ GetDeviceBaseName()

#constant FALSE 0
#constant TRUE 1

#include "def_keys.agc"
#include "def_joypad.agc"
#include "def_game.agc"
#include "def_strings.agc"
#include "color.agc"
#include "file.agc"
#include "timer.agc"
#include "sound.agc"
#include "explosion.agc"
#include "background.agc"
#include "crystal.agc"
#include "block.agc"
#include "field.agc"
#include "summary.agc"
#include "highscore_html.agc"
#include "highscore_windows.agc"
#include "highscore.agc"
#include "game.agc"
#include "workflow.agc"
#include "controls.agc"
#include "input.agc"

local Game as TGame

GameCreate(Game,cx,cy)

repeat
	
	SetTextString(Game.FPS,Str(Trunc(ScreenFPS())))
	
	Game.Time.RealNow = GetMilliseconds()
	
	GameInputDo(Game)
	GameDo(Game)
	GameDraw(Game)
	
	Drawtext(debug)
	Drawtext(Game.FPS)
	
	Swap()
	
until CheckInputBackStatePressed(Game.JoystickIndex) and Game.IsHighScore = TRUE
