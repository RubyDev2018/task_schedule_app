json.array!(@tasks) do |task|
  json.title "#{task.name}"
  json.start task.start_time
  json.end task.end_time
  json.url task_url(task)
end
