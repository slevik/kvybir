module ItemHelper

  def show_item_body(item)
    return '' unless item
    res = ''
    res = res + "<div class='item_show_full'><div class='item_title_show_full'>##{item.title}</div><br /><div class='item_description_show_full'>#{item.body}</div></div>"
    res.html_safe
  end

  def show_horizontal_item_list(items)
    return '' unless items
    return '' if items.size == 0
    res = ''
    items.map do |menu|
      res = res + "<div class='item_show'><div class='item_title_show'>#<a href='/item/info/#{menu.id}'>#{menu.title}</a></div><div class='item_description_show'>#{menu.description}</div></div>"
    end
    res.html_safe
  end

  def show_items_on_the_same_menu(item)
    return '' unless item
    menu = Submenus.where(:id => item.menu).first
    return '' unless menu
    items = Items.where(:menu => menu.id).order('position ASC').limit(1000).all
    return '' unless items
    return '' if items.size == 0
    res = ''
    items.map do |menu|
      next if item.id == menu.id
      res = res + "<div class='item_show' style='width:100% !important'><div class='item_title_show' style='font-size:16px;'>#<a href='/item/info/#{menu.id}'>#{menu.title}</a></div><div style='font-size:14px;' class='item_description_show'>#{menu.description}</div></div>"
    end
    res.html_safe
  end

  def print_crumbs(id)
    return '' unless id
    submenu = Submenus.where(:id => id).first
    res = []
    if submenu
      res << "#{submenu.title}"
      submenu = Submenus.where(:id => submenu.menu).first
      if submenu
        res << "#{submenu.title}"
        submenu = Submenus.where(:id => submenu.menu).first
        if submenu
          res << "#{submenu.title}"
        end
      end
    end
    res << '<a href="\"><img src="/assets/home.png" class="home_image"/></a>'
    res.reverse.join(' > ').html_safe
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


  def show_news_vertical(news)
    res = ''
    news.map do |new|
      res = res + "<div class='item_show_news' style='width:100% !important'> <div class='item_title_show' style='font-size:11px;'>#{new.cdate}</div><div class='item_title_show' style='font-size:14px;'><a href='/item/newsinfo/#{new.id}'>#{new.title} </a></div><div style='font-size:12px;' class='item_description_show'>#{new.description}</div></div>"
    end
    res.html_safe
  end

  def show_news_vertical_full(items)
    res = ''
    items.map do |menu|
      res = res + "<div class='item_show'><div class='item_title_show'> <span style='margin:4px;font-size:12px;float:right;'>#{menu.cdate}</span> #<a href='/item/newsinfo/#{menu.id}'>#{menu.title}</a></div><div class='item_description_show'>#{menu.description}</div></div>"
    end
    res.html_safe
  end

end
