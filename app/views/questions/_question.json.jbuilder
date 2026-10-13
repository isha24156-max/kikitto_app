json.extract! question, :id, :deadline, :q_content, :user_id, :subject_id, :created_at, :updated_at
json.url question_url(question, format: :json)
