#!/usr/bin/env python
# Forwards the received webhooks to the specified url list (POST only)

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
import string
import argparse
import requests
import re

class RequestHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        self.send_response(404)

    def do_POST(self):

        request_headers = self.headers
        content_length = request_headers.getheaders('content-length')
        length = int(content_length[0]) if content_length else 0
        args = self.rfile.read(length).split('&')
        data = dict()
        try:
            for arg in args:
                val = arg.split('=', 1)
                data[val[0]] = val[1]
        except:
            self.send_response(404)
            return

        self.send_response(200)
        self.finish()
        self.connection.close()

        headers = dict()
        for key in request_headers.keys():
            headers[key] = request_headers.getheaders(key)

        for url in self.server.urls:
            if url == '':
                continue
            req = requests.post(url, data=data, headers=headers)
            host = re.search(r'://(?P<host>[^/]+)/', url).group('host')
            headers['host'] = host
            if not req.ok:
                lang = re.search(r'language=(?P<lang>[a-zA-Z-]+)', url).group('lang')
                print '%s: hook returned %d -> %s' % (lang.upper(), req.status_code, url)
        print '  finished triggering hooks'

    do_PUT = do_GET
    do_DELETE = do_GET

class CustomServer(HTTPServer):
    def __init__(self, server_address, RequestHandlerClass, urls):
        HTTPServer.__init__(self, server_address, RequestHandlerClass)
        self.urls = urls

def main(urls):
    with open(urls) as url_f:
        url_list = [string.strip(u) for u in url_f.readlines()]
        port = 59882
        print 'Listening on *:%s' % port
        server = CustomServer(('', port), RequestHandler, url_list)
        server.serve_forever()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Wait for hooks and forwards them to a list of urls.")
    parser.add_argument('urls', nargs=1, type=str, help="file with the list of urls, one per line")
    args = parser.parse_args()
    main(args.urls[0])

