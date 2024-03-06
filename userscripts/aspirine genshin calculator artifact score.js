// ==UserScript==
// @name         Aspirine Genshin Calculator Artifact Score
// @namespace    https://genshin.aspirine.su/
// @version      0.1
// @description  Display artifact score on Aspirine Genshin Calculator
// @author       hakatashi
// @match        https://genshin.aspirine.su/*
// ==/UserScript==

const artifactSelector = '.artifact-big-block';

(() => {
  const artifactElements = new Set();
  const artifactScoreMap = new Map();
  let isTotalScoreInitialized = false;

  const artifactAdditionObserver = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      if (mutation.type === 'childList') {
        for (const node of mutation.addedNodes) {
          if (!(node instanceof HTMLElement)) {
            continue;
          }

          const artifactNodes = node.querySelectorAll(artifactSelector);
          for (const artifactNode of artifactNodes) {
            if (artifactElements.has(artifactNode)) {
              continue;
            }
            startScoreUpdateObservation(artifactNode);
          }
        }
      }
    }
  });

  const updateScore = (node) => {
    const subStatEls = node.querySelectorAll('.sub-stat > .value');
    let score = 0;

    for (const subStatEl of subStatEls) {
      const statName = subStatEl.getElementsByClassName('stat-name')[0]?.textContent?.trim?.();
      const statValue = Array.from(subStatEl.childNodes).find((node) => node.nodeType === Node.TEXT_NODE)?.textContent?.trim?.();

      if (!statName || !statValue) {
        continue;
      }

      if (statName === 'Crit. Rate') {
        score += parseFloat(statValue) * 2;
      }

      if (statName === 'Crit. DMG') {
        score += parseFloat(statValue);
      }

      if (statName === 'ATK' && statValue.endsWith('%')) {
        score += parseFloat(statValue);
      }
    }

    artifactScoreMap.set(node, score);

    const mainStatEl = node.querySelector('.main-stat');
    const scoreEl = mainStatEl.querySelector('.score > span');
    if (scoreEl) {
      scoreEl.textContent = score.toFixed(1);
    } else {
      const newScoreEl = document.createElement('div');
      newScoreEl.classList.add('score');
      newScoreEl.classList.add('value');
      newScoreEl.textContent = 'Score: '
      newScoreEl.style.marginLeft = '5px';
      newScoreEl.style.fontSize = '0.8em';

      const scoreTextEl = document.createElement('span');
      scoreTextEl.textContent = score.toFixed(1);
      scoreTextEl.style.color = 'yellow';

      newScoreEl.appendChild(scoreTextEl);
      mainStatEl.appendChild(newScoreEl);
    }

    updateTotalScore();
  };

  const updateTotalScore = () => {
    const totalScoreEl = document.querySelector('.total-score');
    const totalScoreValueEl = totalScoreEl.querySelector('span');

    const artifactEls = totalScoreEl.parentElement.querySelectorAll(artifactSelector);
    let totalScore = 0;
    for (const artifactEl of artifactEls) {
      totalScore += artifactScoreMap.get(artifactEl) ?? 0;
    }

    totalScoreValueEl.textContent = totalScore.toFixed(1);
  };

  const startScoreUpdateObservation = (node) => {
    if (!isTotalScoreInitialized) {

      const totalScoreEl = document.createElement('div');
      totalScoreEl.classList.add('total-score');
      totalScoreEl.textContent = 'Total Score: ';

      const totalScoreValueEl = document.createElement('span');
      totalScoreValueEl.style.color = 'yellow';
      totalScoreValueEl.textContent = '0';

      totalScoreEl.appendChild(totalScoreValueEl);

      const contentEl = node.parentElement;
      const conditionsEl = contentEl.querySelector('.condition-list');
      contentEl.insertBefore(totalScoreEl, conditionsEl);

      isTotalScoreInitialized = true;
    }

    artifactElements.add(node);
    updateScore(node);

    const scoreUpdateObserver = new MutationObserver((mutations) => {
      for (const mutation of mutations) {
        if (mutation.type === 'characterData') {
          updateScore(node);
        }
      }
    });

    scoreUpdateObserver.observe(node, {
      characterData: true,
      subtree: true,
    });
  };

  const artifacts = document.body.querySelectorAll(artifactSelector);
  for (const artifact of artifacts) {
    startScoreUpdateObservation(artifact);
  }

  artifactAdditionObserver.observe(document.body, {
    childList: true,
    attributes: true,
    attributeFilter: ['class'],
    subtree: true,
  });
})();
