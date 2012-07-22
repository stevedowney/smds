module CommentsHelper

	def link_to_edit_comment(comment)
		if comment.editable_by?(current_user)
			link_to(icon_edit, edit_quote_comment_path(@quote, comment))
		end
	end

	def link_to_delete_comment(comment)
		if comment.deletable_by?(current_user)
			link_to(icon_delete, quote_comment_path(@quote, comment), :method => :delete, :data => {:confirm => "Are you sure?"})
		end
	end

	def comment_login_or_sign_up_message
		login_link = link_to("login", new_user_session_path)
		sign_up_link = link_to("sign-up", new_user_registration_path)
		"To add a comment of your own you must #{login_link} or #{sign_up_link}".html_safe
	end
end