$(function () {
    window.addEventListener('message', function(event) {
        var data = event.data;

        switch (data.action) {
            case 'open':
                $('.container').fadeIn(500);
            break;

            case 'close':
                $('.container').fadeOut(500);
            break;
        }
    });

    $('.container i').on('click', function() {
        $.post('https://as-tigari/close', JSON.stringify({}));
    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://as-tigari/close', JSON.stringify({}));
        }
    }

    $('.options__one-submit').on('click', function() {
        $.post('https://as-tigari/close', JSON.stringify({}));
        $.post('https://as-tigari/startTIGARI', JSON.stringify({
            type: 'passengers'
        }));
    });

    $('.options__two-submit').on('click', function() {
        $.post('https://as-tigari/close', JSON.stringify({}));
        $.post('https://as-tigari/startPACHET', JSON.stringify({
            type: 'products'
        }));
    });


});