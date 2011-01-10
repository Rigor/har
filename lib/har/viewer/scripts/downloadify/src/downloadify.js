(function(){Downloadify=window.Downloadify={queue:{},uid:(new Date).getTime(),getTextForSave:function(b){if(b=Downloadify.queue[b])return b.getData();return""},getFileNameForSave:function(b){if(b=Downloadify.queue[b])return b.getFilename();return""},saveComplete:function(b){(b=Downloadify.queue[b])&&b.complete();return true},saveCancel:function(b){(b=Downloadify.queue[b])&&b.cancel();return true},saveError:function(b){(b=Downloadify.queue[b])&&b.error();return true},addToQueue:function(b){Downloadify.queue[b.queue_name]=
b},getUID:function(b){if(b.id=="")b.id="downloadify_"+Downloadify.uid++;return b.id}};Downloadify.create=function(b,c){b=typeof b=="string"?document.getElementById(b):b;return new Downloadify.Container(b,c)};Downloadify.Container=function(b,c){var a=this;a.el=b;a.enabled=true;a.dataCallback=null;a.filenameCallback=null;a.data=null;a.filename=null;a.enable=function(){document.getElementById(a.flashContainer.id).setEnabled(true);a.enabled=true};a.disable=function(){document.getElementById(a.flashContainer.id).setEnabled(false);
a.enabled=false};a.getData=function(){if(!a.enabled)return"";return a.dataCallback?a.dataCallback():a.data?a.data:""};a.getFilename=function(){return a.filenameCallback?a.filenameCallback():a.filename?a.filename:""};a.complete=function(){typeof a.options.onComplete==="function"&&a.options.onComplete()};a.cancel=function(){typeof a.options.onCancel==="function"&&a.options.onCancel()};a.error=function(){typeof a.options.onError==="function"&&a.options.onError()};(function(){a.options=c;if(!a.options.append)a.el.innerHTML=
"";a.flashContainer=document.createElement("span");a.el.appendChild(a.flashContainer);a.queue_name=Downloadify.getUID(a.flashContainer);if(typeof a.options.filename==="function")a.filenameCallback=a.options.filename;else if(a.options.filename)a.filename=a.options.filename;if(typeof a.options.data==="function")a.dataCallback=a.options.data;else if(a.options.data)a.data=a.options.data;var d={queue_name:a.queue_name,width:a.options.width,height:a.options.height},e={allowScriptAccess:"always"},f={id:a.flashContainer.id,
name:a.flashContainer.id};if(a.options.enabled===false)a.enabled=false;if(a.options.transparent===true)e.wmode="transparent";if(a.options.downloadImage)d.downloadImage=a.options.downloadImage;swfobject.embedSWF(a.options.swf,a.flashContainer.id,a.options.width,a.options.height,"10",null,d,e,f);Downloadify.addToQueue(a)})()};Downloadify.defaultOptions={swf:"media/downloadify.swf",downloadImage:"images/download.png",width:100,height:30,transparent:true,append:false}})();
typeof jQuery!="undefined"&&function(b){b.fn.downloadify=function(c){return this.each(function(){c=b.extend({},Downloadify.defaultOptions,c);var a=Downloadify.create(this,c);b(this).data("Downloadify",a)})}}(jQuery);