// ==UserScript==
// @name         hakataarchive session submission
// @namespace    https://www.pixiv.net/
// @version      1.0
// @description  Spread PHPSESSID to the world (huh?)
// @author       hakatashi
// @match        https://www.pixiv.net/*
// @match        https://poipiku.com/*
// @match        https://www.fanbox.cc/*
// @grant        GM_cookie
// @grant        GM_xmlhttpRequest
// ==/UserScript==

const getServiceName = (host) => {
	if (host === 'poipiku.com') {
		return 'poipiku';
	}
	if (host.endsWith('fanbox.cc')) {
		return 'fanbox';
	}
	return 'pixiv';
};

(() => {
	GM_cookie.list({ url: location.href }, (cookies, error) => {
		if (error) {
			throw new Error(error);
		}

		const session = cookies.find(({ name }) => {
			if (location.host === 'poipiku.com') {
				return name === 'POIPIKU_LK';
			}
			if (location.host.endsWith('fanbox.cc')) {
				return name === 'FANBOXSESSID';
			}
			return name === 'PHPSESSID';
		});

		const apikey = localStorage.getItem('HAKATASHI_API_KEY');

		if (!apikey) {
			alert('HAKATASHI_API_KEY is not set');
			return;
		}

		GM_xmlhttpRequest({
			method: 'POST',
			url: 'https://co791uc66h.execute-api.ap-northeast-1.amazonaws.com/production/post-session',
			data: JSON.stringify({
				apikey,
				id: getServiceName(location.host),
				session: session.value,
			}),
			headers: {
				'Content-Type': 'application/json; charset=utf-8',
			},
		});
	});
})();