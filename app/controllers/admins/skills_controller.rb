module Admins
  class SkillsController < ApplicationController
      def new
          @skills = Skill.all
      end

      def create
        @skills = Skill.new(skill_params)
        if @skills.save
          redirect_to new_admins_skill_path
        else
          flash[:alert] = "Skill fail to save !"
          redirect_to new_admins_skill_path
        end
      end


      private
      def skill_params
        params.require(:skill).permit(:name, :description, :score)
      end

  end
end
