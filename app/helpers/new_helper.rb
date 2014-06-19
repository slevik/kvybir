module NewHelper
  def print_news(news)
    res = ''
    news.map do |new|
      res = res + '<div class="admin_news_line">'
      res = res + "<div class='news_item'>#{new.title} #{new.cdate} <a href='/manager/deletenews/#{new.id}'>[delete]</a></div>"

      res = res + "<span style='cursor:pointer; text-decoration:underline;color:darkgrey;' style='cursor:pointer; color:blue;' onclick='$(\"#edit_itemN_#{new.id}\").show();show_e(\"edit_item_class#{new.id}\")'> [edit] </span>"

      res = res + "<div class='description_item'>#{new.description}</div>"

      res = res + form22_edit(new)

      res = res + "</div><br />"
    end
    res.html_safe
  end

  def form22_edit(item)
    res = form_tag("/manager/updatenews", method: "post") do
      f = ''
      f = f + '<div id="modal_window_close" style="cursor:pointer;float:right;" onclick="$(\'#edit_itemN_' + "#{item.id}" + '\').hide();">[ close ]</div>'
      f = f + hidden_field_tag("id", nil, :value => item.id)
      f = f + text_field_tag("title", nil, :value => item.title, :placeholder => 'title')
      f = f + ' <br />'
      f = f + text_area_tag("description", item.description, :placeholder => 'description')
      f = f + ' <br />'
      f = f + text_area_tag("body", item.body, :placeholder => 'body', :class => "edit_item_class#{item.id}", :id => "edit_item_class#{item.id}")
      f = f + ' <br />'
      f = f + submit_tag(" update")
      f.html_safe
    end
    res = "<div id='edit_itemN_#{item.id}' style='display:none; width:800px !important; border:1px solid red;background-color:silver;'>#{res}</div>"
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
