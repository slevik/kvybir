class ReportController < ApplicationController
  def today
    @username = cookies[:username] if cookies[:username]
    if request.post?
      if valid_params?
        bugs = params[:bug]
        cookies[:username] = params[:name]
        bugs.each_with_index.map do |bug, index|
          if bug && !bug.empty?
            b = Bugs.new
            b.number = bug
            b.date = params[:date]
            b.user = params[:name]
            b.project = params[:project][index]
            b.description = params[:description][index]
            b.status = params[:status][index]
            b.estimate = params[:estimate][index]
            b.points = params[:points][index]
            b.save
          end
        end
        redirect_to root_path
      end
    end
  end


  def go
    get_latest_bugs
  end

  def day
    day = params[:day]
    @bugs = Bugs.find_all_by_date(day, :order => 'date DESC, project ASC, user ASC', :limit => 100)
  end

  def delete
    id = params[:bug]
    bug = Bugs.find_by_id(id)
    bug.destroy if bug
    if params[:admin]
      redirect_to report_go_path
    else
      redirect_to root_path
    end
  end

  def valid_params?
    params[:name] && !params[:name].empty? && params[:date] && !params[:date].empty?
  end
end
