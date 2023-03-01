# frozen_string_literal: true

class ApplicationController < ActionController::Base
  require "govuk_design_system_formbuilder"
  default_form_builder GOVUKDesignSystemFormBuilder::FormBuilder

  # Use with an around action to enable the active job strategy
  # which currently uses Sidekiq as the processing agent
  def use_chewy_active_job_strategy(&block)
    return yield if Rails.env.test?

    Chewy.strategy(:active_job, &block)
  end
end
