module LinksHelper
  def construct_hyperlink(link_url, link_alt_text)
    @www_max_length = session[:full_details] == 'true' ? 69 : 19
    @alt_text_max_length = session[:full_details] == 'true' ? 85 : 35
    link_url= link_url.gsub('http://','').gsub('https://','')
    link_url_no_www= link_url.gsub('http://','').gsub('https://','').gsub('www.','')
    new_url= '<a href="http://' + link_url +'" title="' + link_url + '">'
    @address_url= link_url_no_www.length > @www_max_length ? (new_url + link_url_no_www[0..(@www_max_length+5)] + '...' + '</a>') : (new_url + link_url_no_www + '</a>')
    @new_link_alt_text= link_alt_text.length > @alt_text_max_length  ? (link_alt_text[0..(@alt_text_max_length-1)] + '...') : link_alt_text
    return @address_url, @new_link_alt_text
  end
end