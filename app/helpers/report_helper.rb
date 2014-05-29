module ReportHelper
  def print_admin_bug_list(bugs)
    res = ''
    t_date = ''
    t_day = 0
    user_day = nil
    user_day_count = 0
    bugs.map do |bug|
      if t_date != bug.date
        res = res + "<div class='user_count'> #{user_day_count}/#{@users.size} </div>" if user_day_count != 0
        unless t_date == ''
          res = res + "<br /><br />"
          t_day = t_day-1
        end
        res = res + "<div class='t_date'>#{link_to("#{bug.date} (#{print_day[t_day]})", "/report/day?day=#{bug.date}")}   </div>"
        user_day_count = 0
        user_day = nil
      end
      if user_day != bug.user
        user_day = bug.user
        user_day_count += 1
      end

      res = res + "<div class='bug_item'>"
      res = res + "<div class='inline delete'>#{link_to('x', "/report/delete?bug=#{bug.id}&admin=true")}</div>"
      res = res + "<div class='inline' style='width:100px;text-align:center;font-size:13px;margin-top:2px;'>#{bug.number}&nbsp;</div>"
      project = Projects.find_by_id(bug.project)
      res = res + "<div class='inline' style='width:100px;text-align:left;font-weight:bold;'>#{project.name if project}</div>"
      user_name = Users.find_by_id(bug.user)
      res = res + "<div class='inline' style='width:100px;text-align:left;color:blue;'>#{user_name.name if user_name}</div>"
      res = res + "<div class='inline' style='width:450px;text-align:left;font-size:13px;font-style:italic'>#{bug.description }&nbsp;</div>"
      res = res + "<div class='inline' style='width:100px;text-align:left;'>#{hash_status[bug.status]}</div>"
      res = res + "<div class='inline est' style='text-align:left;'>#{bug.estimate}</div>"
      #" #{bug.number} #{bug.description}"
      res = res + "<div style='clear:both'></div>"
      res = res + "</div>"

      t_date = bug.date
    end
    res = res + "<div class='user_count'> #{user_day_count}/#{@users.size}</div>" if user_day_count != 0

    res.html_safe
  end

  def print_day_admin_bug_list(bugs)
    res = ''
    project_day = nil
    bugs.map do |bug|
      project = Projects.find_by_id(bug.project)
      if project_day != bug.project
        project_day = bug.project
        res = res + "
#{project.name if project}
"
      end

      user_name = Users.find_by_id(bug.user)
      res = res + " - (#{user_name.name if user_name}) "
      res = res + " #{bug.number}: " if bug.number && bug.number != 0

      res = res + "\"#{bug.description }\" " if bug.description && !bug.description.empty?
      res = res + "(#{hash_status[bug.status]}"
      res = res + ", estimate: #{bug.estimate}" if bug.estimate && !bug.estimate.empty?
      res = res + ")"
      res = res + "\n"

    end if bugs
    res.html_safe
  end
end
