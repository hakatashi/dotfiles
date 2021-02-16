
// ==UserScript==
// @name         Moneyforward Import Suruga Visa Debit
// @namespace    https://hakatashi.com
// @version      0.1
// @description  try to take over the world!
// @author       Koki Takahashi
// @match        https://moneyforward.com/*
// @grant        none
// ==/UserScript==

(() => {
    'use strict';

    const wrapEl = document.getElementById('ttl_genyokinbreak_table');

    const textareaEl = document.createElement('textarea');
    textareaEl.style = 'display: block; margin: 0 auto; width: 80%; height: 10rem;';

    const submitEl = document.createElement('input');
    submitEl.type = 'submit';
    submitEl.style = 'display: block; margin: 0 auto;';

    wrapEl.appendChild(textareaEl);
    wrapEl.appendChild(submitEl);

    submitEl.addEventListener('click', async () => {
        const tsv = textareaEl.value;
        textareaEl.value = '';

        const entries = [];

        for (const row of tsv.split('\n')) {
            const components = row.split('\t');

            if (components.length !== 7) {
                continue;
            }

            const [type, date, content, amountString] = components;

            if (type !== 'ご利用') {
                continue;
            }

            if (content.includes('ＡＭＡＺＯＮ') && !content.includes('ＷＥＢ')) {
                continue;
            }

            let [year, month, day] = date.split(/[年月日]/);
            year = parseInt(year);
            month = parseInt(month);
            day = parseInt(day);

            const amount = parseInt(amountString.replaceAll(',', ''));

            entries.push({type, year, month, day, content: content.trim(), amount, row});
        }

        const tbodyEl = wrapEl.querySelector('table > tbody');
        
        if (!tbodyEl) {
            return;
        }

        const notFoundRows = [];

        for (const row of tbodyEl.children) {
            const dateEl = row.querySelector('tr > .date');
            const contentEl = row.querySelector('tr > .content');
            const amountEl = row.querySelector('tr > .amount');
            const memoEl = row.querySelector('tr > .memo');

            if (!dateEl || !contentEl || !amountEl || !memoEl) {
                continue;
            }

            if (!amountEl.classList.contains('minus-color')) {
                continue;
            }

            const date = dateEl.dataset.tableSortableValue.split('-')[0];
            const content = contentEl.innerText;
            const amount = parseInt(amountEl.innerText.replaceAll(',', ''));
            const [year, month, day] = date.split('/').map((s) => parseInt(s));

            if (content !== 'デビツトゴリヨウ その他') {
                continue;
            }

            const entryIndex = entries.findIndex((entry) => (
                entry.year === year &&
                entry.month === month &&
                entry.day === day &&
                entry.amount === -amount
            ));

            if (entryIndex === -1) {
                notFoundRows.push({id: row.id, amount});
                continue;
            }

            const entry = entries[entryIndex];
            entries.splice(entryIndex, 1);

            memoEl.click();

            const inputEl = memoEl.querySelector('input');
            inputEl.value = entry.content.slice(0, 20);
            inputEl.dispatchEvent(new Event('change', {bubbles: true}));

            textareaEl.value = entries.map((entry) => entry.row).join('\n');

            await new Promise((resolve) => setTimeout(resolve, 3000));
        }

        for (const {id, amount} of notFoundRows) {
            const row = document.getElementById(id);
            const memoEl = row.querySelector('tr > .memo');
            const entryIndex = entries.findIndex((entry) => entry.amount === -amount);

            if (entryIndex === -1) {
                continue;
            }

            const entry = entries[entryIndex];
            entries.splice(entryIndex, 1);

            memoEl.click();

            const inputEl = memoEl.querySelector('input');
            inputEl.value = entry.content.slice(0, 20);
            inputEl.dispatchEvent(new Event('change', {bubbles: true}));

            textareaEl.value = entries.map((entry) => entry.row).join('\n');

            await new Promise((resolve) => setTimeout(resolve, 3000));
        }
    });
})();
