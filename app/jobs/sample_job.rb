class SampleJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Sidekiq::logger.info "サンプルジョブを実行しました"
  end
end
