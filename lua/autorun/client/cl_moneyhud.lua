surface.CreateFont("GTAVMoneyFont", {
    font = "Pricedown",
    size = 34,
    weight = 800,
    antialias = true
})

surface.CreateFont("GTAVMoneyChangeFont", {
    font = "Pricedown",
    size = 28,
    weight = 800,
    antialias = true
})

local lastMoney = 0
local changeAmount = 0
local changeAlpha = 0
local changeTime = 0
local isGain = true

hook.Add("HUDPaint", "GTAVStyleMoneyHUD", function()
    local ply = LocalPlayer()
    if not IsValid(ply) or not ply:getDarkRPVar("money") then return end

    local money = ply:getDarkRPVar("money")
    local formattedMoney = DarkRP.formatMoney(money)

    local x = ScrW() - 30
    local y = 40

    draw.SimpleText(formattedMoney, "GTAVMoneyFont", x, y, Color(237, 237, 237), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

    -- Detect money change
    if money ~= lastMoney then
        changeAmount = math.abs(money - lastMoney)
        isGain = (money > lastMoney)
        changeAlpha = 255
        changeTime = CurTime()
        lastMoney = money
    end

    -- Show change text
    if changeAlpha > 0 and changeAmount > 0 then
        local timeSinceChange = CurTime() - changeTime
        local changeY = y - (timeSinceChange * 30)
        local prefix = isGain and "+ " or "- "
        local color = isGain and Color(0, 255, 0, changeAlpha) or Color(255, 0, 0, changeAlpha)

        draw.SimpleText(prefix .. DarkRP.formatMoney(changeAmount), "GTAVMoneyChangeFont", x, changeY, color, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)

        changeAlpha = changeAlpha - FrameTime() * 255
    end
end)