json.extract! question, :id, :question, :option1, :option2, :option3, :option4, :answer, :gname, :sname, :created_at, :updated_at
json.url question_url(question, format: :json)
