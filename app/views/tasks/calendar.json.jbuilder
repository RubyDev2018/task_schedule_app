json.array!(@tasks) do |event|
  json.id "#{event.id}"
  json.title "#{event.name}"
  json.start event.start
  json.end event.end
  json.url task_url(event)
end
