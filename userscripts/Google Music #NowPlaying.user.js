// ==UserScript==
// @name         Google Music #NowPlaying
// @namespace    https://play.google.com/music/
// @version      0.1
// @description  Automatically post #NowPlaying to IFTTT while listening Google Music
// @author       hakatashi
// @match        https://play.google.com/music/*
// @connect      maker.ifttt.com
// @grant        GM_xmlhttpRequest
// ==/UserScript==

(() => {
    'use strict';
    const postedTitles = new Set();
    let isInit = false;

    window.addEventListener('load', () => {
        if (isInit) {
            return;
        }
        isInit = true;

        const targetElement = document.querySelector('#time_container_current');
        const observer = new MutationObserver((mutations) => {
            for (const mutation of mutations) {
                if (mutation.type === 'childList') {
                    const timeText = targetElement.textContent || '';
                    if (!timeText.includes(':')) {
                        return;
                    }
                    const time = parseInt(timeText.split(':')[0]) * 60 + parseInt(timeText.split(':')[1]);
                    if (!time || time < 60) {
                        return;
                    }

                    const author = document.querySelector('#player-artist').textContent;
                    const title = document.querySelector('#currently-playing-title').textContent;
                    const artwork = document.querySelector('#playerBarArt').getAttribute('src').replace('s90-c', 's500-c');

                    if (postedTitles.has(title)) {
                        return;
                    }
                    postedTitles.add(title);

                    GM_xmlhttpRequest({
                        method: "POST",
                        url: 'https://maker.ifttt.com/trigger/soundcloud_nowplaying/with/key/lkski1Yg-au84vJrxyhYmrjwLa-Qk77oNT5xmW9ZaK8',
                        data: JSON.stringify({
                            value1: `♪Listening Now♪ ${title} / ${author} #GoogleMusic #NowPlaying`,
                            value2: artwork,
                        }),
                        headers: {
                            'Content-Type': 'application/json; charset=utf-8',
                        },
                    });
                }
            };
        });

        observer.observe(targetElement, {childList: true});
    });
})();