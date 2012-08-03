describe CommentActivitiesController, :js => true do
  let!(:quote) {FactoryGirl.create(:quote, :text => 'quote text')}
  let!(:comment) {FactoryGirl.create(:comment, :quote => quote, :body => 'comment body')}

  before(:each) do
    @user = create_and_login_user
    visit '/'
    click_on quote.dom_id('comments')
    page.should have_content('quote text')
    page.should have_content('comment body')
  end

  describe '#vote_up' do
    it 'votes_up' do
      page.should have_tag('span', :id => comment.dom_id('vote_net_count') , :text => "0")
      click_on comment.dom_id('vote_up')
      page.should have_tag('span', :id => comment.dom_id('vote_net_count') , :text => "1")
      CommentActivity.find_by_comment_id!(comment.id).should be_voted_up
    end
  end

  describe '#vote_down' do
    it 'votes down' do
      page.should have_tag('span', :id => comment.dom_id('vote_net_count') , :text => "0")
      click_on comment.dom_id('vote_down')
      page.should have_tag('span', :id => comment.dom_id('vote_net_count') , :text => "-1")
      CommentActivity.find_by_comment_id!(comment.id).should be_voted_down
    end
  end
  
  describe '#favorite' do
    it 'favorites' do
      comment.favorite_count.should == 0
      page.should_not have_tag(:a, :id => comment.dom_id('unfavorite'))
      click_on comment.dom_id('favorite')
      page.should have_tag(:a, :id => comment.dom_id('unfavorite'))
      comment.reload.favorite_count.should == 1
    end
  end
  
  describe '#unfavorite' do
    it 'unfavorites' do
      FactoryGirl.create(:comment_activity, :user => @user, :quote => quote, :comment => comment, :favorited => true)
      comment.favorite_count.should == 0
      visit quote_path(quote)
      page.should_not have_tag(:a, :id => comment.dom_id('favorite'))
      click_on comment.dom_id('unfavorite')
      page.should have_tag(:a, :id => comment.dom_id('favorite'))
      comment.reload.favorite_count.should == -1
    end
  end
  
  describe '#flag' do
    it 'flags' do
      comment.flag_count.should == 0
      page.should_not have_tag(:a, :id => comment.dom_id('unflag'))
      click_on comment.dom_id('flag')
      page.should have_tag(:a, :id => comment.dom_id('unflag'))
      comment.reload.flag_count.should == 1
    end
  end
  
  describe '#unflag' do
    it 'unflags' do
      FactoryGirl.create(:comment_activity, :user => @user, :quote => quote, :comment => comment, :flagged => true)
      comment.flag_count.should == 0
      visit quote_path(quote)
      page.should_not have_tag(:a, :id => comment.dom_id('flag'))
      click_on comment.dom_id('unflag')
      page.should have_tag(:a, :id => comment.dom_id('flag'))
      comment.reload.flag_count.should == -1
    end
  end

end