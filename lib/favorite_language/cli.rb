require 'thor'
require 'favorite_language'
require_relative '../favorite_language/github_language'

module FavoriteLanguage
  class CLI < Thor
    desc "get_lang_for", "usage: get_lang_for target_github_username, your github username, your github password"
    def get_lang_for(target_username, auth_username, auth_password)
      puts FavoriteLanguage::GithubLanguage.new.get_lang_for(target_username,
                                                         auth_username,
                                                         auth_password)
    end
  end
end
