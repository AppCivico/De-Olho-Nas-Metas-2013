var md = function () {
    var

        $indi = $('select[name="tabela"]:first'),
        $formato = $('select[name="formato"]:first'),
        $url = $('input[name="url"]:first'),
        _run = function () {


            $indi.change(_redo_url);
            $formato.change(_redo_url);

            _redo_url();
        },
        _redo_url = function () {

            var
            formato = $formato.val(),
                indi = $indi.val();

            var base_uri = '';
            var arquivo = indi ? '.' + formato : 'tabelas.' + formato;
            var url = '';
            if ((indi == '') == false) {
                url = url + '/' + indi;
            }
            base_uri = 'http://www.deolhonasmetas.org.br/api/download' + url;

            url = base_uri  + arquivo;
            $('#id_link').attr('href', url);
            $url.val(url);
        };
    return {
        run: _run
    };
}();

$(function () {
    md.run();
});
