// ==UserScript==
// @name         Copy slacklog message
// @namespace    http://tampermonkey.net/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://slack-log.tsg.ne.jp/*
// @grant        none
// @require      https://cdn.rawgit.com/ricmoo/aes-js/e27b99df/index.js
// ==/UserScript==

const decrypt = (entry, key) => {
    const data = aesjs.utils.hex.toBytes(entry);
    const aes = new aesjs.ModeOfOperation.ctr(key);
    const bytes = aes.decrypt(data);
    const text = aesjs.utils.utf8.fromBytes(bytes);
    return text.match(/^[\x00-\x7F]+$/) ? text : null;
};

(function() {
    'use strict';

    window.addEventListener('dblclick', (event) => {
        const message = event.target.closest('.slack-message');
        if (message === null) {
            return;
        }
        const text = message.querySelector('.slack-message-text').textContent;
        const link = new URL(message.querySelector('.slack-message-date a').getAttribute('href'), location.href).href;
        let user = message.querySelector('.slack-message-user-name').textContent;
        if (user === '1152921504606846976pl') {
            user = 'naan998244353';
        } else if (user === 'jp3bgy') {
            user = 'JP3BGY';
        } else if (user === 'xzy7.naoki.ishii2000') {
            user = '昆布';
        } else if ((decrypted = decrypt('5494c443523e125f72cc06ca470348a742a79f2345047b5a017e01cf7d747623', user))) {
            user = decrypted;
        } else if (user === 'pookemon') {
            user = 'Pokemon';
        } else if (user === 'hisakatafuji') {
            user = 'Oura M. (@domperor，@ut_tex_club）';
        } else if (user === 'yuu.miu.0925') {
            user = 'うら';
        }
        navigator.clipboard.writeText(`[${user}.icon]「${text}」 [(log) ${link}]`);
    });
})();