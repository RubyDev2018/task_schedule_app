json.array!(@tasks) do |task|
  json.title "#{task.name}"
  json.start task.start
  json.end task.end
  json.url task_url(task)
end
