

  CKEDITOR.editorConfig = function( config ) {
      // config.language = 'en';
      config.language = 'en';
      config.language_list = [ 'en:English'];
      config.uiColor = '#AADC6E';
      // config.setLang = ('dialog', 'en');
      // config.setLang = ('lineutils', 'en');
      // config.setLang = ('widget', 'en');
      // config.setLang = ('codesnippet', 'en');
      // config.extraPlugins = 'image2';
      // config.filebrowserUploadMethod = 'form';
      config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

      // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
      config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

      // The location of a script that handles file uploads in the Flash dialog.
      config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

      // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
      config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

      // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
      config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

      // The location of a script that handles file uploads in the Image dialog.
      config.filebrowserImageUploadUrl = "/ckeditor/pictures?command=QuickUpload&type=Images";

      // The location of a script that handles file uploads.
      config.filebrowserUploadUrl = "/ckeditor/attachment_files";
      config.stylesSet = [
        { name: 'Video embed', element: 'div',  attributes: {'class': 'video-embed'}}
      ];
      // Rails CSRF token
      config.filebrowserParams = function(){
        var csrf_token, csrf_param, meta,
            metas = document.getElementsByTagName('meta'),
            params = new Object();

        for ( var i = 0 ; i < metas.length ; i++ ){
          meta = metas[i];

          switch(meta.name) {
            case "csrf-token":
              csrf_token = meta.content;
              break;
            case "csrf-param":
              csrf_param = meta.content;
              break;
            default:
              continue;
          }
        }

        if (csrf_param !== undefined && csrf_token !== undefined) {
          params[csrf_param] = csrf_token;
        }

        return params;
      };

      config.allowedContent = {
          $1: {
              // Use the ability to specify elements as an object.
              elements: CKEDITOR.dtd,
              attributes: true,
              styles: true,
              classes: true
          }
      };
      // config.stylesSet = 'my_styles';
      config.disallowedContent = 'script; span; *[on*]; font; *{*}';
  };



