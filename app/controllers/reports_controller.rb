class ReportsController < ApplicationController
    
    def new
        @report = Report.new
    end
    
    def create
        if logged_in?
            @report = Report.new(report_params)
            
            #@report = listings_url.reports.build(report_params)
        
            @report.name = current_user.fname + " " + current_user.lname
            @report.email = current_user.email
        
            if @report.save
                flash[:success] = "Thank you! We will look into your report and be
                in contact soon."
                redirect_to @report
            else
                render 'new'
            end
        else
            flash[:danger] = 'You must be logged in to perform that action.'
            redirect_to listings_path
        end
    end
    
    def index
        @reports = Report.all
    end
    
    def show
        @report = Report.find(params[:id])
    end
    
    def destroy
        @report = Report.find(params[:id])
        @report.destroy
        
        redirect_to reports_path
    end
    
end


private 
    def report_params
        params.require(:report).permit(:name, :email, :reason)
    end
    
    def check_cancel
        if params[:commit] == "Back"
            redirect_to root_url
        end
    end