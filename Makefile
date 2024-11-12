# Define variables
PY = python3
RM = rm -f

CLIENT = client.py
SERVER = server.py

.PHONY: all clean fclean re $(CLIENT) $(SERVER)

# Default target
all: $(CLIENT) $(SERVER)

# Start server in the background, then start client
$(CLIENT): $(SERVER)
	@echo "Killing any process using port 12345..."
	@PID=$(shell sudo lsof -t -i:12345) && \
		if [ ! -z "$(PID)" ]; then \
			sudo kill -9 $(PID); \
			echo "Killed process on port 12345."; \
		else \
			echo "No process using port 12345."; \
		fi
	@nohup $(PY) $(SERVER) &     # Run server in the background
	@sleep 2              # Small delay to ensure server is ready
	@echo "Waiting for the server to be ready..."
	@while ! nc -z localhost 12345; do sleep 1; done  # Espera até o servidor estar ouvindo
	$(PY) $(CLIENT)       # Then run client

$(SERVER):
	# Server target is now a dependency, nothing extra needed here
	@echo "Server will be started in background"

# Clean up
clean:
	$(RM) *.o *.exe   # Limpeza de arquivos gerados durante o build

# Force clean up
fclean: clean
	$(RM) *.log        # Caso tenha arquivos de log para remover (adapte conforme necessário)

# Rebuild everything
re: fclean all