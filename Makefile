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
	@$(PY) $(SERVER) &    # Run server in the background
	@sleep 1              # Small delay to ensure server is ready
	$(PY) $(CLIENT)       # Then run client

$(SERVER):
	# Server target is now a dependency, nothing extra needed here
	@echo "Server will be started in background"

# Clean up
clean:
	@$(RM) $(OBJ_CLIENT) $(OBJ_SERVER)

# Full clean
fclean: clean
	@$(RM) $(CLIENT) $(SERVER)

# Rebuild everything
re: fclean all