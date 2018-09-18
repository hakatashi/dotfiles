#!/usr/bin/env python
# -*- coding: utf-8 -*-

from sys import argv
try:
    from PIL import Image
except:
    from sys import stderr
    stderr.write('[E] PIL not installed')
    exit(1)
from io import BytesIO
from urllib.request import Request, urlopen
from urllib.parse import urlencode
import json
import re
import shutil
from drawille import Canvas

def usage():
    print('Usage: %s <url/id>')
    exit()

if __name__ == '__main__':
    if len(argv) < 2:
        url = 'http://xkcd.com/'
    else:
        usage()
    c = urlopen(url).read().decode('utf-8')
    img_url = 'https:' + ''.join(re.search('src="(\/\/imgs.xkcd.com\/comics\/.*\.)(jpg|png)"', c).groups())
    i = Image.open(BytesIO(urlopen(img_url).read())).convert('L')
    w, h = i.size
    tw, th = shutil.get_terminal_size((80, 25))
    tw -= 1
    th -= 10
    tw *= 2
    th *= 4
    if tw < w or th < h:
        ratio = min(tw / float(w), th / float(h))
        w = int(w * ratio)
        h = int(h * ratio)
        i = i.resize((w, h), Image.ANTIALIAS)
    can = Canvas()
    x = y = 0

    try:
         i_converted = i.tobytes()
    except AttributeError:
         i_converted = i.tostring()

    for pix in i_converted:
        if pix < 128:
            can.set(x, y)
        x += 1
        if x >= w:
            y += 1
            x = 0

    info_json = urlopen('https://xkcd.com/info.0.json').read().decode('utf-8')
    info = json.loads(info_json)

    """
    redirect_url = "https://www.explainxkcd.com/wiki/api.php?{}".format(urlencode({
        'action': 'query',
        'titles': info['num'],
        'redirects': 'true',
        'format': 'json',
    }))
    redirect_request = Request(redirect_url, headers={'User-Agent': 'xkcd CLI tool'})
    redirect_json = urlopen(redirect_request).read().decode('utf-8')
    redirect = json.loads(redirect_json)

    redirect_to = redirect['query']['redirects'][0]['to']
    transcription_url = "https://www.explainxkcd.com/wiki/api.php?{}".format(urlencode({
        'action': 'parse',
        'page': redirect_to,
        'prop': 'text',
        'section': 2,
        'format': 'json',
        'disableeditsection': 'true',
    }))
    transcription_request = Request(transcription_url, headers={'User-Agent': 'xkcd CLI tool'})
    transcription_json = urlopen(transcription_request).read().decode('utf-8')
    transcription = json.loads(transcription_json)
    """

    print(("\033[92m{0}: {1}\033[0m".format(info['num'], info['title'])))
    print((can.frame()))
    print((''))
    print(("\033[1;31mAlt text\033[0m: {0}".format(info['alt'])))
    print((''))
    print(("\033[1;31mOriginal\033[0m: \033[96mhttps://xkcd.com/{0}\033[0m".format(info['num'])))
    print(("\033[1;31mExplanation\033[0m: \033[96mhttps://www.explainxkcd.com/wiki/index.php/{0}\033[0m".format(info['num'])))
    print((''))
