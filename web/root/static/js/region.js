if (!String.prototype.render) {
    String.prototype.render = function(args) {
        var copy = this + '';
        for (var i in args) {
            copy = copy.replace(RegExp('\\$\\$' + i, 'g'), args[i]);
        }
        return copy;
    };
}
        
if (!Array.prototype.indexOf){
  Array.prototype.indexOf = function(elt /*, from*/){
    var len = this.length >>> 0;

    var from = Number(arguments[1]) || 0;
    from = (from < 0)
         ? Math.ceil(from)
         : Math.floor(from);
    if (from < 0)
      from += len;

    for (; from < len; from++){
      if (from in this &&
          this[from] === elt)
        return from;
    }
    return -1;
  };
}
$(document).ready(function () { // type_of_string = "string" ou "coord"
    var current_map_string = '',
        type_of_string = 'coord',
        map,
        retorno_kml,
        regions_list;

        $("#region-list ul").append("<li class='item'>Carregando...</li>");
        $.getJSON('/getregions', function(data,status){
            data.geoms.sort(function (a, b) {
                a = String(a.name),
                b = String(b.name);
                return a.localeCompare(b);
            });
            $("#region-list ul").empty();
            regions_list = data.geoms;
            if ($("#region-list").length > 0){
                $.each(regions_list, function(index,item){
                    $("#region-list ul").append("<li class='item' region-id='" + item.id + "'>" + item.name + "</li>");
                });
            }

            $("#region-list .item").bind('click', function (e) {
                if (!$(this).hasClass("selected")){
                    $("#region-list .item").removeClass("selected");
                    $(this).addClass("selected");
                    if ($(this).attr("region-id")) {
                        var region_selected = getRegion($(this).attr("region-id"));
                        var region_index = $(this).attr("region-index");
                        if ((region_selected) && region_selected.geom_json) {
                            var coords = JSON.parse(region_selected.geom_json).coordinates;
                            if (!$map.getObjTriangle(region_index)) {
                                $map.addPolygon({
                                    "map_string": JSON.stringify(coords),
                                    "focus": true,
                                    "region_id": region_selected.id,
                                    "select": true,
                                    "set_index": true
                                });
                            } else {
                                $map.selectPolygon(region_index);
                            }
                        }
                    }
                    //$.setSelectedRegion();
                }else{
                    $(this).removeClass("selected");
                    if ($("#save-button").length > 0){
                        document.getElementById('save-button').setAttribute('disabled','disabled');
                    }
                }
    
            });
        });   

    function getRegion(id) {
        var i = "";
        $.each(regions_list, function (index, item) {
            if (item.id == id) {
                i = index;
            }
        });
        if (i) {
            return regions_list[i];
        } else {
            return null;
        }
    }

    $map = function () {

        var drawingManager;
        var selectedShape;
        var objTriangle = [];
        var color = [];
        color["default"] = '#00B6C1';
        color["select"] = '#FFC21E';
        color["edit"] = '#FF1E1E';

        // perguntar a precisao
        // 0 = 100%
        // 20 = muito alta
        // 100 = media
        // 200 = ruim
        // 500 = ruim demais
        // 1000 = estranho

        var _precisao = 20;

        var _binds = {
            on_selection_unavaiable: null,
            on_selection_available: null,
        };

        var _is_visible = 1;

        function hide_controls() {
            _is_visible = 0;

            if (typeof _binds.on_selection_unavaiable == 'function') {
                _binds.on_selection_unavaiable();
            }
        }

        function show_controls() {
            if (_is_visible == 1) return;
            _is_visible = 1;

            if (typeof _binds.on_selection_available == 'function') {
                _binds.on_selection_available();
            }
        }

        // na hora de salvar usa o conteudo do current_map_string

        function clearSelection() {
            if (selectedShape) {
                setColor("default");
                selectedShape.setEditable(false);
                selectedShape = null;
                current_map_string = '';
                hide_controls();
                document.getElementById('delete-button').setAttribute('disabled','disabled');
                document.getElementById('edit-button').setAttribute('disabled','disabled');
                if ($("#save-button").length > 0){
                    if ($("#region-list .item.selected").length <= 0) {
                        document.getElementById('save-button').setAttribute('disabled','disabled');
                    }
                }
            }
        }

        function setSelection(shape) {
            clearSelection();
            selectedShape = shape;
            setColor("select");
            document.getElementById('delete-button').removeAttribute('disabled');
            document.getElementById('edit-button').removeAttribute('disabled');
            if ($("#save-button").length > 0){
                if ($("#region-list .item.selected").length > 0) {
                    document.getElementById('save-button').removeAttribute('disabled');
                }else{
                    document.getElementById('save-button').setAttribute('disabled','disabled');
                }
            }
        }

        function setShapeEditable() {
            document.getElementById('edit-button').setAttribute('disabled','disabled');
            setColor("edit");
            selectedShape.setEditable(true);
        }

        function getSelection() {
            console.log(current_map_string);
        }

        function saveSelectedShape() {
            if ($("#save-button").length > 0) {
                if ($("#save-button").attr("disabled") == "disabled") {
                    return;
                }
            }

            if ($("#region-list .selected").length <= 0 || (!$("#region-list .selected").attr("region-id"))) {
                $("#aviso").setWarning({
                    msg: "Nenhuma região selecionada."
                });
                return;
            } else if (!current_map_string) {
                $.confirm({
                    'title': 'Confirmação',
                    'message': 'Nenhuma forma foi selecionada. <br />Deseja salvar assim mesmo?',
                    'buttons': {
                        'Sim': {
                            'class': '',
                            'action': function () {
                                Save();
                            }
                        },
                        'Não': {
                            'class': '',
                            'action': function () {
                                return;
                            }
                        }
                    }
                });
            } else {
                $.confirm({
                    'title': 'Confirmação',
                    'message': 'Tem certeza que deseja associar essa forma à região "$$regiao"?'.render({
                        regiao: $("#region-list .item.selected").text()
                    }),
                    'buttons': {
                        'Sim': {
                            'class': '',
                            'action': function () {
                                Save();
                            }
                        },
                        'Não': {
                            'class': '',
                            'action': function () {
                                return;
                            }
                        }
                    }
                });
            }

            function Save() {
                var index = objTriangle.length;
                selectedShape.region_index = index;
                objTriangle.push(selectedShape);
                $("#region-list .selected").attr("region-index", selectedShape.region_index);
                updateDataRegions($("#region-list .selected").attr("region-id"), current_map_string);
                return false;

                var action = "update";
                var method = "POST";
                var url_action = "url/" + $("#region-list ul li.selected").attr("region-id");

                args = [{
                    name: "city.region." + action + ".polygon_path",
                    value: current_map_string
                }];

                $.ajax({
                    type: method,
                    dataType: 'json',
                    url: url_action,
                    data: args,
                    success: function (data, status, jqXHR) {

                        if (!selectedShape.region_index) {
                            var index = objTriangle.length;

                            selectedShape.region_index = index;

                            objTriangle.push(selectedShape);

                        }
                        $("#region-list .selected").attr("region-index", selectedShape.region_index);
                        updateDataRegions($("#region-list .selected").attr("region-id"), current_map_string);

                        $("#aviso").setWarning({
                            msg: "Operação efetuada com sucesso."
                        });
                    },
                    error: function (data) {
                        $("#aviso").setWarning({
                            msg: "Erro na operação. ($$codigo)".render({
                                codigo: $.trataErro(data)
                            })
                        });
                    }
                });
            }
        }

        function editSelectedShape() {
            if (selectedShape) {
                setShapeEditable(selectedShape);
            }
        }

        function deleteSelectedShape() {
            if ($("#delete-button").length > 0) {
                if ($("#delete-button").attr("disabled") == "disabled") {
                    return;
                }
            }
            if (selectedShape) {
                if ($("#region-list").length > 0) {
                    $("#region-list .item[region-index=" + selectedShape.region_index + "]").attr("region-index", "");
                }
                selectedShape.setMap(null);
                objTriangle[selectedShape.region_index] = null;
                current_map_string = '';
                $("#map_string").val("");
                hide_controls();
            }
        }

        function deleteShape(shape) {
            if (shape) {
                if ($("#region-list").length > 0) {
                    $("#region-list .item[region-index=" + shape.region_index + "]").attr("region-index", "");
                }
                shape.setMap(null);
                objTriangle[shape.region_index] = null;
            }
        }

        function _deleteAllShapes() {
            $.each(objTriangle, function (index, item) {
                deleteShape(item);
            });
            objTriangle = [];
        }

        function selectColor(status) {
            if (!status) status = 'default';
            // Retrieves the current options from the drawing manager and replaces the
            // stroke or fill color as appropriate.

            var polygonOptions = drawingManager.get('polygonOptions');
            polygonOptions.fillColor = color[status];
            drawingManager.set('polygonOptions', polygonOptions);
        }

        function setColor(status) {
            if (!selectedShape) return;
            if (!status) status = 'default';
            // Retrieves the current options from the drawing manager and replaces the
            // stroke or fill color as appropriate.

            selectedShape.setOptions({
                fillColor: color[status]
            });
        }

        function _store_string(theShape) {
            if (typeof theShape.getPath == "function") {
                if (type_of_string == "string"){
                    current_map_string = google.maps.geometry.encoding.encodePath(theShape.getPath());
                }else if(type_of_string == "coord"){
                    var vertices = theShape.getPath(),
                        coords = [];

                    for (var i =0; i < vertices.getLength(); i++) {
                        var xy = vertices.getAt(i);
                        coords.push( new Array(xy.lng(), xy.lat()) );
                    }
                    coords = new Array(coords);
                    current_map_string = JSON.stringify(coords);
                }
            }
            $("#map_string").val(current_map_string);
            show_controls();
        }

        function _addPolygon(args) {
            if (!(current_map_string) && !(args.map_string) && !(args.kml_string)) return;

            if (!args.kml_string) {
                if (current_map_string && !(args.map_string)){
                    args.map_string = current_map_string;
                }
                if (type_of_string == "string"){
                    var triangleCoords = google.maps.geometry.encoding.decodePath(args.map_string);
                }else{
                    var coordinates = JSON.parse(args.map_string);
                    var polyCoords = new Array();
                    for (j in coordinates[0]) {
                        var coords = coordinates[0][j];
                        polyCoords.push(new google.maps.LatLng(coords[1], coords[0])); 
                    }
                    var triangleCoords = polyCoords;
                }
            } else {
                var triangleCoords = [];

                $.each(args.kml_string.latlng, function (indexx, lnt) {
                    triangleCoords.push(new google.maps.LatLng(lnt[1], lnt[0]));
                });

                if ($("#precision-slider").slider("value")) {
                    _precisao = parseInt($("#precision-slider").slider("value"));
                } else {
                    _precisao = 0;
                }

                triangleCoords = GDouglasPeucker(triangleCoords, _precisao);
            }

            var index = objTriangle.length;

            if (args.set_index){
                $("#region-list ul li.selected").attr("region-index",index);
            }

            objTriangle.push(new google.maps.Polygon({
                paths: triangleCoords,
                fillColor: color['default'],
                strokeWeight: 1,
                strokeOpacity: 0.45,
                fillOpacity: 0.45,
                editable: false,
                region_index: index
            }));

            objTriangle[index].setMap(map);

            if (args.focus) map.fitBounds(objTriangle[index].getBounds());

            google.maps.event.addListener(objTriangle[index], 'click', function () {
                setSelection(this);
                _store_string(this);
            });
            google.maps.event.addListener(objTriangle[index].getPath(), 'insert_at', function () {
                _store_string(this);
            });
            google.maps.event.addListener(objTriangle[index].getPath(), 'set_at', function () {
                _store_string(this);
            });
            if (args.select) {
                setSelection(objTriangle[index]);
                _store_string(objTriangle[index]);
            }

        }

        function _selectPolygon(index) {
            if (!index) return;

            map.fitBounds(objTriangle[index].getBounds());

            setSelection(objTriangle[index]);
            _store_string(objTriangle[index]);
        }

        function _editPolygon(index) {
            if (!index) return;

            map.fitBounds(objTriangle[index].getBounds());

            setShapeEditable(objTriangle[index]);
            _store_string(objTriangle[index]);
        }

        function _focusAll() {
            var super_bound = null;
            $.each(objTriangle, function (a, elm) {

                if (super_bound == null) {
                    super_bound = elm.getBounds();
                    return true;
                }

                super_bound = super_bound.union(elm.getBounds());
            });

            if (!(super_bound == null)) {
                map.fitBounds(super_bound);
            }
        }

        function _getObjTriangle(index) {
            if (objTriangle) {
                if (objTriangle[index]) {
                    return objTriangle[index];
                } else {
                    return null;
                }
            } else {
                return null;
            }
        }

        function updateDataRegions(id, string) {
            var i = "";
            $.each(regions_list, function (index, item) {
                if (item.id == id) {
                    i = index;
                }
            });
            if (i) {
                var geom_json = JSON.parse(regions_list[i].geom_json);
                geom_json.coordinates = JSON.parse(string);
                regions_list[i].geom_json = JSON.stringify(geom_json);
            }
        }

        function initialize(params) {

            if (typeof params.on_selection_unavaiable == 'function')
                _binds.on_selection_unavaiable = params.on_selection_unavaiable;

            if (typeof params.on_selection_available == 'function')
                _binds.on_selection_available = params.on_selection_available;


            map = new google.maps.Map(document.getElementById('map'), {
                zoom: 5,
                center: params.center,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                disableDefaultUI: true,
                zoomControl: true
            });

            var polyOptions = {
                fillColor: color['default'],
                strokeWeight: 0,
                fillOpacity: 0.45,
                editable: true,
            };
            // Creates a drawing manager attached to the map that allows the user to draw
            // markers, lines, and shapes.
            drawingManager = new google.maps.drawing.DrawingManager({
                drawingMode: google.maps.drawing.OverlayType.NONE,
                polygonOptions: polyOptions,
                drawingControlOptions: {
                    drawingModes: [google.maps.drawing.OverlayType.POLYGON]
                },
                map: map
            });

            google.maps.event.addListener(drawingManager, 'overlaycomplete', function (e) {
                if (e.type != google.maps.drawing.OverlayType.MARKER) {
                    // Switch back to non-drawing mode after drawing a shape.
                    drawingManager.setDrawingMode(null);

                    // Add an event listener that selects the newly-drawn shape when the user
                    // mouses down on it.
                    var newShape = e.overlay;
                    newShape.type = e.type;
                    google.maps.event.addListener(newShape, 'click', function () {
                        setSelection(newShape);
                        _store_string(newShape);
                    });
                    google.maps.event.addListener(newShape.getPath(), 'insert_at', function () {
                        _store_string(newShape);
                    });
                    google.maps.event.addListener(newShape.getPath(), 'set_at', function () {
                        _store_string(newShape);
                    });
                    setSelection(newShape);
                    _store_string(newShape);
                }
            });

            // Clear the current selection when the drawing mode is changed, or when the
            // map is clicked.
            google.maps.event.addListener(drawingManager, 'drawingmode_changed', clearSelection);
            google.maps.event.addListener(map, 'click', clearSelection);
            google.maps.event.addDomListener(document.getElementById('edit-button'), 'click', editSelectedShape);
            google.maps.event.addDomListener(document.getElementById('delete-button'), 'click', deleteSelectedShape);
            if ($("#save-button").length > 0) {
                google.maps.event.addDomListener(document.getElementById('save-button'), 'click', saveSelectedShape);
            }
            selectColor();

            if ($("#map_string").length > 0 && $("#map_string").val() != ""){
                addPolygon({
                    "map_string": $("#map_string").val(),
                    "focus": true,
                    "region_id": $("#region_edit_id").val(),
                    "select": true,
                    "set_index": true
                });
            }
        }
        return {
            init: initialize,
            getSelectedShape: function () {
                return selectedShape;
            },
            getSelectedShapeAsString: function () {
                return current_map_string;
            },
            addPolygon: _addPolygon,
            selectPolygon: _selectPolygon,
            editPolygon: _editPolygon,
            deleteAllShapes: _deleteAllShapes,
            getObjTriangle: _getObjTriangle,
            focusAll: _focusAll
        };
    }();

    google.load("maps", "3", {
        other_params: 'sensor=false&libraries=drawing,geometry',
        callback: function () {

            if (!google.maps.Polygon.prototype.getBounds) {

                google.maps.Polygon.prototype.getBounds = function (latLng) {

                    var bounds = new google.maps.LatLngBounds();
                    var paths = this.getPaths();
                    var path;

                    for (var p = 0; p < paths.getLength(); p++) {
                        path = paths.getAt(p);
                        for (var i = 0; i < path.getLength(); i++) {
                            bounds.extend(path.getAt(i));
                        }
                    }

                    return bounds;
                }
            }

            $map.init({
                on_selection_unavaiable: function () {
                    document.getElementById('delete-button').setAttribute('disabled', 'disabled');
                },
                on_selection_available: function () {
                    document.getElementById('delete-button').removeAttribute('disabled');
                },
                // talvez pegar a cidade do usuario logado. ou se for superadmin, todo o mapa
                center: new google.maps.LatLng(-15.781444, -47.930523),
                google: google
            });
            $map.focusAll();

        }
    });

    $("#panel-map #edit-button").click(function(e){
        e.preventDefault();
    });
    $("#panel-map #delete-button").click(function(e){
        e.preventDefault();
    });

    $('.slider-editor').slider();

    $('#slider-editor').slider()
        .on('slide', function(ev){
            $("#slider-value").val(ev.value);
    });

    function trataRetornoKML() {
        $map.deleteAllShapes();
        $.each(retorno_kml.vec, function (index, foo) {
            $map.addPolygon({
                "kml_string": foo,
                "focus": false,
                "select": false
            });
        });
        $map.focusAll();
    }

    $("#upload-kml").bind("click", function(){

        var clickedButton = $(this);

        var file = "arquivo";
        var form = $("#formFileUpload_" + file);
		console.log(form);
        original_id = $('#arquivo_' + file).attr("original-id");

        $('#arquivo_' + file).attr({
            name: "arquivo",
            id: "arquivo"
        });

		alert('teste');
        form.attr("action", "/kml?content-type=application/json");
        form.attr("method", "post");
        form.attr("enctype", "multipart/form-data");
        form.attr("encoding", "multipart/form-data");
        form.attr("target", "iframe_" + file);
        form.attr("file", $('#arquivo').val());
        form.submit();
        $('#arquivo').attr({
            name: original_id,
            id: original_id
        });

        $("#iframe_" + file).load(function () {
            var erro = 0;
            if ($(this).contents()) {
                if ($(this).contents()[0].body) {
                    if ($(this).contents()[0].body.outerHTML) {
                        var retorno = $(this).contents()[0].body.outerHTML;
                        retorno = $(retorno).text();
                        retorno = $.parseJSON(retorno);
						console.log(retorno);
                    } else {
                        erro = 1;
                    }
                } else {
                    erro = 1;
                }
            } else {
                erro = 1;
            }
            if (erro == 0) {
                if (!retorno.error) {
                    $(".upload_via_file .form-aviso").text('Arquivo recebido com sucesso');
                    $(clickedButton).html("Enviar");
                    $(clickedButton).attr("is-disabled", 0);
                    if (retorno.vec) {
                        retorno_kml = retorno;
                        trataRetornoKML();
                    } else {
                        $(".upload_via_file .form-aviso").text('O arquivo possui um formato inválido.');
                    }
                } else {
                    $(".upload_via_file .form-aviso").text('Erro ao enviar arquivo');
                    $(clickedButton).html("Enviar");
                    $(clickedButton).attr("is-disabled", 0);
                    return;
                }
            } else {
                $(".upload_via_file .form-aviso").text('Erro ao enviar arquivo');
                $(clickedButton).html("Enviar");
                $(clickedButton).attr("is-disabled", 0);
                return;
            }
        });

    })

});
$.confirm = function(params){
    if (!params.hide_close_button) params.hide_close_button = 0;
    if($("#modal-alert").length > 0){
        $("#modal-alert").remove();
    }

    var buttonHTML = '';
    var caption;
    $.each(params.buttons,function(name,obj){
        if (obj.caption){
            caption = obj.caption;
        }else{
            caption = name;
        }
        buttonHTML += '<button type="button" class="btn '+obj['class']+'">'+caption+'</button>';
        if(!obj.action){
            obj.action = function(){};
        }
    });
    
    var size_class = "";
    if (params.size){
        size_class = params.size;
    }
    
    var confirmWindow = "<div id='modal-alert' class='modal fade $$size_class' data-backdrop='static'>".render({
        size_class: params.size
    });
    confirmWindow += "<div class='modal-dialog'>";
    confirmWindow += "<div class='modal-content'>";
    confirmWindow += "<div class='modal-header'>";
    if (params.hide_close_button == 0){
        confirmWindow += "<button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span><span class='sr-only'>Close</span></button>";
    }
    confirmWindow += "<h4 class='modal-title'>$$title</h4>".render({title: params.title});
    confirmWindow += "</div>";
    confirmWindow += "<div class='modal-body'>$$message</div>".render({message: params.message});
    confirmWindow += "<div class='modal-footer'>$$buttons</div>".render({buttons: buttonHTML});
    confirmWindow += "</div></div></div>";
    
    $(confirmWindow).appendTo("body");
    
    $("#modal-alert").on("shown.bs.modal", function(e){
        if (typeof params.onCreate == "function"){
            params.onCreate();
        }
        $("#modal-alert .modal-footer button:first").focus();
    });
    
    var buttons = $('#modal-alert .modal-footer button'), i = 0;

    $.each(params.buttons,function(name,obj){
        buttons.eq(i++).click(function(){
            obj.action();
            if (!obj.stay_open) $.confirm.hide();
            return false;
        });
    });     
    $("#modal-alert").modal('show');
};
$.confirm.hide = function(args){
    $("#modal-alert").on("hide.bs.modal", function(e){
        $("#modal-alert").remove();
        if (args){
            args.rollback();
        }
    });
    $("#modal-alert").modal('hide');
}
$.confirm.update = function(msg){
    $('#modal-alert .modal-body').html(msg);
}
$.confirm.center = function(){
    var w = $('#modal-alert').width();
    var h = $('#modal-alert').height();
    $('#modal-alert').animate({
            "margin-left":(w/2*(-1))+"px",
            "margin-top": (h/2*(-1))+"px"
    });
}

$.scrollTo = function(id,has_target,target){
    if (id.charAt(0) != "." && id.charAt(0) != "#" && !(has_target)){
        id = "#"+id;
    }
    var top = $(id).offset().top;
    if (has_target){
        if (!target){
            target = "html,body";
        }
    }else{
        target = "html,body";
    }
    $(target).animate({scrollTop: top},'slow');
}

$.fn.setWarning = function(){
    var args = arguments[0];
    if (!args.type) args.type = "warning";
    if (args.type == "error") args.type = "danger";
    $(this).hide();
    $(this).empty();
    $(this).html("<div class='alert alert-" + args.type + "'>"+args.msg+"</div>");
    $(this).show();
    $.scrollTo("#" + $(this).attr("id"));
};
$.fn.clearWarning = function(){
    $(this).fadeOut("slow",function(){
        $(this).empty();
    });
    
};
