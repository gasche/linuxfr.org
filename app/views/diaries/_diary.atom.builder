url = polymorphic_url([diary.owner, diary])
feed.entry(diary, :url => url) do |entry|
  entry.title(diary.title)
  if diary.node.cc_licensed
    entry.rights("Licence CC by-sa #{cc_url diary}")
  end
  epub = content_tag(:div, link_to("Télécharger ce contenu au format Epub", "#{url}.epub"))
  entry.content(diary.body + epub + atom_comments_link(url), :type => 'html')
  entry.author do |author|
    author.name(diary.owner.name)
  end
  diary.node.popular_tags.each do |tag|
    entry.category(:term => tag.name)
  end
  entry.wfw :commentRss, "http://#{MY_DOMAIN}/nodes/#{diary.node.id}/comments.atom"
end
