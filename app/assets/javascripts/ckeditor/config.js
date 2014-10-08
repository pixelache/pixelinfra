CKEDITOR.editorConfig = function( config ) {
    config.language = 'en';
    config.uiColor = '#AADC6E';
    config.plugins = ['image', 'filebrowser'];
    config.allowedContent = {
        $1: {
            // Use the ability to specify elements as an object.
            elements: CKEDITOR.dtd,
            attributes: true,
            styles: true,
            classes: true
        }
    };
    config.disallowedContent = 'script; span; *[on*]; *{*}';
};