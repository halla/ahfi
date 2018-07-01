socket.connect()


let Form = {
  init(socket, element) { if (!element) { return; }
    let postId = element.getAttribute("data-id");
    socket.connect();

  }
};
// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("topic:subtopic", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
