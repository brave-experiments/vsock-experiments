use futures::StreamExt;
use tokio::io::AsyncWriteExt;
use tokio_vsock::VsockListener;

#[tokio::main]
async fn main() {
    let listener = VsockListener::bind(4, 1234).expect("Failed to bind to address");

    let mut incoming = listener.incoming();
    while let Some(result) = incoming.next().await {
        if let Ok(mut stream) = result {
            tokio::spawn(async move {
                let response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

                stream.write_all(response.as_bytes()).await.ok();
            });
        }
    }
}
