const socket = io('http://localhost:5000', {
  auth: {
    authorization: '123',
  },
  query: {
    page: 1,
    limit: 1,
  },
  withCredentials: true,
  transports: ['websocket', 'polling'], // USE ['polling', 'websocket'] OR DELETED IT
});

const message = document.getElementById('message');
const messages = document.getElementById('messages');

const handleSubmitNewMessage = () => {
  socket.emit('sendMessage', { data: message.value, type: 'text' });
};

socket.on('sendMessage', (data) => {
  handleNewMessage(data);
});

const handleNewMessage = (message) => {
  messages.appendChild(buildNewMessage(message));
};

const buildNewMessage = (message) => {
  const li = document.createElement('li');
  li.appendChild(document.createTextNode(message));
  return li;
};
