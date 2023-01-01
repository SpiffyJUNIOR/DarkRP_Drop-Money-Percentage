local cf = { FCVAR_REPLICATED, FCVAR_ARCHIVE } -- CVarFlags
local CVarDropMoneyPercentage = CreateConVar("darkrp_dropmoney_percentage", 0.20, cf,
"Percentage of money to drop when the drop money module is enabled.")
local CVarDropMoneyEnable = CreateConVar("darkrp_dropmoney_enable", 1, cf,
"Enables or disables the drop money module.")

local function DropMoney(ply, amount, posX, posY)
	if amount == nil then amount = ply:getDarkRPVar("money") end
	if posX == nil then posX = 0 end
	if posY == nil then posY = 0 end

	local darkrp_dropmoneypercentage = CVarDropMoneyPercentage:GetFloat()
	local realamount = math.Round(amount * darkrp_dropmoneypercentage)
	if (realamount > 0) and GetConVar("darkrp_dropmoney_enable"):GetBool() then
		ply:addMoney(-realamount)
		DarkRP.createMoneyBag((ply:GetPos() + Vector(posX, posY, 10)), realamount) -- spawn at different pos for each money stack
	end
end

function Death_DropMoney(victim, inflictor, attacker)
	if !CVarDropMoneyEnable then return end
	local divided = victim:getDarkRPVar("money") / 5
	if divided > 250 then
		for i = 0, 5 do
			DropMoney(victim, divided, i, i)
		end
	else
		DropMoney(victim)
	end
end

hook.Add("PlayerDeath", "chicagoRP_DeathDropMoney", Death_DropMoney)

--	local amount = math.Round(wallet * GetConVar("darkrp_dropmoney_percentage"):GetFloat())