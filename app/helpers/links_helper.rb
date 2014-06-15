module LinksHelper
  def construct_hyperlink(link_url, link_alt_text, size)
    @www_max_length = size == 'long' ? 69 : 19
    @alt_text_max_length = size == 'long' ? 85 : 35
    link_url= link_url.gsub('http://','').gsub('https://','')
    link_url_no_www= link_url.gsub('http://','').gsub('https://','').gsub('www.','')
    new_url= '<a href="http://' + link_url +'" title="' + link_url + '">'
    @address_url= link_url_no_www.length > @www_max_length ? (new_url + link_url_no_www[0..(@www_max_length+5)] + '...' + '</a>') : (new_url + link_url_no_www + '</a>')
    @new_link_alt_text= link_alt_text.length > @alt_text_max_length  ? (link_alt_text[0..(@alt_text_max_length-1)] + '...') : link_alt_text
    return @address_url, @new_link_alt_text
  end

  def group_name_for_link_form_title(group_id)
    'for the '+Group.find(group_id).group_name + ' group.'
  end

  def rotate_rows_color_group
    if session[:group_shading] == 'true' || params[:show]
      cycle('row_color_group_1 color_group_1', 'row_color_group_2 color_group_2', 'row_color_group_3 color_group_3')
    else
      cycle('row_color_group_1', 'row_color_group_2', 'row_color_group_3')
    end
  end

  def long_form(date)
    date.strftime('%m/%d/%Y')
  end

  def short_form(date)
    date.to_s.gsub('00:00:00 UTC','')[0,4]
  end

end
