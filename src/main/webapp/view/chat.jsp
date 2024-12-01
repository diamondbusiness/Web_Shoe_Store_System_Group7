<!DOCTYPE html>
<html lang="en">
<head>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <title>Chat Room</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

        body {
            margin: 0;
            padding: 0;
            font-family: 'Poppins', sans-serif;
            background-color: #e8eaf6;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h2 {
            font-size: 2.5rem;
            color: #3f51b5;
            margin: 20px 0;
            text-align: center;
            font-weight: 600;
        }

        .chat-container {
            width: 100%;
            max-width: 900px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            display: flex;
            flex-direction: row;
            height: 90vh;
            overflow: hidden;
        }

        .customer-list {
            width: 25%;
            background-color: #f5f5f5;
            border-right: 1px solid #ddd;
            padding: 20px;
            overflow-y: auto;
        }

        .customer-item {
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 8px;
            background-color: #e3f2fd;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .customer-item:hover {
            background-color: #bbdefb;
        }

        .chat-box-container {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .chat-box {
            flex-grow: 1;
            overflow-y: auto;
            padding: 20px;
            background-color: #E4E0E1;
            border-radius: 15px;
            margin-bottom: 20px;
            display: flex;
            flex-direction: column;
        }

        .message-wrapper {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .message {
            padding: 12px;
            border-radius: 8px;
            font-size: 1rem;
            max-width: 80%;
            word-wrap: break-word;
            box-sizing: border-box;
        }

        .message.left {
            background-color: #FFE3E3;
            align-self: flex-start;
        }

        .message.right {
            background-color: #7AB2D3;
            color: white;
            align-self: flex-end;
            text-align: right;
        }

        .time {
            font-size: 0.8rem;
            color: #888;
            margin-top: 5px;
        }

        .input-box {
            display: flex;
            align-items: center;
            padding: 15px;
            background-color: #ffffff;
            border-top: 1px solid #ddd;
            border-radius: 0 0 15px 15px;
            box-shadow: 0 -5px 10px rgba(0, 0, 0, 0.1);
        }

        .input-box input {
            width: 80%;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 10px;
            font-size: 1rem;
            outline: none;
            transition: border 0.3s ease;
        }

        .input-box input:focus {
            border-color: #3f51b5;
        }

        .input-box button {
            width: 15%;
            padding: 15px;
            background-color: #3f51b5;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 1rem;
            margin-left: 10px;
            transition: background-color 0.3s ease;
        }

        .input-box button:hover {
            background-color: #303f9f;
        }

        .load-more {
            color: #007bff;
            text-align: center;
            cursor: pointer;
            font-size: 1rem;
            margin: 10px 0;
            font-weight: bold;
        }

        .load-more:hover {
            text-decoration: underline;
        }

        .no-more-msg {
            text-align: center;
            color: #888;
            font-size: 1rem;
            font-style: italic;
        }

        .date-separator {
            text-align: center;
            color: #888;
            font-size: 1rem;
            font-style: italic;
        }
    </style>
</head>
<body>

<div class="chat-container">
    <div id="customerList" class="customer-list" style="display: none;">
        <!-- Danh sách khách hàng -->
    </div>

    <div class="chat-box-container">
        <h2>Customer Support</h2>

        <div class="chat-box">
            <div id="loadMoreMessages" class="load-more" onclick="loadmore()">
                Xem thêm
            </div>
            <div class="message-wrapper" id="messageList">
                <!-- Tin nhắn sẽ được thêm vào đây -->
            </div>
        </div>

        <div class="input-box">
            <input type="text" id="message" placeholder="Type a message..." required>
            <button onclick="sendMessage()">Send</button>
        </div>
    </div>
</div>

<script>
    var socket;
    var userId = "";
    var currentChatId = 1;
    var loadMoreClicked = false;

    window.onload = function () {

        var userJson = `${userJson}`;  // Dùng phương thức toJson() để chuyển đối tượng thành chuỗi JSON

        socket = new WebSocket("ws://localhost:8080/JPAExample_war_exploded/chat");

        socket.onopen = function () {
            console.log("Connected to WebSocket");

            // Gửi chuỗi JSON qua WebSocket
            socket.send("user:" + userJson);
        };


        socket.onmessage = function (event) {
            var messageList = document.getElementById("messageList");

            // If it's a customer list message
            if (event.data.includes("customer-item")) {
                var customerList = document.getElementById("customerList");
                customerList.innerHTML = event.data; // Insert the customer list HTML

                // Display the customer list if it's the admin
                document.getElementById("customerList").style.display = "block";

            } else if (event.data === "noMoreMessages") {
                var noMoreMessageDiv = document.createElement("div");
                noMoreMessageDiv.classList.add("no-more-msg");
                noMoreMessageDiv.innerText = "Bạn đã xem hết tin nhắn!";
                messageList.insertBefore(noMoreMessageDiv, messageList.firstChild);
            } else {
                messageList.innerHTML = event.data;
                var chatBox = document.querySelector('.chat-box');
                if (loadMoreClicked) {
                    loadMoreClicked = false;
                } else {
                    chatBox.scrollTop = chatBox.scrollHeight;
                }
            }
        };

// Handle admin connection
        var userRole = '${role}';

        // Kiểm tra role trong JavaScript
        if (userRole === 1) {
            // Display customer list
            document.getElementById("customerList").style.display = "block";
        }

        socket.onclose = function () {
            console.log("WebSocket connection closed.");
        };

        socket.onerror = function (error) {
            console.log("WebSocket Error: " + error);
        };
    };

    function sendMessage() {
        var message = document.getElementById("message").value;
        if (message) {
            socket.send(message);
            document.getElementById("message").value = "";
        }
    }

    function loadmore() {
        loadMoreClicked = true;
        socket.send("loadMoreMessages");
    }
    function switchChat(customerId) {
        currentChatId = customerId;
        socket.send("switchChat:" + customerId);
    }
</script>
</body>
</html>
