local cf = { FCVAR_REPLICATED, FCVAR_ARCHIVE } -- CVarFlags
local CVarDropMoneyPercentage = CreateConVar("darkrp_dropmoney_percentage", 0.20, cf,
"Percentage of money to drop when the drop money module is enabled.")
local CVarDropMoneyEnable = CreateConVar("darkrp_dropmoney_enable", 1, cf,
"Enables or disables the drop money module.")

function Death_DropCash(victim, inflictor, attacker)
	local wallet = victim:getDarkRPVar("money")
	local darkrp_dropmoneypercentage = CVarDropMoneyPercentage:GetFloat()
	local amount = math.Round(wallet * darkrp_dropmoneypercentage)
	if (amount > 0) and GetConVar("darkrp_dropmoney_enable"):GetBool() then
		victim:addMoney(-amount)
		DarkRP.createMoneyBag((victim:GetPos()+Vector(0, 0, 10)), amount) -- feel as though money would glitch through map at some points, so spawn it higher
	end
end
hook.Add("PlayerDeath", "Death_DropCash", Death_DropCash)

--	local amount = math.Round(wallet * GetConVar("darkrp_dropmoney_percentage"):GetFloat())