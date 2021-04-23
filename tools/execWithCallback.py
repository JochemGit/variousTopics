#!/usr/bin/env python3

import sys
import threading
from http.server import BaseHTTPRequestHandler, HTTPServer
import logging
import time

import os
import requests

httpd = None
recvCallback = False

class S(BaseHTTPRequestHandler):
    def _set_response(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        logging.info("GET request,\nPath: %s\nHeaders:\n%s\n", str(self.path), str(self.headers))
        self._set_response()
        self.wfile.write("GET request for {}".format(self.path).encode('utf-8'))

    def do_POST(self):
        content_length = int(self.headers['Content-Length']) # <--- Gets the size of data
        post_data = self.rfile.read(content_length) # <--- Gets the data itself
        logging.info("POST request,\nPath: %s\nHeaders:\n%s\n\nBody:\n%s\n",
                str(self.path), str(self.headers), post_data.decode('utf-8'))
#        print('CALLBACK BODY: <<<<'+post_data.decode('utf-8')+'>>>>')
        print(post_data.decode('utf-8'))
        self._set_response()
        self.wfile.write("POST request for {}".format(self.path).encode('utf-8'))
        global recvCallback
        recvCallback = True

    def log_message(self, format, *args):
        return

def run(server_class=HTTPServer, handler_class=S, port=8000, startedEvt=None):
    server_address = ('', port)
    global httpd
    httpd = server_class(server_address, handler_class)
    logging.info('Starting httpd...\n')
    if startedEvt is not None:
        startedEvt.set()
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    httpd.server_close()
    logging.info('Stopping httpd...\n')

def invokeRest(port, data=None):
    url = 'http://localhost:'+port+'/'
    if data is None:
        data = '''{
  "host_fqdn":"sgdcm0005406.con-02.emea.dc.corpintra.net",
  "host_ip":"53.136.21.4",
  "status_code":"0",
  "status_msg":"Success",
  "error_msg":"","order_id":"SCTASK0103867"
}'''
    response = requests.post(url, data=data)
#    print('#### '+str(response)+' ####')
#    print('#### '+str(response.url)+' ####')
#    print('#### '+str(response.encoding)+' ####')
#    print('#### '+str(response.headers)+' ####')
#    print('#### '+str(response.text)+' ####')
##    print('#### '+str(response.json())+' ####')
#    print('#### '+str(response.content)+' ####')

if __name__ == '__main__':
    logging.basicConfig(level=logging.WARNING)
    port=8000
    if len(sys.argv) >= 2:
        port = int(sys.argv[1])
    message = None
    if len(sys.argv) >= 3:
        message = str(sys.argv[2])
    startedEvt = threading.Event()
    st = threading.Thread(target=run, kwargs={'startedEvt': startedEvt,'port': port})
    st.start()
    startedEvt.wait()
#    os.system('./testCurl.sh')
    invokeRest(str(port), data=message)
    timeout = 1
    timer = timeout * 60
    while timer > 0 and not recvCallback:
        time.sleep(1)
        timer -= 1
    httpd.shutdown()
