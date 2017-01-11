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

    m::Send +{F10}
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

    ; Instant search from everywhere
    ; sc07b::
    ; SetTitleMatchMode, 2
    ; WinActivate, Google Chrome ahk_class Chrome_WidgetWin_1
    ; send ^t
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
^+v::send +{Insert}

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

sc07b::Ctrl

sc079::-
sc070::^

RAlt::\
;     SetTitleMatch mode 2 enables AutoHotkey to only partially match program names, must be in the beginning of the script
SetTitleMatchMode, 2



;     Ctrl-E is now Ctrl-J, the shortcut for the Downloads tab in Google Chrome
#IfWinActive ahk_class Chrome_WidgetWin_1
^e::^j
#IfWinActive

^n::return

;     QWERTY-Dvorak Toggle using ScrollLock key
state := 1 ; 

#If state=1 and not GetKeyState("Ctrl", "P")
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