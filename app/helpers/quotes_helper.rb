module QuotesHelper

	def link_to_comments(qwa)
		label = icon(:comment) + " #{qwa.comments_count}"
		link_to(label, quote_path(qwa.quote), :id => qwa.quote.dom_id('comments'))	
	end

	def link_to_vote_up(qwa)
		text = icon("thumbs-up")
		url = vote_up_path(qwa.quote)
		link = link_to(text, url, :remote => true, :method => :post, :title => "Vote up")
		link + " #{qwa.vote_up_count}"
	end

	def link_to_vote_down(qwa)
		text = icon("thumbs-down")
		url = vote_down_path(qwa.quote)
		link = link_to(text, url, :remote => true, :method => :post, :title => "Vote down")
		link + " #{qwa.vote_down_count}"
	end

	def link_to_favorite(qwa)
		if qwa.favorited?
			link_to(icon(:star), unfavorite_path(qwa.quote), :remote => true, :method => :post, :title => "Remove from favorites")
		else
			link_to(icon(:star_empty), favorite_path(qwa.quote), :remote => true, :method => :post, :title => "Add to favorites")
		end
	end

	def link_to_flag_quote(qwa)
		if qwa.flagged?
			link_to(icon_unflag, quote_unflag_path(qwa.quote), :remote => true, :method => :post, :title => "Unflag" )
		else
			link_to(icon_flag, quote_flag_path(qwa.quote), :remote => true, :method => :post, :title => "Flag as inappropriate")
		end
	end

	def link_to_delete_quote(qwa)
		if qwa.deletable?
			link_to(icon(:trash), quote_path(qwa.quote), :remote => true, :method => :delete, :title => "Delete", :data => {:confirm => 'Are you sure?  This is irreversible.'}, :id => qwa.quote.dom_id('delete'))
		end
	end

	def link_to_edit_quote(qwa)
		if qwa.editable?
			link_to(icon(:pencil), edit_quote_path(qwa.quote), :title => "Edit", :id => qwa.quote.dom_id('edit'))
		end
	end

	def link_to_submitted_by(owner)
		owner_name = owner == current_user ? 'me' : owner.username
		title = "Submissions by #{owner_name}"
		"by: ".html_safe + link_to(owner_name.html_safe, user_submissions_path(owner), :title => title)
	end

end
