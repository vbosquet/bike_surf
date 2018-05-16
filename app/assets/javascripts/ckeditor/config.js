CKEDITOR.editorConfig = function (config) {
  // ... other configuration ...

  config.extraPlugins = 'wordcount';

  config.toolbar_mini = [
    ['Bold','Italic','Underline','Strike'],
    ['NumberedList','BulletedList','-','Outdent','Indent'],
    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
    ['Link','Unlink'],
    ['Table'],
    ['Styles','Format','Font','FontSize'],
    ['TextColor','BGColor']
  ];
  config.toolbar = "mini";
  config.allowedContent = true;
  config.wordcount = {
    // Whether or not you want to show the Paragraphs Count
    showParagraphs: false,

    // Whether or not you want to show the Word Count
    showWordCount: false,

    // Whether or not you want to show the Char Count
    showCharCount: true,

    // Whether or not you want to count Spaces as Chars
    countSpacesAsChars: false,

    // Whether or not to include Html chars in the Char Count
    countHTML: false,

    // Whether or not to include Line Breaks in the Char Count
    countLineBreaks: false,

    // Maximum allowed Word Count, -1 is default for unlimited
    maxWordCount: -1,

    // Maximum allowed Char Count, -1 is default for unlimited
    maxCharCount: 2500,

    // How long to show the 'paste' warning, 0 is default for not auto-closing the notification
    pasteWarningDuration: 0,

    filter: new CKEDITOR.htmlParser.filter({
        elements: {
            div: function( element ) {
                if(element.attributes.class == 'mediaembed') {
                    return false;
                }
            }
        }
    })
  }

  // ... rest of the original config.js  ...
}
