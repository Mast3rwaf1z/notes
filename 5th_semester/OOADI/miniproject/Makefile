compiler = mvn clean compile package
client_flags = -f ./chat/client_pom.xml -q
server_flags = -f ./chat/server_pom.xml -q

compile:
	$(compiler) $(client_flags)
	mv ./chat/target/chat-1.0.jar client.jar
	$(compiler) $(server_flags)
	mv ./chat/target/chat-1.0.jar server.jar


run: compile
	screen -dmS server konsole -e java -jar server.jar
	
	screen -dmS client konsole -e java -jar client.jar 1
	screen -dmS client konsole -e java -jar client.jar 2
	