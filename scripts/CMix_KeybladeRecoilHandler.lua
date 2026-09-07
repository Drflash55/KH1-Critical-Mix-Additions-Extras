LUAGUI_NAME = "CMix_KeybladeRecoilHandler"
LUAGUI_AUTH = "Xendra"
LUAGUI_DESC = "Intercepts keyblade recoil for manual handling by lua. Has options."

-- Settings
local counterattackPierce = true
local counterattackFinisher = true
--
local soraPointer = 0x2537E48
local curComboChain = 0x296B221

kingdomkeyRecoil = 90
dreamswordRecoil = 90
dreamshieldRecoil = 90
dreamrodRecoil = 90
woodenswordRecoil = 90
junglekingRecoil = 90
threewishesRecoil = 90
crabclawRecoil = 90
pumpkinheadRecoil = 90
fairyharpRecoil = 90
wishingstarRecoil = 90
spellbinderRecoil = 90
metalchocoboRecoil = 90   
olympiaRecoil = 90
lionheartRecoil = 90
ladyluckRecoil = 90
divineroseRecoil = 90
oathkeeperRecoil = 90
oblivionRecoil = 90
diamonddustRecoil = 90
onewingedangelRecoil = 90
ultimaRecoil = 90

local kingdomkeyRecoilAddress = 0x2D2C268 + 0x3
local dreamswordRecoilAddress = 0x2D2C2C0 + 0x3
local dreamshieldRecoilAddress = 0x2D2C318 + 0x3
local dreamrodRecoilAddress = 0x2D2C370 + 0x3
local woodenswordRecoilAddress = 0x2D2C3C8 + 0x3
local junglekingRecoilAddress = 0x2D2C420 + 0x3
local threewishesRecoilAddress = 0x2D2C478 + 0x3
local crabclawRecoilAddress = 0x2D2C580 + 0x3
local pumpkinheadRecoilAddress = 0x2D2C528 + 0x3
local fairyharpRecoilAddress = 0x2D2C4D0 + 0x3
local wishingstarRecoilAddress = 0x2D2C898 + 0x3
local spellbinderRecoilAddress = 0x2D2C630 + 0x3
local metalchocoboRecoilAddress = 0x2D2C738 + 0x3
local olympiaRecoilAddress = 0x2D2C688 + 0x3
local lionheartRecoilAddress = 0x2D2C6E0 + 0x3
local ladyluckRecoilAddress = 0x2D2C840 + 0x3
local divineroseRecoilAddress = 0x2D2C5D8 + 0x3
local oathkeeperRecoilAddress = 0x2D2C790 + 0x3
local oblivionRecoilAddress = 0x2D2C7E8 + 0x3
local diamonddustRecoilAddress = 0x2D2C948 + 0x3
local onewingedangelRecoilAddress = 0x2D2C9A0 + 0x3
local ultimaRecoilAddress = 0x2D2C8F0 + 0x3

local commandSlot1 = 0x528914
local counterPiercing = 0
local pierceDuration = 60

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Critical Mix - Keyblade Recoil Handler Installed")
		canExecute = true
	end
end


function _OnFrame()
	if canExecute == true then
		local bonusRecoil = 0
		local currentAnim = ReadLong(soraPointer)+0x164
		
		if counterattackPierce == true then
			if counterPiercing > 0 then
				counterPiercing = counterPiercing - 1
			end
			-- Also do it if you have the counter command in slot 1
			if ReadByte(currentAnim, true) == 0xD5 or ReadByte(commandSlot1) == 0x63 then
				counterPiercing = pierceDuration
				WriteByte(comboPosition, 0xFE)
			end
			
			if counterPiercing > 0 and ReadByte(currentAnim, true) ~= 0xD4 then
				bonusRecoil = 165
			end
		end
		-- Write Keyblade Recoil Values
		WriteByte(kingdomkeyRecoilAddress, kingdomkeyRecoil + bonusRecoil)
		WriteByte(dreamswordRecoilAddress, dreamswordRecoil + bonusRecoil)
		WriteByte(dreamshieldRecoilAddress, dreamshieldRecoil + bonusRecoil)
		WriteByte(dreamrodRecoilAddress, dreamrodRecoil + bonusRecoil)
		WriteByte(woodenswordRecoilAddress, woodenswordRecoil + bonusRecoil)
		WriteByte(junglekingRecoilAddress, junglekingRecoil + bonusRecoil)
		WriteByte(threewishesRecoilAddress, threewishesRecoil + bonusRecoil)
		WriteByte(crabclawRecoilAddress, crabclawRecoil + bonusRecoil)
		WriteByte(pumpkinheadRecoilAddress, pumpkinheadRecoil + bonusRecoil)
		WriteByte(fairyharpRecoilAddress, fairyharpRecoil + bonusRecoil)
		WriteByte(wishingstarRecoilAddress, wishingstarRecoil + bonusRecoil)
		WriteByte(spellbinderRecoilAddress, spellbinderRecoil + bonusRecoil)
		WriteByte(metalchocoboRecoilAddress, metalchocoboRecoil + bonusRecoil)
		WriteByte(olympiaRecoilAddress, olympiaRecoil + bonusRecoil)
		WriteByte(lionheartRecoilAddress, lionheartRecoil + bonusRecoil)
		WriteByte(ladyluckRecoilAddress, ladyluckRecoil + bonusRecoil)
		WriteByte(divineroseRecoilAddress, divineroseRecoil + bonusRecoil)
		WriteByte(oathkeeperRecoilAddress, oathkeeperRecoil + bonusRecoil)
		WriteByte(oblivionRecoilAddress, oblivionRecoil + bonusRecoil)
		WriteByte(diamonddustRecoilAddress, diamonddustRecoil + bonusRecoil)
		WriteByte(onewingedangelRecoilAddress, onewingedangelRecoil + bonusRecoil)
		WriteByte(ultimaRecoilAddress, ultimaRecoil + bonusRecoil)
	end
end

