class PrepareSearch

  def self.start_date(start_year)
    (start_year + '/01/01').to_date
  end

  def self.end_date(end_year)
    (end_year + '/12/31').to_date
  end

  def self.groups(groups=[])
    @groups_comparison= ' and group_id in (-1'
    groups.each do |group_id|
      @groups_comparison << ','+group_id
    end
    @groups_comparison+= ')'
  end

  def self.versions(version_information={} )
    @version = version_information[:version].to_f
    @version_comparison = ' and (version_number ' + version_information[:version_comparison] + ' ' + @version.to_s
    if version_information[:include_blank_version]
      @version_comparison+= " or version_number is NULL or version_number = '' )"
    else
      @version_comparison+= " and version_number is not NULL and version_number <> '' )"
    end
  end

  def self.dates(from, to)
    @from= from
    @to= to
     " and ((content_date is NULL) or( (content_date >= '" + @from.to_s + "') and (content_date <= '" + @to.to_s + "') ) )"
  end

  def self.text_search(words_1,comparison_operator='',words_2='')
    @words_1 = words_1
    @words_2 = words_2
    @comparison_operator= comparison_operator
    if @words_2.length > 0
      @text_search = " and ( (url_address LIKE '%"+@words_1+"%' or alt_text LIKE '%"+@words_1+"%' or version_number LIKE '%"+@words_1+"%') "
      @text_search+= @comparison_operator
      @text_search+= " (url_address LIKE '%"+@words_2+"%' or alt_text LIKE '%"+@words_2+"%' or version_number LIKE '%"+@words_2+"%') )"
    else
      " and (url_address LIKE '%"+@words_1+"%' or alt_text LIKE '%"+@words_1+"%' or version_number LIKE '%"+@words_1+"%')"
    end
  end

  def self.basic_search(words)
    @words = words
    @conditions = ['(url_address LIKE ? or alt_text LIKE ? or version_number LIKE ?)', "%"+@words+"%", "%"+@words+"%", "%"+@words+"%"]
  end

end
