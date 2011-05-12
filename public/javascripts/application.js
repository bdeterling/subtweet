jQuery(function($) {
  $('.empty_tweep').focus();

  $('.tweets').isotope({
    itemSelector : '.tweet',
    getSortData : {
      text : function(e) {
        return e.children('.text').html();
      },
      time : function(e) {
        return e.attr('data-time')
      }
    },
    sortBy: 'time',
    sortAscending: false
  });

  $('.load_tweets').live('click', function() { load_tweets(this, true); });

  $('.remove_tweets').live('click', function() { remove_tweets(this); });

  $('.tweep').live('keypress', function(event) { 
    if (event.which == '13') {
      load_tweets(this, true); 
    }
  });

  $('.loading_tweets').each(function() {
    load_tweets(this, false);
  });

});

function load_tweets(t, add_container) {
  var container = $(t).parent();
  var name = container.find('input').val();
  if (name == '') {
    return;
  }
  toggle_loading(t);
  if (add_container) {
  }
  container.attr('data-name', name);
  var jqxhr = $.get('/tweets/'+name + '?jstime=' + new Date().getTime(), {},  function(data) {
    $('.tweets').isotope('insert', $(data), indent_tweets);
    toggle_loaded(t)
    if (add_container) {
      var new_container = container.clone()
      $(new_container).removeAttr('data-name');
      $(new_container).find('input').val('');
      $(new_container).find('input').removeAttr('disabled');
      toggle_unloaded($(new_container).find('button'), false);
      new_container.appendTo(container.parent()); 
      $(new_container).find('input').focus();
    }
  })
  .error(function() {  
    toggle_unloaded(t, true);
    input = container.find('input');
    input.removeAttr('disabled');
    input.addClass('invalid');
    input.focus();
  });
}

function remove_tweets(t) {
  var container = $(t).parent();
  var name = container.attr('data-name');
  $('.tweets').isotope('remove', $('.user_'+name));
  $('.tweets').isotope('reLayout', indent_tweets);
  var containers = $('.user');
  if (containers.length > 1) {
    container.remove();
    $(containers[containers.length-1]).find('input').focus();
  } else {
    toggle_unloaded(t, false);
  }
}

function toggle_loading(t) {
  var container = $(t).parent();
  container.find('input').attr('disabled', true);
  var button = container.find('button');
  button.children('span').html('Loading...');
  button.addClass('loading_tweets');
  button.removeClass('load_tweets');
  button.removeClass('remove_tweets');
  container.find('input').removeClass('invalid');
}

function toggle_loaded(t) {
  var container = $(t).parent();
  var button = container.find('button');
  button.children('span').html('Remove Tweets');
  button.addClass('remove_tweets');
  button.removeClass('load_tweets');
  button.removeClass('loading_tweets');
  container.find('input').removeClass('invalid');
}

function toggle_unloaded(t, retain) {
  var container = $(t).parent();
  var button = container.find('button');
  button.children('span').html('Load Tweets');
  button.addClass('load_tweets');
  button.removeClass('loading_tweets');
  button.removeClass('remove_tweets');
  container.removeAttr('data-name');
  if (retain) {
    container.find('input').select();
  } else {
    container.find('input').val('');
  }
  container.find('input').focus();
}

function indent_tweets() {
  if (1 == 1) {
    return;
  }
  var indent = 4;
  var idx = 0;
  var map = {};
  $('.tweets .tweet').each(function(idx) {
    var user = $(this).attr('data-name');
    var current_idx = map[user];
    if (!current_idx) {
      current_idx = idx;
      map[user] = current_idx;
      idx++;
    }
    $(this).css('margin-left', current_idx*indent+'px');
  });
}
