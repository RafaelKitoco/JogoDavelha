# Tic-Tac-Toe with Socket

This project implements the classic **Tic-Tac-Toe** game in Python using the `tkinter` library for the graphical interface and `socket` to allow two players to play remotely. The game is split between a server and a client, where the server creates the game and the client connects to it to play.

## Requirements

- Python 3.x
- Libraries: `tkinter`, `socket` (both come pre-installed with Python)

## Functionality

- **Server**: The server starts the game and waits for a client to connect. Once the client connects, the server sends and receives the moves of both players.
- **Client**: The client connects to the server and sends its moves. The client also receives the moves from the server and updates the graphical interface accordingly.

### Game Rules

- Two players, **X** and **O**, take turns.
- The first player to align `n` symbols (horizontally, vertically, or diagonally) wins.
- If the board is full without a winner, the game ends in a draw.

1. **To run the server, open the terminal or command prompt and execute the following**:

   ```bash
   python server.py

## Gerar Secrete Key

1. **To run the client, open the terminal or command prompt and execute the following code:**
   ```bash
   python client.py


# Code Explanation
server.py File

The server creates the game interface and waits for a client to connect. Once the client connects, the server sends the moves made by the players to the other participant and manages the game state (win, draw, etc.).
client.py File

The client connects to the server, sends the player's moves, and updates the game interface as the other player makes moves.
Technical Details

    Graphical Interface: The game interface is created using tkinter. The board is displayed in a grid with clickable buttons. When a button is clicked, the move is recorded and sent to the other player via socket.
    Communication via Socket: Communication between the server and client is done via socket. The server sends and receives the moves from the players and also notifies the other player about the win, draw, or the move made.

## Threading

The use of threading in this game is crucial for allowing the server and client to handle socket communication asynchronously while still updating the graphical user interface (tkinter).

    In the Server: The server uses a separate thread to handle communication with the client. This allows the server to listen for moves and updates from the client in parallel with managing the game logic.
        A new thread is started when the client connects, and this thread listens for incoming messages from the client (such as moves or game-over messages). By using threading, the server can continue checking for client moves without freezing the game interface or affecting other logic.

    In the Client: The client also uses threading to handle receiving messages from the server while still allowing the user to interact with the game through the graphical interface. The client listens for messages like move instructions and game-over notifications, updating the interface when the server sends them.
        The client uses a separate thread to listen for messages from the server, which ensures that the main thread (responsible for the graphical interface) is not blocked while waiting for server messages.

By using threads, both the server and client can send and receive messages simultaneously, ensuring the game updates in real-time without blocking user input or UI updates.
Threading Example in the Client

In the client, a thread is created to listen for incoming messages from the server:


    import threading

    def listen_for_server_messages():
        while True:
        message = client_socket.recv(1024).decode()
        if message.startswith("move"):
            # Process move
        elif message == "victory" or message  == "draw":
            # Process game end
        # Other conditions...

# Starting the listening thread
    threading.Thread(target=listen_for_server_messages, daemon=True).start()

## Communication via Socket

Communication between the server and client is done via socket. The server sends and receives the moves from the players and also notifies the other player about the win, draw, or the move made.
Communication Examples

    Move: When a player makes a move, the message sent is in the format:

    move i j

    Where i and j are the coordinates on the board (row and column).

    Victory: When a player wins, the message sent is:

    victory X  # or victory O

    Draw: If the game ends in a draw, the message sent is:

    draw

# Contributions

Feel free to contribute improvements, fixes, or new features. To contribute, follow these steps:
Fork this repository.
    
    Create a branch for your modification (git checkout -b my-modification).
    Make the desired changes.
    Commit your changes (git commit -am 'Adding new feature').
    Push to the remote repository (git push origin my-modification).
    Open a Pull Request.