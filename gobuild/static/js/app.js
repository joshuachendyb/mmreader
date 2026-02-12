// Mermaid.js 配置和初始化

// 全局配置
window.mermaidConfig = {
    startOnLoad: false,
    theme: 'default',
    flowchart: {
        useMaxWidth: true,
        htmlLabels: true,
        curve: 'basis',
        diagramPadding: 20,
        htmlLabels: true
    },
    sequence: {
        useMaxWidth: true,
        noteFont: 'normal 14px 'trebuchet ms', verdana, arial, sans-serif',
        actorFontSize: 14,
        messageFontSize: 14,
        messageFont: 'normal 14px 'trebuchet ms', verdana, arial, sans-serif',
        mirrorActors: true,
        bottomMarginAdj: 1,
        width: 100%
    },
    gantt: {
        titleTopMargin: 25,
        barHeight: 20,
        barGap: 4,
        topPadding: 50,
        sidePadding: 75,
        useMaxWidth: true,
        gridLineStartPadding: 8,
        fontSize: 11,
        fontFamily: ''trebuchet ms', verdana, arial, sans-serif',
        numberSectionStyles: 4,
        axisFormatter: [[
            [%Y-%m-%d, function(d) {
                return d;
            }]
        ]]
    },
    pie: {
        displayPercentages: true,
        piePadAngle: 0,
        pieInnerRadius: 0,
        pieMargin: 0,
        pieStartAngle: 0,
        showBorder: true,
        font: '14px 'trebuchet ms', verdana, arial, sans-serif'
    },
    journey: {
        diagramPadding: 20,
        useMaxWidth: true,
        actorFontSize: 14,
        actorFont: 'normal 14px 'trebuchet ms', verdana, arial, sans-serif',
        sectionFontSize: 14,
        sectionFont: 'normal 14px 'trebuchet ms', verdana, arial, sans-serif'
    },
    er: {
        diagramPadding: 20,
        useMaxWidth: true,
        fill: '#f9f9f9',
        stroke: '#666',
        stroke-width: 1,
        font: '14px 'trebuchet ms', verdana, arial, sans-serif'
    },
    class: {
        diagramPadding: 20,
        useMaxWidth: true,
        fill: '#f9f9f9',
        stroke: '#666',
        stroke-width: 1,
        font: '14px 'trebuchet ms', verdana, arial, sans-serif'
    },
    state: {
        diagramPadding: 20,
        useMaxWidth: true,
        fill: '#f9f9f9',
        stroke: '#666',
        stroke-width: 1,
        font: '14px 'trebuchet ms', verdana, arial, sans-serif'
    }
};

// 初始化Mermaid
function initMermaid() {
    mermaid.initialize(mermaidConfig);
}

// 渲染Mermaid图表
document.addEventListener('DOMContentLoaded', function() {
    initMermaid();
    
    // 监听内容变化
    const editor = document.getElementById('editor');
    if (editor) {
        let timer;
        editor.addEventListener('input', function() {
            clearTimeout(timer);
            timer = setTimeout(() => {
                renderPreview();
            }, 500);
        });
    }
});

// 渲染预览
function renderPreview() {
    const content = document.getElementById('editor').innerText;
    const mermaidCode = extractMermaidCode(content);
    
    if (mermaidCode.trim() === '') {
        return;
    }
    
    const preview = document.getElementById('preview');
    preview.innerHTML = '';
    
    mermaid.render('mermaid-preview', mermaidCode, function(svgCode) {
        preview.innerHTML = svgCode;
        
        // 添加动画效果
        const paths = preview.querySelectorAll('path, line, polyline, polygon');
        paths.forEach(path => {
            path.style.opacity = '0';
            path.style.transition = 'opacity 0.5s ease';
            setTimeout(() => {
                path.style.opacity = '1';
            }, 100);
        });
    });
}

// 提取Mermaid代码
function extractMermaidCode(content) {
    const regex = /```mermaid([\s\S]*?)```/g;
    let match;
    let result = '';
    
    while ((match = regex.exec(content)) !== null) {
        result += match[1] + '\n';
    }
    
    return result.trim() || 'graph TD;A-->B;';
}

// 切换主题
function toggleTheme() {
    const body = document.body;
    const isDark = body.classList.contains('dark');
    body.classList.toggle('dark', !isDark);
    body.classList.toggle('light', isDark);
    
    // 重新初始化Mermaid
    mermaid.initialize({
        theme: isDark ? 'dark' : 'default'
    });
    
    renderPreview();
}

// 导出SVG
document.getElementById('export-svg')?.addEventListener('click', function() {
    const svg = document.querySelector('#preview svg');
    if (svg) {
        const serializer = new XMLSerializer();
        const svgData = serializer.serializeToString(svg);
        
        const svgBlob = new Blob([svgData], { type: 'image/svg+xml' });
        const url = URL.createObjectURL(svgBlob);
        const link = document.createElement('a');
        link.href = url;
        link.download = 'mermaid-chart.svg';
        link.click();
        URL.revokeObjectURL(url);
    }
});

// 导出PNG
document.getElementById('export-png')?.addEventListener('click', function() {
    const svg = document.querySelector('#preview svg');
    if (svg) {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        
        const width = svg.width.baseVal.value;
        const height = svg.height.baseVal.value;
        
        canvas.width = width;
        canvas.height = height;
        
        const img = new Image();
        img.onload = function() {
            ctx.drawImage(img, 0, 0);
            const pngUrl = canvas.toDataURL('image/png');
            
            const link = document.createElement('a');
            link.href = pngUrl;
            link.download = 'mermaid-chart.png';
            link.click();
        };
        
        const svgData = new XMLSerializer().serializeToString(svg);
        img.src = 'data:image/svg+xml;base64,' + btoa(unescape(encodeURIComponent(svgData)));
    }
});

// 自动调整预览大小
function adjustPreviewSize() {
    const preview = document.getElementById('preview');
    if (preview) {
        const svg = preview.querySelector('svg');
        if (svg) {
            svg.style.maxWidth = '100%';
            svg.style.height = 'auto';
        }
    }
}

// 监听窗口大小变化
document.addEventListener('DOMContentLoaded', function() {
    window.addEventListener('resize', adjustPreviewSize);
    
    // 初始调整
    setTimeout(adjustPreviewSize, 100);
});

// 键盘快捷键
document.addEventListener('keydown', function(e) {
    // Ctrl/Cmd + O 打开文件
    if ((e.ctrlKey || e.metaKey) && e.key === 'o') {
        e.preventDefault();
        document.getElementById('open-file-btn').click();
    }
    
    // Ctrl/Cmd + R 重新加载
    if ((e.ctrlKey || e.metaKey) && e.key === 'r') {
        e.preventDefault();
        document.getElementById('reload-btn').click();
    }
    
    // Ctrl/Cmd + S 保存文件（在浏览器中可能无法直接使用）
    if ((e.ctrlKey || e.metaKey) && e.key === 's') {
        e.preventDefault();
        alert('保存功能在本地应用中实现');
    }
    
    // F5 刷新预览
    if (e.key === 'F5') {
        e.preventDefault();
        document.getElementById('refresh-preview').click();
    }
});

// 错误处理
window.addEventListener('error', function(e) {
    console.error('JavaScript 错误:', e.error);
    
    // 在预览区域显示错误信息
    const preview = document.getElementById('preview');
    if (preview) {
        preview.innerHTML = `
            <div style="color: red; padding: 20px; text-align: center;">
                <h3>图表渲染失败</h3>
                <p>错误信息: </p>
                <pre>${e.error.message}</pre>
            </div>
        `;
    }
});

// 性能监控
document.addEventListener('DOMContentLoaded', function() {
    if ('performance' in window) {
        window.addEventListener('load', function() {
            const perfData = performance.getEntriesByType('navigation')[0];
            console.log(
                `页面加载时间: ${perfData.loadEventEnd - perfData.loadEventStart}ms\n` +
                `DOM解析时间: ${perfData.domContentLoadedEventEnd - perfData.domContentLoadedEventStart}ms`
            );
        });
    }
});