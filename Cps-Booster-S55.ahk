#Requires AutoHotkey v2.0
#SingleInstance Force

global toggle := false
global cpsLimit := 60
global minInterval := 1000 / cpsLimit  ; ms لكل ضغطة

global lastClickL := 0
global lastClickR := 0

; يعمل فقط على نافذة فيها "Flarial" أو "Minecraft"
#HotIf InStr(WinGetTitle("A"), "Flarial") || InStr(WinGetTitle("A"), "Minecraft")

; تشغيل/إيقاف
F6::{
    global toggle
    toggle := !toggle
    ToolTip(toggle ? "CPS Booster: ON (Max 60 CPS)" : "CPS Booster: OFF")
    SetTimer () => ToolTip(""), -1500
}

; الزر الأيسر
~*LButton::{
    global toggle, lastClickL, minInterval
    if toggle {
        currentTime := A_TickCount
        ; يسجل فقط الضغطات السريعة
        if (currentTime - lastClickL <= minInterval) {
            Click "Left"
        }
        lastClickL := currentTime
    }
}

; الزر الأيمن
~*RButton::{
    global toggle, lastClickR, minInterval
    if toggle {
        currentTime := A_TickCount
        ; يسجل فقط الضغطات السريعة
        if (currentTime - lastClickR <= minInterval) {
            Click "Right"
        }
        lastClickR := currentTime
    }
}

#HotIf