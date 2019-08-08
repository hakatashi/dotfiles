// ==UserScript==
// @name         Slacklog mute
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://slack-log.tsg.ne.jp/*
// @grant        none
// ==/UserScript==

(async () => {
    'use strict';
    while (!document.querySelector(".messages-list")) {
        await new Promise((resolve) => setTimeout(resolve, 300));
    }
    const update = () => {
        const names = Array.from(document.querySelectorAll('.slack-message-user-name')).filter((e) => e.textContent === 'szkieletor');
        for (const name of names) {
            let message = name.closest('.slack-message');
            message.style.display = 'none';
        }
    };
    document.querySelector(".messages-list").addEventListener('DOMSubtreeModified', update);
    document.querySelector(".messages-list").addEventListener('propertychange', update);
})();