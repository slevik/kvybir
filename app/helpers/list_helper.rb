module ListHelper
  def print_menus(menus)
    res = ''
    i = 1
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all

      res = res + "<span class='menu'> #{menu.title} </span>"
      res = res + "<span class='delete_menu' style=''>#{link_to('[delete]', "/manager/deletemenu?menu=#{menu.id}")}</span>"


      form = form_tag("/manager/addsubmenu", method: "post") do
              f = ''
              f = f + hidden_field_tag("menu", nil, :value => menu.id)
              f = f + text_field_tag("title", nil, :placeholder => 'title')
              f = f + submit_tag(" add")
              f.html_safe
             end

      res = res + " <span id='m#{i}' style='cursor:pointer;color:blue;' onclick='$(\"#m#{i}\").hide(); $(\"#_m#{i}\").show();'> [add menu] </span><div id='_m#{i}' style='display:none'>#{form}</div>"

      res = res + print_submenus(submenus)
      res = res + "<br />"
      i = i + 1
    end
    res.html_safe
  end

  def print_submenus(menus)
    res = '<div class="sub_menu"> '
    i = 0
    menus.map do |menu|
      submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all

      res = res + "<span class='menu'> #{menu.title} </span>"
      res = res + "<span class='delete_menu' style=''>#{link_to('[delete]', "/manager/deletesubmenu?menu=#{menu.id}")}</span>"


      form = form_tag("/manager/addsubmenu", method: "post") do
      f = ''
      f = f + hidden_field_tag("menu", nil, :value => menu.id)
      f = f + text_field_tag("title", nil, :placeholder => 'title')
      f = f + submit_tag(" add")
      f.html_safe
    end

    res = res + " <span id='sm#{i}' style='cursor:pointer; color:blue;' onclick='$(\"#sm#{i}\").hide(); $(\"#_sm#{i}\").show();'> [add menu] </span><div id='_sm#{i}' style='display:none'>#{form}</div>"

    res = res + print_subsubmenus(submenus)

    res = res + "<br />"
    i = i + 1
  end
  res = res + " </div>"
  res.html_safe
  end


def print_subsubmenus(menus)
  res = '<div class="sub_sub_menu"> '
  i = 0
  menus.map do |menu|
    #submenus = Submenus.where(:menu => menu.id).order('position ASC').limit(1000).all

    res = res + "<span class='menu'> #{menu.title} </span>"
    res = res + "<span class='delete_menu' style=''>#{link_to('[delete]', "/manager/deletesubmenu?menu=#{menu.id}")}</span>"


    #form = form_tag("/manager/addsubmenu", method: "post") do
    #f = ''
    #f = f + hidden_field_tag("menu", nil, :value => menu.id)
    #f = f + text_field_tag("title", nil, :placeholder => 'title')
    #f = f + submit_tag(" add")
    #f.html_safe
    # end

  #res = res + " <span id='sm#{i}' style='cursor:pointer' onclick='$(\"#sm#{i}\").hide(); $(\"#_sm#{i}\").show();'> [menu] </span><div id='_sm#{i}' style='display:none'>#{form}</div>"

  #res = res + print_subsubmenus(submenus)

  res = res + "<br />"
  i = i + 1
end
res = res + " </div>"
res.html_safe
end


#  def print_bug_list(bugs)
#    res = ''
#    t_date = ''
#    t_day = 0
#    user_day = nil
#    user_day_count = 0
#    bugs.map do |bug|
#      if t_date != bug.date
#        res = res + "<div class='user_count'> #{user_day_count}/#{@users.size} </div>" if user_day_count != 0
#        unless t_date == ''
#          res = res + "<br /><br />"
#          t_day = t_day-1
#        end
#        res = res + "<div class='t_date'>#{bug.date} ##{print_day[t_day]}</div>"
#        user_day_count = 0
#        user_day = nil
#      end
#      if user_day != bug.user
#        user_day = bug.user
#        user_day_count += 1
#      end
#      user_name = Users.find_by_id(bug.user)
#      res = res + "<div class='bug_item'>"
#      res = res + "<div class='inline delete' style='position:absolute;'>#{link_to('x', "/report/delete?bug=#{bug.id}")}</div>" if @username ==  bug.user.to_s
#      res = res + "<div class='inline' style='width:100px;text-align:center;font-size:13px;margin-top:4px;'>#{bug.number != 0 ? bug.number : 'none'}&nbsp;</div>"
#      project = Projects.find_by_id(bug.project)
#      res = res + "<div class='inline' style='width:100px;text-align:left;font-weight:bold;font-family:vernada;font-size:15px;'>#{project.name if project}</div>"
#
#      res = res + "<div class='inline' style='width:100px;text-align:left;color:blue;'>#{user_name.name if user_name}</div>"
#      res = res + "<div class='inline' style='width:450px;text-align:left;font-size:13px;font-style:italic'>#{bug.description }&nbsp;</div>"
#      res = res + "<div class='inline' style='width:100px;text-align:left;font-size:13px;'>#{hash_status[bug.status]}</div>"
#      res = res + "<div class='inline est' style='width:100px;text-align:left;font-size:13px;'>#{bug.estimate}</div>"
#
#      points = ''
#      (bug.points).times {points += '|#|'}
#      res = res + "<div class='inline est' style='text-align:left;font-size:5px;position:absolute;margin-left:16px;margin-top:-1px;'> #{points} </div>"
#
#
#      res = res + "<div style='clear:both'></div>"
#      res = res + "</div>"
#
#      t_date = bug.date
#    end
#    res = res + "<div class='user_count'> #{user_day_count}/#{@users.size}</div>" if user_day_count != 0
#
#    res.html_safe
#  end
#
#
#  def pie_chart(users, bugs)
#    list = {}
#    i = 0
#    days = 5
#    t_day = ''
#    points = 0
#
#    bugs.map do |bug|
#      if t_day != bug.date
#        t_day = bug.date
#        days-=1
#        break if days < 0
#      end
#      list["#{bug.user}"] = {"closed" => {}} unless list["#{bug.user}"]
#      if bug.status == 1
#        number = bug.number == 0 ? "#{i}_" : "#{bug.number}"
#
#        #TODO: points
#        unless list["#{bug.user}"]["closed"]["#{number}"]
#          list["#{bug.user}"]["closed"]["#{number}"] = bug.points
#          points += bug.points.to_i if bug.points
#        else
#          #list["#{bug.user}"]["closed"]["#{number}"] += 1
#        end
#      end
#      i+=1
#    end
#
#    #p "=================="
#    #p list.inspect
#
#    uniq_count = 0
#    zero_users = []
#    res = ''
#    users.map do |u|
#
#      count = 0
#      c_size = 0
#      if list["#{u.id}"] && list["#{u.id}"]["closed"]
#        c_size = list["#{u.id}"]["closed"].size
#        list["#{u.id}"]["closed"].map do |c|
#          count += c[1]
#        end
#      end
#
#      uniq_count += c_size
#
#      if count > 0
#        res += ', ' if res != ''
#        res += "['#{u.name}', #{count}]"
#      else
#        zero_users += ["#{u.name}"]
#      end
#    end
##    data: <%= pie_chart(@users, @bugs) %>
##//                [
##//                    ['Firefox',   45.0],
##//                    ['IE',       26.8],
##//                    {
##//                        name: 'Chrome',
##//                        y: 12.8,
##//                        sliced: true,
##//                        selected: true
##//                    },
##//                    ['Safari',    8.5],
##//                    ['Opera',     6.2],
##//                    ['Others',   0.7]
##//                ]
##    p "==================="
##    p uniq_count
#    ["[#{res}]".html_safe, uniq_count, zero_users, points]
#  end
end
