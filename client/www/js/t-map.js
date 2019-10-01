/*

 OpenLayers.js -- OpenLayers Map Viewer Library

 Copyright (c) 2006-2015 by OpenLayers Contributors
 Published under the 2-clause BSD license.
 See https://raw.githubusercontent.com/openlayers/ol2/master/license.txt for the full text of the license, and https://raw.githubusercontent.com/openlayers/ol2/master/authors.txt for full list of contributors.

 Includes compressed code under the following licenses:

 (For uncompressed versions of the code used, please see the
 OpenLayers Github repository: <https://github.com/openlayers/ol2>)

 */

/**
 * Contains XMLHttpRequest.js <http://code.google.com/p/xmlhttprequest/>
 * Copyright 2007 Sergey Ilinsky (http://www.ilinsky.com)
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 */

/**
 * local TmapV20
 * OpenLayers.Util.pagePosition is based on Yahoo's getXY method, which is
 * Copyright (c) 2006, Yahoo! Inc.
 * All rights reserved.
 *
 * Redistribution and use of this software in source and binary forms, with or
 * without modification, are permitted provided that the following conditions
 * are met:
 *
 * * Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * * Neither the name of Yahoo! Inc. nor the names of its contributors may be
 *   used to endorse or promote products derived from this software without
 *   specific prior written permission of Yahoo! Inc.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

document.write(`<link rel='stylesheet' href='https://topopen.tmap.co.kr/tmaplibv20/theme/default/style.css' type='text/css'>`);(function(){let a=typeof Tmap==`object`&&Tmap.singleFile;let b=!a?`https://topopen.tmap.co.kr/tmaplibv20/Tmap.js`:`Tmap.js`;let c=window.Tmap;window.Tmap={_getScriptLocation:function(){return`https://topopen.tmap.co.kr/tmaplibv20/`},ImgPath:`https://topopen.tmap.co.kr/tmaplibv20/img/`,VERSION_NUMBER:`Release1.18.25`};if(!a){if(!c){c=[`Core.js`,`Format.js`,`Add-on.js`]}let d=new Array(c.length);let e=Tmap._getScriptLocation();for(let f=0,g=c.length;f<g;f++){d[f]=`<script src='`+e+c[f]+`?vn=`+Tmap.VERSION_NUMBER+`'></script>`}if(d.length>0){document.write(d.join(``))}}}());


