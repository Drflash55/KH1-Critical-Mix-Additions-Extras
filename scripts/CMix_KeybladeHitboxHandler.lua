LUAGUI_NAME = "CMix_KeybladeHitboxHandler"
LUAGUI_AUTH = "Xendra"
LUAGUI_DESC = "Intercepts Keyblade Hitbox, allowing you to customize it with code. Has options."

--
local soraPointer = 0x2534680
local comboPosition = 0x296B221
local maxGroundComboLength = 0x2E942B4
local bonusHitbox = 0.0

local kingdomkeyHitbox = 80.0
local dreamswordHitbox = 55.0
local dreamshieldHitbox = 55.0
local dreamrodHitbox = 55.0
local woodenswordHitbox = 100.0
local junglekingHitbox = 55.0
local threewishesHitbox = 55.0
local crabclawHitbox = 55.0
local pumpkinheadHitbox = 55.0
local fairyharpHitbox = 55.0
local wishingstarHitbox = 55.0
local spellbinderHitbox = 55.0
local metalchocoboHitbox = 55.0  
local olympiaHitbox = 55.0
local lionheartHitbox = 55.0
local ladyluckHitbox = 55.0
local divineroseHitbox = 55.0
local oathkeeperHitbox = 55.0
local oblivionHitbox = 55.0
local diamonddustHitbox = 55.0
local onewingedangelHitbox = 55.0
local ultimaHitbox = 100.0

local kingdomkeyHitboxAddress = 0x2D2C268 - 0x10
local dreamswordHitboxAddress = 0x2D2C2C0 - 0x10
local dreamshieldHitboxAddress = 0x2D2C318 - 0x10
local dreamrodHitboxAddress = 0x2D2C370 - 0x10
local woodenswordHitboxAddress = 0x2D2C3C8 - 0x10
local junglekingHitboxAddress = 0x2D2C420 - 0x10
local threewishesHitboxAddress = 0x2D2C478 - 0x10
local crabclawHitboxAddress = 0x2D2C580 - 0x10
local pumpkinheadHitboxAddress = 0x2D2C528 - 0x10
local fairyharpHitboxAddress = 0x2D2C4D0 - 0x10
local wishingstarHitboxAddress = 0x2D2C898 - 0x10
local spellbinderHitboxAddress = 0x2D2C630 - 0x10
local metalchocoboHitboxAddress = 0x2D2C738 - 0x10
local olympiaHitboxAddress = 0x2D2C688 - 0x10
local lionheartHitboxAddress = 0x2D2C6E0 - 0x10
local ladyluckHitboxAddress = 0x2D2C840 - 0x10
local divineroseHitboxAddress = 0x2D2C5D8 - 0x10
local oathkeeperHitboxAddress = 0x2D2C790 - 0x10
local oblivionHitboxAddress = 0x2D2C7E8 - 0x10
local diamonddustHitboxAddress = 0x2D2C948 - 0x10
local onewingedangelHitboxAddress = 0x2D2C9A0 - 0x10
local ultimaHitboxAddress = 0x2D2C8F0 - 0x10

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Critical Mix - Keyblade Hitbox Handler Installed")
		canExecute = true
	end
end


function _OnFrame()
	if canExecute == true then
		
		local currentAnim = ReadLong(soraPointer)+0x164			
		bonusHitbox = 0.0
		
		if ReadByte(comboPosition) >= ReadByte(maxGroundComboLength) - 1 then
			bonusHitbox = bonusHitbox + 25.0
		end
		
		-- Write Keyblade Hitbox Values
		WriteFloat(kingdomkeyHitboxAddress, kingdomkeyHitbox + bonusHitbox)
		WriteFloat(dreamswordHitboxAddress, dreamswordHitbox + bonusHitbox)
		WriteFloat(dreamshieldHitboxAddress, dreamshieldHitbox + bonusHitbox)
		WriteFloat(dreamrodHitboxAddress, dreamrodHitbox + bonusHitbox)
		WriteFloat(woodenswordHitboxAddress, woodenswordHitbox + bonusHitbox)
		WriteFloat(junglekingHitboxAddress, junglekingHitbox + bonusHitbox)
		WriteFloat(threewishesHitboxAddress, threewishesHitbox + bonusHitbox)
		WriteFloat(crabclawHitboxAddress, crabclawHitbox + bonusHitbox)
		WriteFloat(pumpkinheadHitboxAddress, pumpkinheadHitbox + bonusHitbox)
		WriteFloat(fairyharpHitboxAddress, fairyharpHitbox + bonusHitbox)
		WriteFloat(wishingstarHitboxAddress, wishingstarHitbox + bonusHitbox)
		WriteFloat(spellbinderHitboxAddress, spellbinderHitbox + bonusHitbox)
		WriteFloat(metalchocoboHitboxAddress, metalchocoboHitbox + bonusHitbox)
		WriteFloat(olympiaHitboxAddress, olympiaHitbox + bonusHitbox)
		WriteFloat(lionheartHitboxAddress, lionheartHitbox + bonusHitbox)
		WriteFloat(ladyluckHitboxAddress, ladyluckHitbox + bonusHitbox)
		WriteFloat(divineroseHitboxAddress, divineroseHitbox + bonusHitbox)
		WriteFloat(oathkeeperHitboxAddress, oathkeeperHitbox + bonusHitbox)
		WriteFloat(oblivionHitboxAddress, oblivionHitbox + bonusHitbox)
		WriteFloat(diamonddustHitboxAddress, diamonddustHitbox + bonusHitbox)
		WriteFloat(onewingedangelHitboxAddress, onewingedangelHitbox + bonusHitbox)
		WriteFloat(ultimaHitboxAddress, ultimaHitbox + bonusHitbox)
	end
end

