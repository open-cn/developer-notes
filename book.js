module.exports = {
    // 书的标题
    "title": "开发者笔记",
    "description": "",
    // 语言
    "language":"zh-hans",
    // 插件
    "plugins": [
        // 添加插件
        "summary",
        "code",
        // 去掉插件
        // "-highlight",
        "-lunr",
        "-search",
        "-sharing",
        "-fontsettings",
        // "-livereload",
    ],
    // 插件的配置
    "pluginsConfig": {
        "fontsettings": {
            "theme": 'white', // 'sepia', 'night' or 'white',
            "family": 'sans', // 'serif' or 'sans',
            "size": 2         // 1 - 4
        },
        "code": {             // code 插件配置了一个参数
            "copyButtons": true
        }
    }
}
