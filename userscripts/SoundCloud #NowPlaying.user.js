// ==UserScript==
// @name         SoundCloud #NowPlaying
// @namespace    https://hakatashi.com/
// @version      0.1
// @description  Automatically post #NowPlaying to IFTTT while listening SoundCloud
// @author       hakatashi
// @match        https://soundcloud.com/*
// @connect      maker.ifttt.com
// @connect      hooks.slack.com
// @grant        GM_xmlhttpRequest
// ==/UserScript==

(() => {
    'use strict';
    const postedUrls = new Set();
    let init = false;

    window.addEventListener('load', () => {
        if (init) {
            return;
        }
        init = true;

        const targetElement = document.querySelector('.playbackTimeline__timePassed');
        const observer = new MutationObserver((mutations) => {
            for (const mutation of mutations) {
                if (mutation.type === 'childList') {
                    const timeText = targetElement.childNodes[targetElement.childNodes.length - 1].textContent || '';
                    if (!timeText.includes(':')) {
                        return;
                    }
                    const time = parseInt(timeText.split(':')[0]) * 60 + parseInt(timeText.split(':')[1]);
                    if (!time || time < 60) {
                        return;
                    }

                    const author = document.querySelector('.playbackSoundBadge__lightLink').textContent;
                    const title = document.querySelector('.playbackSoundBadge__titleLink > :last-child').textContent;
                    const url = document.querySelector('.playbackSoundBadge__titleLink').href;
                    const artwork = document.querySelector('.playbackSoundBadge__avatar > .image > span').style.backgroundImage.replace(/url\("(.+?)"\)/, '$1').replace('50x50', '500x500');

                    if (postedUrls.has(url)) {
                        return;
                    }
                    postedUrls.add(url);

                    GM_xmlhttpRequest({
                        method: "POST",
                        url: 'https://maker.ifttt.com/trigger/soundcloud_nowplaying/with/key/lkski1Yg-au84vJrxyhYmrjwLa-Qk77oNT5xmW9ZaK8',
                        data: JSON.stringify({
                            value1: `♪Listening Now♪ ${title} / ${author} #SoundCloud #NowPlaying ${url}`,
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