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
    `;::vkF4sc029

    m::+F10
    ,::(
    .::)

    f::Escape
    e::Delete
    d::Backspace

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

    sc079::^#Left
    sc070::^#Right
#If

ScrollLock & Esc::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

^SPACE::  Winset, Alwaysontop, , A
^+v::send +{Insert}

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

sc07b::Ctrl

sc079::-
sc070::^
RAlt::\