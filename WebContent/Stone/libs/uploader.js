/**
 * File:
 * User: dshi
 * Date: 7/14/2015 3:49 PM
 * Copyright (c) 2015 MicroStrategy Incorporated. All rights reserved.
 */
jQuery.extend({


    handleError: function( s, xhr, status, e )      {
        // If a local callback was specified, fire it
        if ( s.error ) {
            s.error.call( s.context || s, xhr, status, e );
        }

        // Fire the global callback
        if ( s.global ) {
            (s.context ? jQuery(s.context) : jQuery.event).trigger( "ajaxError", [xhr, s, e] );
        }
    },

    createUploadIframe: function (id, uri) {
        //create frame
        var frameId = 'jUploadFrame' + id;
        var iframeHtml = '<iframe id="' + frameId + '" name="' + frameId + '" style="position:absolute; top:-9999px; left:-9999px"';
        if (window.ActiveXObject) {
            if (typeof uri == 'boolean') {
                iframeHtml += ' src="' + 'javascript:false' + '"';

            }
            else if (typeof uri == 'string') {
                iframeHtml += ' src="' + uri + '"';

            }
        }
        iframeHtml += ' />';
        jQuery(iframeHtml).appendTo(document.body);

        return jQuery('#' + frameId).get(0);
    },
    createUploadForm: function (id, fileElementId, data) {
        //create form
        var formId = 'jUploadForm' + id;
        var fileId = 'jUploadFile' + id;
        var form = jQuery('<form  action="" method="POST" name="' + formId + '" id="' + formId + '" enctype="multipart/form-data"></form>');
        if (data) {
            for (var i in data) {
                jQuery('<input type="hidden" name="' + i + '" value="' + data[i] + '" />').appendTo(form);
            }
        }
        var oldElement = jQuery('#' + fileElementId);
        var newElement = jQuery(oldElement).clone();
        jQuery(oldElement).attr('id', fileId);
        jQuery(oldElement).before(newElement);
        jQuery(oldElement).appendTo(form);


        //set attributes
        jQuery(form).css('position', 'absolute');
        jQuery(form).css('top', '-1200px');
        jQuery(form).css('left', '-1200px');
        jQuery(form).appendTo('body');
        return form;
    },

    ajaxFileUpload: function (uploadOptions) {
        // TODO introduce global settings, allowing the client to modify them for all requests, not only timeout
        uploadOptions = jQuery.extend({}, jQuery.ajaxSettings, uploadOptions);
        var id = new Date().getTime();
        var form = jQuery.createUploadForm(id, uploadOptions.fileElementId, (typeof(uploadOptions.data) == 'undefined' ? false : uploadOptions.data));
        var io = jQuery.createUploadIframe(id, uploadOptions.secureuri);
        var frameId = 'jUploadFrame' + id;
        var formId = 'jUploadForm' + id;

        // Watch for a new set of requests
        if (uploadOptions.global && !jQuery.active++) {
            jQuery.event.trigger("ajaxStart");
        }

        // Create the request object
        var requestDone = false;
        var xml = {}
        if (uploadOptions.global)
            jQuery.event.trigger("ajaxSend", [xml, uploadOptions]);

        // Wait for a response to come back
        var uploadCallback = function (isTimeout) {
            io = document.getElementById(frameId);
            try {
                if (io.contentWindow) {
                    xml.responseText = io.contentWindow.document.body ? io.contentWindow.document.body.innerHTML : null;
                    xml.responseXML = io.contentWindow.document.XMLDocument ? io.contentWindow.document.XMLDocument : io.contentWindow.document;

                } else if (io.contentDocument) {
                    xml.responseText = io.contentDocument.document.body ? io.contentDocument.document.body.innerHTML : null;
                    xml.responseXML = io.contentDocument.document.XMLDocument ? io.contentDocument.document.XMLDocument : io.contentDocument.document;
                }
            } catch (e) {
                jQuery.handleError(uploadOptions, xml, null, e);
            }

            if (xml || isTimeout == "timeout") {
                requestDone = true;
                var status;
                try {
                    status = isTimeout != "timeout" ? "success" : "error";
                    // Make sure that the request was successful or notmodified
                    if (status != "error") {
                        // process the data (runs the xml through httpData regardless of callback)
                        var data = jQuery.uploadHttpData(xml, uploadOptions.dataType);
                        // If a local callback was specified, fire it and pass it the data
                        if (uploadOptions.success)
                            uploadOptions.success(data, status);

                        // Fire the global callback
                        if (uploadOptions.global)
                            jQuery.event.trigger("ajaxSuccess", [xml, uploadOptions]);
                    } else
                        jQuery.handleError(uploadOptions, xml, status);
                } catch (e) {
                    status = "error";
                    jQuery.handleError(uploadOptions, xml, status, e);
                }

                // The request was completed
                if (uploadOptions.global)
                    jQuery.event.trigger("ajaxComplete", [xml, uploadOptions]);

                // Handle the global AJAX counter
                if (uploadOptions.global && !--jQuery.active)
                    jQuery.event.trigger("ajaxStop");

                // Process result
                if (uploadOptions.complete)
                    uploadOptions.complete(xml, status);

                jQuery(io).unbind();

                setTimeout(function () {
                    try {
                        jQuery(io).remove();
                        jQuery(form).remove();

                    } catch (e) {
                        jQuery.handleError(uploadOptions, xml, null, e);
                    }

                }, 100);

                xml = null

            }
        };


        // Timeout checker
        if (uploadOptions.timeout > 0) {
            setTimeout(function () {
                // Check to see if the request is still happening
                if (!requestDone) uploadCallback("timeout");
            }, uploadOptions.timeout);
        }

        //action now!  submit & load.
        try {

            var form = jQuery('#' + formId);
            jQuery(form).attr('action', uploadOptions.url);
            jQuery(form).attr('method', 'POST');
            jQuery(form).attr('target', frameId);
            if (form.encoding) {
                jQuery(form).attr('encoding', 'multipart/form-data');
            }
            else {
                jQuery(form).attr('enctype', 'multipart/form-data');
            }
            jQuery(form).submit();

        } catch (e) {
            jQuery.handleError(uploadOptions, xml, null, e);
        }

        jQuery('#' + frameId).load(uploadCallback);
        return {abort: function () {
        }};

    },

    uploadHttpData: function (r, type) {
        var data = !type;
        data = type == "xml" || data ? r.responseXML : r.responseText;
        // If the type is "script", eval it in global context
        if (type == "script")
            jQuery.globalEval(data);
        // Get the JavaScript object, if JSON is used.
        if (type == "json")
            eval("data = " + data);
        // evaluate scripts within html
        if (type == "html")
            jQuery("<div>").html(data);

        return data;
    }
});


/**
 * This method provide several different methodology to upload a file to server in a ajax way.
 * Here we assume there is a UI control with id #fileSelectorId, and certain event associated with it will
 * trigger the upload action.
 * For now please consider using this for single file upload only.
 * @param {object} props configurations for ajax upload
 * @param {string} fileSelectorId
 * @param {int} methodology
 * @private
 */
var _fileUploader = function(props, fileSelectorId, methodology) {
    window.console.log("uploader called");


    methodology = methodology || 0;
    var fileSelector = $('#' + fileSelectorId)[0],

        onUploadOk = function(data, status) {
            window.console.log('upload success');
        },

        onUploadFail = function(data, status, e) {
            window.console.log('upload failed');
        };

    var options = props || {
        //timeout: 1000,
        url: 'handler.php',
        type: "post",
        data: {name: "fileUploading"},
        dataType: 'json',
        secureuri: false,
        //fileElementId: fileSelectorId,
        success: onUploadOk,
        error: onUploadFail
    };
    options.fileElementId = fileSelectorId;



    if (fileSelector && fileSelector.files) {

        var files = fileSelector.files,
            oneFile,
            xhr,
            checkExtension = function (name, type, errorCallBack) {
                if (type.match("sheet.*") === false) {
                    return false;
                }

                var ext = name.substring(name.lastIndexOf("."));
                if (['.txt', '.csv', '.xls', '.xlsx', '.jpg', '.png'].indexOf(ext) !== -1) {
                    return true;
                }

                errorCallBack && errorCallBack();
            },

            checkSize = function (file, sizeLimit, errorCallBack) {
                if (file.size < sizeLimit) {
                    return true;
                }

                errorCallBack && errorCallBack();
            };

        if (methodology === 1) {
            var getXHR = function () {
                var xhr = new XMLHttpRequest();
                xhr.open(options.type, options.url, true);
                // Set up a handler for when the request finishes.
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        //uploadButton.innerHTML = 'Upload';
                        window.console.log("upload finished");
                    } else {
                        alert('An error occurred!');
                    }
                };
                return xhr;
            };

            for (var i = 0; i < files.length; i++) {
                oneFile = files[i];
                if (checkExtension(oneFile.name, oneFile.type)) {
                    var formData = new FormData();
                    formData.append(oneFile.name + (new Date()), oneFile);

                    xhr = xhr || getXHR();
                    xhr.send(formData);
                }
            }
        } else {//the other way to upload files to server.
            for (i = 0; i < files.length; i++) {
                oneFile = files[i];
                if (checkExtension(oneFile.name, oneFile.type)) {
                    jQuery.ajaxFileUpload(options);
                }
            }
        }
    }
};