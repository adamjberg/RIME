import socket

UDP_IP = "206.87.153.137"

UDP_PORT = 12000

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

while True:
    data, addr = sock.recvfrom(1024)
    print "received message:", ":".join("{:02x}".format(ord(c)) for c in data)