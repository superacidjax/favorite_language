# NOTE: for these test to work you will need to add envars with your:
# GITHUB_USERNAME
# and
# GITHUB_PASSWORD
# i.e. "export GITHUB_USERNAME=someusername"

RSpec.describe FavoriteLanguage do

  before do
    @favorite_language = FavoriteLanguage::GithubLanguage.new
  end

  describe 'authenticates a user with Github' do
    before { @client = github_auth(github_username, github_password) }
    specify { expect(@client).to be_a(Octokit::Client) }
  end

  describe 'get a target user from Github' do
    before do
      client = github_auth(github_username, github_password)
      @target_user = @favorite_language.get_target_user('jessicadear', client)
    end
    specify { expect(@target_user).to be_truthy }
  end

  describe 'get the favorite language of a target user' do
    before do
      client = github_auth(github_username, github_password)
      target_user = target_user('jessicadear', client)
      @lang = @favorite_language.calculate_favorite_of(target_user, client).to_s
    end
    specify { expect(@lang).to eq('HTML') }
  end

  def github_auth(username, password)
    @favorite_language.authenticate(username, password)
  end

  def target_user(username, client)
    @favorite_language.get_target_user(username, client)
  end

  def github_username
    ENV['GITHUB_USERNAME']
  end

  def github_password
    ENV['GITHUB_PASSWORD']
  end
end
