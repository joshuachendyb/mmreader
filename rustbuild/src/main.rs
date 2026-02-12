use std::path::PathBuf;
use rust_embed::RustEmbed;

// 嵌入静态资源
#[derive(RustEmbed)]
#[folder = "static/"]
struct Asset;

fn main() -> anyhow::Result<()> {
    // 简单的日志输出
    println!("MermaidReader 启动中...");
    
    // 获取应用目录
    let app_dir = get_app_dir()?;
    std::fs::create_dir_all(&app_dir)?;
    
    // 解压静态资源
    extract_static_resources(&app_dir)?;
    
    // 创建 WebView 窗口
    create_webview()?;
    
    Ok(())
}

fn create_webview() -> anyhow::Result<()> {
    use wry::application::{
        application::Application,
        event_loop::{ControlFlow, EventLoop},
        window::{Window, WindowBuilder},
    };
    use wry::webview::{Webview, WebViewBuilder};

    let event_loop = EventLoop::new();
    let window = WindowBuilder::new()
        .with_title("MermaidReader - 图表阅读器")
        .with_inner_size(wry::application::dpi::LogicalSize::new(1200.0, 800.0))
        .build(&event_loop)?;

    // 使用嵌入式 HTML
    let html_content = match Asset::get("index.html") {
        Some(content) => std::str::from_utf8(&content.data).unwrap_or("").to_string(),
        None => return Err(anyhow::anyhow!("无法加载 index.html")),
    };

    let webview = WebViewBuilder::new(&window)?
        .with_html(&html_content)?
        .with_devtools(false)
        .build()?;

    event_loop.run(move |event, _, control_flow| {
        *control_flow = ControlFlow::Wait;

        match event {
            wry::application::event::Event::WindowEvent {
                event: wry::application::event::WindowEvent::CloseRequested,
                ..
            } => *control_flow = ControlFlow::Exit,
            _ => {}
        }
    });

    Ok(())
}

fn get_app_dir() -> anyhow::Result<PathBuf> {
    let app_dir = if cfg!(target_os = "windows") {
        dirs::config_local_dir()
            .ok_or_else(|| anyhow::anyhow!("无法获取配置目录"))?
            .join("MermaidReader")
    } else {
        dirs::home_dir()
            .ok_or_else(|| anyhow::anyhow!("无法获取主目录"))?
            .join(".mermaidreader")
    };

    Ok(app_dir)
}

fn extract_static_resources(app_dir: &PathBuf) -> anyhow::Result<()> {
    // 检查是否需要解压
    let index_file = app_dir.join("index.html");
    if index_file.exists() {
        return Ok(());
    }

    println!("解压静态资源到: {:?}", app_dir);
    
    for path in Asset::iter() {
        if let Some(content) = Asset::get(&path) {
            let file_path = app_dir.join(path.as_ref());
            
            // 创建目录
            if let Some(parent) = file_path.parent() {
                std::fs::create_dir_all(parent)?;
            }
            
            // 写入文件
            std::fs::write(&file_path, content.data)?;
        }
    }

    println!("静态资源解压完成");
    Ok(())
}