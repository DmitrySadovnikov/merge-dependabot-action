require 'dotenv/load'
require 'octokit'

CONFIG = {
  access_token: ENV['GITHUB_TOKEN'],
  author: ENV['PULL_REQUEST_AUTHOR'],
  repository: ENV['GITHUB_REPOSITORY']
}

def client
  @client ||= Octokit::Client.new(access_token: CONFIG[:access_token])
end

pull_requests = client.pull_requests(CONFIG[:repository])
pull_requests = pull_requests.select { |pr| pr[:user][:login] == CONFIG[:author] }
pull_requests.each do |pr|
  body = "## 🛡️ Security\r\n"
  body << '* '
  body << pr[:body].lines.first.to_s
  body << "\r\n"
  client.update_pull_request(CONFIG[:repository], pr[:number], body: body)
  client.merge_pull_request(CONFIG[:repository], pr[:number])
end
