from socket import AF_INET, SOCK_STREAM, socket

s = socket(AF_INET, SOCK_STREAM)
s.connect(("localhost", 8888))
s.send(bytes("test\n", "utf-8"))
s.close()