LUAGUI_NAME = "CMix_GameSpeed_SlowMenu_FastLadders"
LUAGUI_AUTH = "Xendra & denhonator"
LUAGUI_DESC = "Faster Gameplay, Command Menu Slowdown (Press L3 to activate)"

local summonSpeedup = true
local gameSpeed = 1.0
local soraSpeed = 1.05
local boostSpeed = 2.0
local climbSpeed = 2.0
local menuSpeed = 0.1
local menuCameraSpeed = 10.0
local TBD = 0x0
local soraHUD = 0x281249C
local speedup = 0x233FBCC
local stateFlag = 0x28672C8
local speedupFlags = {0x00, 0x01, 0x11, 0x20, 0x21}
local soraPointer = 0x2537E48
local currentCommandMenu = 0x2852790
local menu = 0x2E941C0
local inMenu = 0x232DFA0
local swapped = ReadByte(0x4D8632)
local buttonMask = 0x04 -- L1/LB
local buttonInput = 0
local buttonMask2 = 0x02 -- L3 (Thumbstick Left)
local tempPause = 0
local pausetoggleEnabled = false
local pausetoggleWasPressed = false

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Critical Mix - Game Speedup Installed")
	else
		ConsolePrint("-- FAILED to find compatible game for CMix_GameSpeedup --")
	end
end

function update_toggle()
	local buttonPressed = (ReadByte(0x23407B4) & buttonMask2) ~= 0

	if buttonPressed and not pausetoggleWasPressed then
		pausetoggleEnabled = not pausetoggleEnabled

		ConsolePrint("Game Speed Override is now: " .. tostring(pausetoggleEnabled))
	end
	pausetoggleWasPressed = buttonPressed
end

function _OnFrame()
	if not canExecute then
		return
	end

	update_toggle()

	local buttonPressed = (ReadByte(0x23407B4) & buttonMask2) ~= 0

	-- R3 resets the speed if too slow.
	if buttonPressed == 0x04 then
		WriteFloat(speedup, 1.0)
	end

	if pausetoggleEnabled then
		swapped = ReadByte(0x4D8632)
		buttonMask = 0x04
		if swapped == 1 then
			buttonMask = 0x04 -- ?
		end
		
		local cutscene = ReadInt(0x233E808)
		local skippable = ReadInt(0x2382594)
		local summoning = ReadInt(0x2D60FAC)
		local world = ReadByte(0x233FE84)
		local room = ReadByte(0x233FE8C)
		local minitimer = ReadInt(0x232E000)
		local camstate = ReadByte(0x299BB08)
		local currentSpeed = 1.0
		local soraAnimSpeed = ReadLong(soraPointer)+0x284
		local currentAnim = ReadLong(soraPointer)+0x164
		-- ConsolePrint(ReadByte(currentAnim, true))
		
		for index, flag in pairs(speedupFlags) do
			if ReadByte(stateFlag) == flag then
				currentSpeed = gameSpeed
				break
			end
		end
		local boost = false
		if ReadFloat(soraHUD) < 1 and cutscene > 0 and cutscene ~= 8 
			and skippable ~= 1025 and (summoning == 0 or summonSpeedup)
			and not (world==6 and room==8 and minitimer>=18000.0/boostSpeed)
			and not (world==1 and room==2 and (camstate>=1 and camstate<=5)) then
			boost = true
		end
		
		if ReadByte(currentAnim, true) == 0x15 or ReadByte(currentAnim, true) == 0x16 then
			currentSpeed = climbSpeed
		end
		
		local camSpeed = 0x506ECC
		WriteFloat(camSpeed, 1.0)
		
		local menuSlow = false
		
		if ReadByte(menu) == 0x00 and ReadByte(currentCommandMenu) > 0x00 and ReadByte(currentCommandMenu) < 0x05 and ReadByte(inMenu) == 0x00 then
			menuSlow = true
		end
		
		
		buttonInput = ReadByte(0x23407B5) & buttonMask
		if not buttonInput then
			menuSlow = false
		end
		
		if boost == true then
			currentSpeed = boostSpeed
		end
		
		if menuSlow == true then
			currentSpeed = menuSpeed
			WriteFloat(camSpeed, menuCameraSpeed)
		end
		
		WriteFloat(soraAnimSpeed, soraSpeed, true)
		WriteFloat(speedup, currentSpeed)
	else
		--WriteFloat(speedup, 1.0)
	end
end