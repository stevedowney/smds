module CommentsHelper

	def link_to_favorite_comment(cwa)
		if cwa.favorited?
			link_to(icon_unfavorite, comment_unfavorite_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('unfavorite'))
		else
			link_to(icon_favorite, comment_favorite_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('favorite'))
		end
	end

	def link_to_flag_comment(cwa)
		if cwa.flagged?
			link_to(icon_unflag, comment_unflag_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('unflag'))
		else
			link_to(icon_flag, comment_flag_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('flag'))
		end
	end

	def link_to_toggle_vote_up_comment(cwa)
		link_to(icon_vote_up, comment_toggle_vote_up_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('toggle_vote_up'))
	end

	def link_to_toggle_vote_down_comment(cwa)
		link_to(icon_vote_down, comment_toggle_vote_down_path(cwa.comment), :method => :post, :remote => true, :id => cwa.comment.dom_id('toggle_vote_down'))
	end

  def link_to_reply_comment(cwa)
    link_to(icon_reply, 'javascript:void(0)', :class => 'comment-reply', :id => cwa.comment.dom_id('reply'), :title => 'Reply to this comment', :data => {:form => cwa.comment.dom_id('new')})
  end
  
	def link_to_delete_comment(cwa)
		if cwa.deletable?
			link_to(icon_delete, comment_path(cwa.comment), :method => :delete, :remote => true, :data => {:confirm => "Are you sure?"}, :id => cwa.comment.dom_id('delete'))
      # url = comment_path(cwa.comment)
      link_to_delete(cwa.comment, :format => :js)
		end
	end

	def link_to_edit_comment(cwa)
		if cwa.editable?
			link_to(icon_edit, edit_comment_path(cwa.comment), :id => cwa.comment.dom_id('edit'))
		end
	end

	def comment_login_or_sign_up_message
		login_link = link_to("login", new_user_session_path)
		sign_up_link = link_to("sign-up", new_user_registration_path)
		"To add a comment of your own you must #{login_link} or #{sign_up_link}".html_safe
	end
	
end