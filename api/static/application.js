// NOTICE!! DO NOT USE ANY OF THIS JAVASCRIPT
// IT'S ALL JUST JUNK FOR OUR DOCS!
// ++++++++++++++++++++++++++++++++++++++++++

!function ($) {

  $(function(){

    var $window = $(window)

    // Disable certain links in docs
    $('[href=#]').click(function (e) {
      e.preventDefault()
    })

    // back to top
    setTimeout(function () {
      $('.bs-sidebar').affix({
        offset: {
          top: function () { return $window.width() <= 980 ? 290 : 210 }
        , bottom: 270
        }
      })
    }, 100)

    setTimeout(function () {
      $('.bs-top').affix()
    }, 100)
  })

}(window.jQuery)
