module CommentsHelper

	def link_to_favorite_comment(cwa)
		if cwa.favorited?
			link_to(icon_unfavorite, comment_unfavorite_path(cwa.comment), :method => :post, :remote => true)
		else
			link_to(icon_favorite, comment_favorite_path(cwa.comment), :method => :post, :remote => :true)
		end
	end

	def link_to_flag_comment(cwa)
		if cwa.flagged?
			link_to(icon_unflag, comment_unflag_path(cwa.comment), :method => :post, :remote => true)
		else
			link_to(icon_flag, comment_flag_path(cwa.comment), :method => :post, :remote => :true)
		end
	end

	def link_to_vote_up_comment(cwa)
		link_to(icon_vote_up, comment_vote_up_path(cwa.comment), :method => :post, :remote => true)
	end

	def link_to_vote_down_comment(cwa)
		link_to(icon_vote_down, comment_vote_down_path(cwa.comment), :method => :post, :remote => true)
	end

	def link_to_delete_comment(cwa)
		if cwa.deletable?
			link_to(icon_delete, comment_path(cwa.comment), :method => :delete, :remote => true, :data => {:confirm => "Are you sure?"})
		end
	end

	


##############

	def link_to_edit_comment(comment)
		if comment.editable_by?(current_user)
			link_to(icon_edit, edit_quote_comment_path(@quote, comment))
		end
	end

	def comment_login_or_sign_up_message
		login_link = link_to("login", new_user_session_path)
		sign_up_link = link_to("sign-up", new_user_registration_path)
		"To add a comment of your own you must #{login_link} or #{sign_up_link}".html_safe
	end
end