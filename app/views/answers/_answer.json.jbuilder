json.extract! answer, :id, :ans_content, :user_id, :question_id, :created_at, :updated_at
json.url answer_url(answer, format: :json)
