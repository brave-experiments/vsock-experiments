use futures::StreamExt;
use std::net::Shutdown;
use std::process::exit;
use std::time::Duration;
use tokio::io::AsyncWriteExt;
use tokio::time::sleep;
use tokio_vsock::VsockListener;

#[tokio::main]
async fn main() {
    let listener = VsockListener::bind(4, 8080).expect("Failed to bind to address");

    tokio::spawn(async {
        sleep(Duration::from_secs(30)).await;
        println!("I'm out!");
        exit(0);
    });

    let mut incoming = listener.incoming();
    while let Some(result) = incoming.next().await {
        if let Ok(mut stream) = result {
            tokio::spawn(async move {
                let response = "HTTP/1.1 200 OK\r\nContent-Type: text/plain\r\n\r\nHello, World!";

                stream.write_all(response.as_bytes()).await.ok();
                stream.shutdown(Shutdown::Both).ok();
            });
        }
    }
}
