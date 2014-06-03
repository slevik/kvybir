module NewHelper
  def print_news(news)
    res = ''
    news.map do |new|
      res = res + '<div class="admin_news_line">'
      res = res + "<div class='news_item'>#{new.title} #{new.cdate} <a href='/manager/deletenews/#{new.id}'>[delete]</a></div>"
      res = res + "<div class='description_item'>#{new.description}</div>"
      res = res + "</div><br />"
    end
    res.html_safe
  end

  def print_news_form
    res = form_tag("/manager/news", method: "post") do
      f = ''
      f = f + text_field_tag("cdate", nil)
      f = f + ' <br />'

      f = f + text_field_tag("title", nil, :placeholder => 'title')
      f = f + ' <br />'
      f = f + text_area_tag("description", nil, :placeholder => 'description')
      f = f + ' <br />'
      f = f + text_area_tag("body", nil, :placeholder => 'body', :class => "tinymce", :id => "tinymce")
      f = f + ' <br />'
      f = f + submit_tag(" add")
      f.html_safe
    end
    res.html_safe
  end

end
