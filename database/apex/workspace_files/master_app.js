//
// COPY TO CLIPBOARD
//
var copy_to_clipboard = function (text) {
    var dummy = document.createElement('textarea');
    document.body.appendChild(dummy);
    dummy.value = text;
    dummy.select();
    document.execCommand('copy');
    document.body.removeChild(dummy);
}



//
// CREATE COLORFUL IG/IR CELLS
//
const color_cell = function (options, value, title, color_bg, color_text) {
    if (value && value.length && ((color_bg && color_bg.length) || (color_text && color_text.length))) {
        options.defaultGridColumnOptions = {
            cellTemplate: '<div style="background: ' + color_bg + '; color: ' + color_text + ';" title="' + title + '">' + value + '</div>'
        };
    }
    else {
        options.defaultGridColumnOptions = {
            cellTemplate: '<span title="' + title + '">' + value + '</span>'
        };
    }
    return options;
}

