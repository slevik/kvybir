module ManagerHelper
  def print_menus(menus)
    res = ''
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all
      res = res + print_menu_item(menu)
      res = res + print_add_menu_link(menu)
      res = res + print_submenus(submenus)
      res = res + "<br />"
    end
    res.html_safe
  end

  def print_submenus(menus)
    res = '<div class="sub_menu"> '
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all
      items = Items.where(:menu => menu.id).order('position ASC').limit(1000).all if submenus.size == 0
      res = res + print_menu_item(menu)
      res = res + print_add_menu_link(menu)
      res = res + print_add_item_link(menu)
      res = res + print_items(items)
      res = res + print_subsubmenus(submenus)
      res = res + "<br />"
    end
    res = res + " </div>"
    res.html_safe
  end


  def print_subsubmenus(menus)
    res = '<div class="sub_sub_menu"> '
    menus.map do |menu|
      items = Items.where(:menu => menu.id).order('position ASC').limit(1000).all
      res = res + print_menu_item(menu)
      res = res + print_add_item_link(menu)
      res = res + print_items(items)
      res = res + "<br />"
    end
    res = res + " </div>"
    res.html_safe
  end

  def print_items(items)
    return '' unless items
    res = '<div class="item_list"> '
    items.map do |item|
      res = res + "<span style='cursor:pointer; text-decoration:underline;color:darkgrey;' onclick='$(\"#modal_window_body\").html($(\"#edit_item_#{item.id}\").html()); $(\".modal_window\").toggle();'>#{item.title}</span>"
      res = res + "<span class='delete_menu' style=''>#{link_to(' [delete]', "/manager/deleteitem?id=#{item.id}")}</span>"
      res = res + form2_edit(item)
      res = res + "<br />"
    end
    res = res + " </div>"
    res.html_safe
  end


  #----------------------------------

  def form2(menu)
    res = form_tag("/manager/additem", method: "post") do
      f = ''
      f = f + hidden_field_tag("menu", nil, :value => menu.id)
      f = f + text_field_tag("title", nil, :placeholder => 'title')
      f = f + ' <br />'
      f = f + text_area_tag("description", nil, :placeholder => 'description')
      f = f + ' <br />'
      f = f + text_area_tag("body", nil, :placeholder => 'body', :class => 'body22')
      f = f + ' <br />'
      f = f + submit_tag(" add")
      f.html_safe
    end
    res.html_safe
  end

  def form2_edit(item)
    res = form_tag("/manager/updateitem", method: "post") do
      f = ''
      f = f + hidden_field_tag("id", nil, :value => item.id)
      f = f + hidden_field_tag("menu", nil, :value => item.menu)
      f = f + text_field_tag("title", nil, :value => item.title, :placeholder => 'title')
      f = f + ' <br />'
      f = f + text_area_tag("description", item.description, :placeholder => 'description')
      f = f + ' <br />'
      f = f + text_area_tag("body", item.body, :placeholder => 'body', :class => 'body22')
      f = f + ' <br />'
      f = f + submit_tag(" update")
      f.html_safe
  end
    res = "<div id='edit_item_#{item.id}' style='display:none'>#{res}</div>"
    res.html_safe
  end

  def form1(menu)
    res = form_tag("/manager/addmenu", method: "post") do
      f = ''
      f = f + hidden_field_tag("menu", nil, :value => menu.id)
      f = f + text_field_tag("title", nil, :placeholder => 'title')
      f = f + submit_tag(" add")
      f.html_safe
    end
  res.html_safe
  end

  def print_menu_item(menu)
    res = ''
    res = res + "<span class='menu'> #{menu.title} </span>"
    res = res + "<span class='delete_menu' style=''>#{link_to('[delete]', "/manager/deletemenu?menu=#{menu.id}")}</span>"
    res
  end

  def print_add_menu_link(menu)
    res = ''
    res = res + " <span id='sm#{menu.id}' style='cursor:pointer; color:blue;' onclick='$(\"#sm#{menu.id}\").hide(); $(\"#_sm#{menu.id}\").show();'> [add menu] </span><div id='_sm#{menu.id}' style='display:none'>#{form1(menu)}</div>"
    res
  end

  def print_add_item_link(menu)
    res = ''
    res = res + " <span id='sm2#{menu.id}' style='cursor:pointer; color:blue;' onclick='$(\"#modal_window_body\").html($(\"#_sm2#{menu.id}\").html()); $(\".modal_window\").toggle();'> [add item] </span><div id='_sm2#{menu.id}' style='display:none'>#{form2(menu)}</div>"
    res
  end

end
