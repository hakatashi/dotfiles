#InstallKeybdHook
#PgUp::Volume_Up
#PgDn::Volume_Down

Pause::Media_Play_Pause

; Almighty CapsLock
#If GetKeyState("ScrollLock", "P")
    h::Left
    j::Down
    k::Up
    l::Right
    y::Home
    u::PgDn
    i::PgUp
    o::End
    p::Insert
    `;::vkF4

    m::Send +{F10}
    ,::(
    .::)

    f::Escape
    e::Delete
    d::Backspace
    v::^@

    1::F1
    2::F2
    3::F3
    4::F4
    5::F5
    6::F6
    7::F7
    8::F8
    9::F9
    0::F10

    Space::Media_Play_Pause
    Left::Media_Prev
    Right::Media_Next
    Up::Volume_Up
    Down::Volume_Down

    ; Instant search from everywhere
    ; sc07b::
    ; SetTitleMatchMode, 2
    ; WinActivate, Google Chrome ahk_class Chrome_WidgetWin_1
    ; send ^
    ; SetTitleMatchMode, 1
    ; return

    sc079::^#Left
    sc070::^#Right

    g::
    If (state)
       state := 0
    else
       state := 1
    return
#If

ScrollLock & Esc::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

^SPACE::  Winset, Alwaysontop, , A

#If !WinActive("ahk_class Chrome_WidgetWin_1") and !WinActive("ahk_exe soffice.bin")
^+v::send +{Insert}
#If

; Transparently maps Backslash key of JIS Keyboard into TRUE Backslash
sc073::\
+sc073::_
RCtrl::

#If WinActive("ahk_exe putty.exe") or WinActive("ahk_exe kitty.exe")
    ^Tab::
    send ^b
    send o
    return

    ^F4::
    send ^b
    send, xy
    return

    ^T::
    send ^b
    send `%
    return
#if

; My laptop keyboard has been fixed :)
sc07b::Space

sc079::Space
sc070::^

RAlt::\
;     SetTitleMatch mode 2 enables AutoHotkey to only partially match program names, must be in the beginning of the script
SetTitleMatchMode, 2

;     Ctrl-E is now Ctrl-J, the shortcut for the Downloads tab in Google Chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
^e::^j
#IfWinActive

;     QWERTY-Dvorak Toggle using ScrollLock key
state := 1 ;

#If state=1
    #HotkeyInterval 1000000000
    #MaxHotkeysPerInterval 9999999999999
    -::[
    ^::]
    q::'
    +q::"
    w::,
    e::.
    r::p
    t::y
    y::f
    u::g
    i::c
    o::r
    p::l
    @::/
    [::=
    +[::+
    ]::\
    s::o
    d::e
    f::u
    g::i
    h::d
    j::h
    k::t
    l::n
    `;::s
    :::Send -
    *::Send _
    z::Send `;
    +z::Send :
    x::q
    c::j
    v::k
    b::x
    n::b
    ,::w
    .::v
    /::z
    sc029::`
    +sc029::~
    +2::Send @
    +6::Send {^}
    +7::&
    +8::*
    +9::(
    +0::)
    RWin::-
    +RWin::=
    ^RWin::_
#If

;Left::SendInput ��
;Right::SendInput �E
;Up::SendInput ��
;Down::SendInput ��

#A::SetTimer, AutoIdolProduce, 000
#Q::SetTimer, AutoIdolProduce, Off

;Space::Click

FoundSuperLive := false

AutoJam:
global FoundSuperLive
global Counter
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

WinGetPos, X, Y, W, H, A
W := W + X
H := H + Y

Counter++
if (Mod(Counter, 200) = 0) {
    Send {F5}
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\event-top.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+20
    Sleep, 1000
    MouseClick, left
    Sleep, 4000
}

MouseMove, X+160, Y+605
Sleep, 1000
MouseClick, left
Sleep, 4000

MouseMove, X+40, Y+530
Sleep, 1000
MouseClick, left
Sleep, 4000

MouseMove, X+40, Y+415
Sleep, 1000
MouseClick, left

if (Mod(Counter, 5) = 0) {
    Sleep, 4000
    MouseMove, X+40, Y+320
    Sleep, 1000
    MouseClick, left
}

return

NotFoundCounter := 0
Counter := 0

AutoOshigoto:
global NotFoundCounter
global Counter
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

WinGetPos, X, Y, W, H, A
W := W + X
H := H + Y

Counter++

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *20 C:\Users\denjj\dotfiles\temp\button.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+30
    MouseClick, left
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\sutadori.png
if (ErrorLevel = 0) {
    if (Mod(Counter, 4) = 0) {
        MouseMove, FoundX, FoundY+60
        MouseClick, left
        Sleep 1000
        MouseClick, left
        NotFoundCounter := 0
    }
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\sutadori-gray.png
if (ErrorLevel = 0) {
    if (Mod(Counter, 4) = 0) {
        MouseMove, FoundX+60, FoundY+60
        MouseClick, left
        Sleep 1000
        MouseClick, left
        NotFoundCounter := 0
    }
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\next-area.png
if (ErrorLevel = 0) {
    if (Mod(Counter, 4) = 0) {
        MouseMove, FoundX+20, FoundY+30
        MouseClick, left
        NotFoundCounter := 0
    }
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\skip.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+10
    MouseClick, left
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *120 C:\Users\denjj\dotfiles\temp\start-battle.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+10
    MouseClick, left
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *20 C:\Users\denjj\dotfiles\temp\battle-ready.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY
    Click WheelDown
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *20 C:\Users\denjj\dotfiles\temp\after-win-1.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY
    Click WheelDown
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *20 C:\Users\denjj\dotfiles\temp\after-win-2.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY
    Click WheelDown
    NotFoundCounter := 0
    return
}

NotFoundCounter++
if (Mod(NotFoundCounter, 3) = 0) {
    MouseMove, X+230, Y+350
    MouseClick, left
}

return

AutoIdolProduce:
global NotFoundCounter
global Counter
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

WinGetPos, X, Y, W, H, A
W := W + X
H := H + Y

Counter++

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *20 C:\Users\denjj\dotfiles\temp\button.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+30
    MouseClick, left
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\sutadori.png
if (ErrorLevel = 0) {
    if (Mod(Counter, 4) = 0) {
        MouseMove, FoundX, FoundY+60
        MouseClick, left
        Sleep 1000
        MouseClick, left
        NotFoundCounter := 0
    }
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\sutadori-gray.png
if (ErrorLevel = 0) {
    if (Mod(Counter, 4) = 0) {
        MouseMove, FoundX+60, FoundY+60
        MouseClick, left
        Sleep 1000
        MouseClick, left
        NotFoundCounter := 0
    }
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\communicate.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+30
    MouseClick, left
    NotFoundCounter := 0
    return
}

ImageSearch, FoundX, FoundY, %X%, %Y%, %W%, %H%, *100 C:\Users\denjj\dotfiles\temp\communicate3.png
if (ErrorLevel = 0) {
    MouseMove, FoundX+20, FoundY+30
    MouseClick, left
    NotFoundCounter := 0
    return
}

NotFoundCounter++
if (Mod(NotFoundCounter, 2) = 0) {
    MouseMove, X+180, Y+380
    MouseClick, left
}

return
