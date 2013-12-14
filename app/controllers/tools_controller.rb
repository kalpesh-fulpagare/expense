class ToolsController < ApplicationController
  def monthly_stats
    @system_setting = SystemSetting.find_settlement params[:year]
  end

  def calculate_stats
    SystemSetting.calculate_last_settlement current_user
    redirect_to "/tools/monthly_stats", notice: "Calculated successfully!"
  end
end
