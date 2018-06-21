XML  = open('1.xml' ).read()
JSON = open('2.json').read()

import socket
import threading

class Pusher(threading.Thread):
    def __init__(self):
        threading.Thread.__init__(self)
    def run(self):
        self.S = socket.socket()
        print self.S.connect(('127.0.0.1',8001))
    
TH = []
for i in range(1):
    T = Pusher() ; TH.append(T)
print TH
map(lambda i:i.start(), TH)
print TH
map(lambda i:i.join(), TH)
print TH
