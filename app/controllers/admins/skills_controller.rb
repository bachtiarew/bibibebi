module Admins
  class SkillsController < ApplicationController
      def new
          @skill = Skill.new
          @skills = Skill.all
      end

      def create
        @skill = Skill.new(skill_params)
        if @skill.save
          redirect_to new_admins_skill_path
        else
          flash[:alert] = "Skill fail to save !"
          redirect_to new_admins_skill_path
        end
      end

      def destroy
        @skill = Skill.find(params[:id])
        @skill.destroy
        redirect_to new_admins_skill_path
      end

      private
      def skill_params
        params.require(:skill).permit(:name, :description, :score)
      end

  end
end
