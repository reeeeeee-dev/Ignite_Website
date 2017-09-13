
function resetOffset(val) {
    var navHeight = val || $('.navbar').height();
    $(document.body).data('bs.scrollspy').options.offset = navHeight;
    $(document.body).data('bs.scrollspy').process();
}

$(function () {

    $(document.body).scrollspy({target: ".navbar", offset: 100});

    $(window).resize(function () {
        var navHeight = $('.navbar').height();
        $(document.body).css('padding-top', navHeight);
        resetOffset(navHeight);
    }).resize();

    $('.navbar-toggle').click(function () {
        if ($('.navbar-collapse').is(':not(.in)')) {
            setTimeout(resetOffset, 300);
        }
    });

    $('a[href^="#"]:not(.carousel-control)').click(function () {
        var hash = $(this).attr('href'),
            target = $(hash);
        target.attr('id', '');
        window.location.hash = hash;
        target.attr('id', hash.replace('#', ''));
        resetOffset();
        var navHeight;
        if ($(this).parents('#navbar').length && $(".navbar-toggle").is(':visible')) {
            $('.navbar-toggle').click();
            navHeight = $('.navbar-brand').height();
        } else {
            navHeight = $('.navbar').height();
        }
        $("html, body").animate({
            scrollTop: target.offset().top - navHeight
        }, {
            duration: 800,
            easing: "easeInOutQuad"
        });
        return false;
    });

});
