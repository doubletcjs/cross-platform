let BrowserWindow = require('electron').remote.BrowserWindow;
let win;

let button = window.document.querySelector('#btn');

button.onclick = () => {
    alert('点击了');
    win = new BrowserWindow({
        width: 320,
        height: 480,
        frame: false,
        fullscreen: true
    });
    win.loadURL(`file://${__dirname}/news.html`);
    win.on('closed', () => {
        win = null;
    });
}