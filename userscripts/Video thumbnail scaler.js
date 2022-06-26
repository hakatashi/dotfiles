// ==UserScript==
// @name         Video thumbnail scaler
// @match        https://ecchi.iwara.tv/**
// @match        https://www.iwara.tv/**
// @version      0.1
// @description  try to take over the world!
// @author       hakatashi
// @grant        none
// @run-at       document-idle
// ==/UserScript==

(() => {
    'use strict';

    const processedVideoIds = new Set();

    const updateImageSrc = async () => {
        console.log('updateImageSrc');
        for (const img of document.querySelectorAll('img')) {
            const src = new URL(img.src);
            const filename = src.pathname.split('/').pop();
            console.log(filename);
            if (!filename.startsWith('thumbnail-')) {
                continue;
            }

            const [_, videoId, count] = filename.split(/[-_.]/);
            if (processedVideoIds.has(videoId)) {
                continue;
            }

            await new Promise((resolve) => setTimeout(resolve, 100));
            img.src = `https://www.iwara.tv/sites/default/files/videos/thumbnails/${videoId}/thumbnail-${videoId}_${count}.jpg`;
            processedVideoIds.add(videoId);
        }
    };

    const mutationObserver = new MutationObserver(updateImageSrc);
    const contentEl = document.querySelector('.container > .col-sm-9');
    if (contentEl) {
        mutationObserver.observe(contentEl, {childList: true, subtree: true});
    }
    updateImageSrc();
})();