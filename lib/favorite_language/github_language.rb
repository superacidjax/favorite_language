require 'octokit'

module FavoriteLanguage
  class GithubLanguage

    def get_lang_for(target_username, auth_username, auth_password)
      authenticate(auth_username, auth_password)
      target_user = get_target_user(target_username, @client)
      calculate_favorite_of(target_user, @client)
    end

    def authenticate(username, password)
      @client = Octokit::Client.new(login: username, password: password)
    end

    def get_target_user(target_username, client)
      client.user target_username
    end

    def calculate_favorite_of(target_user, client)
      repos = target_user.rels[:repos].get.data
      languages = {}
      repos.each do |repo|
        rel = repo.rels[:languages]
        rel.get.data.attrs
        languages.merge!(rel.get.data.attrs){
          |key, old_value, new_value| new_value + old_value }
      end
      languages.invert.max&.last
    end
  end
end
