compiler = mvn compile package
sensorFlags = -f sensor -q
serverFlags = -f server -q
outdir = ./jars
runtime = java -jar

nodeCount = 4
nodes = $(shell seq -s " " $(nodeCount))

compile:
	@echo "Compiling..."
	@$(compiler) $(sensorFlags)
	@mv sensor/target/sensor-0.0a.jar $(outdir)/sensor.jar
	@$(compiler) $(serverFlags)
	@mv server/target/server-0.0a.jar $(outdir)/server.jar

run: compile
	@echo "Creating a server..."
	@screen -dmS server konsole -e $(runtime) $(outdir)/server.jar
	@echo "Creating $(nodeCount) sensors..."
	@$(foreach node, $(nodes), screen -dmS node konsole -e $(runtime) $(outdir)/node.jar $(nodeCount) 10.225.171.50;)

clean:
	@echo "cleaning repository..."
	@mvn clean $(sensorFlags)
	@mvn clean $(serverFlags)
