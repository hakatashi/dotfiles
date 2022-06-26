// ==UserScript==
// @name         d-anime watch complete submission
// @namespace    https://animestore.docomo.ne.jp/
// @version      1.0
// @description  Spread PHPSESSID to the world (huh?)
// @author       hakatashi
// @match        https://animestore.docomo.ne.jp/animestore/sc_d_pc*
// @grant        GM_xmlhttpRequest
// ==/UserScript==

(() => {
    const processedVideos = new Set();

    setInterval(() => {
        for (const video of document.getElementsByTagName('video')) {
            if (processedVideos.has(video)) {
                continue;
            }
            processedVideos.add(video);

            video.addEventListener('ended', () => {
                const now = Date.now();
                const workEl = document.querySelector('.backInfoTxt1');
                const work = workEl ? workEl.textContent : 'No work';
                const partEl = document.querySelector('.backInfoTxt2');
                const part = partEl ? partEl.textContent : 'No part id';
                const nameEl = document.querySelector('.backInfoTxt3');
                const name = nameEl ? nameEl.textContent : 'No name';
                const partId = new URL(location.href).searchParams.get('partId');
                const workId = new URL(document.referrer).searchParams.get('workId');

                GM_xmlhttpRequest({
                    method: 'POST',
                    url: 'https://us-central1-hakatabot-firebase-functions.cloudfunctions.net/recordAnimeWatchRecord',
                    data: JSON.stringify({date: now, work, part, name, partId, workId}),
                    headers: {
                        'Content-Type': 'application/json; charset=utf-8',
                    },
                });
            })
        }
    }, 5000);
})();