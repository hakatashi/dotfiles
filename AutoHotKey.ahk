#PgUp::Volume_Up
#PgDn::Volume_Down

Pause::Media_Play_Pause

ScrollLock & h::send {Left}
ScrollLock & j::send {Down}
ScrollLock & k::send {Up}
ScrollLock & l::send {Right}
ScrollLock & y::send {Home}
ScrollLock & u::send {PgDn}
ScrollLock & i::send {PgUp}
ScrollLock & o::send {End}
ScrollLock & `;::send {vkF4sc029}

ScrollLock & ,::send {(}
ScrollLock & .::send {)}

ScrollLock & f::send {Escape}
ScrollLock & e::send {Delete}
ScrollLock & d::send {Backspace}

ScrollLock & 1::send {F1}
ScrollLock & 2::send {F2}
ScrollLock & 3::send {F3}
ScrollLock & 4::send {F4}
ScrollLock & 5::send {F5}
ScrollLock & 6::send {F6}
ScrollLock & 7::send {F7}
ScrollLock & 8::send {F8}
ScrollLock & 9::send {F9}
ScrollLock & 0::send {F10}

ScrollLock & Space::send {Media_Play_Pause}
ScrollLock & Left::send {Media_Prev}
ScrollLock & Right::send {Media_Next}
ScrollLock & Up::send {Volume_Up}
ScrollLock & Down::send {Volume_Down}

ScrollLock & Esc::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0)

^SPACE::  Winset, Alwaysontop, , A

sc07b::Ctrl

sc079::-
sc070::^
RAlt::\