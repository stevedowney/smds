module QuotesHelper

  def quote_form_as
    @quote.persisted? ? :edit_quote : :new_quote
  end
  
  def link_to_comments(qwa)
    text = pluralize(qwa.comments_count, 'Comment')
    link_to_icon_with_text(icon_comment, text, quote_path(qwa.quote), :id => qwa.quote.dom_id('comments'))  
  end

  def link_to_toggle_vote_up(qwa)
    text = icon_vote_up
    url = toggle_vote_up_path(qwa.quote)
    link = link_to(text, url, :remote => true, :method => :post, :title => "Vote up", :id => qwa.quote.dom_id('toggle_vote_up'), :class => 'logged_in_link')
    link# + " #{qwa.vote_up_count}"
  end

  def link_to_toggle_vote_down(qwa)
    text = icon_vote_down
    url = toggle_vote_down_path(qwa.quote)
    link = link_to(text, url, :remote => true, :method => :post, :title => "Vote down", :id => qwa.quote.dom_id('toggle_vote_down'), :class => 'logged_in_link')
    link# + " #{qwa.vote_down_count}"
  end

  def link_to_favorite(qwa)
    if qwa.favorited?
      link_to_icon_with_text(icon_unfavorite, 'Favorited', unfavorite_path(qwa.quote), :remote => true, :method => :post, :title => "Undo favorite", :id => qwa.quote.dom_id('unfavorite'))
    else
      link_to_icon_with_text(icon_favorite, 'Favorite', favorite_path(qwa.quote), :remote => true, :method => :post, :title => "Add to favorites", :id => qwa.quote.dom_id('favorite'))
    end
  end

  # def link_to_flag_quote(qwa)
  #   if qwa.flagged?
  #     link_to_icon_with_text(icon_unflag, 'Flagged', quote_unflag_path(qwa.quote), :remote => true, :method => :post, :title => "Undo flag", :id => qwa.quote.dom_id('unflag')) 
  #   else
  #     link_to_icon_with_text(icon_flag, 'Flag', quote_flag_path(qwa.quote), :remote => true, :method => :post, :title => "Flag as inappropriate", :id => qwa.quote.dom_id('flag'))
  #   end
  # end

  def link_to_email_quote(qwa)
    link_to_icon_with_text(icon_email, 'Email', '#', :data => {:quote_id => qwa.quote.id}, :title => "Share by Email", :id => qwa.quote.dom_id('email'), :class => 'email-quote logged_in_link')
  end
  
  def link_to_delete_quote(qwa)
    if qwa.deletable?
      link_to_icon_with_text(icon_delete, 'Delete', quote_path(qwa.quote), :title => "Delete", :class => 'delete-link', :data => {:confirmation => 'Are you sure?  This is irreversible.', :"row-id" => qwa.quote.dom_id, :format => :js}, :id => qwa.quote.dom_id('delete'))
    end
  end

  def link_to_edit_quote(qwa)
    if qwa.editable?
      link_to_icon_with_text(icon_edit, "Edit", edit_quote_path(qwa.quote),
          :title => "Edit", :id => qwa.quote.dom_id('edit'), :remote => true)
    end
  end

  def link_to_submitted_by(owner)
    owner_name = owner == current_user ? 'me' : owner.username
    title = "Submissions by #{owner_name}"
    "by: ".html_safe + link_to(owner_name.html_safe, user_submissions_path(owner), :title => title)
  end

end
