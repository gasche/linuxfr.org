atom_feed(:root_url => polls_url) do |feed|
  feed.title("LinuxFr.org : les sondages")
  feed.updated(@polls.first.try :created_at)
  feed.icon("/favicon.png")

  @polls.each do |poll|
    feed.entry(poll) do |entry|
      entry.title(poll.title)
      entry.content(poll_body(poll), :type => 'html')
      entry.author do |author|
        author.name(poll.node.user.name)
      end
      entry.wfw :commentRss, "http://#{MY_DOMAIN}/nodes/#{poll.node.id}/comments.atom"
    end
  end
end
