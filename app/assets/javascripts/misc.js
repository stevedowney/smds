$('.logged_in_link').live('click', function(e) {
  if (!gon.logged_in) {
    e.preventDefault();
    tbAlert('You must be logged in to perform that action');
    return false;
  }
});