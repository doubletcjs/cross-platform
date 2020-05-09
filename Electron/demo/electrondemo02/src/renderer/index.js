var fs = require('fs');

onload = () => {
    var btn = document.querySelector('#btn');
    var textarea = document.querySelector('#textarea');

    btn.onclick = () => {
        fs.readFile('package.json', (error, data) => {
            textarea.innerHTML = data;
        })
    }

    var content = document.querySelector('.content');
    content.ondragenter = (res) => {
        return false;
    }


    content.ondragover = (res) => {
        return false;
    }

    content.ondragleave = (res) => {
        return false;
    }

    content.ondrop = (res) => {
        var dataTransfer = res.dataTransfer;
        if (dataTransfer.files.length > 0) {
            var file = dataTransfer.files[0];
            var path = file.path;
            fs.readFile(path, 'utf-8', (error, data) => {
                if (error) {
                    console.log(error);
                } else {
                    content.innerHTML = data;
                }
            });
        }

        return false;
    }
}