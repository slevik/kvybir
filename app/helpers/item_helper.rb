module ItemHelper
  def show_horizontal_item_list(items)
    return '' unless items
    return '' if items.size == 0
    res = ''
    items.map do |menu|
      res = res + "<div class='item_show'><div class='item_title_show'>#{menu.title}</div><div class='item_description_show'>#{menu.description}</div></div>"
    end
    res.html_safe
  end

  def print_horizontal_menus(menus)
    menus = Submenus.where(menu: nil).order('position ASC').limit(1000).all
    return '' unless menus
    return '' if menus.size == 0
    res = ''
    res = res + '<ul>'
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all
      if submenus && submenus.size > 0
        res = res + print_has_sub_horizontal_menu_item(menu)
      else
        res = res + print_horizontal_menu_item(menu)
      end
      res = res + print_vertical_menu_items(submenus)
      res = res + '</li>'
    end
    res = res + '</ul>'
    res.html_safe
  end

  def print_horizontal_menu_item(menu)
    "<li><a href='#'><span>#{menu.title}</span></a>"
  end

  def print_horizontal_menu_item_link(menu)
    "<li><a href='/item/show/#{menu.id}'><span>#{menu.title}</span></a>"
  end

  def print_active_horizontal_menu_item(menu)
    "<li class='active'><a href='#'><span>#{menu.title}</span></a>"
  end

  def print_has_sub_horizontal_menu_item(menu)
    "<li class='has-sub'><a href='#'><span>#{menu.title}</span></a>"
  end

  def print_horizontal_item_link(menu)
    "<li><a href='#'><span>#{menu.title}</span></a>"
  end

  def print_vertical_menu_items(menus)
    return '' unless menus
    return '' if menus.size == 0
    res = ''
    res = res + '<ul>'
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all
      #items = Items.where(:menu => menu.id).order('position ASC').limit(1000).all
      if submenus && submenus.size > 0
        res = res + print_has_sub_horizontal_menu_item(menu)
      else
        res = res + print_horizontal_menu_item_link(menu)
      end
      res = res + print_sub_vertical_menu_items(submenus)
      res = res + '</li>'
      #res = res + print_horizontal_items(items) if !submenus || submenus.size == 0
    end
    res = res + '</ul>'
    res.html_safe
  end

  def print_sub_vertical_menu_items(menus)
    return '' unless menus
    return '' if menus.size == 0
    res = ''
    res = res + '<ul>'
    menus.map do |menu|
      #items = Items.where(:menu => menu.id).order('position ASC').limit(1000).all
      res = res + print_horizontal_menu_item_link(menu)
      #res = res + print_horizontal_items(items)
      res = res + '</li>'
    end
    res = res + '</ul>'
    res.html_safe
  end

  #def print_horizontal_items(menus)
  #  return '' unless menus
  #  return '' if menus.size == 0
  #  res = ''
  #  res = res + '<ul>'
  #  menus.map do |menu|
  #    res = res + print_horizontal_item_link(menu)
  #  end
  #  res = res + '</ul>'
  #  res.html_safe
  #end


end
